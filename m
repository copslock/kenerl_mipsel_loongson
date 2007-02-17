Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2007 02:52:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48055 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573811AbXBQCwA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 17 Feb 2007 02:52:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1H2pSnm020294;
	Sat, 17 Feb 2007 02:51:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1H2pFIw020287;
	Sat, 17 Feb 2007 02:51:15 GMT
Date:	Sat, 17 Feb 2007 02:51:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [IOC3] Fix link autonegotiation timer.
Message-ID: <20070217025115.GA20247@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Start link negotiation in the open method.  Previously it was started
on driver initialialization and shutdown on close so an ifdown would
have results in closing negotiation for good.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
index ee6bca0..f5d277c 100644
--- a/drivers/net/ioc3-eth.c
+++ b/drivers/net/ioc3-eth.c
@@ -831,13 +831,17 @@ static int ioc3_mii_init(struct ioc3_private *ip)
 	}
 
 	ip->mii.phy_id = i;
+
+out:
+	return res;
+}
+
+static void ioc3_mii_start(struct ioc3_private *ip)
+{
 	ip->ioc3_timer.expires = jiffies + (12 * HZ)/10;  /* 1.2 sec. */
 	ip->ioc3_timer.data = (unsigned long) ip;
 	ip->ioc3_timer.function = &ioc3_timer;
 	add_timer(&ip->ioc3_timer);
-
-out:
-	return res;
 }
 
 static inline void ioc3_clean_rx_ring(struct ioc3_private *ip)
@@ -1066,6 +1070,7 @@ static int ioc3_open(struct net_device *dev)
 	ip->ehar_h = 0;
 	ip->ehar_l = 0;
 	ioc3_init(dev);
+	ioc3_mii_start(ip);
 
 	netif_start_queue(dev);
 	return 0;
@@ -1269,6 +1274,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_stop;
 	}
 
+	ioc3_mii_start(ip);
 	ioc3_ssram_disc(ip);
 	ioc3_get_eaddr(ip);
 
@@ -1307,6 +1313,7 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 out_stop:
 	ioc3_stop(ip);
+	del_timer_sync(&ip->ioc3_timer);
 	ioc3_free_rings(ip);
 out_res:
 	pci_release_regions(pdev);
@@ -1328,6 +1335,8 @@ static void __devexit ioc3_remove_one (struct pci_dev *pdev)
 	struct ioc3 *ioc3 = ip->regs;
 
 	unregister_netdev(dev);
+	del_timer_sync(&ip->ioc3_timer);
+
 	iounmap(ioc3);
 	pci_release_regions(pdev);
 	free_netdev(dev);
@@ -1483,6 +1492,7 @@ static void ioc3_timeout(struct net_device *dev)
 	ioc3_stop(ip);
 	ioc3_init(dev);
 	ioc3_mii_init(ip);
+	ioc3_mii_start(ip);
 
 	spin_unlock_irq(&ip->ioc3_lock);
 
