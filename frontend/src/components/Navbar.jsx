import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { Swords, Trophy, BookOpen, LayoutDashboard, LogOut } from 'lucide-react';

export default function Navbar() {
  const { user, logout } = useAuth();
  const location = useLocation();

  const links = [
    { to: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { to: '/problems', label: 'Problems', icon: BookOpen },
    { to: '/leaderboard', label: 'Leaderboard', icon: Trophy },
  ];

  return (
    <nav style={{
      position: 'sticky', top: 0, zIndex: 100,
      background: 'rgba(10, 10, 15, 0.85)',
      backdropFilter: 'blur(20px)',
      borderBottom: '1px solid var(--border)',
      padding: '0 24px',
    }}>
      <div style={{
        maxWidth: 1400, margin: '0 auto',
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        height: 64,
      }}>
        <Link to="/dashboard" style={{
          display: 'flex', alignItems: 'center', gap: 10,
          textDecoration: 'none', color: 'var(--text-primary)',
        }}>
          <Swords size={28} color="var(--accent)" />
          <span style={{ fontSize: 22, fontWeight: 800, letterSpacing: '-0.5px' }}>
            Dev<span style={{ color: 'var(--accent)' }}>Duel</span>
          </span>
        </Link>

        <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
          {links.map(({ to, label, icon: Icon }) => (
            <Link key={to} to={to} style={{
              display: 'flex', alignItems: 'center', gap: 6,
              padding: '8px 16px', borderRadius: 'var(--radius-sm)',
              textDecoration: 'none', fontSize: 14, fontWeight: 500,
              color: location.pathname === to ? 'var(--accent)' : 'var(--text-secondary)',
              background: location.pathname === to ? 'var(--accent-glow)' : 'transparent',
              transition: 'all 0.2s',
            }}>
              <Icon size={16} />
              {label}
            </Link>
          ))}
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
          {user && (
            <>
              <div style={{
                display: 'flex', alignItems: 'center', gap: 10,
                padding: '6px 14px', background: 'var(--bg-tertiary)',
                borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
              }}>
                <div style={{
                  width: 32, height: 32, borderRadius: '50%',
                  background: 'var(--gradient-primary)',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  fontSize: 14, fontWeight: 700,
                }}>
                  {user.username?.[0]?.toUpperCase()}
                </div>
                <div>
                  <div style={{ fontSize: 13, fontWeight: 600 }}>{user.username}</div>
                  <div style={{ fontSize: 11, color: 'var(--accent)' }}>ELO {user.elo}</div>
                </div>
              </div>
              <button onClick={logout} style={{
                display: 'flex', alignItems: 'center', gap: 6,
                padding: '8px 12px', background: 'transparent', border: 'none',
                color: 'var(--text-muted)', cursor: 'pointer', borderRadius: 'var(--radius-sm)',
                transition: 'all 0.2s',
              }}
              onMouseEnter={e => e.target.style.color = 'var(--red)'}
              onMouseLeave={e => e.target.style.color = 'var(--text-muted)'}
              >
                <LogOut size={16} />
              </button>
            </>
          )}
        </div>
      </div>
    </nav>
  );
}
