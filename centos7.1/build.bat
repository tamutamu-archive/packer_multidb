packer build template.json > build.log 2>&1

@if not "%ERRORLEVEL%"  == "0" (
  echo "�G���[�I"
) else (
  vagrant box add --force multidb multidb.box
  rm multidb.box
)