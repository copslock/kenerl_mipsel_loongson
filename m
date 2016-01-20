Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:47:42 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34745 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014801AbcATAo0yzAkw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:26 +0100
Received: by mail-pa0-f67.google.com with SMTP id yy13so34598552pab.1
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cz2REAAVDgXwJyHnX4QtPFLZyCK+OObFzyr+4a3dUe8=;
        b=FfGBKsY8Sj/ajuyYG2/LwDG/rWZ40sDeLIJgkSjP5BawyRn/yEDORXg27pUPuQouvF
         r3nqTdkT4qP8ZsfvI1oCT2UdRghRyh7fPMKyXn6fn0E/NvOvhnGy5GV5WZOzccHmCxSI
         V2kVxRgh/ePZSGKQyojGEblKfk4KujkUbJnU7VRzRji/CcFl6c+B5PHkFfGozVyTP3Z2
         tf1OJKDeZRx7gbz0Ir0DJU3qS8+6I07rgBaVbzOmtnk7lWMMffeHp8qFP7oGN4tv43Bu
         SSNagWWb9ydkMenNR6i/0lP+3ZTzMRjhIPcYvSkOSmTMbTK3+ymRC/V8Ys4Z2+BUDCve
         Khyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cz2REAAVDgXwJyHnX4QtPFLZyCK+OObFzyr+4a3dUe8=;
        b=MT7gn2w6D61EbxnvQxPAU3N1syjjewFiiCgP9cmthKIdOXwr+tFALG6eyUmKOMeS+Y
         qo4oGizhT3cJmxT2/TTQuVNEU2cU766K0sr8EV7h6HAWBJiXAYn2Z+1XeP3JPwE9JJmx
         ZM4NcWEhEAujJ8pZ3QlU2wu8AAsIYyWlyLoZxtXOeFzyY06wWVcDiEpo9dOcUDbUpbYa
         PlH3VCZ46dKGPKJSTBhPxV/SyzkyqZ7Y0Rn/pz9Vl28atSkfEdTUWWqseyazGnB9Kmw0
         IxuIM6Pu19tgbJAjeIxXBysEpd+lI00EIv6Htg/Gi4VFTJqmvrNXWjLxd/05Tw6rE8eo
         A0Yg==
X-Gm-Message-State: ALoCoQnzznRWDxHCybfJlgnZgqKNCrrKtmBfYRjzAHkHdgKzXn5cRr43UQgvxRIPCj+wpxwrDBTHxwQUBNFIICRN9anO3832oQ==
X-Received: by 10.66.63.104 with SMTP id f8mr48815522pas.41.1453250661285;
        Tue, 19 Jan 2016 16:44:21 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:20 -0800 (PST)
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
Subject: [PATCH net-next v6 11/19] net: team: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:56 -0800
Message-Id: <1453250644-14796-12-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51239
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
index 2528331..9eac51d 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2809,12 +2809,12 @@ static void __team_port_change_send(struct team_port *port, bool linkup)
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
