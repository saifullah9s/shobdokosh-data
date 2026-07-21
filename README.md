# Shobdokosh Dictionary Data

This repository is intended to publish versioned dictionary JSON files through GitHub Pages.

## Initial contents

- `docs/manifest.json`
- `docs/dictionary-v1.json`
- `docs/index.html`
- `docs/.nojekyll`

Current SHA-256:

`fc487b443cb3404e4bebbb121220dffd51504344c775c57f3ed281971ff4e2f1`

## Enable GitHub Pages

1. Create a public GitHub repository named `shobdokosh-data`.
2. Upload everything from this starter package, preserving the `docs` folder.
3. Open the repository's **Settings**.
4. Open **Pages**.
5. Under **Build and deployment**, choose **Deploy from a branch**.
6. Select branch **main** and folder **/docs**.
7. Save and wait for the deployment to finish.

Your URLs will be:

- `https://YOUR_USERNAME.github.io/shobdokosh-data/manifest.json`
- `https://YOUR_USERNAME.github.io/shobdokosh-data/dictionary-v1.json`

## Publishing a correction

1. Correct your master JSON file.
2. Choose the next integer version, for example `2`.
3. Run the included PowerShell script:

```powershell
powershell -ExecutionPolicy Bypass -File .\prepare-update.ps1 `
  -SourceJson "C:\path\to\corrected_dictionary.json" `
  -Version 2
```

4. The script creates `docs/dictionary-v2.json` and updates `docs/manifest.json`.
5. Upload/commit the new dictionary file first.
6. Upload/commit `manifest.json` last.
7. Keep older dictionary files for rollback.

Do not overwrite an older versioned file after users may have downloaded it.
