Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:02:38 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34191 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013942AbcBXS6ytS1BA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:54 +0100
Received: by mail-pa0-f68.google.com with SMTP id yy13so1388566pab.1
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2cpccZ/cSkKBh9RLdhNU1fsAcsmIbg32s47uQBLJ/kc=;
        b=J53IeriJLp5j1gsA7WFsdG0amP9hWOPrUpcKJHsQK1KzkFpeAn0gLcDSrpRAeVblwx
         +iXlq4sorPIkoFKKmiCjN206e7nCx5WA4sQrmcptJ5J0U2Bb2DCvcuuylfl6u0hpXSLv
         5UZmdsWnH5MremA/ENg3Vl8mUZb8zKlhqoDRRHBaqsBJdPLsfCGdkCgFHL2ZYE/kR3Ql
         UDP+vxHyYmy4YDOxPdPCXXCFpX7H5TadeTLC4KDcsqjEvcN/fYA0FpYf/y5FIaAxFefS
         PlaIs1wNB6lTUm0WO5Nizz3SdYVv2MfWXv9EeED/DdC0HlxDIR/ss0fRuARYBbv2NJTt
         VfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2cpccZ/cSkKBh9RLdhNU1fsAcsmIbg32s47uQBLJ/kc=;
        b=iuK5lt/bhv2pPc4f0oNen3mRkap6C3otCxWx5zXUHBtswM1UvZgUuTOt8pLKsWEd1V
         NxY4pKRY5nOHPf05drUgTgBHUoSt7JfbGwumiPKaEoC71ND8Ik1IfUIWEhHafpYFempc
         Ym/yuBoomMrPt5nNXd3LF1M6utVEypJ9s6/AHdNkHkVjvWk1xGeBN/UfosU6HmeECfew
         m6gvVyB61tNLJ5NZcTTfDtyc0AuQSSktf+jYOn0z4sQAaTjgTwouqaqWlLMSySOqwLXl
         lIT4TipSowWaOWm+QIs6IYXOmK9YuPaU2OOMKN6NmxED2uNzS7QzwNrwCB3m1IzXJq8e
         iOOA==
X-Gm-Message-State: AG10YOTeHCKDV7eY01z8WFD97hBkoLKYL2ixuJFlKW+RliTvZWmDeKpTftkhtJUOVHO4RQ==
X-Received: by 10.66.249.41 with SMTP id yr9mr56966143pac.86.1456340328056;
        Wed, 24 Feb 2016 10:58:48 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:47 -0800 (PST)
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
Subject: [PATCH net-next v9 15/16] net: ethtool: remove unused __ethtool_get_settings
Date:   Wed, 24 Feb 2016 10:58:11 -0800
Message-Id: <1456340292-26003-16-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52220
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

replaced by __ethtool_get_link_ksettings.

Signed-off-by: David Decotigny <decot@googlers.com>
---
 include/linux/ethtool.h |  4 ----
 net/core/ethtool.c      | 45 ++++++++++++++-------------------------------
 2 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8a400a5..e2b7bf2 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -150,10 +150,6 @@ extern int
 __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
 
-/* DEPRECATED, use __ethtool_get_link_ksettings */
-extern int __ethtool_get_settings(struct net_device *dev,
-				  struct ethtool_cmd *cmd);
-
 /**
  * struct ethtool_ops - optional netdev operations
  * @get_settings: DEPRECATED, use %get_link_ksettings/%set_link_ksettings
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index edcec56..2966cd0 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -551,7 +551,12 @@ int __ethtool_get_link_ksettings(struct net_device *dev,
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
 
@@ -729,30 +734,6 @@ static int ethtool_set_link_ksettings(struct net_device *dev,
 	return dev->ethtool_ops->set_link_ksettings(dev, &link_ksettings);
 }
 
-/* Internal kernel helper to query a device ethtool_cmd settings.
- *
- * Note about transition to ethtool_link_settings API: We do not need
- * (or want) this function to support "dev" instances that implement
- * the ethtool_link_settings API as we will update the drivers calling
- * this function to call __ethtool_get_link_ksettings instead, before
- * the first drivers implement ethtool_ops::get_link_ksettings.
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
@@ -796,16 +777,18 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 		/* send a sensible cmd tag back to user */
 		cmd.cmd = ETHTOOL_GSET;
 	} else {
-		int err;
-		/* TODO: return -EOPNOTSUPP when
-		 * ethtool_ops::get_settings disappears internally
-		 */
-
 		/* driver doesn't support %ethtool_link_ksettings
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
