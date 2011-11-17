Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 10:40:52 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:42636 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904023Ab1KQJkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 10:40:13 +0100
Received: by ywp31 with SMTP id 31so955238ywp.36
        for <multiple recipients>; Thu, 17 Nov 2011 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qoyTcWdG+n2MA/xHI6UNjA3MzsoNz0fOUIWvyN55GFE=;
        b=BkV/nh24LuLuh4Uv1IRA9lHmmbQCoqVcARlcIJizEhsUaliTjvmzAuLkBXVUvy/Dwj
         daW4D4QcubgeSRJ0M6xFU+PDEKGxawxDfYBDdTUHuprBcoDf8QTu5qk3ZC9I0VEyX+uW
         Ptrucq+NRVrOOmbplEARHrLHKtoSc+twWlYLk=
Received: by 10.236.124.105 with SMTP id w69mr7803240yhh.2.1321522807212;
        Thu, 17 Nov 2011 01:40:07 -0800 (PST)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id j25sm5198496yhm.12.2011.11.17.01.39.57
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:40:06 -0800 (PST)
From:   keguang.zhang@gmail.com
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, zhzhl555@gmail.com, peppe.cavallaro@st.com,
        wuzhangjin@gmail.com, r0bertz@gentoo.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V3 3/5] MIPS: Add Makefile and Kconfig for Loongson1B
Date:   Thu, 17 Nov 2011 17:39:06 +0800
Message-Id: <1321522748-21391-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1321522748-21391-1-git-send-email-keguang.zhang@gmail.com>
References: <1321522748-21391-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 31716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14293

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds Makefile and Kconfig related to Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/Kbuild.platforms          |    1 +
 arch/mips/Kconfig                   |   31 +++++++++++++++++++++++++++++++
 arch/mips/loongson1/Kconfig         |   21 +++++++++++++++++++++
 arch/mips/loongson1/Makefile        |   11 +++++++++++
 arch/mips/loongson1/Platform        |    7 +++++++
 arch/mips/loongson1/common/Makefile |    5 +++++
 arch/mips/loongson1/ls1b/Makefile   |    5 +++++
 7 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson1/Kconfig
 create mode 100644 arch/mips/loongson1/Makefile
 create mode 100644 arch/mips/loongson1/Platform
 create mode 100644 arch/mips/loongson1/common/Makefile
 create mode 100644 arch/mips/loongson1/ls1b/Makefile

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 5ce8029..d64786d 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -14,6 +14,7 @@ platforms += jz4740
 platforms += lantiq
 platforms += lasat
 platforms += loongson
+platforms += loongson1
 platforms += mipssim
 platforms += mti-malta
 platforms += netlogic
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d9b8ea8..4c6ad4f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -262,6 +262,17 @@ config MACH_LOONGSON
 	  Chinese Academy of Sciences (CAS) in the People's Republic
 	  of China. The chief architect is Professor Weiwu Hu.
 
+config MACH_LOONGSON1
+	bool "Loongson1 family of machines"
+	select SYS_SUPPORTS_ZBOOT
+	help
+	  This enables the support of Loongson1 family of machines.
+
+	  Loongson1 is a family of 32-bit MIPS-compatible SoCs.
+	  developed at Institute of Computing Technology (ICT),
+	  Chinese Academy of Sciences (CAS) in the People's Republic
+	  of China.
+
 config MIPS_MALTA
 	bool "MIPS Malta board"
 	select ARCH_MAY_HAVE_PC_FDC
@@ -808,6 +819,7 @@ source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson/Kconfig"
+source "arch/mips/loongson1/Kconfig"
 source "arch/mips/netlogic/Kconfig"
 
 endmenu
@@ -1201,6 +1213,14 @@ config CPU_LOONGSON2F
 	  have a similar programming interface with FPGA northbridge used in
 	  Loongson2E.
 
+config CPU_LOONGSON1B
+	bool "Loongson 1B"
+	depends on SYS_HAS_CPU_LOONGSON1B
+	select CPU_LOONGSON1
+	help
+	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
+	  release 2 instruction set.
+
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
 	depends on SYS_HAS_CPU_MIPS32_R1
@@ -1529,6 +1549,14 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 
+config CPU_LOONGSON1
+	bool
+	select CPU_MIPS32
+	select CPU_MIPSR2
+	select CPU_HAS_PREFETCH
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+
 config SYS_HAS_CPU_LOONGSON2E
 	bool
 
@@ -1538,6 +1566,9 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON1B
+	bool
+
 config SYS_HAS_CPU_MIPS32_R1
 	bool
 
diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
new file mode 100644
index 0000000..237fa21
--- /dev/null
+++ b/arch/mips/loongson1/Kconfig
@@ -0,0 +1,21 @@
+if MACH_LOONGSON1
+
+choice
+	prompt "Machine Type"
+
+config LOONGSON1_LS1B
+	bool "Loongson LS1B board"
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON1B
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+
+endchoice
+
+endif # MACH_LOONGSON1
diff --git a/arch/mips/loongson1/Makefile b/arch/mips/loongson1/Makefile
new file mode 100644
index 0000000..e9123c2
--- /dev/null
+++ b/arch/mips/loongson1/Makefile
@@ -0,0 +1,11 @@
+#
+# Common code for all Loongson1 based systems
+#
+
+obj-$(CONFIG_MACH_LOONGSON1) += common/
+
+#
+# Loongson LS1B board
+#
+
+obj-$(CONFIG_LOONGSON1_LS1B)  += ls1b/
diff --git a/arch/mips/loongson1/Platform b/arch/mips/loongson1/Platform
new file mode 100644
index 0000000..92804c6
--- /dev/null
+++ b/arch/mips/loongson1/Platform
@@ -0,0 +1,7 @@
+cflags-$(CONFIG_CPU_LOONGSON1)  += \
+	$(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
+	-Wa,-mips32r2 -Wa,--trap
+
+platform-$(CONFIG_MACH_LOONGSON1)	+= loongson1/
+cflags-$(CONFIG_MACH_LOONGSON1)		+= -I$(srctree)/arch/mips/include/asm/mach-loongson1
+load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80010000
diff --git a/arch/mips/loongson1/common/Makefile b/arch/mips/loongson1/common/Makefile
new file mode 100644
index 0000000..b279770
--- /dev/null
+++ b/arch/mips/loongson1/common/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for common code of loongson1 based machines.
+#
+
+obj-y	+= clock.o irq.o platform.o prom.o reset.o setup.o
diff --git a/arch/mips/loongson1/ls1b/Makefile b/arch/mips/loongson1/ls1b/Makefile
new file mode 100644
index 0000000..891eac4
--- /dev/null
+++ b/arch/mips/loongson1/ls1b/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for loongson1B based machines.
+#
+
+obj-y += board.o
-- 
1.7.1
