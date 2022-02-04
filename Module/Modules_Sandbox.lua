-- I know the code is bad, forgive me.

local p ={}

local iconTable = {
    ["bili-logo"] = "[[File:Bilibilitv-logo.png|20px|link=]]",
    ["ig-logo"] = "[[File:Instagram_logo.png|20px|link=]]",
    ["nico-logo"] = "[[File:Niconico-2021-black.png|20px|link=]]",
    ["piapro-logo"] = "[[File:Piapro_icon.svg|20px|link=]]",
    ["tweets-logo"] = "[[File:Twitte_Logo.png|20px|link=]]",
    ["youtube-logo"] = "[[File:YouTube Logo icon.png|20px|link=]]"
}

local prefixTable = {
    {prefix = "https://www.bilibili.com/video/" , icon = iconTable["bili-logo"]},
    {prefix = "https://www.instagram.com/tv/" , icon = iconTable["ig-logo"]},
    {prefix = "" , icon = iconTable["ig-logo"]},
    {prefix = "https://www.nicovideo.jp/watch/" , icon = iconTable["nico-logo"]},
    {prefix = "https://piapro.jp/t/", icon = iconTable["piapro-logo"]},
    {prefix = "" , icon = iconTable["tweets-logo"]},
    {prefix = "https://twitter.com/" , icon = iconTable["tweets-logo"]},
    {prefix = "https://t.co/" , icon = iconTable["tweets-logo"]},
    {prefix = "https://youtu.be/" , icon = iconTable["youtube-logo"]}

}

local centralTable = {
    -- center
    prefixTable[1], 
    prefixTable[2],
    prefixTable[3],
    prefixTable[4],
    prefixTable[5],
    prefixTable[6],
    prefixTable[7],
    prefixTable[8],
    prefixTable[9]
    --left
    --right
}

local indexTable = {
    {"bl","bili","bilibili"},
    {"ig","instagram"},
    {"igf","instagramfull"},
    {"nc","nico","niconico"},
    {"pp","piapro"},
    {"tw","tweet","tweets"},
    {"twsc","tweetsc","twittershortcut"},
    {"tws","tweetsh","twittershort"},
    {"yt","youtube"}
}

function p.main(A,B)
    local translatedHeader = findPrefixIndex(A)
    if translatedHeader == false then
        return "Don't have this prefix"
    elseif centralTable[translatedHeader] then
        return "{{plain link |url=" .. centralTable[translatedHeader].prefix .. B.. " " .. centralTable[translatedHeader].icon .. " }}"
    end
end


function findPrefixIndex (inputValue)
for i , x in pairs(indexTable) do
    for j , y in pairs(x) do
        if x[j] == inputValue then
        return i
        end
    end
end
return false
end

return p