## About This DevContainer

This repository provides a DevContainer setup for Dart.  
The Docker image is based on `dart:stable` and has a size of approximately 1.3GB after being built.

This setup has been tested on macOS-x86_64 and Linux-x86_64 as host platforms, with Linux-x86_64 as the container runtime. Compatibility with other environments is not guaranteed.

Additionally, this DevContainer provides runtime-native builds using Docker for the host environment and includes pre-configured tasks for building platform-portable artifacts:

- **aot-snapshot** — Generates an AOT-compiled module that can run on supported platforms using `dartaotruntime`. This allows some level of cross-compatibility as long as the appropriate runtime exists.
- **kernel** — Produces a portable `.dill` kernel file, which is not tied to a specific OS or CPU architecture. This is suitable for use across platforms with the Dart SDK installed.
- **Cross-Build** — Dart does not support self-contained cross-builds. Therefore, only self-contained executables for the **host platform** can be built using the `toolchains-cross` setup.

### Host Platform Compatibility for Self-Contained Executable Builds

The table below lists the host environments currently supported or planned for building self-contained Dart executables using the `toolchains-cross` setup.

| Host OS | Host Arch | Status       |
|---------|-----------|--------------|
| Windows | x64       | PLANNED      |
| Windows | arm64     | PLANNED      |
| macOS   | x64       | OK           |
| macOS   | arm64     | NOT TESTED   |
| Linux   | x64       | OK           |
| Linux   | arm64     | NOT TESTED   |

## Support This Project

If you found this project helpful, consider supporting its maintenance and future development with a small donation.  
You can buy me a coffee via the Ko-fi link below — thank you! ☕✨  

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/B0B21CR05U)

---

## Getting Started (with Dev Containers)

### 1. Launch VSCode  
Open Visual Studio Code.

### 2. Open the Project Folder in VSCode  
Go to **File → Open Folder** and select the folder where the project is cloned.  
If you see a message saying **"Could not find a Dart SDK. Please download, or, if already downloaded, click 'Locate SDK'."**, close the message by clicking the **X button**. This message may appear if the Dart VSCode extension is installed on the host machine. The Dart SDK is installed inside the container, so you can proceed without any issues.

### 3. Install VSCode Extensions  
If you see a message at the bottom of VSCode saying **"Do you want to install the recommended extensions from GitHub, Microsoft, and others for this repository?"**, click **Install** to install the **Dev Containers** extension along with other recommended extensions.

### 4. Reopen the Project in a Container  
Click the **bottom left corner** of the VSCode window where it says **"Open a Remote Window"** → **Reopen in Container**.  

### 5. Wait for the Container to Build and Set Up  
Wait while the **Dev Container environment prepares**. This process may include **downloading the base image**, **installing required tools and libraries**, and **building the Docker image if necessary**.  
Depending on your internet speed and system performance, this may take **a few minutes**.  
If you see a message prompting you to install recommended extensions like in the previous steps, click **Install** to install the extensions in the container environment.

### 6. Debug the Project  
Open `[WORKSPACE_FOLDER]/src/dart_example.dart` and press **F5** to start debugging.  
The project will be **compiled and executed inside the container**, and the output will be visible in the **Terminal**.

### 7. Build a Docker Runtime-Native Binary  
Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **build release: docker runtime native**.  
This will generate an executable binary that runs natively in the Docker runtime environment.

### 8. Build a Host Self-Contained Executable and Clean SDK/Cache

On macOS and Linux, you can build a self-contained executable for the host platform by running the following VSCode task:

1. Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task**.
2. Select **[HOST only] Build Host Executable** from the list of tasks.

This task will:

- Automatically detect your host OS and architecture.
- Download the appropriate Dart SDK if not already present.
- Compile `[WORKSPACE_FOLDER]/src/bin/dart_example.dart` into a self-contained executable at:

```
[WORKSPACE_FOLDER]/src/build/release/dart_example-[platform]
```

To remove previously downloaded SDKs and cached SDK archives without affecting build outputs, run the following VSCode task:

1. Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task**.
2. Select **[HOST only] Remove SDKs and Cache** from the list of tasks.

> **Note:**  
> This cleanup only removes downloaded SDKs and zip cache files.  
> It does **not** delete any previously built executables.

> **Windows is not supported yet** for host-side builds.

