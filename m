Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 18:41:19 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:59126 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8224791AbUKRSlM>; Thu, 18 Nov 2004 18:41:12 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iAIIf9dh003237;
	Thu, 18 Nov 2004 10:41:09 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iAIIf8sQ003235;
	Thu, 18 Nov 2004 10:41:08 -0800
Date: Thu, 18 Nov 2004 10:41:08 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Fix for the pcnet32 ethernet driver
Message-ID: <20041118184108.GA3228@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

This patch fixes the pcnet32 ethernet driver to clear any other interrupt
when setting interrupt enable in the pcnet32 interrupt handler. This has been
tested on the NEC CMB-VR4133 board.

Please review 

Thanks
Manish Lachwani


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_NEC_eth_MR9056.patch"

Source: MontaVista Software, Inc. | http;//www.mvista.com | Manish Lachwani <mlachwani@mvista.com>
Type: Defect Fix
Disposition: Submitted to Linux-MIPS
Description:
	Fix the Interrupt Enable for the PcNet32 driver. Ack any
	remaining interrupts. Tested on the NEC CMB-VR4133

Index: linux/drivers/net/pcnet32.c
===================================================================
--- linux.orig/drivers/net/pcnet32.c
+++ linux/drivers/net/pcnet32.c
@@ -1897,7 +1897,7 @@
     }
 
     /* Set interrupt enable. */
-    lp->a.write_csr (ioaddr, 0, 0x0040);
+    lp->a.write_csr (ioaddr, 0, 0x7940);
     lp->a.write_rap (ioaddr,rap);
 
     if (netif_msg_intr(lp))

--7AUc2qLy4jB3hD7Z--
