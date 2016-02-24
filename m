Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 19:59:49 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35969 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013930AbcBXS6jKAeWA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:39 +0100
Received: by mail-pf0-f193.google.com with SMTP id e127so1451990pfe.3
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C87hp26EAOXO4eg4qnGWIFEHLssSnIXXYKwIoDEJQO0=;
        b=Ap6iONjLndDqTIVBhGFKEj/eySYcQjYfIh+XHmW4fXztSmg44zkB6SkW719eVNPqiM
         vaKyvq3vUfT/eQ7XCXpHt5tJ6xYZ4/pDapSA7+FL8qrEOX8mrKrkgx8JUnn5Y8cLo6j4
         LjuKq8k3b2cShYEcjDywM2T0gZkX+ve3Q4k13o3sbkQG2vsGXqsIuExdJXRrMhIEctkq
         kDZ3KIdABKwZRpqEThmlkVtcUCjPD1ZiaLYfqW7YuyEqXbzi+gL4HKci0QvlUmA9mY5g
         rMeaTmdIT8WRCnJCUwhh/bF1mlHxwRLr+txRQyITPbo51GJJZGiaXYYgGjU/kDHmUsdQ
         hR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C87hp26EAOXO4eg4qnGWIFEHLssSnIXXYKwIoDEJQO0=;
        b=Fyt0Q0Yooks2min2DAMqRfOLAIbBSMKy8mRziqU6luN0de0IZkZF36gf9IJtiSXTKu
         XCSDXOEvNXqltiJ27bxafphCp8VJ2QyyiiAjRIGdrpxvu6Z8d0J8L0Mw1FVYk6iiEMOn
         lOAowv6gAiNGtNqY1paYo3WjNPr6HVXvtIbOKcTSsJwkB00iZh2lJ+XxWDlq0QDYNV1k
         adwA0bnwgwrWZxSLu2o5ggWLcFB90UE+OZQcn2IiBeYDnTKWqZfOZhmQ7y0v9xt5/8eh
         s1b9pFVMctPwFBqcSXMW4u+OV1QnTEhhMHcHhE3EY7t+xDOTL6kYwKBotaeSIoRdZMbA
         qXMw==
X-Gm-Message-State: AG10YORTTs7XhR0Zk9VRsC4lCuJyfhooMrg4re+9r4yIkC5xTL9v2SeD5Y8bGGUr4kbyoQ==
X-Received: by 10.98.43.194 with SMTP id r185mr56995506pfr.24.1456340313511;
        Wed, 24 Feb 2016 10:58:33 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:32 -0800 (PST)
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
Subject: [PATCH net-next v9 05/16] net: usnic: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:01 -0800
Message-Id: <1456340292-26003-6-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52210
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
index 1cf19a3..a5bfbba 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -324,12 +324,12 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 				struct ib_port_attr *props)
 {
 	struct usnic_ib_dev *us_ibdev = to_usdev(ibdev);
-	struct ethtool_cmd cmd;
+	struct ethtool_link_ksettings cmd;
 
 	usnic_dbg("\n");
 
 	mutex_lock(&us_ibdev->usdev_lock);
-	__ethtool_get_settings(us_ibdev->netdev, &cmd);
+	__ethtool_get_link_ksettings(us_ibdev->netdev, &cmd);
 	memset(props, 0, sizeof(*props));
 
 	props->lid = 0;
@@ -353,8 +353,8 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 	props->pkey_tbl_len = 1;
 	props->bad_pkey_cntr = 0;
 	props->qkey_viol_cntr = 0;
-	eth_speed_to_ib_speed(cmd.speed, &props->active_speed,
-				&props->active_width);
+	eth_speed_to_ib_speed(cmd.base.speed, &props->active_speed,
+			      &props->active_width);
 	props->max_mtu = IB_MTU_4096;
 	props->active_mtu = iboe_get_mtu(us_ibdev->ufdev->mtu);
 	/* Userspace will adjust for hdrs */
-- 
2.7.0.rc3.207.g0ac5344
