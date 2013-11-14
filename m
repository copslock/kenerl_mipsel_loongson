Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:13:51 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1075 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6852087Ab3KNQM5lX6SO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:57 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 03/12] MIPS: features: Add initial support for TLBINVF capable cores
Date:   Thu, 14 Nov 2013 16:12:23 +0000
Message-ID: <1384445552-30573-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
References: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_54
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

New Aptiv cores support the TLBINVF instruction for flushing
the VTLB.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/cpu-probe.c         | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index d445d06..296606b 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -20,6 +20,9 @@
 #ifndef cpu_has_tlb
 #define cpu_has_tlb		(cpu_data[0].options & MIPS_CPU_TLB)
 #endif
+#ifndef cpu_has_tlbinv
+#define cpu_has_tlbinv		(cpu_data[0].options & MIPS_CPU_TLBINV)
+#endif
 
 /*
  * For the moment we don't consider R6000 and R8000 so we can assume that
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index d2035e1..fd3bc43 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -348,6 +348,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_PCI		0x00400000 /* CPU has Perf Ctr Int indicator */
 #define MIPS_CPU_RIXI		0x00800000 /* CPU has TLB Read/eXec Inhibit */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
+#define MIPS_CPU_TLBINV		0x02000000 /* CPU supports TLBINV/F */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c814287..5dac95a 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -286,6 +286,11 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 	    && cpu_has_tlb)
 		c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
 
+	if (cpu_has_tlb) {
+		if (((config4 & MIPS_CONF4_IE) >> 29) == 2)
+			c->options |= MIPS_CPU_TLBINV;
+	}
+
 	c->kscratch_mask = (config4 >> 16) & 0xff;
 
 	return config4 & MIPS_CONF_M;
-- 
1.8.4.3
