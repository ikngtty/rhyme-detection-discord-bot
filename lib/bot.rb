# frozen_string_literal: true

require 'natto'

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
    return if event.server.nil?

    responder = event.method(:respond)

    bot_id = @discord.profile.id
    member = event.server.member(bot_id)
    return if member.nil?
    managed_role = member.roles.find(&:managed?)

    command_regexp = /\A (?:
      < @#{bot_id} > |
      < @!#{bot_id} > |
      < @&#{managed_role.id} >
      )

      \s*

      (?<command> \S+)

      \s*

      (?<rest> .*) \Z/mx
    match = command_regexp.match(event.content)

    if match.nil?
      detect(event.content, responder)
    else
      captures = match.named_captures
      command = captures['command']
      rest = captures['rest']

      case command
      when 'mecab'
        mecab_command(rest, responder)
      else
        unknown_command(rest, responder)
      end
    end
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

  def mecab_command(content, responder)
    mecab = Natto::MeCab.new
    parse_result = mecab.parse(content)
    responder.call("```\n#{parse_result}\n```")
  end

  def unknown_command(content, responder)
    responder.call('かまってちゃんは黙ってな👊')
  end
end
