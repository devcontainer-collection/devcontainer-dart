## Getting Started (with DevContainers)

### 1. Install VSCode Extension  
Install the **Microsoft Dev Containers** extension.

### 2. Open the Project Folder in VSCode  
Go to **File → Open Folder** and select the folder where the project is cloned.

### 3. Reopen the Project in a Container  
Click the **bottom left corner** of the VSCode window where it says **"Open a Remote Window"** → **Reopen in Container**.

### 4. Wait for the Container to Build  
Wait for the **Docker image to be built** and for the **workspace to open inside the container**.

### 5. Debug the Project  
Open `/workspace/src/dart_example.dart` and press **F5** to start debugging.  
The project will be **compiled and executed inside the container**, and the output will be visible in the **Debug Console**.

### 6. Cross-Build the Project  
~~Press Cmd + Shift + P → Tasks: Run Task → Build all release targets.~~


---

## About This DevContainer

This repository provides a DevContainer setup for Dart development, enabling cross-compilation across multiple platforms.  
The Docker image size is approximately 1.3GB after build due to preinstalled cross-compilation toolchains and dependencies.

> **Note:**  
> Dart’s self-contained release build via `dart compile exe` does not support cross-compilation. These builds are platform-specific native binaries and must be compiled on their target OS (Linux, macOS, or Windows).

However, this DevContainer provides runtime-native builds using Docker for the host environment, and also includes pre-configured Tasks for building platform-portable artifacts:

- **aot-snapshot** — Generates an AOT-compiled module that can run on supported platforms using `dartaotruntime`. This allows some level of cross-compatibility as long as the appropriate runtime exists.
- **kernel** — Produces a portable `.dill` kernel file, which is not tied to a specific OS or CPU architecture, suitable for use across platforms with the Dart SDK installed.
