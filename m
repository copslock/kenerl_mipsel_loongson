Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 20:38:59 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1016 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225197AbTBRUi6>;
	Tue, 18 Feb 2003 20:38:58 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1IKctH24984;
	Tue, 18 Feb 2003 12:38:55 -0800
Date: Tue, 18 Feb 2003 12:38:55 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] kgdb cleanup and improvement
Message-ID: <20030218123855.L7466@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Some misc improvements.  Various bits are contributed by Kip Walker.

. reverse an earlier change of CONFIG and gcc option.
. Add detach 'D', which lets kernel run free
. Make 'kill' and 'restart' to restart the machine
. Support "call foo()" (really useful)
	- add 'G' support, increase stack reserve
. remove useless code.

2.4 patch is attached.

Jun

--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030218.a-2.4-kgdb-update.patch"

diff -Nru linux/arch/mips/kernel/gdb-stub.c.orig linux/arch/mips/kernel/gdb-stub.c
--- linux/arch/mips/kernel/gdb-stub.c.orig	Fri Feb 14 10:31:01 2003
+++ linux/arch/mips/kernel/gdb-stub.c	Tue Feb 18 12:20:16 2003
@@ -127,6 +127,8 @@
 #include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/reboot.h>
 
 #include <asm/asm.h>
 #include <asm/mipsregs.h>
@@ -595,30 +597,10 @@
 	char *ptr;
 	unsigned long *stack;
 
-#if 0
-	printk("in handle_exception()\n");
-	show_gdbregs(regs);
-#endif
-
-	/*
-	 * First check trap type. If this is CPU_UNUSABLE and CPU_ID is 1,
-	 * the simply switch the FPU on and return since this is no error
-	 * condition. kernel/traps.c does the same.
-	 * FIXME: This doesn't work yet, so we don't catch CPU_UNUSABLE
-	 * traps for now.
-	 */
-	trap = (regs->cp0_cause & 0x7c) >> 2;
-/*	printk("trap=%d\n",trap); */
-	if (trap == 11) {
-		if (((regs->cp0_cause >> CAUSEB_CE) & 3) == 1) {
-			regs->cp0_status |= ST0_CU1;
-			return;
-		}
-	}
-
 	/*
 	 * If we're in breakpoint() increment the PC
 	 */
+	trap = (regs->cp0_cause & 0x7c) >> 2;
 	if (trap == 9 && regs->cp0_epc == (unsigned long)breakinst)
 		regs->cp0_epc += 4;
 
@@ -707,6 +689,11 @@
 			output_buffer[3] = 0;
 			break;
 
+		case 'D':
+			/* detach; let CPU run */
+			putpacket(output_buffer);
+			return;
+
 		case 'd':
 			/* toggle debug flag */
 			break;
@@ -726,26 +713,21 @@
 
 		/*
 		 * set the value of the CPU registers - return OK
-		 * FIXME: Needs to be written
 		 */
 		case 'G':
 		{
-#if 0
-			unsigned long *newsp, psr;
-
 			ptr = &input_buffer[1];
-			hex2mem(ptr, (char *)registers, 16 * 4, 0); /* G & O regs */
-
-			/*
-			 * See if the stack pointer has moved. If so, then copy the
-			 * saved locals and ins to the new location.
-			 */
-
-			newsp = (unsigned long *)registers[SP];
-			if (sp != newsp)
-				sp = memcpy(newsp, sp, 16 * 4);
-
-#endif
+			hex2mem(ptr, (char *)&regs->reg0, 32*4, 0);
+			ptr += 32*8;
+			hex2mem(ptr, (char *)&regs->cp0_status, 6*4, 0);
+			ptr += 6*8;
+			hex2mem(ptr, (char *)&regs->fpr0, 32*4, 0);
+			ptr += 32*8;
+			hex2mem(ptr, (char *)&regs->cp1_fsr, 2*4, 0);
+			ptr += 2*8;
+			hex2mem(ptr, (char *)&regs->frame_ptr, 2*4, 0);
+			ptr += 2*8;
+			hex2mem(ptr, (char *)&regs->cp0_index, 16*4, 0);
 			strcpy(output_buffer,"OK");
 		 }
 		break;
@@ -811,19 +793,14 @@
 
 
 		/*
-		 * kill the program
-		 */
-		case 'k' :
-			break;		/* do nothing */
-
-
-		/*
-		 * Reset the whole machine (FIXME: system dependent)
+		 * kill the program; let us try to restart the machine
+		 * Reset the whole machine.
 		 */
+		case 'k':
 		case 'r':
+			machine_restart("kgdb restarts machine");
 			break;
 
-
 		/*
 		 * Step to next instruction
 		 */
@@ -922,6 +899,20 @@
 			);
 }
 
+/*
+ * malloc is needed by gdb client in "call func()", even a private one
+ * will make gdb happy
+ */
+static void *malloc(size_t size)
+{
+	return kmalloc(size, GFP_ATOMIC);
+}
+
+static void free(void *where)
+{
+	kfree(where);
+}
+
 #ifdef CONFIG_GDB_CONSOLE
 
 void gdb_putsn(const char *str, int l)
diff -Nru linux/arch/mips/kernel/gdb-low.S.orig linux/arch/mips/kernel/gdb-low.S
--- linux/arch/mips/kernel/gdb-low.S.orig	Mon Aug  5 16:53:33 2002
+++ linux/arch/mips/kernel/gdb-low.S	Tue Feb 18 12:11:59 2003
@@ -14,6 +14,16 @@
 #include <asm/gdb-stub.h>
 
 /*
+ * [jsun] We reserves about 2x GDB_FR_SIZE in stack.  The lower (addressed)
+ * part is used to store registers and passed to exception handler.
+ * The upper part is reserved for "call func" feature where gdb client
+ * saves some of the regs, setups call frame and passes args.
+ *
+ * A trace shows about 200 bytes are used to store about half of all regs.
+ * The rest should be big enough for frame setup and passing args.
+ */
+
+/*
  * The low level trap handler
  */
 		.align 	5
@@ -38,7 +48,7 @@
 		nop
 1:
 		move	k0,sp
-		subu	sp,k1,GDB_FR_SIZE
+		subu	sp,k1,GDB_FR_SIZE*2	# see comment above
 		sw	k0,GDB_FR_REG29(sp)
 		sw	v0,GDB_FR_REG2(sp)
 
diff -Nru linux/arch/mips/Makefile.orig linux/arch/mips/Makefile
--- linux/arch/mips/Makefile.orig	Tue Feb 18 12:28:17 2003
+++ linux/arch/mips/Makefile	Tue Feb 18 12:26:48 2003
@@ -41,8 +41,8 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_DEBUG
-GCCFLAGS	+= -gstabs+
+ifdef CONFIG_REMOTE_DEBUG
+GCCFLAGS	+= -g
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
 endif
diff -Nru linux/arch/mips64/Makefile.orig linux/arch/mips64/Makefile
--- linux/arch/mips64/Makefile.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips64/Makefile	Fri Feb 14 15:47:08 2003
@@ -39,8 +39,8 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_DEBUG
-GCCFLAGS	+= -gstabs+
+ifdef CONFIG_REMOTE_DEBUG
+GCCFLAGS	+= -g
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
 endif

--hoZxPH4CaxYzWscb--
