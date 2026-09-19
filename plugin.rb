# name: discourse-no-class-template
# about: 无关分类的话题模板, 让用户点击"创建话题"时立即进行模板选择
# version: 0.1.0
# authors: tiandic
# url: https://github.com/tiandic/discourse-no-class-template

enabled_site_setting :discourse_no_class_template_enabled

register_asset "stylesheets/topic-template-selector.scss"

after_initialize do
  User.register_custom_field_type(:open_directly_with_no_template, :boolean)
  register_editable_user_custom_field :open_directly_with_no_template
  DiscoursePluginRegistry.serialized_current_user_fields << 'open_directly_with_no_template'
  add_to_serializer(:current_user, :open_directly_with_no_template) { object.custom_fields["open_directly_with_no_template"] }
end
