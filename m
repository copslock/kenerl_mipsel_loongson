Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 22:13:23 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35841 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492669Ab0G0UM5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 22:12:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D777C85E3;
        Tue, 27 Jul 2010 22:12:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3BGQYThiCbZ3; Tue, 27 Jul 2010 22:12:52 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-249-197.ewe-ip-backbone.de [91.97.249.197])
        by hauke-m.de (Postfix) with ESMTPSA id 744077E2C;
        Tue, 27 Jul 2010 22:12:52 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] MIPS: BCM47xx: Really fix 128MB RAM problem
Date:   Tue, 27 Jul 2010 22:12:43 +0200
Message-Id: <1280261566-8247-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

The previews patch 84a6fcb368a080620d12fc4d79e07902dbee7335 was wrong,
I got wrong success reports.

The bcm47xx architecture maps the ram into a 128MB address space. It
will be paced there as often as goes into the 128MB. The detection
tries to find the position where the same memory is found. When reading
over 128MB the processor will throw an exception. If 128MB ram is
installed, it will not find the same memory because it tries to read
over the 128MB boarder. Now it just assumes 128MB installed ram if it
can not find that the ram is repeating.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 0fa646c..f6e9063 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -126,6 +126,7 @@ static __init void prom_init_cmdline(void)
 static __init void prom_init_mem(void)
 {
 	unsigned long mem;
+	unsigned long max;
 
 	/* Figure out memory size by finding aliases.
 	 *
@@ -134,21 +135,26 @@ static __init void prom_init_mem(void)
 	 * want to reuse the memory used by CFE (around 4MB). That means cfe_*
 	 * functions stop to work at some point during the boot, we should only
 	 * call them at the beginning of the boot.
+	 *
+	 * BCM47XX uses 128MB for addressing the ram, if the system contains
+	 * less that that amount of ram it remaps the ram more often into the
+	 * available space.
+	 * Accessing memory after 128MB will cause an exception.
+	 * max contains the biggest possible address supported by the platform.
+	 * If the method wants to try something above we assume 128MB ram.
 	 */
+	max = ((unsigned long)(prom_init) | ((128 << 20) - 1));
 	for (mem = (1 << 20); mem < (128 << 20); mem += (1 << 20)) {
+		if (((unsigned long)(prom_init) + mem) > max) {
+			mem = (128 << 20);
+			printk(KERN_DEBUG "assume 128MB RAM\n");
+			break;
+		}
 		if (*(unsigned long *)((unsigned long)(prom_init) + mem) ==
 		    *(unsigned long *)(prom_init))
 			break;
 	}
 
-	/* Ignoring the last page when ddr size is 128M. Cached
-	 * accesses to last page is causing the processor to prefetch
-	 * using address above 128M stepping out of the ddr address
-	 * space.
-	 */
-	if (mem == 0x8000000)
-		mem -= 0x1000;
-
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
-- 
1.7.0.4
