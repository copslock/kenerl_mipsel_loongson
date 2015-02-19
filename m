Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2015 17:19:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26586 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013233AbbBSQTNAFHqw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Feb 2015 17:19:13 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 904EFE9532C1B
        for <linux-mips@linux-mips.org>; Thu, 19 Feb 2015 16:19:04 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 19 Feb
 2015 16:19:07 +0000
Received: from solomon.ba.imgtec.org (10.20.78.13) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 19 Feb
 2015 08:19:04 -0800
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH V4 3/5] MIPS: Add set/clear CP0 macros for PageGrain register
Date:   Thu, 19 Feb 2015 10:18:52 -0600
Message-ID: <1424362734-30364-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1424362734-30364-1-git-send-email-Steven.Hill@imgtec.com>
References: <1424362734-30364-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.13]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

Build set and clear macros for the PageGrain register.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h |    1 +
 arch/mips/kernel/cpu-probe.c     |    2 +-
 arch/mips/mm/tlb-r4k.c           |    6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 0634600..235469a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1897,6 +1897,7 @@ __BUILD_SET_C0(config5)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
+__BUILD_SET_C0(pagegrain)
 __BUILD_SET_C0(brcm_config_0)
 __BUILD_SET_C0(brcm_bus_pll)
 __BUILD_SET_C0(brcm_reset)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 81f0aed..48dfb9d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -550,7 +550,7 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	if (cpu_has_rixi) {
 		/* Enable the RIXI exceptions */
-		write_c0_pagegrain(read_c0_pagegrain() | PG_IEC);
+		set_c0_pagegrain(PG_IEC);
 		back_to_back_c0_hazard();
 		/* Verify the IEC bit is set */
 		if (read_c0_pagegrain() & PG_IEC)
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index e90b2e8..b2afa49 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -485,11 +485,11 @@ static void r4k_tlb_configure(void)
 		 * Enable the no read, no exec bits, and enable large virtual
 		 * address.
 		 */
-		u32 pg = PG_RIE | PG_XIE;
 #ifdef CONFIG_64BIT
-		pg |= PG_ELPA;
+		set_c0_pagegrain(PG_RIE | PG_XIE | PG_ELPA);
+#else
+		set_c0_pagegrain(PG_RIE | PG_XIE);
 #endif
-		write_c0_pagegrain(pg);
 	}
 
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
-- 
1.7.10.4
