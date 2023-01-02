local ok, mason_plugin = pcall(require, "mason")
if not ok then
  print("Mason not found!!!")
  return
end

mason_plugin.setup()
