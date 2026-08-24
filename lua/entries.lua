local entries = {
    { name = "alpha", enabled = true,  value = 12 },
    { name = "beta",  enabled = false, value = 24 },
    { name = "gamma", enabled = true,  value = 48 },
    { name = "delta", enabled = true,  value = 96 },
}

local function print_entries(entries)
    for _, item in ipairs(entries) do
        if item.enabled then
            print(item.name .. ": " .. item.value)
        end
    end
end

local function double_values(entries)
    for _, entry in ipairs(entries) do
        entry.value = entry.value * 2
    end
end

local function find_entry(entries, name)
    for _, entry in ipairs(entries) do
        if entry.name == name then
            return entry
        end
    end

    return nil
end

print_entries(entries)
double_values(entries)

local entry = find_entry(entries, "gamma")

if entry then
    print("Found " .. entry.name)
end
