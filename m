Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 14:59:22 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:15122 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S20039345AbWJHN7T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 14:59:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id EF4A67F403A
	for <linux-mips@linux-mips.org>; Sun,  8 Oct 2006 15:59:12 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29439-08 for <linux-mips@linux-mips.org>;
	Sun, 8 Oct 2006 15:59:12 +0200 (CEST)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id C8AF97F4026; Sun,  8 Oct 2006 15:59:12 +0200 (CEST)
Date:	Sun, 8 Oct 2006 15:59:12 +0200
From:	Daniel Mack <daniel@caiaq.de>
To:	linux-mips@linux-mips.org
Subject: [PATCH] make au1xxx_ide compile
Message-ID: <20061008135912.GA368@ipxXXXXX>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi all,

This makes the DMA part of the au1xxx driver compile again.

Daniel

Signed-off-by: Daniel Mack <daniel@caiaq.de>

--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -171,10 +171,8 @@ #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_D
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
