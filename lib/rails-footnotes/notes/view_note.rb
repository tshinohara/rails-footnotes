module Footnotes
  module Notes
    class ViewNote < AbstractNote
      def initialize(controller)
        @controller = controller
        subscribe!
      end

      def subscribe!
        @subscriber = ActiveSupport::Notifications.subscribe(
          'render_template.action_view') do |*args|
          event = ActiveSupport::Notifications::Event.new(*args)
          @template = event.payload[:identifier]
        end
      end

      def close
        ActiveSupport::Notifications.unsubscribe @subscriber
      end

      def row
        :edit
      end

      def link
        escape(Footnotes::Filter.prefix(@template, 1, 1))
      end

      def valid?
        @template
      end
    end
  end
end
