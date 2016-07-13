Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:15:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47010 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992909AbcGMNNear8Ah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1AA7616C0F13A;
        Wed, 13 Jul 2016 14:13:13 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:15 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 02/13] MIPS: SMP: Update cpu_foreign_map on CPU disable
Date:   Wed, 13 Jul 2016 14:12:45 +0100
Message-ID: <1468415576-12600-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
References: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When a CPU is disabled via CPU hotplug, cpu_foreign_map is not updated.
This could result in cache management SMP calls being sent to offline
CPUs instead of online siblings in the same core.

Add a call to calculate_cpu_foreign_map() in the various MIPS cpu
disable callbacks after set_cpu_online(). All cases are updated for
consistency and to keep cpu_foreign_map strictly up to date, not just
those which may support hardware multithreading.

Fixes: cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Hongliang Tao <taohl@lemote.com>
Cc: Hua Yan <yanh@lemote.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/cavium-octeon/smp.c         | 1 +
 arch/mips/include/asm/smp.h           | 2 ++
 arch/mips/kernel/smp-bmips.c          | 1 +
 arch/mips/kernel/smp-cps.c            | 1 +
 arch/mips/kernel/smp.c                | 2 +-
 arch/mips/loongson64/loongson-3/smp.c | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 33aab89259f3..4d457d602d3b 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -271,6 +271,7 @@ static int octeon_cpu_disable(void)
 		return -ENOTSUPP;
 
 	set_cpu_online(cpu, false);
+	calculate_cpu_foreign_map();
 	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	octeon_fixup_irqs();
 
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 03722d4326a1..0c534a03bb36 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -53,6 +53,8 @@ extern cpumask_t cpu_coherent_mask;
 
 extern void asmlinkage smp_bootstrap(void);
 
+extern void calculate_cpu_foreign_map(void);
+
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index e02addc0307f..6d0f1321e084 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -363,6 +363,7 @@ static int bmips_cpu_disable(void)
 	pr_info("SMP: CPU%d is offline\n", cpu);
 
 	set_cpu_online(cpu, false);
+	calculate_cpu_foreign_map();
 	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	clear_c0_status(IE_IRQ5);
 
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4ed36f288d64..47ff5108bed5 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -397,6 +397,7 @@ static int cps_cpu_disable(void)
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
+	calculate_cpu_foreign_map();
 	cpumask_clear_cpu(cpu, &cpu_callin_map);
 
 	return 0;
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0c98b4a313be..a4d4309ecff2 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -124,7 +124,7 @@ static inline void set_cpu_core_map(int cpu)
  * Calculate a new cpu_foreign_map mask whenever a
  * new cpu appears or disappears.
  */
-static inline void calculate_cpu_foreign_map(void)
+void calculate_cpu_foreign_map(void)
 {
 	int i, k, core_present;
 	cpumask_t temp_foreign_map;
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index e59759af63d9..2fec6f753a35 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -417,6 +417,7 @@ static int loongson3_cpu_disable(void)
 		return -EBUSY;
 
 	set_cpu_online(cpu, false);
+	calculate_cpu_foreign_map();
 	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	local_irq_save(flags);
 	fixup_irqs();
-- 
2.4.10
