-- простейшее определение функции
    function sum(a, b)
        return a + b
    end
    print(sum(3, 2)) -- выведет 5

-- функции можно передать лишние аргументы, они просто отбросятся
    print(sum(1, 2, 3, 4, 5)) -- выведет 3

-- если наоборот передать недостаточно аргументов,
-- то переменные не переданных аргументов получат пустое значение nil
    function printFiveArgs(a, b, c , d, e)
        print(a)
        print(b)
        print(c)
        print(d)
        print(e)
    end

    printFiveArgs(1, 2, 3)
    --[[ выведет
    1
    2
    3
    nil
    nil
    ]]

-- функции могут возвращать несколько значений
-- для примера напишем функцию, которая и складывает и переменожает 2 аргумента
    function sumAndMul(a, b)
        return a + b, a * b
    end

    sum, mul = sumAndMul(6, 7)
    print(sum)  -- выведет 13
    print(mul)  -- выведет 42

    -- в случае, если мы попытаемся взять больше значений, чем функция возвращает,
    -- то лишняя переменная получит nil
    sum, mul, extra = sumAndMul(1, 3)
    print(extra) -- выведет nil

    -- если попытаемся взять меньше значений, то лишнее отбросится
    sum = sumAndMul(3, 4)
    print(sum)  -- выведет 7


    -- а вот интересный пример множественного присваивания, когда переменные получают значения не только от вызываемых функций
    -- когда функция стоит не на последнем месте, то она выдает только первое из своих значений
    sum, mul = sumAndMul(3, 2), 144
    print(sum)  -- выведет 5
    print(mul)  -- выведет 144

    -- когда функция стоит на последнем месте, она выдает все свои значения
    extra, sum, mul = 144, sumAndMul(3, 2)
    print(extra)    -- выведет 144
    print(sum)      -- выведет 5
    print(mul)      -- выведет 6

    -- смешанный случай
    extra, sum, mul = sumAndMul(10, 15), sumAndMul(7, 4)
    print(extra)    -- выведет 25
    print(sum)      -- выведет 11
    print(mul)      -- выведет 28

    -- Когда реузльтаты вызова функции передаются как аргументы в другой вызов функции, применяются аналогичные правила
    printFiveArgs(sumAndMul(1, 3), sumAndMul(2, 4))
    --[[ выведет
    4
    6
    8
    nil
    nil
    ]]

    -- фукнции, возвразщающие несколько значений, в выражениях используют свое первое значение
    function getHelloAndBye()
        return 'Hello', 'Bye'
    end
    print(getHelloAndBye() .. ', world!')  -- выведет Hello, world!

    -- при передаче возвращаемых значений функции в конструктор таблицы,
    -- тоже действует правило последней функции, возвращающей все свои значения
    mtable = {getHelloAndBye(), sumAndMul(1, 3)}
    print(mtable[1])    -- выведет Hello
    print(mtable[2])    -- выведет 4
    print(mtable[3])    -- выведет 3

    -- когда функция возвращает значения другой функции, действуют аналогичные правила
    -- последней функции, возвращающей все значения
    function returnManyValues()
        return getHelloAndBye(), sumAndMul(3, 2), getHelloAndBye()
    end
    w1, w2, w3, w4, w5, w6 = returnManyValues()
    print(w1)   -- выведет Hello
    print(w2)   -- выведет 5
    print(w3)   -- выведет Hello
    print(w4)   -- выведет Bye
    print(w5)   -- выведет nil
    print(w6)   -- выведет nil

    -- количество возвращаемых значений функции можно явно ограничить до одного
    -- обернув вызов функции в круглые скобки
    sum, mul = (sumAndMul(25, 35))
    print(sum)      -- выведет 60
    print(mul)      -- выведет nil

-- Функции с переменным числом аргументов
-- казалось бы, Lua и так умеет обрабатывать переменное число аргументов, отбрасывая лишние и присваивая nil недостающим
-- но явное указание переменности аргументов позволяет работать с аргументами, как с таблицей
    function multiSum(...)
        local sum = 0
        for index, arg in ipairs{...} do
            if type(arg) == 'number' then sum = sum + arg end
        end

        return sum
    end

    print(multiSum(3, 2, 1, 'text', 6, 7)) -- выведет 19

    function printVarargs(...)
        print(type(...))
        print(...)
    end

    printVarargs(3, 2, 1, 6 , 7)
    printVarargs('Vaka', 'Gashira', 'Wipeout')
    printVarargs('Vaka', 2, 'Wipeout')
    printVarargs(1, 'Gashira', 3)

    -- само многоточие, в сущности тоже самое, что и несколько значений, через запятую
    -- можно аналогично применить в выражении
    function passVaragsToGlobals(...)
        a, b, c, d, e = ...
    end
    passVaragsToGlobals(6, 7, 8)
    print(a)        -- выведет 6
    print(b)        -- выведет 7
    print(c)        -- выведет 8
    print(d)        -- выведет nil
    print(e)        -- выведет nil

    -- само многоточие в функции необязательно заменяет весь список аргументов
    -- многоточие является списком "дополнительных" аргументов, а аргументы функции могут состоять, как и из основных, так и из дополнительных
    function printBrandModelAndRest(brand, model, ...)
        print('brand = ' .. brand)
        print('model = ' .. model)
        print(...)
    end

    printBrandModelAndRest('Chevrolet', 'Tahoe', 'V8', '426hp')
    --[[ выведет
    brand = Chevrolet
    model = Tahoe
    V8	426hp
    ]]

-- есть способ передавать в функцию аргументы по именам, а не позиционно
-- это удобно, когда у функции много аргументов и трубно запомнить их позиции
-- в других языках это выглядело бы так printNamedArgs(brand='Porsche', model='Cayenne')
-- В Lua это решается икусственно засчет передачи всего одного аргумента-таблицы, которая в свою очередь содержит именованые поля
function printNamedArgs(args)
    for argName, argValue in pairs(args) do
        print(argName .. ' = ' .. argValue)
    end
end

-- первое, что приходит на ум, это можно вызвать как printNamedArgs({brand='Porsche', model='Cayenne'}) - и это работает
-- мда, вызов обзавелся дополнительными скобками, да и внутри функции работаем по сути не как с несколькими аргументами,
-- а как с одним аргументом-таблицей

-- но Lua позволяет убирать круглые скобки при вызове функции с единственным аргументом-таблицей
printNamedArgs{brand='Porsche', model='Cayenne'}
--[[ выведет
brand = Porsche
model = Cayenne
]]

-- объектно-ориентированный вызов функции
-- o:foo(x)  равносильно o.foo(o, x)

-- функцию можно вызвать без скобок,
-- если у нее всего 1 аргумент и он либо строковая константа, либо конструктор таблицы
    function printSymbol (x)
        print(x)
    end

    printSymbol 'Aer3r' -- выводит Aer3r

    str = 'this is string'
    -- printSymbol str         -- ошибка, не получится вызвать функцию без скобок, так как без скобок указана не строковая константа, а строковая переменная

-- печать таблицы (ассоциативного массива). Для простоты примера полагаем, что таблица имеет всего 1 уровень вложенности
    function printTable(table)
        for key, value in pairs(table) do                   -- обращаю внимание, что итератор pairs выдает ключ-значение в случайном порядке из таблицы
           print('key = ' .. key .. ', value = ' .. value)
        end
    end

    printTable {brand = "Kia", model = "Sorento"}
    -- выводит
            -- key = model, value = Sorento
            -- key = brand, value = Kia

    mtable = {brand = "Kia", model = "Sorento"}
    -- printTable mtable  -- ошибка, не получится вызвать функцию без скобок, так как аргумент - не конструктор таблицы, а переменная таблицы