Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I0jN8d032255
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 17:45:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I0jNvp032254
	for linux-mips-outgoing; Wed, 17 Apr 2002 17:45:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I0j88d032242
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 17:45:08 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA00127
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 17:45:48 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id RAA08255;
	Wed, 17 Apr 2002 17:30:09 -0700
Message-ID: <3CBE1399.9020702@mvista.com>
Date: Wed, 17 Apr 2002 17:30:17 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: ieee754_csr and smp (again)
Content-Type: multipart/mixed;
 boundary="------------010108030005080606060305"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------010108030005080606060305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OK, ieee754_csr is a global variable and it screws up fpu emulation code under 
smp.

I have a patch that makes the problem go away.  It basically transform this 
variable into an array of global variables.  Each cpu only uses one of the 
elements.  See the attachment.

That patch works, but I think there might be a better fix.  Looking through 
the code, I am rather confused by the usage of this variable.  Hopefully 
someone with more better knowledge can help me out here.

. should ieee754_csr be a per-thread variable?  If yes, we should just use the 
current->thread->xxx instead of this global variable.

. what is ieee754_csr for anyway?

. Some of the fields in ieee754_csr (such as nod, rm, cx) gets set in 
fpu_emulator_cop1Handler().  But what about others?

. I can't find anywhere we write iee754_csr back to the current->thread 
structure.  Do I miss anything?

Thanks.

Jun

--------------010108030005080606060305
Content-Type: text/plain;
 name="020411.math-emu-smp-safe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="020411.math-emu-smp-safe.patch"


Copy from the patch checked into our EAP.  This
is still a little hackish.  Hopefully we can settle it better later.
A per-cpu page would be nice so that we don't have declare arrays.

BTW, ralf thinks ieee754_csr should belong to per thread fpu structure.
I check it in now anyway so that we have some reliable for running.

Jun

diff -Nru smp/arch/mips/kernel/traps.c.orig smp/arch/mips/kernel/traps.c
--- smp/arch/mips/kernel/traps.c.orig	Wed Feb 13 16:23:12 2002
+++ smp/arch/mips/kernel/traps.c	Thu Apr 11 15:46:11 2002
@@ -678,14 +678,11 @@
 	return;
 
 fp_emul:
-	if (last_task_used_math != current) {
-		if (!current->used_math) {
-			fpu_emulator_init_fpu();
-			current->used_math = 1;
-		}
+	if (!current->used_math) {
+		fpu_emulator_init_fpu();
+		current->used_math = 1;
 	}
 	sig = fpu_emulator_cop1Handler(regs);
-	last_task_used_math = current;
 	if (sig)
 		force_sig(sig, current);
 	return;
diff -Nru smp/arch/mips/math-emu/ieee754.h.orig smp/arch/mips/math-emu/ieee754.h
--- smp/arch/mips/math-emu/ieee754.h.orig	Tue Jan 22 17:11:40 2002
+++ smp/arch/mips/math-emu/ieee754.h	Thu Apr 11 15:46:11 2002
@@ -323,7 +323,7 @@
 
 /* the control status register 
 */
-struct ieee754_csr {
+struct ieee754_csr_struct {
 	unsigned pad:13;
 	unsigned nod:1;		/* set 1 for no denormalised numbers */
 	unsigned cx:5;		/* exceptions this operation */
@@ -331,7 +331,13 @@
 	unsigned sx:5;		/* exceptions total */
 	unsigned rm:2;		/* current rounding mode */
 };
-extern struct ieee754_csr ieee754_csr;
+
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <linux/smp.h>
+#include <asm/current.h>
+extern struct ieee754_csr_struct ieee754_csr_array[NR_CPUS];
+#define	ieee754_csr ieee754_csr_array[smp_processor_id()]
 
 static __inline unsigned ieee754_getrm(void)
 {
diff -Nru smp/arch/mips/math-emu/ieee754.c.orig smp/arch/mips/math-emu/ieee754.c
--- smp/arch/mips/math-emu/ieee754.c.orig	Tue Jan 15 13:25:24 2002
+++ smp/arch/mips/math-emu/ieee754.c	Thu Apr 11 15:46:11 2002
@@ -52,7 +52,7 @@
 
 /* the control status register 
 */
-struct ieee754_csr ieee754_csr;
+struct ieee754_csr_struct ieee754_csr_array[NR_CPUS];
 
 /* special constants
 */
diff -Nru smp/arch/mips/math-emu/cp1emu.c.orig smp/arch/mips/math-emu/cp1emu.c
--- smp/arch/mips/math-emu/cp1emu.c.orig	Tue Jan 15 13:25:24 2002
+++ smp/arch/mips/math-emu/cp1emu.c	Thu Apr 11 15:46:12 2002
@@ -945,7 +945,7 @@
 static ieee754##p fpemu_##p##_##name (ieee754##p r, ieee754##p s, \
     ieee754##p t) \
 { \
-    struct ieee754_csr ieee754_csr_save; \
+    struct ieee754_csr_struct ieee754_csr_save; \
     s = f1 (s, t); \
     ieee754_csr_save = ieee754_csr; \
     s = f2 (s, r); \
diff -Nru smp/arch/mips/math-emu/dp_sqrt.c.orig smp/arch/mips/math-emu/dp_sqrt.c
--- smp/arch/mips/math-emu/dp_sqrt.c.orig	Tue Jan 15 13:25:24 2002
+++ smp/arch/mips/math-emu/dp_sqrt.c	Thu Apr 11 15:46:12 2002
@@ -37,7 +37,7 @@
 
 ieee754dp ieee754dp_sqrt(ieee754dp x)
 {
-	struct ieee754_csr oldcsr;
+	struct ieee754_csr_struct oldcsr;
 	ieee754dp y, z, t;
 	unsigned scalx, yh;
 	COMPXDP;

--------------010108030005080606060305--
