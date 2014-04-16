Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:58:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:60580 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837156AbaDPM5JGGGzj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:57:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E038973BE4B7
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:56:59 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:57:02 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:57:02 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:57:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 12/39] MIPS: introduce cpu_coherent_mask
Date:   Wed, 16 Apr 2014 13:53:03 +0100
Message-ID: <1397652810-4336-13-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39819
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

Add a mask of CPUs which are currently known to be operating coherently.
This is setup initially to be all present CPUs, but in a subsequent
patch CPUs in a MIPS Coherent Processing System will be cleared in this
mask as they enter non-coherent idle states. This will be used in order
to determine when a CPU within a CPS system may need to be powered back
up, but may also be used in future to optimise away wakeups for cache
operations or TLB invalidations.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/smp.h | 3 +++
 arch/mips/kernel/smp.c      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index efa02ac..b037334 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -46,6 +46,9 @@ extern int __cpu_logical_map[NR_CPUS];
 
 extern volatile cpumask_t cpu_callin_map;
 
+/* Mask of CPUs which are currently definitely operating coherently */
+extern cpumask_t cpu_coherent_mask;
+
 extern void asmlinkage smp_bootstrap(void);
 
 /*
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 9a52264..991ae96 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -66,6 +66,8 @@ EXPORT_SYMBOL(cpu_sibling_map);
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
+cpumask_t cpu_coherent_mask;
+
 static inline void set_cpu_sibling_map(int cpu)
 {
 	int i;
@@ -124,6 +126,7 @@ asmlinkage void start_secondary(void)
 	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
+	cpu_set(cpu, cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
 	set_cpu_online(cpu, true);
@@ -186,6 +189,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 #ifndef CONFIG_HOTPLUG_CPU
 	init_cpu_present(cpu_possible_mask);
 #endif
+	cpumask_copy(&cpu_coherent_mask, cpu_possible_mask);
 }
 
 /* preload SMP state for boot cpu */
-- 
1.8.5.3
