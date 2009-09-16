Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2009 09:44:39 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:47011 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492332AbZIPHoc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2009 09:44:32 +0200
Received: by ewy25 with SMTP id 25so2661666ewy.33
        for <multiple recipients>; Wed, 16 Sep 2009 00:44:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:reply-to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Cw+xT34KFmUivnBW/b8v75D8NsJRkAkyiNXMeKSkw+s=;
        b=tHipxmEzgyRhQLPR/wnlGMV08z8CdzWQkcFfGIJAks/FXyLSE0INTxX3EC3nyffrND
         45iqoNBLfkkAsT9sJRWhz3YvKCMnmY/DpWFB42Z6R4mc0bEGD+eiS1I2b3TrfMpGjeLR
         sJmDg70Q0Emj4s4jYmCYBcyCdFJTyVfNt+9K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc:reply-to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=CjbbFXH5KZim/ElLiwzwhsXtQXFI6syZlKbZWoC9kgTpj3dvIpYk4iDn09EUQT7jRm
         2dSxaZUSHrOCkzffqWyhsD7IcWr6A4aV/8q3+3mW40GBVEFUYB88wmFyGTgOLenOY8vL
         F5+exVBAr7SW59zelR/qXz18VN82FQHQeZDA8=
Received: by 10.211.130.6 with SMTP id h6mr9446899ebn.97.1253087066595;
        Wed, 16 Sep 2009 00:44:26 -0700 (PDT)
Received: from lenovo.localnet (147.59.76-86.rev.gaoland.net [86.76.59.147])
        by mx.google.com with ESMTPS id 10sm1320657eyd.24.2009.09.16.00.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 00:44:25 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Wed, 16 Sep 2009 09:44:22 +0200
Subject: [PATCH] cpmac: fix compilation errors against undeclared BUS_ID_SIZE
MIME-Version: 1.0
X-UID:	1380
X-Length: 3115
To:	David Miller <davem@davemloft.net>
Cc:	netdev@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200909160944.24265.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi David,

This is relevant for 2.6.32-rc0, thanks !
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] cpmac: fix compilation errors against undeclared BUS_ID_SIZE

With the removal of BUS_ID_SIZE, cpmac was not fully
converted to use MII_BUS_ID_SIZE as it ought to. This
patch fixes the following cpmac build failure:
 CC      drivers/net/cpmac.o
drivers/net/cpmac.c: In function 'cpmac_start_xmit':
drivers/net/cpmac.c:563: warning: comparison of distinct pointer types lacks a cast
drivers/net/cpmac.c: In function 'cpmac_probe':
drivers/net/cpmac.c:1112: error: 'BUS_ID_SIZE' undeclared (first use in this function)
drivers/net/cpmac.c:1112: error: (Each undeclared identifier is reported only once
drivers/net/cpmac.c:1112: error: for each function it appears in.)

Reported-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index 3e3fab8..61f9da2 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -1109,7 +1109,7 @@ static int external_switch;
 static int __devinit cpmac_probe(struct platform_device *pdev)
 {
 	int rc, phy_id;
-	char mdio_bus_id[BUS_ID_SIZE];
+	char mdio_bus_id[MII_BUS_ID_SIZE];
 	struct resource *mem;
 	struct cpmac_priv *priv;
 	struct net_device *dev;
@@ -1118,7 +1118,7 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 	pdata = pdev->dev.platform_data;
 
 	if (external_switch || dumb_switch) {
-		strncpy(mdio_bus_id, "0", BUS_ID_SIZE); /* fixed phys bus */
+		strncpy(mdio_bus_id, "0", MII_BUS_ID_SIZE); /* fixed phys bus */
 		phy_id = pdev->id;
 	} else {
 		for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
@@ -1126,7 +1126,7 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 				continue;
 			if (!cpmac_mii->phy_map[phy_id])
 				continue;
-			strncpy(mdio_bus_id, cpmac_mii->id, BUS_ID_SIZE);
+			strncpy(mdio_bus_id, cpmac_mii->id, MII_BUS_ID_SIZE);
 			break;
 		}
 	}
@@ -1167,7 +1167,7 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 	priv->msg_enable = netif_msg_init(debug_level, 0xff);
 	memcpy(dev->dev_addr, pdata->dev_addr, sizeof(dev->dev_addr));
 
-	snprintf(priv->phy_name, BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id, phy_id);
+	snprintf(priv->phy_name, MII_BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id, phy_id);
 
 	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link, 0,
 						PHY_INTERFACE_MODE_MII);
