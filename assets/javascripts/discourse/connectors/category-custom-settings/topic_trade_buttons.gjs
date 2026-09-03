import Component from "@glimmer/component";
import { Input } from "@ember/component";
import { i18n } from "discourse-i18n";

export default class TopicTradeButtonsCategorySettings extends Component {
  static shouldRender(args, context) {
    return context.siteSettings.topic_trade_buttons_enabled;
  }

  <template>
    <section class="field">
      <div class="enable-sold-button">
        <label class="checkbox-label">
          <Input
            @type="checkbox"
            @checked={{@outletArgs.category.enable_sold_button}}
          />
          {{i18n "topic_trading.enable_sold_button"}}
        </label>
      </div>
      <div class="enable-purchased-button">
        <label class="checkbox-label">
          <Input
            @type="checkbox"
            @checked={{@outletArgs.category.enable_purchased_button}}
          />
          {{i18n "topic_trading.enable_purchased_button"}}
        </label>
      </div>
      <div class="enable-exchanged-button">
        <label class="checkbox-label">
          <Input
            @type="checkbox"
            @checked={{@outletArgs.category.enable_exchanged_button}}
          />
          {{i18n "topic_trading.enable_exchanged_button"}}
        </label>
      </div>
      <div class="enable-cancelled-button">
        <label class="checkbox-label">
          <Input
            @type="checkbox"
            @checked={{@outletArgs.category.enable_cancelled_button}}
          />
          {{i18n "topic_trading.enable_cancelled_button"}}
        </label>
      </div>
    </section>
  </template>
}
