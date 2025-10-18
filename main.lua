-- подключаем модули
local ui = require "ui"
-- подключаем вспомогательные переменные и методы
local const = require "constants"
-- основное окно
local win=ui.Window("Music",520,380)
-- лэйбел "Имя сохраняемого файла"
local filename_label = ui.Label(win, "Имя сохраняемого файла", 20, 20)
  filename_label.fontsize = DEF_FONT_SIZE
-- кнопка генерации имени
local genName_button = ui.Button(win, "Сгенерировать", 20, 50)
-- строка ввода имени сохраняемого файла
local filename_entry = ui.Entry(win, "", 190, 20, 200)
-- кнопка "Cохранить"
local save_button = ui.Button(win, "Сохранить", 400, 18)
-- сложность определяемых слов
local difword_label = ui.Label(win, "Сложность (кол-во гласных)", 20, 80)
  difword_label.fontsize = DEF_FONT_SIZE
-- кнопки повышения и уменьшения сложности  
local difword_sub_button = ui.Button(win, "◀", 20, 100, 30, 30)
local difword_add_button = ui.Button(win, "▶", 120, 100, 30, 30)
  difword = 3
local difword_number_label = ui.Label(win, difword, 60, 105, 50)
  difword_number_label.fontsize = DEF_FONT_SIZE + 2
  difword_number_label.fontstyle = {bold = true, underline = true}
  difword_number_label.textalign = "center"
-- кнопка "Открыть"
local open_button = ui.Button(win, "Открыть", 20, 140, 130, 30)
-- кнопка "Анализ"
local calculate_button = ui.Button(win, "Анализ текста", 20, 180, 130, 30)
-- лэйбел события
local msg = ""
local msg_label = ui.Label(win, msg, 20, 360)
local function msg_(string)
  if not string then return false end
  msg = string
  msg_label.text = string
  return true
end
-- редактор
local edit = ui.Edit(win, "", 190, 100, 300, 250)


-- событие onClick кнопок:
function save_button:onClick()
  
  if filename_entry.text ~= "" then
    return msg_("журнал сохранён под именем "..filename_entry.text)
  else
    return msg_("журнал не сохранен так как отсутствует имя файла"..filename_entry.text)
  end
end

function genName_button:onClick()
  local string = "log"..os.time()
  filename_entry.text = string
  return true
end

function difword_add_button:onClick()
  local d = difword + 1
  if d <= 13 then -- самое длинное русское слово состоит из 13 слогов
    difword = d
    difword_number_label.text = difword
    return true
  else
    return false
  end
end

function difword_sub_button:onClick()
  local d = difword - 1
  if d > 0 then
    difword = d
    difword_number_label.text = difword
    return true
  else
    return false
  end
end

function calculate_button:onClick()
  
  return msg_("текст проанализирован")
end

function open_button:onClick()
  local file = ui.opendialog("добавить текстовый файл", false, "Text files (*.txt)|*.txt")
  
  if file then
    
    return msg_("файл для анализа открыт")
  else
    
    return msg_("ошибка открытия файла")
  end
end




  
  
  
  
  
  
  
  
ui.run(win):wait()