# typed: strict
# frozen_string_literal: true

cask "castsound" do
  version "1.0.34"
  sha256 "51d29a7fd212f440d1c98d96e718b9c9410f32c70b9b85f1145aa1b97477fc24"

  url "https://github.com/CastSound/CastSound-Desktop/releases/download/v#{version}/CastSound-#{version}-macos-universal.dmg"
  name "CastSound"
  desc "Turn your smartphone into complete PC peripherals with ultra-low latency"
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
  uninstall delete: [
    "#{appdir}/CastSound.app",
  ]

  zap trash: [
    "~/Library/Application Support/CastSound",
    "~/Library/Application Support/com.devculi.castsound",
    "~/Library/Caches/com.devculi.castsound",
    "~/Library/Preferences/com.devculi.castsound.plist",
  ]
end
