# LockoutRadar

> A turnkey Microsoft 365 brute force alerting package for MSPs and IT admins that surfaces account lockout attacks before they become incidents.

## Overview

LockoutRadar is a pre-configured, plug-and-play PowerShell automation bundle that monitors Entra ID sign-in logs for error code 50053 events via Microsoft Graph, aggregates impacted users into a prioritized risk table, and delivers branded HTML alert emails with attached CSV forensics — all without an SMTP relay. It ships with an Azure Automation runbook, a Task Scheduler XML template, an App Registration setup guide, and a one-click deployment script so any IT admin or MSP can be live in under 30 minutes.

## Problem This Solves

Security teams have no real-time visibility into credential-stuffing and brute force attacks against their Azure AD tenant — the data exists in Entra sign-in logs but nobody is watching it, so the first signal is a flood of help desk lockout tickets after the damage is done

## Target Audience

MSPs managing multiple Microsoft 365 tenants, and in-house IT admins at SMBs (100–2,000 seat orgs) who lack a dedicated SIEM but need proactive security alerting

## Tech Stack

PowerShell, Microsoft Graph API, Azure Automation, HTML/CSS email templating

## Quick Start

```powershell
# Clone the repository
git clone https://github.com/lockout-radar-m365.git
cd lockout-radar-m365

# One-click install & run
.\Install.ps1

# Or run the script directly
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\scripts\{lockout-radar-m365}.ps1
```

## Usage

Query the Microsoft Graph auditLogs/signIns endpoint for Entra ID error code 50053 events within a configurable lookback window, deduplicate and rank impacted accounts by lockout frequency, and dispatch a branded HTML summary email with a full raw-event CSV attachment using the Graph sendMail API — no SMTP relay required.

## Monetization Strategy

Sell a one-time 'Starter Pack' ($49) on Gumroad or Lemon Squeezy that includes the core script bundle, deployment guide, and email templates; offer a 'MSP Multi-Tenant Edition' ($149 one-time or $19/month per tenant block of 10) with a wrapper script that loops across client tenants and routes alerts to per-client mailboxes; upsell a 90-minute remote setup consultation for $299 via Calendly

| Metric | Value |
|--------|-------|
| Revenue Potential | HIGH |
| Estimated Effort  | 1-2weeks |

## About the Author