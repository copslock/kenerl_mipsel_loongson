Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:43:37 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56710 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6902530Ab2JDJmsd9G0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 11:42:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6251C8F68;
        Wed,  3 Oct 2012 14:34:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xI6OsM61ih-P; Wed,  3 Oct 2012 14:34:31 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 8E0C48F62;
        Wed,  3 Oct 2012 14:34:23 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 2/5] MIPS: BCM47XX: improve memory size detection
Date:   Wed,  3 Oct 2012 14:34:17 +0200
Message-Id: <1349267660-31845-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349267660-31845-1-git-send-email-hauke@hauke-m.de>
References: <1349267660-31845-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34570
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
seen again, but it is better to check for a bigger part of the memory
to decrease the chance of wrong results.

This should fix a problem we saw in OpenWrt, where the detected
available memory decreed on some devices when doing a soft reboot.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 22258a4..8c155af 100644
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
+	unsigned long off;
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	/* Figure out memory size by finding aliases.
@@ -145,15 +147,15 @@ static __init void prom_init_mem(void)
 	 * max contains the biggest possible address supported by the platform.
 	 * If the method wants to try something above we assume 128MB ram.
 	 */
-	max = ((unsigned long)(prom_init) | ((128 << 20) - 1));
+	off = (unsigned long)prom_init;
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
+		if (!memcmp(prom_init, prom_init + mem, 32))
 			break;
 	}
 
-- 
1.7.9.5
