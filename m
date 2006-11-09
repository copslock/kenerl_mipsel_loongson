Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2006 19:12:04 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:54507 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20037733AbWKITMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2006 19:12:00 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: swarm IDE fix: missing probing
Date:	Thu, 9 Nov 2006 11:11:50 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D44DDBE@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: swarm IDE fix: missing probing
Thread-Index: AccEMuj6vdk2mz7kRWqmadbYRgo3Cw==
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

This patch is needed to bring up the compact flash IDE drive.

I think it's missing under 2.6.18 as well.


Index: linux-2.6.17.7/drivers/ide/mips/swarm.c
===================================================================
--- linux-2.6.17.7.orig/drivers/ide/mips/swarm.c	2006-11-09
12:55:20.000000000 -0800
+++ linux-2.6.17.7/drivers/ide/mips/swarm.c	2006-11-09
12:56:30.432607488 -0800
@@ -127,6 +127,7 @@
 	memcpy(hwif->io_ports, hwif->hw.io_ports,
sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
+	probe_hwif_init(hwif);
 	dev_set_drvdata(dev, hwif);
 
 	return 0;
