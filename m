Received:  by oss.sgi.com id <S305196AbQD1OUy>;
	Fri, 28 Apr 2000 07:20:54 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:44824 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305175AbQD1OUc>;
	Fri, 28 Apr 2000 07:20:32 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA12288; Fri, 28 Apr 2000 07:15:46 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA82613
	for linux-list;
	Fri, 28 Apr 2000 07:07:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA60508
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 07:07:35 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08924
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 07:07:20 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1EB347DD; Fri, 28 Apr 2000 16:07:16 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 06AA28FFD; Fri, 28 Apr 2000 15:55:06 +0200 (CEST)
Date:   Fri, 28 Apr 2000 15:55:05 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: [patch] getting cvs to run on IP22
Message-ID: <20000428155505.F2891@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,
i had the time today and retry getting 2.3.99pre6 (current cvs)
to run on SGI. I'll just attach the patch with what you get
the kernel to work.

Following things get changes:

- Move __initcall(rs_init) to drivers/char/sgiserial.c 
  This is obvious and rs_init in mips/sgi/kernel/setup.c
  is definitly only a dirty hack i introduced

- Do a different (probably incorrect but working) 
  memory setup -  I had the problem of not having any
  DMAable pages after initialization. Now ALL pages
  get into ZONE_DMA which might be right ( I surrounded
  this by CONFIG_ISA and CONFIG_PCI as the PCee controllers
  mostly have DMA limits )

- Call init_serial_console even if CONFIG_SERIAL isnt set
  (but CONFIG_SGI_SERIAL)

- Remove the console initialisation from sgi/kernel/setup.c
  as this hmmm - isnt the thing i think is correct. 
  Normally a kernel "console=" parameter should override
  the setup of the prom (i have ArcEnv = g but want serial console)

TODO:

- Cleanup of mips/arc/memory.c changes for kernel allocation 
  I seem to have luck to get the only broken prom version on the
  planet not allocating the kernel space.
  So - prevent allocating already allocated pages or ignorant
  freeing of ARC memory chunks for some broken proms.

- Clean way of setting the console (Arc Console Env as fallback
  and priotity to console= command line and support
  for the major 5 minor 1 console device like on i386 etc ... 


I would like to have some comments on the different fragments.

Flo

Index: arch/mips/mm/init.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/init.c,v
retrieving revision 1.27
diff -u -r1.27 init.c
--- arch/mips/mm/init.c	2000/02/23 01:33:56	1.27
+++ arch/mips/mm/init.c	2000/04/28 13:47:55
@@ -256,12 +256,16 @@
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
 
+#if defined(CONFIG_PCI) || defined(CONFIG_ISA)
 	if (low < max_dma)
 		zones_size[ZONE_DMA] = low;
 	else {
 		zones_size[ZONE_DMA] = max_dma;
 		zones_size[ZONE_NORMAL] = low - max_dma;
 	}
+#else
+	zones_size[ZONE_DMA] = low;
+#endif
 
 	free_area_init(zones_size);
 }
Index: arch/mips/sgi/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/setup.c,v
retrieving revision 1.32
diff -u -r1.32 setup.c
--- arch/mips/sgi/kernel/setup.c	2000/04/06 20:26:58	1.32
+++ arch/mips/sgi/kernel/setup.c	2000/04/28 13:47:55
@@ -160,20 +160,6 @@
 	/* Now enable boardcaches, if any. */
 	indy_sc_init();
 
-#ifdef CONFIG_SERIAL_CONSOLE
-	/* ARCS console environment variable is set to "g?" for
-	 * graphics console, it is set to "d" for the first serial
-	 * line and "d2" for the second serial line.
-	 */
-	ctype = ArcGetEnvironmentVariable("console");
-	if(*ctype == 'd') {
-		if(*(ctype+1)=='2')
-			console_setup ("ttyS1");
-		else
-			console_setup ("ttyS0");
-	}
-#endif
-
 #ifdef CONFIG_REMOTE_DEBUG
 	kgdb_ttyd = prom_getcmdline();
 	if ((kgdb_ttyd = strstr(kgdb_ttyd, "kgdb=ttyd")) != NULL) {
@@ -195,10 +181,6 @@
 	}
 #endif
 
-#ifdef CONFIG_SGI_PROM_CONSOLE
-	console_setup("ttyS0");
-#endif
- 
 	sgi_volume_set(simple_strtoul(ArcGetEnvironmentVariable("volume"), NULL, 10));
 
 #ifdef CONFIG_VT
@@ -230,4 +212,3 @@
 	init_vino();
 #endif
 }
-__initcall(rs_init);
Index: drivers/char/tty_io.c
===================================================================
RCS file: /cvs/linux/drivers/char/tty_io.c,v
retrieving revision 1.33
diff -u -r1.33 tty_io.c
--- drivers/char/tty_io.c	2000/04/28 01:09:37	1.33
+++ drivers/char/tty_io.c	2000/04/28 13:47:58
@@ -2189,7 +2189,7 @@
 #ifdef CONFIG_SERIAL_CONSOLE
 #ifdef CONFIG_8xx
 	console_8xx_init();
-#elif defined(CONFIG_SERIAL) 	
+#elif defined(CONFIG_SERIAL) || defined(CONFIG_SGI_SERIAL)
 	serial_console_init();
 #endif /* CONFIG_8xx */
 #if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
Index: drivers/sgi/char/sgiserial.c
===================================================================
RCS file: /cvs/linux/drivers/sgi/char/sgiserial.c,v
retrieving revision 1.23
diff -u -r1.23 sgiserial.c
--- drivers/sgi/char/sgiserial.c	2000/01/27 01:05:35	1.23
+++ drivers/sgi/char/sgiserial.c	2000/04/28 13:48:21
@@ -2251,3 +2251,5 @@
 {
 	register_console(&sgi_console_driver);
 }
+
+__initcall(rs_init);


-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
