import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { register } from '../services/api';
import toast from 'react-hot-toast';
import { Swords, User, Mail, Lock, ArrowRight, Loader2 } from 'lucide-react';

export default function Register() {
  const [form, setForm] = useState({ username: '', email: '', password: '' });
  const [loading, setLoading] = useState(false);
  const { loginUser } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      const { data } = await register(form);
      loginUser(data);
      toast.success('Account created! Welcome to DevDuel!');
      navigate('/dashboard');
    } catch (err) {
      toast.error(err.response?.data?.message || 'Registration failed');
    } finally {
      setLoading(false);
    }
  };

  const fields = [
    { key: 'username', label: 'Username', type: 'text', icon: User, placeholder: 'codewizard42' },
    { key: 'email', label: 'Email', type: 'email', icon: Mail, placeholder: 'you@example.com' },
    { key: 'password', label: 'Password', type: 'password', icon: Lock, placeholder: 'Min 6 characters' },
  ];

  return (
    <div style={{
      minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center',
      background: 'radial-gradient(ellipse at top, #1a1a3e 0%, var(--bg-primary) 60%)',
      padding: 20,
    }}>
      <div className="animate-fadeIn" style={{ width: '100%', maxWidth: 420 }}>
        <div style={{ textAlign: 'center', marginBottom: 40 }}>
          <div style={{ display: 'inline-flex', alignItems: 'center', gap: 12, marginBottom: 16 }}>
            <Swords size={40} color="var(--accent)" />
            <span style={{ fontSize: 36, fontWeight: 800 }}>
              Dev<span style={{ color: 'var(--accent)' }}>Duel</span>
            </span>
          </div>
          <p style={{ color: 'var(--text-secondary)', fontSize: 15 }}>Create your account and start coding</p>
        </div>

        <div className="card" style={{ padding: 32 }}>
          <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: 20 }}>
            {fields.map(({ key, label, type, icon: Icon, placeholder }) => (
              <div className="input-group" key={key}>
                <label>{label}</label>
                <div style={{ position: 'relative' }}>
                  <Icon size={16} style={{
                    position: 'absolute', left: 14, top: '50%', transform: 'translateY(-50%)',
                    color: 'var(--text-muted)'
                  }} />
                  <input
                    type={type} className="input-field" placeholder={placeholder}
                    style={{ paddingLeft: 40, width: '100%' }}
                    value={form[key]} onChange={e => setForm({ ...form, [key]: e.target.value })}
                    required minLength={key === 'password' ? 6 : key === 'username' ? 3 : undefined}
                  />
                </div>
              </div>
            ))}

            <button type="submit" className="btn btn-primary btn-lg" disabled={loading}
              style={{ width: '100%', marginTop: 8 }}>
              {loading ? <Loader2 size={18} style={{ animation: 'spin 1s linear infinite' }} /> : (
                <>Create Account <ArrowRight size={16} /></>
              )}
            </button>
          </form>
        </div>

        <p style={{ textAlign: 'center', marginTop: 24, color: 'var(--text-secondary)', fontSize: 14 }}>
          Already have an account?{' '}
          <Link to="/login" style={{ color: 'var(--accent)', textDecoration: 'none', fontWeight: 600 }}>
            Sign in
          </Link>
        </p>
      </div>
    </div>
  );
}
