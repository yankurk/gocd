/*
 * Copyright 2018 ThoughtWorks, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

describe("Dashboard Pipeline Pause Modal Body", () => {
  const m      = require("mithril");
  const Stream = require("mithril/stream");
  const $      = require("jquery");

  const PipelinePauseModalBody = require("views/dashboard/pipeline_pause_modal_body");
  const Modal                  = require("views/shared/new_modal");
  const Pipeline               = require('models/dashboard/pipeline');

  const pauseMessage        = Stream();
  const spyForPauseCallback = jasmine.createSpy();

  const pipelineJSON = {
    "_links":                 {
      "self":                 {
        "href": "http://localhost:8153/go/api/pipelines/up42/history"
      },
      "doc":                  {
        "href": "https://api.go.cd/current/#pipelines"
      },
      "settings_path":        {
        "href": "http://localhost:8153/go/admin/pipelines/up42/general"
      },
      "trigger":              {
        "href": "http://localhost:8153/go/api/pipelines/up42/schedule"
      },
      "trigger_with_options": {
        "href": "http://localhost:8153/go/api/pipelines/up42/schedule"
      },
      "pause":                {
        "href": "http://localhost:8153/go/api/pipelines/up42/pause"
      },
      "unpause":              {
        "href": "http://localhost:8153/go/api/pipelines/up42/unpause"
      }
    },
    "name":                   "up42",
    "last_updated_timestamp": 1510299695473,
    "locked":                 false,
    "can_unlock":             true,
    "pause_info":             {
      "paused":       true,
      "paused_by":    "admin",
      "pause_reason": "under construction"
    },
    "can_administer":         true,
    "_embedded":              {
      "instances": [
        {
          "_links":       {
            "self":            {
              "href": "http://localhost:8153/go/api/pipelines/up42/instance/1"
            },
            "doc":             {
              "href": "https://api.go.cd/current/#get-pipeline-instance"
            },
            "history_url":     {
              "href": "http://localhost:8153/go/api/pipelines/up42/history"
            },
            "vsm_url":         {
              "href": "http://localhost:8153/go/pipelines/value_stream_map/up42/1"
            },
            "compare_url":     {
              "href": "http://localhost:8153/go/compare/up42/0/with/1"
            },
            "build_cause_url": {
              "href": "http://localhost:8153/go/pipelines/up42/1/build_cause"
            }
          },
          "label":        "1",
          "counter":      "1",
          "scheduled_at": "2017-11-10T07:25:28.539Z",
          "triggered_by": "changes",
          "build_cause":  {
            "approver":           "",
            "is_forced":          false,
            "trigger_message":    "modified by GoCD Test User <devnull@example.com>",
            "material_revisions": [
              {
                "material_type": "Git",
                "material_name": "test-repo",
                "changed":       true,
                "modifications": [
                  {
                    "_links":        {
                      "vsm": {
                        "href": "http://localhost:8153/go/materials/value_stream_map/4879d548de8a9d7122ceb71e7809c1f91a0876afa534a4f3ba7ed4a532bc1b02/9c86679eefc3c5c01703e9f1d0e96b265ad25691"
                      }
                    },
                    "user_name":     "GoCD Test User <devnull@example.com>",
                    "revision":      "9c86679eefc3c5c01703e9f1d0e96b265ad25691",
                    "modified_time": "2017-12-19T05:30:32.000Z",
                    "comment":       "Initial commit"
                  }
                ]
              }
            ]
          },
          "_embedded":    {
            "stages": [
              {
                "_links":       {
                  "self": {
                    "href": "http://localhost:8153/go/api/stages/up42/1/up42_stage/1"
                  },
                  "doc":  {
                    "href": "https://api.go.cd/current/#get-stage-instance"
                  }
                },
                "name":         "up42_stage",
                "counter":      "1",
                "status":       "Failed",
                "approved_by":  "changes",
                "scheduled_at": "2017-11-10T07:25:28.539Z"
              }
            ]
          }
        }
      ]
    }
  };

  const pipeline = new Pipeline(pipelineJSON);
  const modal    = new Modal();

  let $root, root;
  beforeEach(() => {
    [$root, root] = window.createDomElementForTest();
    m.mount(root, {
      view() {
        return m(PipelinePauseModalBody, {
          pipeline,
          message:       pauseMessage,
          pauseCallback: spyForPauseCallback,
          modal
        });
      }
    });
    m.redraw(true);
  });

  afterEach(() => {
    window.destroyDomElementForTest();
    Modal.destroyAll();
  });

  it("should trigger pause and close it's modal when user presses enter", () => {
    const modalSpy       = spyOn(modal, ['destroy']);
    const inputField     = $root.find('label input');
    const keydownEvent   = $.Event("keydown");
    keydownEvent.keyCode = 13;
    inputField.trigger(keydownEvent);
    expect(spyForPauseCallback).toHaveBeenCalledWith(pipeline);
    expect(modalSpy).toHaveBeenCalled();
  });
});
