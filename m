Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 09:14:34 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:62837 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20025012AbYFZIOZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 09:14:25 +0100
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [213.58.128.207]) with ESMTP; Thu, 26 Jun 2008 17:14:23 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1C19A1E385;
	Thu, 26 Jun 2008 17:14:18 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1121C1CF22;
	Thu, 26 Jun 2008 17:14:18 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m5Q8EGfl061391;
	Thu, 26 Jun 2008 17:14:16 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 26 Jun 2008 17:14:15 +0900 (JST)
Message-Id: <20080626.171415.81099548.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: [PATCH] tc35815: Fix receiver hangup on Rx FIFO overflow
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
X-archive-position: 19640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Rx FIFO overflow error, the controller consume a buffer descriptor
but currently the driver does not give it back to the controller.
This results unrecoverable 'Buffer List Exhausted' condition.  This
patch fix this problem by moving a "fbl_count--" line to proper place.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index dccea52..b07b8cb 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -1736,7 +1736,6 @@ tc35815_rx(struct net_device *dev)
 			skb = lp->rx_skbs[cur_bd].skb;
 			prefetch(skb->data);
 			lp->rx_skbs[cur_bd].skb = NULL;
-			lp->fbl_count--;
 			pci_unmap_single(lp->pci_dev,
 					 lp->rx_skbs[cur_bd].skb_dma,
 					 RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
@@ -1792,6 +1791,7 @@ tc35815_rx(struct net_device *dev)
 #ifdef TC35815_USE_PACKEDBUFFER
 			while (lp->fbl_curid != id)
 #else
+			lp->fbl_count--;
 			while (lp->fbl_count < RX_BUF_NUM)
 #endif
 			{
