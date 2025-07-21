variable "project_name" {
  default = "devops2025"
}

variable "github_repo" {
  default = "https://github.com/yourusername/your-repo"
}

variable "github_token" {
  description = "GitHub Personal Access Token for authentication"
  type        = string
  sensitive   = true  # This marks the variable as sensitive so it won't be shown in logs
}