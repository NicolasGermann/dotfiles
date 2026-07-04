-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
local vimrc_path = vim.fn.expand("~/.vimrc")
if vim.fn.filereadable(vimrc_path) == 1 then
  vim.cmd("source " .. vimrc_path)
end
