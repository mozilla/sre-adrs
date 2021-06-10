# 4. Use 1 Kubernetes Cluster Per Environment

Date: 2021-06-09
Scope: Web SRE Team

## Status

Proposed

## Context

We need to have multiple environments (sometimes called tiers) for Web SRE Services. These environments generally serve different purposes & audiences, and can have different uptime requirements. Environments can optionally serve as required points in the path towards the production environment. 

At Mozilla, our service environments generally include Development (Dev), Staging (Stage), and Production (Prod). There can sometimes also be a Testing environment (usually ephemeral). Generally, these environments are in the same infrastructure provider account, and differ at the infrastructure or application platform level (e.g. at the Kubernetes level) - with the exception of Testing, which tends to be ephemeral within a particular context (e.g. a docker-compose spin up or a kind cluster in a CI pipeline).

There are multiple ways that we differentiate these persistent (dev, stage, prod) environments on our infrastructure and application platforms. Within a Kubernetes context, some common patterns for separating persistent environments are:
1. Having a distinct Kubernetes cluster per environment;
2. Having one namespace per environment in a shared Kubernetes cluster;
3. Having distinct node pool(s) per environment within a single cluster along with using selectors, taints, and tolerations.

## Decision

For Web SRE Services persistent environments - dev, stage, prod - that are Kubernetes-based, we will:
* Use a distinct Kubernetes cluster per environment (dev, stage, prod) within the same infrastructure account;
* Use a distinct Kubernetes namespace within each cluster per application;
* Deploy applications to these distinct clusters as relevant to the expected application environment (e.g. applications should deploy to the stage cluster, prod applications should deploy to the prod cluster, etc.);
* Deploy operationals & infrastructure changes & upgrades to these distinct clusters, specifically moving changes from stage to prod within an appropriate timeframe, with an end goal of keeping stage and prod clusters in close alignment;
* Development clusters availability and uptime expectations (of the application or the infrastructure) does not include support outside of business hours;
* Development clusters can optionally include automatic infrastructure or platform updates, as a first place to review these changes and their effects;
* Only use reviewed & approved, production-ready stable application & infrastructure releases on the Production cluster;
* Only use reviewed & approved, stable infrastructure releases on the Stage cluster, and deploy those infrastructure changes when able to relatively quickly move the changes from stage into prod to avoid divergent results from staging and production applications.

This ADR does not include the following:
* How the applications within each cluster name their namespaces (e.g. keeping "discourse_prod" namespace in a production cluster is redundent, but also very explicit, and is left up to the SREs working on the service);
* An immediate push to migrate all existing services to this pattern, as it will cause a lot of churn. Instead, this should be used going forward when doing migrations or starting new services;
* Explicit declarations on SLOs, SLAs, or uptime guarantees on these environment clusters beyond the declaration that Development clusters do not have round-the-clock uptime guarantees to make space for more frequent platform and application changes there;
* Any expectation on multi-tenant clusters versus single-tenant clusters; the pattern for environments should apply in either case;
* An expectation that a development cluster exists - this is left up to a service's need(s) and SREs' determination;
* Decisions on approaches to non-peristent clusters, e.g. Testing environments;
* Decisions on how to implement 1 cluster per environment, e.g. it can follow the itse-apps-*-1 implementation or some other approach as the SRE sees fit.

## Consequences

Pros:
* We have a pattern that supports a meaningful & separate staging environment, especially for infrastructure changes where testing their impact on applications is trickier in cases where dev, staging, and prod applications all live in the production cluster;
* There is a clearer boundary between environments within the infrastructure;

Cons:
* There will need to be work to bring our current services into alignment, including a fair amount of migrations and infrastructure updates, hence the decision above that this ADR is considered a pattern to involve when creating a new service or performing a migration;
* Admin or Developer+ users of the Kubernetes clusters will have to hop between clusters to compare environment states, logs, etc. This is mitigated somewhat by Kubernetes command line tooling, though.

## Resources

* itse-apps-prod-1 cluster implementation: https://github.com/mozilla-it/itse-apps-prod-1-infra
* itse-apps-stage-1 cluster implementation: https://github.com/mozilla-it/itse-apps-stage-1-infra 
* A good, short synapsis of Kubernetes tier separation approaches can be found in Production Kubernetes by Rosso, Lander, Brand & Harris: https://www.oreilly.com/library/view/production-kubernetes/9781492092292/
