Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:09:40 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34841 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011680AbcBHBJhjsTfT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:37 +0100
Received: by mail-pf0-f196.google.com with SMTP id 66so7997139pfe.2
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W91fS6/kCTvxpN9oUaegO1BUr1Z/FxCHfX020UmvNOo=;
        b=Bay02PUj83sZXrMA138bCWAHvbVHtyq1HNvX0pJVYjusjIBhaXGk5sNmXKHyFKc+1z
         vkrfZdqIsd231JbGfYPQlhmePwW6DdWnx7IBhAhAGjAJPvTttJ/KUDhH8Xv7n1AjwF44
         Kj0X0lDKz3hcFLn8xa9FE27/xXg0pr4GB8kAZnzN81Jwcq6Y/V3z0AMbUtagGzVqiXEt
         U1irQme5bEB1CleAWNg9qvdG+S6mses2FovCVRBAHC1asnfk6ok+YAWrYsUqR88AxpHQ
         uI7fmnjHiQ/rRwWFLfvVXo+7D+HsZfLrXa5Zgg8QDzZ81zjIOoGKfQ0swBCcCvYsUsKt
         XJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W91fS6/kCTvxpN9oUaegO1BUr1Z/FxCHfX020UmvNOo=;
        b=ZTzJwNy9s0dIFbUos4CjCpUc0aZT8qKFgSXAX8OgvsFB4rTLJPIeUuzXw/a7wLj2Yc
         6xhgDdJGtIwTvg/tkAKVBOdRhaSzIad2beclnlc83dscC1Vdz/auSWOSmgkX9L/bPA3/
         +TvGRymw+L7zGrGoHZVN85D0J52EgXkSg78F07D8dW0kpAiyWdAbmR5cuuplG3y5I2bx
         Zk2fCuk/lUpgFsqsZ6vkZ6DwRQ960E8Z/9X6TTfQ0CzVkIYcq8S8mu+JenTyFCIT4Rtc
         eyyi9m6acq/69WrAz0HgDpgrWfMyaN7ACPgytK6sb2OZTg80dImvFEd75+z34S9iDzAT
         V6mA==
X-Gm-Message-State: AG10YOThfj5XaUi8NLAkCfOaWubS4/IZwRqX8v6ANsy4GvsqdKzW9tNO9vaY8psmju/y8A==
X-Received: by 10.98.72.133 with SMTP id q5mr38894366pfi.166.1454893768581;
        Sun, 07 Feb 2016 17:09:28 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:28 -0800 (PST)
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
Subject: [PATCH net-next v7 04/19] net: usnic: use __ethtool_get_settings
Date:   Sun,  7 Feb 2016 17:08:48 -0800
Message-Id: <1454893743-6285-5-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51822
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
index ea003ec..1cf19a3 100644
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
