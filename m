Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:11:48 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32781 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011864AbcBHBJnGq9lT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:43 +0100
Received: by mail-pf0-f195.google.com with SMTP id c10so7615093pfc.0
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0j1t+SKIZ/poZtjnNNa47rUo/uK+LDyZVb8UMVTVCsI=;
        b=RXdBRmuG20Ak2rwoFHJjDLgsaXRaMGNL3rrOkXMx5KTLW+hycRoKQZz0X5lv4g4xCi
         Ih+s+BSxRTnnOdU/Ulj2IXEtgleJ/piclEgUrleqjbSfvYbcRI27aKe5v7RAxvYWA/4E
         xDmq/jS4XJ2kbNdyPFrCH9wg7xwO1udc2eB1Rl6P2HsLe/DrAPcdRZaE4ZFymxn7THNp
         ogOzWlE6TsA/qcSZ8jcNg90cHL0erqUqwE5i8PU7MFAQ9bcUSoAvng9pjjklR6uDC+SI
         RNLN0f8jDujEyxFdnuleLnzoZ6FxnvsxOhTjoXWzxQ3EIfAMlq78hX1NY69dakd0ZYUM
         31sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0j1t+SKIZ/poZtjnNNa47rUo/uK+LDyZVb8UMVTVCsI=;
        b=bGDr4ucbH/n4cJyc9a0TRXJ+YKZNFa60R7fwUeVHHENdz1P/yhbbiC6NOSyzxro5pA
         KwOsvq50ZiDM5OYJ/66+1S6jNwwtxbfTe0EUp+DbEK71c2KxHBzFFG7LWh+RZoch1Js3
         4zRHh76XBla0EkozlUC6vnLbOy+NIXwOQS3+2Qk962hNJ34MAL2TlFi+nPjTzid7Ziqv
         Qtbv+p+yOlCG1K1akB0M11Ah9EG6cwj6n5uMtvwy17kCOp0u2p8mPT+nBv6lnavUQzdZ
         GT435UGI00Gn0F2m8jNHvvK8Wi0flg8TlFkJOo1ObtKOFEkJDkI1eIjN9IkD+dLytW07
         ygDw==
X-Gm-Message-State: AG10YOTCC/WnzfLjdMc5EzGR1QaP/xmRV+Nd64TPhrqdpf9Z+K0N8IgBSMLJoA0I90KBMA==
X-Received: by 10.98.64.202 with SMTP id f71mr38501856pfd.113.1454893775146;
        Sun, 07 Feb 2016 17:09:35 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:34 -0800 (PST)
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
Subject: [PATCH net-next v7 09/19] net: ipvlan: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:53 -0800
Message-Id: <1454893743-6285-10-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51828
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
