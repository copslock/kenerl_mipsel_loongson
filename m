Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 18:15:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5837 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039164AbXB0SPJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Feb 2007 18:15:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1RIF2P5010957;
	Tue, 27 Feb 2007 18:15:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1RIF1d8010929;
	Tue, 27 Feb 2007 18:15:01 GMT
Date:	Tue, 27 Feb 2007 18:15:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] jmr3927: do not call tc35815_killall().
Message-ID: <20070227181501.GA10897@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

No need to stop tc35815 before resetting the board.  This fixes the
build of tc35815 as a module.  This also means there is no caller of
tc35815_killall left, so remove that function also.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/jmr3927/rbhma3100/setup.c b/arch/mips/jmr3927/rbhma3100/setup.c
index 7ca3d6d..ecabe5b 100644
--- a/arch/mips/jmr3927/rbhma3100/setup.c
+++ b/arch/mips/jmr3927/rbhma3100/setup.c
@@ -137,10 +137,6 @@ int jmr3927_ccfg_toeon = 0;
 
 static inline void do_reset(void)
 {
-#ifdef CONFIG_TC35815
-	extern void tc35815_killall(void);
-	tc35815_killall();
-#endif
 #if 1	/* Resetting PCI bus */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 	jmr3927_ioc_reg_out(JMR3927_IOC_RESET_PCI, JMR3927_IOC_RESET_ADDR);
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index 81ed82f..911ff51 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -1703,19 +1703,6 @@ static void tc35815_chip_init(struct net_device *dev)
 	spin_unlock_irqrestore(&lp->lock, flags);
 }
 
-/* XXX */
-void
-tc35815_killall(void)
-{
-	struct net_device *dev;
-
-	for (dev = root_tc35815_dev; dev; dev = ((struct tc35815_local *)dev->priv)->next_module) {
-		if (dev->flags&IFF_UP){
-			dev->stop(dev);
-		}
-	}
-}
-
 static struct pci_driver tc35815_driver = {
 	.name = TC35815_MODULE_NAME,
 	.probe = tc35815_probe,
