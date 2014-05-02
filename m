Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 May 2014 21:48:11 +0200 (CEST)
Received: from [195.59.15.197] ([195.59.15.197]:37612 "EHLO
        mailapp01.imgtec.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664AbaEBTsJsErw6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 May 2014 21:48:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 90078957F9BBC
        for <linux-mips@linux-mips.org>; Fri,  2 May 2014 20:47:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 2 May 2014 20:48:02 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 2 May 2014 20:48:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 32/39] MIPS: smp-cps: prevent multi-core SMP with unsuitable CCA
Date:   Fri, 2 May 2014 20:47:57 +0100
Message-ID: <1399060077-26767-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397653533-4648-1-git-send-email-paul.burton@imgtec.com>
References: <1397653533-4648-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40017
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

If the user or bootloader sets the CCA to a value which is not suited
for multi-core SMP (ie. anything non-coherent) then limit the system to
using only a single core and warn the user.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v2 of patch 28.
---
 arch/mips/kernel/smp-cps.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 2c195b1..7083a59 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -88,11 +88,38 @@ static void __init cps_smp_setup(void)
 
 static void __init cps_prepare_cpus(unsigned int max_cpus)
 {
-	unsigned ncores, core_vpes, c;
+	unsigned ncores, core_vpes, c, cca;
+	bool cca_unsuitable;
 	u32 *entry_code;
 
 	mips_mt_set_cpuoptions();
 
+	/* Detect whether the CCA is unsuited to multi-core SMP */
+	cca = read_c0_config() & CONF_CM_CMASK;
+	switch (cca) {
+	case 0x4: /* CWBE */
+	case 0x5: /* CWB */
+		/* The CCA is coherent, multi-core is fine */
+		cca_unsuitable = false;
+		break;
+
+	default:
+		/* CCA is not coherent, multi-core is not usable */
+		cca_unsuitable = true;
+	}
+
+	/* Warn the user if the CCA prevents multi-core */
+	ncores = mips_cm_numcores();
+	if (cca_unsuitable && ncores > 1) {
+		pr_warn("Using only one core due to unsuitable CCA 0x%x\n",
+			cca);
+
+		for_each_present_cpu(c) {
+			if (cpu_data[c].core)
+				set_cpu_present(c, false);
+		}
+	}
+
 	/* Patch the start of mips_cps_core_entry to provide the CM base */
 	entry_code = (u32 *)&mips_cps_core_entry;
 	UASM_i_LA(&entry_code, 3, (long)mips_cm_base);
@@ -100,7 +127,6 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 			    (void *)entry_code - (void *)&mips_cps_core_entry);
 
 	/* Allocate core boot configuration structs */
-	ncores = mips_cm_numcores();
 	mips_cps_core_bootcfg = kcalloc(ncores, sizeof(*mips_cps_core_bootcfg),
 					GFP_KERNEL);
 	if (!mips_cps_core_bootcfg) {
-- 
1.8.5.3
