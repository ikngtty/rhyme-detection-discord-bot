# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

require_relative 'lib/bot'

ENV_TOKEN = 'DISCORD_BOT_TOKEN'
token = ENV[ENV_TOKEN]
unless token
  puts "ERROR! The environment variable #{ENV_TOKEN} is not defined."
  exit 1
end

bot_lib = Discordrb::Bot.new token: token, intents: [:server_messages]
bot = Bot.new(bot_lib)
bot.register_handlers
bot.run
