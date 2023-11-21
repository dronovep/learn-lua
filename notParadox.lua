if not x then x = 25 end
print("by default x = " .. x)
-- выведет 25

x = false;
if not x then x = 36 end
print("After paradox check x = " .. x)
-- выведет 36, парадокса нет