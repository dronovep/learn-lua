-- таблица - единственная структура данных в Lua, по сути это ассоциативный массив
-- по сути таблица заменяет собой и массивы и списки и даже объекты и т.д.

-- пример использования таблицы как массива
-- в этом случае просто перечисляем для таблицы набор значений через запятую, не указывая явно ключи
-- Lua сам создаст им последовательные числовые ключи, начиная с одного
simpleArrayTable = {3, 7, 1, 21, 15, 43}

-- пройтись по значениям такого массива можно через итератор pairs
for index, value in pairs(simpleArrayTable) do
    print('simpleArrayTable[' .. index .. '] = ' .. value)
end
--[[выведет
simpleArrayTable[1] = 3
simpleArrayTable[2] = 7
simpleArrayTable[3] = 1
simpleArrayTable[4] = 21
simpleArrayTable[5] = 15
simpleArrayTable[6] = 43
]]
-- Как видим, все значения массива четко вывелись в том порядке, в каком мы их записали при создании массива
-- А индексы начинаются с 1


-- Аналогично можно определить массив строковых значений
sestra = 'sister'
stringsArray = {'mother', 'father', sestra, 'brother'}
-- пройдемся и по нему
for index, value in pairs(stringsArray) do
    print('stringsArray[' .. index .. '] = ' .. value)
end
--[[ тут ничего неожиданного, выведет
stringsArray[1] = mother
stringsArray[2] = father
stringsArray[3] = sister
stringsArray[4] = brother
]]

-- также есть специальный оператор взятия длинны '#'
-- как раз работает с массивами
print(#simpleArrayTable)            -- выведет 6
print(#stringsArray)                -- выведет 4


-- к массиву можно обратиться по индексу, по константе или переменной
mindex = 2
print(simpleArrayTable[5])      -- выведет 15
print(stringsArray[mindex])     -- выведет father


-- зададим массив постепенно, просто добавляя элементы один за другим, используя операцию взятия длины
marr = {}
marr[#marr+1] = 'BWM'
marr[#marr+1] = 'Mercedes'
marr[#marr+1] = 'Audi'
for index, value in pairs(marr) do
    print('marr[' .. index .. '] = ' .. value)
end
--[[выведет
marr[1] = BWM
marr[2] = Mercedes
marr[3] = Audi
]]

-- так, напишем ка простенькую функцию для обхода массива и печати его ключ=значение через итератор pairs
function printArray(array)
    for index, value in pairs(array) do
        print('array[' .. index .. '] = ' .. value)
    end
end

-- в массиве можно сделать разрыв, например положи в него пустой элемент nil
marr = {'mother', 'father', nil, 'brother'}
printArray(marr)
--[[выведет
array[1] = mother
array[2] = father
array[4] = brother
]]
-- как видим, итератор pairs пропускает элементы со значением nil и образуется разрыв,
-- после второго элемента выводится четвертый
-- однако 3й пустой элемент все еще доступен для прямого обращения
print(marr[3])      -- выведет nil
print(#marr)        -- выведет 3, nil-элементы не считаются


-- попробуем теперь сделать массив с разрывом не засчет nil элемента, а благодаря прерыванию/скачку в последовательности индексов
marr = {}
marr[#marr+1] = 'Sorento'
marr[#marr+1] = 'Tahoe'
marr[#marr+1] = 'Yukon'
marr[#marr+55] = 'Bugatti'
print(#marr)     -- выведет 3 - внутренний счетчик длинны массива не реагирует на прыжки в индексах, а считает по порядку до первого разрыва
marr[#marr+1] = 'Toyota'
marr[#marr+1] = 'Mitsubishi'
marr[100] = 'Bentley'
marr[#marr+1] = 'X5M'
printArray(marr)
--[[выведет
array[1] = Sorento
array[2] = Tahoe
array[3] = Yukon
array[4] = Toyota
array[5] = Mitsubishi
array[6] = X5M
array[100] = Bentley
array[58] = Bugatti
]]

-- обращение к промежуточным элементам между разрывами даст nil
print(marr[33])     -- выведет nil

-- попробуем сделать разрыв с помощью nil, но задавая массив постепенно
marr = {}
marr[#marr+1] = 'mother'
marr[#marr+1] = 'father'
marr[#marr+1] = nil
marr[#marr+1] = nil
marr[#marr+1] = 'brother'
printArray(marr)
--[[выведет
array[1] = mother
array[2] = father
array[3] = brother
]]
print(#marr)   -- выведет 3

-- Мы видим, что класть пустые элементы nil в массив не имеет смысла
-- такие элементы пропускаются при обходе, а также не учитываются в длинне
-- да в общем-то разрыв как таковому понятию массив и не свойственен


-- попробуем еще начать массив со скачка по индексу
marr = {}
marr[134] = 223
marr[#marr+1] = 'vaka'
marr[#marr+1] = 15
marr[#marr+1] = 43
marr[67] = 43
marr[#marr+1] = 'finish'
print(#marr)                -- выведет 4
printArray(marr)
--[[выведет
array[1] = vaka
array[2] = 15
array[3] = 43
array[4] = finish
array[134] = 223
array[67] = 43
]]

-- Как видим, внутренний счетчик длинны массива учитывает только последовательные индексы начиная с 1
-- А оторванные индексы не учитывает
-- Также при разрывах по индексу возможен неверный порядок обхода массива по индексу в области разрывов (67 следует после 134)

-- Подводя итог по использованию таблицы для массивов - индексы явно не указываем, кроме конструкции взятия длинны + 1
-- пустые nil элементы не кладем в массив
-- Тогда это будет абсолютно стройный и логичный последовательный массив с ожидаемым поведением