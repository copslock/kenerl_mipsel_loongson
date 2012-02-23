Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 20:19:55 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:32782 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903635Ab2BWTTt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2012 20:19:49 +0100
Received: by ggnf2 with SMTP id f2so874022ggn.36
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2012 11:19:43 -0800 (PST)
Received-SPF: pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.80.4 as permitted sender) client-ip=10.236.80.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of ddaney.cavm@gmail.com designates 10.236.80.4 as permitted sender) smtp.mail=ddaney.cavm@gmail.com; dkim=pass header.i=ddaney.cavm@gmail.com
Received: from mr.google.com ([10.236.80.4])
        by 10.236.80.4 with SMTP id j4mr5330334yhe.120.1330024783770 (num_hops = 1);
        Thu, 23 Feb 2012 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MvXCEvX6QBI/PM9ko/YHmn0LRck0OPAF5usErf6rxrM=;
        b=PtIXRwltOu1FL4lEZhlY9mgKC+b09CKhgxGh8Hxnf2922fwfjQ7wzSiU3sZeFmZm+M
         hSbc/7rtSdhyt2BDKAu1Uw/mdJu74me4f0feme4rwWDrPEE8MndwZ8ut94W2UG5iiROZ
         2sOL5m6/MR0ytIpfYIO1Dq53yuK0Rl8TrI9iM=
Received: by 10.236.80.4 with SMTP id j4mr4313302yhe.120.1330024783718;
        Thu, 23 Feb 2012 11:19:43 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b73sm2214169yhj.22.2012.02.23.11.19.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 11:19:42 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q1NJJe3M025437;
        Thu, 23 Feb 2012 11:19:40 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q1NJJc8x025426;
        Thu, 23 Feb 2012 11:19:38 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, devel@driverdev.osuosl.org,
        David Daney <david.daney@cavium.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] staging/octeon: Fix PHY binding in octeon-ethernet driver.
Date:   Thu, 23 Feb 2012 11:19:31 -0800
Message-Id: <1330024771-25396-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Commit d6c25be (mdio-octeon: use an unique MDIO bus name.) changed the
names used to refer to MDIO buses.  The ethernet driver must be
changed to match, so that the PHY drivers can be attached.

Cc: Florian Fainelli <florian@openwrt.org>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/staging/octeon/ethernet-mdio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index 63800ba..e31949c 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -164,9 +164,9 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
 
 	int phy_addr = cvmx_helper_board_get_mii_address(priv->port);
 	if (phy_addr != -1) {
-		char phy_id[20];
+		char phy_id[MII_BUS_ID_SIZE + 3];
 
-		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "0", phy_addr);
+		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT, "mdio-octeon-0", phy_addr);
 
 		priv->phydev = phy_connect(dev, phy_id, cvm_oct_adjust_link, 0,
 					PHY_INTERFACE_MODE_GMII);
-- 
1.7.2.3
