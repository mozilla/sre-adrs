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

If desired, you can use [the adr cli](https://github.com/npryce/adr-tools) to work with proposals in this repository.

Some examples:

```
# create a new adr from the template:
$ adr new My New ADR
# generate a TOC in markdown to go into TOC.md
$ adr generate toc > TOC.md
```

For a cleaner presentation, adr-viewer (a python package) is being considered as part of the CI to generate static files for a website from this repository.
