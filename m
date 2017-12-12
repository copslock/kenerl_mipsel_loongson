Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 11:00:48 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:51261 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbdLLJ7L4rSyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 10:59:11 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 09:59:08 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:59:07 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 05/16] MIPS: Use CP0 register for smp_processor_id()
Date:   Tue, 12 Dec 2017 09:57:51 +0000
Message-ID: <1513072682-1371-6-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072747-637140-23890-866542-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

We already keep a copy of the CPU's ID stashed in CP0.Context or
CP0.XContext (defined by SMP_CPUID_REG) for use in exceptions handlers
to restore the correct CPUs state.

Currently, smp_processor_id() uses the thread_info->cpu
field, which will vanish when CONFIG_THREAD_INFO_IN_TASK is activated.

Switch smp_processor_id() to use the CP0 register.

Since this is quite an invasive change, here is quantification of it's
impact. All tests are from start of series to this patch with a 64r6
defconfig on Boston platform.

Size of 64r6 generic kernel according to bloatometer:
Total: Before=10010245, After=10016193, chg +0.06%

Average latency of syscall (10 x lat_syscall -W 2 -N 10 null)
Before: 6.13729, After: 6.13794, chg +0.00%

Average latency of syscall (10 x lat_syscall -W 2 -N 10 stat /dev/null)
Before: 102.21804, After: 104.14817, chg +1.89%

Average latency of syscall (10 x lat_syscall -W 2 -N 10 exec)
Before: 16051.1, After: 16066.2, chg +0.09%

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/smp.h | 5 ++++-
 arch/mips/kernel/cps-vec.S  | 5 +++--
 arch/mips/kernel/smp.c      | 9 ++++++++-
 arch/mips/kvm/entry.c       | 4 ++--
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 056a6bf13491..38352af394d6 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -19,6 +19,7 @@
 
 #include <linux/atomic.h>
 #include <asm/smp-ops.h>
+#include <asm/thread_info.h>
 
 extern int smp_num_siblings;
 extern cpumask_t cpu_sibling_map[];
@@ -31,8 +32,10 @@ static inline int raw_smp_processor_id(void)
 	extern int vdso_smp_processor_id(void)
 		__compiletime_error("VDSO should not call smp_processor_id()");
 	return vdso_smp_processor_id();
+#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+	return read_const_c0_xcontext() >> SMP_CPUID_REGSHIFT;
 #else
-	return current_thread_info()->cpu;
+	return read_const_c0_context() >> SMP_CPUID_REGSHIFT;
 #endif
 }
 #define raw_smp_processor_id raw_smp_processor_id
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index c7ed26029cbb..8c8822b2cf16 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -17,6 +17,7 @@
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/pm.h>
+#include <asm/thread_info.h>
 
 #define GCR_CPC_BASE_OFS	0x0088
 #define GCR_CL_COHERENCE_OFS	0x2008
@@ -596,8 +597,8 @@ dcache_done:
 	.macro	psstate	dest
 	.set	push
 	.set	noat
-	lw	$1, TI_CPU(gp)
-	sll	$1, $1, LONGLOG
+	ASM_CPUID_MFC0	$1, ASM_SMP_CPUID_REG
+	LONG_SRL	$1, SMP_CPUID_PTRSHIFT
 	PTR_LA	\dest, __per_cpu_offset
 	addu	$1, $1, \dest
 	lw	$1, 0($1)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index d84b9066b465..defec7499ccd 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -353,7 +353,14 @@ early_initcall(mips_smp_ipi_init);
  */
 asmlinkage void start_secondary(void)
 {
-	unsigned int cpu;
+	unsigned int cpu = current_thread_info()->cpu;
+
+	/* Stash this CPUs ID in CP0 for smp_processor_id() */
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+	write_c0_xcontext((unsigned long)cpu << SMP_CPUID_REGSHIFT);
+#else
+	write_c0_context(cpu << SMP_CPUID_REGSHIFT);
+#endif
 
 	cpu_probe();
 	per_cpu_trap_init(false);
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 16e1c93b484f..ef411117d435 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -382,9 +382,9 @@ static void *kvm_mips_build_enter_guest(void *addr)
 
 	/* t1: contains the base of the ASID array, need to get the cpu id  */
 	/* smp_processor_id */
-	uasm_i_lw(&p, T2, offsetof(struct thread_info, cpu), GP);
+	UASM_i_MFC0(&p, T2, SMP_CPUID_REG);
+	UASM_i_SRL(&p, T2, T2, SMP_CPUID_PTRSHIFT);
 	/* index the ASID array */
-	uasm_i_sll(&p, T2, T2, ilog2(sizeof(long)));
 	UASM_i_ADDU(&p, T3, T1, T2);
 	UASM_i_LW(&p, K0, 0, T3);
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
-- 
2.7.4
