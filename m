Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Feb 2008 19:17:50 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:38067 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20037192AbYBYTRr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Feb 2008 19:17:47 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 6B4B348919;
	Mon, 25 Feb 2008 20:17:42 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JTiph-0001S7-Q2; Mon, 25 Feb 2008 19:17:49 +0000
Date:	Mon, 25 Feb 2008 19:17:49 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [MIPS, 2.6.16, PATCH] Fix SWARM onboard IDE probing
Message-ID: <20080225191749.GG25530@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

linux-2.6.16-stable misses the IDE probing fix which is already applied
to later stable branches (from linux-2.6.17-stable onwards). It is
needed to access the SWARM onboard IDE device.


Signed-off-by: Thiemo Seufer <ths@networkno.de>

diff --git a/drivers/ide/mips/swarm.c b/drivers/ide/mips/swarm.c
index 66f6064..f75d34e 100644
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -127,6 +127,7 @@ static int __devinit swarm_ide_probe(struct device *dev)
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
+	probe_hwif_init(hwif);
 	dev_set_drvdata(dev, hwif);
 
 	return 0;
