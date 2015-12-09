Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 19:02:14 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35843 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013555AbbLISA33TyAm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 19:00:29 +0100
Received: by pfbc17 with SMTP id c17so3521900pfb.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 10:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SLZu4wDfPCMLSD0EjTqF5vtk0jmXRpgPD/TdddjYjZI=;
        b=VHAHn4HUrFYzBrcd3zD2VqraS9NXSU17AIf6wBFlTGjGFzKfwkYuyUex9sbksGpawk
         KG8jQljeVYHgyHbVuquAvkthR+X7lJPAuQTcXcmCBi4oNLWmXDBxIIW2Wo4wLQLhoXI1
         jKGqB5YpEUqSz+CIlAKmRxR060eOKSEypzT/G+Q4yOr9gAz0VV6PMGiMbfGeMNC4fefM
         EC6Fg8sbOA3iUHVdkskMt6V/jbEx4hzpw0J2TKnc+exvGGp+ZzuU4O851NvxuZnON7oN
         qvFIgDTNd9ulGm+RdIv4fZn3kBSCURvOs1KGoA52+IwVuoX1E4YpqMXhdkewf2qIX41r
         MtDA==
X-Received: by 10.98.12.20 with SMTP id u20mr65651pfi.71.1449684023835;
        Wed, 09 Dec 2015 10:00:23 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 82sm13056535pfn.76.2015.12.09.10.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 10:00:23 -0800 (PST)
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
Subject: [PATCH net-next v4 07/19] net: usnic: use __ethtool_get_ksettings
Date:   Wed,  9 Dec 2015 09:59:17 -0800
Message-Id: <1449683969-7305-8-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
References: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50496
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
index e082170..e0d12d4 100644
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
2.6.0.rc2.230.g3dd15c0
