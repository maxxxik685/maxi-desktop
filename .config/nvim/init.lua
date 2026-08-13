-- ============================================================================
-- 1. АВТОМАТИЧЕСКАЯ УСТАНОВКА LAZY.NVIM (BOOTSTRAP)
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- 2. ИНИЦИАЛИЗАЦИЯ И СПИСОК ПЛАГИНОВ
-- ============================================================================
require("lazy").setup({

  -- Боковая панель файлов (Neo-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true,          -- Показывать скрытые файлы по умолчанию
            hide_dotfiles = false,   -- Не скрывать файлы на точку (.)
            hide_gitignored = false, -- Не скрывать гитигнор файлы
          },
        },
        window = {
          width = 30,
          mappings = {
            ["<cr>"] = "open",       -- Enter: открыть
            ["l"]    = "open",       -- l: открыть
            ["h"]    = "close_node", -- h: свернуть
            ["a"]    = "add",        -- a: создать файл/папку
            ["d"]    = "delete",     -- d: удалить
            ["r"]    = "rename",     -- r: переименовать
            ["H"]    = "toggle_hidden", -- Shift+H: переключить показ скрытых файлов
          },
        },
      })
    end,
  },

  -- Линии отступов для скобок {} (статичные)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = false }, -- Отключаем яркую динамическую подсветку
    },
  },

  -- Умная подсветка синтаксиса (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "python", "cpp", "c" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },

  -- Цветовая схема Tokyo Night
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm",
        styles = {
          sidebars = "transparent", -- Делает фоны панелей единым целым с редактором
          floats = "transparent",
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
})

-- ============================================================================
-- 3. ОСНОВНЫЕ НАСТРОЙКИ (OPTIONS)
-- ============================================================================

-- Номера строк и подсветка
vim.opt.number = true          -- Показ номера текущей строки
vim.opt.relativenumber = true  -- Относительные номера строк
vim.opt.cursorline = true      -- Подсветка текущей строки

-- Внешний вид
vim.opt.wrap = false           -- Отключение переноса длинных строк
vim.opt.mouse = ""             -- Отключение мыши
vim.opt.fillchars:append({ eob = " " }) -- Убираем тильды (~) в конце файлов

-- Табуляция (4 пробела)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Системный буфер обмена
vim.opt.clipboard = "unnamedplus"

-- ============================================================================
-- 4. ГОРЯЧИЕ КЛАВИШИ (KEYMAPS)
-- ============================================================================

-- Пробел — клавиша-лидер
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Space в Normal mode открывает ввод команд (вместо :)
vim.keymap.set('n', '<Space>', ':', { noremap = true })

-- Space + e — Открыть/Закрыть боковое дерево файлов
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- Удаление без попадания в буфер обмена (регистр "_")
vim.keymap.set({'n', 'v'}, 'x', '"_x')
vim.keymap.set({'n', 'v'}, 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set({'n', 'v'}, 'c', '"_c')
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('n', 'C', '"_C')
-- Включаем постоянное сохранение истории отмены
vim.opt.undofile = true

-- Задаем отдельную директорию для файлов истории
local undo_dir = vim.fn.stdpath("state") .. "/undo"
if vim.fn.isdirectory(undo_dir) == 0 then
    vim.fn.mkdir(undo_dir, "p")
end
vim.opt.undodir = undo_dir
