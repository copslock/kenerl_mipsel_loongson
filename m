Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:06:56 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36149 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008081AbbK3WG2SM7LY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 23:06:28 +0100
Received: by pabfh17 with SMTP id fh17so26930891pab.3
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/REcK23yGJ7JdkI4eqZvWHNndUFE0N7MWy4yvzwR3sI=;
        b=fstJuZQrnfAhAjdAkcAzeHDnhWvGcSc5HnI8VUYYR7OGdMRyFuWCCOJsXjbM3aZmSr
         Ugw02ub8GsAwKMNcYp/gtcCdbJ/Ypd30IJ3T6fgjqeWaiygdqx5Rclp670KFSxQDt2aM
         0f61qc7cAqjFvdZ9Rnm93aKWUdvdrbdL9vsxcd/tO13P6kY5/GZaJ+uuDV64HbU0Wuug
         dvj5mKUcuvyp5hJKKd1uvV3apCdyQmXy2aztH9q3hcL/Hwgbu+7v69T5UF3qJW9TvBQT
         xu4KHd7fRPPM5AT22j/ybQHFGWKd03xps1FHrudi+6pDkQSRYLaE5lLrimW9d0E4WXqR
         eSVg==
X-Received: by 10.66.142.136 with SMTP id rw8mr94772799pab.36.1448921182361;
        Mon, 30 Nov 2015 14:06:22 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id p6sm53253789pfi.20.2015.11.30.14.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:06:21 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v3 02/17] net: usnic: use __ethtool_get_settings
Date:   Mon, 30 Nov 2015 14:05:40 -0800
Message-Id: <1448921155-24764-3-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50224
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
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 5b60579..e082170 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -329,7 +329,7 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 	usnic_dbg("\n");
 
 	mutex_lock(&us_ibdev->usdev_lock);
-	us_ibdev->netdev->ethtool_ops->get_settings(us_ibdev->netdev, &cmd);
+	__ethtool_get_settings(us_ibdev->netdev, &cmd);
 	memset(props, 0, sizeof(*props));
 
 	props->lid = 0;
-- 
2.6.0.rc2.230.g3dd15c0
