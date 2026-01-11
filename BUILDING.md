# Build Prerequisites

* Microsoft Visual Studio 2013 Professional
* Multibyte MFC Library for Visual Studio 2013

> [!CAUTION]
> Visual Studio 2013 Express does **not** include the *Microsoft Foundation Classes* library required to build Hammer. The Professional edition, or higher, must be installed.

> [!NOTE]
> Any version of Visual Studio can build the solution, as long as it is newer than Visual Studio 2013 and the Visual Studio 2013 *(v120)* toolset is installed. The v120 toolset is only included with Visual Studio 2013, or Visual Studio 2015 as a component called `Windows 8.1 and Windows Phone 8.0/8.1 Tools`
>
> Newer versions of Visual Studio do not include the Microsoft Foundation Classes by default and must be selected in the installer. Windows XP Support must also be selected to build for Windows XP.

## Building the Solution

1. Open the solution file `source_level_editor.sln` in the `src` directory. 

2. Build both the `level_editor` and `level_editor_dll` projects, or build the entire solution.

The binaries will be placed in `game\bin`, next to `src`.  
These will need to be copied into the Source SDK 2013 Singleplayer `bin` directory to function.
