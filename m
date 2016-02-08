Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:14:58 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34052 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012037AbcBHBJv0lEjT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:51 +0100
Received: by mail-pf0-f194.google.com with SMTP id 71so2953795pfv.1
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BC5MVW4fkXbCHPz7AmLsG33g3+VYtluRix3tR64p+Pw=;
        b=voDDHb8Jw/eaRIkDHsnV/tqaCqyJJEzVKicoAe6atHs9uq5TsvKzBwB4rB3SQQxtBK
         fZlwXbiytlsGriZnNMLlMr2UtxURXNIuULt5Dyt6Z9hPHuOhhTypWJtuc4PH0iUvCeJY
         KHYphBxG/ZVgPf52JaJr8Q7nlKHZA/imv/sql1PoDjw0QgkLRZMv6k9+DURASuxUZud/
         ox9+8qQTT0drirthyuwhF33deNo4xDe7ttYpry6wTId3EFY0e2vRSNVzGAANF96ub9B9
         hWGUJW3q5hEOPY6CnPPKtIF7Osm5Ne6FRWI9mPhe7OwMDPci8x4V7imBeGVUmvkUvjWp
         Dz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BC5MVW4fkXbCHPz7AmLsG33g3+VYtluRix3tR64p+Pw=;
        b=iSl2PI71kzQUNYB3mxQ86AyCmP3OQ/gntQN8tfZqMnZhPiXwXhgU8CmhbZ2aJxl1zP
         GkGTdux/YaYhlc7XYQYSBLO2WvwIc9X2ytzL0bEclgBCV9XaXMxl/uy2DUoCDHRnmJFN
         wN4rv7t3z1uXyKaCZaExDM6Y4ji6GRWG0+mJYNr7AtptYLSKRVp5Nefl3Kg/1jlR4wRI
         5TvUEdca1WuXrDoIi0abewichvT9iePA5/BvHPgnITk0s3fcc8QDiJvJSnRtUBC7J7vC
         og0XTkLYnqWuWC0BX1tRGcEnZ+lJUA/xaN678eyfC94TfoKv0krdy0LSPjM9XbFJ56ER
         CxZQ==
X-Gm-Message-State: AG10YORpYBq0u4x9lDfcFRWXaLGG0L902fY0bGugM9t/u6hPgF4uVO8PYO+1rNoK/GRqvA==
X-Received: by 10.98.14.149 with SMTP id 21mr38384290pfo.79.1454893785768;
        Sun, 07 Feb 2016 17:09:45 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:44 -0800 (PST)
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
Subject: [PATCH net-next v7 17/19] net: ethtool: remove unused __ethtool_get_settings
Date:   Sun,  7 Feb 2016 17:09:01 -0800
Message-Id: <1454893743-6285-18-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51838
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
index 669bd78..10e2c48 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -529,7 +529,12 @@ int __ethtool_get_ksettings(struct net_device *dev,
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
 
@@ -699,30 +704,6 @@ static int ethtool_set_ksettings(struct net_device *dev, void __user *useraddr)
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
@@ -764,16 +745,18 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
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
2.7.0.rc3.207.g0ac5344
