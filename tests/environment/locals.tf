locals {
  workspace_id = "a${substr(replace(uuid(), "-", ""), 1, 23)}"
}
