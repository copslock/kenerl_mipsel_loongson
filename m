Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:52:49 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60255 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822126Ab2LGEwsT3LWC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:52:48 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgpvW-0007KS-DB; Thu, 06 Dec 2012 22:52:42 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: microMIPS: Add breakpoints.
Date:   Thu,  6 Dec 2012 22:52:37 -0600
Message-Id: <1354855957-28353-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35207
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

Redefine BRK_BUG and BRK_KDB values when using a pure microMIPS
kernel. Add MM_BRK_MEMU for running microMIPS user binaries on
a standard kernel.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/break.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
index 9161e68..c4744aa 100644
--- a/arch/mips/include/asm/break.h
+++ b/arch/mips/include/asm/break.h
@@ -27,9 +27,16 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
+
+#ifdef CONFIG_CPU_MICROMIPS
+#define BRK_BUG		12	/* Used by BUG() */
+#define BRK_KDB		13	/* Used in KDB_ENTER() */
+#else
 #define BRK_BUG		512	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
+#endif
 #define BRK_MEMU	514	/* Used by FPU emulator */
+#define MM_BRK_MEMU	14	/* Used by FPU emulator for microMIPS */
 #define BRK_KPROBE_BP	515	/* Kprobe break */
 #define BRK_KPROBE_SSTEPBP 516	/* Kprobe single step software implementation */
 #define BRK_MULOVF	1023	/* Multiply overflow */
-- 
1.7.9.5
