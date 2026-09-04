# Source of truth for the Homebrew cask published to youngminnnn/homebrew-tap.
#
# This file is the template AND the released artifact: the `homebrew-tap` job in
# .github/workflows/build.yml rewrites the `version` and `sha256` lines from the
# tag being built, then commits the result to the tap as Casks/wooi.rb. Keep both
# lines on their own line, exactly in this shape — the job's sed patterns anchor
# on them and the build fails if the substitution doesn't take.
#
# Install: brew install --cask youngminnnn/tap/wooi
cask "wooi" do
  version "1.28.0"
  sha256 "e858ab62c1a83689f9c54ba569b4a06191b16df4d8137e18b58860fb8a4b3a7e"

  url "https://github.com/youngminnnn/wooi/releases/download/v#{version}/Wooi-arm64.dmg"
  name "Wooi"
  desc "Run AI coding agents in parallel, each in its own git worktree"
  homepage "https://github.com/youngminnnn/wooi"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Wooi updates itself through electron-updater: it checks GitHub Releases on
  # launch, downloads in the background, and installs on restart. Without this
  # stanza Homebrew also considers itself the owner of the version, so `brew
  # upgrade` would reinstall over an app that has already self-updated (and
  # `brew outdated` would flag an app that is in fact current). Do not remove it.
  auto_updates true
  # The only published build is Apple Silicon (package.json build.mac targets
  # arm64; the release asset is Wooi-arm64.dmg). The floor is Electron 43's own
  # LSMinimumSystemVersion, 12.0.
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Wooi.app"

  # Everything Wooi writes lives under userData — settings (wooi.json),
  # transcripts, reviews and logs are all subdirectories of it (src/main/store.ts,
  # transcripts.ts, review/store.ts, logger.ts). The rest is created by macOS for
  # the bundle id com.wooi.app.
  #
  # Deliberately NOT listed:
  #   ~/wooi          — git worktrees for your own repos (src/main/paths.ts
  #                     wooiHome()). It is app-created, but it holds your source
  #                     and possibly uncommitted work, so zap leaves it to you.
  #   ~/Library/Application Support/Wooi (dev)
  #                   — only `npm run dev` from a source checkout writes here;
  #                     a cask install never creates it.
  zap trash: [
    "~/Library/Application Support/Wooi",
    "~/Library/Caches/com.wooi.app",
    "~/Library/HTTPStorages/com.wooi.app",
    "~/Library/Preferences/com.wooi.app.plist",
  ]
end
