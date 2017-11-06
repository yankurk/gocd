module ActiveSupportCacheEntryExt
  def value=(new_value)
    @value = compressed? ? compress(new_value) : new_value
  end

  ActiveSupport::Cache::Entry.send(:include, ActiveSupportCacheEntryExt)
end
