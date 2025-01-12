return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "folke/which-key.nvim",
    lazy = false,
  },
  {
    "mrcjkb/rustaceanvim", -- https://github.com/mrcjkb/rustaceanvim
    version = "^5", -- Recommended
    event = "BufEnter",
    cond = function()
      -- Start rustaceanvim when we load up a rust workspace instead of on file enter
      local cwd = vim.fn.getcwd()
      local is_rust = vim.fn.glob(cwd .. "/Cargo.toml") ~= ""
      return is_rust
    end,
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require "rustaceanvim.config"

      -- Trigger the lsp to warm up in the background
      local client_id = require("rustaceanvim.lsp").start(0)
      vim.lsp.buf_detach_client(0, client_id)

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "adamthedash/llm.nvim", -- https://github.com/huggingface/llm.nvim
    -- dir = "~/projects/lua/llm.nvim",
    enabled = false,
    event = "BufRead",
    opts = {
      -- cf Setup
      backend = "llamacpp",
      url = "http://172.30.176.1:1234/completions", -- host IP from WSL2: echo $(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
      lsp = {
        bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
        -- cmd_env = { LLM_LOG_LEVEL = "DEBUG" },
      },
      tokenizer = {
        path = "/mnt/c/Users/Adam/Desktop/llama-b3995-bin-win-vulkan-x64/models/qwen_tokenizer.json",
      },
      fim = {
        enabled = true,
        prefix = "<|fim_prefix|>",
        middle = "<|fim_middle|>",
        suffix = "<|fim_suffix|>",
      },
      debounce_ms = 400,

      context_window = 1024, -- max number of tokens for the context window
      enable_suggestions_on_startup = true,
      enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
      disable_url_path_completion = true, -- cf Backend
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zjp-CN/nvim-cmp-lsp-rs",
        ops = {
          kind = function(k)
            -- The argument in callback is type-aware with opts annotated,
            -- so you can type the CompletionKind easily.
            return { k.Module, k.Function }
          end,
          -- -- Override the default comparator list provided by this plugin.
          -- -- Mainly used with key binding to switch between these Comparators.
          -- combo = {
          --   -- The key is the name for combination of comparators and used
          --   -- in notification in swiching.
          --   -- The value is a list of comparators functions or a function
          --   -- to generate the list.
          --   alphabetic_label_but_underscore_last = function()
          --     local comparators = require("cmp_lsp_rs").comparators
          --     return { comparators.sort_by_label_but_underscore_last }
          --   end,
          --   recentlyUsed_sortText = function()
          --     local compare = require("cmp").config.compare
          --     local comparators = require("cmp_lsp_rs").comparators
          --     -- Mix cmp sorting function with cmp_lsp_rs.
          --     return {
          --       compare.recently_used,
          --       compare.sort_text,
          --       comparators.sort_by_label_but_underscore_last,
          --     }
          --   end,
          -- },
          opts = function(_, opts)
            local comparators = require "cmp_lsp_rs"
            opts.sorting.comparators = {
              comparators.inscope_inherent_import,
            }
            -- for k,v in pairs(opts) do
            --   print(k, v)
            -- end
            return opts
          end,
        },
      },
    },
  },
}
