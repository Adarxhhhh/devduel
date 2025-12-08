CREATE TABLE match_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    winner_id VARCHAR(50) NOT NULL,
    loser_id VARCHAR(50) NOT NULL,
    problem_id UUID NOT NULL,
    duration_seconds INTEGER NOT NULL,
    elo_delta INTEGER NOT NULL DEFAULT 25,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);
