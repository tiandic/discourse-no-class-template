# discourse-no-class-template
这个插件可以创建一个无关类型的模板

当用户点击`创建话题`时, 将弹出选择器, 用户可以选择该模板填充进编辑器:
<img width="603" height="387" alt="Screenshot from 2026-09-19 15-23-59" src="https://github.com/user-attachments/assets/0cf32a25-948d-4193-a6fb-de3302f73d32" />



## 使用说明:
### 对于论坛管理员:
插件默认预设了提问模板, 开箱即用

在`/admin/customize/site_texts?locale=zh_CN&q=discourse-no-class-template`中编辑选择器界面文本

在`/admin/plugins/discourse-no-class-template/settings`中编辑填充的模板

### 对于论坛普通用户:
`/u/<user name>/preferences/interface`中的`下次创建话题时，直接通过无模板打开编辑器`:

勾选可以跳过模板选择, 打开空的编辑器, 获得像未使用本插件时一样的体验

当然, 在选择器里面勾选该选项也是同样的效果
