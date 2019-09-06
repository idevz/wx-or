local _M = {}

function _M.hello(...)
    ngx.say("hello world!")
    ngx.log(ngx.ERR, "---")
    -- error("bad")
end

return _M
