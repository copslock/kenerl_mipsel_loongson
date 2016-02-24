Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 20:00:56 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34927 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013936AbcBXS6o7TSlA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:44 +0100
Received: by mail-pa0-f67.google.com with SMTP id fl4so1385314pad.2
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wRMxCXp7vJ2JerjIzEg6rRlU49dT6SVyB1OswBwp0C0=;
        b=0ZZnKE/mIIgA/1h2CBRMVyy0guR6B+GOfe88rPABdZDDg1PpIGc3S4yr03iD+uV8v3
         bnXgRUNHi1Sw7fbKJnQhqqSSkJskmg1P39ctSAc0K4HGlVIippRlNcsbmB3KclF33Dvo
         bRzs2sQVxSh1sjkLK/Im+UuAvbMlCtRGo5d9QuInL+thovTNAiBy0OELPPE2K713FZqi
         H7pCCg3s1d0izwpIgOKwgEEFzMBzNCzNgovt2eMsigFmhIp8sGyolyOiFoRMBBJSe8YO
         2yrEsWz7RHNTRhx3yFw4V+sDal130QAaq55WdHLtAtiWRSFLbLsUdzPCdV/dwaKTcJDi
         /afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wRMxCXp7vJ2JerjIzEg6rRlU49dT6SVyB1OswBwp0C0=;
        b=He4BOpOOsKAKZ6lIjJWzGAFzmu9kcmn1ZM4hgMBlalZEWUzzPwhxTws8RkvSUzTq1l
         53GVu6cBhgKvCfLiqmR7leNb912T5xtznk1xWQsxEd2s9jJ0eE3r3gcAlQx6OmeDf6pe
         5trPfe0XOWhxIeEozio52Xwubejx0Rl+vn8OLQTICSKnH9PwPi8z9XfQph2tDNCiwTHq
         Ogs9fWjmgteGlBZrx69EgDRCr7osrL7gOr9LqX70QBV/ahILBbMR+uNML7qOmDgKgI4G
         p4A/Kd79TF8j/if2cO3lhsQN+/i8OXj6lX/59d1hLqHJR44jfJe3f/mrxkVawfj+FVqV
         MjQg==
X-Gm-Message-State: AG10YOQlWSR7sPFHbIXKYDa9EXFN7GPKEcf2LCcIzKEvc6kudnx7Fe/lpv6sKz2wdZtnGw==
X-Received: by 10.66.102.104 with SMTP id fn8mr57248891pab.129.1456340319339;
        Wed, 24 Feb 2016 10:58:39 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:38 -0800 (PST)
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
Subject: [PATCH net-next v9 09/16] net: team: use __ethtool_get_ksettings
Date:   Wed, 24 Feb 2016 10:58:05 -0800
Message-Id: <1456340292-26003-10-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
References: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52214
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
index 00558e1..2769835 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2813,12 +2813,12 @@ static void __team_port_change_send(struct team_port *port, bool linkup)
 	port->state.linkup = linkup;
 	team_refresh_port_linkup(port);
 	if (linkup) {
-		struct ethtool_cmd ecmd;
+		struct ethtool_link_ksettings ecmd;
 
-		err = __ethtool_get_settings(port->dev, &ecmd);
+		err = __ethtool_get_link_ksettings(port->dev, &ecmd);
 		if (!err) {
-			port->state.speed = ethtool_cmd_speed(&ecmd);
-			port->state.duplex = ecmd.duplex;
+			port->state.speed = ecmd.base.speed;
+			port->state.duplex = ecmd.base.duplex;
 			goto send_event;
 		}
 	}
-- 
2.7.0.rc3.207.g0ac5344
