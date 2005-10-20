Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 08:03:02 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:47629 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465581AbVJTG6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:58:44 +0100
Received: from 10.10.64.121 by mms1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:58:29 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:58:27 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW11066; Wed, 19 Oct 2005 23:58:27 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28367 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:58:27
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6wQov008732 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:58:26 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6wQe24011 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:58:26 -0700
Date:	Wed, 19 Oct 2005 23:58:26 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 9/12]  sbmac-fixes
Message-ID: <20051020065826.GI23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F499F9F0684624672-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Improve sb1250-mac driver to probe for PHYs at addresses other
than 1, such as the PHYs on BigSur.

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 drivers/net/sb1250-mac.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

Index: lmo/drivers/net/sb1250-mac.c
===================================================================
--- lmo.orig/drivers/net/sb1250-mac.c	2005-10-19 22:34:12.000000000 -0700
+++ lmo/drivers/net/sb1250-mac.c	2005-10-19 22:34:12.000000000 -0700
@@ -314,6 +314,7 @@
 static int sbmac_mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int sbmac_close(struct net_device *dev);
 static int sbmac_mii_poll(struct sbmac_softc *s,int noisy);
+static int sbmac_mii_probe(struct net_device *dev);
 
 static void sbmac_mii_sync(struct sbmac_softc *s);
 static void sbmac_mii_senddata(struct sbmac_softc *s,unsigned int data, int bitcnt);
@@ -451,6 +452,9 @@
 
 #define	MII_BMCR	0x00 	/* Basic mode control register (rw) */
 #define	MII_BMSR	0x01	/* Basic mode status register (ro) */
+#define	MII_PHYIDR1	0x02
+#define	MII_PHYIDR2	0x03
+
 #define MII_K1STSR	0x0A	/* 1K Status Register (ro) */
 #define	MII_ANLPAR	0x05	/* Autonegotiation lnk partner abilities (rw) */
 
@@ -2460,6 +2464,15 @@
 		return -EBUSY;
 
 	/*
+	 * Probe phy address
+	 */
+
+	if(sbmac_mii_probe(dev) == -1) {
+		printk("%s: failed to probe PHY.\n", dev->name);
+		return -EINVAL;
+	}
+
+	/*
 	 * Configure default speed
 	 */
 
@@ -2492,6 +2505,29 @@
 	return 0;
 }
 
+static int sbmac_mii_probe(struct net_device *dev)
+{
+	int i;
+	struct sbmac_softc *s = netdev_priv(dev);
+	u16 bmsr, id1, id2;
+	u32 vendor, device;
+
+	for (i=1; i<31; i++) {
+	bmsr = sbmac_mii_read(s, i, MII_BMSR);
+		if (bmsr != 0) {
+			s->sbm_phys[0] = i;
+			id1 = sbmac_mii_read(s, i, MII_PHYIDR1);
+			id2 = sbmac_mii_read(s, i, MII_PHYIDR2);
+			vendor = ((u32)id1 << 6) | ((id2 >> 10) & 0x3f);
+			device = (id2 >> 4) & 0x3f;
+
+			printk(KERN_INFO "%s: found phy %d, vendor %06x part %02x\n",
+				dev->name, i, vendor, device);
+			return i;
+		}
+	}
+	return -1;
+}
 
 
 static int sbmac_mii_poll(struct sbmac_softc *s,int noisy)
