Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:46:40 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61380 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903648Ab2HUSp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:45:26 +0200
Received: by pbbrq8 with SMTP id rq8so322063pbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NDXuOP3XVTDnd621xVKfXwFApD/xlJu2S7WcCTQUBIM=;
        b=YNxNJHYVkVn+yBIXvgj9acklHsXxxF8yKHG62PwNHKPGU3wrONtfhV/mUFjADplnE3
         lQbTWvDOsnxG2aYOdZ8tq6tHe3mbRvQ220b2vjrs65HrPPiBTrF5E75N+/EeKeA9lwaL
         S/+vinIh5NOE/wBg06m5JFiD0fnVhEUHNkvgPkOHCDKgIAPyLUsZKkjxmoVkZtc9OgNe
         Tfziv15j0RuzS1HUM81XCfdtMLAEvIKzUbF16t1/LbxOyuqPMXYbNid65R+9r55pHBZZ
         m3FB3kdJ01mN6tw7C81oCMmjaoFaSJF9Szk/yNVufotZMQx9fCHOt1hJNXba3v26Shgq
         5I1g==
Received: by 10.68.234.7 with SMTP id ua7mr47033557pbc.91.1345574719514;
        Tue, 21 Aug 2012 11:45:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id th6sm1971474pbc.0.2012.08.21.11.45.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 11:45:18 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q7LIjGfq021503;
        Tue, 21 Aug 2012 11:45:16 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q7LIjG6P021502;
        Tue, 21 Aug 2012 11:45:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 4/8] netdev: octeon_mgmt: Improve ethtool_ops.
Date:   Tue, 21 Aug 2012 11:45:08 -0700
Message-Id: <1345574712-21444-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 34320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Correctly show no link when the interface is down, and return
-EOPNOTSUPP for things that don't work.  This quiets the ethtool
program when run on down interfaces.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/octeon/octeon_mgmt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
index 687a6a0..cf06cf2 100644
--- a/drivers/net/ethernet/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/octeon/octeon_mgmt.c
@@ -1379,7 +1379,7 @@ static int octeon_mgmt_get_settings(struct net_device *netdev,
 	if (p->phydev)
 		return phy_ethtool_gset(p->phydev, cmd);
 
-	return -EINVAL;
+	return -EOPNOTSUPP;
 }
 
 static int octeon_mgmt_set_settings(struct net_device *netdev,
@@ -1393,14 +1393,28 @@ static int octeon_mgmt_set_settings(struct net_device *netdev,
 	if (p->phydev)
 		return phy_ethtool_sset(p->phydev, cmd);
 
-	return -EINVAL;
+	return -EOPNOTSUPP;
+}
+
+static int octeon_mgmt_nway_reset(struct net_device *dev)
+{
+	struct octeon_mgmt *p = netdev_priv(dev);
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (p->phydev)
+		return phy_start_aneg(p->phydev);
+
+	return -EOPNOTSUPP;
 }
 
 static const struct ethtool_ops octeon_mgmt_ethtool_ops = {
 	.get_drvinfo = octeon_mgmt_get_drvinfo,
-	.get_link = ethtool_op_get_link,
 	.get_settings = octeon_mgmt_get_settings,
-	.set_settings = octeon_mgmt_set_settings
+	.set_settings = octeon_mgmt_set_settings,
+	.nway_reset = octeon_mgmt_nway_reset,
+	.get_link = ethtool_op_get_link,
 };
 
 static const struct net_device_ops octeon_mgmt_ops = {
-- 
1.7.11.4
