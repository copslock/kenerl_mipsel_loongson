Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 22:52:56 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33516 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493221AbZHDUwt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 22:52:49 +0200
Received: by ewy12 with SMTP id 12so5358211ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 13:52:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xtQWb8HhG85u4wsk8TcRUU0J0z1npIHIn5m5jT4r+Oo=;
        b=xzHqjHOUhEEhl/ykL4BVj0SGJYsEfPU0LNJCy91LlRedMEZ5Gm2QGrxo5S/Hc52pvj
         Q7G05HJ2DStDSV3oocnzknAScnyM6vYAXRDDGUm2esBi995bMimseBMojCdOeoodACqw
         SIBtJQfK948wvO+tQiuBbDbF4SUkZ5FbhzSxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=HtnnDIwjECOyKTQ9F0UvLB0jKPnS4dbrrOX6hNhcksgDEqq4gaXF29vCxqYe5sNeff
         xVxVQa64NsQ8Lt1peCmWwMIGj5FprfKotNNMov+Cb+6zT7WMKcCum1TPNaaFogQA4sp9
         QnxBhwZ1Av5DVfdEbZJtwQJeafK9KrD+kSq+Q=
Received: by 10.210.44.12 with SMTP id r12mr9423326ebr.24.1249419164363;
        Tue, 04 Aug 2009 13:52:44 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 10sm674108eyz.31.2009.08.04.13.52.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 13:52:44 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 22:52:41 +0200
Subject: [PATCH 1/5] cpmac: fix wrong MDIO bus identifier
MIME-Version: 1.0
X-UID:	1120
X-Length: 1945
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042252.42254.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the wrong MDIO bus identifier which was
set to 0 unconditionaly, suitable for external switches while
it is actually 1 for PHYs different than external switches
which are autodetected.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index fd5e32c..c951dd4 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -1109,7 +1109,7 @@ static int external_switch;
 static int __devinit cpmac_probe(struct platform_device *pdev)
 {
 	int rc, phy_id;
-	char *mdio_bus_id = "0";
+	char mdio_bus_id[BUS_ID_SIZE];
 	struct resource *mem;
 	struct cpmac_priv *priv;
 	struct net_device *dev;
@@ -1127,7 +1127,7 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 
 	if (phy_id == PHY_MAX_ADDR) {
 		if (external_switch || dumb_switch) {
-			mdio_bus_id = 0; /* fixed phys bus */
+			strncpy(mdio_bus_id, "0", BUS_ID_SIZE); /* fixed phys bus */
 			phy_id = pdev->id;
 		} else {
 			dev_err(&pdev->dev, "no PHY present\n");
@@ -1254,7 +1254,7 @@ int __devinit cpmac_init(void)
 	}
 
 	cpmac_mii->phy_mask = ~(mask | 0x80000000);
-	snprintf(cpmac_mii->id, MII_BUS_ID_SIZE, "0");
+	snprintf(cpmac_mii->id, MII_BUS_ID_SIZE, "1");
 
 	res = mdiobus_register(cpmac_mii);
 	if (res)
