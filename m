Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:31:51 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.149]:19199 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024311AbZEaSbi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 May 2009 19:31:38 +0100
Received: by ey-out-1920.google.com with SMTP id 4so303439eyg.54
        for <multiple recipients>; Sun, 31 May 2009 11:31:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=37p5ahW21EGH+z7klRO7fS6R7QdOIgsTGCM5I/8dfgA=;
        b=D6hvB3KXY1CJVx73Drwb6zvOJ8rkbcIDT0MPcGZ3fykyouOKuWUMTlcweQ5Z28qQIu
         UuzOXnBq8ps/I5V7A6ylyExQJwxu31//qRMagR1fMa0PyLd6qHCjYYUBq2J3leLQCJ1P
         ZNMXJrpiwNpwR1wcyRHXuPFdC/dQZCOv7OzCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=UtoGZQqwDvX6gts1iU9vjmJWliTLBvqhhO/1nO2ZGmurHSIjHVuKkPx8QBYEj/P3+T
         ENKkOb1A6QYMwap/Y/FQ6IzB+e2twE8p2jwjwHi/C5b9S475GJHNsCSOanAkDg9Kgxc/
         UH105tHRljPFeHOs9KfTDwu5nfwjAOhSXyf80=
Received: by 10.210.16.17 with SMTP id 17mr3020727ebp.23.1243794697997;
        Sun, 31 May 2009 11:31:37 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 7sm524527eyb.45.2009.05.31.11.31.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:31:37 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sun, 31 May 2009 20:31:34 +0200
Subject: [PATCH 10/10] bcm63xx: compile fixes for bcm63xx_enet.c
MIME-Version: 1.0
X-UID:	142
X-Length: 1790
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905312031.35241.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch makes the ethernet driver compile again
after commit 908a7a1. netif_rx_schedule became
napi_schedule and __netif_rx_complete became
__napi_rx_complete.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index 39f7b67..a91f909 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -450,7 +450,7 @@ static int bcm_enet_poll(struct napi_struct *napi, int budget)
 
 	/* no more packet in rx/tx queue, remove device from poll
 	 * queue */
-	__netif_rx_complete(dev, napi);
+	__napi_complete(napi);
 
 	/* restore rx/tx interrupt */
 	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
@@ -502,7 +502,7 @@ static irqreturn_t bcm_enet_isr_dma(int irq, void *dev_id)
 	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
 	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
 
-	netif_rx_schedule(dev, &priv->napi);
+	napi_schedule(&priv->napi);
 
 	return IRQ_HANDLED;
 }
