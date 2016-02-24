Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 19:58:59 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33591 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013902AbcBXS6esv55A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:34 +0100
Received: by mail-pa0-f68.google.com with SMTP id y7so1392831paa.0
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W91fS6/kCTvxpN9oUaegO1BUr1Z/FxCHfX020UmvNOo=;
        b=kqPUIZtcXw/4RAF70rNt6wKmPwEVnMA7hpq5RqSdN3IuQf7GFM3U1ilHWRBdJweKrt
         HnT+18oPrwU/Zr8qgqeDE0/VPeE5AfnqwMw6DdPEQFhCVUvelsvzJQuJO01RvrqfiIhE
         2TfhCHAzV3VQgCuchLk/Xnvps70Zx25k5CzkQ2XLTToxfjiSFyW8wRqb9C2SpnvBrLzE
         +AB5G+Gnv1NA1uZtyxpgdRyEvApOkGRg3cp27gir8fEYKPB/7mKvMB7Y6uS7v9UQ5E5T
         pfsaOzN+sm8dNQ8BgDwVp/mHWHd4jpx7nwchJBlpw9R2wSPOtw2zG418USUEiU13vlTa
         rF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W91fS6/kCTvxpN9oUaegO1BUr1Z/FxCHfX020UmvNOo=;
        b=CPNrkfkKovDS027dSFj8g02b3Uaog2KyWsAGrCOx9peaCbGM2KEzGqk29A6aT2lnI8
         6iIC8IqBxJ+WTuR9zlEqXHYJhh2Dbv84vsULhu8DFImoY/t9Nd7I21X89jpNYfPhSuV6
         cypTPb1dinkfwUy+Tk7rsJuRvU+B6YSaH5UuEJFs6y6I/B0IOgf8Wwl4Slpsl37UgjBO
         CKRUCyaEdo/JPI0pWYzyJFXQDj4H0INRjHAzfYfhKVjQ2OCCh7MRDBb0+OPXQyvBOQ+Q
         d+mLAXTHC90FN324FyHe1flSGe85XZnFT9ESKLBXjTWhTnY8txaPsR2lAwXrQvxJq4QI
         Ff+A==
X-Gm-Message-State: AG10YOT6RkkVgdj4o2j2KCUgqY6TfeOF9lvNtwSexe7RxaHsU9k3KPAWiaFZzU4EiRWk6A==
X-Received: by 10.66.141.142 with SMTP id ro14mr56019578pab.112.1456340309141;
        Wed, 24 Feb 2016 10:58:29 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:28 -0800 (PST)
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
Subject: [PATCH net-next v9 02/16] net: usnic: use __ethtool_get_settings
Date:   Wed, 24 Feb 2016 10:57:58 -0800
Message-Id: <1456340292-26003-3-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52207
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
