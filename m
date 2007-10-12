Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 16:47:16 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:61658 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20025855AbXJLPrH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 16:47:07 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9289D400D4;
	Fri, 12 Oct 2007 17:47:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id vNVqHkHZvv-n; Fri, 12 Oct 2007 17:46:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E477840095;
	Fri, 12 Oct 2007 17:46:56 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9CFl1Zl023642;
	Fri, 12 Oct 2007 17:47:01 +0200
Date:	Fri, 12 Oct 2007 16:46:56 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] sb1250-swarm_defconfig: Enable GenBus IDE
Message-ID: <Pine.LNX.4.64N.0710121641150.21684@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4533/Fri Oct 12 12:59:29 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 Enable the onboard GenBus IDE interface in the default configuration.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 I see no reason to keep it disabled; I think the onboard devices deserve 
some automatic build-time testing -- at least ones for which drivers are 
known to be in a reasonable shape.

 As a side note, this configuration template has not been regenerated for 
a long time and is thus severely outdated.  I am tempted to do this, 
obviously setting any new options to my liking -- I'll send another patch 
for it unless somebody objects.

 Please apply,

  Maciej

patch-mips-2.6.23-20071011-swarm-defconfig-0
diff -up --recursive --new-file linux-mips-2.6.23-20071011.macro/arch/mips/configs/sb1250-swarm_defconfig linux-mips-2.6.23-20071011/arch/mips/configs/sb1250-swarm_defconfig
--- linux-mips-2.6.23-20071011.macro/arch/mips/configs/sb1250-swarm_defconfig	2007-10-11 04:56:52.000000000 +0000
+++ linux-mips-2.6.23-20071011/arch/mips/configs/sb1250-swarm_defconfig	2007-10-12 14:51:50.000000000 +0000
@@ -467,7 +467,7 @@ CONFIG_BLK_DEV_IDEFLOPPY=y
 #
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
-# CONFIG_BLK_DEV_IDE_SWARM is not set
+CONFIG_BLK_DEV_IDE_SWARM=y
 # CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
