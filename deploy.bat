@echo off
echo ============================================
echo  P-TC Website Deploy Script
echo ============================================
echo.

cd /d "%~dp0"

echo [1/6] Checking git status...
git status
echo.

echo [2/6] Tagging current state as 'old-site' (rollback point)...
git tag -a old-site -m "Old site before 2026 redesign" 2>nul
if %errorlevel% neq 0 (
  echo Tag 'old-site' already exists, skipping.
) else (
  echo Tag created.
)
echo.

echo [3/6] Pushing tag to GitHub...
git push origin old-site
echo.

echo [4/6] Staging all changes...
git add -A
echo.

echo [5/6] Committing new site...
git commit -m "2026 redesign: new layout, content, branding, responsive nav"
echo.

echo [6/6] Pushing to GitHub (this deploys to p-tc.be via GitHub Pages)...
git push origin
echo.

echo ============================================
echo  Done! Site will be live at https://p-tc.be
echo  within a few minutes (GitHub Pages rebuild).
echo.
echo  To roll back at any time:
echo    git checkout old-site -- .
echo    git push origin
echo ============================================
pause
