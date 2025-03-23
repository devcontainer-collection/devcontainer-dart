## Getting Started (with Dev Containers)

### 1. Launch VSCode  
Open Visual Studio Code.

### 2. Open the Project Folder in VSCode  
Go to **File → Open Folder** and select the folder where the project is cloned.  
If you see a message saying **"Could not find a Dart SDK. Please download, or, if already downloaded, click 'Locate SDK'."**, just close the message by clicking the **X button**. The Dart SDK is installed inside the container, so you can proceed without any issues.

### 3. Install VSCode Extension  
If you see a message at the bottom of VSCode saying **"Do you want to install the recommended extensions from GitHub, Microsoft and others for this repository?"**, click **Install** to install the **Dev Containers** extension along with other recommended extensions.

### 4. Reopen the Project in a Container  
Click the **bottom left corner** of the VSCode window where it says **"Open a Remote Window"** → **Reopen in Container**.  

### 5. Wait for the Container to Build and Set Up  
Wait while the **Dev Container environment is being prepared**. This process may include **downloading the base image**, **installing required tools and libraries**, and **building the Docker image if necessary**.  
Depending on your internet speed and system performance, this may take **a few minutes**.  
If you see a message prompting you to install recommended extensions like in the previous steps, click **Install** to install the extensions in the container environment.

### 6. Debug the Project  
Open `/workspace/src/dart_example.dart` and press **F5** to start debugging.  
The project will be **compiled and executed inside the container**, and the output will be visible in the **Terminal**.

### 7. Build Docker Runtime-Native Binary  
Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **build release: docker runtime native**.  
This will generate an executable binary that runs natively in the Docker runtime environment.

### 8. ~~Cross-Build the Project~~
~~Open the command palette: Press **Ctrl + Shift + P** (macOS: **Cmd + Shift + P**) → **Tasks: Run Task** → **Build all release targets**.~~

---

## About This DevContainer

This repository provides a DevContainer setup for Dart development.
The Docker image size is approximately 1.3GB after build.

> **Note:**  
> Dart’s self-contained release build via dart compile exe does not support cross-compilation. These builds are platform-specific native binaries and must be compiled on their target OS (Linux, macOS, or Windows).

However, this DevContainer provides runtime-native builds using Docker for the host environment, and also includes pre-configured Tasks for building platform-portable artifacts:

- **aot-snapshot** — Generates an AOT-compiled module that can run on supported platforms using dartaotruntime. This allows some level of cross-compatibility as long as the appropriate runtime exists.
- **kernel** — Produces a portable .dill kernel file, which is not tied to a specific OS or CPU architecture, suitable for use across platforms with the Dart SDK installed.