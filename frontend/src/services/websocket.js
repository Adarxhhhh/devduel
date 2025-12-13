import { Client } from '@stomp/stompjs';
import SockJS from 'sockjs-client';

const MATCH_WS_URL = import.meta.env.VITE_MATCH_WS_URL || 'http://localhost:8083/ws';

class WebSocketService {
  constructor() {
    this.client = null;
    this.subscriptions = {};
    this.reconnectAttempts = 0;
    this.maxReconnectAttempts = 3;
  }

  connect(matchId, onEvent) {
    return new Promise((resolve, reject) => {
      this.client = new Client({
        webSocketFactory: () => new SockJS(MATCH_WS_URL),
        reconnectDelay: 2000,
        heartbeatIncoming: 4000,
        heartbeatOutgoing: 4000,
        onConnect: () => {
          this.reconnectAttempts = 0;
          const sub = this.client.subscribe(`/topic/match/${matchId}`, (message) => {
            try {
              const event = JSON.parse(message.body);
              onEvent(event);
            } catch (e) {
              console.error('Failed to parse WS message', e);
            }
          });
          this.subscriptions[matchId] = sub;
          resolve();
        },
        onStompError: (frame) => {
          console.error('STOMP error', frame);
          reject(frame);
        },
        onWebSocketClose: () => {
          this.reconnectAttempts++;
          if (this.reconnectAttempts >= this.maxReconnectAttempts) {
            console.error('Max reconnect attempts reached');
          }
        }
      });

      this.client.activate();
    });
  }

  sendTyping(matchId, playerId, code) {
    if (this.client?.connected) {
      this.client.publish({
        destination: `/app/match/${matchId}/typing`,
        body: JSON.stringify({ playerId, code })
      });
    }
  }

  disconnect() {
    Object.values(this.subscriptions).forEach(sub => sub?.unsubscribe());
    this.subscriptions = {};
    if (this.client) {
      this.client.deactivate();
      this.client = null;
    }
  }
}

export default new WebSocketService();
