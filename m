Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2011 03:05:27 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:50790 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492217Ab1HUBFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2011 03:05:23 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1QuwTX-00065O-IK; Sun, 21 Aug 2011 01:05:21 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1QuwTR-000499-Sj; Sun, 21 Aug 2011 03:05:13 +0200
Date:   Sun, 21 Aug 2011 03:05:13 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: [PATCH] mips/loongson: unify compiler flags and load location for
        Loongson 2E and 2F
Message-ID: <20110821010513.GZ2657@mails.so.argh.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        linux-mips@linux-mips.org, debian-mips@lists.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15213

This patch is the first one in a series to unify the kernels for the different
loongson machines. More patches will follow after more testing.

Signed-off-by: Andreas Barth <aba@not.so.argh.org>
---
 arch/mips/Kconfig           |    4 ++--
 arch/mips/loongson/Platform |    9 +++------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b122adc..5d3e753 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1481,7 +1481,7 @@ config CPU_XLR
 	  Netlogic Microsystems XLR/XLS processors.
 endchoice
 
-if CPU_LOONGSON2F
+if CPU_LOONGSON2
 config CPU_NOP_WORKAROUNDS
 	bool
 
@@ -1506,7 +1506,7 @@ config CPU_LOONGSON2F_WORKAROUNDS
 	  systems.
 
 	  If unsure, please say Y.
-endif # CPU_LOONGSON2F
+endif # CPU_LOONGSON2
 
 config SYS_SUPPORTS_ZBOOT
 	bool
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 29692e5..d6471a5 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -4,10 +4,8 @@
 
 # Only gcc >= 4.4 have Loongson specific support
 cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2E) += \
-	$(call cc-option,-march=loongson2e,-march=r4600)
-cflags-$(CONFIG_CPU_LOONGSON2F) += \
-	$(call cc-option,-march=loongson2f,-march=r4600)
+cflags-$(CONFIG_CPU_LOONGSON2) += \
+	$(call cc-option,-march=r4600)
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
   ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
@@ -28,5 +26,4 @@ endif
 
 platform-$(CONFIG_MACH_LOONGSON) += loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
-load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
-load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
+load-$(CONFIG_MACH_LOONGSON) += 0xffffffff80200000
-- 
1.5.6.5
