Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 19:04:37 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34994 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013573AbbLISAjk7p1m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 19:00:39 +0100
Received: by padhk6 with SMTP id hk6so3456166pad.2
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OhzCX4d6bCoeJaYJGuOErFxTEsBbq5YwBKBuqgfp42k=;
        b=szpO78ylja1dpfMd8pOsiL3HssOdN6hQ9AZktKQKeUlLkXiqitqTKxSLZeKiaFBKHz
         qfwglccLbbMn2KR1Nmdcdug0e/SUzNtGSWMRKR/cWFYmX4OWT5sbn1LQzxZrm9lJG4na
         ru7cZPOobkuvp+H6C8uS01+Ffu/7Vu+bbbaAkP/KUrPj96B1hbU6VbwvCUgsLvuUKXZG
         j7b8oi9v9+m9GbV6QB4mK+zpZTBNLRlBI6Xq7m5GTQpt4L9BYt5e7gO5DQAX4CErNdDB
         YXETEXS0QuXd7Dg8tVYjEquTjim1IwnewYJ1TbmlRoQEiYHltUTFh/kYQrVAugA4EcEb
         KKFg==
X-Received: by 10.66.251.226 with SMTP id zn2mr9920190pac.44.1449684034041;
        Wed, 09 Dec 2015 10:00:34 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 82sm13056535pfn.76.2015.12.09.10.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Dec 2015 10:00:33 -0800 (PST)
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
Subject: [PATCH net-next v4 15/19] net: bridge: use __ethtool_get_ksettings
Date:   Wed,  9 Dec 2015 09:59:25 -0800
Message-Id: <1449683969-7305-16-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
References: <1449683969-7305-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50504
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
 net/bridge/br_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 8d1d4a2..d1022fd 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -36,10 +36,10 @@
  */
 static int port_cost(struct net_device *dev)
 {
-	struct ethtool_cmd ecmd;
+	struct ethtool_ksettings ecmd;
 
-	if (!__ethtool_get_settings(dev, &ecmd)) {
-		switch (ethtool_cmd_speed(&ecmd)) {
+	if (!__ethtool_get_ksettings(dev, &ecmd)) {
+		switch (ecmd.parent.speed) {
 		case SPEED_10000:
 			return 2;
 		case SPEED_1000:
-- 
2.6.0.rc2.230.g3dd15c0
