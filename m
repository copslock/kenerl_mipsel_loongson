Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 21:56:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:766 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225308AbUJPU4G>; Sat, 16 Oct 2004 21:56:06 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 6EAF518503; Sat, 16 Oct 2004 13:56:00 -0700 (PDT)
Message-ID: <41718AE0.10300@mvista.com>
Date: Sat, 16 Oct 2004 13:56:00 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Broadcom SWARM IDE driver
References: <41708A0F.6080504@mvista.com> <Pine.LNX.4.58L.0410160355270.7266@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0410160355270.7266@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Fri, 15 Oct 2004, Manish Lachwani wrote:
>
>  
>
>>+       if (!request_region(0x1f0, 0x2ff, "sibyte-ide"))
>>+               printk("could not reserve for the Broadcom SWARM IDE 
>>port \n");
>>    
>>
>
> This makes no sense, sorry -- the SWARM IDE interface is not I/O-mapped.  
>In fact it's not on PCI at all -- it just occupies the 4th slot of the
>BCM1250A's generic bus.  You should reserve the iomem area covering the
>slot instead.
>
> The rest appears sane enough for the current excuse for a driver. ;-)
>
>  Maciej
>  
>
Hello Maciej

IMHO, The flags IDE_ARCH_OBSOLETE_DEFAULTS and IDE_ARCH_OBSOLETE_INIT 
should not be defined in include/asm-mips/mach-generic/ide.h. Do we 
really need default values for ide_default_io_base, ide_default_irq and 
ide_init_default_irq?

If you look at the sequence,  init_ide_data()  calls 
init_hwif_default(). init_hwif_default() calls ide_init_hwif_ports which 
depends on these flags and initializes hwif->io_ports[IDE_DATA_OFFSET] 
and this in turn enables probing for all hwifs. If we have these flags 
turned off, then hwif->io_ports[IDE_DATA_OFFSET] is set to zero for all 
hwifs and we get the first empty slot in the driver.  IMHO, that should 
be the case for a device that needs an hwif and find an empty slot.

Attached is the patch, please review. This has been tested on the SWARM 
board.

Thanks
Manish Lachwani


--- include/asm-mips/mach-generic/ide.h.orig    2004-10-16 
13:34:52.000000000 -0700
+++ include/asm-mips/mach-generic/ide.h 2004-10-16 13:11:01.000000000 -0700
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
 #define ide_default_io_ctl(base)       ((base) + 0x206) /* obsolete */
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
--- drivers/ide/mips/swarm.c.orig       2004-10-15 16:28:08.000000000 -0700
+++ drivers/ide/mips/swarm.c    2004-10-16 13:34:33.000000000 -0700
@@ -137,54 +137,54 @@
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
+               if (!ide_hwifs[i].io_ports[IDE_DATA_OFFSET]) {
+                       /* Find an empty slot */
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
