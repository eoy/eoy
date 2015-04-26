class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout :layout_for_page

  def contact
    @message = Message.new
  end

  private

  def layout_for_page
    if request.xhr?
      false
    else
      'application'
    end
  end
end
