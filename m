Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5GJpPr14045
	for linux-mips-outgoing; Sat, 16 Jun 2001 12:51:25 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5GJpLZ14039
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 12:51:21 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06304
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 12:51:15 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15BLwM-0008Az-00
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 12:41:02 -0700
Date: Sat, 16 Jun 2001 12:41:02 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@oss.sgi.com
Subject: [patch flood] Debugging patches
Message-ID: <20010616124102.A31141@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been actively working on GDB for the past two weeks now.  A good half
of the problems I've had have turned out to be kernel bugs; one of them
(shadowing res in the POKEUSR case in sys_ptrace) was already fixed in the
OSS tree and not in our local tree, but the others were still somewhat
interesting.

The biggest one was the fact that passing arguments to the inferior in
floating point registers just didn't work.  I tracked this down to at least
three separate problems:
  - We would set last_task_used_math without clearing the ST0_CU1 bit in
    the previous task owning the FPU.  When that previous task swapped
    in again, it would use the existing FP registers, and lazy_fpu_switch
    would never be called.  This happened in signal.c and in ptrace.c.
  - ptrace didn't look for the FP registers in the right places.  This's
    been broken since the FPU emulator merge a while back.
  - We would create new processes with the ST0_CU1 bit already set if
    their parent process had it set.

Of course, the lazy switching isn't quite as useful as it could be, since
every program will eventually use the FPU if not build -msoft-float - I
think it's happening in glibc.  But we can possibly work around that later. 
It still does save a great number of switches, so it's worthwhile - when it
works.


Other patches in my directory that I'm submitting along with that one:
 - kgdb-crash-resistant.diff
    This makes kgdb survive an attempt to dereference bad memory.  It only
    works after memory management has been set up, though.  It's possible
    to do it in such a way that it works even earlier - see PowerPC for an
    example.  We would have to set the fault handler temporarily, and
    basically longjmp out of the fault handler.  This is much more
    straightforward, and met my needs at the time.
 - mips-gdb-with-kgdb.diff
    There's no good reason to trigger kgdb on any trap whose origin is in
    userland - it's a kernel debugger, right?  So I save the traps, and
    pass them along to the old handlers if necessary.  This way kgdb won't
    stop on SIGTRAP when you set a breakpoint in gdb.
 - mips-rtsignal.diff
    Thought I'd sent this already... but I guess not.  setup_frame and
    setup_rt_frame build structures of different sizes, matching
    sys_sigreturn and sys_rt_sigreturn respectively.  Wouldn't it be useful
    if the frame setup_rt_frame built returned into the right function?

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fpu-sharing.diff"

Index: arch/mips/kernel/ptrace.c
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/ptrace.c,v
retrieving revision 1.3
diff -u -r1.3 ptrace.c
--- arch/mips/kernel/ptrace.c	2001/06/15 00:58:41	1.3
+++ arch/mips/kernel/ptrace.c	2001/06/16 19:06:59
@@ -149,8 +149,19 @@
 					save_fp(child);
 					disable_cp1();
 					last_task_used_math = NULL;
+					regs->cp0_status &= ~ST0_CU1;
 				}
-				tmp = (unsigned long) fregs[(addr - 32)];
+				/* The odd registers are actually the high order bits of the values
+				   stored in the even registers - unless we're using r2k_switch.S. */
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_R3912)
+				if (mips_cpu_options & MIPS_CPU_FPU)
+					tmp = *(unsigned long *)(fregs + addr);
+				else
+#endif
+				if (addr & 1)
+					tmp = (unsigned long) (fregs[((addr & ~1) - 32)] >> 32);
+				else
+					tmp = (unsigned long) (fregs[(addr - 32)] & 0xffffffff);
 			} else {
 				tmp = -1;	/* FP not yet used  */
 			}
@@ -238,8 +249,21 @@
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
 				child->thread.fpu.hard.control = 0;
+			}
+			/* The odd registers are actually the high order bits of the values
+			   stored in the even registers - unless we're using r2k_switch.S. */
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_R3912)
+			if (mips_cpu_options & MIPS_CPU_FPU)
+				*(unsigned long *)(fregs + addr) = data;
+			else
+#endif
+			if (addr & 1) {
+				fregs[(addr & ~1) - FPR_BASE] &= 0xffffffff;
+				fregs[(addr & ~1) - FPR_BASE] |= ((unsigned long long) data) << 32;
+			} else {
+				fregs[addr - FPR_BASE] &= ~0xffffffffLL;
+				fregs[addr - FPR_BASE] |= data;
 			}
-			fregs[addr - FPR_BASE] = data;
 			break;
 		}
 		case PC:
Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.2
diff -u -r1.2 signal.c
--- arch/mips/kernel/signal.c	2001/05/30 00:08:10	1.2
+++ arch/mips/kernel/signal.c	2001/06/16 19:06:59
@@ -220,8 +220,10 @@
 
 	err |= __get_user(owned_fp, &sc->sc_ownedfp);
 	if (owned_fp) {
+		if (last_task_used_math && (last_task_used_math != current))
+			last_task_used_math->thread.cp0_status &= ~ST0_CU1;
 		err |= restore_fp_context(sc);
 		last_task_used_math = current;
 	}
 
 	return err;
@@ -353,12 +355,11 @@
 	owned_fp = (current == last_task_used_math);
 	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 
-	if (current->used_math) {	/* fp is active.  */
+	if (owned_fp) {	/* fp is active.  */
 		set_cp0_status(ST0_CU1);
 		err |= save_fp_context(sc);
 		last_task_used_math = NULL;
 		regs->cp0_status &= ~ST0_CU1;
-		current->used_math = 0;
 	}
 
 	return err;
Index: include/asm-mips/processor.h
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/include/asm-mips/processor.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 processor.h
--- include/asm-mips/processor.h	2001/03/27 22:01:19	1.1.1.2
+++ include/asm-mips/processor.h	2001/06/16 19:07:05
@@ -235,8 +235,8 @@
  * Do necessary setup to start up a newly executed thread.
  */
 #define start_thread(regs, new_pc, new_sp) do {				\
-	/* New thread looses kernel privileges. */			\
-	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU)) | KU_USER;\
+	/* New thread loses kernel and FPU privileges. */		\
+	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU|ST0_CU1)) | KU_USER;\
 	regs->cp0_epc = new_pc;						\
 	regs->regs[29] = new_sp;					\
 	current->thread.current_ds = USER_DS;				\

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kgdb-crash-resistant.diff"

Index: arch/mips/kernel/gdb-low.S
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/gdb-low.S,v
retrieving revision 1.2
diff -u -r1.2 gdb-low.S
--- arch/mips/kernel/gdb-low.S	2001/06/15 00:58:41	1.2
+++ arch/mips/kernel/gdb-low.S	2001/06/16 19:06:59
@@ -11,6 +11,7 @@
 #include <linux/sys.h>
 
 #include <asm/asm.h>
+#include <asm/errno.h>
 #include <asm/mipsregs.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
@@ -314,3 +315,36 @@
 		.set	at
 		.set	reorder
 		END(trap_low)
+
+LEAF(kgdb_read_byte)
+		.set push
+		.set noreorder
+		.set nomacro
+4:		lb	t0, (a0)
+		.set pop
+		sb	t0, (a1)
+		li	v0, 0
+		jr	ra
+		.section __ex_table,"a"
+		PTR	4b, kgdbfault
+		.previous
+		END(kgdb_read_byte)
+
+LEAF(kgdb_write_byte)
+		.set push
+		.set noreorder
+		.set nomacro
+5:		sb	a0, (a1)
+		.set pop
+		li	v0, 0
+		jr	ra
+		.section __ex_table,"a"
+		PTR	5b, kgdbfault
+		.previous
+		END(kgdb_write_byte)
+
+		.type	kgdbfault@function
+		.ent	kgdbfault
+kgdbfault:	li	v0, -EFAULT
+		jr	ra
+		.end	kgdbfault
Index: arch/mips/kernel/gdb-stub.c
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/gdb-stub.c,v
retrieving revision 1.2
diff -u -r1.2 gdb-stub.c
--- arch/mips/kernel/gdb-stub.c	2001/06/15 00:58:41	1.2
+++ arch/mips/kernel/gdb-stub.c	2001/06/16 19:06:59
@@ -140,7 +140,6 @@
 
 extern int putDebugChar(char c);    /* write a single character      */
 extern char getDebugChar(void);     /* read and return a single char */
-extern void fltr_set_mem_err(void);
 extern void trap_low(void);
 
 /*
@@ -173,6 +172,10 @@
 static int initialized;	/* !0 means we've been initialized */
 static const char hexchars[]="0123456789abcdef";
 
+/* Used to prevent crashes in memory access.  Note that they'll crash anyway if
+   we haven't set up fault handlers yet... */
+int kgdb_read_byte(unsigned *address, unsigned *dest);
+int kgdb_write_byte(unsigned val, unsigned *dest);
 
 /*
  * Convert ch from a hex digit to an int
@@ -292,42 +295,18 @@
 
 
 /*
- * Indicate to caller of mem2hex or hex2mem that there
- * has been an error.
- */
-static volatile int mem_err = 0;
-
-
-#if 0
-static void set_mem_fault_trap(int enable)
-{
-  mem_err = 0;
-
-#if 0
-  if (enable)
-    exceptionHandler(9, fltr_set_mem_err);
-  else
-    exceptionHandler(9, trap_low);
-#endif  
-}
-#endif /* dead code */
-
-/*
  * Convert the memory pointed to by mem into hex, placing result in buf.
  * Return a pointer to the last char put in buf (null), in case of mem fault,
  * return 0.
- * If MAY_FAULT is non-zero, then we will handle memory faults by returning
- * a 0, else treat a fault like any other fault in the stub.
+ * may_fault is non-zero if we are reading from arbitrary memory, but is currently
+ * not used.
  */
 static unsigned char *mem2hex(char *mem, char *buf, int count, int may_fault)
 {
 	unsigned char ch;
 
-/*	set_mem_fault_trap(may_fault); */
-
 	while (count-- > 0) {
-		ch = *(mem++);
-		if (mem_err)
+		if (kgdb_read_byte(mem++, &ch) != 0)
 			return 0;
 		*buf++ = hexchars[ch >> 4];
 		*buf++ = hexchars[ch & 0xf];
@@ -335,33 +314,28 @@
 
 	*buf = 0;
 
-/*	set_mem_fault_trap(0); */
-
 	return buf;
 }
 
 /*
  * convert the hex array pointed to by buf into binary to be placed in mem
  * return a pointer to the character AFTER the last byte written
+ * may_fault is non-zero if we are reading from arbitrary memory, but is currently
+ * not used.
  */
 static char *hex2mem(char *buf, char *mem, int count, int may_fault)
 {
 	int i;
 	unsigned char ch;
 
-/*	set_mem_fault_trap(may_fault); */
-
 	for (i=0; i<count; i++)
 	{
 		ch = hex(*buf++) << 4;
 		ch |= hex(*buf++);
-		*(mem++) = ch;
-		if (mem_err)
+		if (kgdb_write_byte(ch, mem++) != 0)
 			return 0;
 	}
 
-/*	set_mem_fault_trap(0); */
-
 	return mem;
 }
 
@@ -416,18 +390,6 @@
 
 	initialized = 1;
 	restore_flags(flags);
-}
-
-
-/*
- * Trap handler for memory errors.  This just sets mem_err to be non-zero.  It
- * assumes that %l1 is non-zero.  This should be safe, as it is doubtful that
- * 0 would ever contain code that could mem fault.  This routine will skip
- * past the faulting instruction after setting mem_err.
- */
-extern void fltr_set_mem_err(void)
-{
-	/* FIXME: Needs to be written... */
 }
 
 /*

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-gdb-with-kgdb.diff"

Index: arch/mips/kernel/gdb-low.S
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/gdb-low.S,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 gdb-low.S
--- arch/mips/kernel/gdb-low.S	2001/03/27 21:42:03	1.1.1.1
+++ arch/mips/kernel/gdb-low.S	2001/06/14 19:13:24
@@ -30,10 +30,14 @@
 		move	k1,sp
 
 		/*
-		 * Called from user mode, new stack
+		 * Called from user mode, go somewhere else.
 		 */
-		lui	k1,%hi(kernelsp)
-		lw	k1,%lo(kernelsp)(k1)
+		lui	k1,%hi(saved_vectors)
+		mfc0	k0,CP0_CAUSE
+		andi	k0,k0,0x7c
+		add	k1,k1,k0
+		lw	k0,%lo(saved_vectors)(k1)
+		jr	k0
 1:
 		move	k0,sp
 		subu	sp,k1,GDB_FR_SIZE
Index: arch/mips/kernel/gdb-stub.c
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/gdb-stub.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 gdb-stub.c
--- arch/mips/kernel/gdb-stub.c	2001/03/27 22:03:28	1.1.1.2
+++ arch/mips/kernel/gdb-stub.c	2001/06/14 19:13:24
@@ -388,6 +388,8 @@
 	{ 0, 0}				/* Must be last */
 };
 
+/* Save the normal trap handlers for user-mode traps. */
+void *saved_vectors[32];
 
 /*
  * Set up exception handlers for tracing and breakpoints
@@ -400,7 +402,7 @@
 
 	save_and_cli(flags);
 	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
-		set_except_vector(ht->tt, trap_low);
+		saved_vectors[ht->tt] = set_except_vector(ht->tt, trap_low);
   
 	/*
 	 * In case GDB is started before us, ack any packets

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mips-rtsigreturn.diff"

Index: signal.c
===================================================================
RCS file: /cvsroot/hhl-2.4.2/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 signal.c
--- signal.c	2001/03/27 22:03:28	1.1.1.2
+++ signal.c	2001/05/25 23:46:15
@@ -464,10 +464,10 @@
 		/*
 		 * Set up the return code ...
 		 *
-		 *         li      v0, __NR_sigreturn
+		 *         li      v0, __NR_rt_sigreturn
 		 *         syscall
 		 */
-		err |= __put_user(0x24020000 + __NR_sigreturn,
+		err |= __put_user(0x24020000 + __NR_rt_sigreturn,
 		                  frame->rs_code + 0);
 		err |= __put_user(0x0000000c                 ,
 		                  frame->rs_code + 1);

--6TrnltStXW4iwmi0--
