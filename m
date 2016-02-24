Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:00:05 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34906 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013054AbcBXS6kpDhCA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:40 +0100
Received: by mail-pa0-f67.google.com with SMTP id fl4so1385197pad.2
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4e3dLPJUUsfBwhWYcZu41xfQODdQlRr2+VhoIvjUYro=;
        b=ew4whPa7+I7KZdbrB6C2qnZ5adArBFAZ89h/Nkn3sVlLbGgsCWENXt1HuwqpPEEe9F
         dfOgwHhjv0x9to4TkGyEFRsOGBokjXu85+Vr2kJz0pp7s92SLQy4QN01tXIASjldL4Tl
         aC1nTtYHdbkRE1WiZvHlsbmdP4Da8smR5LWJC3m3ugq/04iA1Z41kPQSxRi0bJ4VBnJM
         flLdzfyWLxIh0Z+XB/rcc9+aVk1ry54fOAeU1tmcFLYadVVnMiriYcCaoj5I1TkaPi2d
         hI76obOrR9HeHj6ybRAkVwBKRhIWJ4AzyJIXOaOFfkyaPTLGzCayDQ0jMcSEdpSo8DBL
         RraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4e3dLPJUUsfBwhWYcZu41xfQODdQlRr2+VhoIvjUYro=;
        b=B0L2BgDy5RHJdvBxQwYktOMbPZsNUxWCn8fa/aYT5tLv72RL+zpe5BqrVywMTdC6wl
         WAOTp8NXKz0AWrH5+HBFKHaDxEu4WHx2J8IIvQ5okCBbXQkrmn3V9t8dU+bxDdbwAW0s
         38Q/grXgn7bUeG2zWurauRlKcwKbL0MDQekIHjNuAoOhjz97O9QgstvgamwfKsnQ8BEd
         YAMNpU4aKAZsEO7RCkl460kmKPztvlBjL6yb8XOmVaY3i6Ro6ULr7/dp0KvlP0Pcenjr
         j2vvb/J7Lrnp/qP3qywqCY/lQoo4Hsj0PF7/7O6tWuuynnobUXlkyBvOR5Z+sxsf7iJZ
         Zqfg==
X-Gm-Message-State: AG10YORVvnqrHHZnwrgGDv7HmtHtOvwbWbjyGRj01nzJDCksuXI3xe/hCp4E9i8gsSVTyA==
X-Received: by 10.66.102.37 with SMTP id fl5mr12018071pab.32.1456340315056;
        Wed, 24 Feb 2016 10:58:35 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:34 -0800 (PST)
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
        kan.liang@intel.com, vidya@cumulusnetworks.com,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v9 06/16] net: bonding: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:02 -0800
Message-Id: <1456340292-26003-7-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52211
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
index a6527d5..b6236ff 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -376,22 +376,20 @@ down:
 static void bond_update_speed_duplex(struct slave *slave)
 {
 	struct net_device *slave_dev = slave->dev;
-	struct ethtool_cmd ecmd;
-	u32 slave_speed;
+	struct ethtool_link_ksettings ecmd;
 	int res;
 
 	slave->speed = SPEED_UNKNOWN;
 	slave->duplex = DUPLEX_UNKNOWN;
 
-	res = __ethtool_get_settings(slave_dev, &ecmd);
+	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
 	if (res < 0)
 		return;
 
-	slave_speed = ethtool_cmd_speed(&ecmd);
-	if (slave_speed == 0 || slave_speed == ((__u32) -1))
+	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
 		return;
 
-	switch (ecmd.duplex) {
+	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
@@ -399,8 +397,8 @@ static void bond_update_speed_duplex(struct slave *slave)
 		return;
 	}
 
-	slave->speed = slave_speed;
-	slave->duplex = ecmd.duplex;
+	slave->speed = ecmd.base.speed;
+	slave->duplex = ecmd.base.duplex;
 
 	return;
 }
-- 
2.7.0.rc3.207.g0ac5344
