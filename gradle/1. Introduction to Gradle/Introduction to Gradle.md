Intrpduction to Gradle
---------------------
- Gradle is an open-source `build automation` tool focused on `flexibility` and `performance`. Gradle build scripts are written using a Groovy or Kotlin DSL.
- **Highly customizable** — Gradle is modeled in a way that is `customizable` and `extensible` in the most fundamental ways.
- **Fast** — Gradle completes tasks quickly by reusing outputs from previous executions, processing only inputs that changed, and executing tasks in parallel.
- __Powerful__ — Gradle is the official build tool for Android, and comes with support for many popular languages and technologies.
- Gradle runs on JVM (JDK).
- Build instruction is defined in a script called build script.
- Plugons provieds the predefined functionality.
- It can be executed from command line.
- Sutable for bild/multimodule and small projects.
- Link : https://docs.gradle.org/current/userguide/what_is_gradle.html
- Link : https://docs.gradle.org/current/userguide/what_is_gradle.html#what_is_gradle

Installing Gradle
-----------------
- You can install the Gradle build tool on Linux, macOS, or Windows.
- Gradle runs on all major operating systems and requires only a __Java Development Kit version 8__ or higher to run. To check, run `java -version`.
- Gradle ships with its own Groovy library, therefore Groovy does not need to be installed. Any existing Groovy installation is ignored by Gradle.
- Gradle uses whatever JDK it finds in your path. Alternatively, you can set the JAVA_HOME environment variable to point to the installation directory of the desired JDK.
- Downlaod the binary archive and extract at suitable location and add the path to bin in System or User PATH variable.
- Run `gradle -v` to check the instllation