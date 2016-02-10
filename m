Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:34:48 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33118 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012512AbcBJAaWDp1px (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:22 +0100
Received: by mail-pf0-f194.google.com with SMTP id c10so175750pfc.0
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AmThrRa7bLmY+7KYhHvw7+pO4bpYLUY8nDHj2mgYmM0=;
        b=wGkJ7LMZldhxuoTU1DCWQSLg6peA1MfLI0hco/GCGxU2VUEOmMDV1XeXydB8XFVT8b
         kmXserl0/AVaBDf7fWVjzfweYKqe/SrJsc9mmCY9LS8SpypmERQ2BMTDJiHSroZdFycB
         JeYgZzVb3kgAXekk2cUEwZYlmrTOnC4xpe0wun37aWrZSX5FabWn9XuEHEyRn0Hyd+fL
         uDbHKPKTYyEVY18Xw0K4mEhnOu7prCi2j3SWeOYsPErU4z9G608VR4OH3D0E/jLbrpDF
         3yzJBqV6sDf4t7eC9lx7qImcxGrSU7Fq5axRToWYM6KEtVBUmR4mci28WvGr4xxbmSWB
         DIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AmThrRa7bLmY+7KYhHvw7+pO4bpYLUY8nDHj2mgYmM0=;
        b=eUqrQpbREm8Q4chNmU6WIZpsQjouGZA1D0V8UpCbPuxOyXIqQIM5J5635j1KjICKRf
         hl6zJWun3mK/vBzMu0LdTLBhtZ4aQAzVUbpDRB4pm3Ix+WIRnhjk2+DjdsrUEj37iIJK
         qDsHNJVOU1vFEMJXYsjaHC2K2kyf32QvKtNRUJiRVixVSr/LICejYu8oIitFQtcFklIA
         QS1D1uxHYjgNdE39ggRgoXKQJnbT8Rt92eqLW9MNwLCFBAjpKhgjLs0MGEyt5loYAnZu
         eeDOkXl83+0qepeSnKjDWtHgO5gelrARZlpCllzalcpzK2yoOatl/mnIPuUCKVFXuE/k
         1wRA==
X-Gm-Message-State: AG10YOSiE8q0pQeXk3Rg7MndlWKZn+X2ZebM2K6dF/nrHdNgaRJtOaGiHSNLfG+sVGG7xA==
X-Received: by 10.98.72.24 with SMTP id v24mr53864178pfa.15.1455064216481;
        Tue, 09 Feb 2016 16:30:16 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:15 -0800 (PST)
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
Subject: [PATCH net-next v8 16/19] net: core: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:25 -0800
Message-Id: <1455064168-5102-17-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51954
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
index da7dbc2..b9c8b91 100644
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
