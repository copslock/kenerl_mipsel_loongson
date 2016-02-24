Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:01:31 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36021 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013937AbcBXS6sFD6nA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:48 +0100
Received: by mail-pf0-f194.google.com with SMTP id e127so1452189pfe.3
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHoOpAAgkVeWfdzmDQYYtvXb49xwLeSF/gToLVZcn6U=;
        b=L4oKzKBLrrRipKtHUrtMssZ3aPGCKCX/3aCcB0piqhYT7gmHxvo8JmkfYizkJtspDw
         6Sl8qpI4cNIX/ip4S4isy+0ocnQ+zFIEaVLQxXiaLfTB3A4NipW1+g3GS1+uDZKyAZPf
         AKpzjSESpSwyv7d/rJYExPT7947SKHKnoVj05HWJ+po7IKvb/IN8cjvBNhr5iMNydrM1
         9e9Awy/Y+jc3InpmyH4DeE9JFixBnFRGv+Rtrj6zueRgWeoXoJU0MkHU6aBMAwU7LG/v
         LKD9MzpQTiv9g6pcZknyH1FL007WgBTxvNjf59XI3i0Yac6zlADAJATj73rRDDfGdWJj
         3JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHoOpAAgkVeWfdzmDQYYtvXb49xwLeSF/gToLVZcn6U=;
        b=Qmz+BivLFI5FONKM6tZZWnDROvbnajpe9I9fd7ysIPBFOruefBmnhmTAbJWIavtA6T
         HoSHikg+HDpMnhmgAPidK1aGs32G3fPd5XcJujAL0VeMinStq72MD6frLDR1PS99vy23
         hqML9pghL/rz70jXtuqKeldkFY1yuyaaEMQtzo5i1N5SgjDw7SJwMEhgA4CfGlLNpfYF
         WI/03YEzdOd3dLOhhfw+lPjy6w9mJq7oVGE552JoqAyw4+mS/4rwRI07nuYYMuQaNBgE
         hNiAU4Ijuj1WADgEE4y9IKo+0TJ18sp8quGLQJqCqShJZMwBdgFiyJJKcdZGZqe86Th0
         wrcw==
X-Gm-Message-State: AG10YOSHqX5IcHYBHu0SkEVer+/JVonwV/zJGcHaXMzzFK9/jjywmAczgndETgWybCthIQ==
X-Received: by 10.98.86.13 with SMTP id k13mr46010776pfb.28.1456340322396;
        Wed, 24 Feb 2016 10:58:42 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:41 -0800 (PST)
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
Subject: [PATCH net-next v9 11/16] net: rdma: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:07 -0800
Message-Id: <1456340292-26003-12-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52216
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
index c34c900..931a47b 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -262,24 +262,22 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 
 static inline int iboe_get_rate(struct net_device *dev)
 {
-	struct ethtool_cmd cmd;
-	u32 speed;
+	struct ethtool_link_ksettings cmd;
 	int err;
 
 	rtnl_lock();
-	err = __ethtool_get_settings(dev, &cmd);
+	err = __ethtool_get_link_ksettings(dev, &cmd);
 	rtnl_unlock();
 	if (err)
 		return IB_RATE_PORT_CURRENT;
 
-	speed = ethtool_cmd_speed(&cmd);
-	if (speed >= 40000)
+	if (cmd.base.speed >= 40000)
 		return IB_RATE_40_GBPS;
-	else if (speed >= 30000)
+	else if (cmd.base.speed >= 30000)
 		return IB_RATE_30_GBPS;
-	else if (speed >= 20000)
+	else if (cmd.base.speed >= 20000)
 		return IB_RATE_20_GBPS;
-	else if (speed >= 10000)
+	else if (cmd.base.speed >= 10000)
 		return IB_RATE_10_GBPS;
 	else
 		return IB_RATE_PORT_CURRENT;
-- 
2.7.0.rc3.207.g0ac5344
