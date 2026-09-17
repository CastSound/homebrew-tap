# typed: strict
# frozen_string_literal: true

cask "castsound" do
  version "0.1.1"
  sha256 "31d7da0ed3fe0c0b112f8253ab9559203badafebfccdcfd49cd38906cd80efa0"

  url "https://github.com/CastSound/CastSound-Desktop/releases/download/v#{version}/CastSound-#{version}-macos-universal.dmg"
  name "CastSound"
  desc "Stream audio between computer and phone"
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
