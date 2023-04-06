resource "local_file" "file" {
  filename = each.value
  content  = "Naveen"
  for_each = toset(var.listoffiles)
}

output "fileout" {
  value     = local_file.file
  sensitive = true
}