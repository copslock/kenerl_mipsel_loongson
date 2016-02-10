Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:34:10 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35282 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012503AbcBJAaS4ooqx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:18 +0100
Received: by mail-pa0-f66.google.com with SMTP id fl4so158947pad.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LOL/7O92oDMdCLwgtZ6Nnxjn/F9wzzzBmcbxLOF+2CM=;
        b=V3PKOURRX58Mk0FsweN0nnQsYlq7PRIXfWhAn3DAcxERyl3L4R/OjIUtaxnceIIRIC
         +hy0j+xqmpuKDcwi4bjLETRfQ/ZQenHoSkf3cJoCF+YqtzdObmMN8FQIuJiCmUMsLqgZ
         Ib+qTTxG4namZoM4Rwz+/AFFTbMS3cFft91n7Vlw27nIvWtfPAfxxJ8VViFmRKjoiv+g
         z2lkEarWimHKUPvTaXemel5Byj5O/Iwche9UjSoKeEwKhwcPlad5F7mKpOj8gQlWSHP8
         hwjjJCEY4u0HiSmQXGMLg7NxfljNAhHl4jopf59zOBdC4zf3qAR2qobNHUt/bfkLBjqK
         ajJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LOL/7O92oDMdCLwgtZ6Nnxjn/F9wzzzBmcbxLOF+2CM=;
        b=BxPhNS4jaFnNNEhDBanV/cB/pTyijnux74rJ/suRKRQHJTl+997/O0eFFU094hPd6H
         9CbvSZVQmsOxBZ0FAw1qGFREKO0pJYTZHdIPJ1Er5ysZKT25OKcNiB3MZ+mv2+v5UBMS
         n14i6zo4xn+//VfbmCnJTLpGelwYmPwBxleOoHajS2i1+qNqkf2KKqXIfb1wT5egMDX/
         bfko5E9Sr9uiP5f8oRcgQM3mr7l6qHhPMPAieZjPtlWbDMe39G1Ggpg6QEWgG+S0UsGC
         fMefsc2BthnG1ksrIArh0qTu+ghl/mqAaXsEppfs5EkqcWSbj8um8LnsVda7fbVX11nX
         CrQg==
X-Gm-Message-State: AG10YOTJ37iSuW6a/rG5NzXuLJaxiWjE3SWVrSlorqX38doOr1j2VD0+/7NWZcbU7bKrQQ==
X-Received: by 10.66.102.8 with SMTP id fk8mr54402830pab.24.1455064213367;
        Tue, 09 Feb 2016 16:30:13 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:12 -0800 (PST)
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
Subject: [PATCH net-next v8 14/19] net: 8021q: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:23 -0800
Message-Id: <1455064168-5102-15-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51952
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
