return {
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            -- Опциональные настройки (если нужны)
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_filetypes = { ["*"] = true }
        end,
    }
}
