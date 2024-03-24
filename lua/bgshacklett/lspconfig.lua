HOME = os.getenv("HOME")
XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or HOME .. "/.config"
XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME") or HOME .. "/.cache"
XDG_DATA_HOME = os.getenv("XDG_DATA_HOME") or HOME .. "/.local/share"
BIN_HOME = HOME .. "/.local/bin"
PROJECT_HOME = HOME .. "/Projects"

local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<leader><space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader><space>q', vim.diagnostic.setloclist, opts)

local lspconfig = require('lspconfig')
local lsp_util = require 'lspconfig.util'


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions

  local list_workspace_folders = function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end

  local fmt = function()
    vim.lsp.buf.format { async = true }
  end

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader><space>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader><space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader><space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader><space>wl', list_workspace_folders, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader><space>f', fmt, bufopts)
end

-- vim.lsp.set_log_level("debug")

local language_servers ={
  taplo = {},

  flow = {},

  eslint = {
    cmd = { 'npm', 'run', 'vscode-eslint-language-server' },
  },

  bashls = {},

  hls = {
    cmd = { 'stack', 'exec', 'haskell-language-server-wrapper', '--', '--lsp' },
  },

  html = {},

  vimls = {
    cmd = { 'npx', 'vim-language-server', '--stdio' },
  },

  lua_ls = {  -- LUA
    settings = {
      Lua = {
        -- runtime = {
        --   -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        --   version = 'LuaJIT',
        -- },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },

  pyright = {},  -- Main Python language server

  -- pylsp = {},  -- Here for plugins like mypy

  tsserver = {},

  gopls = {
    flags = {
      debounce_text_changes = 150,
    }
  },

  terraformls = {
    cmd = {
      "terraform-ls", "serve",
      "-log-file=" .. HOME .. "/tmp/terraform-ls.log",
    },
    -- root_dir = lsp_util.root_pattern('*.tf', '*.tfvars');
  },

  tflint = {},

  solargraph = {
    cmd = { "bundle", "exec", "solargraph", "stdio" };
  },

  yamlls = {},

  powershell_es = {
    bundle_path = XDG_DATA_HOME,
  },

  esbonio = {
    init_options = {
      server = {
        logLevel = "debug"
      },
    },
  },

  efm = {         -- General Purpose Lang Server
    flags = {
      debounce_text_changes = 150,
    },
    init_options = {documentFormatting = true},
    filetypes = {
      "sh",
    },
    settings = {
        rootMarkers = {".git/"},
        languages = {
            sh = {
                {
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck',
                    lintFormats= {
                        '%f:%l:%c: %trror: %m',
                        '%f:%l:%c: %tarning: %m',
                        '%f:%l:%c: %tote: %m',
                    },
                }
            },
        }
    }
  },

  -- java_language_server = {
  --   cmd = { 'sh', '-c', 'JENV_VERSION=1.8 jenv exec /Users/brian.shacklett/Projects/java-language-server/dist/lang_server_mac.sh' }
  -- },

  jdtls = {},

  groovyls = {
    flags = {
      debounce_text_changes = 150,
    },
    -- cmd = { "java", "-jar", BIN_HOME .. "/groovy-language-server-all.jar" },
    cmd = { "java", "-jar", PROJECT_HOME .. "/groovy-language-server/build/libs/groovy-language-server-all.jar" },
    root_dir = function(_)
      return vim.fn.getcwd()  -- TODO: handle more cases
    end,
    filetypes = { "groovy", "Jenkinsfile" },
    settings = {
      groovy = {
        classpath = {
          -- '/Users/brian.shacklett/.gradle/caches/**/*.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/junit/junit/4.13/e49ccba652b735c93bd6e6f59760d8254cf597dd/junit-4.13.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.codehaus.groovy/groovy-all/2.4.12/760afc568cbd94c09d78f801ce51aed1326710af/groovy-all-2.4.12.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.lesfurets/jenkins-pipeline-unit/1.1/afb0fd02143e5d5127ff6187b4403a3cf0b890a0/jenkins-pipeline-unit-1.1.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.cyrusinnovation/mockito-groovy-support/1.3/f091c62bf29c03eed8577db01f137a5cf9cd255c/mockito-groovy-support-1.3.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.jupiter/junit-jupiter-api/5.7.0/b25f3815c4c1860a73041e733a14a0379d00c4d5/junit-jupiter-api-5.7.0.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest/2.2/1820c0968dba3a11a1b30669bb1f01978a91dedc/hamcrest-2.2.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.reflections/reflections/0.9.12/1c9d44c563eebe9b8a3afebd29ed5c4646db800c/reflections-0.9.12.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.slf4j/slf4j-api/1.7.30/b5a4b6d16ab13e34a88fae84c35cd5d68cac922c/slf4j-api-1.7.30.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.cloudbees/groovy-cps/1.12/d766273a59e0b954c016e805779106bca22764b9/groovy-cps-1.12.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/commons-io/commons-io/2.5/2852e6e05fbb95076fc091f6d1780f1f8fe35e0f/commons-io-2.5.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.apache.ivy/ivy/2.4.0/5abe4c24bbe992a9ac07ca563d5bd3e8d569e9ed/ivy-2.4.0.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.assertj/assertj-core/3.4.1/536893abdf1ce11f72c1e4483a88e94d6ba80005/assertj-core-3.4.1.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.mockito/mockito-all/1.9.5/79a8984096fc6591c1e3690e07d41be506356fa5/mockito-all-1.9.5.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.platform/junit-platform-commons/1.7.0/84e309fbf21d857aac079a3c1fffd84284e1114d/junit-platform-commons-1.7.0.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.apiguardian/apiguardian-api/1.1.0/fc9dff4bb36d627bdc553de77e1f17efd790876c/apiguardian-api-1.1.0.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.opentest4j/opentest4j/1.2.0/28c11eb91f9b6d8e200631d46e20a7f407f2a046/opentest4j-1.2.0.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.javassist/javassist/3.26.0-GA/bb2890849968d8d8311ffba8c37b0ce16ce284dc/javassist-3.26.0-GA.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.google.guava/guava/11.0.1/57b40a943725d43610c898ac0169adf1b2d55742/guava-11.0.1.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.google.code.findbugs/jsr305/1.3.9/40719ea6961c0cb6afaeb6a921eaa1f6afd4cfdf/jsr305-1.3.9.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.jupiter/junit-jupiter-engine/5.7.0/d9044d6b45e2232ddd53fa56c15333e43d1749fd/junit-jupiter-engine-5.7.0.jar',
          '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.platform/junit-platform-engine/1.7.0/eadb73c5074a4ac71061defd00fc176152a4d12c/junit-platform-engine-1.7.0.jar',
        }
      }
    }
  }
}

-- Language-specific implementations
local rt = require("rust-tools")

rt.setup({ server = { on_attach = on_attach, } })

-- Setup lspconfig.
local capabilities =
  require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

for server,overrides in pairs(language_servers) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  for k,v in pairs(overrides) do config[k] = v end

  lspconfig[server].setup(
    config
  )
end
