Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2009 22:53:45 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33516 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493238AbZHDUwz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2009 22:52:55 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so5358211ewy.0
        for <multiple recipients>; Tue, 04 Aug 2009 13:52:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fwNcuhp3fK4B9Pxtb2MokBAolkvEYbexfYGXd63btec=;
        b=w/j2aq0fvjasQYECeYs1HTnT56DcTtJD45OAZRFxBRChC8+AWJoUY0Oqm+SkPUCHEU
         vnxbDTzbELVb6rQzM4f5M1hmZGsJ1D8t1g+k/cdTbz4rNklVXG+lhHmk/V/jv3fpu+TV
         V248m8plRrb2vXIsS7uubVdRRL5okGJszYvz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=duDKoLA3YUkpCLfS5nggebBPWofgP229YQHuVXVuOhStspxfzaySGLVrqTkS5I0a/T
         LlrnAhHBScvUkeuahxyJmDWySDmZg3Ae4Jqs3O9VN8HJgAvNrKqEH5HJIZgtu2Djv/lj
         W+GCYO0afNW57Lcmk+hS7nwcpWLX9FXUCAYC0=
Received: by 10.210.44.12 with SMTP id r12mr9423505ebr.24.1249419174843;
        Tue, 04 Aug 2009 13:52:54 -0700 (PDT)
Received: from florian (135.87.196-77.rev.gaoland.net [77.196.87.135])
        by mx.google.com with ESMTPS id 10sm4361889eyz.21.2009.08.04.13.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 13:52:54 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 4 Aug 2009 22:52:52 +0200
Subject: [PATCH 3/5] cpmac: add support for fixed PHY
MIME-Version: 1.0
X-UID:	1121
X-Length: 2954
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908042252.53068.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds support for fixed PHY connected in MII mode
to cpmac. We allow external and dumb_switch module parameters
to override the PHY detection process since they are always connected
with MDIO bus identifier 0. This lets fixed PHYs to be detected
correctly and be connected to the their corresponding MDIO
bus identifier.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/net/cpmac.c b/drivers/net/cpmac.c
index c951dd4..f2fc722 100644
--- a/drivers/net/cpmac.c
+++ b/drivers/net/cpmac.c
@@ -1117,22 +1117,23 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 
-	for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
-		if (!(pdata->phy_mask & (1 << phy_id)))
-			continue;
-		if (!cpmac_mii->phy_map[phy_id])
-			continue;
-		break;
+	if (external_switch || dumb_switch) {
+		strncpy(mdio_bus_id, "0", BUS_ID_SIZE); /* fixed phys bus */
+		phy_id = pdev->id;
+	} else {
+		for (phy_id = 0; phy_id < PHY_MAX_ADDR; phy_id++) {
+			if (!(pdata->phy_mask & (1 << phy_id)))
+				continue;
+			if (!cpmac_mii->phy_map[phy_id])
+				continue;
+			strncpy(mdio_bus_id, cpmac_mii->id, BUS_ID_SIZE);
+			break;
+		}
 	}
 
 	if (phy_id == PHY_MAX_ADDR) {
-		if (external_switch || dumb_switch) {
-			strncpy(mdio_bus_id, "0", BUS_ID_SIZE); /* fixed phys bus */
-			phy_id = pdev->id;
-		} else {
-			dev_err(&pdev->dev, "no PHY present\n");
-			return -ENODEV;
-		}
+		dev_err(&pdev->dev, "no PHY present\n");
+		return -ENODEV;
 	}
 
 	dev = alloc_etherdev_mq(sizeof(*priv), CPMAC_QUEUES);
@@ -1166,8 +1167,11 @@ static int __devinit cpmac_probe(struct platform_device *pdev)
 	priv->msg_enable = netif_msg_init(debug_level, 0xff);
 	memcpy(dev->dev_addr, pdata->dev_addr, sizeof(dev->dev_addr));
 
-	priv->phy = phy_connect(dev, dev_name(&cpmac_mii->phy_map[phy_id]->dev),
-				&cpmac_adjust_link, 0, PHY_INTERFACE_MODE_MII);
+	snprintf(priv->phy_name, BUS_ID_SIZE, PHY_ID_FMT, mdio_bus_id, phy_id);
+	
+	priv->phy = phy_connect(dev, priv->phy_name, &cpmac_adjust_link, 0,
+						PHY_INTERFACE_MODE_MII);
+
 	if (IS_ERR(priv->phy)) {
 		if (netif_msg_drv(priv))
 			printk(KERN_ERR "%s: Could not attach to PHY\n",
