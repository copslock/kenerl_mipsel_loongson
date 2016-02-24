Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:01:46 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36763 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013938AbcBXS6tZFl7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:49 +0100
Received: by mail-pa0-f67.google.com with SMTP id a7so64321pax.3
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYkNU/C465V2lOTBlg2geRwW/BrgobaBgLvom7eM/Os=;
        b=PgVKi9MjfL/rdw9CW+FvaNdROhEDsFEIR36Nf16Wi8bspDDj1urHghPKxrLPF4f1oE
         ZiQt9WjG/zAVw3K6r6DZ3fF0jdGET8cmlYjOrgxey1id+iBc+0mFj9Gbfkwtqqa9qVwp
         1nqQcpIQiUTBPhi8CZiG3L/doGOwfi08iTezRLRJJ/+pZhWWVBdXyCxMVNj7Ttlrh5QA
         PCGBQ33iltdjV/Eh0rmmmI8aWxP/O9IrtY23TpYl17tRcUCi6cWyQDkuDWTMT5rW76gx
         jQ1ulVgcYA6aPDx74BcNezyQy5Mp2A94xpPl3v2NCCHFk7/NrgZQzc7Mh5MrTAnQaVEc
         8Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYkNU/C465V2lOTBlg2geRwW/BrgobaBgLvom7eM/Os=;
        b=TSg2PaTibTsqfR4BYDsqcdP7QVI5H2IUR9nJsyrPJhzYsc90677jlK3OCLf5Yh2Y7V
         RDTnv73PD28XcbgyiELR5ZksxiR1LO+c45dUapLbZrAXVFoIgotdx6wkdsWgHM49ZAcW
         +H1XbUeEG26bGWNccBi47JM3V66tWnx7o8e384CZdyrYBenWnhd94wUhxbCm1hncrc6x
         UBsw+Zqn0zUtIbZ00/bmsHIoR63HpKPPbfpJsRlosx/F//FHL/iL/0GRf10zfqp5M/va
         sfBHX9pR+mQIW6lQeBgKkl/de8bMj6FZs8doQ8Qs2Lri2ILgAS/BbiEwa0Q6ixvcFNxH
         pbWw==
X-Gm-Message-State: AG10YORRncF10ADbiaVzYBdmkcFKiAy7mAqOUDmIysQDgUjMHcsrTFNigEGUmCqm6PFnLQ==
X-Received: by 10.67.7.1 with SMTP id cy1mr57601238pad.123.1456340323757;
        Wed, 24 Feb 2016 10:58:43 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:43 -0800 (PST)
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
Subject: [PATCH net-next v9 12/16] net: 8021q: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:08 -0800
Message-Id: <1456340292-26003-13-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52217
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
index 055f0e9..e416a40 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -621,12 +621,12 @@ static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 	return features;
 }
 
-static int vlan_ethtool_get_settings(struct net_device *dev,
-				     struct ethtool_cmd *cmd)
+static int vlan_ethtool_get_link_ksettings(struct net_device *dev,
+					   struct ethtool_link_ksettings *cmd)
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 
-	return __ethtool_get_settings(vlan->real_dev, cmd);
+	return __ethtool_get_link_ksettings(vlan->real_dev, cmd);
 }
 
 static void vlan_ethtool_get_drvinfo(struct net_device *dev,
@@ -741,7 +741,7 @@ static int vlan_dev_get_iflink(const struct net_device *dev)
 }
 
 static const struct ethtool_ops vlan_ethtool_ops = {
-	.get_settings	        = vlan_ethtool_get_settings,
+	.get_link_ksettings	= vlan_ethtool_get_link_ksettings,
 	.get_drvinfo	        = vlan_ethtool_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ts_info		= vlan_ethtool_get_ts_info,
-- 
2.7.0.rc3.207.g0ac5344
