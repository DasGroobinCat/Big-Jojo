-- "Zillion Assistant", a LUA script for MESEN 2.0.0
-- created by Big Jojo (Apr 2025)
-- use with Zillion [v1] ROM (Size: 128KB; CRC32: 5718762c)

-- setup SMS Work RAM read function
function readcpu(addr)
  return emu.read(addr, emu.memType.smsDebug, false)
end

-- get emulation state and pull variables from RAM
function printInfo()
  state = emu.getState()
  local code1 = readcpu(0xC1F0)
  local code2 = readcpu(0xC1F1)
  local code3 = readcpu(0xC1F2)
  local code4 = readcpu(0xC1F3)
  local screen = readcpu(0xC11F)
  local xpos = readcpu(0xC324)
  local ypos = readcpu(0xC329)
  local boss = readcpu(0xC3B9)
  local comp = readcpu(0xC1CF)
  local bcards = readcpu(0xC129)
  local scrolling = readcpu(0xC186)
  local secret1 = readcpu(0xC495)
  local secret2 = readcpu(0xC475)
  
-- visibility settings
if screen == 136 --using computer
then BoxColor = 0x8000ff00
floppy = 0xff00ff00
levelup = 0xffffff00
zillion = 0xff000000
textfg = 0xff000000
textbg = 0xff000000
mapf = 0xFF00FF00
mapb = 0xFF000000
card = 0xFF00FFFF
hpbar = 0xffff5500
redcard = 0xFF000000
end

if screen == 137 --pause screen
then BoxColor = 0xff00ff00
floppy = 0xff00ff00
levelup = 0xffffff00
zillion = 0xff000000
textfg = 0xff000000
textbg = 0xff000000
hpbar = 0xffff5500
mapf = 0xFF00FF00
mapb = 0xFF000000
card = 0xFF000000
redcard = 0xff000000
end

if screen == 139 --game screen
then BoxColor = 0xff000000
floppy = 0x8000ff00
levelup = 0x80ffff00
zillion = 0x80ff00ff
textfg = 0x0000FF00
textbg = 0x80000000
hpbar = 0x00ff5500
mapf = 0x0000FF00
mapb = 0x77000000
redcard = 0x80ff0000
card = 0x8000ffff
end

if screen == 130 --demo screen
then BoxColor = 0xff000000
textfg = 0xFF000000
textbg = 0xFF000000
hpbar = 0xffff5500
end

if screen == 129 --title screen
then BoxColor = 0xff000000
textfg = 0xFF000000
textbg = 0xFF000000
mapf = 0xFF000000
mapb = 0xFF000000
hpbar = 0xffff5500
end

if screen == 138 --intro anim
then BoxColor = 0xff000000
textfg = 0xFF000000
textbg = 0xFF000000
mapf = 0xFF000000
mapb = 0xFF000000
hpbar = 0xffff5500
end

if screen == 134 --find character
then BoxColor = 0xff000000
levelup = 0xffffff00
zillion = 0xff000000
redcard = 0xffff0000
textfg = 0xFF000000
textbg = 0xFF000000
mapf = 0xFF000000
mapb = 0xFF000000
hpbar = 0xffff5500
end

if scrolling == 1 --screen scrolling
then floppy = 0xff00ff00
levelup = 0xffffff00
zillion = 0xff000000
redcard = 0xffff0000
textfg = 0xff000000
textbg = 0xff000000
card = 0xff000000
hpbar = 0xff000000
end
  
-- force doors open
if emu.isKeyPressed("Space")
then emu.write(0xC1CD, 08, emu.memType.smsDebug)
end

-- HP meter for BOSS
if xpos == 6 and ypos == 10 --at the boss location
then if screen == 139 --game screen active, not showing pause screen
then if boss ~= 0 --boss is alive
then emu.drawString(32, 64, "HP", textfg, textbg)
emu.drawRectangle(45, 64, 2.2*boss, 8, hpbar, true)
else end
end
end

-- show number of cards when using computer
if screen == 136
then emu.drawString(138, 149, "CARDS: " .. bcards, BoxColor, 0x44000000)
end

-- draw map rows
if ypos == 1 then
emu.drawString(48, 34, "A", mapf, mapb)
elseif ypos == 2 then
emu.drawString(48, 34, "B", mapf, mapb)
elseif ypos == 3 then
emu.drawString(48, 34, "C", mapf, mapb)
elseif ypos == 4 then
emu.drawString(48, 34, "D", mapf, mapb)
elseif ypos == 5 then
emu.drawString(48, 34, "E", mapf, mapb)
elseif ypos == 6 then
emu.drawString(48, 34, "F", mapf, mapb)
elseif ypos == 7 then
emu.drawString(48, 34, "G", mapf, mapb)
elseif ypos == 8 then
emu.drawString(48, 34, "H", mapf, mapb)
elseif ypos == 9 then
emu.drawString(48, 34, "I", mapf, mapb)
elseif ypos == 10 then
emu.drawString(48, 34, "J", mapf, mapb)
elseif ypos == 11 then
emu.drawString(48, 34, "K", mapf, mapb)
elseif ypos == 12 then
emu.drawString(48, 34, "L", mapf, mapb)
elseif ypos == 13 then
emu.drawString(48, 34, "M", mapf, mapb)
elseif ypos == 14 then
emu.drawString(48, 34, "N", mapf, mapb)
elseif ypos == 15 then
emu.drawString(48, 34, "O", mapf, mapb)
elseif ypos == 16 then
emu.drawString(48, 34, "P", mapf, mapb)
elseif ypos == 0 then
emu.drawString(18, 34, "Surface", mapf, mapb)
else end

-- draw map columns
if xpos == 0 then
emu.drawString(55, 34, "1", mapf, mapb)
elseif xpos == 1 then
emu.drawString(55, 34, "2", mapf, mapb)
elseif xpos == 2 then
emu.drawString(55, 34, "3", mapf, mapb)
elseif xpos == 3 then
emu.drawString(55, 34, "4", mapf, mapb)
elseif xpos == 4 then
emu.drawString(55, 34, "5", mapf, mapb)
elseif xpos == 5 then
emu.drawString(55, 34, "6", mapf, mapb)
elseif xpos == 6 then
emu.drawString(55, 34, "7", mapf, mapb)
elseif xpos == 7 then
emu.drawString(55, 34, "8", mapf, mapb)
else end

-- special item highlighting
if xpos == 7 and ypos == 2
then emu.drawString(96, 28, "CYAN = CARD", textfg, textbg)
emu.drawRectangle(224, 177, 16, 32, card, true)
end

if xpos == 7 and ypos == 1
then emu.drawString(96, 28, "CYAN = CARD", textfg, textbg)
emu.drawRectangle(208, 176, 16, 32, card, true)
end

if xpos == 1 and ypos == 2
then if boss ~= 0
then emu.drawString(4, 128, "DESTRUCTABLE", textfg, textbg)
emu.drawString(28, 138, "WALL", textfg, textbg)
emu.drawRectangle(8, 112, 7*boss, 8, hpbar, true)
end
end

if xpos == 0 and ypos == 1
then if secret2 ~= 0
then emu.drawString(20, 188, "HIDDEN", textfg, textbg)
emu.drawString(20, 198, "BREAD >", textfg, textbg)
emu.drawRectangle(8, 178, 6*secret2, 8, hpbar, true)
end
end

if xpos == 0 and ypos == 2
then emu.drawString(96, 28, "YELLOW = LEVEL UP", textfg, textbg)
emu.drawRectangle(144, 48, 16, 32, levelup, true)
emu.drawRectangle(160, 48, 16, 32, card, true)
end

if xpos == 2 and ypos == 1
then emu.drawRectangle(96, 48, 16, 32, card, true)
end

if xpos == 3 and ypos == 1
then emu.drawRectangle(64, 81, 16, 32, card, true)
emu.drawRectangle(128, 113, 16, 32, card, true)
emu.drawRectangle(176, 145, 16, 32, card, true)
end

if xpos == 5 and ypos == 1
then emu.drawString(96, 28, "PURPLE = GUN UPGRADE", textfg, textbg)
emu.drawRectangle(16, 80, 16, 32, zillion, true)
emu.drawRectangle(48, 112, 16, 32, levelup, true)
emu.drawRectangle(176, 48, 16, 32, levelup, true)
emu.drawRectangle(224, 176, 16, 32, card, true)
emu.drawRectangle(32, 112, 16, 32, card, true)
if secret1 ~=0 then emu.drawString(172, 125, "SHOOT WALL >", textfg, textbg)
emu.drawRectangle(172, 112, 9*secret1, 8, hpbar, true)
end
end


if xpos == 5 and ypos == 3
then emu.drawRectangle(160, 48, 16, 32, card, true)
emu.drawRectangle(192, 48, 16, 32, card, true)
emu.drawString(96, 28, "SUICIDE MESSAGE", textfg, textbg)
end

if xpos == 2 and ypos == 3
then emu.drawRectangle(16, 48, 16, 32, card, true)
end

if xpos == 3 and ypos == 3
then emu.drawString(96, 28, "YELLOW = LEVEL UP", textfg, textbg)
emu.drawRectangle(16, 80, 16, 32, levelup, true)
end

if xpos == 1 and ypos == 4
then emu.drawString(96, 28, "GREEN = FLOPPY DISK", textfg, textbg)
emu.drawString(96, 38, "SUICIDE MESSAGE", textfg, textbg)
emu.drawRectangle(88, 48, 16, 32, floppy, true)
emu.drawRectangle(224, 112, 16, 32, levelup, true)
end

if xpos == 2 and ypos == 4
then emu.drawRectangle(208, 48, 16, 32, levelup, true)
end

if xpos == 4 and ypos == 4
then emu.drawRectangle(224, 177, 16, 32, card, true)
emu.drawRectangle(112, 48, 16, 32, card, true)
emu.drawString(96, 28, "EXPLODE MESSAGE", textfg, textbg)
end

if xpos == 5 and ypos == 4
then emu.drawRectangle(16, 113, 16, 32, card, true)
end

if xpos == 4 and ypos == 6
then emu.drawString(96, 28, "FLOPPY DISK!", textfg, textbg)
emu.drawRectangle(224, 112, 16, 32, floppy, true)
end

if xpos == 5 and ypos == 5
then emu.drawRectangle(16, 176, 16, 32, levelup, true)
emu.drawRectangle(128, 176, 16, 32, card, true)
end

if xpos == 7 and ypos == 5
then emu.drawRectangle(208, 48, 16, 32, card, true)
emu.drawRectangle(192, 176, 16, 32, card, true)
end

if xpos == 7 and ypos == 6
then emu.drawRectangle(16, 113, 16, 32, card, true)
end

if xpos == 7 and ypos == 8
then emu.drawRectangle(144, 48, 16, 32, card, true)
end

if xpos == 6 and ypos == 8
then emu.drawRectangle(128, 113, 16, 32, card, true)
end

if xpos == 5 and ypos == 8
then emu.drawRectangle(80, 113, 16, 32, card, true)
emu.drawRectangle(160, 113, 16, 32, card, true)
end

if xpos == 5 and ypos == 9
then emu.drawRectangle(16, 48, 16, 32, card, true)
emu.drawString(96, 28, "EXPLODE MESSAGE", textfg, textbg)
end

if xpos == 6 and ypos == 6
then emu.drawRectangle(224, 48, 16, 32, card, true)
end

if xpos == 3 and ypos == 6
then emu.drawRectangle(112, 113, 16, 32, card, true)
end

if xpos == 3 and ypos == 5
then emu.drawRectangle(112, 113, 16, 32, card, true)
end


if xpos == 6 and ypos == 7
then emu.drawRectangle(176, 112, 16, 32, levelup, true)
end

if xpos == 5 and ypos == 7
then emu.drawRectangle(192, 112, 16, 32, levelup, true)
emu.drawRectangle(224, 48, 16, 32, card, true)
end

if xpos == 4 and ypos == 7
then emu.drawRectangle(16, 48, 16, 32, card, true)
emu.drawRectangle(224, 48, 16, 32, card, true)
end

if xpos == 3 and ypos == 7
then emu.drawRectangle(64, 176, 16, 32, card, true)
emu.drawString(96, 28, "SUICIDE MESSAGE", textfg, textbg)
end

if xpos == 3 and ypos == 8
then emu.drawRectangle(16, 48, 16, 32, card, true)
emu.drawRectangle(224, 48, 16, 32, card, true)
end

if xpos == 2 and ypos == 8
then if boss ~= 0
then emu.drawString(132, 128, "DESTRUCTABLE", textfg, textbg)
emu.drawString(154, 138, "WALL", textfg, textbg)
emu.drawRectangle(132, 112, 2.5*boss, 8, hpbar, true)
end
end

if xpos == 2 and ypos == 6
then if boss ~= 0
then emu.drawString(132, 128, "DESTRUCTABLE", textfg, textbg)
emu.drawString(154, 138, "WALL", textfg, textbg)
emu.drawRectangle(132, 112, 5*boss, 8, hpbar, true)
end
end

if xpos == 0 and ypos == 6
then if secret2 ~= 0
then emu.drawString(132, 176, "< SHOOT HIDDEN BREAD", textfg, textbg)
emu.drawRectangle(132, 166, 14*secret2, 8, hpbar, true)
end
end

if xpos == 1 and ypos == 5
then emu.drawRectangle(192, 113, 16, 32, card, true)
emu.drawString(96, 28, "EXPLODE MESSAGE", textfg, textbg)
end

if xpos == 1 and ypos == 6
then emu.drawRectangle(16, 48, 16, 32, card, true)
end

if xpos == 1 and ypos == 7
then emu.drawRectangle(64, 113, 16, 32, card, true)
end

if xpos == 7 and ypos == 9
then emu.drawString(96, 28, "SUICIDE MESSAGE", textfg, textbg)
emu.drawRectangle(192, 48, 32, 32, levelup, true)
end

if xpos == 3 and ypos == 9
then emu.drawRectangle(160, 176, 16, 32, card, true)
end

if xpos == 1 and ypos == 9
then emu.drawString(96, 28, "FLOPPY DISK!", textfg, textbg)
emu.drawRectangle(224, 176, 16, 32, levelup, true)
emu.drawRectangle(224, 112, 16, 32, floppy, true)
emu.drawRectangle(192, 176, 16, 32, zillion, true)
end

if xpos == 1 and ypos == 13
then emu.drawString(36, 180, "EMPTY", textfg, textbg)
end

if xpos == 0 and ypos == 14
then if boss ~= 0
then emu.drawString(132, 128, "DESTRUCTABLE", textfg, textbg)
emu.drawString(154, 138, "WALL", textfg, textbg)
emu.drawRectangle(132, 150, 1.4*boss, 8, hpbar, true)
end
end

if xpos == 1 and ypos == 16
then if boss ~= 0
then emu.drawString(184, 128, "DESTRUCTABLE", textfg, textbg)
emu.drawString(210, 138, "WALL", textfg, textbg)
emu.drawRectangle(196, 150, 2.4*boss, 8, hpbar, true)
end
end

if xpos == 1 and ypos == 11
then emu.drawRectangle(208, 177, 16, 32, levelup, true)
emu.drawRectangle(16, 112, 16, 32, levelup, true)
emu.drawRectangle(224, 177, 16, 32, card, true)
emu.drawRectangle(192, 177, 16, 32, card, true)
end

if xpos == 2 and ypos == 16
then emu.drawRectangle(48, 48, 16, 32, levelup, true)
emu.drawRectangle(128, 120, 16, 32, card, true)
end

if xpos == 2 and ypos == 15
then emu.drawRectangle(128, 176, 16, 32, levelup, true)
end

if xpos == 1 and ypos == 14
then emu.drawRectangle(16, 48, 16, 32, levelup, true)
emu.drawRectangle(112, 176, 16, 32, zillion, true)
emu.drawRectangle(192, 176, 16, 32, card, true)
emu.drawRectangle(48, 176, 16, 32, card, true)
end

if xpos == 3 and ypos == 14
then emu.drawRectangle(176, 176, 16, 32, card, true)
end

if xpos == 4 and ypos == 13
then emu.drawRectangle(144, 176, 16, 32, card, true)
end

if xpos == 4 and ypos == 14
then emu.drawRectangle(16, 48, 16, 32, card, true)
end

if xpos == 6 and ypos == 15
then emu.drawRectangle(16, 112, 16, 32, levelup, true)
end

if xpos == 6 and ypos == 13
then emu.drawString(96, 28, "RED CARD!!!", textfg, textbg)
emu.drawString(96, 38, "SUICIDE MESSAGE", textfg, textbg)
emu.drawRectangle(224, 48, 16, 32, redcard, true)
emu.drawRectangle(160, 177, 16, 32, levelup, true)
end

if xpos == 7 and ypos == 3
then if scrolling ~= 1
then emu.drawString(90, 102, string.char(32, 82, 69, 83, 84, 32, 73, 78, 32, 80, 69, 65, 67, 69, 32), 0x00 .. math.random(1, 255) .. math.random(1, 255) .. math.random(1, 255))
emu.drawString(38, 116, string.char(32, 87, 69, 70, 32, 49, 57, 51, 57, 45, 50, 48, 50, 53, 32, 38, 32, 74, 71, 70, 32, 49, 57, 53, 55, 45, 50, 48, 49, 55, 32), 0x00FFFF00, 0x00000000)
end
end

if xpos == 6 and ypos == 14
then emu.drawRectangle(208, 112, 16, 32, zillion, true)
emu.drawString(96, 28, "EXPLODE MESSAGE", textfg, textbg)
end

if xpos == 5 and ypos == 14
then emu.drawString(96, 28, "FLOPPY DISK!", textfg, textbg)
emu.drawRectangle(224, 176, 16, 32, floppy, true)
emu.drawRectangle(224, 113, 16, 32, card, true)
end

if xpos == 1 and ypos == 12
then emu.drawRectangle(48, 48, 16, 32, levelup, true)
emu.drawRectangle(208, 112, 16, 32, levelup, true)
emu.drawRectangle(224, 112, 16, 32, card, true)
emu.drawRectangle(80, 48, 16, 32, card, true)
end

if xpos == 3 and ypos == 12
then emu.drawRectangle(16, 48, 16, 32, card, true)
emu.drawRectangle(112, 48, 16, 32, card, true)
end

if xpos == 3 and ypos == 11
then emu.drawRectangle(80, 80, 16, 32, card, true)
end

if xpos == 4 and ypos == 11
then emu.drawRectangle(128, 176, 16, 32, card, true)
end

if xpos == 4 and ypos == 10
then emu.drawRectangle(32, 48, 16, 32, card, true)
emu.drawString(96, 28, "EXPLODE MESSAGE", textfg, textbg)
end

if xpos == 2 and ypos == 11
then emu.drawRectangle(144, 80, 16, 32, card, true)
end

if xpos == 2 and ypos == 12
then emu.drawRectangle(16, 48, 16, 32, zillion, true)
end

if xpos == 4 and ypos == 12
then emu.drawRectangle(224, 176, 16, 32, levelup, true)
emu.drawRectangle(80, 176, 16, 32, card, true)
end

if xpos == 6 and ypos == 11
then emu.drawRectangle(80, 176, 16, 32, levelup, true)
end

if xpos == 5 and ypos == 11
then emu.drawRectangle(80, 112, 16, 32, zillion, true)
end

if xpos == 5 and ypos == 15
then emu.drawRectangle(32, 176, 16, 32, card, true)
end

if xpos == 5 and ypos == 12
then emu.drawRectangle(192, 113, 16, 32, card, true)
end

if xpos == 5 and ypos == 13
then emu.drawRectangle(16, 48, 16, 32, card, true)
end

if xpos == 2 and ypos == 10
then emu.drawRectangle(112, 112, 16, 32, levelup, true)
emu.drawRectangle(128, 176, 16, 32, card, true)
end

if xpos == 1 and ypos == 10
then emu.drawRectangle(112, 112, 16, 32, levelup, true)
emu.drawRectangle(112, 177, 16, 32, levelup, true)
emu.drawRectangle(160, 145, 16, 32, card, true)
emu.drawString(96, 28, "SUICIDE MESSAGE", textfg, textbg)
end

if xpos == 3 and ypos == 13
then emu.drawRectangle(192, 113, 16, 32, card, true)
end

if xpos == 4 and ypos == 15
then emu.drawRectangle(224, 176, 16, 32, card, true)
end

if xpos == 3 and ypos == 10
then emu.drawString(96, 28, "FLOPPY DISK!", textfg, textbg)
emu.drawRectangle(32, 48, 16, 32, floppy, true)
emu.drawRectangle(80, 176, 16, 32, card, true)
end

-- hide password if using main computer
if comp == 1 then
BoxColor = 0xff000000
end

-- password box drawing functions
function drawSingle()
  return emu.drawRectangle(168, 177, 16, 14, BoxColor, true)
end
function drawMap()
  return emu.drawRectangle(24, 177, 16, 14, BoxColor, true)
end
function drawHeart()
  return emu.drawRectangle(40, 177, 16, 14, BoxColor, true)
end
function drawJar()
  return emu.drawRectangle(56, 177, 16, 14, BoxColor, true)
end
function drawCow()
  return emu.drawRectangle(72, 177, 16, 14, BoxColor, true)
end
function drawBottle()
  return emu.drawRectangle(88, 177, 16, 14, BoxColor, true)
end
function drawButterfly()
  return emu.drawRectangle(104, 177, 16, 14, BoxColor, true)
end
function drawScrew()
  return emu.drawRectangle(120, 177, 16, 14, BoxColor, true)
end
function drawDouble()
  return emu.drawRectangle(136, 177, 16, 14, BoxColor, true)
end
function drawFist()
  return emu.drawRectangle(152, 177, 16, 14, BoxColor, true)
end

-- password finder
if code1 == 0
then drawSingle()
elseif code2 == 0
then drawSingle()
elseif code3 == 0
then drawSingle()
elseif code4 == 0
then drawSingle()
else end

if code1 == 1
then drawMap()
elseif code2 == 1
then drawMap()
elseif code3 == 1
then drawMap()
elseif code4 == 1
then drawMap()
else end

if code1 == 2
then drawHeart()
elseif code2 == 2
then drawHeart()
elseif code3 == 2
then drawHeart()
elseif code4 == 2
then drawHeart()
else end

if code1 == 3
then drawJar()
elseif code2 == 3
then drawJar()
elseif code3 == 3
then drawJar()
elseif code4 == 3
then drawJar()
else end

if code1 == 4
then drawCow()
elseif code2 == 4
then drawCow()
elseif code3 == 4
then drawCow()
elseif code4 == 4
then drawCow()
else end

if code1 == 5
then drawBottle()
elseif code2 == 5
then drawBottle()
elseif code3 == 5
then drawBottle()
elseif code4 == 5
then drawBottle()
else end

if code1 == 6
then drawButterfly()
elseif code2 == 6
then drawButterfly()
elseif code3 == 6
then drawButterfly()
elseif code4 == 6
then drawButterfly()
else end

if code1 == 7
then drawScrew()
elseif code2 == 7
then drawScrew()
elseif code3 == 7
then drawScrew()
elseif code4 == 7
then drawScrew()
else end

if code1 == 8
then drawDouble()
elseif code2 == 8
then drawDouble()
elseif code3 == 8
then drawDouble()
elseif code4 == 8
then drawDouble()
else end

if code1 == 9
then drawFist()
elseif code2 == 9
then drawFist()
elseif code3 == 9
then drawFist()
elseif code4 == 9
then drawFist()
else end

end
--Register some code (printInfo function) that will be run at the end of each frame
emu.addEventCallback(printInfo, emu.eventType.endFrame);

--Display a startup message
emu.displayMessage("Zillion Assistant by Big Jojo", "Space Bar Forces Door Open")