##########################GO-LICENSE-START################################
# Copyright 2017 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################GO-LICENSE-END##################################
RSpec.configure do |config|
# Use color not only in STDOUT but also in pagers and files
  config.tty = true
  config.color = true
  config.default_formatter = "doc"

  config.add_formatter :documentation
  config.add_formatter RspecJunitFormatter, File.join(ENV['REPORTS_DIR'] || Rails.root.join('tmp/reports'), 'spec_full_report.xml')
  config.include ApiSpecHelper
  config.include MiscSpecExtensions
  config.include CacheTestHelpers

# clear flash messages for every spec
  config.before(:each) do
    com.thoughtworks.go.server.web.FlashMessageService.useFlash(com.thoughtworks.go.server.web.FlashMessageService::Flash.new)
    setup_base_urls
  end

  config.before(:each) do
    # call params.permit! if params is an instance of StrongParameter
    respond_to?(:params) && params.respond_to?(:permit!) && params.permit!
  end

  config.after(:each) do
    ServiceCacheStrategy.instance.clear_services
  end

  config.example_status_persistence_file_path = Rails.root.join('tmp/rspec_failures.txt')
end

include JavaSpecImports
include JavaImports