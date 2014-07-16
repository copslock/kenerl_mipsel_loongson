From: Huacai Chen <chenhc@lemote.com>
Date: Wed, 16 Jul 2014 09:19:16 +0800
Subject: MIPS: Remove BUG_ON(!is_fpu_owner()) in do_ade()
Message-ID: <20140716011916.L79M8xpWQCRojeLLHLQjxBf1auspyu4PGZsE3dujEbk@z>

commit 2e5767a27337812f6850b3fa362419e2f085e5c3 upstream.

In do_ade(), is_fpu_owner() isn't preempt-safe. For example, when an
unaligned ldc1 is executed, do_cpu() is called and then FPU will be
enabled (and TIF_USEDFPU will be set for the current process). Then,
do_ade() is called because the access is unaligned.  If the current
process is preempted at this time, TIF_USEDFPU will be cleard.  So when
the process is scheduled again, BUG_ON(!is_fpu_owner()) is triggered.

This small program can trigger this BUG in a preemptible kernel:

int main (int argc, char *argv[])
{
        double u64[2];

        while (1) {
                asm volatile (
                        ".set push \n\t"
                        ".set noreorder \n\t"
                        "ldc1 $f3, 4(%0) \n\t"
                        ".set pop \n\t"
                        ::"r"(u64):
                );
        }

        return 0;
}

V2: Remove the BUG_ON() unconditionally due to Paul's suggestion.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jie Chen <chenj@lemote.com>
Signed-off-by: Rui Wang <wangr@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/unaligned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index c369a5d..b897dde 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -605,7 +605,6 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	case sdc1_op:
 		die_if_kernel("Unaligned FP access in kernel code", regs);
 		BUG_ON(!used_math());
-		BUG_ON(!is_fpu_owner());

 		lose_fpu(1);	/* Save FPU state for the emulator. */
 		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
--
1.9.1
