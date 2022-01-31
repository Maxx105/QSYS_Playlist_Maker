json = require("rapidjson")

-- Controls
local songs = Controls.Songs
local nextSong = Controls.NextSong
local previousSong = Controls.PreviousSong
local submitSongInfo = Controls.SubmitSongInfo
local addName = Controls.AddName
local addTime = Controls.AddTime
local audioPlayerSelect = Controls.AudioPlayerSelect
local listOfSongs = Controls.ListOfSongs
local removeSong = Controls.RemoveSong
local updateSong = Controls.UpdateSong
local allDirectories = Controls.AllDirectories
local allFiles = Controls.AllFiles

local counter = 1
local currentSong = ""
local songsTable = {}
local listboxSongsTable = {}
local components = {}
local audioPlayersTable = {}
local decodedSongs = {}
local directories = {}
local files = {}

function init()
  getJSONDecodedPlaylist()
  populateSongsTable()
  setAudioPlayersTable()
  setAudioPlayerComponent()
  populateDirectories()
  if allDirectories.String ~= nil then
    populateFiles()
  end
end

function setAudioPlayersTable()
  local songString = ""
  components = Component.GetComponents()
  for i, component in ipairs(components) do
    if (component.Type == "audio_file_player") then
      table.insert(audioPlayersTable, component.Name)
    end
  end
  if #audioPlayersTable >= 1 then
    audioPlayerSelect.Choices = audioPlayersTable
    audioPlayerSelect.String = audioPlayerSelect.Choices[1]
      else if #audioPlayersTable == 0 then
      audioPlayerSelect.Choices = {}
      songs.Choices = {}
      listOfSongs.Choices = {}
      audioPlayerSelect.String = "No detected named audio player"
    end
  end
end

function populateSongsTable()
  songsTable = {}
  listboxSongsTable = {}
  songTimes = {}
  for i, song in ipairs(decodedSongs) do 
    table.insert(songsTable, song.name)
    table.insert(listboxSongsTable, i..") "..song.name.." - "..song.time.." seconds")
  end
  songs.Choices = songsTable
  listOfSongs.Choices = listboxSongsTable
end

function getJSONDecodedPlaylist()
  local f = io.open("media/chillMixPlaylists/"..allFiles.String..".json","r")
  if f ~= nil then
    io.input("media/chillMixPlaylists/"..allFiles.String..".json")
    decodedSongs = json.decode(io.read("*a"))
    io.close(f)
    else decodedSongs = {}
  end
end

function handleCounter(numOne, numTwo, op)
  if counter ~= numOne then
    counter = counter + op
    else counter = numTwo
  end
  if json.encode(decodedSongs) ~= '{}' then
    audioPlayer.locate.Value = decodedSongs[counter].time
  end
end

function sortSongs(tbl)
  local sortedTable = {}
  table.sort(tbl, function(a,b) return a.time < b.time end)
  for i, song in ipairs(tbl) do
    table.insert(sortedTable, song)
  end
  return sortedTable
end

function writeFile()
  dir.create("media/chillMixPlaylists")
  io.output("media/chillMixPlaylists/"..allFiles.String..".json")
  io.write(json.encode(sortSongs(decodedSongs)))
  io.close()
  addName.String = ""
  addTime.String = ""
  populateSongsTable()
end

function deleteSong()
  getJSONDecodedPlaylist()
  local position = string.sub(listOfSongs.String, 1, string.find(listOfSongs.String, ")")-1)
  table.remove(decodedSongs, position)
  writeFile()
end

function replaceSong()
  if addName.String ~= "" and addTime.String ~= "" then
    getJSONDecodedPlaylist()
    local position = string.sub(listOfSongs.String, 1, string.find(listOfSongs.String, ")")-1)
    table.remove(decodedSongs, position)
    table.insert (decodedSongs, position, {name = addName.String, time = tonumber(addTime.String)})
    writeFile()
  end
end

function setCurrentSongName()
  for i, song in ipairs(decodedSongs) do
    if audioPlayer.progress.Value >= song.time then
      counter = i
      currentSong = song.name
    end
  end
  songs.String = currentSong
end

function populateDirectories()
  directories = {}
  directory = "media/Audio"
  temp = dir.get(directory)
  for i, audioDir in ipairs(temp) do
    table.insert(directories, audioDir.name..'/')
  end
  allDirectories.Choices = directories
end

function populateFiles()
  files = {}
  file = "media/Audio/"..string.sub(allDirectories.String, 1, -2)
  fileTemp = dir.get(file)
  for i, audioFile in ipairs(fileTemp) do
    table.insert(files, audioFile.name)
  end
  allFiles.Choices = files
end

function setAudioFileStrings()
  if audioPlayer ~= nil then
    allDirectories.String = audioPlayer.directory.String
    allFiles.String = audioPlayer.filename.String
  else
    allDirectories.String = ""
    allFiles.String = ""
  end
end

function setAudioPlayerComponent()
  songs.String=""
  if audioPlayerSelect.String ~= "No detected named audio player" then
    audioPlayer = Component.New(audioPlayerSelect.String)
    audioPlayer.progress.EventHandler = function()
      if json.encode(decodedSongs) ~= '{}' then
        setCurrentSongName()
      end
    end
    audioPlayer.directory.EventHandler = setAudioFileStrings
    audioPlayer.filename.EventHandler = function()
      setAudioFileStrings()
      getJSONDecodedPlaylist()
      populateSongsTable()
      if json.encode(decodedSongs) == '{}' then
        songs.String = ""
      end
    end
    else audioPlayer = nil
  end
  setAudioFileStrings()
  getJSONDecodedPlaylist()
  populateSongsTable()
end

nextSong.EventHandler = function()
  handleCounter(#decodedSongs, 1, 1)
end

previousSong.EventHandler = function()
  handleCounter(1, #decodedSongs, -1)
end

songs.EventHandler = function()
  for i, song in ipairs(decodedSongs) do
    if songs.String == song.name then
      counter = i
    end
  end
  audioPlayer.locate.Value = decodedSongs[counter].time
end

submitSongInfo.EventHandler = function()
  if addName.String ~= "" and addTime.String ~= "" and tonumber(addTime.String) then
    getJSONDecodedPlaylist()
    table.insert(decodedSongs, {name = addName.String, time = tonumber(addTime.String)})
    writeFile()
    else 
      addName.String = ""
      addTime.String = ""
  end
end

audioPlayerSelect.EventHandler = setAudioPlayerComponent
removeSong.EventHandler = deleteSong
updateSong.EventHandler = replaceSong

init()

allDirectories.EventHandler = function()
  populateFiles()
  if audioPlayer ~= nil then
    audioPlayer.directory.String = allDirectories.String
  end
  allFiles.String = allFiles.Choices[1]
end

allFiles.EventHandler = function()
  songs.String = ""
  if audioPlayer ~= nil then
    audioPlayer.filename.String = allFiles.String
  end
  getJSONDecodedPlaylist()
  populateSongsTable()
  audioPlayer.play:Trigger()
end