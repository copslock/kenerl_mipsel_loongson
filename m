From: Paul Burton <paul.burton@mips.com>
Date: Tue, 25 Sep 2018 15:51:26 -0700
Subject: MIPS: VDSO: Always map near top of user memory
Message-ID: <20180925225126.e82iJuwc79Ylt7S-E0r7-UlGiAJwfsUKlndKeciaG_g@z>

From: Paul Burton <paul.burton@mips.com>

commit ea7e0480a4b695d0aa6b3fa99bd658a003122113 upstream.

When using the legacy mmap layout, for example triggered using ulimit -s
unlimited, get_unmapped_area() fills memory from bottom to top starting
from a fairly low address near TASK_UNMAPPED_BASE.

This placement is suboptimal if the user application wishes to allocate
large amounts of heap memory using the brk syscall. With the VDSO being
located low in the user's virtual address space, the amount of space
available for access using brk is limited much more than it was prior to
the introduction of the VDSO.

For example:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00cc3000-00ce4000 rwxp 00000000 00:00 0          [heap]
  2ab96000-2ab98000 r--p 00000000 00:00 0          [vvar]
  2ab98000-2ab99000 r-xp 00000000 00:00 0          [vdso]
  2ab99000-2ab9d000 rwxp 00000000 00:00 0
  ...

Resolve this by adjusting STACK_TOP to reserve space for the VDSO &
providing an address hint to get_unmapped_area() causing it to use this
space even when using the legacy mmap layout.

We reserve enough space for the VDSO, plus 1MB or 256MB for 32 bit & 64
bit systems respectively within which we randomize the VDSO base
address. Previously this randomization was taken care of by the mmap
base address randomization performed by arch_mmap_rnd(). The 1MB & 256MB
sizes are somewhat arbitrary but chosen such that we have some
randomization without taking up too much of the user's virtual address
space, which is often in short supply for 32 bit systems.

With this the VDSO is always mapped at a high address, leaving lots of
space for statically linked programs to make use of brk:

  # ulimit -s unlimited; cat /proc/self/maps
  00400000-004ec000 r-xp 00000000 08:00 71436      /usr/bin/coreutils
  004fc000-004fd000 rwxp 000ec000 08:00 71436      /usr/bin/coreutils
  004fd000-0050f000 rwxp 00000000 00:00 0
  00c28000-00c49000 rwxp 00000000 00:00 0          [heap]
  ...
  7f67c000-7f69d000 rwxp 00000000 00:00 0          [stack]
  7f7fc000-7f7fd000 rwxp 00000000 00:00 0
  7fcf1000-7fcf3000 r--p 00000000 00:00 0          [vvar]
  7fcf3000-7fcf4000 r-xp 00000000 00:00 0          [vdso]

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Huacai Chen <chenhc@lemote.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/processor.h |   10 +++++-----
 arch/mips/kernel/process.c        |   25 +++++++++++++++++++++++++
 arch/mips/kernel/vdso.c           |   18 +++++++++++++++++-
 3 files changed, 47 insertions(+), 6 deletions(-)

--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -13,6 +13,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/sizes.h>
 #include <linux/threads.h>
 
 #include <asm/cachectl.h>
@@ -80,11 +81,10 @@ extern unsigned int vced_count, vcei_cou
 
 #endif
 
-/*
- * One page above the stack is used for branch delay slot "emulation".
- * See dsemul.c for details.
- */
-#define STACK_TOP	((TASK_SIZE & PAGE_MASK) - PAGE_SIZE)
+#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_256M)
+
+extern unsigned long mips_stack_top(void);
+#define STACK_TOP		mips_stack_top()
 
 /*
  * This decides where the kernel will search for a free chunk of vm
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -31,6 +31,7 @@
 #include <linux/prctl.h>
 #include <linux/nmi.h>
 
+#include <asm/abi.h>
 #include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -38,6 +39,7 @@
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/irq.h>
+#include <asm/mips-cps.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
@@ -644,6 +646,29 @@ out:
 	return pc;
 }
 
+unsigned long mips_stack_top(void)
+{
+	unsigned long top = TASK_SIZE & PAGE_MASK;
+
+	/* One page for branch delay slot "emulation" */
+	top -= PAGE_SIZE;
+
+	/* Space for the VDSO, data page & GIC user page */
+	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+	top -= PAGE_SIZE;
+	top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+	/* Space for cache colour alignment */
+	if (cpu_has_dc_aliases)
+		top -= shm_align_mask + 1;
+
+	/* Space to randomize the VDSO base */
+	if (current->flags & PF_RANDOMIZE)
+		top -= VDSO_RANDOMIZE_SIZE;
+
+	return top;
+}
+
 /*
  * Don't forget that the stack pointer must be aligned on a 8 bytes
  * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
@@ -97,6 +98,21 @@ void update_vsyscall_tz(void)
 	}
 }
 
+static unsigned long vdso_base(void)
+{
+	unsigned long base;
+
+	/* Skip the delay slot emulation page */
+	base = STACK_TOP + PAGE_SIZE;
+
+	if (current->flags & PF_RANDOMIZE) {
+		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
+		base = PAGE_ALIGN(base);
+	}
+
+	return base;
+}
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
@@ -137,7 +153,7 @@ int arch_setup_additional_pages(struct l
 	if (cpu_has_dc_aliases)
 		size += shm_align_mask + 1;
 
-	base = get_unmapped_area(NULL, 0, size, 0, 0);
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;


Patches currently in stable-queue which might be from paul.burton@mips.com are

queue-4.18/mips-vdso-always-map-near-top-of-user-memory.patch
queue-4.18/mips-fix-config_cmdline-handling.patch
