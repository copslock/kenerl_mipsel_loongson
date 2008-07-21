Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2008 10:53:59 +0100 (BST)
Received: from alpha-bit.de ([217.160.213.225]:8924 "EHLO
	p15137410.pureserver.info") by ftp.linux-mips.org with ESMTP
	id S28573717AbYGUJxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Jul 2008 10:53:52 +0100
Received: from Porsche (DSL01.83.171.182.190.ip-pool.NEFkom.net [83.171.182.190])
	by p15137410.pureserver.info (Postfix) with ESMTP id 4A3A980DA12
	for <linux-mips@linux-mips.org>; Mon, 21 Jul 2008 11:53:52 +0200 (CEST)
X-KENId: 00001AA9KEN004CDB5A
X-KENRelayed: 00001AA9KEN004CDB5A@Porsche
Received: from [192.168.0.209]
   by KEN (4.00.93-v070725) with SMTP
   ; Mon, 21 Jul 2008 11:53:42 +0200
Date:	Mon, 21 Jul 2008 11:53:50 +0200
From:	Martin Gebert <martin.gebert@alpha-bit.de>
Subject: [PATCH] Spinlock initialisation au1000_eth.c
To:	linux-mips@linux-mips.org
Message-Id: <48845CAE.5000606@alpha-bit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
X-KENRecTime: 1216634022
Content-Transfer-Encoding: 7bit
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Return-Path: <martin.gebert@alpha-bit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.gebert@alpha-bit.de
Precedence: bulk
X-list: linux-mips

Seems like the spinlock for the AU1x00 ethernet device is initialised too
late, as it is already used in enable_mac(), which is called via
mii_probe() before the init takes place.
The attached patch is working here for a Linux Au1100 2.6.22.6 kernel,
and as far as I checked should also be applicable to the current head
(just line numbers differ).

Signed-off-by: Martin Gebert <Martin.Gebert@alpha-bit.de>

--- drivers/net/au1000_eth.c	2008-06-26 14:21:53.000000000 +0200
+++ drivers/net/au1000_eth.c	2008-06-26 14:23:00.000000000 +0200
@@ -656,6 +656,7 @@
		dev->name, base, irq);

	aup = dev->priv;
+	spin_lock_init(&aup->lock);

	/* Allocate the data buffers */
	/* Snooping works fine with eth on all au1xxx */
@@ -766,7 +767,6 @@
		aup->tx_db_inuse[i] = pDB;
	}

-	spin_lock_init(&aup->lock);
	dev->base_addr = base;
	dev->irq = irq;
	dev->open = au1000_open;
