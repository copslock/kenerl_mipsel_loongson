Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:32:52 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35153 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012491AbcBJAaJu6nFx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:09 +0100
Received: by mail-pf0-f193.google.com with SMTP id 66so172944pfe.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTYWeEEzjj97eb9ojBPzb/1B0v1RQJrewoXHhvSno6I=;
        b=mhXwJxYIST+0JBTG54ugamMEcb0PNvjD3a3E/RLkeLtEKxktezj5r7+NW6tU0PQ44B
         /Pu/WedT7vBkbayc7Tme6tnOt+GKHgUkjR9oFqh+X7uB1vIoQxBnezypHMYPVwyiJ9I/
         wN48RTXcBKZbW8taAKIojm3h81ON5AIuuQ3WnvfgZPsufclcpCOV+fnRLOyt4kkmrKv5
         J68/j6+hdq5xlk0dNAJuaxOhmgN0JbkVPBKhXWuDpB9C4TJPI4iV9P5ZtUtdJx41Mzvy
         hoN2py064FxQ+0l2Cs93V0gcV3NSZ2eoOXCi3UZhPF4r8vQIQr1jo+uR4lP1ErU2bNN9
         FYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KTYWeEEzjj97eb9ojBPzb/1B0v1RQJrewoXHhvSno6I=;
        b=RcVyDUT9CZFQvN8rWPtFyK1pIcixuN1Z8wTviUejCj1WsEfhvs/somv0QEdp9GK0EN
         FTjJ80f3xCxne/bc/a3IyuytRFiy/vX8Q93c15ytcfbhf+Buwalt47WztBKJ/WH6h4I3
         SgyomDszIGQaa3Z/atDvgJ9ipfDolzACF9/1DyXvfnf6PNlV5Fy16xONMtCP9F6/dLSL
         vJuvcWkZt9VsBFi4rQfDlAdu1MrN6E43Vk7ERsdgayJAouSHQZmjm1JpmV+INfdoui3C
         QhN6tPYF8p2ez0S9OXWr6TtANRi21S+1jQ57WD9R/62y5d9wNbjq4gOnaTBMhV1FYhwD
         yMHQ==
X-Gm-Message-State: AG10YOR1ozYNyfFzGRiicye3yjmj9uJYj5UWiRxzpSs2bsYP41xx2/TpWPgBv46jow3aow==
X-Received: by 10.98.17.208 with SMTP id 77mr53793321pfr.37.1455064204250;
        Tue, 09 Feb 2016 16:30:04 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:03 -0800 (PST)
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
Subject: [PATCH net-next v8 10/19] net: macvlan: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:19 -0800
Message-Id: <1455064168-5102-11-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51948
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
index 94e6888..a54ad4c 100644
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
