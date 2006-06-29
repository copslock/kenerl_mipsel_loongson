Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2006 21:02:23 +0100 (BST)
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62172 "EHLO
	fr.zoreil.com") by ftp.linux-mips.org with ESMTP id S8133749AbWF2UCN
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Jun 2006 21:02:13 +0100
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.4/8.12.1) with ESMTP id k5TK18pl009295;
	Thu, 29 Jun 2006 22:01:08 +0200
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.4/8.12.1) id k5TK17YN009294;
	Thu, 29 Jun 2006 22:01:07 +0200
Date:	Thu, 29 Jun 2006 22:01:07 +0200
From:	Francois Romieu <romieu@fr.zoreil.com>
To:	Tom Rix <trix@specifix.com>
Cc:	tbm@cyrius.com, jgarzik@pobox.com, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, mark.e.mason@broadcom.com
Subject: Re: PATCH SB1250 NAPI support
Message-ID: <20060629200107.GA8122@electric-eye.fr.zoreil.com>
References: <20060524125512.GO12089@deprecation.cyrius.com> <op.s93yprpethfl8t@localhost.localdomain> <20060525133505.GH8746@deprecation.cyrius.com> <op.tamrhvwlthfl8t@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tamrhvwlthfl8t@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation:	Land of Sunshine Inc.
Return-Path: <romieu@fr.zoreil.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: romieu@fr.zoreil.com
Precedence: bulk
X-list: linux-mips

Tom Rix <trix@specifix.com> :
[...]
diff -rup a/drivers/net/sb1250-mac.c b/drivers/net/sb1250-mac.c
--- a/drivers/net/sb1250-mac.c	2006-03-09 04:25:41.000000000 -0600
+++ b/drivers/net/sb1250-mac.c	2006-03-09 05:30:52.000000000 -0600
[...]
@@ -2079,13 +2095,31 @@ static irqreturn_t sbmac_intr(int irq,vo
 		 * Transmits on channel 0
 		 */
 
+#if defined(CONFIG_SBMAC_NAPI)
 		if (isr & (M_MAC_INT_CHANNEL << S_MAC_TX_CH0)) {
-			sbdma_tx_process(sc,&(sc->sbm_txdma));
+			sbdma_tx_process(sc,&(sc->sbm_txdma), 0);
 		}
 
 		/*
 		 * Receives on channel 0
 		 */
+		if (isr & (M_MAC_INT_CHANNEL << S_MAC_RX_CH0)) {
+			if (netif_rx_schedule_prep(dev))
+			{

An irq could appear here. I am skeptical that it is safe to write
the irq mask register so late.

One should probably consider a break in the enclosing "for" loop too.


+				__raw_writeq(0, sc->sbm_imr);
+				__netif_rx_schedule(dev);
+			}
+			else
+			{

} else {, please.

-- 
Ueimor
