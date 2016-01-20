Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:48:54 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35416 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014805AbcATAobwxTyw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:31 +0100
Received: by mail-pa0-f65.google.com with SMTP id gi1so41971474pac.2
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IpA9nl8IZlK/ByCx1cK2rQrWfMOQ/Wm2UEg6gnOMKA=;
        b=vRd4+AsVw3Fiy6xG3NCzr9LRgLCOtfwYBKmyEzmgsNAz6/c/TwwWJ5zBB2NTnz993y
         ET9B15hhrCR0bcIlJpg1zf5ON65qkKwTI/3nHiSuPCfjYqtB4gmTAMAWTr6soFtIsnKT
         ZVnkLHw8PKG+0REZgouUkCnOO/MC9glmlgwxsvL5QmqWdSK70Z8pALfjAY5uKhEYwit8
         GuvxRCv5INVx/nYzOKpTmthwNu+WrkSrgC41RzLkN3gzFrEm1qXLPIXxh8swlXC0vVrP
         nRvk1pARwzhinx9j4JFPxNaYdYD4S2ZfmXz/1vTzO9zPxH23gU50VEfP3a1WJFHihMz6
         sjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IpA9nl8IZlK/ByCx1cK2rQrWfMOQ/Wm2UEg6gnOMKA=;
        b=VaqQc8sssZQr6KG42X41NHawWg+5BEn5eFeT/TiLY8kNYZWNcTQBzbN9a9wrQ2BOiR
         ZNwl7loRjgJ1lQRZAaHFFC29Wg6R5r+DX+24xQqZDigWVh2iH1Go8QIbpmoQutdv4zrh
         vYwbVEBuRrFcL6Yslyymr2gfcu4jfjJm5COhl5QKtqjg2Tx6wL5ehD3TCb6BHzC1Fm0a
         Kq9//IfosC+moeQUo0aHgRw23xTURuJTrLZvwJRaqXESakDxWWanx04nonugHXIU5W4b
         shM7x/gWd4HCnk7FulLhvdg9WaJTEm4xFVfdGi0yEqTvPMacHCi2MQKNm/hw6qWDNZuf
         AkYw==
X-Gm-Message-State: ALoCoQmB/nzxz82YgfnfU/D2tv/hJILqPSdm2OPm4TFmzgwefcxNKDqsp9rfEDtLaUzvwQ1/igUhqpeCWM0sRhFAj7alJM67RQ==
X-Received: by 10.67.7.200 with SMTP id de8mr48946845pad.28.1453250665885;
        Tue, 19 Jan 2016 16:44:25 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:25 -0800 (PST)
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
Subject: [PATCH net-next v6 15/19] net: bridge: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:44:00 -0800
Message-Id: <1453250644-14796-16-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51243
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
