Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:32:13 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33051 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012480AbcBJAaGjHXPx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:06 +0100
Received: by mail-pf0-f195.google.com with SMTP id c10so175462pfc.0
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vb8OXaU3jZ/ngUMICb8p1qwofc19oinYE7RmcMDIOKM=;
        b=QoIDvaCLDHH89M3db5Wh9ZMIUcjLZWdbVfI50Vp41PteXGaDeQt/if5f4yEjhHIOb2
         Tr4+fHH4N2uXIE0VtNqhFt3YtacLhlqUVJn2cK2As+R7D8PT7fHkuaR1wtpc8i+zesFy
         QDSJhDYfoa7qS6guORnBU4JQg9WFkZouEFZibLCV3lJ+RAHTQDc9PBylIFgzbpQ5tksc
         6QazEXZnfqQKzUVUmg1Zb/4Ls/k2zm8Ce1LyaIiBBhilrF2TlgnxLyKe+RoESUCl7AuH
         0VVHUeu2Pafs2bRk7rgQBT83OG+fcfz/P2L2ODBMTpr1SfZfFZorXJe2J/Whd5bRhvlM
         Z27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vb8OXaU3jZ/ngUMICb8p1qwofc19oinYE7RmcMDIOKM=;
        b=d0FoEuq7AOmWOhqvTY2Gc7VHEwnI85l/+ZfDVqjET/8MovDRZaHb9LwEEIuGNceIAQ
         mV+MJa7ijoJDnt1p42al3HR6qsQR0PZ/nNkHb7JeHQYXDKIiPiqkmVh0stkL2wsLuCPY
         U5DWiWAr3Qquqvq9J+UvPYfx8BUw6AXujyEwQJeJ0l6Co5yoSp9S1YEz0OwPKf+Mrua/
         9ZAHnl1IG5zLiiq2IZVDf8X9jv0TkkdTUqRwJ7dsHYv3YHuzCQfh+44KIfnQUX3eYTJx
         Ht3sTnvrXau/pBVJqtwTEwX3jYTLwnX6NMohhZbgj/GdXtnZjaMfWYCDpeXYLG5XiFsl
         kWPg==
X-Gm-Message-State: AG10YOTjtojU/B8qbez4jcAo2BBcU82TaNcMy4qPJnsnju4iC/Gqgsb98RbPtaWB+kQMqA==
X-Received: by 10.98.93.1 with SMTP id r1mr2960002pfb.57.1455064200905;
        Tue, 09 Feb 2016 16:30:00 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:59 -0800 (PST)
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
Subject: [PATCH net-next v8 08/19] net: bonding: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:17 -0800
Message-Id: <1455064168-5102-9-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51946
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
 drivers/net/bonding/bond_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 705cb01..abef2a9 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -374,22 +374,20 @@ down:
 static void bond_update_speed_duplex(struct slave *slave)
 {
 	struct net_device *slave_dev = slave->dev;
-	struct ethtool_cmd ecmd;
-	u32 slave_speed;
+	struct ethtool_ksettings ecmd;
 	int res;
 
 	slave->speed = SPEED_UNKNOWN;
 	slave->duplex = DUPLEX_UNKNOWN;
 
-	res = __ethtool_get_settings(slave_dev, &ecmd);
+	res = __ethtool_get_ksettings(slave_dev, &ecmd);
 	if (res < 0)
 		return;
 
-	slave_speed = ethtool_cmd_speed(&ecmd);
-	if (slave_speed == 0 || slave_speed == ((__u32) -1))
+	if (ecmd.parent.speed == 0 || ecmd.parent.speed == ((__u32)-1))
 		return;
 
-	switch (ecmd.duplex) {
+	switch (ecmd.parent.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
@@ -397,8 +395,8 @@ static void bond_update_speed_duplex(struct slave *slave)
 		return;
 	}
 
-	slave->speed = slave_speed;
-	slave->duplex = ecmd.duplex;
+	slave->speed = ecmd.parent.speed;
+	slave->duplex = ecmd.parent.duplex;
 
 	return;
 }
-- 
2.7.0.rc3.207.g0ac5344
