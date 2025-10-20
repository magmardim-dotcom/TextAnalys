local function Clean(t)
	local file = sys.File('excepts.txt')
  except = fileRead(file)
  
  t = t:gsub('?', '.'); t = t:gsub('!', '.'); t = t:gsub(';', '.'); t = t:gsub(':', '');
	t = t:gsub(',', ''); t = t:gsub('%(', ''); t = t:gsub('%)', ''); t = t:gsub('%=', ''); 
	t = t:gsub('%s%-%s', ' '); t = t:gsub('%s%–%s', ' '); t = t:gsub('%s%—%s', ' ');
	
	local tab = {}
	for w in except:gmatch('[^%,%s]+') do
		tab[#tab+1] = w
	end
  
	for n = 1,#tab do
		t = t:gsub('%s'..tab[n]..'%s', ' ')
	end
	
	return t
end

local analis = function(t, difWord)
  if not t then return false end
    
  local letters_file = sys.File('letters.txt')
  local let = fileRead(letters_file)
  letters = {}
  
  for w in let:gmatch('[^%,%s]+') do
		letters[#letters+1] = w
	end
  
  local logOut = 'Text in: \n'..t.."\n"
	local out = ''
	t = Clean(t)							-- убирает знаки пунктуации; заменяет "!", "?", ";" на "."; !убирает исключения из текста!
	logOut = logOut..'\nAnalys text: \n\n'
	
	local sent = select(2, t:gsub('%.', ''))
	out = out..'Кол-во предложений в тексте: '..sent..'\n'
	logOut = logOut..'Sentences: '..sent..'\n'
	
	local word = {}
	for w in t:gmatch('%S+') do
		word[#word+1] = w
	end
	out = out..'Кол-во слов в тексте: '..#word..'\n'					
	logOut = logOut..'Words: '..#word..'\n'
	
	local dw = {}														
	local lett = 0
	for w = 1,#word do
		local o = 0
		for l = 1,#letters do
			local s = select(2, word[w]:gsub(letters[l], ''))
			lett = lett + s
			o = o + s
		end
		if o >= difWord then dw[#dw+1] = word[w] end 
	end
	out = out..'Кол-во слогов в тексте: '..lett..'\n'
	logOut = logOut..'Letters: '..lett..'\n'
	out = out..'Кол-во сложных слов в тексте: '..#dw..'\n'
	logOut = logOut..'Different words: '..#dw..'\n'
	
	local S = string.format ('%.2f', #word/sent)
	out = out..'Средняя длина предложения: '..S..'\n'
	logOut = logOut..'Sentence length: '..S..'\n'
	
	local W = string.format ('%.2f', lett/#word)
	out = out..'Средняя длина слова: '..W..'\n'
	logOut = logOut..'Word length: '..W..'\n'
	
	local pers = string.format ('%.2f', 100*(#dw/#word))
	out = out..'Процент сложных слов: '..pers..'\n'
	logOut = logOut..'Percent difficult words: '..pers..'\n'
	
	logOut = logOut..'\nWords for analysis:\n'
	for n = 1,#word do logOut = logOut..word[n]..' ' end
	
	logOut = logOut..'\n\nDifferent words:\n'
	for n = 1,#dw do logOut = logOut..dw[n]..' ' end
  
  local fres = 206.835 - (1.52 * (#word/sent)) - (65.14 * (lett/#word))
  out = out..'Индекс удобочитаемости Флеша: '..fres
	
	return out, logOut
end

return analis