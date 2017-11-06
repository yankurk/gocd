##########################################################################
# Copyright 2016 ThoughtWorks, Inc.
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
##########################################################################

require 'rails_helper'

describe ApiV1::VersionController do
  include ApiHeaderSetupForRouting

  describe 'with header' do
    before(:each) do
      setup_header
    end

    it 'should route to show action of version controller' do
      expect(:get => 'api/version').to route_to(action: 'show', controller: 'api_v1/version')
    end
  end

  describe 'without header' do
    it 'should not route to show action of version controller' do
      expect(:get => 'api/version').to_not route_to(action: 'show', controller: 'api_v1/version')
      expect(:get => 'api/version').to route_to(controller: 'application', action: 'unresolved', url: 'api/version')
    end
  end
end
