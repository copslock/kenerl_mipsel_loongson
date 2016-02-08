Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:14:35 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32803 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012028AbcBHBJtxO1VT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:49 +0100
Received: by mail-pf0-f194.google.com with SMTP id c10so7615209pfc.0
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AmThrRa7bLmY+7KYhHvw7+pO4bpYLUY8nDHj2mgYmM0=;
        b=cA7MsFdnOo2pT8Sd1QDxX7Qefo3BJj0GFJKll8hTvqBObXM7bhWBAvbXIt6Cyg8lw8
         /6REIZNgL4b819UWxWHzOefIWjuoDKBRFBbpgv6G2IMwjCwxHch5nT1jnbKJWNKGeX99
         v0gsVC/wCnlFs6DR9TFTtDTVzv7iXKLiOHJxUz2Jm4US9qQ9MnFeiZU47Ul5lWAeMPWG
         Xj11qoBFsJmmpawOX6gefmAcfB26q0kdCbUtA3JMYDDgOSIXu8vZuKqglWzTD2CcIWOL
         qf+ipWrGMbfLoeB7FbJJpaKfbxQoK03DvwqvAzgVjKpqUVhYT5zzbdlgFsVtJCXlBuc6
         CFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AmThrRa7bLmY+7KYhHvw7+pO4bpYLUY8nDHj2mgYmM0=;
        b=VXkmtAvzx0aH3n2fbdKHgnG+w66Y0tjtxRbhukN7UQ6v99/zdr9N4yBxJ491G5kqf9
         A8AnSD6n+jfdTzMCzcLltA3eNsfp9Mf5qapU4fobXYJTma3qXc+pIGwnt6+7JBzBXS1q
         ndFkI4CgoREiN3fVwM+uq8KXH6vjuERGDSxh6bfzLHfY/xWl46NpEaRk6WtNd0FeN2pI
         zTN1IN7/3lcCLNWDELvIc7DGQFMK/wLKw0QoGXXBQPJpE3/0z68SoUKPlxFtOzG55ej2
         XV46Jth/wWut+5T+2MQhkqKSmqUR9WOwKJi5xjDtdji35elPXB5HuS5GZ3ySyeBBfPtM
         hgkA==
X-Gm-Message-State: AG10YOQxuOCVec5EKSb5E5YrxmOvdro4/A+wLx5KTp1tQJq6OUlJ8dDpkfiliduKgruD+w==
X-Received: by 10.98.10.65 with SMTP id s62mr38667194pfi.119.1454893784256;
        Sun, 07 Feb 2016 17:09:44 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:43 -0800 (PST)
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
Subject: [PATCH net-next v7 16/19] net: core: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:09:00 -0800
Message-Id: <1454893743-6285-17-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51837
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
