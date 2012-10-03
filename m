Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:46:09 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56715 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6902621Ab2JDJmstJzPO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 11:42:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8ADE08F60;
        Wed,  3 Oct 2012 14:34:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jgda+MK9so54; Wed,  3 Oct 2012 14:34:23 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4E3CC8F61;
        Wed,  3 Oct 2012 14:34:23 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 1/5] MIPS: BCM47XX: ignore last memory page
Date:   Wed,  3 Oct 2012 14:34:16 +0200
Message-Id: <1349267660-31845-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349267660-31845-1-git-send-email-hauke@hauke-m.de>
References: <1349267660-31845-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 34574
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

Ignoring the last page when ddr size is 128M. Cached accesses to last
page is causing the processor to prefetch using address above 128M
stepping out of the ddr address space.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/prom.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index f6e9063..22258a4 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/smp.h>
 #include <asm/bootinfo.h>
 #include <asm/fw/cfe/cfe_api.h>
 #include <asm/fw/cfe/cfe_error.h>
@@ -127,6 +128,7 @@ static __init void prom_init_mem(void)
 {
 	unsigned long mem;
 	unsigned long max;
+	struct cpuinfo_mips *c = &current_cpu_data;
 
 	/* Figure out memory size by finding aliases.
 	 *
@@ -155,6 +157,14 @@ static __init void prom_init_mem(void)
 			break;
 	}
 
+	/* Ignoring the last page when ddr size is 128M. Cached
+	 * accesses to last page is causing the processor to prefetch
+	 * using address above 128M stepping out of the ddr address
+	 * space.
+	 */
+	if (c->cputype == CPU_74K && (mem == (128  << 20)))
+		mem -= 0x1000;
+
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
-- 
1.7.9.5
