Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:08:29 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36213 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008923AbbK3WGewS7jY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 23:06:34 +0100
Received: by pabfh17 with SMTP id fh17so26931275pab.3
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8b2JNe369HZ01ilYAMaiBGj5Ilvzj1KPQULqwcETt1Q=;
        b=K6xeWjmGonlrIyY/bWu85bU7vT+KmjQ1KJvZJJ7GpNSpSPQEusEIyGFu6pYBvxCtuM
         5msB1rzeZvqjoMVgsQQCNkg1s3z1KblKqYGBhjzsj9/kG30p8EWSqsqHuJUQHCHyddQY
         lGKKwP1GcNNK5K/+3dE8Fz1vb9jEUrRxXSCiKWKAP0H07fq9RXO2INPUhI5lI9guqXX6
         +G+wgv1y2yI22Rnt5iNQJvI/EGOqub44U7uY4rp0HZOPnVN6PPPsoEqTosJs7xrtqbub
         +uY2aNEHjNtsH7fCjSI0RbCWJ9tUgR9BA/OkyeFgS/v3Vgim1PA9+k2XFroQ1wkzlGet
         t3WA==
X-Received: by 10.66.150.198 with SMTP id uk6mr93646271pab.70.1448921189150;
        Mon, 30 Nov 2015 14:06:29 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id p6sm53253789pfi.20.2015.11.30.14.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:06:28 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v3 08/17] net: macvlan: use __ethtool_get_ksettings
Date:   Mon, 30 Nov 2015 14:05:46 -0800
Message-Id: <1448921155-24764-9-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

From: David Decotigny <decot@googlers.com>

Signed-off-by: David Decotigny <decot@googlers.com>
---
 drivers/net/macvlan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 06c8bfe..a95b793 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -940,12 +940,12 @@ static void macvlan_ethtool_get_drvinfo(struct net_device *dev,
 	strlcpy(drvinfo->version, "0.1", sizeof(drvinfo->version));
 }
 
-static int macvlan_ethtool_get_settings(struct net_device *dev,
-					struct ethtool_cmd *cmd)
+static int macvlan_ethtool_get_ksettings(struct net_device *dev,
+					 struct ethtool_ksettings *cmd)
 {
 	const struct macvlan_dev *vlan = netdev_priv(dev);
 
-	return __ethtool_get_settings(vlan->lowerdev, cmd);
+	return __ethtool_get_ksettings(vlan->lowerdev, cmd);
 }
 
 static netdev_features_t macvlan_fix_features(struct net_device *dev,
@@ -1020,7 +1020,7 @@ static int macvlan_dev_get_iflink(const struct net_device *dev)
 
 static const struct ethtool_ops macvlan_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
-	.get_settings		= macvlan_ethtool_get_settings,
+	.get_ksettings		= macvlan_ethtool_get_ksettings,
 	.get_drvinfo		= macvlan_ethtool_get_drvinfo,
 };
 
-- 
2.6.0.rc2.230.g3dd15c0
