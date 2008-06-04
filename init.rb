# Footnotes is divided in five files:
#
# * textmate_footnotes.rb: Is the core and adds the debug options at the bottom
#   of each page;
#
# * textmate_initialiaze.rb: Initialize the plugin and apply the footnotes as an
#   after_filter;
#
# * textmate_links.rb: Provides links to open controller, layout, view and asset
#   files in textmate;
#
# * textmate_backtracer.rb: Append links to Textmate in backtrace pages. 
#
# * textmate_analyzer.rb: Append explain queries in log when using MySQL.
#
# The footnotes are applied in all actions under development. If You want to
# change this behaviour, check the textmate_initialize.rb file.
#
# And by default, the last two files are only loaded in MacOSX. If your editor
# support opening files like Textmate, e.g. txmt://open?url=file://, you can put
# in your environment file the following line:
#
#   Footnotes::Filter.textmate_prefix = "editor://open?file://"
#
# If You want to use your own stylesheet, you can disable the Footnotes
# stylesheet with:
#
#   Footnotes::Filter.no_style = true
#
# Footnotes try to append at the end of the page, but if your page have a div
# with id "tm_footnotes", Footnotes will be inserted into this div.
#
# In Footnotes 3.1, you also have the ability to cherry pick which notes do you
# want to use, simply doing:
#
#   Footnotes::Filter.notes = [:session, :cookies, :params, :filters, :routes, :queries, :log, :general]
#
if (ENV['RAILS_ENV'] == 'development')
  # Windows doesn't have 'uname', so rescue false
  ::MAC_OS_X = RUBY_PLATFORM.include?('darwin')
  require 'textmate_footnotes'
  require 'textmate_links'
  require 'textmate_analyzer'
  require 'textmate_initialize'

  if ::MAC_OS_X
    Footnotes::Filter.textmate_prefix = 'txmt://open?url=file://'
    require 'textmate_backtracer'
  end
end