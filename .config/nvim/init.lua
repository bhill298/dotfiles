-- load vimrc.vim config file
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Fix "error nvim: /__w/neovim/neovim/.deps/build/src/libuv/src/unix/core.c:116; uv_close: Assertion `!uv__is_closing(handle)` failed" on close
-- See https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart('', {detach=true})
  end,
})
