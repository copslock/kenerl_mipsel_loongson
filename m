Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 10:30:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59031 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbcKDJ3MEDzn0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 10:29:12 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F95D1FE44B8E;
        Fri,  4 Nov 2016 09:29:03 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 4 Nov 2016 09:29:05 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qsyousef@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Yang Shi <yang.shi@windriver.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] MIPS: smp: Remove cpu_callin_map
Date:   Fri, 4 Nov 2016 09:28:57 +0000
Message-ID: <1478251738-13593-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1478251738-13593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55667
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

The previous commit made cpu_callin_map redundant, since it is no longer
used to signal secondary CPUs starting, or going offline. Remove it now.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/cavium-octeon/smp.c         | 1 -
 arch/mips/include/asm/smp.h           | 2 --
 arch/mips/kernel/smp-bmips.c          | 1 -
 arch/mips/kernel/smp-cps.c            | 1 -
 arch/mips/kernel/smp.c                | 2 --
 arch/mips/loongson64/loongson-3/smp.c | 1 -
 6 files changed, 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 256fe6f65cf2..edaf59647da8 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -272,7 +272,6 @@ static int octeon_cpu_disable(void)
 
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	octeon_fixup_irqs();
 
 	__flush_cache_all();
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 060f23ff1817..f8c5faa93584 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -46,8 +46,6 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_DUMP		0x8
 #define SMP_ASK_C0COUNT		0x10
 
-extern cpumask_t cpu_callin_map;
-
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
 
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 6d0f1321e084..f6700dc2fb09 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -364,7 +364,6 @@ static int bmips_cpu_disable(void)
 
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	clear_c0_status(IE_IRQ5);
 
 	local_flush_tlb_all();
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 6183ad84cc73..44339b470ef4 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -399,7 +399,6 @@ static int cps_cpu_disable(void)
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	cpumask_clear_cpu(cpu, &cpu_callin_map);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 03daf9008124..0a831f63b0ec 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -48,8 +48,6 @@
 #include <asm/setup.h>
 #include <asm/maar.h>
 
-cpumask_t cpu_callin_map;		/* Bitmask of started secondaries */
-
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
 EXPORT_SYMBOL(__cpu_number_map);
 
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 99aab9f85904..cfcf240cedbe 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -418,7 +418,6 @@ static int loongson3_cpu_disable(void)
 
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	local_irq_save(flags);
 	fixup_irqs();
 	local_irq_restore(flags);
-- 
2.7.4
