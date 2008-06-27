Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 10:22:11 +0100 (BST)
Received: from alpha-bit.de ([217.160.213.225]:19604 "EHLO
	p15137410.pureserver.info") by ftp.linux-mips.org with ESMTP
	id S20026094AbYF0JWC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jun 2008 10:22:02 +0100
Received: from Porsche (DSL01.83.171.174.172.ip-pool.NEFkom.net [83.171.174.172])
	by p15137410.pureserver.info (Postfix) with ESMTP id 83E4780DA12;
	Fri, 27 Jun 2008 11:22:00 +0200 (CEST)
X-KENId: 000024B7KEN38BFAF09
X-KENRelayed: 000024B7KEN38BFAF09@Porsche
Received: from [192.168.0.209]
   by KEN (4.00.93-v070725) with SMTP
   ; Fri, 27 Jun 2008 11:22:01 +0200
Date:	Fri, 27 Jun 2008 11:22:02 +0200
From:	Martin Gebert <martin.gebert@alpha-bit.de>
Subject: Patch spinlock initialisation au1000_eth.c
To:	linux-mips@linux-mips.org
Message-Id: <4864B13A.2030702@alpha-bit.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
   boundary="------------040107030702010801080708"
X-KENRecTime: 1214558521
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Return-Path: <martin.gebert@alpha-bit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.gebert@alpha-bit.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040107030702010801080708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all!

While debugging spinlocks I came across a message from the kernel 
indicating a problem in the AU1x00 ethernet driver. Seems like the 
spinlock for the device is initialised too late, as it is already used 
in enable_mac(), which is called via mii_probe() before the init takes 
place. The attached patch is working here for a Linux Au1100 
2.6.22.6-Rev504 kernel, and as far as I checked should also be 
applicable to the current head (line numbers differ).
Comments welcome; I'm quite new to kernel hacking :-)

Martin

Martin Gebert
alpha-bit Gesellschaft für software-engineering mbH
Karl-Zucker-Str. 1a
D-91052 Erlangen
mailto:martin.gebert@alpha-bit.de
Fon:    +49 (9131) 97799-24
Fax:    +49 (9131) 97799-28

Handelsregister Fürth HRB 3159
Geschäftsführer Dipl.-Ing. Lothar Müller, Evi Reiß



--------------040107030702010801080708
Content-Type: text/x-patch;
 name="OFSP6-kernel-2.6.22-Eth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="OFSP6-kernel-2.6.22-Eth.patch"

--- drivers/net/au1000_eth.c.orig	2008-06-26 14:21:53.000000000 +0200
+++ drivers/net/au1000_eth.c	2008-06-26 14:23:00.000000000 +0200
# The following spinlock needs to be initialized earlier, as it is already used
# in enable_mac(), called via mii_probe()
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

--------------040107030702010801080708--
