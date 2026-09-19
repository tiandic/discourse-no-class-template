import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { on } from "@ember/modifier";
import { i18n } from "discourse-i18n";

export default class OpenDirectlyWithNoTemplate extends Component {
  @service currentUser;

  @tracked checked =
    this.currentUser?.custom_fields?.open_directly_with_no_template === "true";

  @action
  toggleChecked(event) {
    const value = event.target.checked;
    this.checked = value;

    this.currentUser.set("custom_fields.open_directly_with_no_template", value);
    this.currentUser.save();
  }

  <template>
    <div class="controls controls-dropdown">
      <label class="checkbox-label">
        <input
          type="checkbox"
          checked={{this.checked}}
          {{on "change" this.toggleChecked}}
        />
        {{i18n
          "discourse-no-class-template.open_directly_with_no_template_checkbox_text"
        }}
      </label>
    </div>
  </template>
}
