let b:ale_fixers = ['clang-format']
let b:ale_linters = ['clang', 'clangtidy']

if executable('clang-9')
  let b:ale_c_clang_executable = 'clang-9'
end
if executable('clangd-9')
  let b:ale_c_clangd_executable = 'clangd-9'
end
if executable('clang-format-9')
  let b:ale_c_clangformat_executable = 'clang-format-9'
end
if executable('clang-tidy-9')
  let b:ale_c_clangtidy_executable = 'clang-tidy-9'
end

let b:ale_c_clang_options = '-std=c11 -Wall'
let b:ale_c_clangformat_options = '-style=Google'
let b:ale_c_clangtidy_options = '-std=c11'
let b:ale_c_gcc_options = '-std=c11 -Wall'
