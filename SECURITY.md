# Security & Disclosure Policy

In a software project this file explains how to report a vulnerability. In a portfolio built from confidential work, the equivalent risk is **disclosure**: something that should have been redacted and was not. This page sets out what the redaction covers and how to tell me if you spot something.

## What is redacted

Every profile passes through **Hazard Filtering** (see [project 26](projects/26-principal-systems-engineering-portfolio/profile.md)) before publication. The intent is that this repository never contains:

- Client, employer or partner names, brands or trademarks, unless the work is my own.
- Proprietary source code, algorithms or business rules.
- Credentials, keys, tokens or connection strings of any kind.
- Public IP addresses, public domain names or other identifiers that resolve to live systems.
- Personal data about end users, staff, beneficiaries or anyone else.

## What is intentionally kept

To keep the architecture readable, profiles may show:

- Generic component and role names (for example `sso-node` or `metrics-node`).
- Open-source products and public vendors used as building blocks.
- Ports and protocols that are standard for the technology involved.
- ✍️ To fill in: whether private (RFC 1918) addressing and internal host naming are illustrative or should be generalised. Some profiles currently show them.

## Reporting a suspected disclosure

If you believe something here identifies a client, exposes a live system or includes data that should not be public:

1. **Do not** open a public issue or pull request that repeats the information.
2. Contact me privately at ✍️ To fill in (email or other private channel).
3. Include the file path and line, and why you think it is sensitive.

I aim to acknowledge reports within ✍️ To fill in (e.g. two working days) and to remove confirmed disclosures, including from git history where needed.

## Scope

This policy covers the contents of this repository. The scripts in `scripts/` are tooling for building the portfolio and are not intended to run against any system other than your own.
