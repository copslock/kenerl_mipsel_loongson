Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 19:05:15 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34543 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013567AbbLISAm0kLnm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 19:00:42 +0100
Received: by pfu207 with SMTP id 207so3523291pfu.1
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eyP6oNjAenjsmnA8SKP5GY3QL3HFB41mWClJRqX6hLQ=;
        b=lg/ny1U41AVpWVmp2vyFXIuAKh4yqjNtQGwTLvE/8ZDXlbVV6PjAWPOKYaRdwF5OQ2
         W63sjTU093PoCSDBWeyy+y731X6Wr915Rfp1Hr18oMmv1qB1x8tf4T9XNFsbiScUE6bf
         rfGAEHX5XE6dTFiNZ/mgAjMljmcs3WbK7oYKNVwW0ag70IR+y3rbskeiEO6US4b6Z94H
         ncBl+rLyyycEyhD3FGu3H31hIQ0TS16E5usAYST1raW4DkrPAwy+cZa9ZlUdOWHovQOv
         oR/QXBEM3HmPxcV1CLSWQssznU4bZpZfCrI0ahl2UYSjCHFPC48DzZWAP6NCuxQ1HCZW
         p4Mg==
X-Received: by 10.98.2.18 with SMTP id 18mr89482pfc.5.1449684036702;
        Wed, 09 Dec 2015 10:00:36 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 82sm13056535pfn.76.2015.12.09.10.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 10:00:36 -0800 (PST)
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
Subject: [PATCH net-next v4 17/19] net: ethtool: remove unused __ethtool_get_settings
Date:   Wed,  9 Dec 2015 09:59:27 -0800
Message-Id: <1449683969-7305-18-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
References: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50506
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

replaced by __ethtool_get_ksettings.

Signed-off-by: David Decotigny <decot@googlers.com>
---
 include/linux/ethtool.h |  4 ----
 net/core/ethtool.c      | 45 ++++++++++++++-------------------------------
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6077cbb..05d4f0e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -148,10 +148,6 @@ struct ethtool_ksettings {
 extern int __ethtool_get_ksettings(struct net_device *dev,
 				   struct ethtool_ksettings *ksettings);
 
-/* DEPRECATED, use __ethtool_get_ksettings */
-extern int __ethtool_get_settings(struct net_device *dev,
-				  struct ethtool_cmd *cmd);
-
 /**
  * struct ethtool_ops - optional netdev operations
  * @get_settings: DEPRECATED, use %get_ksettings/%set_ksettings
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 4865031..84dca87 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -495,7 +495,12 @@ int __ethtool_get_ksettings(struct net_device *dev,
 	 * legacy %ethtool_cmd API, unless it's not supported either.
 	 * TODO: remove when ethtool_ops::get_settings disappears internally
 	 */
-	err = __ethtool_get_settings(dev, &cmd);
+	if (!dev->ethtool_ops->get_settings)
+		return -EOPNOTSUPP;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd = ETHTOOL_GSET;
+	err = dev->ethtool_ops->get_settings(dev, &cmd);
 	if (err < 0)
 		return err;
 
@@ -652,30 +657,6 @@ static int ethtool_set_ksettings(struct net_device *dev, void __user *useraddr)
 	return dev->ethtool_ops->set_ksettings(dev, &ksettings);
 }
 
-/* Internal kernel helper to query a device ethtool_cmd settings.
- *
- * Note about transition to ethtool_settings API: We do not need (or
- * want) this function to support "dev" instances that implement the
- * ethtool_settings API as we will update the drivers calling this
- * function to call __ethtool_get_ksettings instead, before the first
- * drivers implement ethtool_ops::get_ksettings.
- *
- * TODO 1: at least make this function static when no driver is using it
- * TODO 2: remove when ethtool_ops::get_settings disappears internally
- */
-int __ethtool_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
-{
-	ASSERT_RTNL();
-
-	if (!dev->ethtool_ops->get_settings)
-		return -EOPNOTSUPP;
-
-	memset(cmd, 0, sizeof(struct ethtool_cmd));
-	cmd->cmd = ETHTOOL_GSET;
-	return dev->ethtool_ops->get_settings(dev, cmd);
-}
-EXPORT_SYMBOL(__ethtool_get_settings);
-
 static void
 warn_incomplete_ethtool_legacy_settings_conversion(const char *details)
 {
@@ -717,16 +698,18 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 		/* send a sensible cmd tag back to user */
 		cmd.cmd = ETHTOOL_GSET;
 	} else {
-		int err;
-		/* TODO: return -EOPNOTSUPP when
-		 * ethtool_ops::get_settings disappears internally
-		 */
-
 		/* driver doesn't support %ethtool_ksettings
 		 * API. revert to legacy %ethtool_cmd API, unless it's
 		 * not supported either.
 		 */
-		err = __ethtool_get_settings(dev, &cmd);
+		int err;
+
+		if (!dev->ethtool_ops->get_settings)
+			return -EOPNOTSUPP;
+
+		memset(&cmd, 0, sizeof(cmd));
+		cmd.cmd = ETHTOOL_GSET;
+		err = dev->ethtool_ops->get_settings(dev, &cmd);
 		if (err < 0)
 			return err;
 	}
-- 
2.6.0.rc2.230.g3dd15c0
