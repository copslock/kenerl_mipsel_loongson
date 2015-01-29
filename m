Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 18:18:56 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:50157 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012227AbbA2RRrEWQ8Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 18:17:47 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YGsfG-00015a-MR; Thu, 29 Jan 2015 11:13:58 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH V3 3/5] MIPS: Add set/clear CP0 macros for PageGrain register
Date:   Thu, 29 Jan 2015 11:17:35 -0600
Message-Id: <1422551857-10981-4-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1422551857-10981-1-git-send-email-Steven.Hill@imgtec.com>
References: <1422551857-10981-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45547
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Build set and clear macros for the PageGrain register.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h |    1 +
 arch/mips/kernel/cpu-probe.c     |    2 +-
 arch/mips/mm/tlb-r4k.c           |    6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5e4aef3..45b996b 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1894,6 +1894,7 @@ __BUILD_SET_C0(config5)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
+__BUILD_SET_C0(pagegrain)
 __BUILD_SET_C0(brcm_config_0)
 __BUILD_SET_C0(brcm_bus_pll)
 __BUILD_SET_C0(brcm_reset)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f56e53b..da2a78d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -540,7 +540,7 @@ static void decode_configs(struct cpuinfo_mips *c)
 
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
