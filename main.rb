# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

require_relative 'lib/rhyme'

ENV_TOKEN = 'DISCORD_BOT_TOKEN'
token = ENV[ENV_TOKEN]
unless token
  puts "ERROR! The environment variable #{ENV_TOKEN} is not defined."
  exit 1
end

bot = Discordrb::Bot.new token: token, intents: [:server_messages]

bot.ready do
  bot.game = 'ラップ'
end

bot.message do |event|
  next if event.author.bot_account?

  content = event.content
  quote_multiline_regexp = / ^ >>> \s .* \z /mx
  content = content.gsub(quote_multiline_regexp, ">>>\n")
  quote_regexp = / ^ > \s .* $ /x
  content = content.gsub(quote_regexp, '>')
  spoiler_regexp = / \|\| .+? \|\| /mx
  content = content.gsub(spoiler_regexp, '||||')
  code_multiline_regexp = / ``` .+? ``` /mx
  content = content.gsub(code_multiline_regexp, '``````')
  code_regexp = / ` .*? ` /mx
  content = content.gsub(code_regexp, '``')
  content = content.gsub(URI::DEFAULT_PARSER.make_regexp, '***')

  rhymes = Rhyme.detect(content)
  unless rhymes.empty?
    message_of_rhymes = rhymes.map do |rhyme1, rhyme2|
      "「#{rhyme1}」と「#{rhyme2}」"
    end.join('、')
    message = "#{message_of_rhymes}で踏んでるYO！"

    max_message_length = 140
    ellipsis = 'ｱ ｱﾗﾗｧ ｱ ｱｱｧ!!'
    if message.length > max_message_length - ellipsis.length
      message = message[0..(max_message_length - ellipsis.length)] + ellipsis
    end

    event.respond(message)
  end
end

bot.run
