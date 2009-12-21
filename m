Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2009 16:49:12 +0100 (CET)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:46452 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494900AbZLUPtI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Dec 2009 16:49:08 +0100
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 3B59F56421D;
        Tue, 22 Dec 2009 00:49:02 +0900 (JST)
Received: from localhost.localdomain (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Tue, 22 Dec 2009 00:49:02 +0900 (JST)
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] TXx9: Cleanup builtin-cmdline processing
Date:   Tue, 22 Dec 2009 00:48:57 +0900
Message-Id: <1261410537-7921-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Since commit 6acc7d ("Fix and enhance built-in kernel command line")
arcs_cmdline[] does not contain built-in command line.  The commit
introduce CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE to control
built-in command line, and now we can use them instead of
platform-specific built-in command line processing.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 06e801c..e27809b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -160,7 +160,6 @@ static void __init prom_init_cmdline(void)
 	int argc;
 	int *argv32;
 	int i;			/* Always ignore the "-c" at argv[0] */
-	static char builtin[COMMAND_LINE_SIZE] __initdata;
 
 	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
 		/*
@@ -174,20 +173,6 @@ static void __init prom_init_cmdline(void)
 		argv32 = (int *)fw_arg1;
 	}
 
-	/* ignore all built-in args if any f/w args given */
-	/*
-	 * But if built-in strings was started with '+', append them
-	 * to command line args.  If built-in was started with '-',
-	 * ignore all f/w args.
-	 */
-	builtin[0] = '\0';
-	if (arcs_cmdline[0] == '+')
-		strcpy(builtin, arcs_cmdline + 1);
-	else if (arcs_cmdline[0] == '-') {
-		strcpy(builtin, arcs_cmdline + 1);
-		argc = 0;
-	} else if (argc <= 1)
-		strcpy(builtin, arcs_cmdline);
 	arcs_cmdline[0] = '\0';
 
 	for (i = 1; i < argc; i++) {
@@ -201,12 +186,6 @@ static void __init prom_init_cmdline(void)
 		} else
 			strcat(arcs_cmdline, str);
 	}
-	/* append saved builtin args */
-	if (builtin[0]) {
-		if (arcs_cmdline[0])
-			strcat(arcs_cmdline, " ");
-		strcat(arcs_cmdline, builtin);
-	}
 }
 
 static int txx9_ic_disable __initdata;
-- 
1.5.6.5
