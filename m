Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1M4w7l20275
	for linux-mips-outgoing; Thu, 21 Feb 2002 20:58:07 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1M4vv920270
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 20:57:57 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g1M3tAB13008;
	Thu, 21 Feb 2002 19:55:10 -0800
Message-ID: <3C75C19C.13BB0FCC@mvista.com>
Date: Thu, 21 Feb 2002 19:57:16 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: ieee754_csr is the problem (Re: lazy fpu switch irrelavant to no-fpu 
 case?
References: <3C75B181.C5A065A1@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------A6523E81F65DE547E9307DC0"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------A6523E81F65DE547E9307DC0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jun Sun wrote:
> Anyhow, the problem I am seeing with FPU/SMP case seems to be caused by FPU
> emulation code itself, if we can assume it is not caused by fpu context
> switch.  Right now the FPU is not turned on on the box.
> 

OK, I found the guilt part in FPU emul.  It is the global variable
ieee754_csr.  The following patch seems to fix the problem.  I am sure someone
who are more familiar with FPU might be able to make it more elegant.

There is another global variable which is potentially dangerous for SMP.  It
is fpuemuprivate.  Currently it is used in almost used for accounting and
read-only purpose.  I did not bother to change it.  It should be fixed too, I
suppose.

Cheers.

Jun
--------------A6523E81F65DE547E9307DC0
Content-Type: text/plain; charset=us-ascii;
 name="patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch3"

diff -Nru linux/arch/mips/math-emu/ieee754.h.orig linux/arch/mips/math-emu/ieee754.h
--- linux/arch/mips/math-emu/ieee754.h.orig	Thu Jan 31 17:13:26 2002
+++ linux/arch/mips/math-emu/ieee754.h	Thu Feb 21 19:34:06 2002
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
diff -Nru linux/arch/mips/math-emu/ieee754.c.orig linux/arch/mips/math-emu/ieee754.c
--- linux/arch/mips/math-emu/ieee754.c.orig	Mon Jan 28 11:17:14 2002
+++ linux/arch/mips/math-emu/ieee754.c	Thu Feb 21 19:37:32 2002
@@ -52,7 +52,7 @@
 
 /* the control status register 
 */
-struct ieee754_csr ieee754_csr;
+struct ieee754_csr_struct ieee754_csr_array[NR_CPUS];
 
 /* special constants
 */
diff -Nru linux/arch/mips/math-emu/cp1emu.c.orig linux/arch/mips/math-emu/cp1emu.c
--- linux/arch/mips/math-emu/cp1emu.c.orig	Mon Jan 28 11:17:14 2002
+++ linux/arch/mips/math-emu/cp1emu.c	Thu Feb 21 19:22:45 2002
@@ -945,7 +945,7 @@
 static ieee754##p fpemu_##p##_##name (ieee754##p r, ieee754##p s, \
     ieee754##p t) \
 { \
-    struct ieee754_csr ieee754_csr_save; \
+    struct ieee754_csr_struct ieee754_csr_save; \
     s = f1 (s, t); \
     ieee754_csr_save = ieee754_csr; \
     s = f2 (s, r); \
diff -Nru linux/arch/mips/math-emu/dp_sqrt.c.orig linux/arch/mips/math-emu/dp_sqrt.c
--- linux/arch/mips/math-emu/dp_sqrt.c.orig	Thu Feb 21 19:41:09 2002
+++ linux/arch/mips/math-emu/dp_sqrt.c	Thu Feb 21 19:39:08 2002
@@ -37,7 +37,7 @@
 
 ieee754dp ieee754dp_sqrt(ieee754dp x)
 {
-	struct ieee754_csr oldcsr;
+	struct ieee754_csr_struct oldcsr;
 	ieee754dp y, z, t;
 	unsigned scalx, yh;
 	COMPXDP;

--------------A6523E81F65DE547E9307DC0--
