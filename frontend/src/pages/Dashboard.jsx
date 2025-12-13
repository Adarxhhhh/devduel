import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { createSoloMatch, getMyRank, getLeaderboard } from '../services/api';
import toast from 'react-hot-toast';
import { Swords, Zap, Trophy, Target, TrendingUp, Flame, Code2, Loader2, ChevronRight, Sparkles } from 'lucide-react';

export default function Dashboard() {
  const { user } = useAuth();
  const navigate = useNavigate();
  const [difficulty, setDifficulty] = useState('MEDIUM');
  const [creating, setCreating] = useState(false);
  const [stats, setStats] = useState(null);
  const [topPlayers, setTopPlayers] = useState([]);

  useEffect(() => {
    if (user?.id) {
      getMyRank(user.id).then(r => setStats(r.data)).catch(() => {});
      getLeaderboard(5).then(r => setTopPlayers(r.data)).catch(() => {});
    }
  }, [user]);

  const startDuel = async () => {
    setCreating(true);
    try {
      const { data } = await createSoloMatch({ difficulty }, user.id);
      toast.success('Match created! Get ready to duel!');
      navigate(`/duel/${data.matchId}`);
    } catch (err) {
      toast.error('Failed to create match. Is the match service running?');
    } finally {
      setCreating(false);
    }
  };

  const difficulties = [
    { value: 'EASY', label: 'Easy', color: 'var(--green)', icon: Target, desc: 'Warm up' },
    { value: 'MEDIUM', label: 'Medium', color: 'var(--yellow)', icon: Flame, desc: 'Balanced' },
    { value: 'HARD', label: 'Hard', color: 'var(--red)', icon: Zap, desc: 'Expert' },
  ];

  return (
    <div style={{ padding: '40px 24px', maxWidth: 1200, margin: '0 auto' }}>
      {/* Hero Section */}
      <div className="animate-fadeIn" style={{ textAlign: 'center', marginBottom: 48 }}>
        <h1 style={{ fontSize: 42, fontWeight: 800, marginBottom: 12, letterSpacing: '-1px' }}>
          Ready to <span style={{ background: 'var(--gradient-primary)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>Duel</span>?
        </h1>
        <p style={{ color: 'var(--text-secondary)', fontSize: 17, maxWidth: 500, margin: '0 auto' }}>
          Solve coding challenges, beat the clock, and get AI-powered feedback on your code.
        </p>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 32, marginBottom: 40 }}>
        {/* Start Duel Card */}
        <div className="card animate-slideUp" style={{
          padding: 32, position: 'relative', overflow: 'hidden',
          background: 'linear-gradient(135deg, var(--bg-card) 0%, #1a1a3e 100%)',
        }}>
          <div style={{
            position: 'absolute', top: -60, right: -60, width: 200, height: 200,
            background: 'radial-gradient(circle, var(--accent-glow) 0%, transparent 70%)',
            borderRadius: '50%',
          }} />

          <div style={{ position: 'relative', zIndex: 1 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 24 }}>
              <div style={{
                width: 48, height: 48, borderRadius: 12,
                background: 'var(--gradient-primary)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <Code2 size={24} />
              </div>
              <div>
                <h2 style={{ fontSize: 20, fontWeight: 700 }}>Solo Challenge</h2>
                <p style={{ color: 'var(--text-secondary)', fontSize: 13 }}>Solve & get AI feedback</p>
              </div>
            </div>

            <p style={{ color: 'var(--text-secondary)', fontSize: 14, marginBottom: 24 }}>
              Pick a difficulty, solve the problem as fast as you can, then get AI-powered
              code review with quality scores and improvement suggestions.
            </p>

            <div style={{ display: 'flex', gap: 10, marginBottom: 28 }}>
              {difficulties.map(d => (
                <button key={d.value} onClick={() => setDifficulty(d.value)} style={{
                  flex: 1, padding: '14px 12px', borderRadius: 'var(--radius-sm)',
                  border: `2px solid ${difficulty === d.value ? d.color : 'var(--border)'}`,
                  background: difficulty === d.value ? `${d.color}15` : 'var(--bg-secondary)',
                  cursor: 'pointer', transition: 'all 0.2s', textAlign: 'center',
                }}>
                  <d.icon size={18} color={d.color} style={{ marginBottom: 4 }} />
                  <div style={{ color: d.color, fontWeight: 700, fontSize: 13 }}>{d.label}</div>
                  <div style={{ color: 'var(--text-muted)', fontSize: 11 }}>{d.desc}</div>
                </button>
              ))}
            </div>

            <button className="btn btn-primary btn-lg" onClick={startDuel} disabled={creating}
              style={{ width: '100%' }}>
              {creating ? (
                <Loader2 size={20} style={{ animation: 'spin 1s linear infinite' }} />
              ) : (
                <><Swords size={20} /> Start Duel</>
              )}
            </button>
          </div>
        </div>

        {/* Stats Card */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
          <div className="card animate-slideUp" style={{ flex: 1 }}>
            <h3 style={{ fontSize: 16, fontWeight: 600, marginBottom: 20, color: 'var(--text-secondary)' }}>
              Your Stats
            </h3>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16 }}>
              {[
                { label: 'ELO Rating', value: user?.elo || 1000, icon: TrendingUp, color: 'var(--accent)' },
                { label: 'Rank', value: stats?.rank > 0 ? `#${stats.rank}` : 'Unranked', icon: Trophy, color: 'var(--yellow)' },
                { label: 'Wins', value: stats?.wins || 0, icon: Zap, color: 'var(--green)' },
                { label: 'Losses', value: stats?.losses || 0, icon: Target, color: 'var(--red)' },
              ].map((s, i) => (
                <div key={i} style={{
                  padding: 16, background: 'var(--bg-secondary)', borderRadius: 'var(--radius-sm)',
                  border: '1px solid var(--border)',
                }}>
                  <s.icon size={16} color={s.color} />
                  <div style={{ fontSize: 24, fontWeight: 700, marginTop: 8 }}>{s.value}</div>
                  <div style={{ fontSize: 12, color: 'var(--text-muted)' }}>{s.label}</div>
                </div>
              ))}
            </div>
          </div>

          {/* Mini Leaderboard */}
          <div className="card animate-slideUp">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
              <h3 style={{ fontSize: 16, fontWeight: 600, color: 'var(--text-secondary)' }}>Top Players</h3>
              <button className="btn btn-sm btn-secondary" onClick={() => navigate('/leaderboard')}>
                View All <ChevronRight size={14} />
              </button>
            </div>
            {topPlayers.length > 0 ? topPlayers.map((p, i) => (
              <div key={i} style={{
                display: 'flex', alignItems: 'center', gap: 12,
                padding: '10px 0', borderBottom: i < topPlayers.length - 1 ? '1px solid var(--border)' : 'none',
              }}>
                <span style={{
                  width: 28, height: 28, borderRadius: '50%',
                  background: i === 0 ? 'var(--yellow)' : i === 1 ? '#c0c0c0' : i === 2 ? '#cd7f32' : 'var(--bg-tertiary)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: 12, fontWeight: 700, color: i < 3 ? '#000' : 'var(--text-muted)',
                }}>{i + 1}</span>
                <span style={{ flex: 1, fontSize: 14, fontWeight: 500 }}>{p.username}</span>
                <span style={{ fontSize: 14, fontWeight: 600, color: 'var(--accent)' }}>{p.elo}</span>
              </div>
            )) : (
              <p style={{ color: 'var(--text-muted)', fontSize: 13, textAlign: 'center', padding: 20 }}>
                No rankings yet. Be the first!
              </p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
