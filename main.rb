require "telegram/bot"

TOKEN = 'YOUR TOKEN'
def check (message,latin,cyr)
    message = message.split("")
    if !(message & latin).empty?
        return 'eng'
    elsif !(message & cyr).empty?
        return 'russ'
    end 
end
russ = [
#Положительные
"Бесспорно", 
"Предрешено",
"Никаких сомнений", 
"Определённо да",
"Можешь быть уверен в этом",

#Нерешительно положительно
"Мне кажется — «да»",
"Вероятнее всего",
"Хорошие перспективы",
"Знаки говорят — «да»",
"Да",

#Нейтральные
"Пока не ясно, попробуй снова",
"Спроси позже",
"Лучше не рассказывать",
"Сейчас нельзя предсказать",
"Сконцентрируйся и спроси опять",

#Отрицательные 
"Даже не думай",
"Мой ответ — «нет»",
"По моим данным — «нет»",
"Перспективы не очень хорошие",
"Весьма сомнительно"
]

eng = [

#Positive
"It is certain", 
"It is decidedly so",
"Without a doubt", 
"Yes — definitely",
"You may rely on it", 

#Hesitantly positive

"As I see it, yes",
"Most likely",
"Outlook good",
"Signs point to yes",
"Yes",

#Neutral

"Reply hazy, try again",
"Ask again later", 
"Better not tell you now",
"Cannot predict now", 
"Concentrate and ask again", 

#Negative

"Don’t count on It",
"My reply is no",
"My sources say no",
"Outlook not so good",
"Very doubtful"
]
condition = nil

Telegram::Bot::Client.run(TOKEN) do |bot|
    bot.listen do |message|
        latin = [*"A".."Z",*"a".."z"]
        cyr = [*"А".."Я",*"а".."я"]
        if message 
        case message.text
        when '/start'
            condition = 'eng'
            bot.api.send_message(chat_id: message.chat.id, 
            text: "Hello #{message.from.first_name}! Select the language - 1: Russia, 2: English"
            )
        when '1'
            condition = 'russ'
                bot.api.send_message(
                chat_id: message.chat.id,
                text: "Здравствуйте #{message.from.first_name}!Это волшебный шар когда вы ему что-то пишете он будет отвечать по разному, можете писать ему свои вопросы, а шар ответит на них"
                )

        when '2'
            condition = 'eng'
            bot.api.send_message(
                chat_id: message.chat.id,
                text: "Hello #{message.from.first_name}! This is a magic ball when you write something to him, he will answer in different ways, you can write your questions to him, and the ball will answer them"
                )
        else 
            condition = check(message,latin,cyr)
            if condition == 'eng'
                bot.api.send_message(
                chat_id: message.chat.id,
                text: eng.sample)
            else 
                bot.api.send_message(
                chat_id: message.chat.id,
                text: russ.sample)
            end
        end
    end
end
