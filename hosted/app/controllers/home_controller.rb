class HomeController < ApplicationController
  def show
    @inbox = Inbox.friendly.find("wegotyourbacktoday")
  end
end
