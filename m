Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2004 03:00:09 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:18429 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225226AbUKLC7x>; Fri, 12 Nov 2004 02:59:53 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAC2xpdh015613;
	Thu, 11 Nov 2004 18:59:51 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAC2xpnP015611;
	Thu, 11 Nov 2004 18:59:51 -0800
Date: Thu, 11 Nov 2004 18:59:51 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] ne.c driver to support TX4927 board
Message-ID: <20041112025951.GA15605@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf

Attached patch implements changes to the ne.c driver to support
the TX4927 board. Please review 

Thanks
Manish Lachwani


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_toshiba_net_MR9019.patch"

Source: MontaVista Software, Inc. | http://www.mvista.com | Manish Lachwani <mlachwani@mvista.com>
Type: Defect Fix
Disposition: Submitted to Linux-MIPS
Description:
	Support for RBTX4927 in NS8390 ethernet driver in 2.6.10

Index: linux/drivers/net/ne.c
===================================================================
--- linux.orig/drivers/net/ne.c
+++ linux/drivers/net/ne.c
@@ -112,6 +112,7 @@
     {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */
     {"REALTEK", "RTL8019", {0x00, 0x00, 0xe8}}, /* no-name with Realtek chip */
     {"LCS-8834", "LCS-8836", {0x04, 0x04, 0x37}}, /* ShinyNet (SET) */
+    {"RBHMA4X00-RTL8019", "RBHMA4X00/RTL8019", {0x00, 0x60, 0x0a}},  /* Toshiba built-in */
     {NULL,}
 };
 #endif
@@ -226,6 +227,10 @@
 	sprintf(dev->name, "eth%d", unit);
 	netdev_boot_setup_check(dev);
 
+#ifdef CONFIG_TOSHIBA_RBTX4927
+	dev->base_addr = 0x06020280;
+	dev->irq = 29;
+#endif
 	err = do_ne_probe(dev);
 	if (err)
 		goto out;
@@ -511,6 +516,11 @@
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
+
+#ifdef CONFIG_TOSHIBA_RBTX4927	
+	wordlength = 1;
+#endif
+
 #ifdef CONFIG_PLAT_OAKS32R
 	ei_status.word16 = 0;
 #else

--MGYHOYXEY6WxJCY8--
