Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 18:37:28 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:42803 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833221Ab3AQRhHTDeme (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 18:37:07 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TvtOf-0003Gv-Bc; Thu, 17 Jan 2013 11:37:01 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: microMIPS: Redefine value of BRK_BUG.
Date:   Thu, 17 Jan 2013 11:36:56 -0600
Message-Id: <1358444216-17213-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35484
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

The BRK_BUG value is used in the BUG and __BUG_ON inline macros. For
standard MIPS cores the code in the 'tne' instruction is 10-bits long.
In microMIPS, the 'tne' instruction is recoded and the code can only be
4-bits long. We use the value of 12 instead of 512 when building a
microMIPS kernel.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/break.h |    1 +
 arch/mips/include/asm/bug.h   |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 9161e68..df9d090 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -27,6 +27,7 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
+#define BRK_BUG_MM	12	/* Used by BUG() in microMIPS mode */
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
 #define BRK_MEMU	514	/* Used by FPU emulator */
diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 540c98a..b716fb9 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -7,6 +7,10 @@
 #ifdef CONFIG_BUG
 
 #include <asm/break.h>
+#ifdef CONFIG_CPU_MICROMIPS
+#undef BRK_BUG
+#define BRK_BUG		BRK_BUG_MM
+#endif
 
 static inline void __noreturn BUG(void)
 {
-- 
1.7.9.5
