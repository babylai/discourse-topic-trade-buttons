import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { ajax } from "discourse/lib/ajax";
import DButton from "discourse/ui-kit/d-button";
import { i18n } from "discourse-i18n";

export default class TradeButtons extends Component {
  @service dialog;

  #markTopic(topic, { path, confirmKey, errorKey }) {
    return this.dialog.yesNoConfirm({
      message: i18n(confirmKey),
      didConfirm: () => {
        ajax(path, {
          type: "PUT",
          data: {
            topic_id: topic.id,
          },
        })
          .then((result) => {
            topic.set("title", result.topic_trade_buttons.title);
            topic.set("fancy_title", result.topic_trade_buttons.fancy_title);
            topic.set("archived", result.topic_trade_buttons.archived);
          })
          .catch(() => {
            this.dialog.alert({ message: i18n(errorKey) });
          });
      },
    });
  }

  @action
  clickSoldButton(topic) {
    return this.#markTopic(topic, {
      path: "/topic/sold",
      confirmKey: "topic_trading.mark_as_sold_confirm",
      errorKey: "topic_trading.error_while_marked_as_sold",
    });
  }

  @action
  clickPurchasedButton(topic) {
    return this.#markTopic(topic, {
      path: "/topic/purchased",
      confirmKey: "topic_trading.mark_as_purchased_confirm",
      errorKey: "topic_trading.error_while_marked_as_purchased",
    });
  }

  @action
  clickExchangedButton(topic) {
    return this.#markTopic(topic, {
      path: "/topic/exchanged",
      confirmKey: "topic_trading.mark_as_exchanged_confirm",
      errorKey: "topic_trading.error_while_marked_as_exchanged",
    });
  }

  @action
  clickCancelledButton(topic) {
    return this.#markTopic(topic, {
      path: "/topic/cancelled",
      confirmKey: "topic_trading.mark_as_cancelled_confirm",
      errorKey: "topic_trading.error_while_marked_as_cancelled",
    });
  }

  <template>
    {{#if @outletArgs.model.canTopicBeMarkedAsSold}}
      <DButton
        class="btn-primary"
        @action={{this.clickSoldButton}}
        @actionParam={{@outletArgs.model}}
        @label="topic_trading.sold"
      />
    {{/if}}
    {{#if @outletArgs.model.canTopicBeMarkedAsPurchased}}
      <DButton
        class="btn-primary"
        @action={{this.clickPurchasedButton}}
        @actionParam={{@outletArgs.model}}
        @label="topic_trading.purchased"
      />
    {{/if}}
    {{#if @outletArgs.model.canTopicBeMarkedAsExchanged}}
      <DButton
        class="btn-primary"
        @action={{this.clickExchangedButton}}
        @actionParam={{@outletArgs.model}}
        @label="topic_trading.exchanged"
      />
    {{/if}}
    {{#if @outletArgs.model.canTopicBeMarkedAsCancelled}}
      <DButton
        @action={{this.clickCancelledButton}}
        @actionParam={{@outletArgs.model}}
        @label="topic_trading.cancelled"
      />
    {{/if}}
  </template>
}
