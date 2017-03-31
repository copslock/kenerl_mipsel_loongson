Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 12:51:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27391 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbdCaKvVlwH5d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 12:51:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 72A3F9C23249B;
        Fri, 31 Mar 2017 11:51:11 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 11:51:14 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MIPS: smp-cps: Fix potentially uninitialised value of core
Date:   Fri, 31 Mar 2017 11:51:08 +0100
Message-ID: <1490957468-27255-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57502
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

Turning on DEBUG in smp-cps.c, or compiling the kernel with
CONFIG_DYNAMIC_DEBUG enabled results the build error:

arch/mips/kernel/smp-cps.c: In function 'play_dead':
./include/linux/dynamic_debug.h:126:3: error: 'core' may be used
uninitialized in this function [-Werror=maybe-uninitialized]

Fix this by always initialising the variable.

Fixes: 0d2808f338c7 ("MIPS: smp-cps: Add support for CPU hotplug of MIPSr6 processors")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/kernel/smp-cps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 6d45f05538c8..795b4aaf8927 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -422,13 +422,12 @@ void play_dead(void)
 	local_irq_disable();
 	idle_task_exit();
 	cpu = smp_processor_id();
+	core = cpu_data[cpu].core;
 	cpu_death = CPU_DEATH_POWER;
 
 	pr_debug("CPU%d going offline\n", cpu);
 
 	if (cpu_has_mipsmt || cpu_has_vp) {
-		core = cpu_data[cpu].core;
-
 		/* Look for another online VPE within the core */
 		for_each_online_cpu(cpu_death_sibling) {
 			if (cpu_data[cpu_death_sibling].core != core)
-- 
2.7.4
