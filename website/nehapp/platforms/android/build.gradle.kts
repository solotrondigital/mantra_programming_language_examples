plugins {
    id("com.android.application")
    kotlin("android")
}

android {
    namespace = "com.nehapp.nehapp"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.nehapp.nehapp"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "0.5.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
}
