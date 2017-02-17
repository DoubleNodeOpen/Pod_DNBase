Steps to Update Pod
-------------------
To Add DoubleNodeOpen Specs Repo to local Cocoapods:
pod repo add DNOCocoapodsSpecsRepo https://github.com/DoubleNodeOpen/CocoapodsSpecsRepo.git

For New Install Only:
pod repo update DNOCocoapodsSpecsRepo

1. Check local files
pod lib lint --sources=git@github.com:DoubleNodeOpen/CocoapodsSpecsRepo.git,master --private

2. Create tag and push to github

3. Check repo file
pod spec lint --sources=git@github.com:DoubleNodeOpen/CocoapodsSpecsRepo.git,master --private

4. Final Submit
pod repo push DNOCocoapodsSpecsRepo DNBase.podspec


Steps to Resource Podfile Pods
------------------------------
When changing pod's "path" to/from development mode:

rm Pods/Manifest.lock && rm Podfile.lock && pod install
