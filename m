Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 20:56:15 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33403 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012516AbbBDTyRRd3jK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 20:54:17 +0100
Received: by mail-ie0-f179.google.com with SMTP id x19so4783234ier.10
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVv9HdDcMACJKEbiKbzLQWTvmO/GllgcjiCLXTYi9ek=;
        b=X+9biscWvQCGe9hl9+jxrVlsd2ppdY7X5AftBxBHbthknf13DimwULXrD44kDNLLQB
         Ne3T5ByXoiLIRU5VoF4vbIV1BayJzvbub7csX207pN4+tDgyHLjJOoXYQKSdFGHcJf92
         uZqoQMio7jf7jOsxMCvbSH6LPJtc24cizhWEgKTN1ZKDQJYwwgRkon0pY9SQXxGRoye8
         mES3J+Rauj3Ln9Qdk3Er0qz3rP0A0VLi75mTQ8j0r7uHA0tnnj4ZFHA4R/B+dGtDb1rV
         m91bEqlNxuoQLGXfhJPznmp4LxjcR0MzuwZvsz/OB8xxjCBJevvO4LgXckiDr3pKUUDJ
         edvQ==
X-Received: by 10.107.152.137 with SMTP id a131mr85792ioe.14.1423079651914;
        Wed, 04 Feb 2015 11:54:11 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by mx.google.com with ESMTPSA id e70sm1348825ioe.6.2015.02.04.11.54.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Feb 2015 11:54:11 -0800 (PST)
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
        Upinder Malhi <umalhi@cisco.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v2 08/17] net: macvlan: use __ethtool_get_ksettings
Date:   Wed,  4 Feb 2015 11:53:32 -0800
Message-Id: <1423079621-1374-9-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
References: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45706
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
index 1df38bd..ce934c3 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -925,12 +925,12 @@ static void macvlan_ethtool_get_drvinfo(struct net_device *dev,
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
@@ -998,7 +998,7 @@ static void macvlan_dev_netpoll_cleanup(struct net_device *dev)
 
 static const struct ethtool_ops macvlan_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
-	.get_settings		= macvlan_ethtool_get_settings,
+	.get_ksettings		= macvlan_ethtool_get_ksettings,
 	.get_drvinfo		= macvlan_ethtool_get_drvinfo,
 };
 
-- 
2.2.0.rc0.207.ga3a616c
