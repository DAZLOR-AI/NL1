INSERT INTO modules (id, name, tier) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Prompting Fundamentals', 'free'),
  ('22222222-2222-2222-2222-222222222222', 'Advanced Prompting', 'pro'),
  ('33333333-3333-3333-3333-333333333333', 'Research Architectures', 'research');

INSERT INTO lessons (module_id, title, scenario, weak_prompt, optimized_prompt, explanation) VALUES
  ('11111111-1111-1111-1111-111111111111','JWT Login API','Generate backend API','Build login','Role: Senior Vapor engineer...','Adds role, constraints, schema outputs.'),
  ('22222222-2222-2222-2222-222222222222','Prompt Chain','Create deterministic workflow','Write prompt chain','Role + stages + validator loop...','Separates generation and verification.'),
  ('33333333-3333-3333-3333-333333333333','System Prompt Control','Architect multi-agent routing','Make an agent system','System prompt hierarchy + failover...','Imposes topology and control surfaces.');
