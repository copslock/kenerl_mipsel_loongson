Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:12:23 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33368 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011934AbcBHBJnGIwPT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:43 +0100
Received: by mail-pa0-f67.google.com with SMTP id y7so259887paa.0
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHgd2cVF0B0RKo72I38+KPfaN4yuCOO8T9N55q89kC0=;
        b=fTSonsE7Vv73kav8PUMgS4cF2bsYh3ukpZB5LQQ4FOTwB1kLR08zfxuN1q9LsIoOii
         97iAItPBGHAWvsThJEJXoBgliA56u7nOVoG95PBpyQuUHXl5Fxu9dS50IJRx2iuJvmGX
         CVX0wDCECtIoZKiOGwhuyvAEHg/uo27eGUm++8bPlQyCDue5AsrfYOiUM/ho5LiCuZbH
         lNs579zXguyNf1qsKMAeYNjtcluBwk08vFXlmKu7oCn43iZE/K1BuoKmSByDl1svchXh
         b2JKD/0li+CQVXes7Rss23kT5emZp16ERS5DiTgSkiZ/2ajxCukxFm82k5GHB1a+gQNH
         A45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mHgd2cVF0B0RKo72I38+KPfaN4yuCOO8T9N55q89kC0=;
        b=H0ATR+bC0jwy71g+kKgWckwh//8BLizLVmfGKK+MzF3A2cD/6EZmv9atlpvHir+PGu
         8z2wdGody/yuU7oRCKVEGyBSOXHCbC4U3B9is+CP2D4IaOxR1tb1u83rv4FTPVPKs2hF
         73+RQLYQJJAd7Mcnw75GWwKUgOxVvRdEgQg6Ow4lJgkOn8CrsV7+wcyP7JfqUFd8qaDs
         WxIi2yMsKxE5JKjZREPcD6+n7woavxO9NUjAjVFGcGb999CLaXeRWEaqkxpgTDdlL2IU
         VpGR9965rDXKqgmGzhZeIpTdGTN+4h4UNOqhefpDtKo/SyXkBou1bLO0RXIeLvsgcbL9
         yapA==
X-Gm-Message-State: AG10YOTKrtbS1d+rUiBq1CvT6Cevac9aChG5nodKRSGNo+aHJHZPxHrAlTFjBrlrJSUGfw==
X-Received: by 10.66.147.136 with SMTP id tk8mr38523210pab.157.1454893772453;
        Sun, 07 Feb 2016 17:09:32 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:31 -0800 (PST)
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
Subject: [PATCH net-next v7 07/19] net: usnic: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:51 -0800
Message-Id: <1454893743-6285-8-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51830
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
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 1cf19a3..e90dc64 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -324,12 +324,12 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 				struct ib_port_attr *props)
 {
 	struct usnic_ib_dev *us_ibdev = to_usdev(ibdev);
-	struct ethtool_cmd cmd;
+	struct ethtool_ksettings cmd;
 
 	usnic_dbg("\n");
 
 	mutex_lock(&us_ibdev->usdev_lock);
-	__ethtool_get_settings(us_ibdev->netdev, &cmd);
+	__ethtool_get_ksettings(us_ibdev->netdev, &cmd);
 	memset(props, 0, sizeof(*props));
 
 	props->lid = 0;
@@ -353,8 +353,8 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 	props->pkey_tbl_len = 1;
 	props->bad_pkey_cntr = 0;
 	props->qkey_viol_cntr = 0;
-	eth_speed_to_ib_speed(cmd.speed, &props->active_speed,
-				&props->active_width);
+	eth_speed_to_ib_speed(cmd.parent.speed, &props->active_speed,
+			      &props->active_width);
 	props->max_mtu = IB_MTU_4096;
 	props->active_mtu = iboe_get_mtu(us_ibdev->ufdev->mtu);
 	/* Userspace will adjust for hdrs */
-- 
2.7.0.rc3.207.g0ac5344
