{ lua }:

{
  augroups = [
    {
      name = "highlight-yank";
      clear = true;
    }
  ];

  autocmds = [
    {
      event = [ "TextYankPost" ];
      desc = "Highlight when yanking (copying) text";
      callback = lua ''
        function()
          vim.hl.on_yank()
        end
      '';
    }
  ];
}
