if vim.fn.executable("pwsh") == 1 then
  vim.opt.shell = "pwsh"
elseif vim.fn.executable("powershell") == 1 then
  vim.opt.shell = "powershell"
end
