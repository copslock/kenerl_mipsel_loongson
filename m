From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Mon, 29 May 2017 09:22:07 +0200
Subject: kthread: fix boot hang (regression) on MIPS/OpenRISC
Message-ID: <20170529072207.y6r8YpRiImOwbTY-uWyWQ5-nLOz9Y4bbDRNZ5xspMNc@z>

From: Vegard Nossum <vegard.nossum@oracle.com>

commit b0f5a8f32e8bbdaae1abb8abe2d3cbafaba57e08 upstream.

This fixes a regression in commit 4d6501dce079 where I didn't notice
that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
NULL after our initialisation in copy_process().

We can simply get rid of the arch-specific initialisation here since it
is now always done in copy_process() before hitting copy_thread{,_tls}().

Review notes:

 - As far as I can tell, copy_process() is the only user of
   copy_thread_tls(), which is the only caller of copy_thread() for
   architectures that don't implement copy_thread_tls().

 - After this patch, there is no arch-specific code touching
   p->set_child_tid or p->clear_child_tid whatsoever.

 - It may look like MIPS/OpenRISC wanted to always have these fields be
   NULL, but that's not true, as copy_process() would unconditionally
   set them again _after_ calling copy_thread_tls() before commit
   4d6501dce079.

Fixes: 4d6501dce079c1eb6bf0b1d8f528a5e81770109e ("kthread: Fix use-after-free if kthread fork fails")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net> # MIPS only
Acked-by: Stafford Horne <shorne@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
Cc: Jamie Iles <jamie.iles@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c     |    1 -
 arch/openrisc/kernel/process.c |    2 --
 2 files changed, 3 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -118,7 +118,6 @@ int copy_thread(unsigned long clone_flag
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
 	unsigned long childksp;
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
 
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -152,8 +152,6 @@ copy_thread(unsigned long clone_flags, u
 
 	top_of_kernel_stack = sp;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Locate userspace context on stack... */
 	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
 	sp -= sizeof(struct pt_regs);


Patches currently in stable-queue which might be from vegard.nossum@oracle.com are

queue-4.9/kthread-fix-use-after-free-if-kthread-fork-fails.patch
queue-4.9/kthread-fix-boot-hang-regression-on-mips-openrisc.patch
