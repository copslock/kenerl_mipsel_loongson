From: Alex Smith <alex@alex-smith.me.uk>
Date: Wed, 23 Jul 2014 14:40:07 +0100
Subject: MIPS: ptrace: Test correct task's flags in task_user_regset_view()
Message-ID: <20140723134007.RwG8Df2wtiliGw4oTAbeN3LyVjgLwIrlNZKadthFO3Y@z>

commit 65768a1a92cb12cbba87588927cf597a65d560aa upstream.

task_user_regset_view() should test for TIF_32BIT_REGS in the flags of
the specified task, not of the current task.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7450/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index f6e6709..2b32dd4 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -384,7 +384,7 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 #endif

 #ifdef CONFIG_MIPS32_O32
-		if (test_thread_flag(TIF_32BIT_REGS))
+		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 			return &user_mips_view;
 #endif

--
1.9.1
