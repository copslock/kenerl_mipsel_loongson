Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:13:53 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32797 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012001AbcBHBJrPjWiT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:47 +0100
Received: by mail-pf0-f194.google.com with SMTP id c10so7615177pfc.0
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOL/7O92oDMdCLwgtZ6Nnxjn/F9wzzzBmcbxLOF+2CM=;
        b=cc+qaNa+XDeknDFwsUClUbFvgdLrzgBB+a+b+stcQH8jAGVvpF6Vz09CsrPNDpQEy7
         Lk9k8JTH0vZN2gm8SxhJnzM62jt8+IIC2sRy0aWmA42p3h+RTqLcqR1Cr2SlbKAbyubo
         a4ZBNf5NuQW/Kib9L7eNRjhAghMbXwJztKO7gykI+C1eFrpQtl9Va/3GEVe55cdaYPq6
         +EaUJS/MIu4INaaibUSipSFcdRgyJ7Ltt+4Prz9ekwj6tf/NmrctoPvvLD19p7oCN53s
         YE9XNZRnZtUlB4GejDrjD4PrPAdDOimcLgc+SFoqv8f2+o/sN47TUvvP6murDXOH/mwF
         inog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOL/7O92oDMdCLwgtZ6Nnxjn/F9wzzzBmcbxLOF+2CM=;
        b=Y7e3DhbEjTOZmHGxuKE0q8CbLZvqigdXMwbb76CTERxhR9qu39frI1+kFnzKo6Oxi9
         zcslG/t+5sL0r43H/njJGR/+V4795eS0AEkkcnP66m83drvxB/CM5zPmCNcVcDBZoGE5
         0/ftVsxnD5vU4wcW21sXcWHdof4dDiSOz1nKN6ed64wXsTqMRMK7anRT+wIIf9yd0rX/
         whHpeNJmtF8wK2CfLySogzlVfJBVias6Kjx3pZp+PwFynvdGGwHgUd3qp78PgOJH7+lC
         U0psVIQLllGgswQj0b2cnRxOR1uhQLuyMOYJZnZGmXj6yvvCS6o4+7dhhCtGu5awsaER
         qNaw==
X-Gm-Message-State: AG10YOQW+LohE1FTJAeAkGtqyJJjG358zomn2qevrC/7Mp7l3R4vEzsW0/QdX5nl1TMNYA==
X-Received: by 10.98.67.135 with SMTP id l7mr38773606pfi.148.1454893781625;
        Sun, 07 Feb 2016 17:09:41 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:40 -0800 (PST)
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
Subject: [PATCH net-next v7 14/19] net: 8021q: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:58 -0800
Message-Id: <1454893743-6285-15-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51835
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
 net/8021q/vlan_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ad5e2fd..d4a6131 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -621,12 +621,12 @@ static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 	return features;
 }
 
-static int vlan_ethtool_get_settings(struct net_device *dev,
-				     struct ethtool_cmd *cmd)
+static int vlan_ethtool_get_ksettings(struct net_device *dev,
+				      struct ethtool_ksettings *cmd)
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 
-	return __ethtool_get_settings(vlan->real_dev, cmd);
+	return __ethtool_get_ksettings(vlan->real_dev, cmd);
 }
 
 static void vlan_ethtool_get_drvinfo(struct net_device *dev,
@@ -741,7 +741,7 @@ static int vlan_dev_get_iflink(const struct net_device *dev)
 }
 
 static const struct ethtool_ops vlan_ethtool_ops = {
-	.get_settings	        = vlan_ethtool_get_settings,
+	.get_ksettings	        = vlan_ethtool_get_ksettings,
 	.get_drvinfo	        = vlan_ethtool_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ts_info		= vlan_ethtool_get_ts_info,
-- 
2.7.0.rc3.207.g0ac5344
