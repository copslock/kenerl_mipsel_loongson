Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 17:14:52 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:15368 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S20027546AbWHaQOu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 Aug 2006 17:14:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id B6A377F403A
	for <linux-mips@linux-mips.org>; Thu, 31 Aug 2006 18:14:44 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09189-05 for <linux-mips@linux-mips.org>;
	Thu, 31 Aug 2006 18:14:44 +0200 (CEST)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id 6A7B77F4024; Thu, 31 Aug 2006 18:14:44 +0200 (CEST)
Date:	Thu, 31 Aug 2006 18:14:44 +0200
From:	Daniel Mack <daniel@caiaq.de>
To:	linux-mips@linux-mips.org
Subject: [PATCH] iso c90 fix for au1xxx-ide.c
Message-ID: <20060831161444.GA10525@ipxXXXXX>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Hi,

this little patch makes gcc stop complaining about mixed 
declarations and code when compiling drivers/ide/mips/au1xxx-ide.c.

It can also be found at 

	http://caiaq.org/linux-mips/patches/au1xxx-ide_iso_c90.patch

Daniel

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/drivers/ide/mips/au1xxx-ide.c b/drivers/ide/mips/au1xxx-ide.c
index 71f27e9..d40c087 100644
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -653,6 +653,7 @@ static int au_ide_probe(struct device *d
 	_auide_hwif *ahwif = &auide_hwif;
 	ide_hwif_t *hwif;
 	struct resource *res;
+	hw_regs_t *hw;
 	int ret = 0;
 
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA)
@@ -695,7 +696,7 @@ #endif
 	/* FIXME:  This might possibly break PCMCIA IDE devices */
 
 	hwif                            = &ide_hwifs[pdev->id];
-	hw_regs_t *hw 			= &hwif->hw;
+	hw                              = &hwif->hw;
 	hwif->irq = hw->irq             = ahwif->irq;
 	hwif->chipset                   = ide_au1xxx;
