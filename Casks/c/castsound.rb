# typed: strict
# frozen_string_literal: true

cask "castsound" do
  version "1.0.27"
  sha256 "7599d6dde9ecc480c4e12fadfb1f23638e9fef5df5668920d16041979f435525"

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
