Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2017 11:46:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42773 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991955AbdEOJqqHh3Yr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2017 11:46:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 56A22F64211CD;
        Mon, 15 May 2017 10:46:37 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 15 May 2017 10:46:39 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Sort MIPS Kconfig Alphabetically.
Date:   Mon, 15 May 2017 10:46:35 +0100
Message-ID: <1494841595-8954-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57891
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

Sort the entries in config MIPS alphabetically so as to make entries
easier to find.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---


This patch is based on 4.12-rc1. My intention would be for it to be
applied during the -rc's when it is less likely to cause merge conflicts
with other patches changing config MIPS.

---
 arch/mips/Kconfig | 98 +++++++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..0b15978c0f88 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1,75 +1,75 @@
 config MIPS
 	bool
 	default y
-	select ARCH_SUPPORTS_UPROBES
+	select ARCH_BINFMT_ELF_STATE
+	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_DISCARD_MEMBLOCK
+	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
-	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
+	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
-	select HAVE_CONTEXT_TRACKING
-	select HAVE_GENERIC_DMA_COHERENT
-	select HAVE_IDE
-	select HAVE_IRQ_EXIT_ON_IRQ_STACK
-	select HAVE_OPROFILE
-	select HAVE_PERF_EVENTS
-	select PERF_USE_VMALLOC
+	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
+	select ARCH_WANT_IPC_PARSE_VERSION
+	select BUILDTIME_EXTABLE_SORT
+	select CLONE_BACKWARDS
+	select CPU_PM if CPU_IDLE
+	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE
+	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
+	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_TIME_VSYSCALL
+	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select HAVE_CBPF_JIT if !CPU_MICROMIPS
-	select HAVE_FUNCTION_TRACER
+	select HAVE_CC_STACKPROTECTOR
+	select HAVE_CONTEXT_TRACKING
+	select HAVE_COPY_THREAD_TLS
+	select HAVE_C_RECORDMCOUNT
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_API_DEBUG
+	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_C_RECORDMCOUNT
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_TRACER
+	select HAVE_GENERIC_DMA_COHERENT
+	select HAVE_IDE
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
-	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_SYSCALL_TRACEPOINTS
-	select ARCH_HAS_ELF_RANDOMIZE
-	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
-	select RTC_LIB if !MACH_LOONGSON64
-	select GENERIC_ATOMIC64 if !64BIT
-	select HAVE_DMA_CONTIGUOUS
-	select HAVE_DMA_API_DEBUG
-	select GENERIC_IRQ_PROBE
-	select GENERIC_IRQ_SHOW
-	select GENERIC_PCI_IOMAP
-	select HAVE_ARCH_JUMP_LABEL
-	select ARCH_WANT_IPC_PARSE_VERSION
-	select IRQ_FORCED_THREADING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
-	select ARCH_DISCARD_MEMBLOCK
-	select GENERIC_SMP_IDLE_THREAD
-	select BUILDTIME_EXTABLE_SORT
-	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
-	select GENERIC_CMOS_UPDATE
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select VIRT_TO_BUS
-	select MODULES_USE_ELF_REL if MODULES
+	select HAVE_OPROFILE
+	select HAVE_PERF_EVENTS
+	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
-	select CLONE_BACKWARDS
-	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_CC_STACKPROTECTOR
-	select CPU_PM if CPU_IDLE
-	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_BINFMT_ELF_STATE
+	select MODULES_USE_ELF_REL if MODULES
+	select PERF_USE_VMALLOC
+	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
-	select HAVE_IRQ_TIME_ACCOUNTING
-	select GENERIC_TIME_VSYSCALL
-	select ARCH_CLOCKSOURCE_DATA
-	select HANDLE_DOMAIN_IRQ
-	select HAVE_EXIT_THREAD
-	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_COPY_THREAD_TLS
+	select VIRT_TO_BUS
 
 menu "Machine selection"
 
-- 
2.7.4
