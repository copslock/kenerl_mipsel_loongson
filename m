Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 21:14:49 +0100 (BST)
Received: from mion.elka.pw.edu.pl ([IPv6:::ffff:194.29.160.35]:7298 "EHLO
	mion.elka.pw.edu.pl") by linux-mips.org with ESMTP
	id <S8225867AbUDUUOs>; Wed, 21 Apr 2004 21:14:48 +0100
Received: from chello062179061026.chello.pl ([62.179.61.26]:33964 "EHLO
	192.168.0.252") by mion.elka.pw.edu.pl with ESMTP id <S25947AbUDUUOe>;
	Wed, 21 Apr 2004 22:14:34 +0200
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-mips@linux-mips.org
Subject: [PATCH] it8172.c: ide_init_hwif_ports() -> ide_std_init_ports()
Date: Wed, 21 Apr 2004 22:13:43 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404212213.43990.bzolnier@elka.pw.edu.pl>
X-Virus-Scanned: by AMaViS perl-11 mion
Return-Path: <B.Zolnierkiewicz@elka.pw.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: B.Zolnierkiewicz@elka.pw.edu.pl
Precedence: bulk
X-list: linux-mips


Self-explanatory. :-)


[PATCH] it8172.c: ide_init_hwif_ports() -> ide_std_init_ports()

This driver can be compiled only on mips (depends on MIPS_ITE8172 || MIPS_IVR)
so replace ide_init_hwif_ports() with ide_std_init_ports().

 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/pci/it8172.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/pci/it8172.c~it8172_std_init_ports drivers/ide/pci/it8172.c
--- linux-2.6.6-rc1-bk5/drivers/ide/pci/it8172.c~it8172_std_init_ports	2004-04-21 00:37:17.601970896 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/pci/it8172.c	2004-04-21 00:37:17.605970288 +0200
@@ -263,8 +263,8 @@ static void __init init_hwif_it8172 (ide
 
 	cmdBase = dev->resource[0].start;
 	ctrlBase = dev->resource[1].start;
-    
-	ide_init_hwif_ports(&hwif->hw, cmdBase, ctrlBase | 2, NULL);
+
+	ide_std_init_ports(&hwif->hw, cmdBase, ctrlBase | 2);
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->noprobe = 0;
 

_
