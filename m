Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:08:47 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33314 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008060AbbK3WGeEExyY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 23:06:34 +0100
Received: by pagj16 with SMTP id j16so26828404pag.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HaeSywdGb/y7/AJeheiCF5TJwClDXhxly1fU4bqLtSU=;
        b=yrtNPeWMCRQ1fc1bZLAmeR31d+dgYqAqqV+VWczEUQT2B2BpIkboiUC+Ulrwxem1mh
         3uWsnA79jGpbCaZ2X4kNxX6JO8nTAk4+Ii8Qo7SSFYiWo3KETDoiNIrdmaUPhwbNmpHI
         JaYVqjLGiE0ZooMT+7vzbnMbr63lsku6gYXmrX7Kq/xczRYrWKW9yxOGAJm5xQo6vH3Y
         FbjFf5O0BRqnUmrkcFpH5nW6SfD5TmvrnuPMAAUP+Lq27crL3h0fU7pj/1FW7pmqoUzU
         d3Rl2MM6CRyeegV45c8NtmnuWj5vaFsmh30mG8kLz/KnEhpShJVBFaXqrDBChdIb8ryS
         719w==
X-Received: by 10.98.87.16 with SMTP id l16mr73832250pfb.80.1448921188017;
        Mon, 30 Nov 2015 14:06:28 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id p6sm53253789pfi.20.2015.11.30.14.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:06:27 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v3 07/17] net: ipvlan: use __ethtool_get_ksettings
Date:   Mon, 30 Nov 2015 14:05:45 -0800
Message-Id: <1448921155-24764-8-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50230
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
index a9268db..63b3aa5 100644
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
2.6.0.rc2.230.g3dd15c0
