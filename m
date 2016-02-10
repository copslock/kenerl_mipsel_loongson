Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:32:36 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33058 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012487AbcBJAaIOYQ4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:08 +0100
Received: by mail-pf0-f193.google.com with SMTP id c10so175493pfc.0
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0j1t+SKIZ/poZtjnNNa47rUo/uK+LDyZVb8UMVTVCsI=;
        b=P0uEFWQtGVjva0lM4hypQoxvLJ+lK4zfG1ZjOo2z1GNuNc4EaviPZVHS/y/kLeAWwu
         pwsW1HrVQBXs/TWb7wl351E7HNNkko7Yfq93EtFbg3540M/pTj8xEiGKeXUYtqsa+ufX
         9rHtPX6bDLKiWB8EtUCS4OSk3JN+xYlOe601nkWs+wpaeIEiDVh+XJowv1RnmJF8vXuj
         mp3RDWAgeFGG9kfaDCRca/xXSWhItQrnZ78mH7uu6wDquAkYF4jeplREzPs7IfgxDqyb
         2D8m72U6Oo58yPIrKUCb/kOkcF+fIobvGyHFzvFFxaQDp3hYDeqdgxug94D4ByYG8q1b
         P+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0j1t+SKIZ/poZtjnNNa47rUo/uK+LDyZVb8UMVTVCsI=;
        b=hpaIwzPVwdA9oBrCIfG70YFWtHdDxMMTBVdx0qQDRRHkTvMgHrtKaLw2PAKev8mP6n
         x2NRcI+2k+yWRgCpbX8xby78GOJDR1Sws+j3E/iI6YIr2z7ZG92cj3SrBopIMp62v0wT
         zQ3kIegLmgY7i+ei4rIayothoniYxUmNJFAA/mcaGbst6XI8SVjwY3s5zrrAbyIB8Egr
         tYCvqSC8yk9CxzCcU7WudkXSdTZGAnD/uyN3sLMECkUB2PsW1h+y/nvg9HW7gKT+qT81
         YYZm0tQCZ3K4GmjyZmj6ECPfUi/0uNDglq57+sAbqUO5m+6qPqwg7Trf4/DzKNO6B4Zc
         YLVA==
X-Gm-Message-State: AG10YOQ8oEdEj1/AePEDjiGFstmtY3eDPg95MwmE6d+uku03E1x3IXGPJCAsNN2Xnrl6Pg==
X-Received: by 10.98.10.86 with SMTP id s83mr37351104pfi.85.1455064202613;
        Tue, 09 Feb 2016 16:30:02 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:01 -0800 (PST)
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
Subject: [PATCH net-next v8 09/19] net: ipvlan: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:18 -0800
Message-Id: <1455064168-5102-10-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51947
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
index 7a3b414..9703610 100644
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
