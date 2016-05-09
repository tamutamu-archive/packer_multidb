set PACKER_LOG=1
packer build template.json > build.log 2>&1

@if not "%ERRORLEVEL%"  == "0" (
  echo "ÉGÉâÅ[ÅI"
) else (
  vagrant box add --force multidb multidb.box
  del /Q multidb.box
)