Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 19:04:00 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35881 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013564AbbLISAhe61Om (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 19:00:37 +0100
Received: by pfbc17 with SMTP id c17so3522091pfb.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 10:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUlwB4qrbLFrCSqynrfBIefqDqFARwUXcbBAgHj2CsM=;
        b=cOgG8SrZG3hiagASVxZtmS8cEZ6Y6NetHrRx0YIg3solTOCdidflcknXBZDaCWTiLn
         AD2HpHSsUXgvXXP8/NMyVqWiA3HiV54YWQu94hfJbHaHEjOAoA8neMstzk0VLeNNtQJN
         rsE6wWVtPbbf7WJvJ9ZxFm0RPbCxsrvT58FlDiD7Cn5E3jpMrQBjBRALeoLbOBRlgGba
         Rx02rKc2vHUwMPC0ibjlyOgkcUHUKKXNWHVtfDTehbq1q18upaVK+XeFTzfsA9Z58SV0
         BxtqtGPXGKZvM+5LO/u7lKiSejRG9bIw5QD5nxOHJS6PdjUfyYdfh/lElziK7te2GD4f
         sqWg==
X-Received: by 10.98.17.152 with SMTP id 24mr79621pfr.41.1449684031631;
        Wed, 09 Dec 2015 10:00:31 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 82sm13056535pfn.76.2015.12.09.10.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 10:00:31 -0800 (PST)
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
Subject: [PATCH net-next v4 13/19] net: rdma: use __ethtool_get_ksettings
Date:   Wed,  9 Dec 2015 09:59:23 -0800
Message-Id: <1449683969-7305-14-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
References: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50502
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
 include/rdma/ib_addr.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index 1152859..1820f26 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -254,24 +254,22 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 
 static inline int iboe_get_rate(struct net_device *dev)
 {
-	struct ethtool_cmd cmd;
-	u32 speed;
+	struct ethtool_ksettings cmd;
 	int err;
 
 	rtnl_lock();
-	err = __ethtool_get_settings(dev, &cmd);
+	err = __ethtool_get_ksettings(dev, &cmd);
 	rtnl_unlock();
 	if (err)
 		return IB_RATE_PORT_CURRENT;
 
-	speed = ethtool_cmd_speed(&cmd);
-	if (speed >= 40000)
+	if (cmd.parent.speed >= 40000)
 		return IB_RATE_40_GBPS;
-	else if (speed >= 30000)
+	else if (cmd.parent.speed >= 30000)
 		return IB_RATE_30_GBPS;
-	else if (speed >= 20000)
+	else if (cmd.parent.speed >= 20000)
 		return IB_RATE_20_GBPS;
-	else if (speed >= 10000)
+	else if (cmd.parent.speed >= 10000)
 		return IB_RATE_10_GBPS;
 	else
 		return IB_RATE_PORT_CURRENT;
-- 
2.6.0.rc2.230.g3dd15c0
