Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2005 14:24:44 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.190]:18154
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224918AbVBOOY3>; Tue, 15 Feb 2005 14:24:29 +0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1D13cq-0000km-00; Tue, 15 Feb 2005 15:24:28 +0100
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1D13cp-0001Fo-00; Tue, 15 Feb 2005 15:24:28 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: [patch] support for DP83847 MII
Date:	Tue, 15 Feb 2005 15:27:06 +0100
User-Agent: KMail/1.7.1
Cc:	ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151527.06486.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

DP83847, from National Semiconductors. The patch changes four things in fact:

 * add support for DP83847 MII
 * remove unused variable
 * add some initialisations so even an unknown MII won't result in a crash
 * correct error message to "no known MIIs found"

Uli

---
Index: au1000_eth.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.41
diff -u -w -r1.41 au1000_eth.c
--- au1000_eth.c 10 Jan 2005 10:26:25 -0000 1.41
+++ au1000_eth.c 15 Feb 2005 14:22:06 -0000
@@ -151,13 +151,6 @@
  SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full | \
  SUPPORTED_Autoneg
 
-static char *phy_link[] = 
-{ "unknown", 
- "10Base2", "10BaseT", 
- "AUI",
- "100BaseT", "100BaseTX", "100BaseFX"
-};
-
 int bcm_5201_init(struct net_device *dev, int phy_addr)
 {
  s16 data;
@@ -785,6 +778,7 @@
  {"Broadcom BCM5201 10/100 BaseT PHY",0x0040,0x6212, &bcm_5201_ops,0},
  {"Broadcom BCM5221 10/100 BaseT PHY",0x0040,0x61e4, &bcm_5201_ops,0},
  {"Broadcom BCM5222 10/100 BaseT PHY",0x0040,0x6322, &bcm_5201_ops,1},
+ {"NS DP83847 PHY", 0x2000, 0x5c30, &bcm_5201_ops ,0},
  {"AMD 79C901 HomePNA PHY",0x0000,0x35c8, &am79c901_ops,0},
  {"AMD 79C874 10/100 BaseT PHY",0x0022,0x561b, &am79c874_ops,0},
  {"LSI 80227 10/100 BaseT PHY",0x0016,0xf840, &lsi_80227_ops,0},
@@ -1045,7 +1039,7 @@
 #endif
 
  if (aup->mii->chip_info == NULL) {
-  printk(KERN_ERR "%s: Au1x No MII transceivers found!\n",
+  printk(KERN_ERR "%s: Au1x No known MII transceivers found!\n",
     dev->name);
   return -1;
  }
@@ -1546,6 +1540,9 @@
   printk(KERN_ERR "%s: out of memory\n", dev->name);
   goto err_out;
  }
+ aup->mii->next = NULL;
+ aup->mii->chip_info = NULL;
+ aup->mii->status = 0;
  aup->mii->mii_control_reg = 0;
  aup->mii->mii_data_reg = 0;
 
