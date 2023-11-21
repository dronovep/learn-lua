function fact (n)
    if n ~= 0 then
        return n * fact(n - 1);
    else
        return 1
    end
end

--print("Введите число");
--mvar = io.read("*n");
--print(fact(mvar));

m = {}
m.real = 3.4
m.img = 4.3
m['vaka'] = 'kavaka'

m.sum = function (a, b)
    return a + b
end


print(m.sum(3, 2))
print(fact(5))

