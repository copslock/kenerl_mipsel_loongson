Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:46:48 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36851 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014799AbcATAoXf9sDw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:23 +0100
Received: by mail-pa0-f67.google.com with SMTP id a20so29539507pag.3
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LSOSm8ovDOv7O4dhua5l3LiRN+yyMayJ0g+FuqZ6B+0=;
        b=WAN/SlfBOjv/8zxQxmE8v1/Fe+bQORSxNcGyHvBbcmP9jpz0w+kZqSshaBTC/petL7
         pybR8x1iEGe7ke9CyVVNWooWNOjVgG7+JG2+d2S8xjRzNCIEnNuFfBpCZNCZtvX8xFmr
         35jXlX3v6AcY6iPtB5LAAALNsVWSFG87/+Be0xf56BNOyLA0mHV1kP4tYYnj41Pk3ymj
         IaP2MAGCgDSjWrbxHu+O2OoyDykWnjEqhrc1fy68hxkn86R7mpLGlVAErytYLgXdtgy6
         +PcuFDirb8O6yVFcYpeV6mCutRr1KQKmMPgXZLdXYF/rjVZCvduV8RoYrbswhGdjmRrm
         Gw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LSOSm8ovDOv7O4dhua5l3LiRN+yyMayJ0g+FuqZ6B+0=;
        b=N0lgbJaGVu9IccbhFw6+zT/yYZE3x54QydHRBtWMwn/dM1nQBdsevhZQ2PFLNRw/y3
         9Gk8tiDnezZbPw1U7+gNBQ4MXIx6YwjOOdslb6dRwrK1oQUlSmOlt99Jp/zFBJV4xloy
         DxMI5zysd5DcT1XWKAw9xqiraVbgRlsJKw0yFOcbMLuKNdjOnnVLNbsM9hOP7Mm6Jb9v
         UWEi8PdZYy+kgPMLo1xHjWmtqMgsCvXsy5r+dw1UzcowYsIGY3WT84LVcwz0TSiY1cxf
         XMDYtzMWAHgJrPBQnF6pzdCU6VsUrVWNsIwD5DjANPWGAkrKPUR8Hxx+EkGbQ+8IjC+v
         tiyQ==
X-Gm-Message-State: ALoCoQnDDuU0ZoLXNwQLVjdhHRD06Kt2nSoxNR6IVDLNhgipXdanhmEusu7AKna22eiO7D6V3GVCK04B1+39n1kHq8QimqmYWw==
X-Received: by 10.66.234.200 with SMTP id ug8mr48825129pac.129.1453250657796;
        Tue, 19 Jan 2016 16:44:17 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:17 -0800 (PST)
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
Subject: [PATCH net-next v6 08/19] net: bonding: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:53 -0800
Message-Id: <1453250644-14796-9-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51236
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
index 56b5605..df7b12a 100644
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
