Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2004 06:42:23 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:37335 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224950AbUAGGmW>;
	Wed, 7 Jan 2004 06:42:22 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id PAA24743;
	Wed, 7 Jan 2004 15:42:17 +0900 (JST)
Received: 4UMDO00 id i076gHr08948; Wed, 7 Jan 2004 15:42:17 +0900 (JST)
Received: 4UMRO01 id i076gGH05546; Wed, 7 Jan 2004 15:42:16 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Wed, 7 Jan 2004 15:42:16 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][2.6] add smp.h in processor.h
Message-Id: <20040107154216.77967c1e.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040107052829.GB29672@linux-mips.org>
References: <20040107125509.34cfa9db.yuasa@hh.iij4u.or.jp>
	<20040107052829.GB29672@linux-mips.org>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Wed, 7 Jan 2004 06:28:29 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Jan 07, 2004 at 12:55:09PM +0900, Yoichi Yuasa wrote:
> 
> > I made a patch for header file of 2.6.
> > 
> > smp_processor_id() is defined in smp.h.
> > We need adding #include <linux/smp.h> in processor.h.
> 
> <linux/smp.h> pulls in a fairly large number of other header files which
> is why no Linux architecture includes <linux/smp.h> in <asm/processor.h>.
> So instead please include the file directly into your code.  In which .c
> file you're hitting the problem?

OK, I made a patch for same problem about vr41xx.
Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/bcu.c linux/arch/mips/vr41xx/common/bcu.c
--- linux-orig/arch/mips/vr41xx/common/bcu.c	2003-12-16 10:56:22.000000000 +0900
+++ linux/arch/mips/vr41xx/common/bcu.c	2004-01-07 15:09:06.000000000 +0900
@@ -40,6 +40,7 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/cmu.c linux/arch/mips/vr41xx/common/cmu.c
--- linux-orig/arch/mips/vr41xx/common/cmu.c	2003-10-31 11:29:18.000000000 +0900
+++ linux/arch/mips/vr41xx/common/cmu.c	2004-01-07 15:09:19.000000000 +0900
@@ -40,6 +40,7 @@
  *  - Added support for NEC VR4133.
  */
 #include <linux/init.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux-orig/arch/mips/vr41xx/common/giu.c	2003-12-16 10:56:22.000000000 +0900
+++ linux/arch/mips/vr41xx/common/giu.c	2004-01-07 15:09:36.000000000 +0900
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux-orig/arch/mips/vr41xx/common/icu.c	2003-12-16 10:56:22.000000000 +0900
+++ linux/arch/mips/vr41xx/common/icu.c	2004-01-07 15:09:52.000000000 +0900
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/cpu.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/rtc.c linux/arch/mips/vr41xx/common/rtc.c
--- linux-orig/arch/mips/vr41xx/common/rtc.c	2003-12-02 04:32:01.000000000 +0900
+++ linux/arch/mips/vr41xx/common/rtc.c	2004-01-07 15:10:26.000000000 +0900
@@ -19,6 +19,7 @@
  */
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	2003-10-31 11:29:18.000000000 +0900
+++ linux/arch/mips/vr41xx/common/serial.c	2004-01-07 15:10:13.000000000 +0900
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/serial.h>
+#include <linux/smp.h>
 
 #include <asm/addrspace.h>
 #include <asm/cpu.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c linux/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c	2003-11-25 15:28:19.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0226/init.c	2004-01-07 15:10:42.000000000 +0900
@@ -15,6 +15,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c linux/arch/mips/vr41xx/tanbac-tb0229/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c	2003-11-25 15:28:19.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/init.c	2004-01-07 15:10:57.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/init.c linux/arch/mips/vr41xx/zao-capcella/init.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/init.c	2003-11-25 15:28:19.000000000 +0900
+++ linux/arch/mips/vr41xx/zao-capcella/init.c	2004-01-07 15:11:09.000000000 +0900
@@ -15,6 +15,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
