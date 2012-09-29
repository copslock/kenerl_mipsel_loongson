Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2012 20:12:50 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46291 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903297Ab2I2SM1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2012 20:12:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 41B9887B9;
        Sat, 29 Sep 2012 20:12:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5ga7YWSCPusD; Sat, 29 Sep 2012 20:12:21 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 0FFEF8E1C;
        Sat, 29 Sep 2012 20:12:17 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] MIPS: BCM47XX: improve memory size detection
Date:   Sat, 29 Sep 2012 20:12:03 +0200
Message-Id: <1348942326-27195-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
References: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The memory size is detected by finding a place where it repeats in
memory. Currently we are just checking when the function prom_init is
seen again, but with this patch it also checks some more bytes.

This should fix a problem we saw in OpenWrt, where the detected
available memory decreased on some devices when doing a soft reboot.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 22258a4..c18f59a 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -1,6 +1,7 @@
 /*
  *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
  *  Copyright (C) 2007 Aurelien Jarno <aurelien@aurel32.net>
+ *  Copyright (C) 2010-2012 Hauke Mehrtens <hauke@hauke-m.de>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -128,6 +129,7 @@ static __init void prom_init_mem(void)
 {
 	unsigned long mem;
 	unsigned long max;
+	unsigned long off, data, off1, data1;
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	/* Figure out memory size by finding aliases.
@@ -145,15 +147,19 @@ static __init void prom_init_mem(void)
 	 * max contains the biggest possible address supported by the platform.
 	 * If the method wants to try something above we assume 128MB ram.
 	 */
-	max = ((unsigned long)(prom_init) | ((128 << 20) - 1));
+	off = (unsigned long)prom_init;
+	data = *(unsigned long *)prom_init;
+	off1 = off + 4;
+	data1 = *(unsigned long *)off1;
+	max = off | ((128 << 20) - 1);
 	for (mem = (1 << 20); mem < (128 << 20); mem += (1 << 20)) {
-		if (((unsigned long)(prom_init) + mem) > max) {
+		if ((off + mem) > max) {
 			mem = (128 << 20);
 			printk(KERN_DEBUG "assume 128MB RAM\n");
 			break;
 		}
-		if (*(unsigned long *)((unsigned long)(prom_init) + mem) ==
-		    *(unsigned long *)(prom_init))
+		if ((*(unsigned long *)(off + mem) == data) &&
+			(*(unsigned long *)(off1 + mem) == data1))
 			break;
 	}
 
-- 
1.7.9.5
