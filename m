Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OIGTRw003988
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 11:16:29 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OIGTPt003987
	for linux-mips-outgoing; Wed, 24 Jul 2002 11:16:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OIGDRw003976
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 11:16:14 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17XQhA-0001Q2-00
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 20:17:08 +0200
Date: Wed, 24 Jul 2002 20:17:08 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@oss.sgi.com
Subject: _stext is ill-defined / SysRq-T broken
Message-ID: <20020724181708.GA5399@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I use the following patch to enable SysRq on serial console
(via Ctrl-A-F == "Break" in minicom):


--- linux-oss-2.4.19-rc1-20020715.base/drivers/char/dummy_keyb.c	Fri Oct 19 03:24:11 2001
+++ linux-oss-2.4.19-rc1-20020715/drivers/char/dummy_keyb.c	Tue Jul 16 18:57:19 2002
@@ -23,9 +23,15 @@
  * CONFIG_VT.
  *
  */
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+
+#if (!defined(CONFIG_PC_KEYB) && defined (CONFIG_MAGIC_SYSRQ))
+unsigned char kbd_sysrq_xlate[128];
+unsigned char kbd_sysrq_key = 0;
+#endif
 
 void kbd_leds(unsigned char leds)
 {



SysRq-T (showTasks) gives me the following output:
-----------------
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S 00000000     0     1      0   179               (NOTLB)

Call Trace:keventd       S 00000000     0     2      1             3       (L-TLB)

Call Trace:ksoftirqd_CPU S 00000000     0     3      1             4     2 (L-TLB)
[snip]
-----------------

Two problems:
a) there is no call trace, and 
b) there is bad formatting when the call trace is empty.


I found that the cause for this is that _stext (defined in head.S) is in
.text.init instead of .text, so it's past _etext.

I suggest the patch below to fix the bad formatting, but I'm
not shure about _stext. Should kernel_entry be placed into the .text
section, or should _stext = _ftext in ld.script?

Another nit (I don't have ejtag, so I don't care much):
  head.S: Assembler messages:
  head.S:102: Warning: Macro instruction expanded into multiple instructions in a branch delay slot
Maybe someone has spare nop to put there.


Johannes


--- linux-oss-2.4.19-rc1-20020715.base/arch/mips/kernel/traps.c	Mon Jul 15 15:42:06 2002
+++ linux-oss-2.4.19-rc1-20020715/arch/mips/kernel/traps.c	Wed Jul 24 20:08:05 2002
@@ -230,7 +230,7 @@ void show_trace(unsigned int *sp)
 	module_start = VMALLOC_START;
 	module_end = module_start + MODULE_RANGE;
 
-	printk("\nCall Trace:");
+	printk("Call Trace:");
 
 	while ((unsigned long) stack & (PAGE_SIZE -1)) {
 		unsigned long addr;
@@ -250,21 +250,20 @@ void show_trace(unsigned int *sp)
 		 */
 
 		if ((addr >= kernel_start && addr < kernel_end) ||
-		    (addr >= module_start && addr < module_end)) { 
+		    (addr >= module_start && addr < module_end)) {
 
-			printk(" [<%08lx>]", addr);
-			if (column++ == 5) {
-				printk("\n");
-				column = 0;
-			}
 			if (++i > 40) {
 				printk(" ...");
 				break;
 			}
+			if (column++ > 5) {
+				printk("\n           ");
+				column = 1;
+			}
+			printk(" [<%08lx>]", addr);
 		}
 	}
-	if (column != 0)
-		printk("\n");
+	printk("\n");
 }
 
 void show_trace_task(struct task_struct *tsk)
