Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 09:59:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6747 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993023AbcLBI6lpjXe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 09:58:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D585321233CE6;
        Fri,  2 Dec 2016 08:58:32 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 08:58:35 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 1/4] MIPS: kexec: remove SMP_DUMP
Date:   Fri, 2 Dec 2016 09:58:28 +0100
Message-ID: <1480669111-15562-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1480669111-15562-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

SMP_DUMP has been added as a new IPI signal when kexec support was added
for Cavium Octeon CPUs ('commit 7aa1c8f47e7e ("MIPS: kdump: Add support")'.
However, the new signal doesn't appear to ever have a proper handler
added (octeon_message_functions[] array has an empty handler for it),
and generic IPI handlers now trigger a BUG() on unhandled signal.

As the method is unused remove it completely and replace its only
invocation with a smp_call_function().

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/smp.h |  6 ------
 arch/mips/kernel/crash.c    |  2 +-
 arch/mips/kernel/smp.c      | 17 -----------------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 060f23f..5ddd180 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -42,8 +42,6 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
 #define SMP_ICACHE_FLUSH	0x4
-/* Used by kexec crashdump to save all cpu's state */
-#define SMP_DUMP		0x8
 #define SMP_ASK_C0COUNT		0x10
 
 extern cpumask_t cpu_callin_map;
@@ -113,8 +111,4 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	mp_ops->send_ipi_mask(mask, SMP_CALL_FUNCTION);
 }
 
-#if defined(CONFIG_KEXEC)
-extern void (*dump_ipi_function_ptr)(void *);
-void dump_send_ipi(void (*dump_ipi_callback)(void *));
-#endif
 #endif /* __ASM_SMP_H */
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 1723b17..5a71518 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -56,7 +56,7 @@ static void crash_kexec_prepare_cpus(void)
 
 	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
 
-	dump_send_ipi(crash_shutdown_secondary);
+	smp_call_function(crash_shutdown_secondary, NULL, 0);
 	smp_wmb();
 
 	/*
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 7ebb191..214bc65 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -637,23 +637,6 @@ void flush_tlb_one(unsigned long vaddr)
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(flush_tlb_one);
 
-#if defined(CONFIG_KEXEC)
-void (*dump_ipi_function_ptr)(void *) = NULL;
-void dump_send_ipi(void (*dump_ipi_callback)(void *))
-{
-	int i;
-	int cpu = smp_processor_id();
-
-	dump_ipi_function_ptr = dump_ipi_callback;
-	smp_mb();
-	for_each_online_cpu(i)
-		if (i != cpu)
-			mp_ops->send_ipi_single(i, SMP_DUMP);
-
-}
-EXPORT_SYMBOL(dump_send_ipi);
-#endif
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
 static DEFINE_PER_CPU(atomic_t, tick_broadcast_count);
-- 
2.7.4
