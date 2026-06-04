@echo off
cd /d "C:\src\Github - P-TC\Website"

echo === STEP 1: Tag current state as rollback point === > git_deploy_output.txt
git tag -a old-site -m "Old site before 2026 redesign - rollback point" >> git_deploy_output.txt 2>&1
echo Tag result: %errorlevel% >> git_deploy_output.txt

echo. >> git_deploy_output.txt
echo === STEP 2: Push tag to GitHub === >> git_deploy_output.txt
git push origin old-site >> git_deploy_output.txt 2>&1

echo. >> git_deploy_output.txt
echo === STEP 3: Stage all files === >> git_deploy_output.txt
git add -A >> git_deploy_output.txt 2>&1

echo. >> git_deploy_output.txt
echo === STEP 4: Commit === >> git_deploy_output.txt
git commit -m "2026 redesign: new layout, content, stats, responsive nav, coloured logo" >> git_deploy_output.txt 2>&1

echo. >> git_deploy_output.txt
echo === STEP 5: Push to GitHub Pages === >> git_deploy_output.txt
git push origin main >> git_deploy_output.txt 2>&1

echo. >> git_deploy_output.txt
echo === FINAL STATUS === >> git_deploy_output.txt
git log --oneline -4 >> git_deploy_output.txt 2>&1
git tag >> git_deploy_output.txt 2>&1
echo DONE >> git_deploy_output.txt
