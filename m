Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 22:07:50 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34585 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013868AbbLNVEupZgS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 22:04:50 +0100
Received: by pfee66 with SMTP id e66so2117565pfe.1
        for <linux-mips@linux-mips.org>; Mon, 14 Dec 2015 13:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pmVqOOEEDU/OrwYB/6K0UqzhIxeK3ZVCvcoaJsWXvCw=;
        b=QLt9tYO9CLOHssoUeR8xosrni8mGKJXc7bv6ZaMiuIDxZ007vzNSwVU8KqTeTGeA9X
         gq5Ox2PckTuGpMYukzQJrBvjQ5cZZr0jOFhAgDG8s1YTV7lwdcNIVpEbKHRjVkEiBaZ+
         3G2IAo4/eXsOUAxqYosVJl2Oq3siR/Oc/U8Y9qg3C4VfpgCr+bAMtZwXSmG5n+MV4fdx
         AEfD5MznpsuKX7x3rDq2jm0vYnPh81O+23+N05587iJmO6VNb+X3aVex98TAhKtOP6hn
         MFs2JZXkqYaGtsrrArxrWCsSA4RV9IYFeA7dcE9rDidc5O31Ll1rlsEaJ1xbYUnntKS/
         o08g==
X-Received: by 10.98.42.150 with SMTP id q144mr18069620pfq.81.1450127085135;
        Mon, 14 Dec 2015 13:04:45 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 68sm13096148pfp.62.2015.12.14.13.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 13:04:44 -0800 (PST)
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
Subject: [PATCH net-next v5 11/19] net: team: use __ethtool_get_ksettings
Date:   Mon, 14 Dec 2015 13:03:58 -0800
Message-Id: <1450127046-4573-12-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1450127046-4573-1-git-send-email-ddecotig@gmail.com>
References: <1450127046-4573-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50601
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
 drivers/net/team/team.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 059c0f6..7cc98a7 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2799,12 +2799,12 @@ static void __team_port_change_send(struct team_port *port, bool linkup)
 	port->state.linkup = linkup;
 	team_refresh_port_linkup(port);
 	if (linkup) {
-		struct ethtool_cmd ecmd;
+		struct ethtool_ksettings ecmd;
 
-		err = __ethtool_get_settings(port->dev, &ecmd);
+		err = __ethtool_get_ksettings(port->dev, &ecmd);
 		if (!err) {
-			port->state.speed = ethtool_cmd_speed(&ecmd);
-			port->state.duplex = ecmd.duplex;
+			port->state.speed = ecmd.parent.speed;
+			port->state.duplex = ecmd.parent.duplex;
 			goto send_event;
 		}
 	}
-- 
2.6.0.rc2.230.g3dd15c0
