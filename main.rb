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

bot = Discordrb::Bot.new token: token

bot.ready do
  bot.game = 'ラップ'
end

bot.message do |event|
  return if event.author.bot_account?

  content = event.content
  quote_multiline_regexp = / ^ >>> \s .* \z /mx
  content = content.gsub(quote_multiline_regexp, ">>>\n")
  quote_regexp = / ^ > \s .* $ /x
  content = content.gsub(quote_regexp, '>')
  spoiler_regexp = / \|\| .+? \|\| /mx
  content = content.gsub(spoiler_regexp, '||||')

  rhymes = Rhyme.detect(content)
  unless rhymes.empty?
    detection = rhymes.map do |rhyme1, rhyme2|
      "「#{rhyme1}」と「#{rhyme2}」"
    end.join('、')
    event.respond("#{detection}で踏んでるYO！")
  end
end

bot.run
