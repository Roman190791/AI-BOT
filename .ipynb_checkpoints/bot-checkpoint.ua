
import logging
from aiogram import Bot, Dispatcher, types
from aiogram.types import ChatMemberUpdated
from aiogram.utils import executor
import asyncio
import os

API_TOKEN = "7909092865:AAE4UNZ5nOnutpVloC-dot8JOvn6tTagK8w"

logging.basicConfig(level=logging.INFO)
bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)

@dp.message_handler(commands=['start'])
async def send_welcome(message: types.Message):
    await message.reply("Привіт! Я — бот AI Community. Я допомагаю модерувати групу.")

@dp.message_handler(commands=['ban'])
async def ban_user(message: types.Message):
    if not message.reply_to_message:
        await message.reply("Цю команду треба використовувати у відповідь на повідомлення користувача.")
        return
    user_id = message.reply_to_message.from_user.id
    await message.chat.kick(user_id)
    await message.reply("Користувач забанений.")

@dp.message_handler()
async def filter_links(message: types.Message):
    if "http://" in message.text or "https://" in message.text:
        await message.delete()
        await message.answer("Посилання заборонено!")

@dp.chat_member_handler()
async def on_user_join(event: ChatMemberUpdated):
    if event.new_chat_member.status == "member":
        await bot.send_message(event.chat.id, f"Ласкаво просимо, {event.from_user.full_name}!")

if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)
#setup
chmod +x start.sh
