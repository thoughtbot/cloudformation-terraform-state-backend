# Contributing to this template

We love pull requests from everyone. By participating in this project, you
agree to abide by the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code ( **no patch is too small** : fix typos, add comments, etc. )
* by refactoring code
* by closing [issues][]
* by reviewing patches

[issues]: https://github.com/thoughtbot/cloudformation-terraform-state-backend/issues

## Submitting an Issue

* We use the [GitHub issue tracker][issues] to track bugs and features.
* Before submitting a bug report or feature request, check to make sure it hasn't
  already been submitted.
* When submitting a bug report, please include a as much detail as possible to
  reproduce the bug, including your region, parameters, etc.

## Cleaning up issues

* Issues that have no response from the submitter will be closed after 30 days.
* Issues will be closed once they're assumed to be fixed or answered. If the
  maintainer is wrong, it can be opened again.
* If your issue is closed by mistake, please understand and explain the issue.
  We will happily reopen the issue.

## Submitting a Pull Request

1. [Fork][fork] the [official repository][repo].
1. [Create a topic branch.][branch]
1. Implement your feature or bug fix.
1. Add, commit, and push your changes.
1. [Submit a pull request.][pr]

## Setting up

1. You will need [cfn-lint] and [cfn-nag].
2. Run `make` to make sure everything is set up.

## Testing your changes

1. Edit the template file.
2. Run `make` to validate your changes.
3. Deploy the stack to a test account to make sure it works.

[cfn-lint]: https://github.com/aws-cloudformation/cfn-lint
[cfn-nag]: https://github.com/stelligent/cfn_nag
[repo]: https://github.com/thoughtbot/cloudformation-terraform-state-backend/tree/main
[fork]: https://help.github.com/articles/fork-a-repo/
[branch]: https://help.github.com/articles/creating-and-deleting-branches-within-your-repository/
[pr]: https://help.github.com/articles/using-pull-requests/
