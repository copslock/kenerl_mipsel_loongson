Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:31:36 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36177 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012448AbcBJAaBtyAfx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:01 +0100
Received: by mail-pf0-f195.google.com with SMTP id e127so170445pfe.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMoutD4K4abopHMoPWMLnSXDq2EdilqE7/cUUP2P36A=;
        b=lZmX2+JEfVaLwyr4OCc8IMvSa1BCLmoiQUq8AGZ6qpPQeeftzEUIR+coE9iKc/fAac
         F/5rqsWvZ6LiFV3IsSOGQbrlBMuc1OcuSIaKpX+HUTnBjmpundK+E9Gey1Pjc9TyH94N
         PctbieBqHhPyse/caGikM0LSGe0EyGMemX5JBo+YN7cSo3/YZ8CljeUYgYBUEBoWtVXo
         CtTvBKylq5G37OjNXKZMxFDsw/jJZOJxR6RGsYt50Bve2M4rSRmGzWmuc1os0GjC8iXg
         FQl8IRzWcQDDAbogYqmaLAipSDKnd8MwpDyziQTmV0RZ+gOgjxQLXfgXZUvJum3zo508
         hvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMoutD4K4abopHMoPWMLnSXDq2EdilqE7/cUUP2P36A=;
        b=hkxbpQ32kdLsg2xirVny7ZoxKydEnwfOQLRCbmgu2RL/Gse9KOUUZlV242cszpk/eB
         V9pCe8pmHsYqxZ3HLizxegYd+y1d4oUa260a+hmb5viaBjkOAq33sx3EXPn2YY/lBPPf
         3eAflyaPld2IST402As6z/XM8tgdzlDUJs53+3jHoZtxAUyV6bpD+hmHgw8X4qreyUab
         cNSEtKbc04RUH69fkwnH8nstNTXZqQHf6k0A9+O8fEhzPTLxsAQq6D7nxrzyri9Sn9ll
         1z8MXUB+pi/d26rpyZ3GuH863GIv2l/B6Q6xKSVzzME27wu0iXnLi6t83XcmKfB7S+I3
         9ZKQ==
X-Gm-Message-State: AG10YOTnZUr3AgFUSWDMZgmE2KaylqfwiYc5fQfDRL3Xk8Bzaj26TmLvm0kx13aT2D2Ijg==
X-Received: by 10.98.89.78 with SMTP id n75mr53659678pfb.120.1455064195788;
        Tue, 09 Feb 2016 16:29:55 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:54 -0800 (PST)
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
Subject: [PATCH net-next v8 06/19] tx4939: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:15 -0800
Message-Id: <1455064168-5102-7-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51944
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
 arch/mips/txx9/generic/setup_tx4939.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index e3733cd..4a3ebf6 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -320,11 +320,12 @@ void __init tx4939_sio_init(unsigned int sclk, unsigned int cts_mask)
 #if IS_ENABLED(CONFIG_TC35815)
 static u32 tx4939_get_eth_speed(struct net_device *dev)
 {
-	struct ethtool_cmd cmd;
-	if (__ethtool_get_settings(dev, &cmd))
+	struct ethtool_ksettings cmd;
+
+	if (__ethtool_get_ksettings(dev, &cmd))
 		return 100;	/* default 100Mbps */
 
-	return ethtool_cmd_speed(&cmd);
+	return cmd.parent.speed;
 }
 
 static int tx4939_netdev_event(struct notifier_block *this,
-- 
2.7.0.rc3.207.g0ac5344
