mobj = {mother = 'Irina', father = 'Pavel', brother = 'Anton', me = 'Zhania'}

print(#mobj)        -- выведет 0
print(mobj.mother)  -- выведет Irina
print(mobj.father)  -- выведет Pavel
print(mobj.brother) -- выведет Anton
print(mobj.me)      -- выведет Zhania

mobj = {}
mobj.mother = 'Irina'
print(#mobj)        -- выведет 0
print(#mobj.mother) -- выведет 5

marr = {}
marr[1] = 'Waka'
marr[2] = 'Gashira'
print(#marr)         -- выведет 2


mobj = {mother = 'Irina', father = 'Pavel', brother = 'Anton', me = 'Zhania'}
mobj[25] = 'kavaka'
print(#mobj)         -- выведет 0


mobj = {mother = 'Irina', father = 'Pavel', brother = 'Anton', me = 'Zhania'}
mobj[25] = 'kavaka'
mobj.mother = 'Irina'
mobj.father = 'Pavel'
mobj.brother = 'Anton'
mobj.me = 'Zhania'
print(#mobj)        -- выведет 0

print(#mobj)         -- выведет 0

marr = { 3, 2, 1, 6 ,7 }
print(#marr)              -- выведет 5
marr[331] = 'vaka'
print(#marr)              -- выведет 5`

marr = { };
marr[1] = 3
marr[2] = 2
marr[3] = 4
marr[4] = 6
marr[5] = 8
marr[6] = 19
print(#marr)    -- выведет 6
marr['vaka'] = 'kavaka'
print(#marr)    -- выведет 6
marr[7] = 244
print(#marr)    -- выведет 7
marr[125] = 144
print(#marr)    -- выведет 7
marr[8] = 113
print(#marr)    -- выведет 8

marr = {}
marr[0] = 'abba'
marr[1] = 'metallica'
marr[2] = 'iron maiden'
print(#marr)                -- выведет 2


marr = {}
marr[34] = 'Abba'
marr[35] = 'Metallica'
marr[36] = 'Iron Maiden'
print(#marr)                -- выведет 0