Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Feb 2017 22:49:18 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:34271
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdBZVtMQN8h0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Feb 2017 22:49:12 +0100
Received: by mail-wm0-x242.google.com with SMTP id m70so10787277wma.1;
        Sun, 26 Feb 2017 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zg07hfdU3QmuSCMjDVVzfQqvlvyiNN34i4FidKmhHXI=;
        b=D+k09WgmbrpvSQ0D9GW8Uzg8AsMhgLNfOVpsO87jxbuU2BETEKz5vgvw+YTv7GTwcc
         P3Mn5q5CZdhHtFH8PzOmbAXgq/R5ULEsDBLmx/FZImSlYgzwvb0DoVSHDClD7uWSSxel
         P6vPWMdkzKXZ07P/XdSymAIMJlrHb5+i0Bic9UrDpk4qHbfXIP+2MNAha2Z+IDXfAhuP
         molx6FkuTMsu3wZaA/IZ0rIfNR2+zs29/wv2SxVfnzf7UhUgs8GAXsNCFW0CuWuQ+kzv
         duRKq0urVsiG6wmwAXdbnkCzYRl6jCdizhkpYApRJAK+5FPaKE+IVKY7rvbNzoGGXnTe
         CTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zg07hfdU3QmuSCMjDVVzfQqvlvyiNN34i4FidKmhHXI=;
        b=eF8+OnY2MC8fuHOcprX844JLGBTS/rj9SKQmaoNXE6F/ShsjYxTLp0lDmKBiW2FMJW
         P37ueesRanZ7RLzc2lr8bnm+ckjv0WcVAxY7uNzVo/M6ilJyDhbBM3EXltid4Uyt+WI/
         1Xi4zq34id28BQlwiBgWvUqUB07w41nPg4ghRqtleWaOly6L/N9WQX0bg8HqmMQVAYQy
         JWFprBMqKHc53qrciWb17HP6JSE0/odxUDHHrTQGJABTchoCsWOo4f0Ra6OBEABu5qC8
         bD7Nbyl1tqx6v7ts7Q1nreDQzpqusIGyard2+/gV0q9MFV050kXpzanlkGy7Y55H04qo
         9SgA==
X-Gm-Message-State: AMke39nuvlvrXGXdGKk8QEUNxOtRfv97QbEADs/CD8LeTb9HXtj1uuwLVc3j6Qp4UHhQIw==
X-Received: by 10.28.8.213 with SMTP id 204mr11264326wmi.100.1488145745671;
        Sun, 26 Feb 2017 13:49:05 -0800 (PST)
Received: from localhost.localdomain (bny93-7-88-161-33-221.fbx.proxad.net. [88.161.33.221])
        by smtp.gmail.com with ESMTPSA id t195sm3438969wmt.20.2017.02.26.13.49.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Feb 2017 13:49:04 -0800 (PST)
From:   Philippe Reynes <tremyfr@gmail.com>
To:     ralf@linux-mips.org, davem@davemloft.net
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philippe Reynes <tremyfr@gmail.com>
Subject: [PATCH] net: sgi: ioc3-eth: use new api ethtool_{get|set}_link_ksettings
Date:   Sun, 26 Feb 2017 22:48:59 +0100
Message-Id: <1488145739-30614-1-git-send-email-tremyfr@gmail.com>
X-Mailer: git-send-email 1.7.4.4
Return-Path: <tremyfr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tremyfr@gmail.com
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

The ethtool api {get|set}_settings is deprecated.
We move this driver to new api {get|set}_link_ksettings.

As I don't have the hardware, I'd be very pleased if
someone may test this patch.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/net/ethernet/sgi/ioc3-eth.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 57e6cef..52ead55 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1558,25 +1558,27 @@ static void ioc3_get_drvinfo (struct net_device *dev,
 	strlcpy(info->bus_info, pci_name(ip->pdev), sizeof(info->bus_info));
 }
 
-static int ioc3_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int ioc3_get_link_ksettings(struct net_device *dev,
+				   struct ethtool_link_ksettings *cmd)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 	int rc;
 
 	spin_lock_irq(&ip->ioc3_lock);
-	rc = mii_ethtool_gset(&ip->mii, cmd);
+	rc = mii_ethtool_get_link_ksettings(&ip->mii, cmd);
 	spin_unlock_irq(&ip->ioc3_lock);
 
 	return rc;
 }
 
-static int ioc3_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int ioc3_set_link_ksettings(struct net_device *dev,
+				   const struct ethtool_link_ksettings *cmd)
 {
 	struct ioc3_private *ip = netdev_priv(dev);
 	int rc;
 
 	spin_lock_irq(&ip->ioc3_lock);
-	rc = mii_ethtool_sset(&ip->mii, cmd);
+	rc = mii_ethtool_set_link_ksettings(&ip->mii, cmd);
 	spin_unlock_irq(&ip->ioc3_lock);
 
 	return rc;
@@ -1608,10 +1610,10 @@ static u32 ioc3_get_link(struct net_device *dev)
 
 static const struct ethtool_ops ioc3_ethtool_ops = {
 	.get_drvinfo		= ioc3_get_drvinfo,
-	.get_settings		= ioc3_get_settings,
-	.set_settings		= ioc3_set_settings,
 	.nway_reset		= ioc3_nway_reset,
 	.get_link		= ioc3_get_link,
+	.get_link_ksettings	= ioc3_get_link_ksettings,
+	.set_link_ksettings	= ioc3_set_link_ksettings,
 };
 
 static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
1.7.4.4
