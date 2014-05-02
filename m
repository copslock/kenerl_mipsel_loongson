Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2014 21:48:59 +0200 (CEST)
Received: from [195.59.15.196] ([195.59.15.196]:28093 "EHLO
        mailapp01.imgtec.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664AbaEBTs53N0ip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 May 2014 21:48:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 269B98697B69
        for <linux-mips@linux-mips.org>; Fri,  2 May 2014 20:48:47 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 2 May
 2014 20:48:50 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 2 May 2014 20:48:50 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 2 May 2014 20:48:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 34/39] MIPS: smp-cps: duplicate core0 CCA on secondary cores
Date:   Fri, 2 May 2014 20:48:45 +0100
Message-ID: <1399060125-26841-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397653555-4758-1-git-send-email-paul.burton@imgtec.com>
References: <1397653555-4758-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40018
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

Rather than hardcoding CCA=0x5 for secondary cores, re-use the CCA from
the boot CPU. This allows overrides of the CCA using the cca= kernel
parameter to take effect on all CPUs for consistency.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v2 of patch 28.
---
 arch/mips/kernel/cps-vec.S | 11 +++++++----
 arch/mips/kernel/smp-cps.c |  8 +++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 1c865ae..6f4f739 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -45,10 +45,12 @@
 
 LEAF(mips_cps_core_entry)
 	/*
-	 * These first 8 bytes will be patched by cps_smp_setup to load the
-	 * base address of the CM GCRs into register v1.
+	 * These first 12 bytes will be patched by cps_smp_setup to load the
+	 * base address of the CM GCRs into register v1 and the CCA to use into
+	 * register s0.
 	 */
 	.quad	0
+	.word	0
 
 	/* Check whether we're here due to an NMI */
 	mfc0	k0, CP0_STATUS
@@ -139,10 +141,11 @@ icache_done:
 	 add	a0, a0, t0
 dcache_done:
 
-	/* Set Kseg0 cacheable, coherent, write-back, write-allocate */
+	/* Set Kseg0 CCA to that in s0 */
 	mfc0	t0, CP0_CONFIG
 	ori	t0, 0x7
-	xori	t0, 0x2
+	xori	t0, 0x7
+	or	t0, t0, s0
 	mtc0	t0, CP0_CONFIG
 	ehb
 
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 870897d..ec4f115 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -123,9 +123,15 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 		}
 	}
 
-	/* Patch the start of mips_cps_core_entry to provide the CM base */
+	/*
+	 * Patch the start of mips_cps_core_entry to provide:
+	 *
+	 * v0 = CM base address
+	 * s0 = kseg0 CCA
+	 */
 	entry_code = (u32 *)&mips_cps_core_entry;
 	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
+	uasm_i_addiu(&entry_code, 16, 0, cca);
 	dma_cache_wback_inv((unsigned long)&mips_cps_core_entry,
 			    (void *)entry_code - (void *)&mips_cps_core_entry);
 
-- 
1.8.5.3
