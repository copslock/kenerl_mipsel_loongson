Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:12:39 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36623 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011983AbcBHBJnRozdT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:43 +0100
Received: by mail-pa0-f65.google.com with SMTP id sv5so1953760pab.3
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nv/955mO7QOUjayIAkpnofasbr4YawAVZD1TtTr4WYo=;
        b=DByaK5IRX39bAv+/At+7KfSidLPeahvAzb7Og6fgIERVgE1Iw6Fz/Nx2R1dLgI8cOU
         8g1iMw1pXn1bPN635/IFR4zoaMW6Gvs312W7I4y+r1wNsjQpZmvUz5lJgzwCls8AVepS
         iVuWfjClm0w3JkR1YqLsOJ+vhEzcJ1bN9gzN/2uyDMlp7qCbGEjVPaEMKdyNbMryd6Vt
         YrPx0obnouh3klGjTe2sy4zkCzmtc2oa3V1Vhq1TNa1xWi/R75I0Ruk9YIvaG+5Ey8HX
         Taew0A+C0Hce7QRjT7/6fZhUgZr5KwionRK9JaQbU4lcdJHQ37Qkl7sCsZKhXckOY8IN
         PrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nv/955mO7QOUjayIAkpnofasbr4YawAVZD1TtTr4WYo=;
        b=fulKfeRqJnYHU6+IedreLUCGLjA6VcxPtPqx5OC+nUlW//ueHY0bFAlkc2mimpCAU5
         I7AnmhjKEyjh0ixDDQGl6v/3x+0d8tbl+CVOc0P08MnFB9z8PAAcSm76qEY+2j2entma
         OOf7zh2wz842lGTB9ip3rgu5Xr7Ns2NaiiU5gEtT711vd0sR213lUVxoGHg5GM4ga0LM
         4c/Pjf04Caa5KEH9gsPGA8fTTgTpE3W1JRATidyakglgINoekNKTSJCN07bu3Er9ku5W
         jJOmLQ/cnJqm0uGnO9kzlkgZk4ZrnnuIgJ8ZoI4tm+TvS5W/M5zIpX3U97/O9YFae6vb
         HiIQ==
X-Gm-Message-State: AG10YOS0iIdSxPK1mYawRYnVXNfd/mpw5xvAwSAFObe3mT6ZMVmok9dgwN4q/+9LUOuuwA==
X-Received: by 10.66.122.97 with SMTP id lr1mr37841819pab.68.1454893777619;
        Sun, 07 Feb 2016 17:09:37 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:37 -0800 (PST)
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
Subject: [PATCH net-next v7 11/19] net: team: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:55 -0800
Message-Id: <1454893743-6285-12-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51831
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
index 00558e1..7f96eca7 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2813,12 +2813,12 @@ static void __team_port_change_send(struct team_port *port, bool linkup)
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
2.7.0.rc3.207.g0ac5344
