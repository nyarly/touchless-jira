# Touchless Jira
(aka Touch Less Jira)

Included,
find some glue scripts
for making life with a Github enabled Jira project easier.

## Install

* Add `bin/git-jira-branch` to your PATH somewhere.
  If you don't already have a ~/bin,
  you might consider creating one
  and adding it to your PATH in your shell config

* Add `dot-git/hooks/prepare-commit-msg` to your
  project.
  Better yet, add it to your git template.
  If you don't already have a git template,
  consider creating one
  (see `man git-init` section `TEMPLATE DIRECTORY`)

* For the enlightened, the `fish/` directory
  contains functions and completions to
  make `git jira-branch` nicer to use.
  Beware, they make use of the Java CLI for Jira;
  the python one might be more ergonomic.
  (The benighted may submit PRs with completions for other shells)

## Usage

```
> git jira-branch <JIRA-ID>
```
will tag your current branch with the given id(s).
Thereafter, `git commit` on that branch
will populate the tail of the commit message with those ids,
which is the data Jira needs to tie Github activity
to project triggers.

If you're able to install the completions,
(and configure the functions in *`git`*)

```
git jira-branch <TAB>
```
will complete ids based on the configured JQL.

## Configuration

The _completions_ scripts need git configuration like:

```
[jira]
	user = thatsmyname
	server = https://workplace.atlassian.net
	jarfile = /deep/dark/hole/atlassian-cli-5.3.0/lib/jira-cli-5.3.0.jar
  password = "ohmygoodnessyoustolemypassword"
	jql = project = PROJECT and status not in (Closed, Verify)
```

The recommended way to arrange these configs is:

`~/.config/git/config`
```
[jira]
	user = thatsmyname
	server = https://workplace.atlassian.net
  # password should be in ./secret
[include]
  path = ./secret
```

(this split is mostly about use with a dotfiles repo)
`~/.config/git/secret`
```
[jira]
	jarfile = /deep/dark/hole/atlassian-cli-5.3.0/lib/jira-cli-5.3.0.jar
  password = "ohmygoodnessyoustolemypassword"
```

And because the JQL will vary by project:
`<project>/.git/config`
```
[jira]
	jql = project = PROJECT and status not in (Closed, Verify)
```
(test that in the Jira advanced issue search)
