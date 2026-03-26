local Signal = {}
Signal.__index = Signal

-- ==========================
-- Constructor
-- =========================

function Signal.new()
    return setmetatable({
        listeners = {},
    }, Signal)
end

-- ==========================
-- Connect 
-- Supports :
-- signal:connect(function)
-- signal:connect(object, method)
-- ==========================

function Signal:connect(a, b)
    local listener = {}

    if b == nil then
        listener.original = a
        listener.callback = a
    else
        listener.original = b
        listener.object = a
        listener.callback = function(...)
            return b(a, ...)
        end
    end

    table.insert(self.listeners, listener)

    local selfSignal = self

    local connection = {}

    function connection:disconnect()
        local listeners = selfSignal.listeners

        for i = 1, #listeners do
            if listeners[i] == listener then
                table.remove(listeners, i)
                break
            end
        end
    end

    return connection
end

-- ==========================
-- Emit
-- ==========================

function Signal:emit(sender , ...)
    local listeners = self.listeners

    local snapshot = {}

    for i = 1, #listeners do
        snapshot[i] = listeners[i]
    end

    for _, listener in ipairs(snapshot) do
        listener.callback(sender, ...)
    end

end

-- ==========================
-- Disconnect by function
-- ==========================

function Signal:disconnect(fn)
    local listeners = self.listeners

    for i = 1, #listeners do
        if listeners[i].original == fn then
            table.remove(listeners, i)
            break
        end
    end
end

-- ==========================
-- Clear all listeners
-- ==========================

function Signal:clear()
    self.listeners = {}
end

return Signal