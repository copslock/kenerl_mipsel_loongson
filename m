From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 27 Jul 2015 13:50:21 +0100
Subject: MIPS: do_mcheck: Fix kernel code dump with EVA
Message-ID: <20150727125021.SuuZ95e5doVOsg9fJ6DHkf9ckbnqmYEDRpQWMuqKL0o@z>

commit 55c723e181ccec30fb5c672397fe69ec35967d97 upstream.

If a machine check exception is raised in kernel mode, user context,
with EVA enabled, then the do_mcheck handler will attempt to read the
code around the EPC using EVA load instructions, i.e. as if the reads
were from user mode. This will either read random user data if the
process has anything mapped at the same address, or it will cause an
exception which is handled by __get_user, resulting in this output:

 Code: (Bad address in epc)

Fix by setting the current user access mode to kernel if the saved
register context indicates the exception was taken in kernel mode. This
causes __get_user to use normal loads to read the kernel code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10777/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/traps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c3b41e2..f4aacec 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1423,6 +1423,7 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 	const int field = 2 * sizeof(unsigned long);
 	int multi_match = regs->cp0_status & ST0_TS;
 	enum ctx_state prev_state;
+	mm_segment_t old_fs = get_fs();

 	prev_state = exception_enter();
 	show_regs(regs);
@@ -1444,8 +1445,13 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
 		dump_tlb_all();
 	}

+	if (!user_mode(regs))
+		set_fs(KERNEL_DS);
+
 	show_code((unsigned int __user *) regs->cp0_epc);

+	set_fs(old_fs);
+
 	/*
 	 * Some chips may have other causes of machine check (e.g. SB1
 	 * graduation timer)
--
1.9.1
