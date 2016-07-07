Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 09:52:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992420AbcGGHvfM5je6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 09:51:35 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5DEEBCF5FB13B;
        Thu,  7 Jul 2016 08:51:16 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 7 Jul 2016 08:51:18 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/3] MIPS: smp-cps: Add support for CPU hotplug of MIPSr6 processors
Date:   Thu, 7 Jul 2016 08:50:39 +0100
Message-ID: <1467877840-32569-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
References: <1467877840-32569-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54243
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

Introduce support for hotplug of Virtual Processors in MIPSr6 systems.
The method is simpler than the VPE parallel from the now-deprecated MT
ASE, it can now simply write the VP_STOP register with the mask of VPs
to halt, and use the VP_RUNNING register to determine when the VP has
halted.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/smp-cps.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 006e99de170d..234e7e781a94 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -412,14 +412,16 @@ static enum {
 
 void play_dead(void)
 {
-	unsigned cpu, core;
+	unsigned int cpu, core, vpe_id;
 
 	local_irq_disable();
 	idle_task_exit();
 	cpu = smp_processor_id();
 	cpu_death = CPU_DEATH_POWER;
 
-	if (cpu_has_mipsmt) {
+	pr_debug("CPU%d going offline\n", cpu);
+
+	if (cpu_has_mipsmt || cpu_has_vp) {
 		core = cpu_data[cpu].core;
 
 		/* Look for another online VPE within the core */
@@ -440,10 +442,21 @@ void play_dead(void)
 	complete(&cpu_death_chosen);
 
 	if (cpu_death == CPU_DEATH_HALT) {
-		/* Halt this TC */
-		write_c0_tchalt(TCHALT_H);
-		instruction_hazard();
+		vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+
+		pr_debug("Halting core %d VP%d\n", core, vpe_id);
+		if (cpu_has_mipsmt) {
+			/* Halt this TC */
+			write_c0_tchalt(TCHALT_H);
+			instruction_hazard();
+		} else if (cpu_has_vp) {
+			write_cpc_cl_vp_stop(1 << vpe_id);
+
+			/* Ensure that the VP_STOP register is written */
+			wmb();
+		}
 	} else {
+		pr_debug("Gating power to core %d\n", core);
 		/* Power down the core */
 		cps_pm_enter_state(CPS_PM_POWER_GATED);
 	}
@@ -470,6 +483,7 @@ static void wait_for_sibling_halt(void *ptr_cpu)
 static void cps_cpu_die(unsigned int cpu)
 {
 	unsigned core = cpu_data[cpu].core;
+	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	unsigned stat;
 	int err;
 
@@ -498,10 +512,12 @@ static void cps_cpu_die(unsigned int cpu)
 		 * in which case the CPC will refuse to power down the core.
 		 */
 		do {
+			mips_cm_lock_other(core, vpe_id);
 			mips_cpc_lock_other(core);
 			stat = read_cpc_co_stat_conf();
 			stat &= CPC_Cx_STAT_CONF_SEQSTATE_MSK;
 			mips_cpc_unlock_other();
+			mips_cm_unlock_other();
 		} while (stat != CPC_Cx_STAT_CONF_SEQSTATE_D0 &&
 			 stat != CPC_Cx_STAT_CONF_SEQSTATE_D2 &&
 			 stat != CPC_Cx_STAT_CONF_SEQSTATE_U2);
@@ -518,6 +534,12 @@ static void cps_cpu_die(unsigned int cpu)
 					       (void *)(unsigned long)cpu, 1);
 		if (err)
 			panic("Failed to call remote sibling CPU\n");
+	} else if (cpu_has_vp) {
+		do {
+			mips_cm_lock_other(core, vpe_id);
+			stat = read_cpc_co_vp_running();
+			mips_cm_unlock_other();
+		} while (stat & (1 << vpe_id));
 	}
 }
 
-- 
2.7.4
