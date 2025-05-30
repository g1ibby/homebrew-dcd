# Homebrew Tap Setup Instructions

This document explains how to set up the separate `homebrew-dcd` repository and cross-repository automation.

## 📦 Repository Setup

### 1. Set Up GitHub Secrets

In your **main DCD repository** (`g1ibby/dcd`), add this secret:

1. Go to **Settings → Secrets and variables → Actions**
2. Add **Repository secret**:
   - **Name**: `HOMEBREW_TAP_TOKEN`
   - **Value**: Personal Access Token with `repo` scope for `homebrew-dcd`

### 2. Create Personal Access Token

1. Go to **GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens**
2. **Generate new token** with:
   - **Resource owner**: Your account
   - **Repository access**: Selected repositories → `homebrew-dcd`
   - **Permissions**: 
     - **Contents**: Write
     - **Metadata**: Read
     - **Actions**: Write (for repository dispatch)

## 🔄 How It Works

### Automatic Process
1. **You tag a release** in `g1ibby/dcd` (e.g., `v0.2.3`)
2. **Main repo workflow** calculates SHA256 hashes for macOS binaries
3. **Repository dispatch** triggers `homebrew-dcd` with version data
4. **Tap repo workflow** updates formula and commits changes
5. **Users get updates** automatically on next `brew update`

### Manual Testing
```bash
# Test the cross-repo trigger (from main DCD repo)
curl -X POST \
  -H "Authorization: Bearer $HOMEBREW_TAP_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/g1ibby/homebrew-dcd/dispatches \
  -d '{"event_type":"version-update","client_payload":{"version":"0.2.3","sha256_intel":"d472ca0fc5bb77d4f84bfff617b54258579dcdb64c164e9a840824af66340d78","sha256_arm":"393d9ef83145d0d947ce7c18a3564233740c9678f13b1f23a15502b053523cf4"}}'
```

## 🔧 File Structure in homebrew-dcd

```
homebrew-dcd/
├── .github/workflows/
│   └── update-formula.yml     # Triggered by main repo
├── Formula/
│   ├── dcd.rb.template        # Template with placeholders
│   └── dcd.rb                 # Generated formula
├── README.md                  # User instructions
├── MAINTENANCE.md             # Troubleshooting guide
└── SETUP.md                   # This file (optional in tap repo)
```

