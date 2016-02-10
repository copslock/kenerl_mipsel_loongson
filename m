Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:33:16 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36212 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012501AbcBJAaNG26Lx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:13 +0100
Received: by mail-pf0-f195.google.com with SMTP id e127so170648pfe.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nv/955mO7QOUjayIAkpnofasbr4YawAVZD1TtTr4WYo=;
        b=ceLESC2QxeGuF9KCycDnyjdnB1Zg++lrnjQG6fgx9xhVAFLkycggSxzrlG84k8K8GJ
         MbnO+3mPI3aRz5eHLx3X40QwbW03vaagMbZn11lGn4+kFd2M5Aj29zVwAJgmtEsH2QTq
         OrITVIZrcHQFbugC6AhJfD2EfE2BkpBiozL5awgZ+hazSLTnDHlDdkjBmxhoBonSQs8j
         T/bimWQM9pnIpK0Vq/jlQYN0QzyT+zIj6tJ0bLey9oLn2T5h75C3nynjx+KhD4KIZlra
         4cvH4zgRAGeCGof8aZ6rVF+Rl70xg8Gr3Zk285UDijkJh8264pi0DuBJSneCavF2edMa
         T2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nv/955mO7QOUjayIAkpnofasbr4YawAVZD1TtTr4WYo=;
        b=DOaCq2/+JzAAhMAJ51wzLHDVtNgzV+6jLY2iVzgMBkmdJlOT6Ee1KuZLWGhtD0tCgw
         EkA7+8gjTFrS7HfoCn+fRvhvlV5bOlxs6zIuLObUseEimWYgMotXS9bjeexxQgbRzlv7
         qxuU2hNP0TPt89mS94ick/9cF8TodEEFxR6airW9cKWWYJvI+xq2lVchWohsn8fIOEni
         +mPZidO5aZwMIAgky3DcD4n/M0sPZcAONHRdpa94OtDzfZdVwjekDtToaCIi/i5uCz/u
         uw/WO9o0GTXumFR9BbsrqFi47y0H+NSKyrrx+oCNyLE2BdHslm3NBn5LEBGLx7VeHY6c
         nkHw==
X-Gm-Message-State: AG10YOSm/nSoaOImMG+BDzcuCTpYVNOidm7aBI8wquX87WOAvhBuCjshg+kk5lg4KA/Pig==
X-Received: by 10.98.66.138 with SMTP id h10mr55350461pfd.89.1455064206803;
        Tue, 09 Feb 2016 16:30:06 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:04 -0800 (PST)
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
Subject: [PATCH net-next v8 11/19] net: team: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:20 -0800
Message-Id: <1455064168-5102-12-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51949
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
