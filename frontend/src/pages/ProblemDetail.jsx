import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { getProblem, submitCode } from '../services/api';
import Editor from '@monaco-editor/react';
import toast from 'react-hot-toast';
import {
  ArrowLeft, Play, CheckCircle2, XCircle, ChevronDown, Loader2, RotateCcw
} from 'lucide-react';

const LANGUAGES = [
  { id: 'java', label: 'Java', monacoId: 'java' },
  { id: 'python', label: 'Python', monacoId: 'python' },
  { id: 'javascript', label: 'JavaScript', monacoId: 'javascript' },
];

export default function ProblemDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [problem, setProblem] = useState(null);
  const [language, setLanguage] = useState('python');
  const [code, setCode] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [results, setResults] = useState(null);

  useEffect(() => {
    getProblem(id).then(({ data }) => {
      setProblem(data);
      setCode(data.starterCodePython || '');
    }).catch(() => {
      toast.error('Problem not found');
      navigate('/problems');
    });
  }, [id]);

  useEffect(() => {
    if (problem) {
      const keyMap = { java: 'starterCodeJava', python: 'starterCodePython', javascript: 'starterCodeJavascript' };
      setCode(problem[keyMap[language]] || '');
      setResults(null);
    }
  }, [language, problem]);

  const handleSubmit = async () => {
    setSubmitting(true);
    try {
      const { data } = await submitCode(id, { language, code });
      setResults(data);
      if (data.allPassed) toast.success('All tests passed!');
      else toast.error(`${data.passedTests}/${data.totalTests} tests passed`);
    } catch {
      toast.error('Submission failed');
    } finally {
      setSubmitting(false);
    }
  };

  if (!problem) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 80 }}>
        <Loader2 size={32} color="var(--accent)" style={{ animation: 'spin 1s linear infinite' }} />
      </div>
    );
  }

  return (
    <div style={{ height: 'calc(100vh - 64px)', display: 'flex' }}>
      {/* Problem Description */}
      <div style={{
        width: '40%', overflow: 'auto', padding: 24,
        borderRight: '1px solid var(--border)',
      }}>
        <button className="btn btn-sm btn-secondary" onClick={() => navigate('/problems')}
          style={{ marginBottom: 20 }}>
          <ArrowLeft size={14} /> Back
        </button>

        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 16 }}>
          <h1 style={{ fontSize: 24, fontWeight: 800 }}>{problem.title}</h1>
          <span className={`badge badge-${problem.difficulty?.toLowerCase()}`}>{problem.difficulty}</span>
        </div>

        {problem.category && (
          <span style={{
            display: 'inline-block', fontSize: 12, color: 'var(--text-muted)',
            padding: '4px 10px', background: 'var(--bg-secondary)',
            borderRadius: 4, marginBottom: 20,
          }}>{problem.category}</span>
        )}

        <div style={{
          fontSize: 14, lineHeight: 1.8, color: 'var(--text-secondary)',
          whiteSpace: 'pre-wrap',
        }}>
          {problem.description}
        </div>

        {problem.testCases?.length > 0 && (
          <div style={{ marginTop: 24 }}>
            <h3 style={{ fontSize: 14, fontWeight: 700, marginBottom: 12, color: 'var(--text-muted)' }}>
              TEST CASES
            </h3>
            {problem.testCases.filter(tc => !tc.hidden).map((tc, i) => (
              <div key={i} style={{
                marginBottom: 12, padding: 14, background: 'var(--bg-secondary)',
                borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
              }}>
                <div style={{ marginBottom: 8 }}>
                  <span style={{ fontSize: 11, color: 'var(--text-muted)', fontWeight: 600 }}>INPUT</span>
                  <pre style={{
                    fontFamily: "'JetBrains Mono', monospace", fontSize: 13,
                    marginTop: 4, padding: 8, background: 'var(--bg-primary)', borderRadius: 4,
                  }}>{tc.input}</pre>
                </div>
                <div>
                  <span style={{ fontSize: 11, color: 'var(--text-muted)', fontWeight: 600 }}>EXPECTED</span>
                  <pre style={{
                    fontFamily: "'JetBrains Mono', monospace", fontSize: 13,
                    color: 'var(--green)', marginTop: 4, padding: 8,
                    background: 'var(--bg-primary)', borderRadius: 4,
                  }}>{tc.expectedOutput}</pre>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Editor + Results */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column' }}>
        <div style={{
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          padding: '8px 16px', background: 'var(--bg-secondary)',
          borderBottom: '1px solid var(--border)',
        }}>
          <div style={{ display: 'flex', gap: 6 }}>
            {LANGUAGES.map(l => (
              <button key={l.id} onClick={() => setLanguage(l.id)} style={{
                padding: '6px 14px', borderRadius: 'var(--radius-sm)',
                border: `1px solid ${language === l.id ? 'var(--accent)' : 'var(--border)'}`,
                background: language === l.id ? 'var(--accent-glow)' : 'transparent',
                color: language === l.id ? 'var(--accent)' : 'var(--text-muted)',
                cursor: 'pointer', fontSize: 12, fontWeight: 600,
              }}>
                {l.label}
              </button>
            ))}
          </div>
          <div style={{ display: 'flex', gap: 8 }}>
            <button className="btn btn-sm btn-secondary" onClick={() => {
              const keyMap = { java: 'starterCodeJava', python: 'starterCodePython', javascript: 'starterCodeJavascript' };
              setCode(problem[keyMap[language]] || '');
              setResults(null);
            }}>
              <RotateCcw size={12} /> Reset
            </button>
            <button className="btn btn-sm btn-success" onClick={handleSubmit} disabled={submitting}>
              {submitting ? <Loader2 size={12} style={{ animation: 'spin 1s linear infinite' }} /> : <Play size={12} />}
              Run & Submit
            </button>
          </div>
        </div>

        <div style={{ flex: 1 }}>
          <Editor
            height="100%"
            language={LANGUAGES.find(l => l.id === language)?.monacoId}
            value={code}
            onChange={val => setCode(val || '')}
            theme="vs-dark"
            options={{
              fontSize: 14, fontFamily: "'JetBrains Mono', monospace",
              minimap: { enabled: false }, scrollBeyondLastLine: false,
              padding: { top: 12 }, automaticLayout: true, tabSize: 4,
            }}
          />
        </div>

        {results && (
          <div style={{
            borderTop: '1px solid var(--border)', padding: 16,
            background: 'var(--bg-secondary)', maxHeight: 200, overflow: 'auto',
          }}>
            <div style={{
              display: 'flex', alignItems: 'center', gap: 12, marginBottom: 12,
            }}>
              <span style={{
                fontSize: 16, fontWeight: 700,
                color: results.allPassed ? 'var(--green)' : 'var(--red)',
              }}>
                {results.allPassed ? 'Accepted' : 'Wrong Answer'}
              </span>
              <span style={{ fontSize: 13, color: 'var(--text-muted)' }}>
                {results.passedTests}/{results.totalTests} passed
              </span>
            </div>
            <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
              {results.results?.map((r, i) => (
                <div key={i} style={{
                  display: 'flex', alignItems: 'center', gap: 6,
                  padding: '6px 12px', borderRadius: 'var(--radius-sm)',
                  background: r.passed ? 'var(--green-glow)' : 'var(--red-glow)',
                  border: `1px solid ${r.passed ? 'rgba(0,214,143,0.3)' : 'rgba(255,71,87,0.3)'}`,
                  fontSize: 12, fontWeight: 600,
                }}>
                  {r.passed ? <CheckCircle2 size={14} color="var(--green)" /> : <XCircle size={14} color="var(--red)" />}
                  Test {i + 1}
                </div>
              ))}
            </div>
            {results.results?.some(r => !r.passed && !r.hidden && r.actualOutput) && (
              <div style={{ marginTop: 12 }}>
                {results.results.filter(r => !r.passed && !r.hidden).slice(0, 1).map((r, i) => (
                  <div key={i} style={{
                    padding: 12, background: 'var(--bg-primary)',
                    borderRadius: 'var(--radius-sm)', fontSize: 12,
                    fontFamily: "'JetBrains Mono', monospace",
                  }}>
                    <div><span style={{ color: 'var(--text-muted)' }}>Input:</span> {r.input}</div>
                    <div><span style={{ color: 'var(--green)' }}>Expected:</span> {r.expectedOutput}</div>
                    <div><span style={{ color: 'var(--red)' }}>Got:</span> {r.actualOutput || '(empty)'}</div>
                    {r.error && <div style={{ color: 'var(--red)', marginTop: 4 }}>{r.error}</div>}
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
