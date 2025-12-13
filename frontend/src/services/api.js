import axios from 'axios';

const AUTH_URL = import.meta.env.VITE_AUTH_URL || 'http://localhost:8081';
const CHALLENGE_URL = import.meta.env.VITE_CHALLENGE_URL || 'http://localhost:8082';
const MATCH_URL = import.meta.env.VITE_MATCH_URL || 'http://localhost:8083';
const LEADERBOARD_URL = import.meta.env.VITE_LEADERBOARD_URL || 'http://localhost:8084';
const AI_URL = import.meta.env.VITE_AI_URL || 'http://localhost:8085';

const authApi = axios.create({ baseURL: AUTH_URL });
const challengeApi = axios.create({ baseURL: CHALLENGE_URL });
const matchApi = axios.create({ baseURL: MATCH_URL });
const leaderboardApi = axios.create({ baseURL: LEADERBOARD_URL });
const aiApi = axios.create({ baseURL: AI_URL });

// Add auth interceptor
const addAuthInterceptor = (instance) => {
  instance.interceptors.request.use((config) => {
    const token = localStorage.getItem('accessToken');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  });
  instance.interceptors.response.use(
    (res) => res,
    async (error) => {
      if (error.response?.status === 401) {
        const refreshToken = localStorage.getItem('refreshToken');
        if (refreshToken) {
          try {
            const { data } = await authApi.post('/auth/refresh', { refreshToken });
            localStorage.setItem('accessToken', data.accessToken);
            localStorage.setItem('refreshToken', data.refreshToken);
            error.config.headers.Authorization = `Bearer ${data.accessToken}`;
            return axios(error.config);
          } catch {
            localStorage.clear();
            window.location.href = '/login';
          }
        }
      }
      return Promise.reject(error);
    }
  );
};

[authApi, matchApi].forEach(addAuthInterceptor);

// Auth
export const register = (data) => authApi.post('/auth/register', data);
export const login = (data) => authApi.post('/auth/login', data);
export const getMe = () => authApi.get('/auth/me');
export const refreshToken = (token) => authApi.post('/auth/refresh', { refreshToken: token });

// Problems
export const getProblems = (params) => challengeApi.get('/problems', { params });
export const getProblem = (id) => challengeApi.get(`/problems/${id}`);
export const getProblemBySlug = (slug) => challengeApi.get(`/problems/slug/${slug}`);
export const getRandomProblem = (difficulty) => challengeApi.get('/problems/random', { params: { difficulty } });
export const submitCode = (problemId, data) => challengeApi.post(`/problems/${problemId}/submit`, data);

// Matches
export const createSoloMatch = (data, userId) => matchApi.post('/matches/solo', data, {
  headers: { 'X-User-Id': userId }
});
export const getMatch = (id) => matchApi.get(`/matches/${id}`);
export const submitMatchCode = (matchId, data) => matchApi.post(`/matches/${matchId}/submit`, data);

// Leaderboard
export const getLeaderboard = (limit = 20) => leaderboardApi.get('/leaderboard', { params: { limit } });
export const getMyRank = (userId) => leaderboardApi.get(`/leaderboard/me/${userId}`);

// AI Code Review
export const getCodeReview = (data) => aiApi.post('/review', data);
export const getAiHealth = () => aiApi.get('/review/health');

export { AUTH_URL, CHALLENGE_URL, MATCH_URL, LEADERBOARD_URL, AI_URL };
