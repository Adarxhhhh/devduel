import { useState, useEffect } from 'react';
import { getLeaderboard } from '../services/api';
import { useAuth } from '../context/AuthContext';
import { Trophy, Medal, TrendingUp, Loader2, Crown, Swords } from 'lucide-react';

export default function Leaderboard() {
  const [entries, setEntries] = useState([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuth();

  useEffect(() => {
    getLeaderboard(50)
      .then(({ data }) => setEntries(data))
      .catch(() => setEntries([]))
      .finally(() => setLoading(false));
  }, []);

  const getRankStyle = (rank) => {
    if (rank === 1) return { bg: 'linear-gradient(135deg, #FFD700, #FFA500)', color: '#000', icon: Crown };
    if (rank === 2) return { bg: 'linear-gradient(135deg, #C0C0C0, #A8A8A8)', color: '#000', icon: Medal };
    if (rank === 3) return { bg: 'linear-gradient(135deg, #CD7F32, #A0522D)', color: '#fff', icon: Medal };
    return { bg: 'var(--bg-tertiary)', color: 'var(--text-muted)', icon: null };
  };

  return (
    <div style={{ padding: '32px 24px', maxWidth: 900, margin: '0 auto' }}>
      <div style={{ textAlign: 'center', marginBottom: 40 }}>
        <Trophy size={40} color="var(--yellow)" style={{ marginBottom: 12 }} />
        <h1 style={{ fontSize: 36, fontWeight: 800, marginBottom: 8 }}>Leaderboard</h1>
        <p style={{ color: 'var(--text-secondary)' }}>Top players ranked by ELO rating</p>
      </div>

      {loading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 60 }}>
          <Loader2 size={32} color="var(--accent)" style={{ animation: 'spin 1s linear infinite' }} />
        </div>
      ) : entries.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: 60 }}>
          <Swords size={48} color="var(--text-muted)" style={{ marginBottom: 16 }} />
          <h3 style={{ color: 'var(--text-secondary)', marginBottom: 8 }}>No rankings yet</h3>
          <p style={{ color: 'var(--text-muted)', fontSize: 14 }}>
            Complete some duels to appear on the leaderboard!
          </p>
        </div>
      ) : (
        <>
          {/* Top 3 Podium */}
          {entries.length >= 3 && (
            <div style={{
              display: 'flex', justifyContent: 'center', alignItems: 'flex-end',
              gap: 16, marginBottom: 40, padding: '0 40px',
            }}>
              {[entries[1], entries[0], entries[2]].map((entry, idx) => {
                const rank = idx === 0 ? 2 : idx === 1 ? 1 : 3;
                const height = idx === 1 ? 160 : idx === 0 ? 130 : 110;
                const rs = getRankStyle(rank);
                return (
                  <div key={rank} className="animate-slideUp" style={{
                    textAlign: 'center', flex: 1, maxWidth: 200,
                    animationDelay: `${idx * 0.1}s`,
                  }}>
                    <div style={{
                      width: 56, height: 56, borderRadius: '50%', margin: '0 auto 12px',
                      background: rs.bg,
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                      fontSize: 20, fontWeight: 800, color: rs.color,
                      boxShadow: rank === 1 ? '0 0 30px rgba(255,215,0,0.3)' : 'none',
                    }}>
                      {entry?.username?.[0]?.toUpperCase() || '?'}
                    </div>
                    <div style={{ fontWeight: 700, fontSize: 15, marginBottom: 4 }}>
                      {entry?.username || 'Unknown'}
                    </div>
                    <div style={{ color: 'var(--accent)', fontWeight: 600, fontSize: 18, marginBottom: 8 }}>
                      {entry?.elo || 1000}
                    </div>
                    <div style={{
                      height, background: `${rs.bg}`,
                      borderRadius: '12px 12px 0 0', opacity: 0.2,
                      display: 'flex', alignItems: 'center', justifyContent: 'center',
                    }}>
                      <span style={{
                        fontSize: 36, fontWeight: 900, opacity: 1,
                        color: rank === 1 ? 'var(--yellow)' : 'var(--text-muted)',
                      }}>#{rank}</span>
                    </div>
                  </div>
                );
              })}
            </div>
          )}

          {/* Full Table */}
          <div className="card" style={{ padding: 0, overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ borderBottom: '1px solid var(--border)' }}>
                  {['Rank', 'Player', 'ELO', 'W/L', 'Win Rate'].map((h, i) => (
                    <th key={i} style={{
                      padding: '14px 16px', textAlign: i > 1 ? 'center' : 'left',
                      fontSize: 11, fontWeight: 700, color: 'var(--text-muted)',
                      textTransform: 'uppercase', letterSpacing: '0.5px',
                    }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {entries.map((entry) => {
                  const isMe = user?.id === entry.userId;
                  const total = entry.wins + entry.losses;
                  const winRate = total > 0 ? Math.round((entry.wins / total) * 100) : 0;
                  return (
                    <tr key={entry.rank} style={{
                      borderBottom: '1px solid var(--border)',
                      background: isMe ? 'var(--accent-glow)' : 'transparent',
                    }}>
                      <td style={{ padding: '14px 16px', width: 60 }}>
                        <span style={{
                          display: 'inline-flex', alignItems: 'center', justifyContent: 'center',
                          width: 30, height: 30, borderRadius: '50%',
                          background: entry.rank <= 3 ? getRankStyle(entry.rank).bg : 'var(--bg-tertiary)',
                          color: entry.rank <= 3 ? getRankStyle(entry.rank).color : 'var(--text-muted)',
                          fontSize: 13, fontWeight: 700,
                        }}>
                          {entry.rank}
                        </span>
                      </td>
                      <td style={{ padding: '14px 16px' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                          <div style={{
                            width: 32, height: 32, borderRadius: '50%',
                            background: 'var(--gradient-primary)',
                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                            fontSize: 13, fontWeight: 700,
                          }}>
                            {entry.username?.[0]?.toUpperCase()}
                          </div>
                          <span style={{ fontWeight: 600, fontSize: 14 }}>
                            {entry.username}
                            {isMe && <span style={{ color: 'var(--accent)', marginLeft: 6, fontSize: 11 }}>(you)</span>}
                          </span>
                        </div>
                      </td>
                      <td style={{ padding: '14px 16px', textAlign: 'center' }}>
                        <span style={{
                          fontWeight: 700, fontSize: 16, color: 'var(--accent)',
                          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 4,
                        }}>
                          <TrendingUp size={14} /> {entry.elo}
                        </span>
                      </td>
                      <td style={{ padding: '14px 16px', textAlign: 'center', fontSize: 13 }}>
                        <span style={{ color: 'var(--green)' }}>{entry.wins}W</span>
                        {' / '}
                        <span style={{ color: 'var(--red)' }}>{entry.losses}L</span>
                      </td>
                      <td style={{ padding: '14px 16px', textAlign: 'center' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 8, justifyContent: 'center' }}>
                          <div style={{
                            width: 60, height: 6, background: 'var(--bg-tertiary)',
                            borderRadius: 3, overflow: 'hidden',
                          }}>
                            <div style={{
                              width: `${winRate}%`, height: '100%',
                              background: winRate >= 60 ? 'var(--green)' : winRate >= 40 ? 'var(--yellow)' : 'var(--red)',
                              borderRadius: 3,
                            }} />
                          </div>
                          <span style={{ fontSize: 12, color: 'var(--text-muted)', fontWeight: 600 }}>
                            {winRate}%
                          </span>
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </>
      )}
    </div>
  );
}
