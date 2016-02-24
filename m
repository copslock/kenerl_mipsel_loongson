Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:02:19 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34576 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013941AbcBXS6wPm7pA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:52 +0100
Received: by mail-pf0-f196.google.com with SMTP id 71so1457445pfv.1
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GtX1U7QZqXBRWO0vQNwAZ0ItEWrd/JcGOHmo7EAm53c=;
        b=iLsvL+E2+ck6sSzLt3v+eFE5mrLdD+VkdxDGhw1/gXveBJXn0QwGcUzCW4iGyczMwy
         kH3+usK2NxYcQ+X5Wpr4guQc+tCCJj+woK7N3DI9p2ZlfGt0U4IbpAU2i0IqPl7hMH9t
         t/7HzCnD35Xiv1DcVFhk/Np335egkJSU43/3EuBAj8mHvTRgHgIb0uXzPkM9DwA59/d/
         Yt7rBAevQzIuVaWKKsoj0i6geyfZqthGuYLxIN9LN+EUAU5EFqWsZilhzf4y8FLewJ6U
         xQI2YVY86yaBtCyxBwEHaJsrWNOYEzYsExqYtJFiTMQRUWgCw1/OA9/rgqTRwrbVm5Eo
         R7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GtX1U7QZqXBRWO0vQNwAZ0ItEWrd/JcGOHmo7EAm53c=;
        b=kpGOVZupT9ag18Qqu86VODfnjEqN585f1vizI1VNaNbCRjAHvV+g7bAwFb71Mm5Qon
         ruh1jY/aePUAsIbs/1rVl3VpP/Ev9AC/3gtVjQkLRQh/+f68sB7WL/kOy9eAWJ138zBV
         qTJ7RiynQtBJc2gAkgv9OT0SBoppk8Q50cvKeVq/o+7DrV9Z/rSpRKhJVD60G0NlP7uV
         psxtqM+bSGvBDwBbd5TB0glQb/vrvQ6Wxi7fXjpML7cr4BcgkgK6UkjLURDfC2lH/Leg
         jVerMHawV3Kg/ghLkSbKzR4vDq4M45DLKOoj4FjnDASS51wxRjMZSEVDrg0zYU3qvyHb
         2plQ==
X-Gm-Message-State: AG10YORQmOImPd3uythRFhye5n4lfEMw38xE61/UPzOJ1rtk8aFDh/PIPdIwY4YWobRjAg==
X-Received: by 10.98.14.149 with SMTP id 21mr56839627pfo.79.1456340326546;
        Wed, 24 Feb 2016 10:58:46 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:45 -0800 (PST)
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
Subject: [PATCH net-next v9 14/16] net: core: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:10 -0800
Message-Id: <1456340292-26003-15-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52219
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
 net/core/net-sysfs.c   | 15 +++++++++------
 net/packet/af_packet.c | 11 +++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4ae17c3..2b3f76f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -198,9 +198,10 @@ static ssize_t speed_show(struct device *dev,
 		return restart_syscall();
 
 	if (netif_running(netdev)) {
-		struct ethtool_cmd cmd;
-		if (!__ethtool_get_settings(netdev, &cmd))
-			ret = sprintf(buf, fmt_dec, ethtool_cmd_speed(&cmd));
+		struct ethtool_link_ksettings cmd;
+
+		if (!__ethtool_get_link_ksettings(netdev, &cmd))
+			ret = sprintf(buf, fmt_dec, cmd.base.speed);
 	}
 	rtnl_unlock();
 	return ret;
@@ -217,10 +218,12 @@ static ssize_t duplex_show(struct device *dev,
 		return restart_syscall();
 
 	if (netif_running(netdev)) {
-		struct ethtool_cmd cmd;
-		if (!__ethtool_get_settings(netdev, &cmd)) {
+		struct ethtool_link_ksettings cmd;
+
+		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
 			const char *duplex;
-			switch (cmd.duplex) {
+
+			switch (cmd.base.duplex) {
 			case DUPLEX_HALF:
 				duplex = "half";
 				break;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b7e7851..d41b107 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -557,9 +557,8 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 {
 	struct net_device *dev;
 	unsigned int mbits = 0, msec = 0, div = 0, tmo = 0;
-	struct ethtool_cmd ecmd;
+	struct ethtool_link_ksettings ecmd;
 	int err;
-	u32 speed;
 
 	rtnl_lock();
 	dev = __dev_get_by_index(sock_net(&po->sk), po->ifindex);
@@ -567,19 +566,19 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 		rtnl_unlock();
 		return DEFAULT_PRB_RETIRE_TOV;
 	}
-	err = __ethtool_get_settings(dev, &ecmd);
-	speed = ethtool_cmd_speed(&ecmd);
+	err = __ethtool_get_link_ksettings(dev, &ecmd);
 	rtnl_unlock();
 	if (!err) {
 		/*
 		 * If the link speed is so slow you don't really
 		 * need to worry about perf anyways
 		 */
-		if (speed < SPEED_1000 || speed == SPEED_UNKNOWN) {
+		if (ecmd.base.speed < SPEED_1000 ||
+		    ecmd.base.speed == SPEED_UNKNOWN) {
 			return DEFAULT_PRB_RETIRE_TOV;
 		} else {
 			msec = 1;
-			div = speed / 1000;
+			div = ecmd.base.speed / 1000;
 		}
 	}
 
-- 
2.7.0.rc3.207.g0ac5344
