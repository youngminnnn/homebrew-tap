# youngminnnn/homebrew-tap

Homebrew tap for [Wooi](https://github.com/youngminnnn/wooi) — a macOS app for
running AI coding agents in parallel, each in its own git worktree.

```sh
brew install --cask youngminnnn/tap/wooi
```

Apple Silicon, macOS 12 (Monterey) or later. The build is signed and notarized
with an Apple Developer ID.

Use the full `youngminnnn/tap/wooi` name. Homebrew 6 refuses to load casks from
third-party taps unless you name the tap or cask on the command line, so the
short `brew install --cask wooi` needs `brew trust youngminnnn/tap` first.

## Don't edit `Casks/wooi.rb` here

It is generated on every release by the `homebrew-tap` job in
[wooi's `build.yml`](https://github.com/youngminnnn/wooi/blob/main/.github/workflows/build.yml),
which renders
[`build/homebrew/wooi.rb`](https://github.com/youngminnnn/wooi/blob/main/build/homebrew/wooi.rb)
with the released version and the `sha256` of the published `.dmg`. Changes made
directly in this repo are overwritten by the next release — send them to
`build/homebrew/wooi.rb` in the main repo instead.

## Updating

Wooi updates itself through electron-updater, which is why the cask sets
`auto_updates true`. `brew upgrade` is not needed and intentionally does not
manage the app's version after install.
