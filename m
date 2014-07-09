Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2014 13:49:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46162 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861345AbaGILtDQyCjv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2014 13:49:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BD3D4AE4BC63E
        for <linux-mips@linux-mips.org>; Wed,  9 Jul 2014 12:48:54 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:48:56 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 9 Jul 2014 12:48:56 +0100
Received: from pburton-laptop.home (192.168.79.89) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 9 Jul
 2014 12:48:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/5] MIPS: {pm,smp}-cps: use cpu_vpe_id macro
Date:   Wed, 9 Jul 2014 12:48:21 +0100
Message-ID: <1404906502-10702-5-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 41095
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

When determining the VPE ID of a CPU, make use of the cpu_vpe_id macro
which will return 0 in a non-MT kernel build. Most code is already doing
so but a couple of places weren't. Fixing this prevents a build failure
for non-MT kernels where struct cpuinfo_mips does not contain the vpe_id
field:

  arch/mips/kernel/pm-cps.c: In function 'cps_pm_enter_state':
  arch/mips/kernel/pm-cps.c:153:51: error: 'struct cpuinfo_mips' has no
      member named 'vpe_id'
    vpe_cfg = &core_cfg->vpe_config[current_cpu_data.vpe_id];

  arch/mips/kernel/smp-cps.c: In function 'wait_for_sibling_halt':
  arch/mips/kernel/smp-cps.c:363:33: error: 'struct cpuinfo_mips' has no
      member named 'vpe_id'
    unsigned vpe_id = cpu_data[cpu].vpe_id;

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/pm-cps.c  | 2 +-
 arch/mips/kernel/smp-cps.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index c409a5a..0614717 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -154,7 +154,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 			return -EINVAL;
 
 		core_cfg = &mips_cps_core_bootcfg[core];
-		vpe_cfg = &core_cfg->vpe_config[current_cpu_data.vpe_id];
+		vpe_cfg = &core_cfg->vpe_config[cpu_vpe_id(&current_cpu_data)];
 		vpe_cfg->pc = (unsigned long)mips_cps_pm_restore;
 		vpe_cfg->gp = (unsigned long)current_thread_info();
 		vpe_cfg->sp = 0;
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 949f2c6..f9b53b4 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -360,7 +360,7 @@ void play_dead(void)
 static void wait_for_sibling_halt(void *ptr_cpu)
 {
 	unsigned cpu = (unsigned)ptr_cpu;
-	unsigned vpe_id = cpu_data[cpu].vpe_id;
+	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	unsigned halted;
 	unsigned long flags;
 
-- 
2.0.1
