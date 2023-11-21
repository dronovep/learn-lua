mvar = 32
local mvar = 64
print(mvar)         -- выведет 64

mvar = 41
do
    local mvar = 56
    print(mvar)     -- выведет 56
end
print(mvar)         -- выведет 41

while i < 35 do         -- это выведет ошибку, так как тут обращение идет еще к глобальной переменной, которая nil
    local i = 24
    print("i = " .. i)
    i = i + 1
end