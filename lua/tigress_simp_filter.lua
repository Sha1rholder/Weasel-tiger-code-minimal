local han_ranges = {
  { first = 0x4E00, last = 0x9FFF },   -- CJK Unified Ideographs
  { first = 0x3400, last = 0x4DBF },   -- Extension A
  { first = 0x20000, last = 0x2A6DF }, -- Extension B
  { first = 0x2A700, last = 0x2B73F }, -- Extension C
  { first = 0x2B740, last = 0x2B81F }, -- Extension D
  { first = 0x2B820, last = 0x2CEAF }, -- Extension E
  { first = 0x2CEB0, last = 0x2EBEF }, -- Extension F
  { first = 0x30000, last = 0x3134F }, -- Extension G
  { first = 0x31350, last = 0x323AF }, -- Extension H
  { first = 0x2EBF0, last = 0x2EE5D }, -- Extension I
  { first = 0xF900, last = 0xFADF },   -- Compatibility Ideographs
  { first = 0x2F800, last = 0x2FA1F }, -- Compatibility Ideographs Supplement
}

local blocked_ranges = {
  { first = 0xE000, last = 0xF8FF },     -- Private Use Area
  { first = 0xF0000, last = 0xFFFFD },   -- Supplementary Private Use Area-A
  { first = 0x100000, last = 0x10FFFD }, -- Supplementary Private Use Area-B
  { first = 0x1F000, last = 0x1FAFF },   -- emoji / symbols blocks
  { first = 0x2600, last = 0x27BF },     -- Misc symbols / dingbats
  { first = 0xFE00, last = 0xFE0F },     -- Variation Selectors
}

local function in_ranges(code, ranges)
  for _, range in ipairs(ranges) do
    if code >= range.first and code <= range.last then
      return true
    end
  end
  return false
end

local function is_han(code)
  return in_ranges(code, han_ranges)
end

local function is_blocked(code)
  return in_ranges(code, blocked_ranges)
end

local function should_bypass(context)
  local input = context.input or ""
  return input:sub(1, 1) == ";"
end

local function allowed_text(text, env)
  for _, code in utf8.codes(text) do
    if is_han(code) then
      if env.charset_db:lookup(utf8.char(code)) == "" then
        return false
      end
    elseif is_blocked(code) then
      return false
    end
  end
  return true
end

local function filter(input, env)
  local context = env.engine.context

  if should_bypass(context) then
    for cand in input:iter() do
      yield(cand)
    end
    return
  end

  for cand in input:iter() do
    if allowed_text(cand.text, env) then
      yield(cand)
    end
  end
end

local function init(env)
  env.charset_db = ReverseDb("build/tigress_simp_charset.reverse.bin")
end

return {
  init = init,
  func = filter,
}
