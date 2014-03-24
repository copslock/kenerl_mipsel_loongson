Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:22:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:49444 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823009AbaCXKVHcRclb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:21:07 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B760BE26FAC0C
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:20:59 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 24 Mar
 2014 10:21:01 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:01 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:21:00 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/12] MIPS: smp-cps: fix build when CONFIG_MIPS_MT_SMP=n
Date:   Mon, 24 Mar 2014 10:19:29 +0000
Message-ID: <1395656375-9300-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39566
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

The vpe_id field of struct cpuinfo_mips is only present when one of
CONFIG_MIPS_MT_{SMP,SMTC} is enabled. Use the new cpu_vpe_id macro to
read the vpe_id field if present & avoid the build error if it isn't.
When setting vpe_id, #ifdef on CONFIG_MIPS_MT_SMP since smp-cps.c is
never compiled with CONFIG_MIPS_MT_SMTC.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Feel free to apply this as a fixup to "MIPS: Coherent Processing System
SMP implementation", though it relies upon "MIPS: add cpu_vpe_id macro"
being applied first.
---
 arch/mips/kernel/smp-cps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 2998906..4b812c1 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -120,7 +120,9 @@ static void __init cps_smp_setup(void)
 
 		for (v = 0; v < min_t(int, core_vpes, NR_CPUS - nvpes); v++) {
 			cpu_data[nvpes + v].core = c;
+#ifdef CONFIG_MIPS_MT_SMP
 			cpu_data[nvpes + v].vpe_id = v;
+#endif
 		}
 
 		nvpes += core_vpes;
@@ -239,7 +241,7 @@ static void cps_boot_secondary(int cpu, struct task_struct *idle)
 	int err;
 
 	cfg.core = cpu_data[cpu].core;
-	cfg.vpe = cpu_data[cpu].vpe_id;
+	cfg.vpe = cpu_vpe_id(&cpu_data[cpu]);
 	cfg.pc = (unsigned long)&smp_bootstrap;
 	cfg.sp = __KSTK_TOS(idle);
 	cfg.gp = (unsigned long)task_thread_info(idle);
@@ -276,7 +278,7 @@ static void cps_init_secondary(void)
 	dmt();
 
 	/* TODO: revisit this assumption once hotplug is implemented */
-	if (current_cpu_data.vpe_id == 0)
+	if (cpu_vpe_id(&current_cpu_data) == 0)
 		init_core();
 
 	change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
-- 
1.8.5.3
