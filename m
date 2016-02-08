Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:09:55 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36351 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011674AbcBHBJhkw0FT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:37 +0100
Received: by mail-pf0-f193.google.com with SMTP id e127so490656pfe.3
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5rvRaX+snvraiepduGOG338j05vEbZuIxfAxKpZqoz4=;
        b=ryxq73x63xqrLUS+zbqeOb3MwPt+LH349jHU39Wm377yCZlzigDq2cqGe2pVn8p4Sq
         0Wj+sG+g+S+3CPuD9DmxadaQUWmB3X44m7hEEMQMNB6z3Ah/uB2a8/McC7e97yqrjgZS
         JIJkK3nt6s5F5/Es/+AeCS9UaOjH+bHbNuJENdhSKjjTBKLmtzN28c0xy6RFSsDRh+S1
         ++5eNrW+qGM9WhVptU1Dz2/5IK7loXrobENF2/5jURWXNgdGq0qQfpULRpyLgsCe2kmi
         6h68OQG7KWJzB1UivQsEvZvggM8QmyWwiNFcj2nbQ2rDIaoNaclJ8U27KuFonor19Dep
         PHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5rvRaX+snvraiepduGOG338j05vEbZuIxfAxKpZqoz4=;
        b=mgiF0MpZ+C95OkckXBzDFaM0hXXP44cU1ogLtaSyPmJXEjtk00BxtN5aQwYzQsa+0e
         C398YgQV6WfrTgdTdRSfcKYRCnj0VCAejX8X4D7K67+aDnZKF2O41PzYH4rFnK+kwq+g
         E9iv7wH5oP4cCpagiwW2VpKM7YbwtzoRmxYMpdyNhve58uG2tv6Tdx55D/hnU/1SQuOs
         7V7VpFX861sUSSpwXC6rY5sIyo8CNacJAat4GdeX5ZI6c/A3uw97iI/p2LNDvO3AW6jH
         NoUEc5D1yy8rGdyT6CjiDZX5hFrQ1qDonnxD62oCLnXrOsFHTncTlkpnCpFZzHHIC1JZ
         939w==
X-Gm-Message-State: AG10YOSsOKGNqOI4jhAlIbKS6/NTSMgYIhCxUgOdeOjrJS2287eJenxQvcXMPipXDsDQNA==
X-Received: by 10.98.14.69 with SMTP id w66mr38727091pfi.144.1454893767372;
        Sun, 07 Feb 2016 17:09:27 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:26 -0800 (PST)
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
Subject: [PATCH net-next v7 03/19] net: usnic: remove unused call to ethtool_ops::get_settings
Date:   Sun,  7 Feb 2016 17:08:47 -0800
Message-Id: <1454893743-6285-4-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51823
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
