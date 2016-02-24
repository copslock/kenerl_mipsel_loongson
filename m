Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:00:23 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33636 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013932AbcBXS6mMvw9A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:42 +0100
Received: by mail-pa0-f65.google.com with SMTP id y7so1392999paa.0
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FcoWEA/KZmoB1mhwbkN5H5Mwe6es3+hKgOx72zVdePA=;
        b=xUYitur+ZomIvkvFfvZyX4O/W7fLHXPLqNDr0oyU8RzZaBEmL8SN1wyX6v3DKVNTMS
         75yuG7vH674Dy3aet2EFNLVMHFyv9dODly30AdUCtTiOwX7iyuYoberJV2jao1RMCuHc
         JxhM1xhBF5U6z9tdxxsEZsFofzTpxLYjy3reQ57XPOnXCcoO2tYXm4iRK88EL8Sp8Cvn
         3gWFYBKzi+tMlThK9IB8PKO4/oeVIAg+4NYIwxfW2YUarScwzNN0DCtEF/xlBEnhTtDf
         n9XS7FoMYKQ8vHuVoUlSBD2/O+gS1y4jGo4dbjDMl0Mo+F3vCt4XZgwUUN15lwOyqZbr
         1U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FcoWEA/KZmoB1mhwbkN5H5Mwe6es3+hKgOx72zVdePA=;
        b=W9Z38CunQvn++VBlYaWpNO4BqgjUyVvqS797BSrFF1B8MKT6oxJ7q4uOUgWVNK8vFL
         0Dgvkm6eiIkepZvqHHbnthhi/JjA6FUP6oNBvzES8QWJvDslv0z4FDYG/ftqPSjcj4Yz
         V98Zlk7YXewmX2m7sf5nyZN/veZReuzj/c7SFBUXKQQGrcFuFv5a9gQYEE7D1E9crYzX
         J7oPcta7/ubytqiRtvjGwaCrx1zDKNBoTmcYaj4vljC4mZiVk/cSs7PMdpUbtTNNwlR+
         aXHGAaG8T2eDBt+QZ2qi6t+8EZ8j9OCaOnMEA3zLV0eyr41ms9GlBEvG+k/i2QMuy0tJ
         m5gg==
X-Gm-Message-State: AG10YOQQXcwOCqdYf/5SBb61gYFsapQPrqQk/62f5yyhwSo16607MQ367aSFfwL9kxpoJg==
X-Received: by 10.66.122.3 with SMTP id lo3mr56435543pab.25.1456340316559;
        Wed, 24 Feb 2016 10:58:36 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:35 -0800 (PST)
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
Subject: [PATCH net-next v9 07/16] net: ipvlan: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:03 -0800
Message-Id: <1456340292-26003-8-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52212
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
index a7ca1c5..5802b90 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -346,12 +346,12 @@ static const struct header_ops ipvlan_header_ops = {
 	.cache_update	= eth_header_cache_update,
 };
 
-static int ipvlan_ethtool_get_settings(struct net_device *dev,
-				       struct ethtool_cmd *cmd)
+static int ipvlan_ethtool_get_link_ksettings(struct net_device *dev,
+					     struct ethtool_link_ksettings *cmd)
 {
 	const struct ipvl_dev *ipvlan = netdev_priv(dev);
 
-	return __ethtool_get_settings(ipvlan->phy_dev, cmd);
+	return __ethtool_get_link_ksettings(ipvlan->phy_dev, cmd);
 }
 
 static void ipvlan_ethtool_get_drvinfo(struct net_device *dev,
@@ -377,7 +377,7 @@ static void ipvlan_ethtool_set_msglevel(struct net_device *dev, u32 value)
 
 static const struct ethtool_ops ipvlan_ethtool_ops = {
 	.get_link	= ethtool_op_get_link,
-	.get_settings	= ipvlan_ethtool_get_settings,
+	.get_link_ksettings	= ipvlan_ethtool_get_link_ksettings,
 	.get_drvinfo	= ipvlan_ethtool_get_drvinfo,
 	.get_msglevel	= ipvlan_ethtool_get_msglevel,
 	.set_msglevel	= ipvlan_ethtool_set_msglevel,
-- 
2.7.0.rc3.207.g0ac5344
