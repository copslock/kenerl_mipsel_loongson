Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2008 03:41:18 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:50816 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20042932AbYFYClL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jun 2008 03:41:11 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Wed, 25 Jun 2008 11:41:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3BDF342496;
	Wed, 25 Jun 2008 11:41:03 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 30B4B1EF5F;
	Wed, 25 Jun 2008 11:41:03 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m5P2f1fl054647;
	Wed, 25 Jun 2008 11:41:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 25 Jun 2008 11:41:01 +0900 (JST)
Message-Id: <20080625.114101.102912128.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: [PATCH] tc35815: Mark carrier-off before starting PHY
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Call netif_carrier_off() before starting PHY device.  This is a
behavior before converting to generic PHY layer.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index 10e4e85..dccea52 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -1394,6 +1394,7 @@ tc35815_open(struct net_device *dev)
 	tc35815_chip_init(dev);
 	spin_unlock_irq(&lp->lock);
 
+	netif_carrier_off(dev);
 	/* schedule a link state check */
 	phy_start(lp->phy_dev);
 
@@ -2453,6 +2454,7 @@ static int tc35815_resume(struct pci_dev *pdev)
 		return 0;
 	pci_set_power_state(pdev, PCI_D0);
 	tc35815_restart(dev);
+	netif_carrier_off(dev);
 	if (lp->phy_dev)
 		phy_start(lp->phy_dev);
 	netif_device_attach(dev);
