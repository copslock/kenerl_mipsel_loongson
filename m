Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:49:10 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34177 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014806AbcATAocoi42w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:32 +0100
Received: by mail-pf0-f193.google.com with SMTP id 65so13872792pfd.1
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zQ1rYGVvGRJZfRUg7fh1a5XOOy4lFP3VjakhqNShtQc=;
        b=fZf9tCnAaCsPsztmY4H/xL367F0IyNEa5tx2aHwVRP2KTJztFeZb12oAYIRI+HVw52
         rJCgR9ItqiReJrDor6GTzfZyliUEA85WXhT6vTZLdaArDKnjD6WEdfcxteaOfKKS5pFP
         8U/2dIYf/YxXHnlkyhKQVCGYIgXpfO8XIchpiTErwS5t1oGFGvWbWdA/6BzsgaEJCP8/
         8H8VbrkufEAjoWPwyXpxOP5LEztsvwncPpq0m5mL5xilNIlZD/4tlrv3RkCCriIk76xk
         i8mZ7dEXF15qi5/YTgoyfGSS/CQK0Uy7PqNbj8xowiiHGdt6mFGSvjXRE1mJCLer3sYR
         i48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zQ1rYGVvGRJZfRUg7fh1a5XOOy4lFP3VjakhqNShtQc=;
        b=dvfkRzDIyseqemeWRS2+Ik3xi0e6EO9GCikG2ydqvxXUr11ndA3nefd9sf5Pex4TEb
         L8VhnGy7ZOrdx0lP2tNH90CxfggLp4q/BMOjwE4q4haWapQRyFpYriqzTTFgZCFoIinN
         wRHM4/H1J235hnMjiQZI/fLYbw9IrDmxkYXnj6/82infISIDUrwGpeqRcGWvGxRZCCiS
         ZRC2OXC41XiEjsLshlYJ71elN8OKYV/2TzFOf0jTNs/NrB75fsyBYcErHnoHd3P5l0wj
         F61bl2pvmn97k/xUovvXe/654KuRbv/jh+ynVJ9QUY+XA+BFOS/lWB9+7kkrt8Fax9ZO
         nAiw==
X-Gm-Message-State: ALoCoQmY/D5dDoKo76Et+0tUY4lzk7QLl5HErVZKrCwc7njm9MqdipHeNvOW84asy2IiMmLIFY8rdZA2djihDoa9meML+EFIpg==
X-Received: by 10.98.71.157 with SMTP id p29mr48260177pfi.45.1453250667112;
        Tue, 19 Jan 2016 16:44:27 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:26 -0800 (PST)
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
Subject: [PATCH net-next v6 16/19] net: core: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:44:01 -0800
Message-Id: <1453250644-14796-17-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51244
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
index b6c8a66..456f3b9 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -199,9 +199,10 @@ static ssize_t speed_show(struct device *dev,
 		return restart_syscall();
 
 	if (netif_running(netdev)) {
-		struct ethtool_cmd cmd;
-		if (!__ethtool_get_settings(netdev, &cmd))
-			ret = sprintf(buf, fmt_dec, ethtool_cmd_speed(&cmd));
+		struct ethtool_ksettings cmd;
+
+		if (!__ethtool_get_ksettings(netdev, &cmd))
+			ret = sprintf(buf, fmt_dec, cmd.parent.speed);
 	}
 	rtnl_unlock();
 	return ret;
@@ -218,10 +219,12 @@ static ssize_t duplex_show(struct device *dev,
 		return restart_syscall();
 
 	if (netif_running(netdev)) {
-		struct ethtool_cmd cmd;
-		if (!__ethtool_get_settings(netdev, &cmd)) {
+		struct ethtool_ksettings cmd;
+
+		if (!__ethtool_get_ksettings(netdev, &cmd)) {
 			const char *duplex;
-			switch (cmd.duplex) {
+
+			switch (cmd.parent.duplex) {
 			case DUPLEX_HALF:
 				duplex = "half";
 				break;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 992396a..626dae0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -557,9 +557,8 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 {
 	struct net_device *dev;
 	unsigned int mbits = 0, msec = 0, div = 0, tmo = 0;
-	struct ethtool_cmd ecmd;
+	struct ethtool_ksettings ecmd;
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
+	err = __ethtool_get_ksettings(dev, &ecmd);
 	rtnl_unlock();
 	if (!err) {
 		/*
 		 * If the link speed is so slow you don't really
 		 * need to worry about perf anyways
 		 */
-		if (speed < SPEED_1000 || speed == SPEED_UNKNOWN) {
+		if (ecmd.parent.speed < SPEED_1000 ||
+		    ecmd.parent.speed == SPEED_UNKNOWN) {
 			return DEFAULT_PRB_RETIRE_TOV;
 		} else {
 			msec = 1;
-			div = speed / 1000;
+			div = ecmd.parent.speed / 1000;
 		}
 	}
 
-- 
2.7.0.rc3.207.g0ac5344
