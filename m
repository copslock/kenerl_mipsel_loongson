Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:35:10 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35298 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012505AbcBJAaXpy1Ix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:23 +0100
Received: by mail-pa0-f68.google.com with SMTP id fl4so159042pad.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BC5MVW4fkXbCHPz7AmLsG33g3+VYtluRix3tR64p+Pw=;
        b=vl7M9PfZ5TSe/m9xgsp6EYprNAO4NWfEQBgrfXRNAMhfKk7obl3bxdPyharnZ/V+DE
         17/oYn8iA5du40jhQE0JNPHXps7cmVLHt16WzildW+n95/ws3/O8AL/ti958yhSe0Lp1
         tuPmzfVq8ALU3+QOc2FbRdiKSnQxYe/0nE0AE5+CmX0/NNy3Cw960u1A7t6FVVUfXSqm
         sGqzhzeVzvZ9vzLOtNxnXH4DJi+S/6KrnJ/iBzGprZS1VsSt4TQP7LOMglMNnV8vG+wY
         Hj9I/iBtktGLd6TwMZGNXXKPhXao8sZsPQMrb9gOU0gk9aFjtwC3FiwJrauo0fLRyhK2
         tn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BC5MVW4fkXbCHPz7AmLsG33g3+VYtluRix3tR64p+Pw=;
        b=QvtfeVnTEO2N6CDQlgDgxePgm6dmekFSpYSCpwR70XUYCIip+4MBf/6dYMkwyqPpkc
         O+m7NzTSgDFIiJa/1cAPcHV/+eu53VjJ4XZ7Oh66vPYVU/4kGErwp1Bmv6M90h6Q4d2m
         30QzawO7uCxY/dPG45KaK2u++2QkL7ajJToQKK9doCeppz++oJ5U3S2wumfpippYOL2K
         BXz+YuoYOdbOwf/9v1kRuJ5rk2I7OEqman/QgZZ4Jb5SYUl2742j0JL/bXgI3bRSEpdH
         h8/kMLurklZJ7M6GSM7PcRHJTqlww6FXxwep7kMi7/iQWrFN0qW9dxuP6P36EYJ77Vk5
         Q7RQ==
X-Gm-Message-State: AG10YOQvuzVeykFbzira0WuXX+wJAiBJe+i2/GVL3krl5vq4OnDIEdJSJOdZutVfzNx9Lw==
X-Received: by 10.66.90.227 with SMTP id bz3mr1216392pab.121.1455064218160;
        Tue, 09 Feb 2016 16:30:18 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:17 -0800 (PST)
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
Subject: [PATCH net-next v8 17/19] net: ethtool: remove unused __ethtool_get_settings
Date:   Tue,  9 Feb 2016 16:29:26 -0800
Message-Id: <1455064168-5102-18-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51955
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
