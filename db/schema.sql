CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  tier TEXT NOT NULL DEFAULT 'free',
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE modules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  tier TEXT NOT NULL
);

CREATE TABLE lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id UUID NOT NULL REFERENCES modules(id),
  title TEXT NOT NULL,
  scenario TEXT NOT NULL,
  weak_prompt TEXT NOT NULL,
  optimized_prompt TEXT NOT NULL,
  explanation TEXT NOT NULL
);

CREATE TABLE prompt_attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  prompt TEXT NOT NULL,
  clarity INT NOT NULL,
  specificity INT NOT NULL,
  determinism INT NOT NULL,
  structure INT NOT NULL,
  hallucination_risk INT NOT NULL,
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE user_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  lesson_id UUID NOT NULL REFERENCES lessons(id),
  score INT NOT NULL,
  completed BOOLEAN NOT NULL,
  updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  product_id TEXT NOT NULL,
  status TEXT NOT NULL,
  expires_at TIMESTAMP
);

CREATE TABLE usage_tracking (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  day DATE NOT NULL,
  optimizations_used INT NOT NULL
);
