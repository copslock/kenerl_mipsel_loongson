Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2003 11:00:55 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:27375 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225073AbTDUKAv>;
	Mon, 21 Apr 2003 11:00:51 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id TAA10812;
	Mon, 21 Apr 2003 19:00:46 +0900 (JST)
Received: 4UMDO01 id h3LA0kA20446; Mon, 21 Apr 2003 19:00:46 +0900 (JST)
Received: 4UMRO00 id h3LA0jB21102; Mon, 21 Apr 2003 19:00:46 +0900 (JST)
	from pudding.montavista.co.jp (localhost [127.0.0.1]) (authenticated)
Date: Mon, 21 Apr 2003 19:00:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: simulate_ll and simulate_sc move to do_cpu from do_ri
Message-Id: <20030421190045.57b3801c.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20030418204553.A29634@linux-mips.org>
References: <20030418181748.57f7789a.yuasa@hh.iij4u.or.jp>
	<20030418204553.A29634@linux-mips.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__21_Apr_2003_19:00:45_+0900_086d0fa8"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__21_Apr_2003_19:00:45_+0900_086d0fa8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

On Fri, 18 Apr 2003 20:45:53 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Apr 18, 2003 at 06:17:48PM +0900, Yoichi Yuasa wrote:
> 
> > Why did you move simulate_ll and simulate_sc to do_cpu from do_ri?
> > NEC VR4100 series need simulate_ll and simulate_sc in do_ri.
> 
> As the CVS comment said ll is using the opcode for lwc0 and sc the opcode
> for swc0 so the expected behaviour of an attempt to execute ll or sc on a
> ll/sc-less processor is throwing a coprocessor unusable exception, not
> reserved exception.
> 
> So if the VR4100 series is indeed throwing RI exceptions then this processor
> is plain broken.  Will fix but not without cursing into NEC's direction.
> 
> Grr...

In addition, the attached patches are still required for NEC VR4100 series.
Please apply these patches.

Yoichi

--Multipart_Mon__21_Apr_2003_19:00:45_+0900_086d0fa8
Content-Type: text/plain;
 name="simulate_llsc-v24.diff"
Content-Disposition: attachment;
 filename="simulate_llsc-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/cpu-probe.c linux/arch/mips/kernel/cpu-probe.c
--- linux.orig/arch/mips/kernel/cpu-probe.c	Thu Apr 17 12:30:25 2003
+++ linux/arch/mips/kernel/cpu-probe.c	Mon Apr 21 12:30:05 2003
@@ -244,7 +244,7 @@
 				break;
 			}
                         current_cpu_data.isa_level = MIPS_CPU_ISA_III;
-                        current_cpu_data.options = R4K_OPTS | MIPS_CPU_LLSC;
+                        current_cpu_data.options = R4K_OPTS;
                         current_cpu_data.tlbsize = 32;
                         break;
 		case PRID_IMP_R4300:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/proc.c linux/arch/mips/kernel/proc.c
--- linux.orig/arch/mips/kernel/proc.c	Wed Apr 16 12:51:18 2003
+++ linux/arch/mips/kernel/proc.c	Mon Apr 21 12:24:00 2003
@@ -71,6 +71,10 @@
 	[CPU_VR4181A]	"NEC VR4181A"
 };
 
+#ifndef CONFIG_CPU_HAS_LLSC
+extern unsigned long ll_ops;
+extern unsigned long sc_ops;
+#endif
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Mon Apr 21 10:56:54 2003
+++ linux/arch/mips/kernel/traps.c	Mon Apr 21 12:39:25 2003
@@ -405,8 +405,8 @@
  * For now we don't have a mechanism to dump these variables to
  * /procfs anymore ...
  */
-static unsigned long ll_ops;
-static unsigned long sc_ops;
+unsigned long ll_ops;
+unsigned long sc_ops;
 #endif
 
 static struct task_struct *ll_task = NULL;
@@ -521,11 +521,11 @@
 
 	if ((opcode & OPCODE) == LL) {
 		simulate_ll(regs, opcode);
-		return;
+		return 0;
 	}
 	if ((opcode & OPCODE) == SC) {
 		simulate_sc(regs, opcode);
-		return;
+		return 0;
 	}
 }
 

--Multipart_Mon__21_Apr_2003_19:00:45_+0900_086d0fa8
Content-Type: text/plain;
 name="simulate_llsc-v25.diff"
Content-Disposition: attachment;
 filename="simulate_llsc-v25.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/cpu-probe.c linux/arch/mips/kernel/cpu-probe.c
--- linux.orig/arch/mips/kernel/cpu-probe.c	Thu Apr 17 12:31:41 2003
+++ linux/arch/mips/kernel/cpu-probe.c	Mon Apr 21 18:28:51 2003
@@ -244,7 +244,7 @@
 				break;
 			}
                         current_cpu_data.isa_level = MIPS_CPU_ISA_III;
-                        current_cpu_data.options = R4K_OPTS | MIPS_CPU_LLSC;
+                        current_cpu_data.options = R4K_OPTS;
                         current_cpu_data.tlbsize = 32;
                         break;
 		case PRID_IMP_R4300:
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/proc.c linux/arch/mips/kernel/proc.c
--- linux.orig/arch/mips/kernel/proc.c	Wed Apr 16 12:52:27 2003
+++ linux/arch/mips/kernel/proc.c	Mon Apr 21 18:29:29 2003
@@ -71,6 +71,10 @@
 	[CPU_VR4181A]	"NEC VR4181A"
 };
 
+#ifndef CONFIG_CPU_HAS_LLSC
+extern unsigned long ll_ops;
+extern unsigned long sc_ops;
+#endif
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Mon Apr 21 10:59:49 2003
+++ linux/arch/mips/kernel/traps.c	Mon Apr 21 18:30:15 2003
@@ -400,8 +400,8 @@
  * For now we don't have a mechanism to dump these variables to
  * /procfs anymore ...
  */
-static unsigned long ll_ops;
-static unsigned long sc_ops;
+unsigned long ll_ops;
+unsigned long sc_ops;
 #endif
 
 static struct task_struct *ll_task = NULL;
@@ -516,11 +516,11 @@
 
 	if ((opcode & OPCODE) == LL) {
 		simulate_ll(regs, opcode);
-		return;
+		return 0;
 	}
 	if ((opcode & OPCODE) == SC) {
 		simulate_sc(regs, opcode);
-		return;
+		return 0;
 	}
 }
 

--Multipart_Mon__21_Apr_2003_19:00:45_+0900_086d0fa8--
