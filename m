Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:45:17 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35384 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014793AbcATAoSjXMEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:18 +0100
Received: by mail-pa0-f66.google.com with SMTP id gi1so41971294pac.2
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0b2NB8Neq9YbgfIGNg2Fnawu1+aEU+dLPb7K9khusm4=;
        b=X9J8v1DgKYtLKz6+pR18MeFtcKBj16Kp41gG2SZRG6wgSKUo4q9DYr1yDWq/TRdsUV
         WQ23sBdqs4UlJs4bY5HpzDCbQIGLWGz28j29Tbasb7REkcXeVKY1EETGJOOcVRBp2vfz
         TBpN1USQk7b2QiEBjs/SgYd14OLPOTnqvqeyFDscn6+YMjSH1qP9MYj8qwtll2u37iyn
         LjKlGlWkG38lfjhBypyfZZ939p/4wDZcPUsFwTW5SW2FEb0c5pq9+hq0V62OI5oNkPt8
         XMNd0B9ZVKaXPxS8RKN+xfCS+Z8nTIxKFVZo7fZ5uIMIX0dEQSAn4Lbp1uGqYkT4v8Bo
         vU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0b2NB8Neq9YbgfIGNg2Fnawu1+aEU+dLPb7K9khusm4=;
        b=m0N9qE10rwDd6InucB0Qz0VHmKAYMqtutKeiBw8/YI2jSToHcQ4qTsjoKDq0yZsfL6
         zrbLap9W7y8EzXcp7iIeDi0WeUo4pZDJuj4huNfmyM03GUjkAFz5GDZ9n08PqZ9+ppwR
         Vah4ZQWMzTZZT1qQZEBJDl+XRtzSmK5db92xERk5E5UKQtZgIsEGFUt/NkzCGkS0rCys
         t+/Y1GU/FuWnNhLwRFP93d5GgldfvhcJDipe71CpjM3cX9X6A51yOXLdabl97cQgHNDj
         Atg2MOqC552/5kPvj0KS/lq0nzFnUq57aNz0g+cb5X7DChc9sGElmda/egjtftaTl/mm
         v3sA==
X-Gm-Message-State: ALoCoQkTf3TGQ0RrqAyHl7rpXp8kf5LXMXtLMHk5UGDpp4jegC3P8umDQ390850XGhiZa6ZzYJMa+cVoQaGNLVdz2IPy4qdwvg==
X-Received: by 10.66.255.70 with SMTP id ao6mr48135180pad.64.1453250653049;
        Tue, 19 Jan 2016 16:44:13 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:12 -0800 (PST)
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
Subject: [PATCH net-next v6 04/19] net: usnic: use __ethtool_get_settings
Date:   Tue, 19 Jan 2016 16:43:49 -0800
Message-Id: <1453250644-14796-5-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51231
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
2.7.0.rc3.207.g0ac5344
