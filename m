Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:34:58 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:38723 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023417AbZEOWev (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:34:51 +0100
Received: by pzk40 with SMTP id 40so1376351pzk.22
        for <multiple recipients>; Fri, 15 May 2009 15:34:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=SqhTVztLgS45iwt4hcu7XFxP/ggLCctL3NSSVPWH5II=;
        b=ievWYMeunZ8cScReALGRkf+SCc7GsWOClN+aLXRUYeBgTMwLOQn62rLgF+CbcjUh95
         imge8avPYRG5YockO6jO0fCrMcllSAHr0y6ODFEuyN2Nbsv3qtIQcjr3Zb3bi9zIwHXi
         +q9XQ9z9tY0a/XyY/4yRJaW3ro2yVjcqtmsrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MtoQoLegJPmf0I/zMJX/3aXSmd5OPGWQ5cdp1aB1MLRIY7pXOimEposlGY5jgpnQnR
         OLgC/HOcGZF71oZCCYuxmZZ7VDtXsqAnxKOdMU1u1wCpChg0LLF3a0TyWW9vU2X8Ygj7
         QIjhVh96HZ1M7f+yaS1y2ahdazy/a2q35dDGg=
Received: by 10.142.185.13 with SMTP id i13mr1357715wff.36.1242426884355;
        Fri, 15 May 2009 15:34:44 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 29sm3549255wfg.28.2009.05.15.15.34.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:34:43 -0700 (PDT)
Subject: [PATCH 30/30] loongson: update the default kernel config files
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:34:36 +0800
Message-Id: <1242426876.10164.181.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 65cada173d6bbb122961c981aed250d01be862e6 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 05:42:11 +0800
Subject: [PATCH 30/30] loongson: update the default kernel config files

---
 arch/mips/configs/fuloong2e_defconfig  |   16 +++++++++--
 arch/mips/configs/fuloong2f_defconfig  |   39
++++++++++++++++++++++++++-
 arch/mips/configs/yeeloong2f_defconfig |   44
++++++++++++++++++++++++++-----
 3 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig
b/arch/mips/configs/fuloong2e_defconfig
index 8ce07b1..97e3a4f 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.29.3
-# Sat May 16 03:15:18 2009
+# Sat May 16 05:40:49 2009
 #
 CONFIG_MIPS=y
 
@@ -48,6 +48,7 @@ CONFIG_LOONGSON_SYSTEMS=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_LEMOTE_FULOONG2E=y
 # CONFIG_LEMOTE_FULOONG2F is not set
+# CONFIG_LEMOTE_YEELOONG2F is not set
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -302,12 +303,19 @@ CONFIG_BINFMT_ELF32=y
 #
 # Power management options
 #
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
 CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
+# CONFIG_HIBERNATION is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
 CONFIG_NET=y
 
 #
@@ -903,7 +911,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=m
+CONFIG_KEYBOARD_ATKBD=y
 # CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
@@ -935,7 +943,7 @@ CONFIG_MOUSE_SERIAL=y
 CONFIG_SERIO=y
 CONFIG_SERIO_I8042=y
 CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_PCIPS2=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
@@ -1266,6 +1274,7 @@ CONFIG_FB_RADEON_BACKLIGHT=y
 # CONFIG_FB_ARK is not set
 # CONFIG_FB_PM3 is not set
 # CONFIG_FB_CARMINE is not set
+# CONFIG_FB_SILICONMOTION is not set
 # CONFIG_FB_VIRTUAL is not set
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
@@ -1340,6 +1349,7 @@ CONFIG_SND_PCI=y
 # CONFIG_SND_OXYGEN is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS5535AUDIO is not set
 # CONFIG_SND_DARLA20 is not set
 # CONFIG_SND_GINA20 is not set
 # CONFIG_SND_LAYLA20 is not set
diff --git a/arch/mips/configs/fuloong2f_defconfig
b/arch/mips/configs/fuloong2f_defconfig
index ce14008..f667de6 100644
--- a/arch/mips/configs/fuloong2f_defconfig
+++ b/arch/mips/configs/fuloong2f_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.29.3
-# Sat May 16 03:42:12 2009
+# Sat May 16 05:33:06 2009
 #
 CONFIG_MIPS=y
 
@@ -48,7 +48,10 @@ CONFIG_LOONGSON_SYSTEMS=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 # CONFIG_LEMOTE_FULOONG2E is not set
 CONFIG_LEMOTE_FULOONG2F=y
+# CONFIG_LEMOTE_YEELOONG2F is not set
 CONFIG_CS5536=y
+# CONFIG_CS5536_MFGPT is not set
+CONFIG_UCA_SIZE=0x2000000
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -142,6 +145,10 @@ CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_SPARSEMEM=y
 CONFIG_HAVE_MEMORY_PRESENT=y
 CONFIG_SPARSEMEM_STATIC=y
+
+#
+# Memory hotplug is currently incompatible with Software Suspend
+#
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_PHYS_ADDR_T_64BIT=y
@@ -321,12 +328,34 @@ CONFIG_BINFMT_ELF32=y
 #
 # Power management options
 #
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_PM=y
 # CONFIG_PM_DEBUG is not set
 CONFIG_PM_SLEEP=y
 CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
+CONFIG_HIBERNATION=y
+CONFIG_PM_STD_PARTITION="/dev/hda3"
+
+#
+# CPU Frequency scaling
+#
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_TABLE=y
+# CONFIG_CPU_FREQ_DEBUG is not set
+CONFIG_CPU_FREQ_STAT=y
+# CONFIG_CPU_FREQ_STAT_DETAILS is not set
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_NET=y
 
 #
@@ -1183,6 +1212,7 @@ CONFIG_TOUCHSCREEN_MK712=m
 # CONFIG_TOUCHSCREEN_PENMOUNT is not set
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_WM97XX is not set
 # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
 # CONFIG_TOUCHSCREEN_TSC2007 is not set
@@ -1200,7 +1230,7 @@ CONFIG_INPUT_UINPUT=m
 # Hardware I/O ports
 #
 CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_I8042=y
 CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_PCIPS2=m
 CONFIG_SERIO_LIBPS2=y
@@ -1830,6 +1860,7 @@ CONFIG_FB_TRIDENT=m
 # CONFIG_FB_ARK is not set
 # CONFIG_FB_PM3 is not set
 # CONFIG_FB_CARMINE is not set
+# CONFIG_FB_SILICONMOTION is not set
 CONFIG_FB_VIRTUAL=m
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
@@ -1874,6 +1905,8 @@ CONFIG_SND_SUPPORT_OLD_API=y
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
+CONFIG_SND_VMASTER=y
+CONFIG_SND_AC97_CODEC=m
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_PCI=y
 # CONFIG_SND_AD1889 is not set
@@ -1892,6 +1925,7 @@ CONFIG_SND_PCI=y
 # CONFIG_SND_OXYGEN is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
+CONFIG_SND_CS5535AUDIO=m
 # CONFIG_SND_DARLA20 is not set
 # CONFIG_SND_GINA20 is not set
 # CONFIG_SND_LAYLA20 is not set
@@ -1940,6 +1974,7 @@ CONFIG_SND_PCI=y
 # CONFIG_SND_PCMCIA is not set
 # CONFIG_SND_SOC is not set
 # CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=m
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
diff --git a/arch/mips/configs/yeeloong2f_defconfig
b/arch/mips/configs/yeeloong2f_defconfig
index 01ab19f..da30c8d 100644
--- a/arch/mips/configs/yeeloong2f_defconfig
+++ b/arch/mips/configs/yeeloong2f_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.29.3
-# Sat May 16 04:27:13 2009
+# Sat May 16 05:11:58 2009
 #
 CONFIG_MIPS=y
 
@@ -51,6 +51,8 @@ CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_LEMOTE_YEELOONG2F=y
 CONFIG_CS5536=y
 CONFIG_SYS_HAS_MACH_PROM_INIT_CMDLINE=y
+CONFIG_CS5536_MFGPT=y
+CONFIG_UCA_SIZE=0x400000
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
@@ -63,10 +65,6 @@ CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CMOS_UPDATE=y
 CONFIG_SCHED_OMIT_FRAME_POINTER=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
-CONFIG_CEVT_R4K_LIB=y
-CONFIG_CEVT_R4K=y
-CONFIG_CSRC_R4K_LIB=y
-CONFIG_CSRC_R4K=y
 CONFIG_DMA_NONCOHERENT=y
 CONFIG_DMA_NEED_PCI_MAP_STATE=y
 CONFIG_EARLY_PRINTK=y
@@ -144,6 +142,10 @@ CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_SPARSEMEM=y
 CONFIG_HAVE_MEMORY_PRESENT=y
 CONFIG_SPARSEMEM_STATIC=y
+
+#
+# Memory hotplug is currently incompatible with Software Suspend
+#
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_PHYS_ADDR_T_64BIT=y
@@ -268,7 +270,7 @@ CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_PROBE_INITRD_HEADER is not set
-# CONFIG_FREEZER is not set
+CONFIG_FREEZER=y
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
@@ -304,11 +306,38 @@ CONFIG_BINFMT_ELF32=y
 #
 # Power management options
 #
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_PM=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_VERBOSE=y
-# CONFIG_SUSPEND is not set
+CONFIG_CAN_PM_TRACE=y
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+# CONFIG_PM_TEST_SUSPEND is not set
+CONFIG_SUSPEND_FREEZER=y
+CONFIG_HIBERNATION=y
+CONFIG_PM_STD_PARTITION=""
+
+#
+# CPU Frequency scaling
+#
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_TABLE=y
+# CONFIG_CPU_FREQ_DEBUG is not set
+CONFIG_CPU_FREQ_STAT=y
+# CONFIG_CPU_FREQ_STAT_DETAILS is not set
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
+# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
+# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
+CONFIG_LOONGSON2F_CPU_FREQ=y
 CONFIG_NET=y
 
 #
@@ -1814,6 +1843,7 @@ CONFIG_SND_PCI=y
 # CONFIG_SND_OXYGEN is not set
 # CONFIG_SND_CS4281 is not set
 # CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS5535AUDIO is not set
 # CONFIG_SND_DARLA20 is not set
 # CONFIG_SND_GINA20 is not set
 # CONFIG_SND_LAYLA20 is not set
-- 
1.6.2.1
