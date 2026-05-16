local function get_jdtls_workspace_dir()
  return vim.fn.stdpath('cache') .. '/jdtls/workspace'
end

local function get_jdtls_jvm_args()
  local env = os.getenv('JDTLS_JVM_ARGS')
  local args = {}
  for a in string.gmatch((env or ''), '%S+') do
    table.insert(args, string.format('--jvm-arg=%s', a))
  end
  return unpack(args)
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local data_dir = get_jdtls_workspace_dir()
    if config.root_dir then
      data_dir = data_dir .. '/' .. vim.fn.fnamemodify(config.root_dir, ':p:h:t')
    end

    local config_cmd = {
      'jdtls',
      '-data',
      data_dir,
      get_jdtls_jvm_args(),
    }

    return vim.lsp.rpc.start(config_cmd, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,
  filetypes = { 'java' },
  root_markers = {
    { 'mvnw', 'gradlew', 'settings.gradle', 'settings.gradle.kts', '.git' },
    { 'build.xml', 'pom.xml', 'build.gradle', 'build.gradle.kts' },
  },
  init_options = {},
}
