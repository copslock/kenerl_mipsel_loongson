Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:52:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48831 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992110AbdHMCvkAJoD6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:51:40 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5E4B445E06EB8;
        Sun, 13 Aug 2017 03:51:31 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:51:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/19] MIPS: CPC: Use BIT/GENMASK for register fields, order & drop shifts
Date:   Sat, 12 Aug 2017 19:49:29 -0700
Message-ID: <20170813024943.14989-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59501
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

Tidy up asm/mips-cpc.h in a similar way to what "MIPS: CM: Use
BIT/GENMASK for register fields, order & drop shifts" did for
asm/mips-cm.h.

We use BIT() & GENMASK() to simplify the definition of register fields,
drop the _SHF definitions since that information can be found in the
_MSK ones, and then drop the _MSK suffix.

Fields definitions are moved to be next to the appropriate register
definition, making it easier to link the two & keep everything ordered
by register address. Comments are added including the name of each
register & a brief description of its purpose which helps to understand
what registers are for, link them back to hardware documentation or grep
for them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cpc.h | 79 +++++++++++++++++++++-------------------
 arch/mips/kernel/mips-cpc.c      |  2 +-
 arch/mips/kernel/pm-cps.c        |  2 +-
 arch/mips/kernel/smp-cps.c       |  8 ++--
 4 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index 9de7addb59ba..6cd2847fc95b 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -76,55 +76,60 @@ static inline bool mips_cpc_present(void)
 	CPS_ACCESSOR_RW(cpc, sz, MIPS_CPC_CLCB_OFS + off, cl_##name)	\
 	CPS_ACCESSOR_RW(cpc, sz, MIPS_CPC_COCB_OFS + off, co_##name)
 
-/* GCB register accessor functions */
+/* CPC_ACCESS - Control core/IOCU access to CPC registers prior to CM 3 */
 CPC_ACCESSOR_RW(32, 0x000, access)
+
+/* CPC_SEQDEL - Configure delays between command sequencer steps */
 CPC_ACCESSOR_RW(32, 0x008, seqdel)
+
+/* CPC_RAIL - Configure the delay from rail power-up to stability */
 CPC_ACCESSOR_RW(32, 0x010, rail)
+
+/* CPC_RESETLEN - Configure the length of reset sequences */
 CPC_ACCESSOR_RW(32, 0x018, resetlen)
+
+/* CPC_REVISION - Indicates the revisison of the CPC */
 CPC_ACCESSOR_RO(32, 0x020, revision)
 
-/* Core Local & Core Other accessor functions */
+/* CPC_Cx_CMD - Instruct the CPC to take action on a core */
 CPC_CX_ACCESSOR_RW(32, 0x000, cmd)
+#define CPC_Cx_CMD				GENMASK(3, 0)
+#define  CPC_Cx_CMD_CLOCKOFF			0x1
+#define  CPC_Cx_CMD_PWRDOWN			0x2
+#define  CPC_Cx_CMD_PWRUP			0x3
+#define  CPC_Cx_CMD_RESET			0x4
+
+/* CPC_Cx_STAT_CONF - Indicates core configuration & state */
 CPC_CX_ACCESSOR_RW(32, 0x008, stat_conf)
+#define CPC_Cx_STAT_CONF_PWRUPE			BIT(23)
+#define CPC_Cx_STAT_CONF_SEQSTATE		GENMASK(22, 19)
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D0		0x0
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U0		0x1
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U1		0x2
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U2		0x3
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U3		0x4
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U4		0x5
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U5		0x6
+#define  CPC_Cx_STAT_CONF_SEQSTATE_U6		0x7
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D1		0x8
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D3		0x9
+#define  CPC_Cx_STAT_CONF_SEQSTATE_D2		0xa
+#define CPC_Cx_STAT_CONF_CLKGAT_IMPL		BIT(17)
+#define CPC_Cx_STAT_CONF_PWRDN_IMPL		BIT(16)
+#define CPC_Cx_STAT_CONF_EJTAG_PROBE		BIT(15)
+
+/* CPC_Cx_OTHER - Configure the core-other register block prior to CM 3 */
 CPC_CX_ACCESSOR_RW(32, 0x010, other)
+#define CPC_Cx_OTHER_CORENUM			GENMASK(23, 16)
+
+/* CPC_Cx_VP_STOP - Stop Virtual Processors (VPs) within a core from running */
 CPC_CX_ACCESSOR_RW(32, 0x020, vp_stop)
+
+/* CPC_Cx_VP_START - Start Virtual Processors (VPs) within a core running */
 CPC_CX_ACCESSOR_RW(32, 0x028, vp_run)
-CPC_CX_ACCESSOR_RW(32, 0x030, vp_running)
 
-/* CPC_Cx_CMD register fields */
-#define CPC_Cx_CMD_SHF				0
-#define CPC_Cx_CMD_MSK				(_ULCAST_(0xf) << 0)
-#define  CPC_Cx_CMD_CLOCKOFF			(_ULCAST_(0x1) << 0)
-#define  CPC_Cx_CMD_PWRDOWN			(_ULCAST_(0x2) << 0)
-#define  CPC_Cx_CMD_PWRUP			(_ULCAST_(0x3) << 0)
-#define  CPC_Cx_CMD_RESET			(_ULCAST_(0x4) << 0)
-
-/* CPC_Cx_STAT_CONF register fields */
-#define CPC_Cx_STAT_CONF_PWRUPE_SHF		23
-#define CPC_Cx_STAT_CONF_PWRUPE_MSK		(_ULCAST_(0x1) << 23)
-#define CPC_Cx_STAT_CONF_SEQSTATE_SHF		19
-#define CPC_Cx_STAT_CONF_SEQSTATE_MSK		(_ULCAST_(0xf) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_D0		(_ULCAST_(0x0) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U0		(_ULCAST_(0x1) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U1		(_ULCAST_(0x2) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U2		(_ULCAST_(0x3) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U3		(_ULCAST_(0x4) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U4		(_ULCAST_(0x5) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U5		(_ULCAST_(0x6) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_U6		(_ULCAST_(0x7) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_D1		(_ULCAST_(0x8) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_D3		(_ULCAST_(0x9) << 19)
-#define  CPC_Cx_STAT_CONF_SEQSTATE_D2		(_ULCAST_(0xa) << 19)
-#define CPC_Cx_STAT_CONF_CLKGAT_IMPL_SHF	17
-#define CPC_Cx_STAT_CONF_CLKGAT_IMPL_MSK	(_ULCAST_(0x1) << 17)
-#define CPC_Cx_STAT_CONF_PWRDN_IMPL_SHF		16
-#define CPC_Cx_STAT_CONF_PWRDN_IMPL_MSK		(_ULCAST_(0x1) << 16)
-#define CPC_Cx_STAT_CONF_EJTAG_PROBE_SHF	15
-#define CPC_Cx_STAT_CONF_EJTAG_PROBE_MSK	(_ULCAST_(0x1) << 15)
-
-/* CPC_Cx_OTHER register fields */
-#define CPC_Cx_OTHER_CORENUM_SHF		16
-#define CPC_Cx_OTHER_CORENUM_MSK		(_ULCAST_(0xff) << 16)
+/* CPC_Cx_VP_RUNNING - Indicate which Virtual Processors (VPs) are running */
+CPC_CX_ACCESSOR_RW(32, 0x030, vp_running)
 
 #ifdef CONFIG_MIPS_CPC
 
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index 690eefd0fb54..0e3ac6d05e75 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -89,7 +89,7 @@ void mips_cpc_lock_other(unsigned int core)
 	curr_core = current_cpu_data.core;
 	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
 			  per_cpu(cpc_core_lock_flags, curr_core));
-	write_cpc_cl_other(core << CPC_Cx_OTHER_CORENUM_SHF);
+	write_cpc_cl_other(core << __ffs(CPC_Cx_OTHER_CORENUM));
 
 	/*
 	 * Ensure the core-other region reflects the appropriate core &
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 357b451c43a7..df1a1a5b58b9 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -692,7 +692,7 @@ static int __init cps_pm_init(void)
 	/* Detect whether a CPC is present */
 	if (mips_cpc_present()) {
 		/* Detect whether clock gating is implemented */
-		if (read_cpc_cl_stat_conf() & CPC_Cx_STAT_CONF_CLKGAT_IMPL_MSK)
+		if (read_cpc_cl_stat_conf() & CPC_Cx_STAT_CONF_CLKGAT_IMPL)
 			set_bit(CPS_PM_CLOCK_GATED, state_support);
 		else
 			pr_warn("pm-cps: CPC does not support clock gating\n");
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index b544d3df3b73..777e0193e8ed 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -253,7 +253,8 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 		timeout = 100;
 		while (true) {
 			stat = read_cpc_co_stat_conf();
-			seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE_MSK;
+			seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE;
+			seq_state >>= __ffs(CPC_Cx_STAT_CONF_SEQSTATE);
 
 			/* U6 == coherent execution, ie. the core is up */
 			if (seq_state == CPC_Cx_STAT_CONF_SEQSTATE_U6)
@@ -522,7 +523,8 @@ static void cps_cpu_die(unsigned int cpu)
 			mips_cm_lock_other(core, 0);
 			mips_cpc_lock_other(core);
 			stat = read_cpc_co_stat_conf();
-			stat &= CPC_Cx_STAT_CONF_SEQSTATE_MSK;
+			stat &= CPC_Cx_STAT_CONF_SEQSTATE;
+			stat >>= __ffs(CPC_Cx_STAT_CONF_SEQSTATE);
 			mips_cpc_unlock_other();
 			mips_cm_unlock_other();
 
@@ -544,7 +546,7 @@ static void cps_cpu_die(unsigned int cpu)
 			 */
 			if (WARN(ktime_after(ktime_get(), fail_time),
 				 "CPU%u hasn't powered down, seq. state %u\n",
-				 cpu, stat >> CPC_Cx_STAT_CONF_SEQSTATE_SHF))
+				 cpu, stat))
 				break;
 		} while (1);
 
-- 
2.14.0
