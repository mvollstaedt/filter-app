class NewsItem::ScoringAlgorithm
  attr_reader :data
  def initialize(data, max_age:)
    @data = data
    @max_age = max_age.to_i
  end

  def data(val)
    @data[val] || 0
  end

  def run
    base =
      data(:bias) +
      smooth(data(:xing)) * 3 +
      smooth(data(:linkedin)) * 2 +
      smooth(data(:gplus)) +
      smooth(data(:retweets)) + # TODO: maybe old?
      smooth(data(:twitter)) +
      smooth(data(:reddit)) +
      smooth(data(:facebook)) / 2 +
      smooth(data(:incoming_link_count)) * 2 +
      smooth(data(:impression_count)) / 5.0 +
      data(:word_length)**0.3 # Lange beitrage leicht nach oben, z.B.
    # 1000 Worte -> 30pkt
    # (data(:parallel_news_count) ** 1.2 + 2)
    # Oft postende Quellen benachteiligen
    # 20 News in 2 Wochen -> -34pkt
    # 10 News in 2 Wochen -> -13pkt
    #                                  # 3  News in 2 Wochen -> -1pkt

    base *= data(:multiplicator)

    if data(:published_at) < @max_age
      time_factor = 0
    else
      now = Time.now.to_i
      time_factor = (data(:published_at) - @max_age) / (now - @max_age).to_f
      time_factor **= 2.5 # Smooth out -> je aelter desto deutlich weniger
    end
    if base < 0
      time_factor = 1 + time_factor * -1
    end
    {
      absolute_score: base,
      relative_score: base * time_factor
    }
  end

  def smooth(value)
    [Math.log((value + 1) * 2)**2.2 - 1, 0].max
  end
end
