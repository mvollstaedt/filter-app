class DaysController < ApplicationController
  def index
    @days = 14.times.map { |i|
      date = i.days.ago.to_date
      all =  NewsItem.top_of_day(date)
      take = [(all.count * 0.33).ceil, 8].max
      news = all.limit(take)
      [ date, all.count, news]
    }
  end

  def show
    @day = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    if @day > Date.today
      raise ArgumentError
    end
    @news = NewsItem.top_of_day(@day)
    @tomorrow = @day + 1
    if @tomorrow > Date.today
      @tomorrow = nil
    end
    @yesterday = @day - 1
  rescue ArgumentError
    render text: "<h3>Ungültiges Datum</h3>", layout: true, status: 400
  end
end