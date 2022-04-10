local set_key = vim.api.nvim_set_keymap
local options = {
  -- noremap just makes sure we dont trigger anything else ie if we had this:
  -- if we do  `noremap j J` 
  -- and we do `noremap J <some action>`
  -- pressing: "j" will not trigger the action
  noremap = true,
  silent = true
}

local function set(modes, key, action)
  for _, mode in ipairs(modes) do
    set_key(mode, key, action, options)
  end
end

-- disable arrow keys, learn vim properly
set({"n", "i", "v"}, "<Up>", "<Nop>")
set({"n", "i", "v"}, "<Down>", "<Nop>")
set({"n", "i", "v"}, "<Right>", "<Nop>")
set({"n", "i", "v"}, "<Left>", "<Nop>key")

-- Allow moving lines up with Alt+k
-- set({"n"}, "<A-k>", "ma :m 'a-2<CR>")
set({"n"}, "<A-k>", ":m .-2<CR>==")
set({"i"}, "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Allow moving lines up with Alt+j
set({"n"}, "<A-j>", ":m .+1<CR>==")
set({"i"}, "<A-j>", "<Esc>:m .+1<CR>==gi")


set({"n"}, "<S-h>", "Hzz")
set({"n"}, "<S-l>", "Lzz")
set({"v"}, "<S-l>", "Lzz")
set({"v"}, "<S-l>", "Lzz")

-- quick jump between windows
set({"n"}, "<C-h>", "<C-W>h")
set({"n"}, "<C-j>", "<C-W>j")
set({"n"}, "<C-k>", "<C-W>k")
set({"n"}, "<C-l>", "<C-W>l")

-- change size of window
set({"n"}, "<A-S-h>",  "5<C-w><")
set({"n"}, "<A-S-j>",  "5<C-w>+")
set({"n"}, "<A-S-k>",  "5<C-w>-")
set({"n"}, "<A-S-l>",  "5<C-w>>")

-- open git manager
-- set({"n"}, "<leader>q", ":Neogit<cr>")
set({"n"}, "<leader>q", ":LazyGit<cr>")

-- quick jsdoc generate
set({"n"}, "<leader>;", ":Neogen<CR>")
set({"n"}, "<leader>o", ":vsplit ~/todo<CR>")

-- multi cursor on ctrl d (:h visual-multi)
set({"n"}, "<C-d>", "<C-n>")

set({"n"}, "<leader>l", ":call NumberToggle()<CR>")

-- toggle hard mode (forces you to not use hjkl so much)
set({"n"}, "<leader>h", "<Esc>:call ToggleHardMode()<CR>")

-- open notes
set({"n"}, "<leader>o", ":vsplit ~/todo/main.norg<CR>")

-- TODO move this
set({"n"}, "<Leader>c", ":RustTest<CR>");
set({"n"}, "<Leader>f", ":Ctest %<CR>");
set({"n"}, "<Leader>p", ":Ctest<CR>");

-- when you have the quickfix list window open, press dd to delete the item from the list
vim.cmd [[
  function! RemoveQFItem()
    let curqfidx = line('.') - 1
    let qfall = getqflist()
    call remove(qfall, curqfidx)
    call setqflist(qfall, 'r')
    execute curqfidx + 1 . "cfirst"
    :copen
  endfunction

  :command! RemoveQFItem :call RemoveQFItem()
  autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
  
  function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
  endfunction
]]
