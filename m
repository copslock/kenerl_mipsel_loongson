Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:51:29 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:33813 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825710Ab2JWRsHn5yqz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:07 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so2431916lag.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i9+Vv955zbcU020GMmogBTxnmSgA5j4U43zNYqXHS3s=;
        b=CR+N6oj07AJgsooKH5/wpnFQC/AAFcPZczYz5ioLOxbFu8+Hal0MK7KLPF34AcjbiK
         ptTkWoQHMJPHBWEpAahEWXMeHoW5VV2eH6UEzDQfRjiysiIdP6WsD/9mePqgmAwSUhBE
         Q+42LHXwX1LMgnyBARzhI2UV8na01IWPeSC5SqCNHA6nO3rzGx2Fmd37dIdZDf8F5dCW
         dUtzupZhcVnDvZejFM91AFWPHS4dmNu96jIkmL0U+tJm6+U+SHMudRv89FXxPsCyVov/
         D76IWkWiOAv7REsgaIYRqAZe86J6D6dakLnlgk3qIka4aXjbIyPNVMHj6b61/NRnjDvQ
         uQbg==
Received: by 10.152.129.197 with SMTP id ny5mr9779669lab.43.1351014487265;
        Tue, 23 Oct 2012 10:48:07 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.48.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:48:06 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 11/13] MIPS: JZ4750D: Add Kbuild files
Date:   Tue, 23 Oct 2012 21:43:59 +0400
Message-Id: <1351014241-3207-12-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Add the Kbuild files for the JZ4750D architecture and adds JZ4750D support
to the MIPS Kbuild files.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/Kbuild.platforms |    1 +
 arch/mips/Kconfig          |   11 +++++++++++
 arch/mips/jz4750d/Kconfig  |    5 +++++
 arch/mips/jz4750d/Makefile |   10 ++++++++++
 arch/mips/jz4750d/Platform |    3 +++
 5 files changed, 30 insertions(+)
 create mode 100644 arch/mips/jz4750d/Kconfig
 create mode 100644 arch/mips/jz4750d/Makefile
 create mode 100644 arch/mips/jz4750d/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index d64786d..e7d70fe 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -11,6 +11,7 @@ platforms += dec
 platforms += emma
 platforms += jazz
 platforms += jz4740
+platforms += jz4750d
 platforms += lantiq
 platforms += lasat
 platforms += loongson
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index faf6528..9f35486 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -224,6 +224,16 @@ config MACH_JZ4740
 	select HAVE_CLK
 	select GENERIC_IRQ_CHIP
 
+config MACH_JZ4750D
+	bool "Ingenic JZ4750D based machines"
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SYS_HAS_EARLY_PRINTK
+	select HAVE_CLK
+
 config LANTIQ
 	bool "Lantiq based platforms"
 	select DMA_NONCOHERENT
@@ -843,6 +853,7 @@ source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
 source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
+source "arch/mips/jz4750d/Kconfig"
 source "arch/mips/lantiq/Kconfig"
 source "arch/mips/lasat/Kconfig"
 source "arch/mips/pmc-sierra/Kconfig"
diff --git a/arch/mips/jz4750d/Kconfig b/arch/mips/jz4750d/Kconfig
new file mode 100644
index 0000000..388eea4
--- /dev/null
+++ b/arch/mips/jz4750d/Kconfig
@@ -0,0 +1,5 @@
+choice
+	prompt "Machine type"
+	depends on MACH_JZ4750D
+
+endchoice
diff --git a/arch/mips/jz4750d/Makefile b/arch/mips/jz4750d/Makefile
new file mode 100644
index 0000000..0ecfbd4
--- /dev/null
+++ b/arch/mips/jz4750d/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the Ingenic JZ4750D.
+#
+
+# Object file lists.
+
+obj-y += prom.o irq.o time.o reset.o setup.o
+obj-y += clock.o platform.o timer.o serial.o
+
+obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
diff --git a/arch/mips/jz4750d/Platform b/arch/mips/jz4750d/Platform
new file mode 100644
index 0000000..2e4e050
--- /dev/null
+++ b/arch/mips/jz4750d/Platform
@@ -0,0 +1,3 @@
+platform-$(CONFIG_MACH_JZ4750D)	+= jz4750d/
+cflags-$(CONFIG_MACH_JZ4750D)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4750d
+load-$(CONFIG_MACH_JZ4750D)	+= 0xffffffff80010000
-- 
1.7.10.4
