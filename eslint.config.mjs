// Shared ESLint flat config (ESLint v9) for the Node.js backend services.
// Scoped to user-service / task-service / notification-service — plain CommonJS.
// The React frontend is linted by react-scripts during its own build, and
// analytics-service is Python (flake8/bandit), so both are ignored here.
import js from "@eslint/js";

// Node + Jest globals, inlined so no extra "globals" package is required.
const nodeGlobals = {
  process: "readonly",
  module: "writable",
  require: "readonly",
  exports: "writable",
  __dirname: "readonly",
  __filename: "readonly",
  console: "readonly",
  Buffer: "readonly",
  global: "readonly",
  setTimeout: "readonly",
  clearTimeout: "readonly",
  setInterval: "readonly",
  clearInterval: "readonly",
  URL: "readonly",
  // Jest (services use jest for tests)
  describe: "readonly",
  it: "readonly",
  test: "readonly",
  expect: "readonly",
  beforeAll: "readonly",
  afterAll: "readonly",
  beforeEach: "readonly",
  afterEach: "readonly",
};

export default [
  {
    // Only lint the backend Node services; everything else is handled elsewhere.
    ignores: [
      "frontend/**",
      "analytics-service/**",
      "k8s/**",
      "workflows for claude/**",
      "**/node_modules/**",
    ],
  },
  js.configs.recommended,
  {
    files: ["user-service/**/*.js", "task-service/**/*.js", "notification-service/**/*.js"],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: "commonjs",
      globals: nodeGlobals,
    },
    rules: {
      // Blocks on real bugs (no-undef, no-dupe-keys, no-unreachable, ...) from
      // eslint:recommended. Unused vars are a warning so they don't wedge the
      // gate; tighten to "error" once the code is clean.
      "no-unused-vars": ["warn", { argsIgnorePattern: "^_", varsIgnorePattern: "^_" }],
      "no-console": "off",
    },
  },
];
