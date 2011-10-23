Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Oct 2011 15:48:57 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:3556 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491050Ab1JWNoO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Oct 2011 15:44:14 +0200
X-TM-IMSS-Message-ID: <b9687bc60004e566@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id b9687bc60004e566 ; Sun, 23 Oct 2011 06:44:06 -0700
Date:   Sun, 23 Oct 2011 19:12:52 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 11/12] MIPS: Netlogic: Add support for XLP 3XX cores
Message-ID: <20111023134246.GA29137@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 23 Oct 2011 13:40:50.0784 (UTC) FILETIME=[60D23E00:01CC9189]
X-archive-position: 31281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16588

Add new processor ID to asm/cpu.h and kernel/cpu-probe.c.
Update to new CPU frequency detection code which works on XLP 3XX
and 8XX.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/cpu.h      |    4 +++-
 arch/mips/kernel/cpu-probe.c     |    3 ++-
 arch/mips/netlogic/xlp/nlm_hal.c |   26 ++++++++++++++++----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 4bcb668b..4617e5d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -167,7 +167,9 @@
 #define PRID_IMP_NETLOGIC_XLS408B	0x4e00
 #define PRID_IMP_NETLOGIC_XLS404B	0x4f00
 
-#define PRID_IMP_NETLOGIC_XLP832	0x1000
+#define PRID_IMP_NETLOGIC_XLP8XX	0x1000
+#define PRID_IMP_NETLOGIC_XLP3XX	0x1100
+
 /*
  * Definitions for 7:0 on legacy processors
  */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 501d302..757a3c4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1021,7 +1021,8 @@ static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
 			MIPS_CPU_LLSC);
 
 	switch (c->processor_id & 0xff00) {
-	case PRID_IMP_NETLOGIC_XLP832:
+	case PRID_IMP_NETLOGIC_XLP8XX:
+	case PRID_IMP_NETLOGIC_XLP3XX:
 		c->cputype = CPU_XLP;
 		__cpu_name[cpu] = "Netlogic XLP";
 		break;
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 885f687..9428e71 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -86,20 +86,26 @@ int nlm_irt_to_irq(int irt)
 	}
 }
 
-unsigned int nlm_get_cpu_frequency(void)
+unsigned int nlm_get_core_frequency(int core)
 {
-	unsigned int pll_divf, pll_divr, dfs_div, denom;
-	unsigned int val;
+	unsigned int pll_divf, pll_divr, dfs_div, ext_div;
+	unsigned int rstval, dfsval, denom;
 	uint64_t num;
 
-	val = nlm_read_sys_reg(nlm_sys_base, SYS_POWER_ON_RESET_CFG);
-	pll_divf = (val >> 10) & 0x7f;
-	pll_divr = (val >> 8)  & 0x3;
-	dfs_div  = (val >> 17) & 0x3;
+	rstval = nlm_read_sys_reg(nlm_sys_base, SYS_POWER_ON_RESET_CFG);
+	dfsval = nlm_read_sys_reg(nlm_sys_base, SYS_CORE_DFS_DIV_VALUE);
+	pll_divf = ((rstval >> 10) & 0x7f) + 1;
+	pll_divr = ((rstval >> 8)  & 0x3) + 1;
+	ext_div  = ((rstval >> 30) & 0x3) + 1;
+	dfs_div  = ((dfsval >> (core * 4)) & 0xf) + 1;
 
-	num = pll_divf + 1;
-	denom = 3 * (pll_divr + 1) * (1 << (dfs_div + 1));
-	num = num * 800000000ULL;
+	num = 800000000ULL * pll_divf;
+	denom = 3 * pll_divr * ext_div * dfs_div;
 	do_div(num, denom);
 	return (unsigned int)num;
 }
+
+unsigned int nlm_get_cpu_frequency(void)
+{
+	return nlm_get_core_frequency(0);
+}
-- 
1.7.4.1
