Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 19:58:41 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33412 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013924AbcBXS6dTILzA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:33 +0100
Received: by mail-pf0-f196.google.com with SMTP id c10so1453534pfc.0
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5rvRaX+snvraiepduGOG338j05vEbZuIxfAxKpZqoz4=;
        b=cPyBFxOutV6mP+WEpb5qgdxM/sC/LI2XVz518ozWv1/wIofZrAIalJ/Ta3aRwbaopW
         zo8/940VK61DSIU0hhLMPpl6g8GZJbVgJ7IyK+oXQyWa/eBxih60yos9tLXfvWrLao1A
         7vLqAse9s8SllhH5CXZFZ6kKlDsPX+Bjy9gOpo4j2ZFghy/W98XzqdfqOJKH1UCmf/FK
         dkuHH/RMG7t9afjWQEvdz4cDmp2mq+y7shOjFF+Q6rdP6yDij/pTyNDgZuzXb7Dx/R4e
         spS+98OMASef70/ZlfeHjsqxobHVyBRszgPDrq694wh0j6lte/jmaoNEIHmGe3hvNtiO
         oLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5rvRaX+snvraiepduGOG338j05vEbZuIxfAxKpZqoz4=;
        b=d2yz28EzHgWSCbJBRbXxTPwciaSF4k4TVBJZa1cJvvE3/nLM6CiwmhSXq1xvk7AJ8d
         0gVDxkD+i7FszXqpafwgTm4UAi+rGzyYyoMo6XTpRRxGA60FQ4Z7qvRxrdweUUpdCB+o
         XtzWmJu07CTZno7PrPRHxqk7d1HE+oJKzC7A7OJ/rTWI6ifU70iHKg25TtME+cMWZbTZ
         Y9VKBaP+GdVtGX/2ZowJCNmBIjqvfP+k76OzdvH/LTm5XFuQWFnY4rMxZT0fG02nUxA9
         iRRJxk21hyvhhT7wEr3faxP4AEnLCH7WzwOh1+EJYzD6L1KyGSKkrqDYLk9YSD+kVSj6
         KJ6A==
X-Gm-Message-State: AG10YOQI7AImEMZXgyBkjEYKYPWKvop5b2/AWuIkplU2y21sFKGIeuq8gAEfwho/krC1bg==
X-Received: by 10.98.18.207 with SMTP id 76mr56314936pfs.53.1456340307469;
        Wed, 24 Feb 2016 10:58:27 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:26 -0800 (PST)
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
Subject: [PATCH net-next v9 01/16] net: usnic: remove unused call to ethtool_ops::get_settings
Date:   Wed, 24 Feb 2016 10:57:57 -0800
Message-Id: <1456340292-26003-2-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52206
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
index 6cdb4d2..ea003ec 100644
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
