Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 23:09:04 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35041 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009681AbbK3WGf4pOBY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 23:06:35 +0100
Received: by padhk6 with SMTP id hk6so26757109pad.2
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 14:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3MrQkdrWG404sli28QxMn7ROu3hLO7dsAGv0ih1BHuM=;
        b=NBq/gQnFhOOAWMUCiicY0IWc+aErvsTL4xlKq8OAVUQ217IVzx4CUhOYK8E7TcOWTI
         3hHjZwxvK7o/nThTGwv1ShC8Mb9ZRQC686CRaNhN6dMtpcFgv4YoTa6hPSBSa5iMvbmN
         zVYnBPRUtxxOiiDqrSBxBBSTUtlV+DL+yqNbkJ9+svB1UU6ESLm6dvH/WRzA9pzFZIm8
         SV38jSApJlkeBhY65l7IPp+XzL5u7/ax8tSLwplobV6H0cD49RNSuerkRVCJgStAazlt
         MRIOdRl8Bd/D6xW+2Vx4OdUZJGrpUMAi+e5gbPdRxWlBslTpbJzp7p/zsFzbQ13vMber
         agGg==
X-Received: by 10.66.216.7 with SMTP id om7mr93802021pac.90.1448921190220;
        Mon, 30 Nov 2015 14:06:30 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id p6sm53253789pfi.20.2015.11.30.14.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:06:29 -0800 (PST)
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
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v3 09/17] net: team: use __ethtool_get_ksettings
Date:   Mon, 30 Nov 2015 14:05:47 -0800
Message-Id: <1448921155-24764-10-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50231
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
index 651d35e..288ca01 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2776,12 +2776,12 @@ static void __team_port_change_send(struct team_port *port, bool linkup)
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
