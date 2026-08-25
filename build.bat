@echo off
setlocal

set "BASE=%~dp0"
set "SOURCE=%BASE%libwebp"
set "BUILD=%BASE%build_windows_x64"
set "OUTPUT=%BASE%windows_x64"

cmake -S "%SOURCE%" -B "%BUILD%" -G "Visual Studio 17 2022" -A x64 -DBUILD_SHARED_LIBS=OFF -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded -DCMAKE_POLICY_DEFAULT_CMP0091=NEW -DWEBP_BUILD_ANIM_UTILS=OFF -DWEBP_BUILD_CWEBP=OFF -DWEBP_BUILD_DWEBP=OFF -DWEBP_BUILD_GIF2WEBP=OFF -DWEBP_BUILD_IMG2WEBP=OFF -DWEBP_BUILD_VWEBP=OFF -DWEBP_BUILD_WEBPINFO=OFF -DWEBP_BUILD_WEBPMUX=OFF -DWEBP_BUILD_EXTRAS=OFF -DWEBP_BUILD_WEBP_JS=OFF -DWEBP_BUILD_FUZZTEST=OFF -DWEBP_BUILD_LIBWEBPMUX=ON -DWEBP_ENABLE_SIMD=ON -DWEBP_USE_THREAD=OFF
if errorlevel 1 exit /b 1
cmake --build "%BUILD%" --config Release --parallel 6 --target webp webpdemux libwebpmux
if errorlevel 1 exit /b 1

mkdir "%OUTPUT%\lib" 2>nul
mkdir "%OUTPUT%\include\webp" 2>nul
mkdir "%OUTPUT%\licenses" 2>nul
copy /Y "%BUILD%\Release\sharpyuv.lib" "%OUTPUT%\lib\sharpyuv.lib" >nul
copy /Y "%BUILD%\Release\webp.lib" "%OUTPUT%\lib\webp.lib" >nul
copy /Y "%BUILD%\Release\webpdemux.lib" "%OUTPUT%\lib\webpdemux.lib" >nul
copy /Y "%BUILD%\Release\webpmux.lib" "%OUTPUT%\lib\webpmux.lib" >nul
copy /Y "%SOURCE%\src\webp\*.h" "%OUTPUT%\include\webp\" >nul
copy /Y "%SOURCE%\COPYING" "%OUTPUT%\licenses\COPYING" >nul
copy /Y "%SOURCE%\PATENTS" "%OUTPUT%\licenses\PATENTS" >nul

