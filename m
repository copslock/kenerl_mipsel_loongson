Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 14:43:02 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:25608 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225263AbUCYOnB> convert rfc822-to-8bit;
	Thu, 25 Mar 2004 14:43:01 +0000
Received: from localhost ([193.170.141.4]) by grey.subnet.at ; Thu, 25 Mar 2004 14:00:57 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: Pete Popov <ppopov@mvista.com>
Subject: patch: au1000_eth vlan
Date: Thu, 25 Mar 2004 13:42:18 +0100
User-Agent: KMail/1.6.1
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403251342.18945.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello pete!

please consider adding the following patch to support 802.1Q VLAN tagged 
ethernet frames in the au1000_eth driver.

thanks,
bruno


diff -Nurb linux-2.4.24-isl/drivers/net/au1000_eth.c 
linux/drivers/net/au1000_eth.c
- --- linux-2.4.24-isl/drivers/net/au1000_eth.c   2004-03-14 20:01:45.000000000 
+0100
+++ linux/drivers/net/au1000_eth.c      2004-03-25 12:36:27.290599896 +0100
@@ -1384,6 +1384,7 @@
                control |= MAC_FULL_DUPLEX;
        }
        aup->mac->control = control;
+       aup->mac->vlan1_tag = 0x8100; /* vlan */
        au_sync();

        spin_unlock_irqrestore(&aup->lock, flags);
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAYtOqfg2jtUL97G4RAj3dAJ0XraGIkpZGXBUONKzXrDs/HVYwzwCgglyC
CPsIhh1Wjo+F1WPyOu9AbxY=
=93l6
-----END PGP SIGNATURE-----
