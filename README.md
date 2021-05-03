# Web SRE Architectural Decision Records (ADRs) Repository

This repository contains some discussion, the approval process, and approved architectural decision records (ADRs) for the Web SRE Team. The original proposal document for this Web SRE ADR repository can be found [here](https://docs.google.com/document/d/1pZlYCyXcZbmQq1O-g4BNJD1uZTjluYKkk7BSu2BwOGU/edit#).

## About

The Web SRE Team set up this ADR repository in order to help consolidate, clarify, and communicate our team's decisions. 

If you're new to ADRs, see a good definition & overview of ADRs here: https://github.com/joelparkerhenderson/architecture_decision_record. Within Mozilla, a number of teams and projects already use ADRs, like the following:
* [Marketing ADRs & Common Infrastructure](https://github.com/mozmeao/infra/)
* [Mozilla FxA ADRs](https://github.com/mozilla/fxa/blob/main/docs/adr)
* [Refractr (application) codebase architectural docs (not ADRs, but similar in thought)](https://github.com/mozilla-it/refractr/blob/main/docs/refractr-architecture.md)

## Scope

The scope of "architectural decisions" here is left intentionally vague, as it can be refined as we try out this ADR approach. 

Ideally, however, the following information is not stored here:
* implementation steps or docs (that should go into Mana with links to/from the ADR here as needed)
* history of systems or extended documentation 
* runbooks themselves (though there could possibly be an ADR on the expectations and templates of a runbook)
* system FAQs & how-tos

## Process

All ADRs are essentially Markdown documents put into the `decisions` directory in this repository, further refined via subdirectories for specific teams (e.g. `websre`) and a `department` directory for decisions made at a SRE department-wide scale. This setup is to easily take expansions if other teams also want to use this repository in the future; for now, the primary ADRs are created and headed for `decisions/websre`.

All ADRs go through a review and approval process that mirrors gitflow, e.g.:

1. Create feature branch off main & add your ADR - as a new markdown document in the correct `decisions` directory & following our ADR template
2. Commit & push your work up to this repository & create a PR against main. Tag the folks whose approval you need for this particular ADR.
    i. For the Web SRE Team, you can use the IT-SE GitHub team as the reviewer.
    ii. Web SRE requires unananimous approval for the ADR to pass;
    iii. The PR should be noted in the correct team channels or meetings to make sure people review. 
3. Review happens against the PR. If any blockers to moving the proposed ADR come up, they're addressed in those same channels / team meeetings and handed off for further refinement before revisiting the PR.
4. Once there is approval, the PR is merged into main and the ADR is considered approved.
5. After the approval, the author should ensure any work tickets related to implementation of this decision exist in the relevant backlogs.

Any new requests for topics to be written up in an ADR can be made as a ticket under this epic: https://jira.mozilla.com/browse/SE-1670

## Template

New ADRs should largely follow the template stored in [TEMPLATE.md](TEMPLATE.md).

## Automation

If desired, you can use [the adr cli](https://github.com/npryce/adr-tools) and the [adr-viewer pip package](https://github.com/mrwilson/adr-viewer) to work with proposals in this repository. 

NB: given our multi-team setup (for possible growth) and [limitations of adr-tools](https://github.com/npryce/adr-tools/issues/48), this repository is setup currently for `adr` to work against `decisions/websre`. If you want to use the adr-tools cli with `decisions/global` or some other team & subdirectory, you need to manually change that `.adr-dir` file. If / when this repository is setup for multiple teams beyond the theoretical, we'll need some simple wrapper or another tool to help switch between ADR team repositories.

Installation:
```
$ brew install adr-tools # see other install methods here: https://github.com/npryce/adr-tools/blob/master/INSTALL.md
$ adr
  usage: adr help COMMAND [ARG] ...
  COMMAND is one of:
  help
  new
  link
  list
  init
  config
  generate
  upgrade-repository
  Run 'adr help COMMAND' for help on a specific command.
$ pip install adr-viewer # used with python 3.9 here
$ adr-viewer --help
  Usage: adr-viewer [OPTIONS]
  
  Options:
    --adr-path TEXT  Directory containing ADR files.  [default: doc/adr/]
    --output TEXT    File to write output to.  [default: index.html]
    --serve          Serve content at http://localhost:8000/
    --help           Show this message and exit.
```

Using adr-tools cli (adr):

### set adr-tools directory for team in question:
See the limitations of adr-tools notation above. You need to change `.adr-dir` to the team you want to work on.
```
$ echo "decisions/websre" > .adr-dir
```

### create new adr proposal for your team:
```
$ adr new My Awesome Web SRE Team ADR
  ./0002-my-awesome-global-adr.md
# then add your info & go
$ vi 0002-my-awesome-global-adr.md
```

### initialize a new team- or group-specific decisions directory:
```
$ adr init decisions/my-new-team
  decisions/my-new-team/0001-record-architecture-decisions.md
$ vi decisions/my-new-team/0001-record-architecture-decisions.md # then add your info & go
$ cp -r decisions/websre/templates decisions/my-new-team # set up custom templates if you like
$ vi decisions/my-new-team/templates/template.md # edit that custom team template
```

### generate whole repository Table of Contents:
```
$ adr generate toc > TOC.md
# need to add some recursion when using more than Web SRE Team decisions.
```

For a cleaner presentation, adr-viewer (a python package) is being considered as part of the CI to generate static files for a website from this repository.

### serve localhost:8000 view of Web SRE ADRs
```
$ adr-viewer --serve --adr-path decisions/websre
  Starting server at http://localhost:8000/
  {server output; cntl + c to exit}
```

This could be used one day to generate HTML to serve via GitHub pages, but currently is just here for exploration.
