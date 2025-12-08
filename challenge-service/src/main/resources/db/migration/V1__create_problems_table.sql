CREATE TABLE problems (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(100) NOT NULL,
    slug VARCHAR(120) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    difficulty VARCHAR(10) NOT NULL,
    category VARCHAR(50),
    starter_code_java TEXT,
    starter_code_python TEXT,
    starter_code_javascript TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE test_cases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    problem_id UUID NOT NULL REFERENCES problems(id),
    input TEXT NOT NULL,
    expected_output TEXT NOT NULL,
    is_hidden BOOLEAN DEFAULT false
);
