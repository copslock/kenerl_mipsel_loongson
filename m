Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 17:57:41 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65263 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225255AbVAVR5h>; Sat, 22 Jan 2005 17:57:37 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j0MHvZdh026971;
	Sat, 22 Jan 2005 09:57:35 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j0MHvZFV026969;
	Sat, 22 Jan 2005 09:57:35 -0800
Date:	Sat, 22 Jan 2005 09:57:35 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Support 8-bit and 16-bit PCI ops on TX4927 in BE
Message-ID: <20050122175735.GA26945@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

Attached patch supports 8-bit and 16-bit PCI operations on TX4927 in big endian mode. Please review and/or apply

Thanks
Manish Lachwani

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_tx4927_BE.patch"

Source: MontaVista Software, Inc. | URL | Manish Lachwani <mlachwani@mvista.com>
MR: 9909
Type: Defect Fix
Disposition: Submitted to linux-mips.org
Keywords:
Signed-off-by: Manish Lachwani <mlachwani@mvista.com>
Description:
	Support for BE mode on Tx4927 based board

Index: linux-2.6.10/arch/mips/pci/ops-tx4927.c
===================================================================
--- linux-2.6.10.orig/arch/mips/pci/ops-tx4927.c
+++ linux-2.6.10/arch/mips/pci/ops-tx4927.c
@@ -130,11 +130,21 @@
 	switch (size) {
 	case 1:
 		*val = *(volatile u8 *) ((ulong) & tx4927_pcicptr->
-                              g2pcfgdata | (where & 3));
+                              g2pcfgdata | 
+#ifdef __LITTLE_ENDIAN
+						(where & 3));
+#else
+						((where & 0x3) ^ 0x3));
+#endif
 		break;
 	case 2:
 		*val = *(volatile u16 *) ((ulong) & tx4927_pcicptr->
-                               g2pcfgdata | (where & 3));
+                               g2pcfgdata | 
+#ifdef __LITTLE_ENDIAN
+						(where & 3));
+#else
+						((where & 0x3) ^ 0x2));
+#endif
 		break;
 	case 4:
 		*val = tx4927_pcicptr->g2pcfgdata;
@@ -179,12 +189,22 @@
 	switch (size) {
 	case 1:
 		 *(volatile u8 *) ((ulong) & tx4927_pcicptr->
-                          g2pcfgdata | (where & 3)) = val;
+                          g2pcfgdata | 
+#ifdef __LITTLE_ENDIAN
+					(where & 3)) = val;
+#else
+					((where & 0x3) ^ 0x3)) = val;
+#endif
 		break;
 
 	case 2:
 		*(volatile u16 *) ((ulong) & tx4927_pcicptr->
-                           g2pcfgdata | (where & 3)) = val;
+                           g2pcfgdata | 
+#ifdef __LITTLE_ENDIAN
+					(where & 3)) = val;
+#else
+					((where & 0x3) ^ 0x2)) = val;
+#endif
 		break;
 	case 4:
 		tx4927_pcicptr->g2pcfgdata = val;

--5vNYLRcllDrimb99--
