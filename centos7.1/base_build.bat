@if "%1" == "gui" (
  set BASE_NAME=base_centos7_gui
  packer build base_build_gui.json > base_build_gui.log 2>&1
) else (
  set BASE_NAME=base_centos7
  packer build base_build.json > base_build.log 2>&1
)

@if not "%ERRORLEVEL%"  == "0" (
  echo "ÉGÉâÅ[ÅI"
) else (
  vagrant box add --force %BASE_NAME% %BASE_NAME%.box
  del /Q %BASE_NAME%.box
)
