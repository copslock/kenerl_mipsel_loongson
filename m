Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:57:34 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55028 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903788Ab2FZEv3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:29 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbX-0002zj-3z; Mon, 25 Jun 2012 23:42:19 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 28/33] MIPS: RB532: Cleanup firmware support for RB532 platform.
Date:   Mon, 25 Jun 2012 23:41:43 -0500
Message-Id: <1340685708-14408-29-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33836
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
 arch/mips/rb532/prom.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index d7c26d0..54f5399 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -33,7 +33,7 @@
 #include <linux/ioport.h>
 #include <linux/blkdev.h>
 
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-rc32434/ddr.h>
 #include <asm/mach-rc32434/prom.h>
 
@@ -62,41 +62,40 @@ static inline int match_tag(char *arg, const char *tag)
 static inline unsigned long tag2ul(char *arg, const char *tag)
 {
 	char *num;
+	long val;
+	int tmp;
 
 	num = arg + strlen(tag);
-	return simple_strtoul(num, 0, 10);
+	tmp = kstrtol(num, 0, &val);
+	return (unsigned long)val;
 }
 
 void __init prom_setup_cmdline(void)
 {
 	static char cmd_line[COMMAND_LINE_SIZE] __initdata;
 	char *cp, *board;
-	int prom_argc;
-	char **prom_argv, **prom_envp;
 	int i;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
+	fw_init_cmdline();
 
 	cp = cmd_line;
 		/* Note: it is common that parameters start
 		 * at argv[1] and not argv[0],
 		 * however, our elf loader starts at [0] */
-	for (i = 0; i < prom_argc; i++) {
-		if (match_tag(prom_argv[i], FREQ_TAG)) {
-			idt_cpu_freq = tag2ul(prom_argv[i], FREQ_TAG);
+	for (i = 0; i < fw_argc; i++) {
+		if (match_tag(fw_argv(i), FREQ_TAG)) {
+			idt_cpu_freq = tag2ul(fw_argv(i), FREQ_TAG);
 			continue;
 		}
 #ifdef IGNORE_CMDLINE_MEM
 		/* parses out the "mem=xx" arg */
-		if (match_tag(prom_argv[i], MEM_TAG))
+		if (match_tag(fw_argv(i), MEM_TAG))
 			continue;
 #endif
 		if (i > 0)
 			*(cp++) = ' ';
-		if (match_tag(prom_argv[i], BOARD_TAG)) {
-			board = prom_argv[i] + strlen(BOARD_TAG);
+		if (match_tag(fw_argv(i), BOARD_TAG)) {
+			board = fw_argv(i) + strlen(BOARD_TAG);
 
 			if (match_tag(board, BOARD_RB532A))
 				mips_machtype = MACH_MIKROTIK_RB532A;
@@ -104,8 +103,8 @@ void __init prom_setup_cmdline(void)
 				mips_machtype = MACH_MIKROTIK_RB532;
 		}
 
-		strcpy(cp, prom_argv[i]);
-		cp += strlen(prom_argv[i]);
+		strcpy(cp, fw_argv(i));
+		cp += strlen(fw_argv(i));
 	}
 	*(cp++) = ' ';
 
-- 
1.7.10.3
