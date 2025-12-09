return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            highlight = { enable = true, },
            indent = { enable = true, },
            autotag = { enable = true, },
            ensure_installed = {
                "json",
                "java",
                "markdown",
                "markdown_inline",
                "c",
                "bash",
                "rust",
                "vim",
                "lua",
                "dockerfile",
                "gitignore",
                "arduino",
                "cpp",
                "cuda",
                "csv",
                "haskell",
                "scala",
                "javadoc",
                "javascript",
                "json5",
                "llvm",
                "powershell",
                "python",
                "verilog",
                "disassembly",
            },
        })
    end,
}
