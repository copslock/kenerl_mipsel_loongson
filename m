Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 03:40:27 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17662 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225307AbUJPCkW>; Sat, 16 Oct 2004 03:40:22 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP id 2E84D18599
	for <linux-mips@linux-mips.org>; Fri, 15 Oct 2004 19:40:15 -0700 (PDT)
Message-ID: <41708A0F.6080504@mvista.com>
Date: Fri, 15 Oct 2004 19:40:15 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] Broadcom SWARM IDE driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

This is the first attempt at the Broadcom SWARM IDE driver for 2.6.8 for 
it to work. Please provide some feedback. Attached is the patch. This 
has been tested on the SWARM board with a QUANTUM FIREBALLlct10 hard drive.

Thanks
Manish Lachwani

--- drivers/ide/ide.c.orig      2004-10-14 18:56:21.000000000 -0700
+++ drivers/ide/ide.c   2004-10-15 13:25:01.000000000 -0700
@@ -2064,6 +2064,12 @@
                q40ide_init();
        }
 #endif /* CONFIG_BLK_DEV_Q40IDE */
+#ifdef CONFIG_BLK_DEV_IDE_SWARM
+       {
+               extern void swarm_ide_probe(void);
+               swarm_ide_probe();
+       }
+#endif
 #ifdef CONFIG_BLK_DEV_BUDDHA
        {
                extern void buddha_init(void);
--- drivers/ide/mips/swarm.c.orig       2004-10-15 16:28:08.000000000 -0700
+++ drivers/ide/mips/swarm.c    2004-10-15 19:27:43.000000000 -0700
@@ -137,54 +137,63 @@
 }
 
 /*
- * ide_init_default_hwifs - prep the hwifs with our non-swapping ops
- * (otherwise PCI-IDE drives will not come up correctly)
- */
-void ide_init_default_hwifs(void)
-{
-       int i;
-
-       mips_ide_init_default_hwifs();
-       for (i=0; i<MAX_HWIFS; i++) {
-               sibyte_set_ideops(&ide_hwifs[i]);
-       }
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
-       hw_regs_t hw;
+       int i = 0;
        ide_hwif_t *sb_ide_hwif;
 
+       for (i = 0; i < MAX_HWIFS; i++)
+               /*
+                * Sibyte IDE has the IDE_DATA_OFFSET at 0x1f0. These
+                * values for the ide_hwifs[i].io_ports have been
+                * initialized in ide_init_hwif_ports called from
+                * init_hwif_default.
+                */
+               if (ide_hwifs[i].io_ports[IDE_DATA_OFFSET] == 0x1f0) {
+                       /* Found a slot !! */
+                       break;
+               }
+
        /*
         * Preadjust for mips_io_port_base since the I/O ops expect
         * relative addresses
         */
 #define SIBYTE_IDE_REG(pcaddr) (IOADDR(IDE_PHYS) + ((pcaddr)<<5) - 
mips_io_port_base)
 
-       hw.io_ports[IDE_DATA_OFFSET]    = SIBYTE_IDE_REG(0x1f0);
-       hw.io_ports[IDE_ERROR_OFFSET]   = SIBYTE_IDE_REG(0x1f1);
-       hw.io_ports[IDE_NSECTOR_OFFSET] = SIBYTE_IDE_REG(0x1f2);
-       hw.io_ports[IDE_SECTOR_OFFSET]  = SIBYTE_IDE_REG(0x1f3);
-       hw.io_ports[IDE_LCYL_OFFSET]    = SIBYTE_IDE_REG(0x1f4);
-       hw.io_ports[IDE_HCYL_OFFSET]    = SIBYTE_IDE_REG(0x1f5);
-       hw.io_ports[IDE_SELECT_OFFSET]  = SIBYTE_IDE_REG(0x1f6);
-       hw.io_ports[IDE_STATUS_OFFSET]  = SIBYTE_IDE_REG(0x1f7);
-       hw.io_ports[IDE_CONTROL_OFFSET] = SIBYTE_IDE_REG(0x3f6);
-       hw.io_ports[IDE_IRQ_OFFSET]     = SIBYTE_IDE_REG(0x3f7);
-       hw.irq                          = K_INT_GB_IDE;
-
-       if (ide_register_hw(&hw, &sb_ide_hwif) >= 0) {
-               printk("SiByte onboard IDE configured as device %d\n", 
(int)(sb_ide_hwif - ide_hwifs));
-               /* Prevent resource map manipulation */
-               sb_ide_hwif->mmio = 2;
-               /* Reset the ideops after ide_register_hw */
-               sibyte_set_ideops(sb_ide_hwif);
-       }
+       sb_ide_hwif = &ide_hwifs[i];
+
+       sb_ide_hwif->hw.io_ports[IDE_DATA_OFFSET]    = 
SIBYTE_IDE_REG(0x1f0);
+       sb_ide_hwif->hw.io_ports[IDE_ERROR_OFFSET]   = 
SIBYTE_IDE_REG(0x1f1);
+       sb_ide_hwif->hw.io_ports[IDE_NSECTOR_OFFSET] = 
SIBYTE_IDE_REG(0x1f2);
+       sb_ide_hwif->hw.io_ports[IDE_SECTOR_OFFSET]  = 
SIBYTE_IDE_REG(0x1f3);
+       sb_ide_hwif->hw.io_ports[IDE_LCYL_OFFSET]    = 
SIBYTE_IDE_REG(0x1f4);
+       sb_ide_hwif->hw.io_ports[IDE_HCYL_OFFSET]    = 
SIBYTE_IDE_REG(0x1f5);
+       sb_ide_hwif->hw.io_ports[IDE_SELECT_OFFSET]  = 
SIBYTE_IDE_REG(0x1f6);
+       sb_ide_hwif->hw.io_ports[IDE_STATUS_OFFSET]  = 
SIBYTE_IDE_REG(0x1f7);
+       sb_ide_hwif->hw.io_ports[IDE_CONTROL_OFFSET] = 
SIBYTE_IDE_REG(0x3f6);
+       sb_ide_hwif->hw.io_ports[IDE_IRQ_OFFSET]     = 
SIBYTE_IDE_REG(0x3f7);
+
+       sb_ide_hwif->hw.irq                          = K_INT_GB_IDE;
+       sb_ide_hwif->irq                             = K_INT_GB_IDE;
+       sb_ide_hwif->hw.ack_intr                     = NULL;
+       sb_ide_hwif->noprobe                         = 0;
+
+       memcpy(sb_ide_hwif->io_ports, sb_ide_hwif->hw.io_ports, 
sizeof(sb_ide_hwif->io_ports));
+
+       if (!request_region(0x1f0, 0x2ff, "sibyte-ide"))
+               printk("could not reserve for the Broadcom SWARM IDE 
port \n");
+
+       printk("SiByte onboard IDE configured as device %d\n", i);
+
+       /* Prevent resource map manipulation */
+       sb_ide_hwif->mmio = 2;
+
+       /* Reset the ideops */
+       sibyte_set_ideops(sb_ide_hwif);
 #endif
 }
+
