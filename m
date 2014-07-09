Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 13:48:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64642 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861103AbaGILsm0XiPn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 13:48:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C925CA895A46B
        for <linux-mips@linux-mips.org>; Wed,  9 Jul 2014 12:48:33 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:48:35 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 9 Jul 2014 12:48:35 +0100
Received: from pburton-laptop.home (192.168.79.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:48:34 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/5] MIPS: pm-cps: prevent use of mips_cps_* without CPS SMP
Date:   Wed, 9 Jul 2014 12:48:18 +0100
Message-ID: <1404906502-10702-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
References: <1404906502-10702-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.89]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41092
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

These symbols will not be defined when CONFIG_MIPS_CPS=n, but although
the CPS_PM_POWER_GATED state will never be used in that case the
compiler doesn't have enough information to figure that out. Add checks
which evaluate to a constant false for CONFIG_MIPS_CPS=n cases in order
to help the compiler out & eliminate the symbol references.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/smp-cps.h | 12 ++++++++++--
 arch/mips/kernel/pm-cps.c       |  8 ++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index a06a08a..326c16e 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -31,11 +31,19 @@ extern void mips_cps_core_init(void);
 
 extern struct vpe_boot_config *mips_cps_boot_vpes(void);
 
-extern bool mips_cps_smp_in_use(void);
-
 extern void mips_cps_pm_save(void);
 extern void mips_cps_pm_restore(void);
 
+#ifdef CONFIG_MIPS_CPS
+
+extern bool mips_cps_smp_in_use(void);
+
+#else /* !CONFIG_MIPS_CPS */
+
+static inline bool mips_cps_smp_in_use(void) { return false; }
+
+#endif /* !CONFIG_MIPS_CPS */
+
 #else /* __ASSEMBLY__ */
 
 .extern mips_cps_bootcfg;
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index c4c2069..c409a5a 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -149,6 +149,10 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Setup the VPE to run mips_cps_pm_restore when started again */
 	if (config_enabled(CONFIG_CPU_PM) && state == CPS_PM_POWER_GATED) {
+		/* Power gating relies upon CPS SMP */
+		if (!mips_cps_smp_in_use())
+			return -EINVAL;
+
 		core_cfg = &mips_cps_core_bootcfg[core];
 		vpe_cfg = &core_cfg->vpe_config[current_cpu_data.vpe_id];
 		vpe_cfg->pc = (unsigned long)mips_cps_pm_restore;
@@ -376,6 +380,10 @@ static void * __init cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 	memset(relocs, 0, sizeof(relocs));
 
 	if (config_enabled(CONFIG_CPU_PM) && state == CPS_PM_POWER_GATED) {
+		/* Power gating relies upon CPS SMP */
+		if (!mips_cps_smp_in_use())
+			goto out_err;
+
 		/*
 		 * Save CPU state. Note the non-standard calling convention
 		 * with the return address placed in v0 to avoid clobbering
-- 
2.0.1
