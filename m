Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 22:08:07 +0100 (CET)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36396 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013869AbbLNVEwi9hG0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 22:04:52 +0100
Received: by pfnn128 with SMTP id n128so2892559pfn.3
        for <linux-mips@linux-mips.org>; Mon, 14 Dec 2015 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ecebXXqzSyfaSCjRcMVu2iFn6+r/xHQyj3owjlrabgI=;
        b=pK9wEPWgxJiFbsMqnSdwHbzy/GpZWDSwiw8VLjv01xUbn4p17pcob38MHxD+G+8sjP
         ekKJYTHZZRWnDQW6xlQH1WitSQ11y1SGBnX3acMKsVgJU5ODSQRhcRLfMCj77U7UiJ5f
         eY5Wogn9BfdiYKFmXw+0oRVM0i/2FAtIzbHbgioRRkguR6FPI6UyFtXYhPfz+R9d0Ahj
         gbIb4rvCACknv5Fi3IMlWSnur4vIRBORFXU/Zghmn348oFXMFh2T+NV2y4nxppyNJ6xm
         otWDRJOgvm2nCVVVldMbrac734tf7husOqhkuprEFd9H9eGJlu+G+5W7JlmfLjP336JH
         mV9g==
X-Received: by 10.98.65.200 with SMTP id g69mr39528449pfd.33.1450127086971;
        Mon, 14 Dec 2015 13:04:46 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id 68sm13096148pfp.62.2015.12.14.13.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Dec 2015 13:04:45 -0800 (PST)
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
Subject: [PATCH net-next v5 12/19] net: fcoe: use __ethtool_get_ksettings
Date:   Mon, 14 Dec 2015 13:03:59 -0800
Message-Id: <1450127046-4573-13-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.6.0.rc2.230.g3dd15c0
In-Reply-To: <1450127046-4573-1-git-send-email-ddecotig@gmail.com>
References: <1450127046-4573-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50602
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
2.6.0.rc2.230.g3dd15c0
