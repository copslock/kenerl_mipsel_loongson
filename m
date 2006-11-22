Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 13:51:37 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44047 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20039055AbWKVNvd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 13:51:33 +0000
Received: (qmail 18160 invoked by uid 1000); 22 Nov 2006 14:51:32 +0100
Date:	Wed, 22 Nov 2006 14:51:32 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH] make au1xxx-ide compile again
Message-ID: <20061122135132.GA18144@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips


The Au1xx IDE controller driver doesn't compile:

  CC      drivers/ide/mips/au1xxx-ide.o
/linux-2.6.19-rc6-work/drivers/ide/mips/au1xxx-ide.c:480: error: conflicting types for 'auide_ddma_tx_callback'
include2/asm/mach-au1x00/au1xxx_ide.h:174: error: previous declaration of 'auide_ddma_tx_callback' was here
/linux-2.6.19-rc6-work/drivers/ide/mips/au1xxx-ide.c:486: error: conflicting types for 'auide_ddma_rx_callback'
include2/asm/mach-au1x00/au1xxx_ide.h:176: error: previous declaration of 'auide_ddma_rx_callback' was here

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

--- linux-2.6.19-rc6-base/include/asm-mips/mach-au1x00/au1xxx_ide.h	2006-11-16 11:14:28.370553000 +0100
+++ linux-2.6.19-rc6-work/include/asm-mips/mach-au1x00/au1xxx_ide.h	2006-11-22 14:41:33.006773000 +0100
@@ -170,10 +170,8 @@ int __init auide_probe(void);
         static int auide_dma_host_on(ide_drive_t *drive);
         static int auide_dma_lostirq(ide_drive_t *drive);
         static int auide_dma_on(ide_drive_t *drive);
-        static void auide_ddma_tx_callback(int irq, void *param,
-                                           struct pt_regs *regs);
-        static void auide_ddma_rx_callback(int irq, void *param,
-                                           struct pt_regs *regs);
+        static void auide_ddma_tx_callback(int irq, void *param);
+        static void auide_ddma_rx_callback(int irq, void *param);
         static int auide_dma_off_quietly(ide_drive_t *drive);
 #endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
 
