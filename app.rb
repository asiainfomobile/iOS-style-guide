#!/usr/bin/env ruby
require 'json'

# 获取模块列表数组
modules = ARGV

# 模块列表json
modulesString = JSON(modules)

# 执行pod lib create 
system "pod lib create TEST --template-url=ssh://git@gitlab-console.asiainfo.com:10022/kara-mobile/App-Template.git"

# 写入模块列表配置
File.open("TEST/Example/TEST/Modules.json", "w+") do |f|
  f.puts(modulesString)
end

PodfileArray = File.readlines('TEST/Example/Podfile')

podurls = modules.map { |m|
  "pod '#{m}',    :git => 'ssh://git@gitlab-console.asiainfo.com:10022/kara-mobile/#{m}-iOS.git', :branch => 'develop'"
}

newPodFileArray = PodfileArray.insert(12, podurls)
File.open("TEST/Example/Podfile", "w+") do |p|
  p.puts(newPodFileArray.join("\n"))
end

Dir.chdir("TEST/Example") do
  system "pod install"
end
