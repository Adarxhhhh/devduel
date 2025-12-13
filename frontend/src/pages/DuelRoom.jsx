import { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { getMatch, getProblem, submitCode, submitMatchCode, getCodeReview } from '../services/api';
import wsService from '../services/websocket';
import Editor from '@monaco-editor/react';
import toast from 'react-hot-toast';
import {
  Play, Clock, CheckCircle2, XCircle, Trophy, Swords,
  ChevronDown, Loader2, ArrowLeft, RotateCcw, Send,
  Sparkles, Star, TrendingUp, Lightbulb, Code2, X,
  Terminal, AlertTriangle
} from 'lucide-react';

const LANGUAGES = [
  { id: 'java', label: 'Java', monacoId: 'java' },
  { id: 'python', label: 'Python', monacoId: 'python' },
  { id: 'javascript', label: 'JavaScript', monacoId: 'javascript' },
];

export default function DuelRoom() {
  const { matchId } = useParams();
  const { user } = useAuth();
  const navigate = useNavigate();

  const [match, setMatch] = useState(null);
  const [problem, setProblem] = useState(null);
  const [language, setLanguage] = useState('python');
  const [code, setCode] = useState('');
  const [running, setRunning] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [runResults, setRunResults] = useState(null);
  const [allPassed, setAllPassed] = useState(false);
  const [matchFinished, setMatchFinished] = useState(false);
  const [winner, setWinner] = useState(null);
  const [timer, setTimer] = useState(0);
  const [showLangDropdown, setShowLangDropdown] = useState(false);

  // AI Review state
  const [reviewing, setReviewing] = useState(false);
  const [review, setReview] = useState(null);
  const [showReviewPanel, setShowReviewPanel] = useState(false);

  // Track which tab is active in the bottom panel
  const [activeTab, setActiveTab] = useState('testcases'); // 'testcases' | 'results'

  const timerRef = useRef(null);

  // Load match and problem
  useEffect(() => {
    const loadMatch = async () => {
      try {
        const { data: matchData } = await getMatch(matchId);
        setMatch(matchData);

        if (matchData.status === 'FINISHED') {
          setMatchFinished(true);
          setWinner(matchData.winnerId);
        }

        const { data: problemData } = await getProblem(matchData.problemId);
        setProblem(problemData);

        const starterKey = `starterCode${language.charAt(0).toUpperCase() + language.slice(1)}`;
        if (problemData[starterKey]) {
          setCode(problemData[starterKey]);
        }
      } catch (err) {
        toast.error('Failed to load match');
        navigate('/dashboard');
      }
    };
    loadMatch();
  }, [matchId]);

  // Set starter code when language changes
  useEffect(() => {
    if (problem) {
      const keyMap = { java: 'starterCodeJava', python: 'starterCodePython', javascript: 'starterCodeJavascript' };
      const starter = problem[keyMap[language]];
      if (starter) setCode(starter);
    }
  }, [language, problem]);

  // Timer
  useEffect(() => {
    if (match?.status === 'ACTIVE' && !matchFinished) {
      const startTime = new Date(match.startedAt).getTime();
      timerRef.current = setInterval(() => {
        setTimer(Math.floor((Date.now() - startTime) / 1000));
      }, 1000);
    }
    return () => clearInterval(timerRef.current);
  }, [match, matchFinished]);

  // WebSocket
  useEffect(() => {
    if (!matchId) return;
    wsService.connect(matchId, (event) => {
      if (event.type === 'MATCH_FINISHED') {
        setMatchFinished(true);
        setWinner(event.payload?.winnerId);
        clearInterval(timerRef.current);
      }
    }).catch(err => console.warn('WebSocket failed', err));
    return () => wsService.disconnect();
  }, [matchId]);

  // RUN — tests code against all test cases via challenge-service directly
  const handleRun = async () => {
    if (!code.trim() || running) return;
    setRunning(true);
    setRunResults(null);
    setAllPassed(false);
    setActiveTab('results');
    try {
      const { data } = await submitCode(problem.id, { language, code });
      setRunResults(data);
      if (data.allPassed) {
        setAllPassed(true);
        toast.success(`All ${data.totalTests} tests passed! You can now submit.`);
      } else {
        toast.error(`${data.passedTests}/${data.totalTests} tests passed`);
      }
    } catch (err) {
      toast.error('Failed to run code. Is the challenge service running?');
    } finally {
      setRunning(false);
    }
  };

  // SUBMIT — only after all tests pass, submits to match-service to claim the win
  const handleSubmit = async () => {
    if (!allPassed || submitting || matchFinished) return;
    setSubmitting(true);
    try {
      await submitMatchCode(matchId, {
        language,
        code,
        playerId: user.id,
      });
      toast.success('Solution submitted! You won!');
    } catch (err) {
      toast.error('Submission failed');
    } finally {
      setSubmitting(false);
    }
  };

  const handleGetReview = async () => {
    if (!code.trim() || reviewing) return;
    setReviewing(true);
    setReview(null);
    setShowReviewPanel(true);
    try {
      const { data } = await getCodeReview({
        code,
        language,
        problemDescription: problem?.description || '',
        difficulty: match?.difficulty || 'MEDIUM',
        allTestsPassed: allPassed,
      });
      setReview(data);
    } catch (err) {
      setReview({ status: 'error', errorMessage: 'Failed to get AI review. Is the AI service running?' });
    } finally {
      setReviewing(false);
    }
  };

  const formatTime = (seconds) => {
    const m = Math.floor(seconds / 60).toString().padStart(2, '0');
    const s = (seconds % 60).toString().padStart(2, '0');
    return `${m}:${s}`;
  };

  const getScoreColor = (score) => {
    if (score >= 80) return 'var(--green)';
    if (score >= 60) return 'var(--blue)';
    if (score >= 40) return 'var(--yellow)';
    return 'var(--red)';
  };

  if (!problem || !match) {
    return (
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '100vh' }}>
        <Loader2 size={32} color="var(--accent)" style={{ animation: 'spin 1s linear infinite' }} />
      </div>
    );
  }

  const visibleTestCases = problem.testCases?.filter(tc => !tc.hidden) || [];

  return (
    <div style={{ height: '100vh', display: 'flex', flexDirection: 'column', background: 'var(--bg-primary)' }}>
      {/* Top Bar */}
      <div style={{
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '10px 20px', background: 'var(--bg-secondary)',
        borderBottom: '1px solid var(--border)', flexShrink: 0,
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
          <button className="btn btn-sm btn-secondary" onClick={() => navigate('/dashboard')}>
            <ArrowLeft size={14} /> Exit
          </button>
          <h2 style={{ fontSize: 16, fontWeight: 700 }}>{problem.title}</h2>
          <span className={`badge badge-${problem.difficulty?.toLowerCase()}`}>
            {problem.difficulty}
          </span>
        </div>

        <div style={{
          display: 'flex', alignItems: 'center', gap: 8,
          padding: '6px 14px', background: 'var(--bg-tertiary)',
          borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
          fontFamily: "'JetBrains Mono', monospace", fontSize: 18, fontWeight: 600,
          color: timer > 300 ? 'var(--red)' : timer > 120 ? 'var(--yellow)' : 'var(--green)',
        }}>
          <Clock size={16} />
          {formatTime(timer)}
        </div>
      </div>

      {/* Main Content — 3 panes */}
      <div style={{ flex: 1, display: 'flex', overflow: 'hidden' }}>

        {/* LEFT: Problem Description + Test Cases */}
        <div style={{
          width: showReviewPanel ? '24%' : '32%', minWidth: 280,
          borderRight: '1px solid var(--border)', overflow: 'auto',
          display: 'flex', flexDirection: 'column', transition: 'width 0.3s ease',
        }}>
          {/* Problem Description */}
          <div style={{ padding: 20, flex: 1, overflow: 'auto' }}>
            <h3 style={{ fontSize: 18, fontWeight: 700, marginBottom: 12 }}>{problem.title}</h3>
            <div style={{
              fontSize: 14, lineHeight: 1.7, color: 'var(--text-secondary)',
              whiteSpace: 'pre-wrap',
            }}>
              {problem.description}
            </div>

            {/* Sample Test Cases */}
            {visibleTestCases.length > 0 && (
              <div style={{ marginTop: 24 }}>
                <h4 style={{
                  fontSize: 13, fontWeight: 700, marginBottom: 12,
                  color: 'var(--text-muted)', letterSpacing: '0.5px',
                  textTransform: 'uppercase',
                }}>
                  Sample Test Cases ({visibleTestCases.length})
                </h4>
                {visibleTestCases.map((tc, i) => (
                  <div key={tc.id || i} style={{
                    marginBottom: 12, padding: 12, background: 'var(--bg-secondary)',
                    borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
                  }}>
                    <div style={{ fontSize: 11, fontWeight: 700, color: 'var(--text-muted)', marginBottom: 4 }}>
                      Case {i + 1}
                    </div>
                    <div style={{ marginBottom: 8 }}>
                      <span style={{ fontSize: 11, color: 'var(--accent)', fontWeight: 600 }}>Input</span>
                      <pre style={{
                        fontFamily: "'JetBrains Mono', monospace", fontSize: 12,
                        color: 'var(--text-primary)', marginTop: 4,
                        background: 'var(--bg-primary)', padding: 8, borderRadius: 4,
                        overflow: 'auto', whiteSpace: 'pre-wrap',
                      }}>{tc.input}</pre>
                    </div>
                    <div>
                      <span style={{ fontSize: 11, color: 'var(--green)', fontWeight: 600 }}>Expected Output</span>
                      <pre style={{
                        fontFamily: "'JetBrains Mono', monospace", fontSize: 12,
                        color: 'var(--green)', marginTop: 4,
                        background: 'var(--bg-primary)', padding: 8, borderRadius: 4,
                        whiteSpace: 'pre-wrap',
                      }}>{tc.expectedOutput}</pre>
                    </div>
                  </div>
                ))}
              </div>
            )}

            {visibleTestCases.length === 0 && (
              <div style={{
                marginTop: 24, padding: 20, textAlign: 'center',
                color: 'var(--text-muted)', fontSize: 13,
                background: 'var(--bg-secondary)', borderRadius: 'var(--radius-sm)',
                border: '1px solid var(--border)',
              }}>
                <AlertTriangle size={20} style={{ marginBottom: 8, opacity: 0.5 }} />
                <div>No sample test cases available for this problem.</div>
              </div>
            )}
          </div>
        </div>

        {/* CENTER: Code Editor + Bottom Panel */}
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', minWidth: 0 }}>
          {/* Editor Header */}
          <div style={{
            display: 'flex', alignItems: 'center', justifyContent: 'space-between',
            padding: '8px 16px', background: 'var(--bg-secondary)',
            borderBottom: '1px solid var(--border)', flexShrink: 0,
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
              <div style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--green)' }} />
              <span style={{ fontSize: 13, fontWeight: 600 }}>Solution</span>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
              {/* Language Selector */}
              <div style={{ position: 'relative' }}>
                <button onClick={() => setShowLangDropdown(!showLangDropdown)} style={{
                  display: 'flex', alignItems: 'center', gap: 6,
                  padding: '4px 10px', background: 'var(--bg-tertiary)',
                  border: '1px solid var(--border)', borderRadius: 'var(--radius-sm)',
                  color: 'var(--text-primary)', cursor: 'pointer', fontSize: 12,
                }}>
                  {LANGUAGES.find(l => l.id === language)?.label}
                  <ChevronDown size={12} />
                </button>
                {showLangDropdown && (
                  <div style={{
                    position: 'absolute', top: '100%', right: 0, marginTop: 4,
                    background: 'var(--bg-card)', border: '1px solid var(--border)',
                    borderRadius: 'var(--radius-sm)', overflow: 'hidden', zIndex: 10,
                    minWidth: 120,
                  }}>
                    {LANGUAGES.map(l => (
                      <button key={l.id} onClick={() => { setLanguage(l.id); setShowLangDropdown(false); }}
                        style={{
                          display: 'block', width: '100%', padding: '8px 14px', border: 'none',
                          background: language === l.id ? 'var(--accent-glow)' : 'transparent',
                          color: language === l.id ? 'var(--accent)' : 'var(--text-primary)',
                          cursor: 'pointer', fontSize: 13, textAlign: 'left',
                        }}>
                        {l.label}
                      </button>
                    ))}
                  </div>
                )}
              </div>
            </div>
          </div>

          {/* Code Editor */}
          <div style={{ flex: 1, minHeight: 0 }}>
            <Editor
              height="100%"
              language={LANGUAGES.find(l => l.id === language)?.monacoId}
              value={code}
              onChange={(val) => {
                setCode(val || '');
                // Reset pass state when code changes
                if (allPassed) {
                  setAllPassed(false);
                }
              }}
              theme="vs-dark"
              options={{
                fontSize: 14,
                fontFamily: "'JetBrains Mono', monospace",
                minimap: { enabled: false },
                scrollBeyondLastLine: false,
                lineNumbers: 'on',
                renderLineHighlight: 'all',
                padding: { top: 12 },
                automaticLayout: true,
                tabSize: 4,
                wordWrap: 'on',
              }}
            />
          </div>

          {/* Bottom Panel: Test Cases / Run Results */}
          <div style={{
            height: 220, borderTop: '1px solid var(--border)',
            display: 'flex', flexDirection: 'column',
            background: 'var(--bg-secondary)', flexShrink: 0,
          }}>
            {/* Tab Bar */}
            <div style={{
              display: 'flex', alignItems: 'center',
              borderBottom: '1px solid var(--border)',
              padding: '0 16px', gap: 0,
            }}>
              <button onClick={() => setActiveTab('testcases')} style={{
                padding: '8px 16px', fontSize: 12, fontWeight: 600, cursor: 'pointer',
                background: 'none', border: 'none',
                borderBottom: activeTab === 'testcases' ? '2px solid var(--accent)' : '2px solid transparent',
                color: activeTab === 'testcases' ? 'var(--accent)' : 'var(--text-muted)',
                transition: 'all 0.2s',
              }}>
                <span style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                  <Terminal size={13} /> Test Cases
                </span>
              </button>
              <button onClick={() => setActiveTab('results')} style={{
                padding: '8px 16px', fontSize: 12, fontWeight: 600, cursor: 'pointer',
                background: 'none', border: 'none',
                borderBottom: activeTab === 'results' ? '2px solid var(--accent)' : '2px solid transparent',
                color: activeTab === 'results' ? 'var(--accent)' : 'var(--text-muted)',
                transition: 'all 0.2s',
              }}>
                <span style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                  {runResults ? (
                    runResults.allPassed ?
                      <CheckCircle2 size={13} color="var(--green)" /> :
                      <XCircle size={13} color="var(--red)" />
                  ) : <Play size={13} />}
                  Run Results
                  {runResults && (
                    <span style={{
                      fontSize: 10, padding: '1px 6px', borderRadius: 8,
                      background: runResults.allPassed ? 'var(--green-glow)' : 'var(--red-glow)',
                      color: runResults.allPassed ? 'var(--green)' : 'var(--red)',
                      fontWeight: 700,
                    }}>
                      {runResults.passedTests}/{runResults.totalTests}
                    </span>
                  )}
                </span>
              </button>

              {/* Action Buttons — right side */}
              <div style={{ marginLeft: 'auto', display: 'flex', alignItems: 'center', gap: 8, padding: '4px 0' }}>
                <button onClick={() => {
                  if (problem) {
                    const keyMap = { java: 'starterCodeJava', python: 'starterCodePython', javascript: 'starterCodeJavascript' };
                    setCode(problem[keyMap[language]] || '');
                    setRunResults(null);
                    setAllPassed(false);
                  }
                }} style={{
                  display: 'flex', alignItems: 'center', gap: 4,
                  padding: '5px 10px', borderRadius: 'var(--radius-sm)',
                  border: '1px solid var(--border)', background: 'var(--bg-tertiary)',
                  color: 'var(--text-muted)', cursor: 'pointer', fontSize: 12, fontWeight: 500,
                }}>
                  <RotateCcw size={12} /> Reset
                </button>

                {/* RUN Button */}
                <button onClick={handleRun} disabled={running || !code.trim() || matchFinished} style={{
                  display: 'flex', alignItems: 'center', gap: 6,
                  padding: '6px 16px', borderRadius: 'var(--radius-sm)',
                  border: 'none', cursor: 'pointer', fontSize: 13, fontWeight: 600,
                  background: 'var(--bg-tertiary)', color: 'var(--text-primary)',
                  border: '1px solid var(--border)',
                  opacity: running || !code.trim() || matchFinished ? 0.5 : 1,
                  transition: 'all 0.2s',
                }}>
                  {running ? (
                    <Loader2 size={14} style={{ animation: 'spin 1s linear infinite' }} />
                  ) : (
                    <Play size={14} color="var(--green)" />
                  )}
                  {running ? 'Running...' : 'Run'}
                </button>

                {/* SUBMIT Button — only enabled after all tests pass */}
                <button onClick={handleSubmit} disabled={!allPassed || submitting || matchFinished} style={{
                  display: 'flex', alignItems: 'center', gap: 6,
                  padding: '6px 18px', borderRadius: 'var(--radius-sm)',
                  border: 'none', cursor: 'pointer', fontSize: 13, fontWeight: 700,
                  background: allPassed ? 'var(--green)' : 'var(--bg-tertiary)',
                  color: allPassed ? '#000' : 'var(--text-muted)',
                  opacity: !allPassed || submitting || matchFinished ? 0.5 : 1,
                  transition: 'all 0.2s',
                }}>
                  {submitting ? (
                    <Loader2 size={14} style={{ animation: 'spin 1s linear infinite' }} />
                  ) : (
                    <Send size={14} />
                  )}
                  Submit
                </button>

                {/* AI Review Button */}
                <button onClick={handleGetReview} disabled={reviewing || !code.trim()} style={{
                  display: 'flex', alignItems: 'center', gap: 6,
                  padding: '6px 12px', borderRadius: 'var(--radius-sm)',
                  border: '1px solid rgba(99,102,241,0.4)',
                  background: showReviewPanel ? 'rgba(99,102,241,0.15)' : 'rgba(99,102,241,0.08)',
                  color: 'var(--accent)', cursor: 'pointer', fontSize: 12, fontWeight: 600,
                  opacity: reviewing || !code.trim() ? 0.5 : 1,
                }}>
                  {reviewing ? (
                    <Loader2 size={13} style={{ animation: 'spin 1s linear infinite' }} />
                  ) : (
                    <Sparkles size={13} />
                  )}
                  AI Review
                </button>
              </div>
            </div>

            {/* Tab Content */}
            <div style={{ flex: 1, overflow: 'auto', padding: 12 }}>
              {activeTab === 'testcases' && (
                <div>
                  {visibleTestCases.length > 0 ? (
                    <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
                      {visibleTestCases.map((tc, i) => (
                        <div key={tc.id || i} style={{
                          flex: '1 1 280px', maxWidth: 400,
                          padding: 12, background: 'var(--bg-primary)',
                          borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
                        }}>
                          <div style={{
                            fontSize: 12, fontWeight: 700, color: 'var(--text-muted)',
                            marginBottom: 8,
                          }}>
                            Case {i + 1}
                          </div>
                          <div style={{ marginBottom: 6 }}>
                            <span style={{ fontSize: 10, fontWeight: 600, color: 'var(--accent)' }}>INPUT</span>
                            <pre style={{
                              fontFamily: "'JetBrains Mono', monospace", fontSize: 12,
                              color: 'var(--text-primary)', marginTop: 2, whiteSpace: 'pre-wrap',
                              background: 'var(--bg-secondary)', padding: 6, borderRadius: 4,
                            }}>{tc.input}</pre>
                          </div>
                          <div>
                            <span style={{ fontSize: 10, fontWeight: 600, color: 'var(--green)' }}>EXPECTED</span>
                            <pre style={{
                              fontFamily: "'JetBrains Mono', monospace", fontSize: 12,
                              color: 'var(--green)', marginTop: 2, whiteSpace: 'pre-wrap',
                              background: 'var(--bg-secondary)', padding: 6, borderRadius: 4,
                            }}>{tc.expectedOutput}</pre>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div style={{ textAlign: 'center', padding: 24, color: 'var(--text-muted)', fontSize: 13 }}>
                      No sample test cases available.
                    </div>
                  )}
                </div>
              )}

              {activeTab === 'results' && (
                <div>
                  {!runResults ? (
                    <div style={{ textAlign: 'center', padding: 24, color: 'var(--text-muted)', fontSize: 13 }}>
                      <Play size={24} style={{ marginBottom: 8, opacity: 0.3 }} />
                      <div>Click <strong>Run</strong> to test your code against all test cases</div>
                    </div>
                  ) : (
                    <div>
                      {/* Summary Bar */}
                      <div style={{
                        display: 'flex', alignItems: 'center', gap: 12, marginBottom: 12,
                        padding: '8px 12px', borderRadius: 'var(--radius-sm)',
                        background: runResults.allPassed ? 'rgba(0,214,143,0.08)' : 'rgba(255,71,87,0.08)',
                        border: `1px solid ${runResults.allPassed ? 'rgba(0,214,143,0.3)' : 'rgba(255,71,87,0.3)'}`,
                      }}>
                        {runResults.allPassed ? (
                          <CheckCircle2 size={18} color="var(--green)" />
                        ) : (
                          <XCircle size={18} color="var(--red)" />
                        )}
                        <span style={{
                          fontSize: 14, fontWeight: 700,
                          color: runResults.allPassed ? 'var(--green)' : 'var(--red)',
                        }}>
                          {runResults.allPassed ? 'All Tests Passed!' : `${runResults.passedTests}/${runResults.totalTests} Tests Passed`}
                        </span>
                        {runResults.allPassed && !matchFinished && (
                          <span style={{
                            marginLeft: 'auto', fontSize: 12, color: 'var(--green)',
                            fontWeight: 600, animation: 'pulse 1.5s ease infinite',
                          }}>
                            Ready to Submit →
                          </span>
                        )}
                      </div>

                      {/* Individual Test Results */}
                      <div style={{ display: 'flex', gap: 8, flexWrap: 'wrap' }}>
                        {runResults.results?.map((r, i) => (
                          <div key={i} style={{
                            flex: '1 1 280px', maxWidth: 400,
                            padding: 10, borderRadius: 'var(--radius-sm)',
                            background: 'var(--bg-primary)',
                            border: `1px solid ${r.passed ? 'rgba(0,214,143,0.3)' : 'rgba(255,71,87,0.3)'}`,
                          }}>
                            <div style={{
                              display: 'flex', alignItems: 'center', gap: 6, marginBottom: 6,
                            }}>
                              {r.passed ? (
                                <CheckCircle2 size={14} color="var(--green)" />
                              ) : (
                                <XCircle size={14} color="var(--red)" />
                              )}
                              <span style={{
                                fontSize: 12, fontWeight: 700,
                                color: r.passed ? 'var(--green)' : 'var(--red)',
                              }}>
                                Test {i + 1} {r.hidden ? '(Hidden)' : ''}
                              </span>
                            </div>

                            {!r.hidden && (
                              <div style={{ fontSize: 11, fontFamily: "'JetBrains Mono', monospace" }}>
                                {r.input && (
                                  <div style={{ marginBottom: 4 }}>
                                    <span style={{ color: 'var(--text-muted)', fontSize: 10, fontWeight: 600 }}>INPUT: </span>
                                    <span style={{ color: 'var(--text-secondary)' }}>{r.input}</span>
                                  </div>
                                )}
                                <div style={{ marginBottom: 4 }}>
                                  <span style={{ color: 'var(--text-muted)', fontSize: 10, fontWeight: 600 }}>EXPECTED: </span>
                                  <span style={{ color: 'var(--green)' }}>{r.expectedOutput}</span>
                                </div>
                                <div>
                                  <span style={{ color: 'var(--text-muted)', fontSize: 10, fontWeight: 600 }}>OUTPUT: </span>
                                  <span style={{ color: r.passed ? 'var(--green)' : 'var(--red)' }}>
                                    {r.actualOutput || '(no output)'}
                                  </span>
                                </div>
                                {r.error && (
                                  <div style={{
                                    marginTop: 6, padding: 6, background: 'rgba(255,71,87,0.08)',
                                    borderRadius: 4, color: 'var(--red)', fontSize: 10,
                                    whiteSpace: 'pre-wrap',
                                  }}>
                                    {r.error}
                                  </div>
                                )}
                              </div>
                            )}
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>
        </div>

        {/* RIGHT: AI Review Panel (slide-in) */}
        {showReviewPanel && (
          <div style={{
            width: 360, borderLeft: '1px solid var(--border)',
            display: 'flex', flexDirection: 'column',
            background: 'var(--bg-primary)', flexShrink: 0,
          }}>
            <div style={{
              display: 'flex', alignItems: 'center', justifyContent: 'space-between',
              padding: '8px 16px', background: 'var(--bg-secondary)',
              borderBottom: '1px solid var(--border)',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <Sparkles size={16} color="var(--accent)" />
                <span style={{ fontSize: 13, fontWeight: 600 }}>AI Code Review</span>
              </div>
              <button onClick={() => setShowReviewPanel(false)} style={{
                background: 'none', border: 'none', cursor: 'pointer',
                color: 'var(--text-muted)', padding: 4,
              }}>
                <X size={16} />
              </button>
            </div>

            <div style={{ flex: 1, overflow: 'auto', padding: 16 }}>
              {reviewing ? (
                <div style={{ textAlign: 'center', padding: 40 }}>
                  <Sparkles size={32} color="var(--accent)" style={{ marginBottom: 12, animation: 'pulse 1.5s ease infinite' }} />
                  <div style={{ color: 'var(--text-secondary)', fontSize: 14 }}>Analyzing your code...</div>
                </div>
              ) : review?.status === 'error' ? (
                <div style={{
                  padding: 16, background: 'var(--red-glow)', borderRadius: 'var(--radius-sm)',
                  border: '1px solid rgba(255,71,87,0.3)',
                }}>
                  <p style={{ color: 'var(--red)', fontSize: 13 }}>{review.errorMessage}</p>
                </div>
              ) : review ? (
                <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
                  {/* Quality Score */}
                  <div style={{
                    textAlign: 'center', padding: 20, background: 'var(--bg-secondary)',
                    borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
                  }}>
                    <div style={{
                      fontSize: 48, fontWeight: 800, color: getScoreColor(review.qualityScore), lineHeight: 1,
                    }}>
                      {review.qualityScore}
                    </div>
                    <div style={{ fontSize: 12, color: 'var(--text-muted)', marginTop: 4 }}>Quality Score</div>
                    <div style={{ display: 'flex', justifyContent: 'center', gap: 16, marginTop: 12 }}>
                      <div style={{ textAlign: 'center' }}>
                        <div style={{ fontSize: 13, fontWeight: 600, color: 'var(--accent)' }}>{review.timeComplexity}</div>
                        <div style={{ fontSize: 10, color: 'var(--text-muted)' }}>Time</div>
                      </div>
                      <div style={{ width: 1, background: 'var(--border)' }} />
                      <div style={{ textAlign: 'center' }}>
                        <div style={{ fontSize: 13, fontWeight: 600, color: 'var(--accent)' }}>{review.spaceComplexity}</div>
                        <div style={{ fontSize: 10, color: 'var(--text-muted)' }}>Space</div>
                      </div>
                    </div>
                  </div>

                  {/* Summary */}
                  <div style={{
                    padding: 12, background: 'var(--bg-secondary)', borderRadius: 'var(--radius-sm)',
                    border: '1px solid var(--border)', fontSize: 13, color: 'var(--text-secondary)', lineHeight: 1.6,
                  }}>
                    {review.summary}
                  </div>

                  {/* Strengths */}
                  {review.strengths?.length > 0 && (
                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 8 }}>
                        <Star size={14} color="var(--green)" />
                        <span style={{ fontSize: 12, fontWeight: 600, color: 'var(--green)' }}>Strengths</span>
                      </div>
                      {review.strengths.map((s, i) => (
                        <div key={i} style={{
                          padding: '8px 12px', marginBottom: 4,
                          background: 'rgba(0,214,143,0.06)', borderLeft: '3px solid var(--green)',
                          borderRadius: '0 var(--radius-sm) var(--radius-sm) 0',
                          fontSize: 12, color: 'var(--text-secondary)', lineHeight: 1.5,
                        }}>{s}</div>
                      ))}
                    </div>
                  )}

                  {/* Improvements */}
                  {review.improvements?.length > 0 && (
                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 8 }}>
                        <Lightbulb size={14} color="var(--yellow)" />
                        <span style={{ fontSize: 12, fontWeight: 600, color: 'var(--yellow)' }}>Improvements</span>
                      </div>
                      {review.improvements.map((s, i) => (
                        <div key={i} style={{
                          padding: '8px 12px', marginBottom: 4,
                          background: 'rgba(255,199,0,0.06)', borderLeft: '3px solid var(--yellow)',
                          borderRadius: '0 var(--radius-sm) var(--radius-sm) 0',
                          fontSize: 12, color: 'var(--text-secondary)', lineHeight: 1.5,
                        }}>{s}</div>
                      ))}
                    </div>
                  )}

                  {/* Improved Code */}
                  {review.improvedCode && (
                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 8 }}>
                        <Code2 size={14} color="var(--accent)" />
                        <span style={{ fontSize: 12, fontWeight: 600, color: 'var(--accent)' }}>Suggested Solution</span>
                      </div>
                      <pre style={{
                        padding: 12, background: 'var(--bg-secondary)',
                        borderRadius: 'var(--radius-sm)', border: '1px solid var(--border)',
                        fontSize: 11, fontFamily: "'JetBrains Mono', monospace",
                        color: 'var(--text-primary)', overflow: 'auto',
                        maxHeight: 300, lineHeight: 1.5, whiteSpace: 'pre-wrap', wordBreak: 'break-word',
                      }}>{review.improvedCode}</pre>
                    </div>
                  )}
                </div>
              ) : (
                <div style={{ textAlign: 'center', padding: 40, color: 'var(--text-muted)', fontSize: 13 }}>
                  Click "AI Review" to analyze your code
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      {/* Win Modal */}
      {matchFinished && (
        <div style={{
          position: 'fixed', inset: 0, zIndex: 1000,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          background: 'rgba(0,0,0,0.7)', backdropFilter: 'blur(8px)',
        }}>
          <div className="card animate-fadeIn" style={{
            padding: 48, textAlign: 'center', maxWidth: 440,
            background: 'linear-gradient(135deg, var(--bg-card) 0%, #1a1a3e 100%)',
            boxShadow: 'var(--shadow-lg)',
          }}>
            <div style={{
              width: 80, height: 80, borderRadius: '50%', margin: '0 auto 20px',
              background: 'var(--gradient-green)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              animation: 'glow 2s ease infinite',
            }}>
              <Trophy size={40} />
            </div>
            <h2 style={{ fontSize: 32, fontWeight: 800, marginBottom: 8, color: 'var(--green)' }}>
              Challenge Complete!
            </h2>
            <p style={{ color: 'var(--text-secondary)', marginBottom: 8 }}>
              Solved in {formatTime(timer)}!
            </p>
            <div style={{
              display: 'inline-flex', alignItems: 'center', gap: 6,
              padding: '8px 16px', borderRadius: 'var(--radius-sm)',
              background: 'var(--green-glow)', color: 'var(--green)',
              fontWeight: 700, fontSize: 16, marginBottom: 24,
            }}>
              +25 ELO
            </div>

            <div style={{ display: 'flex', gap: 12, justifyContent: 'center' }}>
              <button className="btn btn-primary" onClick={() => navigate('/dashboard')}>
                <RotateCcw size={16} /> Play Again
              </button>
              <button className="btn btn-secondary" onClick={() => navigate('/leaderboard')}>
                <Trophy size={16} /> Leaderboard
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
