import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog.dart';


class PermissionHandler {
  Future<bool> checkAndRequestCameraPermissions() async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      // 权限被拒绝或受限，请求权限
      final requestStatus = await Permission.camera.request();
      // 用户已拒绝，并且不再询问
      if (requestStatus.isPermanentlyDenied) {
        // 引导用户去设置页面开启权限
        // await openAppSettings();
        Get.dialog(PermissionCameraDialog(
          callback: () async {
            await openAppSettings();
          },
        ));
        return false;
      }
      // 用户拒绝，但仍可以再次请求
      return requestStatus.isGranted;
    } else if (status.isGranted) {
      // 权限已经被授予
      return true;
    }
    // 应用第一次运行，权限未知
    return false;
  }

  Future<bool> checkAndRequestPhotoPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        final status = await Permission.storage.status;
        if (status.isDenied || status.isRestricted) {
          // 权限被拒绝或受限，请求权限
          final requestStatus = await Permission.storage.request();
          // 用户已拒绝，并且不再询问
          if (requestStatus.isPermanentlyDenied) {
            // 引导用户去设置页面开启权限
            Get.dialog(PermissionCameraDialog(
              callback: () async {
                await openAppSettings();
              },
            ));
            return false;
          }
          // 用户拒绝，但仍可以再次请求
          return requestStatus.isGranted;
        } else if (status.isGranted) {
          // 权限已经被授予
          return true;
        }
      } else {
        final status = await Permission.photos.status;
        if (status.isDenied || status.isRestricted) {
          // 权限被拒绝或受限，请求权限
          final requestStatus = await Permission.photos.request();
          // 用户已拒绝，并且不再询问
          if (requestStatus.isPermanentlyDenied) {
            // 引导用户去设置页面开启权限
            Get.dialog(PermissionCameraDialog(
              callback: () async {
                await openAppSettings();
              },
            ));
            return false;
          }
          // 用户拒绝，但仍可以再次请求
          return requestStatus.isGranted;
        } else if (status.isGranted) {
          // 权限已经被授予
          return true;
        }
      }
    } else {
      final status = await Permission.photos.status;
      if (status.isDenied || status.isRestricted) {
        // 权限被拒绝或受限，请求权限
        final requestStatus = await Permission.photos.request();
        // 用户已拒绝，并且不再询问
        if (requestStatus.isPermanentlyDenied) {
          // 引导用户去设置页面开启权限
          Get.dialog(PermissionCameraDialog(
            callback: () async {
              await openAppSettings();
            },
          ));
          return false;
        }
        // 用户拒绝，但仍可以再次请求
        return requestStatus.isGranted;
      } else if (status.isGranted) {
        // 权限已经被授予
        return true;
      }
      // 应用第一次运行，权限未知
      return false;
    }
    // 应用第一次运行，权限未知
    return false;
  }
}
