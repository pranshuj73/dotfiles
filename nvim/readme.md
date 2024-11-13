`[vy] nvim config`

---

#### SETUP / TROUBLESHOOTING

`avante.nvim`
- to fix `failed to load avante_repo_map` or `make sure to build avante` try:
    `cd ~/.local/share/nvim/lazy/avante.nvim && make`

[note: requires cargo & rustc]
[[reference]("https://github.com/yetone/avante.nvim/issues/612#issuecomment-2375729928")]


`copilot.lua`
- run `:Copilot Auth` to authenticate copilot


`image.nvim`
- `sudo pacman -Syu imagemagick` on arch

`cord.nvim`
- throws error on wsl [don't know how to fix this yet, requires piping discord's RPC]

`wakatime.nvim`
- `sudo pacman -S wakatime` to install wakatime & `:WakaTimeApiKey` to enter API key
