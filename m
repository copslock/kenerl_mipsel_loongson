Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:46:12 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34729 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014796AbcATAoVF09Uw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:21 +0100
Received: by mail-pa0-f68.google.com with SMTP id yy13so34598458pab.1
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMoutD4K4abopHMoPWMLnSXDq2EdilqE7/cUUP2P36A=;
        b=S4qy9Z0lTELtGEApoKxNrli4Px4t30ruUDbIgeHzEyuB+au3JxaghitcBB66wxUH4I
         EY1FXdnwJ64jglHwH3cx7Fl5m/CTJUPk66pwIlBOGIz6lv1CoTKFh5I7IqCYQLDyBZjn
         7duuAtl8rGX7yYrlQvwRsKPKY79CjSzwyaXLqTxRFXVF8HQz46jYLJCqVK3JwBLmFGKb
         9oNerO+9ArJmYdJVVyHFzmKVPYmuW0MPHc3+ltCtQzrWq01Hbbu0x+3/jGpVtxNfyM6l
         v37WSgZJIVb1ZOUg/rF0R8uq1/9IMxhO6lC1OwkfsBVvzyH9k2VDQuwHoypDgpbx+FX+
         0v1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMoutD4K4abopHMoPWMLnSXDq2EdilqE7/cUUP2P36A=;
        b=YAM5OPmT38MXJKTi+FtcDW37bxHLj821LDsn6cpvddwyrDKWtXcndsTHSAYTn3lH22
         T5/V3m0v2pWN/EwuzILvxhhmhrroyemVYNWK0cc7NtZLOR04faGWnh1zqWac4U2FZukL
         HLUkYUIaobpnYKajmvqQhpfdDEgRTnxyNyAboMgqhGKFgIhyeXtZkzoh81MzjYXmzgsR
         hc+HZEH08CnTWpOKLbHznybGy3ahXj7u7LPN8wBCWDMwOM6Ywtm8806tzQtS62nXKPy3
         G4v+HNpGIUE8BYwKaMjwro7hvp3kijdhoex4mCgIrN7brIaVthBkRj6FR4isI5L7vxyv
         bHdQ==
X-Gm-Message-State: ALoCoQmeqglVd0/xB1gxprExMtM1JSiCNGiY39nhQCSSwnV9460J+OVKy+1W31sZ/ep7a0lZ95I7Kj7+I9CbJ06T1OtzTDi/Qw==
X-Received: by 10.66.63.104 with SMTP id f8mr48815037pas.41.1453250655492;
        Tue, 19 Jan 2016 16:44:15 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:15 -0800 (PST)
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
Subject: [PATCH net-next v6 06/19] tx4939: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:51 -0800
Message-Id: <1453250644-14796-7-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51234
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
