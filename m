Received:  by oss.sgi.com id <S553698AbRCGRlh>;
	Wed, 7 Mar 2001 09:41:37 -0800
Received: from sovereign.org ([209.180.91.170]:41630 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S553687AbRCGRl1>;
	Wed, 7 Mar 2001 09:41:27 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.3/8.11.2/Debian 8.11.2-1) id f27HfTH20547
	for linux-mips@oss.sgi.com; Wed, 7 Mar 2001 10:41:29 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Wed, 7 Mar 2001 10:41:28 -0700
To:     linux-mips@oss.sgi.com
Subject: 2.4.3-pre2 mips changes
Message-ID: <20010307104128.A20517@sovereign.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch contains the portion of 2.4.3-pre3 that affects
arch/mips* and include/asm-mips*  (most are just spelling changes,
but not all ...).

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.3-pre3.mips"

diff -u --recursive --new-file v2.4.2/linux/arch/mips/baget/irq.c linux/arch/mips/baget/irq.c
--- v2.4.2/linux/arch/mips/baget/irq.c	Wed Feb 21 18:20:13 2001
+++ linux/arch/mips/baget/irq.c	Tue Mar  6 19:44:36 2001
@@ -199,7 +199,7 @@
 			add_interrupt_randomness(irq);
 		__cli();
 	} else {
-		printk("do_IRQ: Unregistered IRQ (0x%X) occured\n", irq);
+		printk("do_IRQ: Unregistered IRQ (0x%X) occurred\n", irq);
 	}
 	unmask_irq(irq);
 	irq_exit(cpu);
diff -u --recursive --new-file v2.4.2/linux/arch/mips/boot/elf2ecoff.c linux/arch/mips/boot/elf2ecoff.c
--- v2.4.2/linux/arch/mips/boot/elf2ecoff.c	Mon Jul  5 20:35:17 1999
+++ linux/arch/mips/boot/elf2ecoff.c	Tue Mar  6 19:44:36 2001
@@ -435,7 +435,7 @@
   char ibuf [4096];
   int remaining, cur, count;
 
-  /* Go the the start of the ELF symbol table... */
+  /* Go to the start of the ELF symbol table... */
   if (lseek (in, offset, SEEK_SET) < 0)
     {
       perror ("copy: lseek");
diff -u --recursive --new-file v2.4.2/linux/arch/mips/dec/prom/memory.c linux/arch/mips/dec/prom/memory.c
--- v2.4.2/linux/arch/mips/dec/prom/memory.c	Mon Aug  7 21:02:27 2000
+++ linux/arch/mips/dec/prom/memory.c	Tue Mar  6 19:44:36 2001
@@ -31,7 +31,7 @@
 extern int (*prom_printf)(char *, ...);
 #endif
 
-volatile unsigned long mem_err = 0;	/* So we know an error occured */
+volatile unsigned long mem_err = 0;	/* So we know an error occurred */
 
 extern char _end;
 
diff -u --recursive --new-file v2.4.2/linux/arch/mips/defconfig linux/arch/mips/defconfig
--- v2.4.2/linux/arch/mips/defconfig	Thu Jul 27 18:36:54 2000
+++ linux/arch/mips/defconfig	Sun Mar  4 14:30:18 2001
@@ -175,6 +175,7 @@
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_AM53C974 is not set
diff -u --recursive --new-file v2.4.2/linux/arch/mips/kernel/mips_ksyms.c linux/arch/mips/kernel/mips_ksyms.c
--- v2.4.2/linux/arch/mips/kernel/mips_ksyms.c	Fri Aug  4 16:15:37 2000
+++ linux/arch/mips/kernel/mips_ksyms.c	Fri Mar  2 11:15:47 2001
@@ -140,3 +140,4 @@
 #endif
 
 EXPORT_SYMBOL(get_wchan);
+EXPORT_SYMBOL(flush_tlb_page);
diff -u --recursive --new-file v2.4.2/linux/arch/mips/sgi/kernel/indy_sc.c linux/arch/mips/sgi/kernel/indy_sc.c
--- v2.4.2/linux/arch/mips/sgi/kernel/indy_sc.c	Sat May 13 08:29:14 2000
+++ linux/arch/mips/sgi/kernel/indy_sc.c	Tue Mar  6 19:44:36 2001
@@ -1,6 +1,6 @@
 /* $Id: indy_sc.c,v 1.14 2000/03/25 22:35:07 ralf Exp $
  *
- * indy_sc.c: Indy cache managment functions.
+ * indy_sc.c: Indy cache management functions.
  *
  * Copyright (C) 1997 Ralf Baechle (ralf@gnu.org),
  * derived from r4xx0.c by David S. Miller (dm@engr.sgi.com).
diff -u --recursive --new-file v2.4.2/linux/arch/mips/sgi/kernel/setup.c linux/arch/mips/sgi/kernel/setup.c
--- v2.4.2/linux/arch/mips/sgi/kernel/setup.c	Wed Aug  9 13:46:02 2000
+++ linux/arch/mips/sgi/kernel/setup.c	Tue Mar  6 19:44:36 2001
@@ -165,7 +165,7 @@
         *tcwp = (SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL | SGINT_TCWORD_MSWST);
 
         /* Return the difference, this is how far the r4k counter increments
-         * for every 1/HZ seconds. We round off the the nearest 1 MHz of
+         * for every 1/HZ seconds. We round off the nearest 1 MHz of
 	 * master clock (= 1000000 / 100 / 2 = 5000 count).
          */
         return ((ct1 - ct0) / 5000) * 5000;
diff -u --recursive --new-file v2.4.2/linux/arch/mips64/defconfig linux/arch/mips64/defconfig
--- v2.4.2/linux/arch/mips64/defconfig	Wed Feb 21 18:20:13 2001
+++ linux/arch/mips64/defconfig	Sun Mar  4 14:30:18 2001
@@ -165,6 +165,7 @@
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AHA1740 is not set
 # CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_AM53C974 is not set
diff -u --recursive --new-file v2.4.2/linux/arch/mips64/kernel/mips64_ksyms.c linux/arch/mips64/kernel/mips64_ksyms.c
--- v2.4.2/linux/arch/mips64/kernel/mips64_ksyms.c	Thu Jul 27 18:36:54 2000
+++ linux/arch/mips64/kernel/mips64_ksyms.c	Fri Mar  2 11:15:47 2001
@@ -121,3 +121,4 @@
 #endif
 
 EXPORT_SYMBOL(get_wchan);
+EXPORT_SYMBOL(flush_tlb_page);
diff -u --recursive --new-file v2.4.2/linux/arch/mips64/mm/fault.c linux/arch/mips64/mm/fault.c
--- v2.4.2/linux/arch/mips64/mm/fault.c	Tue Nov 28 21:42:04 2000
+++ linux/arch/mips64/mm/fault.c	Tue Mar  6 19:44:36 2001
@@ -61,7 +61,7 @@
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is aquired through the
+ * message out (timerlist_lock is acquired through the
  * console unblank code)
  */
 void bust_spinlocks(void)
diff -u --recursive --new-file v2.4.2/linux/arch/mips64/sgi-ip22/ip22-sc.c linux/arch/mips64/sgi-ip22/ip22-sc.c
--- v2.4.2/linux/arch/mips64/sgi-ip22/ip22-sc.c	Sat May 13 08:30:17 2000
+++ linux/arch/mips64/sgi-ip22/ip22-sc.c	Tue Mar  6 19:44:36 2001
@@ -1,6 +1,6 @@
 /* $Id: ip22-sc.c,v 1.2 1999/12/04 03:59:01 ralf Exp $
  *
- * indy_sc.c: Indy cache managment functions.
+ * indy_sc.c: Indy cache management functions.
  *
  * Copyright (C) 1997 Ralf Baechle (ralf@gnu.org),
  * derived from r4xx0.c by David S. Miller (dm@engr.sgi.com).
diff -u --recursive --new-file v2.4.2/linux/include/asm-mips64/smp.h linux/include/asm-mips64/smp.h
--- v2.4.2/linux/include/asm-mips64/smp.h	Fri Aug  4 16:15:37 2000
+++ linux/include/asm-mips64/smp.h	Fri Mar  2 11:30:15 2001
@@ -40,6 +40,7 @@
 
 /* Good enough for toy^Wupto 64 CPU Origins.  */
 extern unsigned long cpu_present_mask;
+#define cpu_online_map cpu_present_mask
 
 #endif
 

--0OAP2g/MAC+5xKAE--
