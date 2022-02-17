["### Parameters", ""]
+ (
  .Parameters
  | to_entries
  | sort_by(.key)
  | map("* __`\(.key)`__ (`\(.value.Type)`): \(.value.Description)")
)
+ ["", "### Resources", ""]
+ (
  .Resources
  | to_entries
  | sort_by(.key)
  | map("* __`\(.key)`__ (`\(.value.Type)`): \(.value.Metadata.Description)")
)
+ ["", "### Outputs", ""]
+ (
  .Outputs
  | to_entries
  | sort_by(.key)
  | map("* __`\(.key)`__: \(.value.Description)")
)
| .[]
| gsub("\n"; " ")
| rtrimstr(" ")
