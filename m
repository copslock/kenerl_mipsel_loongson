Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:45:35 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33559 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014792AbcATAoRkyfhw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:17 +0100
Received: by mail-pa0-f67.google.com with SMTP id pv5so35633791pac.0
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SjqM3n3yi1AT/PZiqB08uVDb4q4yu9XebVlaQXGrl+g=;
        b=mfvln1+CSPlj+Rmk6rcvCU7IwhF0zVc1YEn3M1WD/Cfrk2U6FO7wi12yl+il3tDgHK
         mojoEGwXtgwZssMStaky4AwEE92CuNwQAqBVa7L8Nus6Rp3Oms/Q8uCvz6RnclURfkTE
         bXw6cu+Zl682CB3lFlCIf7tSv56GtZnIS4EaTnovqMjvdnPasqjnGL5tU7U38vKyrdCa
         nD/Zu4bEfnjiSwwzDwDUNIaBn+cOccun0+2OeU7/P55JKtfEvBu12EKjhm++/7gTtDsm
         mzh9cPCH7LzmD4xXq5k5nuETMIXaw714jlLYNcWWc0yAxz7HbqXkrAP4I2Fly9biPSIq
         C3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SjqM3n3yi1AT/PZiqB08uVDb4q4yu9XebVlaQXGrl+g=;
        b=XQfFYX2ABhosZCKeHyiY7iPJN6pUzjLr2YoU4XJQIXxG/bH424wdsajplj5w2kgAk+
         u4suy7HI4BJLHpxAPKbCnrf88iM8Z8Z72mPwOo55ekhgCbiA/XYs5LPsuIm0kIkGDLzb
         fOPfpabmgd6QHlr2Zovzavquo2RWtbl4MCSAl8IgF+xcwMXeE4CNmRaN4SSg3We5We3O
         3vhibadiFVR7LFFL8zvniSVV0EUP00j1Zse2sexc6TJRHoWO8Q8kvFWmu67deAcrPJef
         FFK2iaTM/sXEs+U3KMRzsyMLIjFSceob0OJ4PCMpKTVXL2XFPVfm9D6cnLbvhuYSNNfN
         uTSA==
X-Gm-Message-State: ALoCoQkn/IjHaySAL0ZGQBMw15JgyOEYR2DFruhck2TWSaRz3uF3LMypvFvYvVWdXjsI2aV0vQehYZNSVeMqZxMeOYRJVBWhQg==
X-Received: by 10.66.186.170 with SMTP id fl10mr49317351pac.134.1453250651797;
        Tue, 19 Jan 2016 16:44:11 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:11 -0800 (PST)
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
Subject: [PATCH net-next v6 03/19] net: usnic: remove unused call to ethtool_ops::get_settings
Date:   Tue, 19 Jan 2016 16:43:48 -0800
Message-Id: <1453250644-14796-4-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51232
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
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index f8e3211..5b60579 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -269,7 +269,6 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 	struct usnic_ib_dev *us_ibdev = to_usdev(ibdev);
 	union ib_gid gid;
 	struct ethtool_drvinfo info;
-	struct ethtool_cmd cmd;
 	int qp_per_vf;
 
 	usnic_dbg("\n");
@@ -278,7 +277,6 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 
 	mutex_lock(&us_ibdev->usdev_lock);
 	us_ibdev->netdev->ethtool_ops->get_drvinfo(us_ibdev->netdev, &info);
-	us_ibdev->netdev->ethtool_ops->get_settings(us_ibdev->netdev, &cmd);
 	memset(props, 0, sizeof(*props));
 	usnic_mac_ip_to_gid(us_ibdev->ufdev->mac, us_ibdev->ufdev->inaddr,
 			&gid.raw[0]);
-- 
2.7.0.rc3.207.g0ac5344
