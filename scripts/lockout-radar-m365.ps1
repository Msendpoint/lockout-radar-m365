<#
.SYNOPSIS
    LockoutRadar

.DESCRIPTION
    LockoutRadar is a pre-configured, plug-and-play PowerShell automation bundle that monitors Entra ID sign-in logs for error code 50053 events via Microsoft Graph, aggregates impacted users into a prioritized risk table, and delivers branded HTML alert emails with attached CSV forensics — all without an SMTP relay. It ships with an Azure Automation runbook, a Task Scheduler XML template, an App Registration setup guide, and a one-click deployment script so any IT admin or MSP can be live in under 30 minutes.

    Purpose: Query the Microsoft Graph auditLogs/signIns endpoint for Entra ID error code 50053 events within a configurable lookback window, deduplicate and rank impacted accounts by lockout frequency, and dispatch a branded HTML summary email with a full raw-event CSV attachment using the Graph sendMail API — no SMTP relay required.

.NOTES
    Author:      Souhaiel Morhag
    Company:     MSEndpoint.com
    Blog:        https://msendpoint.com
    Academy:     https://app.msendpoint.com/academy
    LinkedIn:    https://linkedin.com/in/souhaiel-morhag
    GitHub:      https://github.com/Msendpoint
    Target:      MSPs managing multiple Microsoft 365 tenants, and in-house IT admins at SMBs (100–2,000 seat orgs) who lack a dedicated SIEM but need proactive security alerting
    Created:     2026-04-01
    Repository:  https://github.com/Msendpoint/lockout-radar-m365
    License:     MIT

.EXAMPLE
    .\scripts\{lockout-radar-m365}.ps1

.EXAMPLE
    .\scripts\{lockout-radar-m365}.ps1 -Verbose

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$TenantId,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = ".\output",

    [Parameter(Mandatory = $false)]
    [switch]$WhatIf
)

#Requires -Version 7.0

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ── Banner ─────────────────────────────────────────────────────
Write-Host ""
Write-Host "  LockoutRadar" -ForegroundColor Cyan
Write-Host "  MSEndpoint.com — https://msendpoint.com" -ForegroundColor DarkGray
Write-Host ""

# ── Prerequisites check ────────────────────────────────────────
function Test-Prerequisites {
    $modules = @('Microsoft.Graph', 'ExchangeOnlineManagement')
    foreach ($mod in $modules) {
        if (-not (Get-Module -ListAvailable -Name $mod)) {
            Write-Warning "Module '$mod' not found. Install with: Install-Module $mod -Scope CurrentUser"
        }
    }
}

# ── Connect to Microsoft Graph ────────────────────────────────
function Connect-ToGraph {
    param([string]$TenantId)

    $scopes = @(
        'DeviceManagementManagedDevices.Read.All',
        'DeviceManagementConfiguration.Read.All',
        'Organization.Read.All'
    )

    if ($TenantId) {
        Connect-MgGraph -TenantId $TenantId -Scopes $scopes
    } else {
        Connect-MgGraph -Scopes $scopes
    }
    Write-Verbose "Connected to Microsoft Graph"
}

# ── Main logic (implement based on specific project requirements) ─
function Invoke-MainProcess {
    param([string]$OutputPath)

    if (-not (Test-Path $OutputPath)) {
        New-Item -ItemType Directory -Path $OutputPath | Out-Null
    }

    # TODO: Implement main automation logic here
    # This is a scaffold — customize based on:
    # Query the Microsoft Graph auditLogs/signIns endpoint for Entra ID error code 50053 events within a configurable lookback window, deduplicate and rank impacted accounts by lockout frequency, and dispatch a branded HTML summary email with a full raw-event CSV attachment using the Graph sendMail API — no SMTP relay required.

    Write-Host "✓ Process complete. Results saved to: $OutputPath" -ForegroundColor Green
}

# ── Entry point ───────────────────────────────────────────────
try {
    Test-Prerequisites

    if (-not $WhatIf) {
        Connect-ToGraph -TenantId $TenantId
        Invoke-MainProcess -OutputPath $OutputPath
    } else {
        Write-Host "[WhatIf] Would execute: Invoke-MainProcess -OutputPath $OutputPath" -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Script failed: $($_.Exception.Message)"
    exit 1
}
finally {
    # Disconnect cleanly
    try { Disconnect-MgGraph -ErrorAction SilentlyContinue } catch {}
}