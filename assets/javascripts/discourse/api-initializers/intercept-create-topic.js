import { apiInitializer } from "discourse/lib/api";
import TopicTemplateSelector from "../components/modal/topic-template-selector.gjs";

export default apiInitializer("1.8.0", (api) => {
  const modal = api.container.lookup("service:modal");

  api.modifyClass(
    "controller:composer",
    (Superclass) =>
      class extends Superclass {
        open(opts) {
          if (
            opts?.action === "createTopic" &&
            api.getCurrentUser()?.custom_fields
              ?.open_directly_with_no_template !== "true"
          ) {
            modal.show(TopicTemplateSelector, {
              model: {
                onSelect: (template) => {
                  super.open({ ...opts, reply: template });
                },
              },
            });
            return;
          }
          return super.open(opts);
        }
      },
  );
});
