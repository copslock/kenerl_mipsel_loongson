Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 20:55:07 +0100 (CET)
Received: from mail-ie0-f194.google.com ([209.85.223.194]:60729 "EHLO
        mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012488AbbBDTyLM3mUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 20:54:11 +0100
Received: by mail-ie0-f194.google.com with SMTP id vy18so747590iec.1
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 11:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Ss4o1J1GmUatA3aFcs6efKoVCGBmGYjDNY7Q+3WALc=;
        b=y/EYmOcOzZLr7QrTiAWoBtntzwbLPHT+fJ/MglUbXBHPVblwkgT8vj8aIDRABsSN10
         ocEiWugE8B8bcCs0HRQnpvGhiYfhUy/KWvJOy44PrmkgG9OeieD2SuAS4MWa2ztE/K/L
         B5f6C+37RunJonTCJlZjELeIQLqam1ca119J++UyGf2UbsMVpAmyyvLr45zSwFFSxTOp
         pN4c/oTX1xGOhVjdni0Lg4HCGRaaj5EUMWKqu17AmIXnbH7MPUtwCaJtkv6j77RjQYrL
         sJtXtQo9FMJ3RxBhmUjnjyssglowK8KdA+dGtP+hGTQ6EuQnPk10HHjye3+V8LLVL07P
         8M3w==
X-Received: by 10.50.119.9 with SMTP id kq9mr4324677igb.36.1423079645451;
        Wed, 04 Feb 2015 11:54:05 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by mx.google.com with ESMTPSA id e70sm1348825ioe.6.2015.02.04.11.54.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Feb 2015 11:54:05 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Upinder Malhi <umalhi@cisco.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v2 04/17] tx4939: use __ethtool_get_ksettings
Date:   Wed,  4 Feb 2015 11:53:28 -0800
Message-Id: <1423079621-1374-5-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
References: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45702
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
2.2.0.rc0.207.ga3a616c
