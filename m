Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 14:21:40 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:29206 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225808AbVDMNVY>; Wed, 13 Apr 2005 14:21:24 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3DDLIFR012899;
	Wed, 13 Apr 2005 14:21:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3DDLIVG012891;
	Wed, 13 Apr 2005 14:21:18 +0100
Date:	Wed, 13 Apr 2005 14:21:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	Stuart Longland <stuartl@longlandclan.hopto.org>,
	linux-mips@linux-mips.org
Subject: Re: BogoMIPS
Message-ID: <20050413132118.GG5253@linux-mips.org>
References: <425BDCE4.6070708@timesys.com> <425C9DBF.6090807@longlandclan.hopto.org> <425D0448.6010700@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D0448.6010700@timesys.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 13, 2005 at 07:36:40AM -0400, Greg Weeks wrote:

> >So honestly, I don't know what's happening with BogoMIPS. :-)  What I do
> >know however, it isn't worth a cracker in terms of benchmarking value. 
> >;-)
> 
> I could care less about it as a benchmarking value, but it's used to do 
> calibrated udelays.  If mips doesn't need it because it calibrates some 
> other way then fine. I suspect not though and we're probably using an 
> initial works everywhere value. I don't know though.

The bugs is the result of the somewhat messy way the calibration code is
working.  calibrate_delay() puts it's result into a global variable,
loops_per_jiffy.  The value is CPU-specific not global, so we need to
copy it to a per-processor data structure which we do on SMP but forget
to do on uniprocessor.  At the same time the actual delay loop code in
delay.h knew to use loops_per_jiffy on uniprocessor, so it was actually
working ok.

   Ralf

Index: arch/mips/kernel/cpu-probe.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/cpu-probe.c,v
retrieving revision 1.43
diff -u -r1.43 cpu-probe.c
--- arch/mips/kernel/cpu-probe.c	8 Apr 2005 20:36:05 -0000	1.43
+++ arch/mips/kernel/cpu-probe.c	13 Apr 2005 13:19:11 -0000
@@ -17,7 +17,6 @@
 #include <linux/ptrace.h>
 #include <linux/stddef.h>
 
-#include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
Index: arch/mips/kernel/smp.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/smp.c,v
retrieving revision 1.77
diff -u -r1.77 smp.c
--- arch/mips/kernel/smp.c	18 Mar 2005 17:36:53 -0000	1.77
+++ arch/mips/kernel/smp.c	13 Apr 2005 13:19:11 -0000
@@ -226,7 +226,6 @@
 /* called from main before smp_init() */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	cpu_data[0].udelay_val = loops_per_jiffy;
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
Index: include/asm-mips/bugs.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/bugs.h,v
retrieving revision 1.10
diff -u -r1.10 bugs.h
--- include/asm-mips/bugs.h	25 Jul 2003 22:49:24 -0000	1.10
+++ include/asm-mips/bugs.h	13 Apr 2005 13:19:12 -0000
@@ -8,12 +8,17 @@
 #define _ASM_BUGS_H
 
 #include <linux/config.h>
+#include <asm/cpu.h>
+#include <asm/cpu-info.h>
 
 extern void check_bugs32(void);
 extern void check_bugs64(void);
 
 static inline void check_bugs(void)
 {
+	unsigned int cpu = smp_processor_id();
+
+	cpu_data[cpu].udelay_val = loops_per_jiffy;
 	check_bugs32();
 #ifdef CONFIG_MIPS64
 	check_bugs64();
Index: include/asm-mips/delay.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/delay.h,v
retrieving revision 1.16
diff -u -r1.16 delay.h
--- include/asm-mips/delay.h	8 Oct 2004 02:41:17 -0000	1.16
+++ include/asm-mips/delay.h	13 Apr 2005 13:19:12 -0000
@@ -15,8 +15,6 @@
 
 #include <asm/compiler.h>
 
-extern unsigned long loops_per_jiffy;
-
 static inline void __delay(unsigned long loops)
 {
 	if (sizeof(long) == 4)
@@ -82,11 +80,7 @@
 	__delay(usecs);
 }
 
-#ifdef CONFIG_SMP
 #define __udelay_val cpu_data[smp_processor_id()].udelay_val
-#else
-#define __udelay_val loops_per_jiffy
-#endif
 
 #define udelay(usecs) __udelay((usecs),__udelay_val)
 
