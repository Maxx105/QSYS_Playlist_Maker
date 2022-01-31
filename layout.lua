table.insert(graphics,{
  Type = "GroupBox",
  Text = "Playlist Maker",
  Fill = {200,200,200},
  StrokeWidth = 1,
  Position = {6,5},
  Size = {303,576},
  CornerRadius = 8
})
table.insert(graphics,{
  Type = "Text",
  Text = "Audio Player:",
  Position = {45,107},
  Size = {82,16},
  FontSize = 12,
  HTextAlign = "Left"
})
table.insert(graphics,{
  Type = "Text",
  Text = "Songs:",
  Position = {45,123},
  Size = {82,16},
  FontSize = 12,
  HTextAlign = "Left"
})
table.insert(graphics,{
  Type = "Text",
  Text = "Directory:",
  Position = {45,139},
  Size = {82,16},
  FontSize = 12,
  HTextAlign = "Left"
})
table.insert(graphics,{
  Type = "Text",
  Text = "File:",
  Position = {45,155},
  Size = {82,16},
  FontSize = 12,
  HTextAlign = "Left"
})
table.insert(graphics,{
  Type = "Text",
  Text = "Name",
  Position = {35,185},
  Size = {167,18},
  FontSize = 12,
  HTextAlign = "Center"
})
table.insert(graphics,{
  Type = "Text",
  Text = "Time",
  Position = {202,185},
  Size = {75,16},
  FontSize = 12,
  HTextAlign = "Center"
})

layout["NextSong"] = {
  PrettyName = "Buttons~Next Song",
  Style = "Button",
  Position = {160,32},
  Size = {50,50},
  Color = {255,255,255},
  UnlinkOffColor = true,
  OffColor = {124,124,124}
}
layout["PreviousSong"] = {
  PrettyName = "Buttons~Previous Song",
  Style = "Button",
  Position = {107,32},
  Size = {50,50},
  Color = {255,255,255},
  UnlinkOffColor = true,
  OffColor = {124,124,124}
}
layout["SubmitSongInfo"] = {
  PrettyName = "Buttons~Add Song",
  Style = "Button",
  Position = {35,219},
  Size = {242,25},
  Color = {255,255,255},
  UnlinkOffColor = true,
  OffColor = {124,124,124}
}
layout["RemoveSong"] = {
  PrettyName = "Buttons~Remove Song",
  Style = "Button",
  Position = {36,514},
  Size = {242,24},
  Color = {255,255,255},
  UnlinkOffColor = true,
  OffColor = {124,124,124},
  FontSize = 14,
  Legend = "Remove"
}
layout["UpdateSong"] = {
  PrettyName = "Buttons~Update Song",
  Style = "Button",
  Position = {36,538},
  Size = {242,24},
  Color = {255,255,255},
  UnlinkOffColor = true,
  OffColor = {124,124,124},
  FontSize = 14,
  Legend = "Replace"
}

layout["AudioPlayerSelect"] = {
  PrettyName = "Text~Audio Player",
  Style = "ComboBox",
  Position = {117,107},
  Size = {149,16}
}
layout["Songs"] = {
  PrettyName = "Text~Songs",
  Style = "ComboBox",
  Position = {117,123},
  Size = {149,16}
}
layout["AllDirectories"] = {
  PrettyName = "Text~Directory",
  Style = "ComboBox",
  Position = {117,139},
  Size = {149,16}
}
layout["AllFiles"] = {
  PrettyName = "Text~File",
  Style = "ComboBox",
  Position = {117,155},
  Size = {149,16}
}

layout["AddName"] = {
  PrettyName = "Text~Song Name",
  Style = "Text",
  Position = {35,203},
  Size = {167,16}
}
layout["AddTime"] = {
  PrettyName = "Text~Song Time",
  Style = "Text",
  Position = {202,203},
  Size = {75,16}
}

layout["ListOfSongs"] = {
  PrettyName = "Text~Song List",
  Style = "ListBox",
  Position = {36,254},
  Size = {242,260}
}

