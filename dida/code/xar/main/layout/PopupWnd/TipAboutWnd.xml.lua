local tFunHelper = XLGetGlobal("DiDa.FunctionHelper")
local tipUtil = tFunHelper.tipUtil

function OnCreate( self )
	PopupInDeskRight(self)
	SetShowText(self)
end

function OnClickCloseBtn(self)
	local objTree = self:GetOwner()
	local objHostWnd = objTree:GetBindHostWnd()
	objHostWnd:Show(0)
end

function SetShowText(self)
	local objtree = self:GetBindUIObjectTree()
	local objRootLayout = objtree:GetUIObject("root.layout")

	local objVersion = objRootLayout:GetObject("TipAbout.Caption:TipAbout.Version")
	if not objVersion then
		return
	end
	
	local strVersion = tFunHelper.GetDiDaVersion()
	local strText = "版本号 ："..tostring(strVersion).." 正式版"
	objVersion:SetText(strText)
end

function PopupInDeskRight(self)
	local objtree = self:GetBindUIObjectTree()
	local objRootLayout = objtree:GetUIObject("root.layout")
    local templateMananger = XLGetObject("Xunlei.UIEngine.TemplateManager")
	
	local nLayoutL, nLayoutT, nLayoutR, nLayoutB = objRootLayout:GetObjPos()
	local nLayoutWidth = nLayoutR - nLayoutL
	local nLayoutHeight = nLayoutB - nLayoutT
	
	local workleft, worktop, workright, workbottom = tipUtil:GetWorkArea()
	self:Move( workright - nLayoutWidth, workbottom - nLayoutHeight, nLayoutWidth, nLayoutHeight)
	return true
end

