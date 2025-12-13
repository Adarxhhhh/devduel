import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { getProblems } from '../services/api';
import { Search, Filter, ChevronRight, BookOpen, Loader2 } from 'lucide-react';

const CATEGORIES = ['All', 'Array', 'Binary', 'Dynamic Programming', 'Graph', 'Interval', 'Linked List', 'Matrix', 'String', 'Tree', 'Heap'];
const DIFFICULTIES = ['All', 'EASY', 'MEDIUM', 'HARD'];

export default function Problems() {
  const [problems, setProblems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [difficulty, setDifficulty] = useState('All');
  const [category, setCategory] = useState('All');
  const navigate = useNavigate();

  useEffect(() => {
    const load = async () => {
      try {
        const params = {};
        if (difficulty !== 'All') params.difficulty = difficulty;
        if (category !== 'All') params.category = category;
        const { data } = await getProblems(params);
        setProblems(data);
      } catch {
        setProblems([]);
      } finally {
        setLoading(false);
      }
    };
    load();
  }, [difficulty, category]);

  const filtered = problems.filter(p =>
    p.title?.toLowerCase().includes(search.toLowerCase()) ||
    p.slug?.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div style={{ padding: '32px 24px', maxWidth: 1200, margin: '0 auto' }}>
      <div style={{ marginBottom: 32 }}>
        <h1 style={{ fontSize: 32, fontWeight: 800, marginBottom: 8 }}>
          <BookOpen size={28} style={{ verticalAlign: 'middle', marginRight: 10, color: 'var(--accent)' }} />
          Problem Bank
        </h1>
        <p style={{ color: 'var(--text-secondary)' }}>
          All 75 Blind 75 problems. Practice or use them in duels.
        </p>
      </div>

      {/* Filters */}
      <div style={{
        display: 'flex', gap: 12, marginBottom: 24, flexWrap: 'wrap', alignItems: 'center',
      }}>
        <div style={{ position: 'relative', flex: 1, minWidth: 200 }}>
          <Search size={16} style={{
            position: 'absolute', left: 14, top: '50%', transform: 'translateY(-50%)',
            color: 'var(--text-muted)',
          }} />
          <input
            className="input-field" placeholder="Search problems..."
            style={{ paddingLeft: 40, width: '100%' }}
            value={search} onChange={e => setSearch(e.target.value)}
          />
        </div>

        <div style={{ display: 'flex', gap: 6 }}>
          {DIFFICULTIES.map(d => (
            <button key={d} onClick={() => setDifficulty(d)} style={{
              padding: '8px 14px', borderRadius: 'var(--radius-sm)',
              border: `1px solid ${difficulty === d ? 'var(--accent)' : 'var(--border)'}`,
              background: difficulty === d ? 'var(--accent-glow)' : 'var(--bg-secondary)',
              color: difficulty === d ? 'var(--accent)' : 'var(--text-secondary)',
              cursor: 'pointer', fontSize: 12, fontWeight: 600,
              transition: 'all 0.2s',
            }}>
              {d === 'All' ? 'All' : d.charAt(0) + d.slice(1).toLowerCase()}
            </button>
          ))}
        </div>
      </div>

      {/* Category pills */}
      <div style={{ display: 'flex', gap: 8, marginBottom: 24, flexWrap: 'wrap' }}>
        {CATEGORIES.map(c => (
          <button key={c} onClick={() => setCategory(c)} style={{
            padding: '6px 14px', borderRadius: 20,
            border: `1px solid ${category === c ? 'var(--accent)' : 'var(--border)'}`,
            background: category === c ? 'var(--accent-glow)' : 'transparent',
            color: category === c ? 'var(--accent)' : 'var(--text-muted)',
            cursor: 'pointer', fontSize: 12, fontWeight: 500,
            transition: 'all 0.2s',
          }}>
            {c}
          </button>
        ))}
      </div>

      {/* Problems Table */}
      {loading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 60 }}>
          <Loader2 size={32} color="var(--accent)" style={{ animation: 'spin 1s linear infinite' }} />
        </div>
      ) : (
        <div className="card" style={{ padding: 0, overflow: 'hidden' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr style={{ borderBottom: '1px solid var(--border)' }}>
                {['#', 'Title', 'Category', 'Difficulty', ''].map((h, i) => (
                  <th key={i} style={{
                    padding: '14px 16px', textAlign: 'left',
                    fontSize: 11, fontWeight: 700, color: 'var(--text-muted)',
                    textTransform: 'uppercase', letterSpacing: '0.5px',
                  }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {filtered.map((p, i) => (
                <tr key={p.id} onClick={() => navigate(`/problems/${p.id}`)}
                  style={{
                    borderBottom: '1px solid var(--border)',
                    cursor: 'pointer', transition: 'background 0.15s',
                  }}
                  onMouseEnter={e => e.currentTarget.style.background = 'var(--bg-hover)'}
                  onMouseLeave={e => e.currentTarget.style.background = 'transparent'}
                >
                  <td style={{ padding: '14px 16px', fontSize: 13, color: 'var(--text-muted)', width: 50 }}>
                    {i + 1}
                  </td>
                  <td style={{ padding: '14px 16px' }}>
                    <span style={{ fontSize: 14, fontWeight: 600 }}>{p.title}</span>
                  </td>
                  <td style={{ padding: '14px 16px' }}>
                    <span style={{
                      fontSize: 12, color: 'var(--text-muted)',
                      padding: '3px 8px', background: 'var(--bg-secondary)',
                      borderRadius: 4,
                    }}>{p.category || 'General'}</span>
                  </td>
                  <td style={{ padding: '14px 16px' }}>
                    <span className={`badge badge-${p.difficulty?.toLowerCase()}`}>
                      {p.difficulty}
                    </span>
                  </td>
                  <td style={{ padding: '14px 16px', textAlign: 'right' }}>
                    <ChevronRight size={16} color="var(--text-muted)" />
                  </td>
                </tr>
              ))}
              {filtered.length === 0 && (
                <tr>
                  <td colSpan={5} style={{
                    padding: 40, textAlign: 'center', color: 'var(--text-muted)',
                  }}>No problems found</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      )}

      <div style={{
        marginTop: 16, textAlign: 'center', color: 'var(--text-muted)', fontSize: 13,
      }}>
        Showing {filtered.length} of {problems.length} problems
      </div>
    </div>
  );
}
