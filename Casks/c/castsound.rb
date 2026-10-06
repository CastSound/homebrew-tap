# typed: strict
# frozen_string_literal: true

cask "castsound" do
  version "1.0.24"
  sha256 "b31575d2ffeb7c4d6dcd10e4deaafd1f45ee2ece623a606d81ee769c1e5cddc9"

  url "https://github.com/CastSound/CastSound-Desktop/releases/download/v#{version}/CastSound-#{version}-macos-universal.dmg"
  name "CastSound"
  desc "Use your phone as a wireless speaker, microphone and webcam for your computer"
  homepage "https://castsound.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on :macos

  app "CastSound.app"

  postflight_steps do
    mkdir_p "Library/Application Support/com.devculi.castsound", base: :home
    touch "Library/Application Support/com.devculi.castsound/.managed_by_homebrew", base: :home
  end

  uninstall script: {
    executable: "#{appdir}/CastSound.app/Contents/MacOS/castsound-uninstall",
    args:       ["-y"],
    sudo:       true,
  }

  zap trash: [
    "~/Library/Application Support/CastSound",
    "~/Library/Application Support/com.devculi.castsound",
    "~/Library/Caches/com.devculi.castsound",
    "~/Library/Preferences/com.devculi.castsound.plist",
  ]
end
