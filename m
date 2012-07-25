Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2012 08:07:51 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:41249 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903468Ab2GYGHA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2012 08:07:00 +0200
Received: by pbbrq13 with SMTP id rq13so940607pbb.36
        for <multiple recipients>; Tue, 24 Jul 2012 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=80p4AWDn8gStwztO1Y57NIC1eU+Sr9lhkR8jhE+KrPc=;
        b=kjLOqH2xFEdMyB+gfR3c6+4ySyz5jjfNce3EspRurP2lqPDtMjVTHcGCDpyi51zRdJ
         16TqdP1+vA9sGE77Xg/+qVlvFYFfk9jgGPru7RDuDNR2nXgtEzYSmCjlrMyF5EpUgZqA
         FYyfuQb5Zjc98HJlz8oAseyCF2blJX05w7w2qb1VTmCumE62Gv9hyamQlILN+ri38mBF
         JDYS2Nq1MxKe35hVAJPLH51ef5nCEgmZwuaU0hGDAKCGOwJ/tF34BNYLTNhqqafQd6ma
         a3CWnr3ACJEQisZNxtslLOYwWhuJUDEP3F6tvjkgMctihwHZNF3vqLwvhbQD5APOUylu
         UWTg==
Received: by 10.68.136.229 with SMTP id qd5mr50802210pbb.2.1343196413706;
        Tue, 24 Jul 2012 23:06:53 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id pj10sm13694271pbb.46.2012.07.24.23.06.50
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:06:53 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     wuzhangjin@gmail.com, zhzhl555@gmail.com,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V7 3/4] (Updated) MIPS: Add Makefile and Kconfig for Loongson1B
Date:   Wed, 25 Jul 2012 14:06:40 +0800
Message-Id: <1343196401-6435-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1343196401-6435-1-git-send-email-keguang.zhang@gmail.com>
References: <1343196401-6435-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 33984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch adds Makefile and Kconfig related to Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V7(updated):
	Change the load address of kernel to 0xffffffff80100000.
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
index 08dfc79..61e1459 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -265,6 +265,17 @@ config MACH_LOONGSON
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
@@ -838,6 +849,7 @@ source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson/Kconfig"
+source "arch/mips/loongson1/Kconfig"
 source "arch/mips/netlogic/Kconfig"
 
 endmenu
@@ -1219,6 +1231,14 @@ config CPU_LOONGSON2F
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
@@ -1548,6 +1568,14 @@ config CPU_LOONGSON2
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
 config CPU_BMIPS
 	bool
 	select CPU_MIPS32
@@ -1566,6 +1594,9 @@ config SYS_HAS_CPU_LOONGSON2F
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
index 0000000..99bdefe
--- /dev/null
+++ b/arch/mips/loongson1/Platform
@@ -0,0 +1,7 @@
+cflags-$(CONFIG_CPU_LOONGSON1)  += \
+	$(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
+	-Wa,-mips32r2 -Wa,--trap
+
+platform-$(CONFIG_MACH_LOONGSON1)	+= loongson1/
+cflags-$(CONFIG_MACH_LOONGSON1)		+= -I$(srctree)/arch/mips/include/asm/mach-loongson1
+load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
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
