Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:31:57 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34111 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011376AbcBJAaDzgODx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:03 +0100
Received: by mail-pf0-f195.google.com with SMTP id 71so173849pfv.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHgd2cVF0B0RKo72I38+KPfaN4yuCOO8T9N55q89kC0=;
        b=qAgubJ+XAd7MW7C+ZSJl/3Ecq7+ysI7e9W/NVr8ytG4qUSgzrjqcNwbA5k9EXM9eZb
         GHoI1yEYbuZnimxYaO5Z+OQPqXP9SJGSyGqEHQmECeKgTwPIjgzQ5wANXnW2v7Cq++6m
         466QdJK1J1lvdH3VCj/wEsAbRVQgyn23cbIdTMU7uEnjbVDzpuSWaVsq4m/TbTPxmGBM
         j7M1mMFWaPwLEZ+e9X/Zxd+gKqlV89cRTQ5eVrap6Ox7CKcnkQVpp4vP8IfwqAChrzP8
         wJ6tvOjcLgMrOWIyUZlgD0iy6Dw5vULSKBEYemGZbbRaxtuvZrMBFedZEQuNrI5lvN7t
         IDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mHgd2cVF0B0RKo72I38+KPfaN4yuCOO8T9N55q89kC0=;
        b=EcxCIzW1giPjJTHjW+6HU6XcuJ3dKd4hY5c1SylJDlogPVueDFicN0YnRAXQeXOoHN
         bjCPSoMKkDBbsRItGWlT3e5tGXqu6pIgHcT79DSAWchqN2wNUAIHGlPNBpXb4Z4hyYXL
         cgKciDSmafIs+vqgxRqngBGxKUIIkC4Itn2/emn/HR+yIpx9VvyCuYq4ssQM0Pe/AkN1
         v2fj8SfTl8u1O1j/cYU4oJmxETw5+C5RbqOBQLtlUFLqtvvXscUNXPOSkRrhmSHE4fS/
         +QFYhQH57GtyVkHO4x3Js1J0N2KQ82IQ0VijnDgXi49GyCWxEOrHE1uTyVcdE0lianIn
         B3fQ==
X-Gm-Message-State: AG10YOQhNUN5kYV3d9H6J0mSfI/OPvHRN//OqsuB+dQxsk9Ub0azxGziIY6mW7QuhHD/NA==
X-Received: by 10.98.66.138 with SMTP id h10mr55349675pfd.89.1455064198319;
        Tue, 09 Feb 2016 16:29:58 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:56 -0800 (PST)
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
Subject: [PATCH net-next v8 07/19] net: usnic: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:16 -0800
Message-Id: <1455064168-5102-8-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51945
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
