Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 20:57:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:42222 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225298AbUK3U4x>; Tue, 30 Nov 2004 20:56:53 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAUKupdh017112;
	Tue, 30 Nov 2004 12:56:51 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAUKupKh017110;
	Tue, 30 Nov 2004 12:56:51 -0800
Date: Tue, 30 Nov 2004 12:56:51 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: sjhill@realitydiluted.com, linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Broadcom SWARM IDE in 2.6.10
Message-ID: <20041130205651.GA17104@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steve,

Try this patch. Let me know if this works for you. If possible, also
send the boot log if the problem continues to occur.

Thanks
Manish Lachwani

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-swarm-ide

--- drivers/ide/mips/swarm.c.orig	2004-10-15 16:28:08.000000000 -0700
+++ drivers/ide/mips/swarm.c	2004-10-26 09:37:20.000000000 -0700
@@ -20,6 +20,9 @@
  *  
  *  Copyright (C) 1998 Paul Mackerras.
  *  Copyright (C) 1995-1998 Mark Lord
+ *
+ *  Copyright (C) 2004 MontaVista Software Inc.
+ *  Author: Manish Lachwani, mlachwani@mvista.com
  */
 
 /*
@@ -31,11 +34,6 @@
  * file.  Probing of a Generic Bus for an IDE device is controlled by
  * the definitions of "SIBYTE_HAVE_IDE" and "IDE_PHYS", which are
  * provided by <asm/sibyte/board.h> for Broadcom boards.
- *
- * We hijack ide_init_default_hwifs() from <asm/ide.h> because it
- * gives us the best opportunity to prep the ide_hwifs[] with our
- * non-swapping operations (and it's easier to get ide_hwif_t /
- * ide_hwifs[] declarations outside of the header).
  */
 
 #include <linux/kernel.h>
@@ -137,54 +135,54 @@
 }
 
 /*
- * ide_init_default_hwifs - prep the hwifs with our non-swapping ops
- * (otherwise PCI-IDE drives will not come up correctly)
- */
-void ide_init_default_hwifs(void)
-{
-	int i;
-
-	mips_ide_init_default_hwifs();
-	for (i=0; i<MAX_HWIFS; i++) {
-		sibyte_set_ideops(&ide_hwifs[i]);
-	}
-}
-
-/*
  * swarm_ide_probe - if the board header indicates the existence of
  * Generic Bus IDE, allocate a HWIF for it.
  */
 void __init swarm_ide_probe(void)
 {
 #if defined(SIBYTE_HAVE_IDE) && defined(IDE_PHYS)
-
-	hw_regs_t hw;
+	int i = 0;
 	ide_hwif_t *sb_ide_hwif;
 
+	for (i = 0; i < MAX_HWIFS; i++) 
+		if (!ide_hwifs[i].io_ports[IDE_DATA_OFFSET]) {
+			/* Find an empty slot */
+			break;
+		}
+
 	/*
 	 * Preadjust for mips_io_port_base since the I/O ops expect
 	 * relative addresses
 	 */
 #define SIBYTE_IDE_REG(pcaddr) (IOADDR(IDE_PHYS) + ((pcaddr)<<5) - mips_io_port_base)
 
-	hw.io_ports[IDE_DATA_OFFSET]    = SIBYTE_IDE_REG(0x1f0);
-	hw.io_ports[IDE_ERROR_OFFSET]   = SIBYTE_IDE_REG(0x1f1);
-	hw.io_ports[IDE_NSECTOR_OFFSET] = SIBYTE_IDE_REG(0x1f2);
-	hw.io_ports[IDE_SECTOR_OFFSET]  = SIBYTE_IDE_REG(0x1f3);
-	hw.io_ports[IDE_LCYL_OFFSET]    = SIBYTE_IDE_REG(0x1f4);
-	hw.io_ports[IDE_HCYL_OFFSET]    = SIBYTE_IDE_REG(0x1f5);
-	hw.io_ports[IDE_SELECT_OFFSET]  = SIBYTE_IDE_REG(0x1f6);
-	hw.io_ports[IDE_STATUS_OFFSET]  = SIBYTE_IDE_REG(0x1f7);
-	hw.io_ports[IDE_CONTROL_OFFSET] = SIBYTE_IDE_REG(0x3f6);
-	hw.io_ports[IDE_IRQ_OFFSET]     = SIBYTE_IDE_REG(0x3f7);
-	hw.irq                          = K_INT_GB_IDE;
-
-	if (ide_register_hw(&hw, &sb_ide_hwif) >= 0) {
-		printk("SiByte onboard IDE configured as device %d\n", (int)(sb_ide_hwif - ide_hwifs));
-		/* Prevent resource map manipulation */
-		sb_ide_hwif->mmio = 2;
-		/* Reset the ideops after ide_register_hw */
-		sibyte_set_ideops(sb_ide_hwif);
-	}
+	sb_ide_hwif = &ide_hwifs[i];
+
+	sb_ide_hwif->hw.io_ports[IDE_DATA_OFFSET]    = SIBYTE_IDE_REG(0x1f0);
+	sb_ide_hwif->hw.io_ports[IDE_ERROR_OFFSET]   = SIBYTE_IDE_REG(0x1f1);
+	sb_ide_hwif->hw.io_ports[IDE_NSECTOR_OFFSET] = SIBYTE_IDE_REG(0x1f2);
+	sb_ide_hwif->hw.io_ports[IDE_SECTOR_OFFSET]  = SIBYTE_IDE_REG(0x1f3);
+	sb_ide_hwif->hw.io_ports[IDE_LCYL_OFFSET]    = SIBYTE_IDE_REG(0x1f4);
+	sb_ide_hwif->hw.io_ports[IDE_HCYL_OFFSET]    = SIBYTE_IDE_REG(0x1f5);
+	sb_ide_hwif->hw.io_ports[IDE_SELECT_OFFSET]  = SIBYTE_IDE_REG(0x1f6);
+	sb_ide_hwif->hw.io_ports[IDE_STATUS_OFFSET]  = SIBYTE_IDE_REG(0x1f7);
+	sb_ide_hwif->hw.io_ports[IDE_CONTROL_OFFSET] = SIBYTE_IDE_REG(0x3f6);
+	sb_ide_hwif->hw.io_ports[IDE_IRQ_OFFSET]     = SIBYTE_IDE_REG(0x3f7);
+
+	sb_ide_hwif->hw.irq                          = K_INT_GB_IDE;
+	sb_ide_hwif->irq			     = K_INT_GB_IDE;
+	sb_ide_hwif->hw.ack_intr		     = NULL;
+	sb_ide_hwif->noprobe			     = 0;
+
+	memcpy(sb_ide_hwif->io_ports, sb_ide_hwif->hw.io_ports, sizeof(sb_ide_hwif->io_ports));
+	
+	printk("SiByte onboard IDE configured as device %d\n", i);
+
+	/* Prevent resource map manipulation */
+	sb_ide_hwif->mmio = 2;
+
+	/* Reset the ideops */
+	sibyte_set_ideops(sb_ide_hwif);
 #endif
 }
+

--BOKacYhQ+x31HxR3--
