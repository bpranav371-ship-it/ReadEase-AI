plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.readease"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Keeps your build compatible with modern Android Gradle Plugin 8.0+
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.readease"

        // Firestore often requires a minimum SDK of 21.
        // If flutter.minSdkVersion is lower (e.g. 19), this ensures stability.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // ★ CRITICAL UPDATE FOR FIREBASE ★
        // Enables building apps with over 64k methods (common with Firestore)
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // TODO: For Hackathon, debug keys are fine.
            // For Store, generate a real keystore later.
            signingConfig = signingConfigs.getByName("debug")

            // helps remove unused code to shrink apk size
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

// ★ ADDED DEPENDENCIES BLOCK ★
dependencies {
    // Required if your minSdk is below 21, but good practice to include for Firestore
    implementation("androidx.multidex:multidex:2.0.1")
}