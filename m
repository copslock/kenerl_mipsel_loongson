Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 13:51:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55814 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860063AbaGILvTYQcsI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 13:51:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1B40A39AB24BD
        for <linux-mips@linux-mips.org>; Wed,  9 Jul 2014 12:51:10 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:51:12 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 9 Jul 2014 12:51:12 +0100
Received: from pburton-laptop.home (192.168.79.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:51:11 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 5/5] MIPS: smp-cps: fix entry code cache flush for systems with coherent I/O
Date:   Wed, 9 Jul 2014 12:51:05 +0100
Message-ID: <1404906665-10825-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
References: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.89]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The dma_cache_wback_inv function performs exactly as is required here,
unless the system has coherent I/O in which case it's a no-op. Call the
underlying cache writeback functions directly, which is arguably clearer
anyway given that the code doesn't actually have anything to do with
DMA in a strict sense.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/smp-cps.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index f9b53b4..e6e16a1 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -14,13 +14,14 @@
 #include <linux/smp.h>
 #include <linux/types.h>
 
-#include <asm/cacheflush.h>
+#include <asm/bcache.h>
 #include <asm/gic.h>
 #include <asm/mips-cm.h>
 #include <asm/mips-cpc.h>
 #include <asm/mips_mt.h>
 #include <asm/mipsregs.h>
 #include <asm/pm-cps.h>
+#include <asm/r4kcache.h>
 #include <asm/smp-cps.h>
 #include <asm/time.h>
 #include <asm/uasm.h>
@@ -132,8 +133,11 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	entry_code = (u32 *)&mips_cps_core_entry;
 	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
 	uasm_i_addiu(&entry_code, 16, 0, cca);
-	dma_cache_wback_inv((unsigned long)&mips_cps_core_entry,
-			    (void *)entry_code - (void *)&mips_cps_core_entry);
+	blast_dcache_range((unsigned long)&mips_cps_core_entry,
+			   (unsigned long)entry_code);
+	bc_wback_inv((unsigned long)&mips_cps_core_entry,
+		     (void *)entry_code - (void *)&mips_cps_core_entry);
+	__sync();
 
 	/* Allocate core boot configuration structs */
 	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
-- 
2.0.1
