Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:20:49 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:60124 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492984AbZJPGSN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:18:13 +0200
Received: by mail-px0-f187.google.com with SMTP id 17so681981pxi.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:18:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=+Agolxq2Fv6B+jAXGy+s5eAP4prEVS/j7JusHGHzyOc=;
        b=oNsnn65S/CSIyV4+Xhmgz+0/9VH/hTJlYbysjQ2AZLYyUadfOllH/bIRqc8JWRcbhd
         rNZdHjVqa0a4eFjwAx4nUI6aXdEClpZWjA7yqXaDWVBcKRjt6i84/VmtvZzrjtL6qX8/
         yx7gEn56M6tZGND0JfSOabD8P1JyKWhCyVK6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EL4r/Huy61AKNVvaHGxXyvQR4MwT8k5NU7D7duhb+gQD8nOIhyyYXAOhvq3VdKks0t
         NAgqj23CIinyQ7vhCNichFuQ69L1RnA3TBTSxovK2lam0RGpLKq9+WOxD3I/al/sjgCP
         PQ7w+tst/hNOqzCdPg0sA9ELfzf3B7q1v4JVQ=
Received: by 10.114.249.24 with SMTP id w24mr282449wah.146.1255673892226;
        Thu, 15 Oct 2009 23:18:12 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.18.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:18:11 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 7/7] [loongson] fuloong2e: update config file
Date:	Fri, 16 Oct 2009 14:17:20 +0800
Message-Id: <3f07a3ecf42181a5642d734d070da4676cad51f3.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <2aaf6778010c608858cf7af1bd46d226f89bf355.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
 <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
 <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
 <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
 <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
 <35c04cb5cd3aa4c2d2fc3cbb471304a7f3434ebb.1255673756.git.wuzhangjin@gmail.com>
 <2aaf6778010c608858cf7af1bd46d226f89bf355.1255673756.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch enable Hibernation support by default, and choose SPARSEMEM
memory model to avoid Hibernation failure with FLATMEM and also save
memory wasted by FLATMEM.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/configs/fuloong2e_defconfig |   93 +++++++++++++++++++++-----------
 1 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 0197f0d..b3626de 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.31-rc1
-# Thu Jul  2 22:37:00 2009
+# Linux kernel version: 2.6.32-rc4
+# Fri Oct 16 13:18:01 2009
 #
 CONFIG_MIPS=y
 
@@ -12,6 +12,7 @@ CONFIG_MIPS=y
 # CONFIG_AR7 is not set
 # CONFIG_BASLER_EXCITE is not set
 # CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
@@ -105,6 +106,8 @@ CONFIG_CPU_LOONGSON2E=y
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
 # CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_SUPPORTS_ZBOOT=y
+CONFIG_SYS_SUPPORTS_ZBOOT_UART16550=y
 CONFIG_CPU_LOONGSON2=y
 CONFIG_SYS_HAS_CPU_LOONGSON2E=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
@@ -135,12 +138,16 @@ CONFIG_SYS_SUPPORTS_HIGHMEM=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
-CONFIG_FLATMEM_MANUAL=y
+# CONFIG_FLATMEM_MANUAL is not set
 # CONFIG_DISCONTIGMEM_MANUAL is not set
-# CONFIG_SPARSEMEM_MANUAL is not set
-CONFIG_FLATMEM=y
-CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_SPARSEMEM=y
+CONFIG_HAVE_MEMORY_PRESENT=y
 CONFIG_SPARSEMEM_STATIC=y
+
+#
+# Memory hotplug is currently incompatible with Software Suspend
+#
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_PHYS_ADDR_T_64BIT=y
@@ -148,6 +155,7 @@ CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
 CONFIG_HAVE_MLOCK=y
 CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
@@ -180,6 +188,12 @@ CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION="-fuloong2e"
 # CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_BZIP2=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_KERNEL_GZIP=y
+# CONFIG_KERNEL_BZIP2 is not set
+# CONFIG_KERNEL_LZMA is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
@@ -193,11 +207,12 @@ CONFIG_BSD_PROCESS_ACCT=y
 #
 # RCU Subsystem
 #
-CONFIG_CLASSIC_RCU=y
-# CONFIG_TREE_RCU is not set
-# CONFIG_PREEMPT_RCU is not set
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=64
+# CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
-# CONFIG_PREEMPT_RCU_TRACE is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -235,18 +250,16 @@ CONFIG_SHMEM=y
 CONFIG_AIO=y
 
 #
-# Performance Counters
+# Kernel Performance Events And Counters
 #
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_PCI_QUIRKS=y
-# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
 CONFIG_PROFILING=y
 CONFIG_TRACEPOINTS=y
-CONFIG_MARKERS=y
 CONFIG_OPROFILE=m
 CONFIG_HAVE_OPROFILE=y
 CONFIG_HAVE_SYSCALL_WRAPPERS=y
@@ -255,8 +268,8 @@ CONFIG_HAVE_SYSCALL_WRAPPERS=y
 # GCOV-based kernel profiling
 #
 # CONFIG_GCOV_KERNEL is not set
-# CONFIG_SLOW_WORK is not set
-# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_SLOW_WORK=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 CONFIG_BASE_SMALL=0
@@ -283,7 +296,7 @@ CONFIG_IOSCHED_CFQ=y
 CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
-# CONFIG_FREEZER is not set
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -321,9 +334,14 @@ CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
 # CONFIG_SUSPEND is not set
-# CONFIG_HIBERNATION is not set
+CONFIG_HIBERNATION_NVS=y
+CONFIG_HIBERNATION=y
+CONFIG_PM_STD_PARTITION="/dev/hda3"
+# CONFIG_PM_RUNTIME is not set
 CONFIG_NET=y
+CONFIG_COMPAT_NETLINK_MESSAGES=y
 
 #
 # Networking options
@@ -442,6 +460,7 @@ CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 # CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -473,6 +492,7 @@ CONFIG_NET_CLS_ROUTE=y
 # CONFIG_AF_RXRPC is not set
 CONFIG_WIRELESS=y
 # CONFIG_CFG80211 is not set
+CONFIG_CFG80211_DEFAULT_PS_VALUE=0
 CONFIG_WIRELESS_OLD_REGULATORY=y
 CONFIG_WIRELESS_EXT=y
 CONFIG_WIRELESS_EXT_SYSFS=y
@@ -481,7 +501,6 @@ CONFIG_WIRELESS_EXT_SYSFS=y
 #
 # CFG80211 needs to be enabled for MAC80211
 #
-CONFIG_MAC80211_DEFAULT_PS_VALUE=0
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 CONFIG_NET_9P=m
@@ -495,6 +514,7 @@ CONFIG_NET_9P=m
 # Generic Driver Options
 #
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=m
@@ -504,9 +524,9 @@ CONFIG_EXTRA_FIRMWARE=""
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=m
 # CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_CONCAT is not set
 # CONFIG_MTD_PARTITIONS is not set
-# CONFIG_MTD_TESTS is not set
 
 #
 # User Modules And Translation Layers
@@ -820,6 +840,7 @@ CONFIG_8139TOO=y
 # CONFIG_SUNDANCE is not set
 # CONFIG_TLAN is not set
 # CONFIG_KS8842 is not set
+# CONFIG_KS8851_MLL is not set
 # CONFIG_VIA_RHINE is not set
 # CONFIG_SC92031 is not set
 # CONFIG_ATL2 is not set
@@ -867,10 +888,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_SFC is not set
 # CONFIG_BE2NET is not set
 # CONFIG_TR is not set
-
-#
-# Wireless LAN
-#
+CONFIG_WLAN=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 
@@ -886,6 +904,7 @@ CONFIG_CHELSIO_T3_DEPENDS=y
 # CONFIG_USB_PEGASUS is not set
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
+# CONFIG_USB_CDC_PHONET is not set
 # CONFIG_WAN is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
@@ -933,12 +952,16 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
 CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 CONFIG_MOUSE_PS2_ALPS=y
@@ -946,6 +969,7 @@ CONFIG_MOUSE_PS2_LOGIPS2PP=y
 CONFIG_MOUSE_PS2_SYNAPTICS=y
 CONFIG_MOUSE_PS2_TRACKPOINT=y
 # CONFIG_MOUSE_PS2_ELANTECH is not set
+# CONFIG_MOUSE_PS2_SENTELIC is not set
 # CONFIG_MOUSE_PS2_TOUCHKIT is not set
 CONFIG_MOUSE_SERIAL=y
 # CONFIG_MOUSE_APPLETOUCH is not set
@@ -1015,6 +1039,7 @@ CONFIG_RTC=y
 CONFIG_DEVPORT=y
 CONFIG_I2C=m
 CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_HELPER_AUTO=y
 
@@ -1070,9 +1095,6 @@ CONFIG_I2C_VIAPRO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_PCF8575 is not set
-# CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
@@ -1088,7 +1110,6 @@ CONFIG_I2C_VIAPRO=m
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
-# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
@@ -1105,6 +1126,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_PCF50633 is not set
 # CONFIG_AB3100_CORE is not set
@@ -1114,6 +1136,7 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Graphics support
 #
+CONFIG_VGA_ARB=y
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
@@ -1198,6 +1221,7 @@ CONFIG_FONT_8x16=y
 # CONFIG_LOGO is not set
 CONFIG_SOUND=y
 CONFIG_SOUND_OSS_CORE=y
+CONFIG_SOUND_OSS_CORE_PRECLAIM=y
 CONFIG_SND=m
 CONFIG_SND_TIMER=m
 CONFIG_SND_PCM=m
@@ -1304,7 +1328,6 @@ CONFIG_SND_USB=y
 CONFIG_AC97_BUS=m
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
 CONFIG_HIDRAW=y
 
 #
@@ -1356,6 +1379,7 @@ CONFIG_USB_EHCI_TT_NEWSCHED=y
 # CONFIG_USB_OXU210HP_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 CONFIG_USB_ISP1760_HCD=m
+# CONFIG_USB_ISP1362_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
@@ -1453,6 +1477,7 @@ CONFIG_UIO_CIF=m
 # CONFIG_UIO_SMX is not set
 # CONFIG_UIO_AEC is not set
 # CONFIG_UIO_SERCOS3 is not set
+# CONFIG_UIO_PCI_GENERIC is not set
 
 #
 # TI VLYNQ
@@ -1469,10 +1494,10 @@ CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_EXT4_FS=m
-CONFIG_EXT4DEV_COMPAT=y
 CONFIG_EXT4_FS_XATTR=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_EXT4_DEBUG is not set
 CONFIG_FS_XIP=y
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
@@ -1489,6 +1514,7 @@ CONFIG_FS_POSIX_ACL=y
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
 CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
@@ -1557,7 +1583,6 @@ CONFIG_OMFS_FS=m
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NILFS2_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
@@ -1666,6 +1691,7 @@ CONFIG_ENABLE_WARN_DEPRECATED=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_FRAME_WARN=2048
 # CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
@@ -1678,6 +1704,7 @@ CONFIG_NOP_TRACER=y
 CONFIG_RING_BUFFER=y
 CONFIG_EVENT_TRACING=y
 CONFIG_CONTEXT_SWITCH_TRACER=y
+CONFIG_RING_BUFFER_ALLOW_SWAP=y
 CONFIG_TRACING=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
@@ -1742,11 +1769,13 @@ CONFIG_CRYPTO_XTS=m
 #
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_VMAC is not set
 
 #
 # Digest
 #
 # CONFIG_CRYPTO_CRC32C is not set
+CONFIG_CRYPTO_GHASH=m
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=m
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
-- 
1.6.2.1
