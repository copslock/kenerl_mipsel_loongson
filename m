Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:30:58 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36164 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012470AbcBJA35YVUXx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:29:57 +0100
Received: by mail-pf0-f195.google.com with SMTP id e127so170373pfe.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W91fS6/kCTvxpN9oUaegO1BUr1Z/FxCHfX020UmvNOo=;
        b=xnOVXmAy371Dl4h2rpf0gh+ecRUCPJkUbiTJYQ7SsFPcu2VO2oB+CGKFywBcMRifbt
         A7xrripJJ1XjS+2ohEGHEOqcoLugFSiTVmx0HfVy+l10r72GqnQ8V5tSmrEnjtb/Tgvr
         CwD/ZF1jcdo46FSM0wjvLH6mM75zmqVlnc5rAzjWEfqMz5rBE1j44LMKFDIGSMD9MR8D
         pD8mcGSbi4tWv4X1kp4Y72RIDzeFsmGpRG9XlRdl3gGpFgfyEz1Nkc72QovX6Svjbh4t
         HHjb/vv4wXeQh7SOj/cJnNbC2q4qLAPaRQN8iIdHyuUGnTJe/HPB8oMJmrdrelkl+bRX
         ktNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W91fS6/kCTvxpN9oUaegO1BUr1Z/FxCHfX020UmvNOo=;
        b=Y88kq3e3cVzJzV8VTPVjbME8CNFndSOvbquuIiH1rn1oF+9tTN0qg4HqJ2vE2YHm+U
         XyFBLuXm/hXC9DC8owzzwK15L2SxvRQ2DOd16r1FL68MSIXkIqLL/AGsNyp6lZpLvSx8
         ule4liOrwnALt6IavFRt2Umvuq/16nppByEw21NciAtQG7X6P/V9oRCjOQtslyBreUnH
         2dym05SiaXjKf6zeXB2a5NUGUM2fRB8qtq0F+f1As8vv0dXY1BeNYDXT9ZLzBtr1q+bJ
         8wCAZKADsJ2UBxquzWdi4YINGBIEi2IZcpuKknqOGSJemS4q1TWE7IkIC+EougHzJWIN
         RvCw==
X-Gm-Message-State: AG10YORMMZ4dVmApe5GFSRonQxOy60/A+jfh/uWvYUQc1AzkTH8SvfupKCpeJK6bVKceWA==
X-Received: by 10.98.44.73 with SMTP id s70mr13706303pfs.2.1455064191780;
        Tue, 09 Feb 2016 16:29:51 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:50 -0800 (PST)
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
Subject: [PATCH net-next v8 04/19] net: usnic: use __ethtool_get_settings
Date:   Tue,  9 Feb 2016 16:29:13 -0800
Message-Id: <1455064168-5102-5-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51942
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
