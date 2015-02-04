Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 20:54:15 +0100 (CET)
Received: from mail-ie0-f193.google.com ([209.85.223.193]:52018 "EHLO
        mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012477AbbBDTyGd-G7V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 20:54:06 +0100
Received: by mail-ie0-f193.google.com with SMTP id tr6so751891ieb.0
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FTL4oKOY8CQu2+64m5qUVShrDSbHgFUSGI5lYd7s/WI=;
        b=JV91gsMFkqLkRt15Fe1Tzsdp4gz1RpKRKZJ53CthKgxTQyPWRDzR+FqPFiNe3K2RDv
         0h7iJaBjqnVKbJHOq58CQV3A0MkBPGw6826sq8CCicxMDN6p8ewbHAMTUAibIaDyYSfd
         /B0n8VWFRgV2sTj0n/m3QSBhhRk0wL8rIvQf1sy9fnC4DCrMs7BzmPNhHDE7mJJu+clz
         y9DiP42W8jgGRXNU+DzweNTNHgJ8SHbQFCvmVYRhBoySDdK5uFWImchJby2O01Et4tPP
         u/0q7zX4bEdDiTAZQ9eQ7MClOmdihpIePsn16wlSk7C5Emk3i2mXg9fNkXnwhUsu5Kjc
         lKtw==
X-Received: by 10.50.60.72 with SMTP id f8mr26526641igr.31.1423079640301;
        Wed, 04 Feb 2015 11:54:00 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by mx.google.com with ESMTPSA id e70sm1348825ioe.6.2015.02.04.11.53.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Feb 2015 11:53:59 -0800 (PST)
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
        Upinder Malhi <umalhi@cisco.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v2 01/17] net: usnic: remove unused call to ethtool_ops::get_settings
Date:   Wed,  4 Feb 2015 11:53:25 -0800
Message-Id: <1423079621-1374-2-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
References: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45699
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
index 53bd6a2..61337c7c 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -253,13 +253,11 @@ int usnic_ib_query_device(struct ib_device *ibdev,
 	struct usnic_ib_dev *us_ibdev = to_usdev(ibdev);
 	union ib_gid gid;
 	struct ethtool_drvinfo info;
-	struct ethtool_cmd cmd;
 	int qp_per_vf;
 
 	usnic_dbg("\n");
 	mutex_lock(&us_ibdev->usdev_lock);
 	us_ibdev->netdev->ethtool_ops->get_drvinfo(us_ibdev->netdev, &info);
-	us_ibdev->netdev->ethtool_ops->get_settings(us_ibdev->netdev, &cmd);
 	memset(props, 0, sizeof(*props));
 	usnic_mac_ip_to_gid(us_ibdev->ufdev->mac, us_ibdev->ufdev->inaddr,
 			&gid.raw[0]);
-- 
2.2.0.rc0.207.ga3a616c
