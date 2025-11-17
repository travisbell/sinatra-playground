# frozen_string_literal: true

module Components
  class CardList < Base
    def initialize
      super
    end

    def results
      [
        {
          date: rand(1..12).months.ago,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dolor ac luctus pulvinar. Vivamus consequat libero ipsum, id ullamcorper sem gravida nec. Suspendisse vel.",
          id: 1,
          name: "Search Result 1",
          url: "/demo/item/1"
        },
        {
          date: rand(1..14).days.ago,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dolor ac luctus pulvinar. Vivamus consequat libero ipsum, id ullamcorper sem gravida nec. Suspendisse vel.",
          id: 2,
          name: "Search Result 2",
          url: "/demo/item/2"
        },
        {
          date: rand(1..24).hours.ago,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dolor ac luctus pulvinar. Vivamus consequat libero ipsum, id ullamcorper sem gravida nec. Suspendisse vel.",
          id: 3,
          name: "Search Result 3",
          url: "/demo/item/3"
        },
        {
          date: rand(1..12).months.ago,
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dolor ac luctus pulvinar. Vivamus consequat libero ipsum, id ullamcorper sem gravida nec. Suspendisse vel.",
          id: 4,
          name: "Search Result 4",
          url: "/demo/item/4"
        }
      ]
    end
  end
end
