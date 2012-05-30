Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:12:29 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43485 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903647Ab2E3WLK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:11:10 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZr6e-00012l-1n; Wed, 30 May 2012 17:11:04 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 3/5] MIPS: Clean up YAMON support for PowerTV platform.
Date:   Wed, 30 May 2012 17:10:53 -0500
Message-Id: <1338415855-11401-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
X-archive-position: 33495
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

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/powertv/init.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index 1cf5abb..d8c6c0b 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -33,42 +33,8 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/mach-powertv/asic.h>
 
-static int *_prom_envp;
 unsigned long _prom_memsize;
 
-/*
- * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
- * This macro take care of sign extension, if running in 64-bit mode.
- */
-#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
-
-char *prom_getenv(char *envname)
-{
-	char *result = NULL;
-
-	if (_prom_envp != NULL) {
-		/*
-		 * Return a pointer to the given environment variable.
-		 * In 64-bit mode: we're using 64-bit pointers, but all pointers
-		 * in the PROM structures are only 32-bit, so we need some
-		 * workarounds, if we are running in 64-bit mode.
-		 */
-		int i, index = 0;
-
-		i = strlen(envname);
-
-		while (prom_envp(index)) {
-			if (strncmp(envname, prom_envp(index), i) == 0) {
-				result = prom_envp(index + 1);
-				break;
-			}
-			index += 2;
-		}
-	}
-
-	return result;
-}
-
 /* TODO: Verify on linux-mips mailing list that the following two  */
 /* functions are correct                                           */
 /* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
@@ -105,9 +71,6 @@ static void __init mips_ejtag_setup(void)
 
 void __init prom_init(void)
 {
-	int prom_argc;
-	char *prom_argv;
-
 	prom_argc = fw_arg0;
 	prom_argv = (char *) fw_arg1;
 	_prom_envp = (int *) fw_arg2;
-- 
1.7.10
