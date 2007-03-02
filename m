Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:10:59 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:2215 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039614AbXCBVKK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:10:10 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id EB8948D1694
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:17 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/7] Au1000 eth : Link beat detection
Date:	Fri, 2 Mar 2007 22:07:35 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XIJ6FfcY7J8uNDy"
Message-Id: <200703022207.35218.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_XIJ6FfcY7J8uNDy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes the link beat detection when the cable is not plugged at 
startup. It is not MTX1 specific.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
--

--Boundary-00=_XIJ6FfcY7J8uNDy
Content-Type: text/plain;
  charset="iso-8859-1";
  name="005-au1000_eth_link_beat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="005-au1000_eth_link_beat.patch"

diff -urN linux-2.6.16.7/drivers/net/au1000_eth.c linux-2.6.16.7.new/drivers/net/au1000_eth.c
--- linux-2.6.16.7/drivers/net/au1000_eth.c	2006-04-17 23:53:25.000000000 +0200
+++ linux-2.6.16.7.new/drivers/net/au1000_eth.c	2006-04-23 01:42:48.000000000 +0200
@@ -12,6 +12,9 @@
  * Author: MontaVista Software, Inc.
  *         	ppopov@mvista.com or source@mvista.com
  *
+ *         Bjoern Riemer 2004
+ *           riemer@fokus.fraunhofer.de or riemer@riemer-nt.de
+ *             // fixed the link beat detection with ioctls (SIOCGMIIPHY)
  * ########################################################################
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -1672,6 +1675,10 @@
 	aup->phy_ops->phy_status(dev, aup->phy_addr, &link, &speed);
 	control = MAC_DISABLE_RX_OWN | MAC_RX_ENABLE | MAC_TX_ENABLE;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
+	/*riemer: fix for startup without cable */
+	if (!link)
+		dev->flags &= ~IFF_RUNNING;
+
 	control |= MAC_BIG_ENDIAN;
 #endif
 	if (link && (dev->if_port == IF_PORT_100BASEFX)) {

--Boundary-00=_XIJ6FfcY7J8uNDy--
