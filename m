Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 19:32:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:56046 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224935AbUKRTcD>; Thu, 18 Nov 2004 19:32:03 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAIJW1dh004278;
	Thu, 18 Nov 2004 11:32:01 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAIJW1Fa004276;
	Thu, 18 Nov 2004 11:32:01 -0800
Date: Thu, 18 Nov 2004 11:32:01 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Fix to the Broadcom sb1250-mac driver
Message-ID: <20041118193201.GA4269@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached is a small patch for the sb1250-mac driver to print the ethernet
device name correctly. This is based on a previous discussion. Please review

Thanks
Manish Lachwani

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-sb1250-mac

--- drivers/net/sb1250-mac.c.orig	2004-11-18 11:24:12.000000000 -0800
+++ drivers/net/sb1250-mac.c	2004-11-18 11:27:49.000000000 -0800
@@ -1811,8 +1811,6 @@
 	
 	/* read system identification to determine revision */
 	if (periph_rev >= 2) {
-		printk(KERN_INFO "%s: enabling TCP rcv checksum\n",
-		       sc->sbm_dev->name);
 		sc->rx_hw_checksum = ENABLE;
 	} else {
 		sc->rx_hw_checksum = DISABLE;
@@ -2417,6 +2415,11 @@
 	if (err)
 		goto out_uninit;
 
+	if (periph_rev >= 2) {
+		printk(KERN_INFO "%s: enabling TCP rcv checksum\n",
+			sc->sbm_dev->name);
+	}
+
 	/*
 	 * Display Ethernet address (this is called during the config
 	 * process so we need to finish off the config message that

--wac7ysb48OaltWcw--
