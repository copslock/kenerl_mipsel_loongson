Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:47:07 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33586 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014800AbcATAoYk6Xqw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:24 +0100
Received: by mail-pa0-f66.google.com with SMTP id pv5so35633914pac.0
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YqzFUwOOYfvvbbWV3bDRf6OmJBSkZssNbqtiqnmrOzo=;
        b=PhZJjYlXPBhQX9i2NOnbLVUsqaMeJVdnosUxZL+xA/5fMIDPZEpcqZ+YztafKx8Llr
         kloekguDuEqExmYpwXN/Hnue+amJAn5aCyfcOiLOHEglW47UzHfcRf6aoQh+yOysaf8M
         s+kOCi0zx4UYcgraCZ2y27ETz/LydlU5zryTFlSCoZtEKoDUM+BOxYn0eBax6+3kUify
         bhxInuci2XgTc5C0XOluDAFatVuKZLpTFddyxsXUyY/FPtHvtPkLWph7TH84spo38co2
         5kGsoxBy+CTZxz/XYsonZQ+WXvt43ysl0Op12SqnVg6jY+TcTrn2lKvoBmcGoQG4HnV+
         zQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YqzFUwOOYfvvbbWV3bDRf6OmJBSkZssNbqtiqnmrOzo=;
        b=QTc7z1b0fIp1tfhEKnxrWXD7vBlN0BdvwgBrDub068uMMpOXOkk4TlG2fYIjrUo0nh
         ONKicvloqMyI4O6gsK968wjYHJZDhqiir/cPAKXN6XwTHCPvTwyuPsLA0PPwr640stn1
         cxKE/ywgArqkSz+DuGMrn4XmOqfOkakBAd05p5QCYA6eezHyy/BmnE0fBpCDpC74+tsz
         elbi7s0YhhzmX9JsiM9+X23bwpcwDG43bqNPfMK7M9iXgiQHwA5zR48cD1VRG4lDYvre
         s2qxz8ky1hA6MKzJVgMFawY27SpvEvNtMw14e+cf07MYIAIWHeohWuXPYN4xdThfVvaE
         Y3Ow==
X-Gm-Message-State: ALoCoQnYbRqfjXnrVCog6hQv6lRLi5XJlfRrfGlcdgiSzwt+TEvvFqvdMitHkd3PIZ9yZXiS0zjyBcGKSH4lFLcwUD8cAFgaEw==
X-Received: by 10.66.139.234 with SMTP id rb10mr48222795pab.82.1453250658930;
        Tue, 19 Jan 2016 16:44:18 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:18 -0800 (PST)
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
Subject: [PATCH net-next v6 09/19] net: ipvlan: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:54 -0800
Message-Id: <1453250644-14796-10-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51237
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
 drivers/net/ipvlan/ipvlan_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index f94392d..3ea9983 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -346,12 +346,12 @@ static const struct header_ops ipvlan_header_ops = {
 	.cache_update	= eth_header_cache_update,
 };
 
-static int ipvlan_ethtool_get_settings(struct net_device *dev,
-				       struct ethtool_cmd *cmd)
+static int ipvlan_ethtool_get_ksettings(struct net_device *dev,
+					struct ethtool_ksettings *cmd)
 {
 	const struct ipvl_dev *ipvlan = netdev_priv(dev);
 
-	return __ethtool_get_settings(ipvlan->phy_dev, cmd);
+	return __ethtool_get_ksettings(ipvlan->phy_dev, cmd);
 }
 
 static void ipvlan_ethtool_get_drvinfo(struct net_device *dev,
@@ -377,7 +377,7 @@ static void ipvlan_ethtool_set_msglevel(struct net_device *dev, u32 value)
 
 static const struct ethtool_ops ipvlan_ethtool_ops = {
 	.get_link	= ethtool_op_get_link,
-	.get_settings	= ipvlan_ethtool_get_settings,
+	.get_ksettings	= ipvlan_ethtool_get_ksettings,
 	.get_drvinfo	= ipvlan_ethtool_get_drvinfo,
 	.get_msglevel	= ipvlan_ethtool_get_msglevel,
 	.set_msglevel	= ipvlan_ethtool_set_msglevel,
-- 
2.7.0.rc3.207.g0ac5344
