return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
    }

    -- Function to find the best Python interpreter for linting
    local function find_python_interpreter()
      -- Check for virtual environment in current directory
      local venv_path = vim.fn.getcwd() .. "/venv/bin/python"
      if vim.fn.filereadable(venv_path) == 1 then
        return venv_path
      end
      
      -- Check for .venv
      local dot_venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
      if vim.fn.filereadable(dot_venv_path) == 1 then
        return dot_venv_path
      end
      
      -- Fallback to system python
      return vim.fn.exepath("python")
    end

    -- Configure pylint to use the correct Python interpreter
    lint.linters.pylint = {
      cmd = find_python_interpreter(),
      stdin = true,
      args = {
        "--from-stdin",
        "--disable=C0111", -- Missing docstring
        "--disable=C0103", -- Invalid name
        "--disable=C0303", -- Trailing whitespace
        "--disable=W0611", -- Unused import
        "--disable=W0621", -- Redefining name from outer scope
        "--disable=W0622", -- Redefining built-in
        "--disable=W0703", -- Broad except clause
        "--disable=R0903", -- Too few public methods
        "--disable=R0913", -- Too many arguments
        "--disable=R0914", -- Too many local variables
        "--disable=R0915", -- Too many statements
      },
      stdin_filename = true,
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
