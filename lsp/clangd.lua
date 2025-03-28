return {
  cmd = { 'clangd', '--query-driver=/**/arm-none-eabi-g*,/**/avr-g*' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
}
