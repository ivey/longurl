require 'longurl/expander'

module LongURL
  
  class << self

    # Expand given <tt>:url</tt> to a longest one.
    # First, expand will try to expand url using longurl.org service.
    # Then, it will try to direct follow redirections on the given url and returns final one.
    # === Options
    # * <tt>:cache</tt> : cache object to use, must implement [] and []= functions.
    # * <tt>:first_only</tt> : if true, users all-redirects option to the API to fetch only the first redirect
    #   instead of following all of them. Useful to identify the original URL that was shortened, not the
    #   destination.
    # === Types
    # <tt>url</tt> is expected to be a String and returns a String with the url.
    # === Examples
    #   # simple expands
    #   LongURL.expand("http://tinyurl.com/1c2")                              # => "http://www.google.com"
    #   LongURL.expand("http://tinyurl.com/blnhsg")                           # => "http://www.google.com/search?q=number+of+horns+on+a+unicorn&ie=UTF-8"
    #   LongURL.expand("http://is.gd/iUKg")                                   # => "http://fabien.jakimowicz.com"
    #
    #   # not expandable urls
    #   LongURL.expand("http://www.linuxfr.org")                              # => "http://www.linuxfr.org"
    #
    # === Exceptions
    # * LongURL::InvalidURL : will occurs if given url is nil, empty or invalid
    # * LongURL::NetworkError : a network (timeout, host could be reached, ...) error occurs
    # * LongURL::UnknownError : an unknown error occurs
    def expand(url, options = {})
      @@expander ||= Expander.new(
        :cache => options[:cache],
        :first_only => options[:first_only]
      )
      @@expander.expand(url)
    end
  end
  
end
