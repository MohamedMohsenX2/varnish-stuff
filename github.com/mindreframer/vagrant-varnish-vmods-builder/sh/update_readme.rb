#!/usr/bin/env ruby

sh_path        = File.expand_path(File.dirname(__FILE__))
readme_path    = File.expand_path(File.join(sh_path, "..", "Readme.md"))
readme_content = File.read(readme_path)

require "#{sh_path}/varnish_installer"


REGEX = /\<\!-- VMODS_LIST_START --\>(.*)\<\!-- VMODS_LIST_END --\>/m
REGEX_START = "<!-- VMODS_LIST_START -->"
REGEX_END   = "<!-- VMODS_LIST_END -->"
EMPTY_LIST  = "#{REGEX_START}\n#{REGEX_END}"


indented_results = VMODS.map{|x| x[:name] + ":\n       - " + x[:url]}.map{|x| "    #{x}"}.map{|x| x.rstrip }.join("\n")
managed_by_text = "    *** GENERATED BY sh/update_readme.rb ***\n"
list_content = REGEX_START + "\n#{managed_by_text}\n#{indented_results}\n" + REGEX_END
content      = readme_content.gsub(REGEX, list_content)
File.open(readme_path, "w") do |f|
  f.puts content
end