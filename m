Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 02:13:18 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36625 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011984AbcBHBJoaGUtT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 02:09:44 +0100
Received: by mail-pa0-f68.google.com with SMTP id sv5so1953777pab.3
        for <linux-mips@linux-mips.org>; Sun, 07 Feb 2016 17:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EavHrjc2HwEPbHOa3N4yzK1CX7dCZK5nkbrXOfu5vOw=;
        b=qjvIwwSfM75muaIp5eKRyV/qHjFstp1nHFVeIfCHpKnzCAKnR4GDVAvk2DKgJKH6XZ
         MCUnYcvmwEM0oQxlKSYJ1VSz0ISTxzbSzJgG7WYcoErTWJ67NwUHjGBcX0YEP58WGUgW
         ta3ruAs+rQMWOiG1QRxNDtbQZHxedcm8mFUwMgwqqIznfMeXpMUCYaLj3buWZJpghi2v
         tyaddK80bhRDTj31tL1yyWfRlNCyemS4FKZOIgcdSsJLw8M36FjnhfgY8kLP/pX3vBmU
         yqk42rQtDEGPeH6eUQ9mvkgpiqcCgsWiRJJ8UQG2Co6W48npnxaCpinX1C15XVAePUTT
         oxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EavHrjc2HwEPbHOa3N4yzK1CX7dCZK5nkbrXOfu5vOw=;
        b=c9lWYL1e53lpPDX9JQBUZ3ygtgjjVDvna0DDxnf5LPsmQy1/ErQZGJT2MZsF07PaB+
         DEZXNXcbcjZ7CzpfIH9om6DpJ9EFuENv3H3io0GIGspJ4wz3c198MFgzpCfgOUk/jjLu
         yauJocUgskHMtQnTdzNXU9sLvLBoVjeOWo2Y/VoDkXWk/4d5br98+hOAaSoPb2sV5+9Q
         Jy5kZvK6BAOQg2vbbGAY9GqWLqUYe9YWP6BOq9WtNMQjPWIaDE7fkRNARFGDR1IKP9g2
         /VY2az/pvEwtRPbywomzd/DBp0ILyu3xjcfmiLPU4c0QPPc15RMA3ulVYJ8WA1IeGbn8
         69ww==
X-Gm-Message-State: AG10YOTE+BNRLCDC2PDPINm87wjYKTbsIJ4wzlX/Tclya1F0IEVNEDlTqHBYsCjdnGE2dQ==
X-Received: by 10.66.162.9 with SMTP id xw9mr38360671pab.46.1454893778872;
        Sun, 07 Feb 2016 17:09:38 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id wt2sm569211pac.48.2016.02.07.17.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 17:09:38 -0800 (PST)
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
Subject: [PATCH net-next v7 12/19] net: fcoe: use __ethtool_get_ksettings
Date:   Sun,  7 Feb 2016 17:08:56 -0800
Message-Id: <1454893743-6285-13-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
References: <1454893743-6285-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51833
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
 drivers/scsi/fcoe/fcoe_transport.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index d7597c0..2d5909f 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -93,36 +93,40 @@ static struct notifier_block libfcoe_notifier = {
 int fcoe_link_speed_update(struct fc_lport *lport)
 {
 	struct net_device *netdev = fcoe_get_netdev(lport);
-	struct ethtool_cmd ecmd;
+	struct ethtool_ksettings ecmd;
 
-	if (!__ethtool_get_settings(netdev, &ecmd)) {
+	if (!__ethtool_get_ksettings(netdev, &ecmd)) {
 		lport->link_supported_speeds &= ~(FC_PORTSPEED_1GBIT  |
 		                                  FC_PORTSPEED_10GBIT |
 		                                  FC_PORTSPEED_20GBIT |
 		                                  FC_PORTSPEED_40GBIT);
 
-		if (ecmd.supported & (SUPPORTED_1000baseT_Half |
-		                      SUPPORTED_1000baseT_Full |
-		                      SUPPORTED_1000baseKX_Full))
+		if (ecmd.link_modes.supported[0] & (
+			    SUPPORTED_1000baseT_Half |
+			    SUPPORTED_1000baseT_Full |
+			    SUPPORTED_1000baseKX_Full))
 			lport->link_supported_speeds |= FC_PORTSPEED_1GBIT;
 
-		if (ecmd.supported & (SUPPORTED_10000baseT_Full   |
-		                      SUPPORTED_10000baseKX4_Full |
-		                      SUPPORTED_10000baseKR_Full  |
-		                      SUPPORTED_10000baseR_FEC))
+		if (ecmd.link_modes.supported[0] & (
+			    SUPPORTED_10000baseT_Full   |
+			    SUPPORTED_10000baseKX4_Full |
+			    SUPPORTED_10000baseKR_Full  |
+			    SUPPORTED_10000baseR_FEC))
 			lport->link_supported_speeds |= FC_PORTSPEED_10GBIT;
 
-		if (ecmd.supported & (SUPPORTED_20000baseMLD2_Full |
-		                      SUPPORTED_20000baseKR2_Full))
+		if (ecmd.link_modes.supported[0] & (
+			    SUPPORTED_20000baseMLD2_Full |
+			    SUPPORTED_20000baseKR2_Full))
 			lport->link_supported_speeds |= FC_PORTSPEED_20GBIT;
 
-		if (ecmd.supported & (SUPPORTED_40000baseKR4_Full |
-		                      SUPPORTED_40000baseCR4_Full |
-		                      SUPPORTED_40000baseSR4_Full |
-		                      SUPPORTED_40000baseLR4_Full))
+		if (ecmd.link_modes.supported[0] & (
+			    SUPPORTED_40000baseKR4_Full |
+			    SUPPORTED_40000baseCR4_Full |
+			    SUPPORTED_40000baseSR4_Full |
+			    SUPPORTED_40000baseLR4_Full))
 			lport->link_supported_speeds |= FC_PORTSPEED_40GBIT;
 
-		switch (ethtool_cmd_speed(&ecmd)) {
+		switch (ecmd.parent.speed) {
 		case SPEED_1000:
 			lport->link_speed = FC_PORTSPEED_1GBIT;
 			break;
-- 
2.7.0.rc3.207.g0ac5344
