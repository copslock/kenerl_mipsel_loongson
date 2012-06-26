Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:44:58 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54955 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903757Ab2FZEmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:42:12 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbK-0002zj-CO; Mon, 25 Jun 2012 23:42:06 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 06/33] MIPS: ath79: Cleanup firmware support for the ath79 platform.
Date:   Mon, 25 Jun 2012 23:41:21 -0500
Message-Id: <1340685708-14408-7-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33814
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
 arch/mips/ath79/prom.c |   38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index e9cbd7c..c891f6b 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -1,20 +1,17 @@
 /*
- *  Atheros AR71XX/AR724X/AR913X specific prom routines
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ * Atheros AR71XX/AR724X/AR913X specific prom routines
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
+ * Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  */
-
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/string.h>
 
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/addrspace.h>
 
 #include "common.h"
@@ -32,25 +29,24 @@ static inline int is_valid_ram_addr(void *addr)
 	return 0;
 }
 
-static __init void ath79_prom_init_cmdline(int argc, char **argv)
+void __init prom_init(void)
 {
 	int i;
 
-	if (!is_valid_ram_addr(argv))
+	fw_argc = (fw_arg0 & 0x0000ffff);
+	_fw_argv = (int *)fw_arg1;
+	_fw_envp = (int *)fw_arg2;
+
+	if (!is_valid_ram_addr((void *)_fw_argv))
 		return;
 
-	for (i = 0; i < argc; i++)
-		if (is_valid_ram_addr(argv[i])) {
-			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
-			strlcat(arcs_cmdline, argv[i], sizeof(arcs_cmdline));
+	for (i = 1; i < fw_argc; i++)
+		if (is_valid_ram_addr(fw_argv(i))) {
+			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(arcs_cmdline, fw_argv(i), COMMAND_LINE_SIZE);
 		}
 }
 
-void __init prom_init(void)
-{
-	ath79_prom_init_cmdline(fw_arg0, (char **)fw_arg1);
-}
-
 void __init prom_free_prom_memory(void)
 {
 	/* We do not have to prom memory to free */
-- 
1.7.10.3
