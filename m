Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:14:17 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34875 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012013AbcBHBJsgHi0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:48 +0100
Received: by mail-pf0-f196.google.com with SMTP id 66so7997355pfe.2
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IpA9nl8IZlK/ByCx1cK2rQrWfMOQ/Wm2UEg6gnOMKA=;
        b=DIJjx4k4TbFmEGfS+8V+pTP2QlBzOAQrF6fxQP4TRjoYuz7kNDZztqVPQFqj6/pj2Z
         OwEI4st8kILv4DufAnIK+NskvVqEr8tjQdeRHy9VKbkzoQVp4YUcmq+btEI4NiNZpD3U
         PknAMBnTV1K0zSFEssh82jHVcyQ0REVzui0caw/XEyN012TyUczk8AaMakYMI5vftOBs
         1aRQ3HaJQRCIX7Z/U1ctYPUVFPNsgtkyTa4UQ2BoE9J3BA/TMymj815VEQ49K8NJ/WNy
         jZHBrJmY8TNTCaGry+kRBrwXUzqO2u5bWAPQ3w3NhdtuFu43EWGkLzY0O2ZloZQzHB41
         TJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IpA9nl8IZlK/ByCx1cK2rQrWfMOQ/Wm2UEg6gnOMKA=;
        b=GMvOOWogLLrPMzKfQ8IzdAQzoNb6ltRMo8Dj/hNzaP4r9QG0gqs+HYaIEnNYjSxZO5
         IdrDGobRqH++KUz9wk7UXbT6DupShLeYmniSb0ovHf/6o2xoDXnD1/WfvFMvUv7FqCWm
         YRBggMiwhAEk06omW1M83NtyJ5DdEF+9Iqwd1EGaJGTlyZtazhZyTUCIP92DxtVM6vwh
         NTBIXjgTqrH6804bBGJATMaJZh+zfiRTPbidMm6uohB8BrQdsLNSKUnyxf05W5D1Bytn
         vesK0FWbqpXk5BlQORXoS2wwxgFD1KTUVAA/qjfXaAXcUhmQp7gqdHrSbnhFa/0Gr6S8
         8Mnw==
X-Gm-Message-State: AG10YOQl0WchhC+q7AOxXWt4jnEmZztA3QYpMXvj0XoXaNy0GHBzox6Nn7w8DaF2Jg1ZCA==
X-Received: by 10.98.71.130 with SMTP id p2mr38200657pfi.99.1454893782965;
        Sun, 07 Feb 2016 17:09:42 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:42 -0800 (PST)
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
Subject: [PATCH net-next v7 15/19] net: bridge: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:59 -0800
Message-Id: <1454893743-6285-16-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51836
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
index c367b3e..cafe4e6 100644
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
2.7.0.rc3.207.g0ac5344
