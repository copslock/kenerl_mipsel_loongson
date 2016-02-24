Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:02:03 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34567 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013940AbcBXS6uwvbUA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:50 +0100
Received: by mail-pf0-f194.google.com with SMTP id 71so1457407pfv.1
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4DGO6C5RAUPM6FfsqcB6b4ohMiRLnrx4wYeWVGlpkL0=;
        b=rUgoOWFFi1cdXqCYRbHPQDlSXfjfyy5H1e+gr9JN/FqUam8k8QBr+r1uvI7V30HGlx
         vBmqUNzg7s8jmkPPt64s0NkhvGh9IpmktOn2lvJRM0B+eGp7dP2H4Lq/l87FRINP4HP0
         B0h9+BD79pE43w+0UP3R04p4p195++QgQd15ePI7W9gMg73u5mSW45O8wHaqPO0eIjXS
         HytEsEq9BqXYDZdg1GJZFPTA8au1QVNbFqp/uoxeH1xB/q7zaF6SSh/H3uyrUNf/Gte5
         UWAyffu5y5Q4UOvFQI8HaYmuusqtkz5rLXTH38fIayfp9VCXU3m3qxcjGCS0B625+xMn
         6pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4DGO6C5RAUPM6FfsqcB6b4ohMiRLnrx4wYeWVGlpkL0=;
        b=lo6yk0CCWIuDN5awwa7snF0laX1NR0/6V2PpYl43zQsCV/CZ5eEMhr+Inf30JlN+Bl
         QPy8UkVqVXkEf3aadjqViAZpPkEsh7gJkfLNNvk2zK7p4gpavG+qQIhLAyZwnm9y4bU7
         UdBiT1DqbKP0EITijOCDVFsSAGwQ8cVnsyCNF+6pim6Rn2b7P0HWv8EKjHiNpH5Cjlw+
         iYjPa5l5ho0ExKvy98JR/acoOh/rMvnokPnVHa8HyDFn0sZjN6knX8ywUaTa9l0IGqv5
         /PlcB7OOi6gFtEOlAhK1xQWzN2bTCyfwxPsCt0GyZHjZHcCcMJLZO/25Y2tAFzstoRGR
         SThA==
X-Gm-Message-State: AG10YORqvXbI9C9ePqJokxx3C035qHT6JIxkiO/ua+af7pgvV09g/pz5dPwg3vKiEHkDig==
X-Received: by 10.98.75.200 with SMTP id d69mr57727221pfj.108.1456340325231;
        Wed, 24 Feb 2016 10:58:45 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:44 -0800 (PST)
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
Subject: [PATCH net-next v9 13/16] net: bridge: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:09 -0800
Message-Id: <1456340292-26003-14-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52218
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
index c367b3e..b37a1cc 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -36,10 +36,10 @@
  */
 static int port_cost(struct net_device *dev)
 {
-	struct ethtool_cmd ecmd;
+	struct ethtool_link_ksettings ecmd;
 
-	if (!__ethtool_get_settings(dev, &ecmd)) {
-		switch (ethtool_cmd_speed(&ecmd)) {
+	if (!__ethtool_get_link_ksettings(dev, &ecmd)) {
+		switch (ecmd.base.speed) {
 		case SPEED_10000:
 			return 2;
 		case SPEED_1000:
-- 
2.7.0.rc3.207.g0ac5344
