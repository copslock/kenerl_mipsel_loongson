Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:50:52 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60238 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816191Ab2LGEuvLxU80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:50:51 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgptb-0007Jd-4v; Thu, 06 Dec 2012 22:50:43 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Remove usage of CSRC_R4K_LIB config option.
Date:   Thu,  6 Dec 2012 22:50:37 -0600
Message-Id: <1354855837-28187-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

The CSRC_R4K_LIB is redundant and can safely be removed.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig            |    6 +-----
 arch/mips/include/asm/time.h |    2 +-
 arch/mips/kernel/Makefile    |    2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dba9390..40cb646 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -54,7 +54,7 @@ config MIPS_ALCHEMY
 	bool "Alchemy processor based machines"
 	select 64BIT_PHYS_ADDR
 	select CEVT_R4K_LIB
-	select CSRC_R4K_LIB
+	select CSRC_R4K
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -946,11 +946,7 @@ config CSRC_IOASIC
 config CSRC_POWERTV
 	bool
 
-config CSRC_R4K_LIB
-	bool
-
 config CSRC_R4K
-	select CSRC_R4K_LIB
 	bool
 
 config CSRC_SB1250
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index bc14447..6be93a4 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -71,7 +71,7 @@ static inline int mips_clockevent_init(void)
 /*
  * Initialize the count register as a clocksource
  */
-#ifdef CONFIG_CSRC_R4K_LIB
+#ifdef CONFIG_CSRC_R4K
 extern int init_r4k_clocksource(void);
 #endif
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 8b28bc4..e4260b6 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
 obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
 obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
 obj-$(CONFIG_CSRC_POWERTV)	+= csrc-powertv.o
-obj-$(CONFIG_CSRC_R4K_LIB)	+= csrc-r4k.o
+obj-$(CONFIG_CSRC_R4K)		+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
-- 
1.7.9.5
