# frozen_string_literal: true

require_relative 'rhyme'

class Bot
  def initialize(discord)
    @discord = discord
  end

  def register_handlers
    @discord.ready(&method(:handle_ready))
    @discord.message(&method(:handle_message))
  end

  def run
    @discord.run
  end

  def handle_ready(event)
    @discord.game = 'ラップ'
  end

  def handle_message(event)
    return if event.author.bot_account?

    detect(event.content, event.method(:respond))
  end

  private

  def escape_message_for_detection(message)
    quote_multiline_regexp = / ^ >>> \s .* \z /mx
    message = message.gsub(quote_multiline_regexp, ">>>\n")
    quote_regexp = / ^ > \s .* $ /x
    message = message.gsub(quote_regexp, '>')
    spoiler_regexp = / \|\| .+? \|\| /mx
    message = message.gsub(spoiler_regexp, '||||')
    code_multiline_regexp = / ``` .+? ``` /mx
    message = message.gsub(code_multiline_regexp, '``````')
    code_regexp = / ` .*? ` /mx
    message = message.gsub(code_regexp, '``')
    message = message.gsub(URI::DEFAULT_PARSER.make_regexp, '***')
    message
  end

  def detect(content, responder)
    content = escape_message_for_detection(content)

    rhymes = Rhyme.detect(content)
    return if rhymes.empty?

    message_of_rhymes = rhymes.map do |rhyme1, rhyme2|
      "「#{rhyme1}」と「#{rhyme2}」"
    end.join('、')
    message = "#{message_of_rhymes}で踏んでるYO！"

    max_message_length = 140
    ellipsis = 'ｱ ｱﾗﾗｧ ｱ ｱｱｧ!!'
    if message.length > max_message_length - ellipsis.length
      message = message[0..(max_message_length - ellipsis.length)] + ellipsis
    end

    responder.call(message)
  end
end
