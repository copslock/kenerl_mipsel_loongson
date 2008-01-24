Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 16:59:31 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:63226 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037142AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id D29C88FEADB;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id A33B88FF54A;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] [MIPS] Malta: remaining bits of the board support code cleanup
Date:	Thu, 24 Jan 2008 19:52:56 +0300
Message-Id: <1201193577-4261-17-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch factors out the code, which handles the Bonito system
controller. The case of not supporting the DMA coherency is handled
separately to make the logic obvious. Besides, a couple of empty
lines added to beautify the code even further.

No functional changes introduced.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/malta/malta_setup.c |   80 +++++++++++++++--------------
 1 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 541f4e7..2cd8f57 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -1,6 +1,7 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) Dmitri Vorobiev
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -145,6 +146,41 @@ static void __init screen_info_setup(void)
 }
 #endif
 
+static void __init bonito_quirks_setup(void)
+{
+	char *argptr;
+
+	argptr = prom_getcmdline();
+	if (strstr(argptr, "debug")) {
+		BONITO_BONGENCFG |= BONITO_BONGENCFG_DEBUGMODE;
+		printk(KERN_INFO "Enabled Bonito debug mode\n");
+	} else
+		BONITO_BONGENCFG &= ~BONITO_BONGENCFG_DEBUGMODE;
+
+#ifdef CONFIG_DMA_COHERENT
+	if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
+		BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
+		printk(KERN_INFO "Enabled Bonito CPU coherency\n");
+
+		argptr = prom_getcmdline();
+		if (strstr(argptr, "iobcuncached")) {
+			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
+				~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+					BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			printk(KERN_INFO "Disabled Bonito IOBC coherency\n");
+		} else {
+			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
+			BONITO_PCIMEMBASECFG |=
+				(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
+					BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
+			printk(KERN_INFO "Enabled Bonito IOBC coherency\n");
+		}
+	} else
+		panic("Hardware DMA cache coherency not supported");
+#endif
+}
+
 void __init plat_mem_setup(void)
 {
 	unsigned int i;
@@ -164,54 +200,22 @@ void __init plat_mem_setup(void)
 	kgdb_config();
 #endif
 
-	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO) {
-		char *argptr;
-
-		argptr = prom_getcmdline();
-		if (strstr(argptr, "debug")) {
-			BONITO_BONGENCFG |= BONITO_BONGENCFG_DEBUGMODE;
-			printk("Enabled Bonito debug mode\n");
-		}
-		else
-			BONITO_BONGENCFG &= ~BONITO_BONGENCFG_DEBUGMODE;
-
 #ifdef CONFIG_DMA_COHERENT
-		if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
-			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
-			printk("Enabled Bonito CPU coherency\n");
-
-			argptr = prom_getcmdline();
-			if (strstr(argptr, "iobcuncached")) {
-				BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
-				BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
-					~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
-					  BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
-				printk("Disabled Bonito IOBC coherency\n");
-			}
-			else {
-				BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
-				BONITO_PCIMEMBASECFG |=
-					(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
-					 BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
-				printk("Enabled Bonito IOBC coherency\n");
-			}
-		}
-		else
-			panic("Hardware DMA cache coherency not supported");
-
-#endif
-	}
-#ifdef CONFIG_DMA_COHERENT
-	else
+	if (mips_revision_sconid != MIPS_REVISION_SCON_BONITO)
 		panic("Hardware DMA cache coherency not supported");
 #endif
 
+	if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
+		bonito_quirks_setup();
+
 #ifdef CONFIG_BLK_DEV_IDE
 	pci_clock_check();
 #endif
+
 #ifdef CONFIG_BLK_DEV_FD
 	fd_activate();
 #endif
+
 #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
 	screen_info_setup();
 #endif
-- 
1.5.3
