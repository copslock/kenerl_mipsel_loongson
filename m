Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:49:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32970 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992215AbcIGJptCJIpS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9F9323EE44D8E;
        Wed,  7 Sep 2016 10:45:29 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:32 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 09/12] MIPS: pm-cps: Add MIPSr6 CPU support
Date:   Wed, 7 Sep 2016 10:45:17 +0100
Message-ID: <1473241520-14917-10-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

This patch adds support for CPUs implementing the MIPSr6 ISA to the CPS
power management code. Three changes are necessary:

1. In MIPSr6, coupled coherence is necessary when CPUS implement multiple
   Virtual Processors (VPs).

2. MIPSr6 virtual processors are more like real cores and cannot yield
   to other VPs on the same core, so drop the MT ASE yield instruction.

3. To halt a MIPSr6 VP, the CPC VP_STOP register is used rather than the
   MT ASE TCHalt CP0 register.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/include/asm/pm-cps.h |  6 ++++--
 arch/mips/kernel/pm-cps.c      | 22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/pm-cps.h b/arch/mips/include/asm/pm-cps.h
index 625eda53d571..89d58d80b77b 100644
--- a/arch/mips/include/asm/pm-cps.h
+++ b/arch/mips/include/asm/pm-cps.h
@@ -13,10 +13,12 @@
 
 /*
  * The CM & CPC can only handle coherence & power control on a per-core basis,
- * thus in an MT system the VPEs within each core are coupled and can only
+ * thus in an MT system the VP(E)s within each core are coupled and can only
  * enter or exit states requiring CM or CPC assistance in unison.
  */
-#ifdef CONFIG_MIPS_MT
+#if defined(CONFIG_CPU_MIPSR6)
+# define coupled_coherence cpu_has_vp
+#elif defined(CONFIG_MIPS_MT)
 # define coupled_coherence cpu_has_mipsmt
 #else
 # define coupled_coherence 0
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index b3a7d36ada5a..440e79259566 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -129,7 +129,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 		return -EINVAL;
 
 	/* Calculate which coupled CPUs (VPEs) are online */
-#ifdef CONFIG_MIPS_MT
+#if defined(CONFIG_MIPS_MT) || defined(CONFIG_CPU_MIPSR6)
 	if (cpu_online(cpu)) {
 		cpumask_and(coupled_mask, cpu_online_mask,
 			    &cpu_sibling_map[cpu]);
@@ -431,7 +431,8 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 			uasm_i_lw(&p, t0, 0, r_nc_count);
 			uasm_il_bltz(&p, &r, t0, lbl_secondary_cont);
 			uasm_i_ehb(&p);
-			uasm_i_yield(&p, zero, t1);
+			if (cpu_has_mipsmt)
+				uasm_i_yield(&p, zero, t1);
 			uasm_il_b(&p, &r, lbl_poll_cont);
 			uasm_i_nop(&p);
 		} else {
@@ -439,8 +440,21 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 			 * The core will lose power & this VPE will not continue
 			 * so it can simply halt here.
 			 */
-			uasm_i_addiu(&p, t0, zero, TCHALT_H);
-			uasm_i_mtc0(&p, t0, 2, 4);
+			if (cpu_has_mipsmt) {
+				/* Halt the VPE via C0 tchalt register */
+				uasm_i_addiu(&p, t0, zero, TCHALT_H);
+				uasm_i_mtc0(&p, t0, 2, 4);
+			} else if (cpu_has_vp) {
+				/* Halt the VP via the CPC VP_STOP register */
+				unsigned int vpe_id;
+
+				vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+				uasm_i_addiu(&p, t0, zero, 1 << vpe_id);
+				UASM_i_LA(&p, t1, (long)addr_cpc_cl_vp_stop());
+				uasm_i_sw(&p, t0, 0, t1);
+			} else {
+				BUG();
+			}
 			uasm_build_label(&l, p, lbl_secondary_hang);
 			uasm_il_b(&p, &r, lbl_secondary_hang);
 			uasm_i_nop(&p);
-- 
2.7.4
