<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <ItemGroup Label="ProjectConfigurations">
    <ProjectConfiguration Include="Release|Win32">
      <Configuration>Release</Configuration>
      <Platform>Win32</Platform>
    </ProjectConfiguration>
  </ItemGroup>
  <PropertyGroup Label="Globals">
    <ProjectGuid>{2E58F113-DEEF-4B4B-8A7F-9208C18B5481}</ProjectGuid>
    <Keyword>Win32Proj</Keyword>
    <RootNamespace>PythonEmbed</RootNamespace>
  </PropertyGroup>
  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
  <PropertyGroup>
    <ConfigurationType>StaticLibrary</ConfigurationType>
    <UseDebugLibraries>false</UseDebugLibraries>
    <WholeProgramOptimization>true</WholeProgramOptimization>
  </PropertyGroup>
  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
  <ImportGroup Label="ExtensionSettings">
  </ImportGroup>
  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
  </ImportGroup>
  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
  </ImportGroup>
  <PropertyGroup Label="UserMacros" />
  <PropertyGroup>
    <GenerateManifest>false</GenerateManifest>
    <TargetName>pythonembed</TargetName>
    <OutDir>$(MSBuildProjectDirectory)\</OutDir>
  </PropertyGroup>
  <ItemDefinitionGroup>
    <ClCompile>
      <WarningLevel>Level3</WarningLevel>
      <PrecompiledHeader>
      </PrecompiledHeader>
      <Optimization>MaxSpeed</Optimization>
      <FunctionLevelLinking>true</FunctionLevelLinking>
      <IntrinsicFunctions>true</IntrinsicFunctions>
      <PreprocessorDefinitions>WIN32;_WIN32;NDEBUG;Py_NO_ENABLE_SHARED;Py_BUILD_CORE;_USRDLL;_CRT_SECURE_NO_WARNINGS;%(PreprocessorDefinitions)</PreprocessorDefinitions>
      <AdditionalIncludeDirectories>..\PC;..\Python;..\Modules\zlib;..\Modules\_ctypes\libffi_msvc;..\..\openssl-$(OPENSSL_V)\inc32;..\Include</AdditionalIncludeDirectories>
      <CompileAsManaged>false</CompileAsManaged>
      <CompileAsWinRT>false</CompileAsWinRT>
      <MultiProcessorCompilation>true</MultiProcessorCompilation>
      <InlineFunctionExpansion>OnlyExplicitInline</InlineFunctionExpansion>
      <OmitFramePointers>true</OmitFramePointers>
      <EnableFiberSafeOptimizations>true</EnableFiberSafeOptimizations>
    </ClCompile>
    <Link>
      <SubSystem>Windows</SubSystem>
      <GenerateDebugInformation>true</GenerateDebugInformation>
      <EnableCOMDATFolding>true</EnableCOMDATFolding>
      <OptimizeReferences>true</OptimizeReferences>
      <IgnoreSpecificDefaultLibraries>libc;libcmt;%(IgnoreSpecificDefaultLibraries)</IgnoreSpecificDefaultLibraries>
    </Link>
    <Lib>
      <IgnoreSpecificDefaultLibraries>libc;libcmt;%(IgnoreSpecificDefaultLibraries)</IgnoreSpecificDefaultLibraries>
      <SuppressStartupBanner>false</SuppressStartupBanner>
    </Lib>
  </ItemDefinitionGroup>
  <ItemGroup>
    <ClCompile Include="..\Objects\*.c"/>
    <ClCompile Include="..\Parser\*.c"/>
    <ClCompile Include="..\PC\*.c"/>
    <ClCompile Include="..\Python\*.c"/>
    <ClCompile Include="..\Modules\*.c"/>
    <ClCompile Include="..\Modules\_ctypes\*.c"/>
    <ClCompile Include="..\Modules\_ctypes\libffi_msvc\*.c"/>
    <ClCompile Include="..\Modules\_io\*.c"/>
    <ClCompile Include="..\Modules\cjkcodecs\*.c"/>
    <ClCompile Include="..\Modules\zlib\*.c"/>
  </ItemGroup>
  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
  <ImportGroup Label="ExtensionTargets">
  </ImportGroup>
</Project>
