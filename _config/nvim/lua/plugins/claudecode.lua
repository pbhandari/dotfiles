-- claudecode.nvim: bridges nvim to the Claude Code CLI over the same
-- WebSocket/MCP protocol the official VS Code/JetBrains extensions use. Gives
-- Claude awareness of the active buffer, visual selection, and LSP diagnostics,
-- and renders proposed edits as native nvim diffs. Launch `claude` from the
-- embedded terminal (or :ClaudeCode) so it discovers the ~/.claude/ide lockfile.
return {
  {
    'coder/claudecode.nvim',
    cmd = { 'ClaudeCode', 'ClaudeCodeSend', 'ClaudeCodeFocus', 'ClaudeCodeDiffAccept', 'ClaudeCodeDiffDeny' },
    -- No snacks.nvim dependency: use the built-in terminal provider instead.
    opts = {
      terminal = { provider = 'native' },
    },
    keys = {
      { '<leader>ac', '<Cmd>ClaudeCode<CR>', desc = 'Toggle Claude Code' },
      { '<leader>af', '<Cmd>ClaudeCodeFocus<CR>', desc = 'Focus Claude Code' },
      { '<leader>as', '<Cmd>ClaudeCodeSend<CR>', mode = 'v', desc = 'Send selection to Claude' },
      -- Accept/deny an inline diff Claude proposes.
      { '<leader>aa', '<Cmd>ClaudeCodeDiffAccept<CR>', desc = 'Accept Claude diff' },
      { '<leader>ad', '<Cmd>ClaudeCodeDiffDeny<CR>', desc = 'Deny Claude diff' },
    },
  },
}
