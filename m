Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2004 23:51:57 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21745 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225744AbUKHXvw>; Mon, 8 Nov 2004 23:51:52 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iA8Npndh021000
	for <linux-mips@linux-mips.org>; Mon, 8 Nov 2004 15:51:49 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iA8NpnVH020998
	for linux-mips@linux-mips.org; Mon, 8 Nov 2004 15:51:49 -0800
Date: Mon, 8 Nov 2004 15:51:48 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Subject: [PATCH] Small fix for the Sibyte Mac driver
Message-ID: <20041108235148.GA20991@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello !

Attached is a small patch for the Sibyte MAC Driver. This helps
print the device name correctly

Thanks
Manish Lachwani

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-sb1250-mac

--- drivers/net/sb1250-mac.c.orig	2004-11-08 15:36:45.000000000 -0800
+++ drivers/net/sb1250-mac.c	2004-11-08 15:44:33.000000000 -0800
@@ -2410,13 +2410,13 @@
 
 	dev->change_mtu         = sb1250_change_mtu;
 
-	/* This is needed for PASS2 for Rx H/W checksum feature */
-	sbmac_set_iphdr_offset(sc);
-
 	err = register_netdev(dev);
 	if (err)
 		goto out_uninit;
 
+	/* This is needed for PASS2 for Rx H/W checksum feature */
+	sbmac_set_iphdr_offset(sc);
+
 	/*
 	 * Display Ethernet address (this is called during the config
 	 * process so we need to finish off the config message that

--4Ckj6UjgE2iN1+kY--
