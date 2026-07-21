# Required Android app integration

GitHub hosting alone does not update the installed app. The app must be rebuilt once with an updater.

The updater should:

1. Keep the bundled JSON as the first-install fallback.
2. Store the installed dictionary version locally.
3. Request `manifest.json` over HTTPS.
4. Compare `dictionaryVersion`.
5. Download the named JSON into a temporary file.
6. Verify file size and SHA-256.
7. Parse and validate the expected schema.
8. Import into Room inside a safe transaction or staging tables.
9. Preserve Saved and History tables.
10. update the stored version only after a successful import.
11. retain the working database when any step fails.

Recommended initial policy:

- Manual **Check for updates** button.
- Optional automatic check once per day.
- Download only on Wi-Fi option.
- Do not require an account or GitHub token.
