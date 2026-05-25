---
name: infra-devops-review
description: Reviews a codebase for infrastructure and DevOps quality, risk, and operability. Use when asked to assess CI/CD, IaC, containers, deployment config, secrets handling, observability, runtime operations, or production readiness.
---

# Infra DevOps Review

## What it does

- Reviews the operational side of a codebase rather than the product logic.
- Assesses infrastructure definitions, delivery pipelines, runtime configuration, and operational safeguards.
- Produces a prioritized review with concrete findings, risk level, and practical remediation guidance.

## When to use it

Use this skill when the task involves:
- reviewing a repo's infrastructure or DevOps posture
- assessing CI/CD workflows, release automation, or deployment safety
- checking Terraform, OpenTofu, Pulumi, Helm, Kubernetes, Docker, Compose, or cloud config
- evaluating secrets handling, environment configuration, backups, observability, or incident readiness
- judging whether a codebase looks production-ready from an infra or operations perspective

## Do not use it when

- the task is a general application code review with no operational angle
- the task is to implement or repair infrastructure rather than review it
- the request needs a provider-specific audit that depends on live cloud access, billing data, or account settings not present in the repo
- the task is primarily security compliance or penetration testing beyond repo-visible infrastructure practices

## Workflow

1. Identify the operational surface area in the repo. Look for files and directories such as `.github/workflows/`, `.gitlab-ci.yml`, `Dockerfile`, `docker-compose.yml`, `compose.yml`, `terraform/`, `infra/`, `deploy/`, `helm/`, `charts/`, `k8s/`, `manifests/`, and environment template files.
2. Infer the deployment model and runtime shape. Determine how the service is built, tested, packaged, configured, deployed, and observed.
3. Review the most relevant areas:
   - build and release reliability
   - deployment safety and rollback story
   - environment parity and configuration management
   - secret handling and least-exposure practices
   - container quality, image hygiene, and runtime hardening
   - IaC structure, reuse, drift risk, and state handling
   - logging, metrics, health checks, alerts, and runbook clues
   - backup, disaster recovery, and operational resilience signals
4. Score findings by severity and likelihood. Prefer `critical`, `high`, `medium`, and `low` or a similarly clear scale.
5. Return a concise review that includes:
   - what was inspected
   - key strengths
   - prioritized findings
   - why each finding matters operationally
   - the smallest practical next fix or decision
6. If the user also wants changes, separate review findings from implementation recommendations so the audit stays clear.

## Review heuristics

- Favor repo-visible evidence over assumptions.
- Treat missing basics as findings only when the repo suggests they should exist.
- Distinguish maturity gaps from outright risks.
- Call out brittle single points of failure, manual deployment steps, and undocumented operational dependencies.
- Note when safeguards exist but are incomplete, such as CI without required checks or health checks without alerting.

## Guardrails

- Do not claim live infrastructure state, cloud posture, or secret rotation status unless the repo proves it.
- Do not turn the review into a generic security audit; stay anchored to infrastructure and delivery concerns.
- Do not flood the user with low-value nitpicks; focus on issues that affect reliability, safety, repeatability, cost control, or operability.
- Do not recommend heavyweight platform changes unless the current setup clearly fails the stated needs.
- Be explicit about uncertainty when deployment details are inferred from partial configuration.

## Verification

- Confirm the review is based on actual files and configurations present in the repo.
- Confirm each major finding includes impact and a practical next step.
- Confirm the final output separates observed evidence from inference.
- Confirm the review stays focused on infra and DevOps concerns rather than drifting into a full code audit.

## Output

- Return a prioritized infra/DevOps review of the codebase.
- Include a short list of strengths as well as risks.
- Note any missing context that prevents stronger conclusions.
