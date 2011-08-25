Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2011 10:01:07 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:46655 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491085Ab1HYIBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Aug 2011 10:01:03 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1QwUs0-0000Nc-WE; Thu, 25 Aug 2011 08:01:01 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1QwUru-0002iq-Nb; Thu, 25 Aug 2011 10:00:54 +0200
Date:   Thu, 25 Aug 2011 10:00:54 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: [PATCH] mips/loongson: unify compiler flags and load location for
        Loongson 2E and 2F
Message-ID: <20110825080054.GA10459@mails.so.argh.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        linux-mips@linux-mips.org, debian-mips@lists.debian.org
References: <20110821010513.GZ2657@mails.so.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110821010513.GZ2657@mails.so.argh.org>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18531

This patch starts to merge the Loongson 2E and 2F code together with the
goal to produce a binary kernel image that can run on both machines. As
code compiled for 2E cannot run on 2F and vice versa, the usage of cpu
dependend code is optionally now (and old behaviour is default).

The load address is unified as well, and the 2F workarounds can be enabled
while compiling on a 2E machine (disabled there by default).

Signed-off-by: Andreas Barth <aba@not.so.argh.org>
---
 arch/mips/Kconfig           |   22 +++++++++++++++++++---
 arch/mips/loongson/Platform |   15 +++++++++++----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b122adc..b7b65fb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1481,7 +1481,7 @@ config CPU_XLR
 	  Netlogic Microsystems XLR/XLS processors.
 endchoice
 
-if CPU_LOONGSON2F
+if CPU_LOONGSON2
 config CPU_NOP_WORKAROUNDS
 	bool
 
@@ -1490,7 +1490,7 @@ config CPU_JUMP_WORKAROUNDS
 
 config CPU_LOONGSON2F_WORKAROUNDS
 	bool "Loongson 2F Workarounds"
-	default y
+	default y if !CPU_LOONGSON2E
 	select CPU_NOP_WORKAROUNDS
 	select CPU_JUMP_WORKAROUNDS
 	help
@@ -1506,7 +1506,23 @@ config CPU_LOONGSON2F_WORKAROUNDS
 	  systems.
 
 	  If unsure, please say Y.
-endif # CPU_LOONGSON2F
+
+config CPU_LOONGSON2E_CODE
+	bool "Loongson 2E-only code"
+        default y
+	depends on SYS_HAS_CPU_LOONGSON2E
+        help
+          Compile with Loongson 2E specific compiler options. This prevents
+          the kernel to run on other cpus.
+
+config CPU_LOONGSON2F_CODE
+	bool "Loongson 2F-only code"
+        default y
+	depends on SYS_HAS_CPU_LOONGSON2F
+        help
+          Compile with Loongson 2F specific compiler options. This prevents
+          the kernel to run on other cpus.
+endif # CPU_LOONGSON2
 
 config SYS_SUPPORTS_ZBOOT
 	bool
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 29692e5..df52393 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -4,10 +4,18 @@
 
 # Only gcc >= 4.4 have Loongson specific support
 cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2E) += \
+ifdef CONFIG_CPU_LOONGSON2E_CODE
+    cflags-$(CONFIG_CPU_LOONGSON2) += \
 	$(call cc-option,-march=loongson2e,-march=r4600)
-cflags-$(CONFIG_CPU_LOONGSON2F) += \
+else
+  ifdef CONFIG_CPU_LOONGSON2F_CODE
+    cflags-$(CONFIG_CPU_LOONGSON2) += \
 	$(call cc-option,-march=loongson2f,-march=r4600)
+  else
+    cflags-$(CONFIG_CPU_LOONGSON2) += \
+	$(call cc-option,-march=r4600)
+  endif
+endif
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
   ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
@@ -28,5 +36,4 @@ endif
 
 platform-$(CONFIG_MACH_LOONGSON) += loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
-load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
-load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
+load-$(CONFIG_MACH_LOONGSON) += 0xffffffff80200000
-- 
1.5.6.5
