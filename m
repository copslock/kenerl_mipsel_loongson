Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 20:55:42 +0100 (CET)
Received: from mail-ie0-f193.google.com ([209.85.223.193]:36831 "EHLO
        mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012495AbbBDTyOFAjMl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 20:54:14 +0100
Received: by mail-ie0-f193.google.com with SMTP id tr6so752191ieb.0
        for <linux-mips@linux-mips.org>; Wed, 04 Feb 2015 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vdm635z5BIZ8baPqZ15MvHu2KHpz60EVvs+bLBDU//k=;
        b=E5rIn44cPRHuyjRTwi13+C4BY2Gqas29dPp5INLnmjCCXHZbNZF9YtDDvKEcvTL3lH
         k9ApsdiwrFuI8PhUj4mpFjHq5bya9VqdtfupifIqKTkHs1L2uE2I7Dl3DX4oladahi2h
         j3nyT+Y6LWrQu9PUjKJiTV9SjXdPF03G6srSp5WPIEhesgVqu04z9Z37ZQb4wyDczGAo
         +XD0aRlWfOjWsh5togSard31Dc9MvMLU9c00JZBj9mmiypuL2MVVUc2ardV9h7ofrkqX
         YXjn9oDJ55s8V6CFUTC4xfnTI67JNEx+v5x4vtZfOm7qoRMoaHtcEMZnFo+lF5Yx2Uuw
         Xeow==
X-Received: by 10.50.32.71 with SMTP id g7mr26582313igi.4.1423079648672;
        Wed, 04 Feb 2015 11:54:08 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by mx.google.com with ESMTPSA id e70sm1348825ioe.6.2015.02.04.11.54.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Feb 2015 11:54:08 -0800 (PST)
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
Subject: [PATCH net-next v2 06/17] net: bonding: use __ethtool_get_ksettings
Date:   Wed,  4 Feb 2015 11:53:30 -0800
Message-Id: <1423079621-1374-7-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
References: <1423079621-1374-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45704
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
 drivers/net/bonding/bond_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c9e519c..9aba5a8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -372,22 +372,20 @@ down:
 static void bond_update_speed_duplex(struct slave *slave)
 {
 	struct net_device *slave_dev = slave->dev;
-	struct ethtool_cmd ecmd;
-	u32 slave_speed;
+	struct ethtool_ksettings ecmd;
 	int res;
 
 	slave->speed = SPEED_UNKNOWN;
 	slave->duplex = DUPLEX_UNKNOWN;
 
-	res = __ethtool_get_settings(slave_dev, &ecmd);
+	res = __ethtool_get_ksettings(slave_dev, &ecmd);
 	if (res < 0)
 		return;
 
-	slave_speed = ethtool_cmd_speed(&ecmd);
-	if (slave_speed == 0 || slave_speed == ((__u32) -1))
+	if (ecmd.parent.speed == 0 || ecmd.parent.speed == ((__u32) -1))
 		return;
 
-	switch (ecmd.duplex) {
+	switch (ecmd.parent.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
@@ -395,8 +393,8 @@ static void bond_update_speed_duplex(struct slave *slave)
 		return;
 	}
 
-	slave->speed = slave_speed;
-	slave->duplex = ecmd.duplex;
+	slave->speed = ecmd.parent.speed;
+	slave->duplex = ecmd.parent.duplex;
 
 	return;
 }
-- 
2.2.0.rc0.207.ga3a616c
