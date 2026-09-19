import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { Input } from "@ember/component";
import { action } from "@ember/object";
import { on } from "@ember/modifier";
import { fn } from "@ember/helper";
import { eq, not } from "truth-helpers";
import { i18n } from "discourse-i18n";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import DButton from "discourse/components/d-button";
import DModal from "discourse/components/d-modal";

export default class TopicTypeSelector extends Component {
  @tracked selected = "notemplate";
  @tracked checked = false;
  @service siteSettings;
  @service currentUser;

  options = [
    {
      id: "notemplate",
      label: "discourse-no-class-template.no_template_options_title",
      description:
        "discourse-no-class-template.no_template_options_description",
      icon: "file",
      template: "",
    },
    {
      id: "template",
      label: "discourse-no-class-template.template",
      icon: "question",
      description: "discourse-no-class-template.template_description",
      template: this.siteSettings.discourse_no_class_template_template,
    },
  ];

  @action
  select(option) {
    this.selected = option.id;
  }

  @action
  confirm() {
    const item = this.getOptionsItem(this.selected);

    this.saveCheckboxStatus();
    this.args.model.onSelect(item.template);
    this.args.closeModal();
  }

  getOptionsItem(id) {
    return this.options.find((item) => item.id === id);
  }

  saveCheckboxStatus() {
    if (!this.currentUser) {
      return;
    }

    this.currentUser.set(
      "custom_fields.open_directly_with_no_template",
      this.checked,
    );
    this.currentUser.save();
  }

  <template>
    <DModal
      @title={{i18n "discourse-no-class-template.selector_title"}}
      @closeModal={{@closeModal}}
      class="topic-template-selector-modal"
    >
      <:body>
        <div class="template-choices">
          {{#each this.options as |opt|}}
            <div
              class="template-card {{if (eq this.selected opt.id) 'selected'}}"
              {{on "click" (fn this.select opt)}}
            >
              {{icon opt.icon}}
              <div class="template-card__info">
                <div class="template-card__info__title">{{i18n opt.label}}</div>
                <div class="template-card__info__description">{{i18n
                    opt.description
                  }}</div>
              </div>
            </div>
          {{/each}}
        </div>
        <label class="no-template-checkbox">
          <Input @type="checkbox" @checked={{this.checked}} />
          {{i18n
            "discourse-no-class-template.open_directly_with_no_template_checkbox_text"
          }}
        </label>
      </:body>
      <:footer>
        <DButton
          @action={{this.confirm}}
          @label="discourse-no-class-template.confirm"
          class="btn-primary confirm-button"
        />
      </:footer>
    </DModal>
  </template>
}
