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

module ApiSpecHelper

  def current_api_accept_header
    @controller.class.default_accepts_header
  end

  [:get, :delete, :head].each do |http_verb|
    class_eval(<<-EOS, __FILE__, __LINE__)
      def #{http_verb}_with_api_header(path, params={})
        request.headers.merge!({'Accept' => current_api_accept_header})
        #{http_verb} path, params: params
      end
    EOS
  end

  [:post, :put, :patch].each do |http_verb|
    class_eval(<<-EOS, __FILE__, __LINE__)
      def #{http_verb}_with_api_header(path, params={})
        controller.stub(:verify_content_type_on_post)
        request.headers.merge!({'Accept' => current_api_accept_header})
        #{http_verb} path, params: params
      end
    EOS
  end

  def login_as_pipeline_group_Non_Admin_user
    enable_security
    controller.stub(:current_user).and_return(@user = Username.new(CaseInsensitiveString.new(SecureRandom.hex)))
    @security_service.stub(:isUserAdminOfGroup).and_return(false)
    @security_service.stub(:isUserAdmin).with(@user).and_return(false)
  end

  def login_as_pipeline_group_admin_user(group_name)
    enable_security
    controller.stub(:current_user).and_return(@user = Username.new(CaseInsensitiveString.new(SecureRandom.hex)))
    @security_service.stub(:isUserAdminOfGroup).with(@user.getUsername, group_name).and_return(true)
    @security_service.stub(:isUserAdmin).with(@user).and_return(false)
  end

  def login_as_user
    enable_security
    controller.stub(:current_user).and_return(@user = Username.new(CaseInsensitiveString.new(SecureRandom.hex)))
    @security_service.stub(:isUserAdmin).with(@user).and_return(false)
    @security_service.stub(:isUserGroupAdmin).with(@user).and_return(false)
    @security_service.stub(:isUserAdminOfGroup).with(anything, anything).and_return(false)
    @security_service.stub(:isAuthorizedToViewAndEditTemplates).with(@user).and_return(false)
    @security_service.stub(:isAuthorizedToEditTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(false)
    @security_service.stub(:isAuthorizedToViewTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(false)
    @security_service.stub(:isAuthorizedToViewTemplates).with(@user).and_return(false)
  end

  def allow_current_user_to_access_pipeline(pipeline_name)
    @security_service.stub(:hasViewPermissionForPipeline).with(controller.current_user, pipeline_name).and_return(true)
  end

  def allow_current_user_to_not_access_pipeline(pipeline_name)
    @security_service.stub(:hasViewPermissionForPipeline).with(controller.current_user, pipeline_name).and_return(false)
  end

  def disable_security
    controller.stub(:security_service).and_return(@security_service = double('security-service'))
    @security_service.stub(:isSecurityEnabled).and_return(false)
    @security_service.stub(:isUserAdmin).and_return(true)
  end

  def enable_security
    controller.stub(:security_service).and_return(@security_service = double('security-service'))
    @security_service.stub(:isSecurityEnabled).and_return(true)
  end

  def login_as_admin
    enable_security
    controller.stub(:current_user).and_return(@user = Username.new(CaseInsensitiveString.new(SecureRandom.hex)))
    @security_service.stub(:isUserAdmin).with(@user).and_return(true)
    @security_service.stub(:isAuthorizedToViewTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(true)
    @security_service.stub(:isAuthorizedToViewTemplates).with(@user).and_return(true)
    @security_service.stub(:isAuthorizedToEditTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(true)
    @security_service.stub(:isAuthorizedToViewAndEditTemplates).with(anything).and_return(true)
  end

  def login_as_group_admin
    enable_security
    controller.stub(:current_user).and_return(@user = Username.new(CaseInsensitiveString.new(SecureRandom.hex)))
    @security_service.stub(:isUserAdmin).with(@user).and_return(false)
    @security_service.stub(:isUserGroupAdmin).with(@user).and_return(true)
    @security_service.stub(:isUserAdminOfGroup).with(anything, anything).and_return(true)
  end

  def login_as_template_admin
    enable_security
    controller.stub(:current_user).and_return(@user = Username.new(CaseInsensitiveString.new(SecureRandom.hex)))
    @security_service.stub(:isUserAdmin).with(@user).and_return(false)
    @security_service.stub(:isUserGroupAdmin).with(@user).and_return(false)
    @security_service.stub(:isAuthorizedToViewAndEditTemplates).with(@user).and_return(true)
    @security_service.stub(:isAuthorizedToEditTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(true)
    @security_service.stub(:isAuthorizedToViewTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(true)
    @security_service.stub(:isAuthorizedToViewTemplates).with(@user).and_return(true)

  end

  def login_as_anonymous
    controller.stub(:current_user).and_return(@user = Username::ANONYMOUS)
    @security_service.stub(:isUserAdmin).with(@user).and_return(false)
    @security_service.stub(:isUserGroupAdmin).with(@user).and_return(false)
    @security_service.stub(:isAuthorizedToViewAndEditTemplates).with(@user).and_return(false)
    @security_service.stub(:isAuthorizedToEditTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(false)
    @security_service.stub(:isAuthorizedToViewTemplate).with(an_instance_of(CaseInsensitiveString), @user).and_return(false)
    @security_service.stub(:isAuthorizedToViewTemplates).with(@user).and_return(false)
  end

  def actual_response
    JSON.parse(response.body).deep_symbolize_keys
  end

  def expected_response(thing, representer)
    JSON.parse(representer.new(thing).to_hash(url_builder: controller).to_json).deep_symbolize_keys
  end

  def expected_response_with_args(thing, representer, *args)
    JSON.parse(representer.new(thing, *args).to_hash(url_builder: controller).to_json).deep_symbolize_keys
  end


  def expected_response_with_options(thing, opts=[], representer)
    JSON.parse(representer.new(thing, opts).to_hash(url_builder: controller).to_json).deep_symbolize_keys
  end
end
