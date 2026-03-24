---@diagnostic disable: undefined-global
---@diagnostic disable: lowercase-global
local han_ranges = {
    { first = 0x4E00,  last = 0x9FFF },
    { first = 0x3400,  last = 0x4DBF },
    { first = 0x20000, last = 0x2A6DF },
    { first = 0x2A700, last = 0x2B73F },
    { first = 0x2B740, last = 0x2B81F },
    { first = 0x2B820, last = 0x2CEAF },
    { first = 0x2CEB0, last = 0x2EBEF },
    { first = 0x30000, last = 0x3134F },
    { first = 0x31350, last = 0x323AF },
    { first = 0x2EBF0, last = 0x2EE5D },
    { first = 0xF900,  last = 0xFADF },
    { first = 0x2F800, last = 0x2FA1F },
}

local blocked_ranges = {
    { first = 0xE000,   last = 0xF8FF },
    { first = 0xF0000,  last = 0xFFFFD },
    { first = 0x100000, last = 0x10FFFD },
    { first = 0x1F000,  last = 0x1FAFF },
    { first = 0x2600,   last = 0x27BF },
    { first = 0xFE00,   last = 0xFE0F },
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

local function shared_simp_filter_func(input, env)
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

local function shared_simp_filter_init(env)
    env.charset_db = ReverseDb("build/tigers_simp_charset.reverse.bin")
end

tigers_simp_filter = {
    init = shared_simp_filter_init,
    func = shared_simp_filter_func,
}

tigress_simp_filter = tigers_simp_filter
tiger_simp_filter = tigers_simp_filter
