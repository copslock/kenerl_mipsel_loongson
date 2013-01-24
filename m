Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 18:26:49 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:56052 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833443Ab3AXR0rtHL-3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2013 18:26:47 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TyQZT-0000RJ-Vu; Thu, 24 Jan 2013 11:26:39 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v3] MIPS: microMIPS: Redefine value of BRK_BUG.
Date:   Thu, 24 Jan 2013 11:26:35 -0600
Message-Id: <1359048395-32736-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35547
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
4-bits long. We change the value to 12 instead of 512 so that both
classic and microMIPS kernels build.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/uapi/asm/break.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/break.h b/arch/mips/include/uapi/asm/break.h
index e5fa7b5..73455e9 100644
--- a/arch/mips/include/uapi/asm/break.h
+++ b/arch/mips/include/uapi/asm/break.h
@@ -27,7 +27,7 @@
 #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
 #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
 #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
-#define BRK_BUG		512	/* Used by BUG() */
+#define BRK_BUG		12	/* Used by BUG() */
 #define BRK_KDB		513	/* Used in KDB_ENTER() */
 #define BRK_MEMU	514	/* Used by FPU emulator */
 #define BRK_KPROBE_BP	515	/* Kprobe break */
-- 
1.7.9.5
