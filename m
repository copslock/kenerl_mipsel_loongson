Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:11:02 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32784 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011861AbcBHBJm7L5ZT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:42 +0100
Received: by mail-pf0-f196.google.com with SMTP id c10so7615117pfc.0
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KTYWeEEzjj97eb9ojBPzb/1B0v1RQJrewoXHhvSno6I=;
        b=fNdAA2SMlVU7bIcqCZaeU/0IBiqeSO8QSBN+zgQIrM6xcCanhPN01/qisg03+82tUN
         nJwliTn6l99RbufAYKfPUb5QG28FF8go9YOPT9NfxawuFqvsaPj/Wtz+FLqkhm/ht8fh
         y0mWIw6I6WRQ1nvCpjd6MByQ9VZXu6GUu+cKlYOkaq+u5EwtqCaheR/uqpR6iFOWDe/B
         WzLYuy37m2/T2Uhcy0SBweEF9McRp5UJIzIRRFPlYHtq66UU6W0oxN2z/KpamT+y/mC9
         IC16nH+4iZTZ4IgzGkvEY7j84R5QrY8RtIHtlzGN94RINIP+QAtku9AxC/DYhDmz73iS
         y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KTYWeEEzjj97eb9ojBPzb/1B0v1RQJrewoXHhvSno6I=;
        b=OuWqLxDogbE66motFRcMvXwI+aRUwLMjdnycmNFpK+uQKX74SLL3QBgaCnfdmyGPnN
         J+8Iff9SjCPOegi33nj92YihRIA/OsttaxToHOVwoShGIhicjn5pSyKTUFWvUxNbI6Ri
         spe7PMil2Y1J/bRZ9i1NLCr8OkmT5nUz6m07p+ieq0ydPAzseFLX0tJpRK6oFFGDL7FU
         rxMRR+uLhLht4cfA3uypmDzttEsnuCSmgxNUr93+v1ucs92Cssdii0g2t5VMPmBuI09J
         ye14g2QtzCEvjjEKh+sx/9kW9CvGrsxI3U03gx+s+uEceC+EktSofFutxsWB0MM2qo18
         tB4w==
X-Gm-Message-State: AG10YOTJIxDdAwtcWcTL0MwxwLSpeRqe07nOZv4J1mS8AwMtwVshVeosTaLSvvEI5DtudA==
X-Received: by 10.98.15.19 with SMTP id x19mr38779006pfi.60.1454893776362;
        Sun, 07 Feb 2016 17:09:36 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:35 -0800 (PST)
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
Subject: [PATCH net-next v7 10/19] net: macvlan: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:54 -0800
Message-Id: <1454893743-6285-11-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51826
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
 drivers/net/macvlan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 94e6888..a54ad4c 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -940,12 +940,12 @@ static void macvlan_ethtool_get_drvinfo(struct net_device *dev,
 	strlcpy(drvinfo->version, "0.1", sizeof(drvinfo->version));
 }
 
-static int macvlan_ethtool_get_settings(struct net_device *dev,
-					struct ethtool_cmd *cmd)
+static int macvlan_ethtool_get_ksettings(struct net_device *dev,
+					 struct ethtool_ksettings *cmd)
 {
 	const struct macvlan_dev *vlan = netdev_priv(dev);
 
-	return __ethtool_get_settings(vlan->lowerdev, cmd);
+	return __ethtool_get_ksettings(vlan->lowerdev, cmd);
 }
 
 static netdev_features_t macvlan_fix_features(struct net_device *dev,
@@ -1020,7 +1020,7 @@ static int macvlan_dev_get_iflink(const struct net_device *dev)
 
 static const struct ethtool_ops macvlan_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
-	.get_settings		= macvlan_ethtool_get_settings,
+	.get_ksettings		= macvlan_ethtool_get_ksettings,
 	.get_drvinfo		= macvlan_ethtool_get_drvinfo,
 };
 
-- 
2.7.0.rc3.207.g0ac5344
