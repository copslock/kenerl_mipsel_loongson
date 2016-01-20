Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:47:23 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35776 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014797AbcATAoZrK6bw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:25 +0100
Received: by mail-pf0-f196.google.com with SMTP id 65so13873688pff.2
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFv8Eymip8BrPElJoSIgNx7ZE0qTdjE5TxkxmNk+6yg=;
        b=Ybprftj8IRCZoqnz9LBZk63yG1Zi7ycB7vI4pq1dPptwKg32w+ZLu2M5FjGx5nWmZW
         rRClcC4owNqw73uRtSzH+5LZILGUM0etqIMuzxeffT9tOpMQZNvGwpDloTTMpYMVf4ve
         4J0hNow2SVSX6Y/hwJImnNz96EUV473PUH0CbPYz0g6YawMmXcrqdacsbAOzD+55PaHR
         X4KJCgVREkLHEWLUCWEMs3Q9qmc1GCRwY4/us1jpZjRteA0u+pm0tJjwiep+Ar/P+IIe
         SPhJys1G12e+LqSRYsLeh3nDeCeXKIs75/fpwGrZBKVTvpxTA7UzzhAcbd5sKhKSytBf
         O5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFv8Eymip8BrPElJoSIgNx7ZE0qTdjE5TxkxmNk+6yg=;
        b=W8/tnhGROVM2fga04HE8m/HyeA4AhAS5kzjHIWjj5OdZkDcORqrjrYk6xq8Tel0BBr
         xRzShIJO5EURzZHwSKnKHZDmcjCkd7RvoVpW1pwU5QX+wagHqWW4PiiDNJqaNl9H1L44
         3YdF4y7xHKwhscPN1P9Q11n1pTSIBBHkA9puYTsxtYgo+HSXoEcWJD6kQBVFR6a7uoQK
         AmCLjnf11cqd7dftKj0v2c9wTDV3MpP+PRk1H3ve5BwcRZWNPsHE+yNpMz/4t/OtzmES
         Wu7wtdzJmSAgH/w5zHBbYUxwYTNM4lqRmeLYBr+Rl4OdCg+tsr3PS2VK/fbVups4pQvi
         RLhQ==
X-Gm-Message-State: AG10YOTDNXKRdlgXZEsJ0p2ltoh44bllvOnLzSIy4/b85lzJFAIkE2kX4Kd9Bh4wqkqnAg==
X-Received: by 10.98.40.131 with SMTP id o125mr28019672pfo.83.1453250660159;
        Tue, 19 Jan 2016 16:44:20 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:19 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v6 10/19] net: macvlan: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:55 -0800
Message-Id: <1453250644-14796-11-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51238
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
index 6a57a00..2064eb2 100644
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
2.7.0.rc3.207.g0ac5344
