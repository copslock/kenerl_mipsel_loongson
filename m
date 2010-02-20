Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 19:51:52 +0100 (CET)
Received: from [193.201.54.104] ([193.201.54.104]:56926 "EHLO hauke-m.de"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492063Ab0BTSvs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Feb 2010 19:51:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 3FB1F8587;
        Sat, 20 Feb 2010 19:51:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uDuCebCU-+31; Sat, 20 Feb 2010 19:51:24 +0100 (CET)
Received: from localhost.localdomain (host-091-096-211-027.ewe-ip-backbone.de [91.96.211.27])
        by hauke-m.de (Postfix) with ESMTPSA id EEFB17E29;
        Sat, 20 Feb 2010 19:51:23 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: Bcm47xx: Fix 128MB RAM support
Date:   Sat, 20 Feb 2010 19:51:20 +0100
Message-Id: <1266691880-372-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Ignoring the last page when ddr size is 128M. Cached
accesses to last page is causing the processor to prefetch
using address above 128M stepping out of the ddr address
space.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 5efc995..0fa646c 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -141,6 +141,14 @@ static __init void prom_init_mem(void)
 			break;
 	}
 
+	/* Ignoring the last page when ddr size is 128M. Cached
+	 * accesses to last page is causing the processor to prefetch
+	 * using address above 128M stepping out of the ddr address
+	 * space.
+	 */
+	if (mem == 0x8000000)
+		mem -= 0x1000;
+
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
-- 
1.6.3.3
