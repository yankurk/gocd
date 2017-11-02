# ##########################################################################
# # Copyright 2016 ThoughtWorks, Inc.
# #
# # Licensed under the Apache License, Version 2.0 (the "License");
# # you may not use this file except in compliance with the License.
# # You may obtain a copy of the License at
# #
# #     http://www.apache.org/licenses/LICENSE-2.0
# #
# # Unless required by applicable law or agreed to in writing, software
# # distributed under the License is distributed on an "AS IS" BASIS,
# # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# # See the License for the specific language governing permissions and
# # limitations under the License.
# ##########################################################################
#
# $rack_default_headers = Rack::MockRequest::DEFAULT_ENV.dup
# warn "$rack_default_headers.frozen?: #{$rack_default_headers.frozen?}"
module ApiHeaderSetupTeardown

  def setup_header
    request.env['HTTP_ACCEPT'] = current_api_accept_header
    request.headers['Accept'] = current_api_accept_header
    warn request.headers.inspect
    warn request.env.inspect
  end

  def teardown_header
    request.headers['Accept'] = nil
    request.env['HTTP_ACCEPT'] = nil
  end

  def self.included(klass)
    klass.class_eval do
      before :each do
        setup_header
      end
      after :each do
        teardown_header
      end
    end
  end
end
