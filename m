Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 23:43:45 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([204.127.200.82]:34719 "EHLO
	sccrmhc12.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021968AbXCSXnj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 23:43:39 +0000
Received: from plexity.net (c-71-193-156-244.hsd1.or.comcast.net[71.193.156.244])
          by comcast.net (sccrmhc12) with ESMTP
          id <20070319234255012008mll5e>; Mon, 19 Mar 2007 23:42:56 +0000
Received: by plexity.net (Postfix, from userid 1025)
	id DD7B454494A; Mon, 19 Mar 2007 15:43:11 -0700 (PDT)
Date:	Mon, 19 Mar 2007 15:43:11 -0700
From:	Deepak Saxena <dsaxena@plexity.net>
To:	netdev@vger.kernel.org
Cc:	ralf@linux-mips.org, jeff@garzik.org, linux-mips@linux-mips.org,
	Manish Lachwani <mlachwani@mvista.com>
Subject: [PATCH] Netpoll support for Sibyte MAC
Message-ID: <20070319224311.GA10176@plexity.net>
Reply-To: dsaxena@plexity.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Return-Path: <dsaxena@plexity.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsaxena@plexity.net
Precedence: bulk
X-list: linux-mips


NETPOLL support for Sibyte MAC

Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
Signed-off-by: Deepak Saxena <dsaxena@mvista.com>

---

 Applies cleanly to 2.6.21-rc4

 drivers/net/sb1250-mac.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

Index: linux-2.6.18/drivers/net/sb1250-mac.c
===================================================================
--- linux-2.6.18.orig/drivers/net/sb1250-mac.c
+++ linux-2.6.18/drivers/net/sb1250-mac.c
@@ -1128,6 +1128,26 @@ static void sbdma_fillring(sbmacdma_t *d
 	}
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void sbmac_netpoll(struct net_device *netdev)
+{
+	struct sbmac_softc *sc = netdev_priv(netdev);
+	int irq = sc->sbm_dev->irq;
+
+	__raw_writeq(0, sc->sbm_imr);
+
+	sbmac_intr(irq, netdev, NULL);
+
+#ifdef CONFIG_SBMAC_COALESCE
+	__raw_writeq(((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_TX_CH0) |
+	((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_RX_CH0),
+	sc->sbm_imr);
+#else
+	__raw_writeq((M_MAC_INT_CHANNEL << S_MAC_TX_CH0) | 
+	(M_MAC_INT_CHANNEL << S_MAC_RX_CH0), sc->sbm_imr);
+#endif
+}
+#endif
 
 /**********************************************************************
  *  SBDMA_RX_PROCESS(sc,d)
@@ -2402,6 +2422,9 @@ static int sbmac_init(struct net_device 
 	dev->watchdog_timeo     = TX_TIMEOUT;
 
 	dev->change_mtu         = sb1250_change_mtu;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = sbmac_netpoll;
+#endif
 
 	/* This is needed for PASS2 for Rx H/W checksum feature */
 	sbmac_set_iphdr_offset(sc);

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertolt Brecht
