Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:04:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34926 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837167AbaDPNC1hKU4k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:02:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 19E3E547162B
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:02:15 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 14:02:17 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:02:17 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:02:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 28/39] MIPS: smp-cps: flush cache after patching mips_cps_core_entry
Date:   Wed, 16 Apr 2014 13:53:19 +0100
Message-ID: <1397652810-4336-29-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39835
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

The start of mips_cps_core_entry is patched in order to provide the code
with the address of the CM register region at a point where it will be
running non-coherent with the rest of the system. However the cache
wasn't being flushed after that patching which could in principle lead
to secondary cores using an invalid CM base address.

The patching is moved to cps_prepare_cpus since local_flush_icache_range
has not been initialised at the point cps_smp_setup is called.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/smp-cps.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index c7879fb..6da42f0 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -44,7 +44,6 @@ static void __init cps_smp_setup(void)
 {
 	unsigned int ncores, nvpes, core_vpes;
 	int c, v;
-	u32 *entry_code;
 
 	/* Detect & record VPE topology */
 	ncores = mips_cm_numcores();
@@ -82,10 +81,6 @@ static void __init cps_smp_setup(void)
 	/* Initialise core 0 */
 	mips_cps_core_init();
 
-	/* Patch the start of mips_cps_core_entry to provide the CM base */
-	entry_code = (u32 *)&mips_cps_core_entry;
-	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
-
 	/* Make core 0 coherent with everything */
 	write_gcr_cl_coherence(0xff);
 }
@@ -93,9 +88,16 @@ static void __init cps_smp_setup(void)
 static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned ncores, core_vpes, c;
+	u32 *entry_code;
 
 	mips_mt_set_cpuoptions();
 
+	/* Patch the start of mips_cps_core_entry to provide the CM base */
+	entry_code = (u32 *)&mips_cps_core_entry;
+	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
+	local_flush_icache_range((unsigned long)&mips_cps_core_entry,
+				 (unsigned long)entry_code);
+
 	/* Allocate core boot configuration structs */
 	ncores = mips_cm_numcores();
 	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
-- 
1.8.5.3
