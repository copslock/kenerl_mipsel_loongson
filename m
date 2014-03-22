From: Huacai Chen <chenhc@lemote.com>
Date: Sat, 22 Mar 2014 17:21:44 +0800
Subject: MIPS: Hibernate: Flush TLB entries in swsusp_arch_resume()
Message-ID: <20140322092144.z_brs4nhzxApxRMqYl1kiEjB5BG4E4fIO4mynUc14I0@z>

commit c14af233fbe279d0e561ecf84f1208b1bae087ef upstream.

The original MIPS hibernate code flushes cache and TLB entries in
swsusp_arch_resume(). But they are removed in Commit 44eeab67416711
(MIPS: Hibernation: Remove SMP TLB and cacheflushing code.). A cross-
CPU flush is surely unnecessary because all but the local CPU have
already been disabled. But a local flush (at least the TLB flush) is
needed. When we do hibernation on Loongson-3 with an E1000E NIC, it is
very easy to produce a kernel panic (kernel page fault, or unaligned
access). The root cause is E1000E driver use vzalloc_node() to allocate
pages, the stale TLB entries of the booting kernel will be misused by
the resumed target kernel.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/6643/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/power/hibernate.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 7e0277a..32a7c82 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -43,6 +43,7 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
+	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
--
1.9.1
