Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 14:40:45 +0000 (GMT)
Received: from buzzloop.caiaq.de ([212.112.241.133]:51722 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S20021457AbXCOOkk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 14:40:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 80E6C7F402B
	for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 15:40:02 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09863-05 for <linux-mips@linux-mips.org>;
	Thu, 15 Mar 2007 15:39:53 +0100 (CET)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id 82D8E7F4025; Thu, 15 Mar 2007 15:39:53 +0100 (CET)
Date:	Thu, 15 Mar 2007 15:39:53 +0100
From:	Daniel Mack <daniel@caiaq.de>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE/DMA for au1xxx
Message-ID: <20070315143953.GA11034@ipxXXXXX>
References: <20070315122012.GA8612@ipxXXXXX> <45F9520A.2000804@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <45F9520A.2000804@ru.mvista.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at caiaq.de
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2007 at 05:02:50PM +0300, Sergei Shtylyov wrote:
> >diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h 
> >b/include/asm-mips/mach-au1x00/au1xxx_ide.h
> >index e9fa252..e747814 100644
> >--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
> >+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
> >@@ -166,13 +166,13 @@ int __init auide_probe(void);
> >         static int auide_dma_setup(ide_drive_t *drive);
> >         static int auide_dma_check(ide_drive_t *drive);
> >         static int auide_dma_test_irq(ide_drive_t *drive);
> >-        static int auide_dma_host_off(ide_drive_t *drive);
> >-        static int auide_dma_host_on(ide_drive_t *drive);
> >+        static void auide_dma_host_off(ide_drive_t *drive);
> >+        static void auide_dma_host_on(ide_drive_t *drive);
> >         static int auide_dma_lostirq(ide_drive_t *drive);
> >         static int auide_dma_on(ide_drive_t *drive);
> >         static void auide_ddma_tx_callback(int irq, void *param);
> >         static void auide_ddma_rx_callback(int irq, void *param);
> >-        static int auide_dma_off_quietly(ide_drive_t *drive);
> >+        static void auide_dma_off_quietly(ide_drive_t *drive);
> > #endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
> 
>    WTF these protos are doing in include/asm-mips/ -- being purely IDE 
> subsystem specific?! :-O
>    Could you move them into the driver (if they are indeed necessary)?

You're right.

This patch removes the static prototypes from the au1xxx_ide.h, some of
them were not even implemented.

Signed-off-by: Daniel Mack <daniel@caiaq.de>



--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1xxx_ide.h.patch"

diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
index e9fa252..8fcae21 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -141,40 +141,6 @@ static int auide_ddma_init( _auide_hwif *auide );
 static void auide_setup_ports(hw_regs_t *hw, _auide_hwif *ahwif);
 int __init auide_probe(void);
 
-#ifdef CONFIG_PM
-        int au1200ide_pm_callback( au1xxx_power_dev_t *dev,
-                                   au1xxx_request_t request, void *data);
-        static int au1xxxide_pm_standby( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_sleep( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_resume( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_getstatus( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_access( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_idle( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_cleanup( au1xxx_power_dev_t *dev );
-#endif
-
-
-/*
- * Multi-Word DMA + DbDMA functions
- */
-#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-        static int auide_build_sglist(ide_drive_t *drive,  struct request *rq);
-        static int auide_build_dmatable(ide_drive_t *drive);
-        static int auide_dma_end(ide_drive_t *drive);
-        ide_startstop_t auide_dma_intr (ide_drive_t *drive);
-        static void auide_dma_exec_cmd(ide_drive_t *drive, u8 command);
-        static int auide_dma_setup(ide_drive_t *drive);
-        static int auide_dma_check(ide_drive_t *drive);
-        static int auide_dma_test_irq(ide_drive_t *drive);
-        static int auide_dma_host_off(ide_drive_t *drive);
-        static int auide_dma_host_on(ide_drive_t *drive);
-        static int auide_dma_lostirq(ide_drive_t *drive);
-        static int auide_dma_on(ide_drive_t *drive);
-        static void auide_ddma_tx_callback(int irq, void *param);
-        static void auide_ddma_rx_callback(int irq, void *param);
-        static int auide_dma_off_quietly(ide_drive_t *drive);
-#endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
-
 /*******************************************************************************
 * PIO Mode timing calculation :                                                *
 *                                                                              *

--sm4nu43k4a2Rpi4c--
