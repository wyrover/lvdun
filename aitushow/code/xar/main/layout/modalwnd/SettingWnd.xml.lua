local Helper = XLGetGlobal("Helper")
local Selector = Helper.Selector
function GetMainWndHost()
	return Selector.select("", "", "MainWnd.Instance")
end


function OnCreate(self)
	local HostWnd = GetMainWndHost()
	local l, t, r, b = HostWnd:GetWindowRect()
	local w, h = r-l, b-t
	local _l, _t, _r, _b = self:GetWindowRect()
	local new_l = l + math.floor((w-(_r - _l))/2)
	local new_t = t + math.floor((h-(_b - _t))/2)
	local new_r = new_l + _r - _l
	local new_b = new_t + _b - _t
	self:Move(new_l, new_t, new_r, new_b)
end

function OnShowWindow(self, bVisible)
	
end