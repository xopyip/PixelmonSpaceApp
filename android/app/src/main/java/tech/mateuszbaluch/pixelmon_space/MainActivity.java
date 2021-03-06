package tech.mateuszbaluch.pixelmon_space;

import android.graphics.drawable.Drawable;
import android.widget.ImageView;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.DrawableSplashScreen;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.SplashScreen;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }

  @java.lang.Override
  public SplashScreen provideSplashScreen() {
    Drawable splash = getResources().getDrawable(R.drawable.splash);
    return new DrawableSplashScreen(splash, ImageView.ScaleType.CENTER, 0);
  }
}
