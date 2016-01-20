Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:48:18 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32951 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014803AbcATAobvGntw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:31 +0100
Received: by mail-pf0-f196.google.com with SMTP id e65so13913763pfe.0
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOL/7O92oDMdCLwgtZ6Nnxjn/F9wzzzBmcbxLOF+2CM=;
        b=ZQSgS/HwkSKH0tN4f0wSN9LOgtefuf7TM7+FofwMcXMIui5D/pFP2HpRNwyXyk85sq
         tva3/j9Vv9LF5mlrTMYE2XeXq0Qa4xSqM7IV4tIJkKEAHhEB5576rE7u915gpSJn9s72
         B1IZh1HA1ysV+a8qCoWsyYKV9HfbeYXnsDZiGbNMGdhp9+AKBBEHXZlY0ExeASo88sVW
         sa4Hd2liZElaU0xVSIvlNTMYaYCClN0CqxPi2URv2kiYes/JU5yN7H0R/+/PwMAOPZWl
         FFktqkqwCorWiOdu7bM4lDLKwSvewRaje3goB6kbYlNCD1TkE6NA53f08sy5JHSPVnvV
         3P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOL/7O92oDMdCLwgtZ6Nnxjn/F9wzzzBmcbxLOF+2CM=;
        b=kFmcMBGbaD5OXbydOakGIbZCYvcFKJoPNYDwmQ03HAyZ7ouMBmgScu1GYrQQvfCmdK
         j9G8vAcgheuRm94NwYMwyRcr5lyViwpRkLxFjG0dWrtCxZ7/2JcJeh9UDyzKEu5rFC9L
         R+Y4NAw05itKB3QvnkRwWpR1rExMEPDo4uEoTrqUVloq7KgutihGt+fU5PGZCaqZCk7S
         7KR86ilf2C2O2YdGGEM5rTImsK8nXockWkoiOYksg3OPfW/ZWMdZHMAQqQBXHlRnyGF8
         XXy7Vw6OZFefYjcKrRrBugPunD37UfZh245AKER76eHArLih/f/VAifkYAyM+zIGYYuH
         Yx/w==
X-Gm-Message-State: ALoCoQnmhEzij/2iqdT5+pCQmMGMqBXo/MHr/ntmjHZ8u0fZryqKTdrSR/Lh52SIKFrIzgHJ2QOvAC1Xx1LkT1bIreNcEWQMkA==
X-Received: by 10.98.86.67 with SMTP id k64mr49282407pfb.50.1453250664741;
        Tue, 19 Jan 2016 16:44:24 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:24 -0800 (PST)
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
Subject: [PATCH net-next v6 14/19] net: 8021q: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:59 -0800
Message-Id: <1453250644-14796-15-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51241
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
