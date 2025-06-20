
--==================================================
--=== 0. Cloned functions
--==================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local succ, result = pcall(function()
  return debug.getconstants(clonefunction)
end)
if succ then
  pcall(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper by replacing the clone function!")
    task.wait(1)
  end)
  while true do end
end

local clonefunc = clonefunction(clonefunction) or function(a)
  return a
end

local deletefile = clonefunc(delfile)
local pc = clonefunc(pcall)
local floor = clonefunc(math.floor)
local toNum = clonefunc(tonumber)
local s_byte = clonefunc(string.byte)
local s_char = clonefunc(string.char)
local s_gsub = clonefunc(string.gsub)
local s_sub = clonefunc(string.sub)
local s_find = clonefunc(string.find)
local s_format = clonefunc(string.format)
local s_lower = clonefunc(string.lower)
local o_date = clonefunc(os.date)
local t_insert = clonefunc(table.insert)
local t_concat = clonefunc(table.concat)
local t_unpack = clonefunc(table.unpack)
local t_string = clonefunc(tostring)
local t_create = clonefunc(table.create)
local d_getconstants = clonefunc(debug.getconstants)
local cf = clonefunc(cloneref)
local newcc = clonefunc(newcclosure)
local hf = clonefunc(detourfunction or hookfunction)

local reqm = http_request or request or (syn and syn.request) or httprequest
local req = clonefunc(reqm)

local support, ih, rf = {}
if restorefunction and ishooked then
  support.rfih = true
  ih, rf = clonefunc(ishooked), clonefunc(restorefunction)
end

local CrashUser = newcc(function()
  while true do end
end)

--==================================================
--=== 1. Game Services
--==================================================

local HttpService = cf(game:GetService("HttpService"))
local Players = cloneref(game:GetService("Players"))

--==================================================
--=== 2. Anti-tamper function
--==================================================

if getgenv() == getfenv(0) then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper by doing an enviroment logger")
    task.wait(1)
  end)
  CrashUser()
end

local isHooked = function(func, name)
  local succ, result = pc(function()
    return ishooked(func)
  end)
  if succ and result == true then
    pc(function()
      Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper by hooking the " .. name .." function!")
      task.wait(1)
    end)
    CrashUser()
  end
end

local isReplaced = function(func, name)
  local succ, result = pc(function()
    return d_getconstants(func)
  end)
  if succ then
    pc(function()
      Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper by replacing the " .. name .." function!")
      task.wait(1)
    end)
    CrashUser()
  end
  isHooked(func, name)
end

--// Request
isReplaced(reqm, "request")

-- // Logging
isReplaced(print, "print")
isReplaced(warn, "warn")
isReplaced(error, "error")

--// Table / String
isReplaced(table.unpack, "Table")
isReplaced(string.char, "String")

-- // Other
isReplaced(pcall, "pcall")
isReplaced(newcclosure, "newcclosure")
isReplaced(hookfunction, "hookfunction")
isReplaced(ishooked, "ishooked")
isReplaced(restorefunction, "restorefunction")
isReplaced(debug.getinfo, "debug")
isReplaced(setreadonly, "setreadonly")
isReplaced(setmetatable, "setmetatable")
isReplaced(isreadonly, "only")
isReplaced(task.wait, "wait")

pc(function()
  isReplaced(getfunctionhash, "hash")
end)

local Kry = {}

--==================================================
--=== 3. Self function checking
--==================================================

hookfunction(print, print)

if not type(ishooked) == "function" then
  ishooked = newcclosure(function(...) return false end)
end

if ishooked(print) == false then
  pcall(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to return a false value, 1")
    task.wait()
  end)
else
  succ, er = pc(function()
    restorefunction(print) 
  end)
end

hookfunction(warn, warn)

if ishooked(warn) == false then
  pcall(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to return a false value, 2")
    task.wait()
  end)
else
  succ, er = pc(function()
    restorefunction(warn) 
  end)
end

hookfunction(error, error)

if ishooked(error) == false then
  pcall(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to return a false value, 3")
    task.wait()
  end)
else
  succ, er = pc(function()
    restorefunction(error) 
  end)
end

--==================================================
--=== 3. Encryption functions
--==================================================

local fallbit = {}
if not bit then
	fallbit.band = newcc(function(a, b)
		local res, p = 0, 1
		while a > 0 and b > 0 do
			local afallbit, bfallbit = a % 2, b % 2
			if afallbit == 1 and bfallbit == 1 then
				res = res + p
			end
			a, b, p = math.floor(a / 2), math.floor(b / 2), p * 2
		end
		return res
	end)
	fallbit.bor = newcc(function(a, b)
		local res, p = 0, 1
		while a > 0 or b > 0 do
			local afallbit, bfallbit = a % 2, b % 2
			if afallbit == 1 or bfallbit == 1 then
				res = res + p
			end
			a, b, p = math.floor(a / 2), math.floor(b / 2), p * 2
		end
		return res
	end)
	fallbit.bxor = newcc(function(a, b)
		local res, p = 0, 1
		while a > 0 or b > 0 do
			local afallbit, bfallbit = a % 2, b % 2
			if afallbit ~= bfallbit then
				res = res + p
			end
			a, b, p = math.floor(a / 2), math.floor(b / 2), p * 2
		end
		return res
	end)
	fallbit.bnot = newcc(function(x)
		return 0xFFFFFFFF - x
	end)
	fallbit.lshift = newcc(function(x, n)
		return x * (2 ^ n)
	end)
	fallbit.rshift = newcc(function(x, n)
		return math.floor(x / (2 ^ n))
	end)
end

--// Dependencies
local bit = bit or fallbit
local band, bor, bxor, lshift, rshift = bit.band, bit.bor, bit.bxor, bit.lshift, bit.rshift

--// Binary to byte
local function b2b(byte)
  local bits = {}
  for i = 7, 0, -1 do
    bits[#bits + 1] = (rshift(byte, i) % 2 == 1) and "1" or "0"
  end
  return table.concat(bits)
end

local replacements = {
  ["0"] = "Z", ["1"] = "X", 
  Z = "0", X = "1"
}

--// String to XZ format
local function s2xz(s)
  local len = #s
  local buf = t_create(len * 8)
  local pos = 1
  for i = 1, len do
    local byte = s_byte(s, i)
    for shift = 7, 0, -1 do
      buf[pos] = replacements[band(rshift(byte, shift), 1) == 1 and "1" or "0"]
      pos = pos + 1
    end
  end
  return t_concat(buf)
end

--// Binary to Number
local function bin2num(b)
  local n = 0
  local len = #b
  for i = 1, len, 16 do
    local chunk = s_sub(b, i, i + 15)
      for j = 1, #chunk do
        n = lshift(n, 1) + (s_byte(chunk, j) - 48)
      end
  end
  return n
end

local function xz2s(xz)
  local len = #xz
  local buf = t_create(math.ceil(len / 8))  -- Pre-allocate output buffer
  local byte_idx = 1
  local temp = 0
  local bit_count = 0
  for i = 1, len do
    local char = s_sub(xz, i, i)
    local bit_val = replacements[char] == "1" and 1 or 0
    temp = lshift(temp, 1) + bit_val
    bit_count = bit_count + 1
    if bit_count == 8 then
      buf[byte_idx] = s_char(temp)
      byte_idx = byte_idx + 1
      temp = 0
      bit_count = 0
    end
  end
  return t_concat(buf)
end

--// Caesar cipher
local function caesarCipher(str, shift, encrypt)
  local len = #str
  local buf = t_create(len)
  local mod = encrypt and band or function(a, b) return a end
  for i = 1, len do
    local byte = s_byte(str, i)
    buf[i] = s_char(mod(byte + (encrypt and shift or -shift), 0xFF))
  end
  return t_concat(buf)
end

-- Aliases for clarity
local function caesarEncrypt(str, shift)
  return caesarCipher(str, shift, true)
end

local function caesarDecrypt(str, shift)
  return caesarCipher(str, shift, false)
end

--// Final encryption with Caesar + XZ
local function enc(s)
	return caesarEncrypt(s2xz(s), 7)
end

--// Final decryption with Caesar + XZ
local function dec(r)
	return {
		body = xz2s(caesarDecrypt(r.body or "", 7)),
		statusCode = bin2num(xz2s(caesarDecrypt(r.status_code or "0", 7))),
		headers = HttpService:JSONDecode(xz2s(caesarDecrypt(r.headers or "{}", 7)))
	}
end

--// Generates a Auth-Header
local function generateAuthHeader()
	local utc = os.time(os.date("!*t"))
	local s = t_string(utc)
	local bits = {}
	for i = 1, #s do
		t_insert(bits, b2b(s_byte(s, i)))
	end
	local binary = t_concat(bits)
	local xz = s_gsub(s_gsub(binary, "1", "X"), "0", "Z")
	return caesarEncrypt(xz, 7)
end
--==================================================
--=== 5. UI Text Sanitizer (one-time connect)
--==================================================

local blockedString = "https://hungquan99.xyz/ahs"
local blockedTStrings = {}

local function checkTextObject(object)
	local success, text = pc(function()
		return object.Text
	end)
	if success and typeof(text) == "string" then
		local lowerText = s_lower(text)
		if s_find(lowerText, blockedString, 1, true) then
			object.Text = "[x2zu]: Hmh, attempt to display a URL. Skid"
			return
		end
		for _, blocked in ipairs(blockedTStrings) do
			if string.find(lowerText, blocked, 1, true) then
				object.Text = "[x2zu]: Hmh,blocked content detected."
				return
			end
		end
	end
end

game.DescendantAdded:Connect(function(object)
	checkTextObject(object)
end)

--==================================================
--=== 6. Hardened table of functions
--==================================================

local function decode(t)
  return s_char(t_unpack(t))
end

--[[
local function encode(str)
	local bytes = {}
	for i = 1, #str do
		table.insert(bytes, string.byte(str, i))
	end
	return bytes
end
]]

local encodedStrings = {
  HttpGet = {72,116,116,112,71,101,116},
  HttpPost = {72,116,116,112,80,111,115,116},
  request = {114,101,113,117,101,115,116},
  getVersion = {103,101,116,86,101,114,115,105,111,110},
  Validate = {86,97,108,105,100,97,116,101},
  Secure = {83,101,99,117,114,101},
  kickMsgUnauthorized = {91,65,72,83,93,58,32,85,110,97,117,116,104,111,114,105,122,101,100,32,97,99,99,101,115,115,32,116,111,32,115,101,99,117,114,101,32,102,117,110,99,116,105,111,110},
  kickMsgTamper = {91,65,72,83,93,58,32,65,116,116,101,109,112,116,32,116,111,32,116,97,109,112,101,114,32,119,105,116,104,32,65,72,83},
  kickMsgTamperKey = {91,65,72,83,93,58,32,65,116,116,101,109,112,116,32,116,111,32,116,97,109,112,101,114,32,119,105,116,104,32,65,72,83,44,32},
  kickMsgInvalidOpLT = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,111,112,101,114,97,116,105,111,110,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,60},
  kickMsgInvalidOpLE = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,111,112,101,114,97,116,105,111,110,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,60,61},
  kickMsgInvalidOpConcat = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,111,112,101,114,97,116,105,111,110,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,46,46},
  kickMsgInvalidUnary = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,117,110,97,114,121,32,111,112,101,114,97,116,105,111,110,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,45,118,97,108,117,101},
  kickMsgInvalidAdd = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,97,114,105,116,104,109,101,116,105,99,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,43},
  kickMsgInvalidSub = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,97,114,105,116,104,109,101,116,105,99,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,45},
  kickMsgInvalidMul = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,97,114,105,116,104,109,101,116,105,99,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,42},
  kickMsgInvalidDiv = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,97,114,105,116,104,109,101,116,105,99,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,47},
  kickMsgInvalidPow = {91,65,72,83,93,58,32,73,110,118,97,108,105,100,32,97,114,105,116,104,109,101,116,105,99,32,111,110,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,44,32,94},
  kickMsgLength = {91,65,72,83,93,58,32,65,116,116,101,109,112,116,32,116,111,32,103,101,116,32,108,101,110,103,116,104,32,111,102,32,97,32,112,114,111,116,101,99,116,101,100,32,116,97,98,108,101,33},
  metatableMsg = {91,65,72,83,93,58,32,84,97,109,112,101,114,105,110,103,32,119,105,116,104,32,65,110,116,105,32,72,116,116,112,32,83,112,121,32,105,115,110,39,116,32,97,108,108,111,119,101,100}
}

local Key = {}
local tab, Kry = {}, {}

Kry = setmetatable(tab, {
  __index = function(_, key)
    if key == decode(encodedStrings.HttpGet) then
      return Key.HttpGet
    elseif key == decode(encodedStrings.HttpPost) then
      return Key.HttpPost
    elseif key == decode(encodedStrings.request) then
      return Key.request
    elseif key == decode(encodedStrings.getVersion) then
      return Key.getVersion
    elseif key == decode(encodedStrings.Validate) then
      return setmetatable({}, {
        __index = function(_, subkey)
          if subkey == decode(encodedStrings.Secure) then
            return newcc(function()
              local info = debug.getinfo(2, "S")
              if not info or not info.short_src:find(info.short_src) then
                LocalPlayer:Kick(decode(encodedStrings.kickMsgUnauthorized))
                task.wait(1)
                CrashUser()
              end
              return newcc(function()
                if type(tab) == "table" and type(Kry) == "table" then
                  return true
                else
                  return false
                end
              end)
            end)
          end
        end,
        __metatable = decode(encodedStrings.metatableMsg)
      })
    else
      return nil
    end
  end,
  __mod = function(self, other)
    return 'IsReal'
  end,
  __call = function(_, key)
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgTamper))
      task.wait(1)
    end)
    CrashUser()
  end,
  __eq = function(a, b)
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgTamper))
      task.wait(1)
    end)
    CrashUser()
  end,
  __lt = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidOpLT))
      task.wait(1)
    end)
    CrashUser()
  end,
  __le = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidOpLE))
      task.wait(1)
    end)
    CrashUser()
  end,
  __concat = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidOpConcat))
      task.wait(1)
    end)
    CrashUser()
  end,
  __unm = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidUnary))
      task.wait(1)
    end)
    CrashUser()
  end,
  __add = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidAdd))
      task.wait(1)
    end)
    CrashUser()
  end,
  __sub = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidSub))
      task.wait(1)
    end)
    CrashUser()
  end,
  __mul = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidMul))
      task.wait(1)
    end)
    CrashUser()
  end,
  __div = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidDiv))
      task.wait(1)
    end)
    CrashUser()
  end,
  __pow = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgInvalidPow))
      task.wait(1)
    end)
    CrashUser()
  end,
  __tostring = function()
    return t_string(function() end)
  end,
  __tonumber = function()
    return tonumber(math.huge)
  end,
  __len = function()
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgLength))
      task.wait(1)
    end)
    CrashUser()
  end,
  __pairs = function()
    return function() return nil end, nil, nil
  end,
  __ipairs = function()
    return function() return nil end, nil, nil
  end,
  __newindex = function(_, key, _)
    pc(function()
      LocalPlayer:Kick(decode(encodedStrings.kickMsgTamperKey) .. t_string(key))
      task.wait(1)
    end)
    CrashUser()
  end,
  __metatable = decode(encodedStrings.metatableMsg)
})


local function isSecure()
  local SelfCheck = Kry.Validate.Secure()
  if tab % 2 == 'IsReal' and SelfCheck() == true then
    return true
  else
    return false
  end
end

setreadonly(Kry, true)

--==================================================
--=== 4. StartHook function
--==================================================

local runAntiHook = false

local function StartHook()
	local runAntiHook = true
	task.spawn(function()
		while runAntiHook == true do
			task.wait(1.5)
			local cgc = getgc(true)
			if isSecure() == false then
				pc(function()
					Players.LocalPlayer:Kick("[x2zu]: Detected some Critical functions were hooked!")
					task.wait(1)
				end)
				CrashUser()
			end
			if support.rfih then
				pc(function()
					for i, v in ipairs(CriticalFunctions) do
						local func = getfenv()[v]
						local succ, res = pc(function()
							return ih(func)
						end)
						if succ and res == true then
							pc(function()
								if not (v == "pc" or v == "restorefunction" or v == "ishooked") then
									rf(func)
								else
									pc(function()
										Players.LocalPlayer:Kick("[x2zu]: Detected some Critical functions were hooked!")
										task.wait(1)
									end)
									CrashUser()
								end
							end)
							pc(function()
								Players.LocalPlayer:Kick("[x2zu]: Detected some Critical functions were hooked!")
								task.wait(1)
							end)
							CrashUser()
						end
					end
				end)
			end
			if support.rfih then
				pc(function()
					for i, v in ipairs(HttpFunctions) do
						local func = getfenv()[v]
						local succ, res = pc(function()
							return ih(func)
						end)
						if succ and res == true then
							pc(function()
								rf(func)
							end)
							pc(function()
								Players.LocalPlayer:Kick("[x2zu]: Detected some HTTP/s functions were hooked!")
								task.wait(1)
							end)
							CrashUser()
						end
					end
				end)
			end
		end
	end)
end

--==================================================
--=== 5. HttpRequest
--==================================================

local function HttpRequest(o)
  t_insert(blockedTStrings, o.Url)
  StartHook()
  task.wait(0.1)
	local b = enc(HttpService:JSONEncode(o))
	local s, r = pc(function()
		a = req({
			Url = "https://hungquan99.xyz/ahs",
			Method = "POST",
			Headers = {
			  ["Content-Type"] = "application/json",
			  ["Authentication"] = generateAuthHeader()
			},
			Body = HttpService:JSONEncode({Encrypted = true, Data = b})
		})
		return a
	end)
	print(r.Body)
	if runAntiHook == true then
	  runAntiHook = false
	end
	if s and r then
	  local d
	  local succ, result = pc(function()
	    return HttpService:JSONDecode(r.Body)
	  end)
	  if succ then
	    d = result
	 else
	   d = r.Body
	 end
		local j = dec(d)
		return {Body = j.body, StatusCode = j.statusCode, Headers = j.headers}
	end
end

--==================================================
--=== 6. Kry wrappers
--==================================================

--// HttpGet wrapper
Key.HttpGet = function(u)
	local r = HttpRequest({
		Url = u,
		Method = "GET",
		Headers = {
		  ["User-Agent"] = "KryCore"
		}
	})
	return r.Body
end

-- Simple POST
Key.HttpPost = function(u, h, b)
	return HttpRequest({
		Url = u,
		Method = "POST",
		Headers = h or {
		  ["Content-Type"] = "application/json"},
		Body = HttpService:JSONEncode(b or {})
	})
end

Key.getVersion = function()
  return "Secure - a2.6", "Cheetah"
end

Key.request = HttpRequest

--==================================================
--=== 7. Common tampering checks
--==================================================

local support; support = {}; support.rfih = false

local BannedKeywords = {
  "hungquan99.xyz",
  "/ahs",
  "https://hungquan99.xyz/ahs"
}

local old, old2, old3, old4
local c, c2, writefile_num, appendfile_num, setclipboard_num = 0, 0, 0, 0, 0

pc(function()
  setfenv(writefile, {})
  c = c + 1
end)

if c == 1 then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Integrity check failed, 1")
		task.wait(1)
	end)
	CrashUser()
end

pc(function()
  setfenv(appendfile, {})
  c2 = c2 + 1
end)

if c == 2 then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Integrity check failed, 2")
		task.wait(1)
	end)
	CrashUser()
end

if ishooked and ih(delfile) == true then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper AHS with a hooked delfile")
		task.wait(1)
	end)
	CrashUser()
end

if ishooked and ih(hookfunction) == true then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper AHS with a hooked hookfunction!")
		task.wait(1)
	end)
	CrashUser()
end

local success, result = pc(function()
	return writefile(".a.lua", "a", "Secure")
end)
local Status1 = success and result or false

pc(function()
  delfile(".a.lua")
end)

if not Status1 == true then
  if ishooked and ih(writefile) == true then
    pc(function()
      Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper AHS with a hooked writefile, " .. t_string(Status1))
      task.wait(1)
    end)
    while true do 
      print("[x2zu]: Attempt to tamper with AHS with a hooked writefile, " .. t_string(Status1))
      task.wait(1) 
    end
  end
end

local success, result = pc(function()
	return appendfile("", "", "Secure")
end)

local Status2 = success and result or false
if not Status2 == true then
  if ishooked and ih(appendfile) == true then
    pc(function()
      Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper AHS with a hooked appendfile, " .. Status2)
      task.wait(1)
    end)
    while true do 
      print("[x2zu]: Attempt to tamper with AHS with a hooked appendfile, " .. Status2)
      task.wait(1) 
    end
  end
end

  if ishooked and ih(setclipboard) == true then
    pc(function()
      restorefunction(setclipboard)
    end)
    pc(function()
      old3 = hf(setclipboard, newcclosure(function(content, Auth)
        if Auth == "Secure" then
          return true
        end
        setclipboard_num = setclipboard_num + 1
        if type(content) ~= "string" then
          content = string.lower(t_string(content))
        else
          content = string.lower(content)
        end
        for _, Keyword in ipairs(BannedKeywords) do
          local v = string.lower(Keyword)
          if s_find(content, v) or string.match(content, v) then
            content = "[x2zu]: Attempt to setclipboard a protected URL isnt alloerd"
          end
        end
        return old3(content)
      end))
    end)
  end

old = hf(writefile, newcclosure(function(FileName, FileContent, Auth)
  if Auth == "Secure" then
    return true
  end
  writefile_num = writefile_num + 1
  local name, content = FileName, FileContent
  if type(FileName) ~= "string" then
    name = string.lower(t_string(FileName))
  else
    name = string.lower(FileName)
  end
  if type(FileContent) ~= "string" then
    content = string.lower(t_string(FileContent))
  else
    content = string.lower(FileContent)
  end
  for _, Keyword in ipairs(BannedKeywords) do
    local v = string.lower(Keyword)
    if s_find(name, v) or string.match(name, v) then
      FileName = "renbex-sexy.lua"
    end
    if s_find(content, v) or string.match(content, v) then
      FileContent = "return print('[x2zu]: Attempt to retrive a protected URL!')"
    end
  end
  return old(FileName, FileContent)
end))

pc(function()
  writefile(".test.lua","skibidi")
end)
pc(function()
  delfile(".test")
end)

if writefile_num == 0 then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper using hookfunction!")
		task.wait(1)
	end)
	CrashUser()
end

old2 = hf(appendfile, newcclosure(function(FileName, FileContent, Auth)
  if Auth == "Secure" then
    return true
  end
  appendfile_num = appendfile_num + 1
  local name, content = FileName, FileContent
  if type(FileName) ~= "string" then
    name = string.lower(t_string(FileName))
  else
    name = string.lower(FileName)
  end
  if type(FileContent) ~= "string" then
    content = string.lower(t_string(FileContent))
  else
    content = string.lower(FileContent)
  end
  for _, Keyword in ipairs(BannedKeywords) do
    local v = string.lower(Keyword)
    if s_find(name, v) or string.match(name, v) then
      FileName = "renbex-sexy.lua"
    end
    if s_find(content, v) or string.match(content, v) then
      FileContent = "return print('[x2zu]: Attempt to retrive a protected URL!')"
    end
  end
  return old2(FileName, FileContent)
end))

pc(function()
  writefile(".test.lua","")
end)
pc(function()
  appendfile(".test.lua","skibidi")
end)
pc(function()
  deletefile(".test.lua")
end)

if appendfile_num == 0 then
  pc(function()
    Players.LocalPlayer:Kick("[x2zu]: Attempt to tamper using hookfunction!")
		task.wait(1)
	end)
	CrashUser()
end

old3 = hf(setclipboard, newcclosure(function(content, Auth)
  if Auth == "Secure" then
    return true
  end
  setclipboard_num = setclipboard_num + 1
  if type(content) ~= "string" then
    content = string.lower(t_string(content))
  else
    content = string.lower(content)
  end
  for _, Keyword in ipairs(BannedKeywords) do
    local v = string.lower(Keyword)
    if s_find(content, v) or string.match(content, v) then
      content = "[x2zu]: Attempt to setclipboard a protected URL isnt alloerd"
    end
  end
  return old3(content)
end))

local IsRunning, Fpscap = false, 60
if typeof(getfpscap) == "function" then
	local ok, result = pcall(getfpscap)
	if ok and typeof(result) == "number" then
		Fpscap = result
	end
end

if typeof(get_fps_cap) == "function" then
  local ok, result = pcall(get_fps_cap)
  if ok and typeof(result) == "number" then
    Fpscap = result
  end
end

local Status3 = setfpscap(Fpscap, "Secure") or false
old4 = hf(setfpscap, newcclosure(function(content, Auth)
  if Auth == "Secure" then
    return true
  end
  return old4(content)
end))

--==================================================
--=== 8. Anti-Http Spy
--==================================================

local HttpFunctions = {
  "http_request",
  "http.request",
  "request",
  "httprequest",
  "syn.request"
}, {}

local CriticalFunctions = {
  "ishooked",
  "restorefunction",
  "setmetatable",
  "setreadonly",
  "rawget",
  "pc",
  "table.find"
}

if Status3 == false then
  task.spawn(function()
    while task.wait(1.5) do
      local cgc = getgc(true)
      if isSecure() == false then
        pc(function()
          Players.LocalPlayer:Kick("[x2zu]: Detected some Critical functions were hooked!")
          task.wait(1)
        end)
        CrashUser()
      end
      if support.rfih then
        succ, er = pc(function()
          for i, v in ipairs(CriticalFunctions) do
            local func = getfenv()[v]
            local succ, res = pc(function()
              return ih(func)
            end)
            if succ and res == true then
              pc(function()
                if not v == "pc" or not v == "restorefunction" or not v == "ishooked" then
                  rf(func)
                else
                  pc(function()
                    Players.LocalPlayer:Kick("[x2zu]: Detected some Critical functions were hooked!")
                    task.wait(1)
                  end)
                  CrashUser()
                end
              end)
              pc(function()
                Players.LocalPlayer:Kick("[x2zu]: Detected some Critical functions were hooked!")
                task.wait(1)
              end)
              CrashUser()
            end
          end
        end)
      end
      if support.rfih then
        succ, er = pc(function()
          for i, v in ipairs(HttpFunctions) do
            local func = getfenv()[v]
            local succ, res = pc(function()
              return ih(func)
            end)
            if succ and res == true then
              pc(function()
                rf(func)
              end)
              pc(function()
                Players.LocalPlayer:Kick("[x2zu]: Detected some HTTP/s functions were hooked!")
                task.wait(1)
              end)
              CrashUser()
            end
          end
        end)
      end
    end
  end)
end

--==================================================
--=== 9. Other detection methods
--==================================================

pc(function()
  loadstring(setmetatable({}, {
    __tostring = function()
      return "[x2zu]: Trying to see the contents of loadstring, nice try!"
    end
  }))
end)