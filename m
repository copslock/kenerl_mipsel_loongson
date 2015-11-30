Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:06:34 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34958 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008007AbbK3WG2RTpEY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 23:06:28 +0100
Received: by padhk6 with SMTP id hk6so26756621pad.2
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=foI0qjyVrsfdXTw0dPLkCriM6WBmHBiEyQH0sFdy9pw=;
        b=WzKtjuVIxphaO9qliCuZUm2PRthOy+eErtj3WRZYUH4OHub1uk/ZbCVVkvV3l6bHFc
         j9/9qAD1W6g6eInHSWPmTtROWTakTaB6ez8QN/5YIkETIV9/XEBV1RMMzRgxGEOoOfkF
         F3LNZYz3h0GGJtkW4HB+OXA9rrVINFWcVe2aaHw88BQRz2i+p6rqqMnn1S2caU6nlbNq
         4ouWNr4fiNlibR4T9RP1btzLcq4cOJNWw4+Wz3/kzrE4GTzwm+TldjRO2ErfHSePqSTQ
         eANCh/199+1gjOctTiUbYqVaZ5xCsRuiHEElLafRqJ7AfVX8ZLAEZaDfmgYhXuR692YF
         PFUw==
X-Received: by 10.67.30.168 with SMTP id kf8mr94803210pad.106.1448921181255;
        Mon, 30 Nov 2015 14:06:21 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id p6sm53253789pfi.20.2015.11.30.14.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:06:20 -0800 (PST)
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
Subject: [PATCH net-next v3 01/17] net: usnic: remove unused call to ethtool_ops::get_settings
Date:   Mon, 30 Nov 2015 14:05:39 -0800
Message-Id: <1448921155-24764-2-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50223
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
2.6.0.rc2.230.g3dd15c0
