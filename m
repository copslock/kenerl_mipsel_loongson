Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 22:08:58 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:22720 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S8133463AbWAYWIl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 22:08:41 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F1ssw-0000m2-TC; Wed, 25 Jan 2006 22:13:02 +0000
Date:	Wed, 25 Jan 2006 22:13:02 +0000
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2.6.X] Fix SWARM IDE detection
Message-ID: <20060125221302.GA2968@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Make sure we scan SWARM IDE interface for devices.

P.

Index: linux.git/drivers/ide/mips/swarm.c
===================================================================
--- linux.git.orig/drivers/ide/mips/swarm.c	2006-01-23 22:48:58.000000000 +0000
+++ linux.git/drivers/ide/mips/swarm.c	2006-01-24 08:32:45.000000000 +0000
@@ -127,6 +127,7 @@
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
+	probe_hwif_init(hwif);
 	dev_set_drvdata(dev, hwif);
 
 	return 0;
