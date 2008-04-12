Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 01:50:35 +0100 (BST)
Received: from p549F7144.dip.t-dialin.net ([84.159.113.68]:39589 "EHLO
	p549F7144.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20023344AbYDNAuc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Apr 2008 01:50:32 +0100
Received: from mba.ocn.ne.jp ([122.1.235.107]:960 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S1788957AbYDLPK7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Apr 2008 17:10:59 +0200
Received: from localhost (p4038-ipad205funabasi.chiba.ocn.ne.jp [222.146.99.38])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0A2DBAB59; Sun, 13 Apr 2008 00:10:54 +0900 (JST)
Date:	Sun, 13 Apr 2008 00:11:46 +0900 (JST)
Message-Id: <20080413.001146.25909265.anemo@mba.ocn.ne.jp>
To:	jeff@garzik.org, Andy Fleming <afleming@freescale.com>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] tc35815: Statistics cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48007A41.2000803@garzik.org>
References: <20080411.002412.03977557.anemo@mba.ocn.ne.jp>
	<48007A41.2000803@garzik.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 12 Apr 2008 05:00:49 -0400, Jeff Garzik <jeff@garzik.org> wrote:
> applied 1-6

Thanks.

Could you apply this too, or hopufully fold into Andy Fleming's "phy:
Change mii_bus id field to a string" patch (commit c69fedae) ?

------------------------------------------------------
Subject: [PATCH] tc35815: build fix

Fix build failure caused by Andy Fleming's "phy: Change mii_bus id
field to a string" patch.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index 744f11f..10e4e85 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -766,7 +766,8 @@ static int tc_mii_init(struct net_device *dev)
 	lp->mii_bus.name = "tc35815_mii_bus";
 	lp->mii_bus.read = tc_mdio_read;
 	lp->mii_bus.write = tc_mdio_write;
-	lp->mii_bus.id = (lp->pci_dev->bus->number << 8) | lp->pci_dev->devfn;
+	snprintf(lp->mii_bus.id, MII_BUS_ID_SIZE, "%x",
+		 (lp->pci_dev->bus->number << 8) | lp->pci_dev->devfn);
 	lp->mii_bus.priv = dev;
 	lp->mii_bus.dev = &lp->pci_dev->dev;
 	lp->mii_bus.irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
