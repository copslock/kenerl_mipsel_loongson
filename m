Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 23:00:28 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60149 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225329AbUK3XAY>; Tue, 30 Nov 2004 23:00:24 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAUN0Mdh017210;
	Tue, 30 Nov 2004 15:00:22 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAUN0MUV017208;
	Tue, 30 Nov 2004 15:00:22 -0800
Date: Tue, 30 Nov 2004 15:00:22 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: sjhill@realitydiluted.com
Subject: [PATCH] Broadcom SWARM IDE in 2.6
Message-ID: <20041130230022.GA17202@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steve,

I had sent an incomplete patch before. Please try out this new patch, attached.
Let me know if it works

Thanks
Manish Lachwani

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-swarm-ide

--- include/asm-mips/mach-generic/ide.h.orig	2004-10-16 13:34:52.000000000 -0700
+++ include/asm-mips/mach-generic/ide.h	2004-10-16 13:11:01.000000000 -0700
@@ -20,7 +20,7 @@
 # endif
 #endif
 
-#define IDE_ARCH_OBSOLETE_DEFAULTS
+#undef IDE_ARCH_OBSOLETE_DEFAULTS
 
 static inline int ide_default_irq(unsigned long base)
 {
@@ -50,7 +50,7 @@
 	}
 }
 
-#define IDE_ARCH_OBSOLETE_INIT
+#undef IDE_ARCH_OBSOLETE_INIT 
 #define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
--- drivers/ide/mips/swarm.c.orig	2004-10-15 16:28:08.000000000 -0700
+++ drivers/ide/mips/swarm.c	2004-10-16 13:34:33.000000000 -0700
@@ -137,54 +137,54 @@
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
--- drivers/ide/ide.c.orig	2004-10-14 18:56:21.000000000 -0700
+++ drivers/ide/ide.c	2004-10-15 13:25:01.000000000 -0700
@@ -2064,6 +2064,12 @@
 		q40ide_init();
 	}
 #endif /* CONFIG_BLK_DEV_Q40IDE */
+#ifdef CONFIG_BLK_DEV_IDE_SWARM
+	{
+		extern void swarm_ide_probe(void);
+		swarm_ide_probe();
+	}
+#endif
 #ifdef CONFIG_BLK_DEV_BUDDHA
 	{
 		extern void buddha_init(void);

--T4sUOijqQbZv57TR--
