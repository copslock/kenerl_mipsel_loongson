Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:00:38 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34920 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013935AbcBXS6nk3yNA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:43 +0100
Received: by mail-pa0-f67.google.com with SMTP id fl4so1385278pad.2
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VjjhQ9nQgOeNRJtZZz2XiQoA8xBWBteBqa9EWXEs+2c=;
        b=uRjRW2IhKftF2nzQ/5P3dYiuiRlbeWXqKRXT8zMLHsKXFLHsdMdAQ2Iy56qNDJxspy
         +9N5ZxcYVp6rz8/QXOBptlxDS023MmJ0vuaes7bcXLephUH5ZDbjT3r5d++luKlxQJ0j
         1V9yvMRjK/rLNMImJx7PQVGLlfJEs2deuzHM1h7xl7eZPKJssYo1N487PGIOHfQTT20V
         hJDN923AZoNofwmraON+UnreGb0sih8QoEOhQVLmEPxsaumlaccRbiye3Hr/X0zR1vTQ
         qbPI9MJNsBAugVVLR+KRJUipeYJUjcwjg0GtN3IqcFstLFbkJgOR+xXoPyKtqtqgwvde
         d83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VjjhQ9nQgOeNRJtZZz2XiQoA8xBWBteBqa9EWXEs+2c=;
        b=ky3WuGEl7BNAloEQeNXM1JXCFdsvtx/xciV4swcVFVjw1wMB0mLfwJzRpBLTsQFLv6
         clFapbsP9btb2WnoAK3qacH2kxAT/UKPj8w+6jj+kbiDCFpixxotE96DdFLJYOTE25q6
         SsGWWopn6lfP76U21Qv4HQTnNXKoiIYM88hsq/S3nkOyF8DdBWy4sBskEBioQaR38y9p
         ItMVmfNuKS/pHvZsbrjGlfc2yVb5RkI9OhuGGdvBn02EHBI/NTvaCu2AZZC+FB6b98Dk
         3R8RjcbGVOlr2YrX2VE1U63OSmxc0WZozuHKLlSiHHbjRyogGOtWBPejn3o8qJt5ftEL
         QZ6Q==
X-Gm-Message-State: AG10YOQ7fOVb8pCc6JNq/iFa+CUjoqEkLQwEtI2H+qnG1vvRkcahgXfdrr899EqkUn7Wvw==
X-Received: by 10.66.97.101 with SMTP id dz5mr47824688pab.61.1456340318019;
        Wed, 24 Feb 2016 10:58:38 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:37 -0800 (PST)
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
Subject: [PATCH net-next v9 08/16] net: macvlan: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:04 -0800
Message-Id: <1456340292-26003-9-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52213
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
index 426a2cc..6e953e3 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -940,12 +940,12 @@ static void macvlan_ethtool_get_drvinfo(struct net_device *dev,
 	strlcpy(drvinfo->version, "0.1", sizeof(drvinfo->version));
 }
 
-static int macvlan_ethtool_get_settings(struct net_device *dev,
-					struct ethtool_cmd *cmd)
+static int macvlan_ethtool_get_link_ksettings(struct net_device *dev,
+					      struct ethtool_link_ksettings *cmd)
 {
 	const struct macvlan_dev *vlan = netdev_priv(dev);
 
-	return __ethtool_get_settings(vlan->lowerdev, cmd);
+	return __ethtool_get_link_ksettings(vlan->lowerdev, cmd);
 }
 
 static netdev_features_t macvlan_fix_features(struct net_device *dev,
@@ -1020,7 +1020,7 @@ static int macvlan_dev_get_iflink(const struct net_device *dev)
 
 static const struct ethtool_ops macvlan_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
-	.get_settings		= macvlan_ethtool_get_settings,
+	.get_link_ksettings	= macvlan_ethtool_get_link_ksettings,
 	.get_drvinfo		= macvlan_ethtool_get_drvinfo,
 };
 
-- 
2.7.0.rc3.207.g0ac5344
