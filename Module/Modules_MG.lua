-- I know the code is bad, forgive me.

local p = {}

local linkAssamble = {
    "", -- 1
    " ",
    "[",
    "]",
    '<span class="">', -- 5
    "</span>",
    '<span class="plainlinks">',
    '<span class="error" style="font-size:smaller;">' -- 8
}


local iconTable = {
    ["bili-logo"] = "[[File:Bilibilitv-logo.png|20px|link=]]",
    ["ig-logo"] = "[[File:Instagram_logo.png|20px|link=]]",
    ["nico-logo"] = "[[File:Niconico-2021-black.png|20px|link=]]",
    ["piapro-logo"] = "[[File:Piapro_icon.svg|20px|link=]]",
    ["tweets-logo"] = "[[File:Twitte_Logo.png|20px|link=]]",
    ["youtube-logo"] = "[[File:YouTube Logo icon.png|20px|link=]]"
}

local prefixTable = {
    ["bilibili"] = {prefix = "https://www.bilibili.com/video/" , icon = iconTable["bili-logo"]},
    ["instagram"] = {prefix = "https://www.instagram.com/tv/" , icon = iconTable["ig-logo"]},
    ["niconico"] = {prefix = "https://www.nicovideo.jp/watch/" , icon = iconTable["nico-logo"]},
    ["piapro"] = {prefix = "https://piapro.jp/t/", icon = iconTable["piapro-logo"]},
    ["twitter"] = {prefix = "https://twitter.com/" , prefix2 = "https://t.co/", ending1 = "/status/" , icon = iconTable["tweets-logo"]},
    ["youtube"] = {prefix = "https://youtu.be/" , icon = iconTable["youtube-logo"]}
}

--[[
    Index Start at 1
]]

local centralTable = {
    -- center
    prefixTable["bilibili"], -- 1
    prefixTable["instagram"],
    prefixTable["instagram"],
    prefixTable["niconico"],
    prefixTable["piapro"], -- 5
    prefixTable["twitter"],
    prefixTable["twitter"],
    prefixTable["twitter"],
    prefixTable["youtube"] -- 9
}

local leftTable = {
    --left
    [10] = prefixTable["bilibili"],
    [11] = prefixTable["instagram"],
    [12] = prefixTable["niconico"],
    [13] = prefixTable["piapro"],
    [14] = prefixTable["twitter"],
    [15] = prefixTable["youtube"],
}

local rightTable = {
    --right
    [16] = prefixTable["bilibili"],
    [17] = prefixTable["instagram"],
    [18] = prefixTable["niconico"],
    [19] = prefixTable["piapro"],
    [20] = prefixTable["twitter"],
    [21] = prefixTable["youtube"],
}

local onlyLogoTable = {
    [22] = prefixTable["bilibili"],
    [23] = prefixTable["instagram"],
    [24] = prefixTable["niconico"],
    [25] = prefixTable["piapro"],
    [26] = prefixTable["twitter"],
    [27] = prefixTable["youtube"],
}

local indexTable = {
    -- Video Link
    {"bl","bili","bilibili"},  -- 1
    {"ig","instagram"},
    {"igf","instagramfull"},
    {"nc","nico","niconico"},
    {"pp","piapro"}, -- 5
    {"tw","tweet","tweets"},
    {"twsc","tweetsc","twittershortcut"},
    {"tws","tweetsh","twittershort"},
    {"yt","youtube"}, -- 9
    -- General Link (Logo on the left)
    {"bl_l","blil_lf","bilibili_left"}, -- 10
    {"ig_l","instagram_lf"},
    {"nc_l","nico_lf","niconico_left"},
    {"pp_l","piapro_left"},
    {"tw_l","tweets_lf","twittersh_left"}, -- 11
    {"yt_l","youtube_left"},
    -- General Link (Logo on the right)
    {"bl_r","blil_rg","bilibili_right"},
    {"ig_r","instagram_rg"},
    {"nc_r","nico_rg","niconico_right"}, -- 15
    {"pp_r","piapro_right"},
    {"tw_r","tweets_rg","twittersh_right"},
    {"yt_r","youtube_right"},
    -- General Link (Logo but button)
    {"bl_c","blil_ct","bilibili_center"},
    {"ig_c","instagram_ct"}, -- 20
    {"nc_c","nico_ct","niconico_center"},
    {"pp_c","piapro_center"},
    {"tw_c","tweets_ct","twittersh_center"},
    {"yt_c","youtube_center"} -- 24
}

local errorMessageTable = {
    ["missingArg_1"] = linkAssamble[8] .. "缺少第<big>1</big>參數,請確認是否已填妥所需資料." .. linkAssamble[6],
    ["missingArg_2"] = linkAssamble[8] .. "缺少第<big>2</big>參數,請確認是否已填妥所需資料." .. linkAssamble[6],
    ["missingArg_3"] =  linkAssamble[8] .."缺少第<big>3</big>參數,請確認是否已填妥所需資料." .. linkAssamble[6],
    ["tooManyArg"] = linkAssamble[8] .."請刪除多餘參數,或檢查第<big>1</big>參數是否錯誤." .. linkAssamble[6]
}

function p.main(frame)
    local argA,argB,argC,argD = frame.arg[1],frame.arg[2],frame.arg[3],frame.arg[4]
    
    if argA == nil then
        return errorMessageTable["missingArg_1"]
    elseif argD ~= nil then
        return errorMessageTable["tooManyArg"]
    else
        return p._main(argA,argB,argC)
    end
end

function p._main(argA,argB,argC)

    local argA = tostring(argA)

    local translatedHeader = p.findPrefixIndex(argA)
    
    if translatedHeader == false then
        -- Default Error Message
        return linkAssamble[8] .. "模板網站代號變數錯誤：<code>" .. argA .. "</code>本模板暫不支持此網站鏈接." .. linkAssamble[6]
    elseif argB == nil then
        return errorMessageTable["missingArg_2"]
    end
    -- Video Link Section
    if centralTable[translatedHeader] then
        local argB,argC = tostring(argB),tostring(argC)
        return p.videoLink(translatedHeader,argB,argC)
    end
    -- Side Logo Section
    if (leftTable[translatedHeader] or rightTable[translatedHeader]) and argC == nil then
        return errorMessageTable["missingArg_3"]
    elseif leftTable[translatedHeader] then
        local argB,argC = tostring(argB),tostring(argC)
        return p.generalLink_leftLogo(translatedHeader,argB,argC)
    elseif rightTable[translatedHeader] then
        local argB,argC = tostring(argB),tostring(argC)
        return p.generalLink_rightLogo(translatedHeader,argB,argC)
    end
    
    -- Center Logo Section
    if onlyLogoTable[translatedHeader] then
        if argC ~= nil then
            return errorMessageTable["tooManyArg"]
        else
            local argB = tostring(argB)
            return p.generalLink_centralLogo(translatedHeader,argB)
        end
    end

end

function p.findPrefixIndex (argA)

    for i , x in pairs(indexTable) do
        for j , y in pairs(x) do
            if x[j] == argA then
                return i
            end
        end
    end
    return false

end

function p.videoLink(translatedHeader,argB,argC)

    if translatedHeader == 7 then -- twittershortcut
        if argC == nil then
            return errorMessageTable["missingArg_3"]
        else
            return linkAssamble[7] .. linkAssamble[3] .. centralTable[translatedHeader].prefix .. argB .. centralTable[translatedHeader].ending1 .. argC .. centralTable[translatedHeader].icon .. linkAssamble[4] .. linkAssamble[6]
        end
    elseif translatedHeader == 8 then
        return linkAssamble[7] .. linkAssamble[3] .. centralTable[translatedHeader].prefix2 .. argB .. centralTable[translatedHeader].icon .. linkAssamble[4] .. linkAssamble[6]
    elseif argC ~= nil then
        return errorMessageTable["tooManyArg"]
    end
    return linkAssamble[7] .. linkAssamble[3] .. centralTable[translatedHeader].prefix .. argB .. linkAssamble[2] .. centralTable[translatedHeader].icon .. linkAssamble[4] .. linkAssamble[6]

end

function p.generalLink_leftLogo(translatedHeader,argB,argC)
    return leftTable[translatedHeader].icon .. linkAssamble[3] .. argB .. linkAssamble[2] .. argC .. linkAssamble[4]
end

function p.generalLink_rightLogo(translatedHeader,argB,argC)
    return linkAssamble[3] .. argB .. linkAssamble[2] .. argC .. rightTable[translatedHeader].icon .. linkAssamble[4]
end

function p.generalLink_centralLogo(translatedHeader,argB)
    return linkAssamble[7] .. argB .. linkAssamble[3] .. onlyLogoTable[translatedHeader].icon .. linkAssamble[6]
end


return p