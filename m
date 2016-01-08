Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jan 2016 01:00:52 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:34214 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014716AbcAGX63RYt5u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jan 2016 00:58:29 +0100
Received: from mx.microchip.com (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 7 Jan 2016
 16:58:21 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Thu, 07 Jan 2016
 17:06:00 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Joshua Henderson <joshua.henderson@microchip.com>
Subject: [PATCH v3 14/14] MIPS: pic32mzda: Add initial PIC32MZDA Starter Kit defconfig
Date:   Thu, 7 Jan 2016 17:00:29 -0700
Message-ID: <1452211389-31025-15-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
References: <1452211389-31025-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This adds an initial default config that enables all available PIC32
drivers and is enough for booting a PIC32MZDA Starter Kit.

Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/configs/pic32mzda_defconfig |   89 +++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 arch/mips/configs/pic32mzda_defconfig

diff --git a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic32mzda_defconfig
new file mode 100644
index 0000000..52192c6
--- /dev/null
+++ b/arch/mips/configs/pic32mzda_defconfig
@@ -0,0 +1,89 @@
+CONFIG_MACH_PIC32=y
+CONFIG_DTB_PIC32_MZDA_SK=y
+CONFIG_HZ_100=y
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_SECCOMP is not set
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_RELAY=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_SGI_PARTITION=y
+CONFIG_BINFMT_MISC=m
+# CONFIG_SUSPEND is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_SCAN_ASYNC=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_INPUT_LEDS=m
+CONFIG_INPUT_POLLDEV=y
+CONFIG_INPUT_MOUSEDEV=m
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_EVBUG=m
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=m
+CONFIG_KEYBOARD_GPIO_POLLED=m
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_PIC32=y
+CONFIG_SERIAL_PIC32_CONSOLE=y
+CONFIG_HW_RANDOM=y
+CONFIG_RAW_DRIVER=m
+CONFIG_GPIO_SYSFS=y
+# CONFIG_HWMON is not set
+CONFIG_HIDRAW=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_MICROCHIP_PIC32=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=m
+CONFIG_LEDS_TRIGGER_ONESHOT=m
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_GPIO=m
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_AUTOFS4_FS=m
+CONFIG_FUSE_FS=m
+CONFIG_FSCACHE=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_SQUASHFS=m
+CONFIG_SQUASHFS_XATTR=y
+CONFIG_SQUASHFS_LZ4=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
-- 
1.7.9.5
