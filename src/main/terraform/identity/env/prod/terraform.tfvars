prefix    = "mil"
env_short = "p"
env       = "prod"

github_repository_environment_cd = {
  protected_branches     = false
  custom_branch_policies = true
  reviewers_teams = [
    "infrastructure-admins",
    "mil-team",
  ]
}
