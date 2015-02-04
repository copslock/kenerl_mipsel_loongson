Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 20:54:32 +0100 (CET)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:46367 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012478AbbBDTyHSApup (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 20:54:07 +0100
Received: by mail-ig0-f174.google.com with SMTP id b16so37328174igk.1
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 11:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZ4Bwbb89mibL3Sn22QRhvu/FNS6A1dKJehhP3ZN1pE=;
        b=WEc5fQhCDL279wSrQyni+cG8Qdm/uyRZ2iP3pl30HMEKB0ZIw5eOWOltMPvR1w9ZyY
         rJIhGQKr1DoFii6qUM+oqQXQno9vpChzbZbX7AKjL0Sj6NwjeSPisTf/hXPGcbp7yuu5
         ArsHHbBHmyCywaEO9Muz4EEAEaW7xP06mEU9DpaEDvC1c9NUobfR6sbgPVL+AthHSUE1
         fYOzN6t51sVwUVOtziovKZt6JHbs58chS0NEVAsiZbGXP/NymswatE8ArDlpk5yT1ZTf
         aYeEXUonYxaqXh8MzTEvmFwK8fW+1xk8LH+6L45R2wcKA3/BY+VjqG2+OAVpiebGZrS4
         c9QA==
X-Received: by 10.43.92.9 with SMTP id bo9mr3648742icc.54.1423079641903;
        Wed, 04 Feb 2015 11:54:01 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by mx.google.com with ESMTPSA id e70sm1348825ioe.6.2015.02.04.11.54.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Feb 2015 11:54:01 -0800 (PST)
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
Subject: [PATCH net-next v2 02/17] net: usnic: use __ethtool_get_settings
Date:   Wed,  4 Feb 2015 11:53:26 -0800
Message-Id: <1423079621-1374-3-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
References: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45700
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
index 61337c7c..d71ba62 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -310,7 +310,7 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 	usnic_dbg("\n");
 
 	mutex_lock(&us_ibdev->usdev_lock);
-	us_ibdev->netdev->ethtool_ops->get_settings(us_ibdev->netdev, &cmd);
+	__ethtool_get_settings(us_ibdev->netdev, &cmd);
 	memset(props, 0, sizeof(*props));
 
 	props->lid = 0;
-- 
2.2.0.rc0.207.ga3a616c
