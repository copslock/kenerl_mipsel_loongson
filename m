Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4E2ZSnC005203
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 19:35:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4E2ZSoh005202
	for linux-mips-outgoing; Mon, 13 May 2002 19:35:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4E2ZCnC005198;
	Mon, 13 May 2002 19:35:12 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA04482; Mon, 13 May 2002 19:35:25 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id TAA05413;
	Mon, 13 May 2002 19:19:28 -0700
Message-ID: <3CE073D0.8030402@mvista.com>
Date: Mon, 13 May 2002 19:17:52 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: ralf@oss.sgi.com
CC: linux-mips@oss.sgi.com
Subject: [PATCH] gettimeoffset for swarm
Content-Type: multipart/mixed;
 boundary="------------020401010503040805090101"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------020401010503040805090101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


By default, swarm will use calibrate_div64_gettimeoffset().  That does
not work in SMP mode because the two cores have different counter register
value.  This patch gives swarm its own and accurate gettimeoffset().

The symptom without this patch is that cpu core 1 does not have micro-second
resolution of gettimeofday().

It applies to 2.4 branch with 1 or 2 line offset warnings.  It does not apply 
to 2.5 branch. 2.5 branch appears to be outdated.

http://linux.junsun.net/patches/oss.sgi.com/submitted/020515.swarm-own-gettimeoffset.patch

Jun



--------------020401010503040805090101
Content-Type: text/plain;
 name="020515.swarm-own-gettimeoffset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="020515.swarm-own-gettimeoffset.patch"


By default, swarm will use calibrate_div64_gettimeoffset().  That does
not work in SMP mode because the two cores have different counter register
value.  This patch gives swarm its own and accurate gettimeoffset().

The symptom without this patch is that cpu core 1 does not have micro-second
resolution of gettimeofday().

Jun

diff -Nru linux/arch/mips/sibyte/sb1250/time.c.orig linux/arch/mips/sibyte/sb1250/time.c
--- linux/arch/mips/sibyte/sb1250/time.c.orig	Tue Apr 30 17:29:25 2002
+++ linux/arch/mips/sibyte/sb1250/time.c	Fri May 10 14:53:39 2002
@@ -34,6 +34,7 @@
 #include <asm/ptrace.h>
 #include <asm/addrspace.h>
 #include <asm/time.h>
+#include <asm/debug.h>
 
 #include <asm/sibyte/sb1250.h>
 #include <asm/sibyte/sb1250_regs.h>
@@ -107,3 +108,19 @@
 	 */
 	ll_local_timer_interrupt(0, regs);
 }
+
+/*
+ * We use our own do_gettimeoffset() instead of the generic one,
+ * because the generic one does not work for SMP case.
+ * In addition, since we use general timer 0 for system time,
+ * we can get accurate intra-jiffy offset without calibration.
+ */
+unsigned long sb1250_gettimeoffset(void)
+{
+	unsigned long count =
+		in64(KSEG1 + A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT));
+
+	db_assert(count <= 1000000 / HZ);
+	return 1000000/HZ - count;
+}
+
diff -Nru linux/arch/mips/sibyte/swarm/setup.c.orig linux/arch/mips/sibyte/swarm/setup.c
--- linux/arch/mips/sibyte/swarm/setup.c.orig	Tue Apr 30 17:38:09 2002
+++ linux/arch/mips/sibyte/swarm/setup.c	Fri May 10 14:54:36 2002
@@ -237,12 +237,15 @@
          * interrupts through low-level (direct) meachanism.
          */
 
+	/* Use our own gettimeoffset() routine */
+	do_gettimeoffset = sb1250_gettimeoffset;
+
         /* We only need to setup the generic timer */
         sb1250_time_init();
 }
 
 extern int xicor_set_time(unsigned long);
-extern unsigned int xicor_get_time(void);
+extern unsigned long xicor_get_time(void);
 
 void __init swarm_setup(void)
 {
diff -Nru linux/include/asm-mips/sibyte/sb1250.h.orig linux/include/asm-mips/sibyte/sb1250.h
--- linux/include/asm-mips/sibyte/sb1250.h.orig	Tue Jan 15 13:25:45 2002
+++ linux/include/asm-mips/sibyte/sb1250.h	Fri May 10 14:51:50 2002
@@ -20,6 +20,7 @@
 #define _ASM_SIBYTE_SB1250_H
 
 extern void sb1250_time_init(void);
+extern unsigned long sb1250_gettimeoffset(void);
 extern void sb1250_mask_irq(int cpu, int irq);
 extern void sb1250_unmask_irq(int cpu, int irq);
 extern void sb1250_smp_finish(void);
diff -Nru linux/include/asm-mips64/sibyte/sb1250.h.orig linux/include/asm-mips64/sibyte/sb1250.h
--- linux/include/asm-mips64/sibyte/sb1250.h.orig	Tue Apr 30 17:30:44 2002
+++ linux/include/asm-mips64/sibyte/sb1250.h	Fri May 10 14:52:16 2002
@@ -20,6 +20,7 @@
 #define _ASM_SIBYTE_SB1250_H
 
 extern void sb1250_time_init(void);
+extern unsigned long sb1250_gettimeoffset(void);
 extern void sb1250_mask_irq(int cpu, int irq);
 extern void sb1250_unmask_irq(int cpu, int irq);
 extern void sb1250_smp_finish(void);

--------------020401010503040805090101--
