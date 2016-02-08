Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:11:22 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36617 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011897AbcBHBJnF5fnT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:43 +0100
Received: by mail-pa0-f65.google.com with SMTP id sv5so1953685pab.3
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SNaRQ7B2mW2/UykpJiQPLHMM6XjOqA/HjbAbAUmiWik=;
        b=FDGrCyLA2fsxTMC/AzmPVcRajkJ4T2vZRv1j4ku/AZe3amuXXg1mwIb1cuLeTdyGm/
         t5Adb2EiAI3DmM84BZEOyNZ9evrRQ8NIyTn5nJhvweoUGZzVAHnSg5yo6OjJhIozniqQ
         tfFsZa/ObaOUfPACXmf/CxMxY9a1VllX4N0mtptx0ByFwNI3dXl2JAbhQ/bmiTFdfFPe
         s67q/ikFSap6WOrA46XEn+G3rSARXwSB6RMAgpLJWUh+efLRWiQcfqgQQhWfmqWG5Rn3
         xvmLuRkUJz9kcvc7zGLjfcrszDcWGVeCeYebpXgWG48iau5wgohntxCIaFH20owvzthY
         NcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SNaRQ7B2mW2/UykpJiQPLHMM6XjOqA/HjbAbAUmiWik=;
        b=F1vYuYxtUPGtPf/E02T3D+rBU3vH6GQKQf+7fIYvGuvjn9ndWqBWayAd50yJIadH3Z
         M6/bYU7bCm7Pzr3bNcsG+D/ELqCkarOoHAwST+9gnseXO0iorfHR1ICr1bz2mrpkANXc
         CHyrmvVQ6IK2QytyxsIHdCgMCxOGbRg+H43Chjo3OpiWXOpq2ZoKtJsBS3V2Yb0PW4zp
         QmXD84mAcuw1ADoianeiTPXyne19Yf5iLe5/zKwaPR7+X0f08iVBgpM0Wd/U4XkSTefY
         NTdbzdaKSBv36oP0uEEzq0hlKXsqlDqjTcEJ+74Rq0/D07FyhBlSYrNuOf5Jp7ojc69K
         aW1g==
X-Gm-Message-State: AG10YORbktWp+uaRo43NYol3HnT3mrCyBMQggnp3s1nEqpz2aoTfJs/+5pQJ5KI3Rm5qtA==
X-Received: by 10.66.255.97 with SMTP id ap1mr38530031pad.135.1454893773837;
        Sun, 07 Feb 2016 17:09:33 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:33 -0800 (PST)
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
Subject: [PATCH net-next v7 08/19] net: bonding: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:52 -0800
Message-Id: <1454893743-6285-9-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51827
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
index 7c9eb67..c2baa86 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -374,22 +374,20 @@ down:
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
+	if (ecmd.parent.speed == 0 || ecmd.parent.speed == ((__u32)-1))
 		return;
 
-	switch (ecmd.duplex) {
+	switch (ecmd.parent.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
@@ -397,8 +395,8 @@ static void bond_update_speed_duplex(struct slave *slave)
 		return;
 	}
 
-	slave->speed = slave_speed;
-	slave->duplex = ecmd.duplex;
+	slave->speed = ecmd.parent.speed;
+	slave->duplex = ecmd.parent.duplex;
 
 	return;
 }
-- 
2.7.0.rc3.207.g0ac5344
