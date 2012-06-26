Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:56:34 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55023 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903765Ab2FZEvQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:16 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbY-0002zj-AC; Mon, 25 Jun 2012 23:42:20 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 30/33] MIPS: txx9: Cleanup firmware support for txx9 platforms.
Date:   Mon, 25 Jun 2012 23:41:45 -0500
Message-Id: <1340685708-14408-31-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33834
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
 arch/mips/include/asm/txx9/generic.h |    1 -
 arch/mips/txx9/generic/setup.c       |   56 ++--------------------------------
 2 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/arch/mips/include/asm/txx9/generic.h b/arch/mips/include/asm/txx9/generic.h
index 64887d3..4127a38 100644
--- a/arch/mips/include/asm/txx9/generic.h
+++ b/arch/mips/include/asm/txx9/generic.h
@@ -42,7 +42,6 @@ struct txx9_board_vec {
 };
 extern struct txx9_board_vec *txx9_board_vec;
 extern int (*txx9_irq_dispatch)(int pending);
-const char *prom_getenv(const char *name);
 void txx9_wdt_init(unsigned long base);
 void txx9_wdt_now(unsigned long base);
 void txx9_spi_init(int busid, unsigned long base, int irq);
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index ae77a79..8a053d6 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -25,11 +25,11 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
-#include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
 #include <asm/r4kcache.h>
 #include <asm/sections.h>
+#include <asm/fw/fw.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9tmr.h>
@@ -157,39 +157,6 @@ static struct txx9_board_vec *__init find_board_byname(const char *name)
 	return NULL;
 }
 
-static void __init prom_init_cmdline(void)
-{
-	int argc;
-	int *argv32;
-	int i;			/* Always ignore the "-c" at argv[0] */
-
-	if (fw_arg0 >= CKSEG0 || fw_arg1 < CKSEG0) {
-		/*
-		 * argc is not a valid number, or argv32 is not a valid
-		 * pointer
-		 */
-		argc = 0;
-		argv32 = NULL;
-	} else {
-		argc = (int)fw_arg0;
-		argv32 = (int *)fw_arg1;
-	}
-
-	arcs_cmdline[0] = '\0';
-
-	for (i = 1; i < argc; i++) {
-		char *str = (char *)(long)argv32[i];
-		if (i != 1)
-			strcat(arcs_cmdline, " ");
-		if (strchr(str, ' ')) {
-			strcat(arcs_cmdline, "\"");
-			strcat(arcs_cmdline, str);
-			strcat(arcs_cmdline, "\"");
-		} else
-			strcat(arcs_cmdline, str);
-	}
-}
-
 static int txx9_ic_disable __initdata;
 static int txx9_dc_disable __initdata;
 
@@ -341,7 +308,7 @@ static void __init select_board(void)
 	if (txx9_board_vec)
 		return;
 	/* next, determine by "board" envvar */
-	envstr = prom_getenv("board");
+	envstr = fw_getenv("board");
 	if (envstr) {
 		txx9_board_vec = find_board_byname(envstr);
 		if (txx9_board_vec)
@@ -378,7 +345,7 @@ static void __init select_board(void)
 
 void __init prom_init(void)
 {
-	prom_init_cmdline();
+	fw_init_cmdline();
 	preprocess_cmdline();
 	select_board();
 
@@ -401,23 +368,6 @@ const char *get_system_type(void)
 	return txx9_system_type;
 }
 
-const char *__init prom_getenv(const char *name)
-{
-	const s32 *str;
-
-	if (fw_arg2 < CKSEG0)
-		return NULL;
-
-	str = (const s32 *)fw_arg2;
-	/* YAMON style ("name", "value" pairs) */
-	while (str[0] && str[1]) {
-		if (!strcmp((const char *)(unsigned long)str[0], name))
-			return (const char *)(unsigned long)str[1];
-		str += 2;
-	}
-	return NULL;
-}
-
 static void __noreturn txx9_machine_halt(void)
 {
 	local_irq_disable();
-- 
1.7.10.3
