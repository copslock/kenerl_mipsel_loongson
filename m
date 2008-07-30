Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 00:14:42 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:57551 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28584633AbYG3XOi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2008 00:14:38 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KOKsO-0000By-00; Thu, 31 Jul 2008 01:14:36 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id CD5E8DEBB8; Thu, 31 Jul 2008 01:14:24 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	netdev@vger.kernel.org, linux-mips@linux-mips.org
cc:	ralf@linux-mips.org, jgarzik@pobox.com
Subject: [PATCH] METH: fix MAC address setup
Message-Id: <20080730231424.CD5E8DEBB8@solo.franken.de>
Date:	Thu, 31 Jul 2008 01:14:24 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Setup of the mac filter lost the upper 16bit of the mac address. This
bug got unconvered by a patch, which fixed the promiscous handling.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/net/meth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/meth.c b/drivers/net/meth.c
index 4cb364e..0a97c26 100644
--- a/drivers/net/meth.c
+++ b/drivers/net/meth.c
@@ -100,7 +100,7 @@ static inline void load_eaddr(struct net_device *dev)
 	DPRINTK("Loading MAC Address: %s\n", print_mac(mac, dev->dev_addr));
 	macaddr = 0;
 	for (i = 0; i < 6; i++)
-		macaddr |= dev->dev_addr[i] << ((5 - i) * 8);
+		macaddr |= (u64)dev->dev_addr[i] << ((5 - i) * 8);
 
 	mace->eth.mac_addr = macaddr;
 }
