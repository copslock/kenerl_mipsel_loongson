Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:33:33 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35171 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012484AbcBJAaOoiULx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:30:14 +0100
Received: by mail-pf0-f195.google.com with SMTP id 66so173038pfe.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EavHrjc2HwEPbHOa3N4yzK1CX7dCZK5nkbrXOfu5vOw=;
        b=pQeH6zaWBCjTTUNoxh71jibsyXkgEYwpx8zE+QD7PjQklrL3hCILlOIEiFjZgY0va7
         3cHYCN/9++36/PNAqcxaXJSGRAVUwfF9p72QA3ZoPPurrTzPD7wL9Dbhlm5dT2CdY29K
         f595zErVtAJQ1R3yVr01o8T2bDLFuxGFcvdXuzNyIr8crYB6CP2wCSWnqQExJXIXg+Xa
         hwiWKzmBXbu23t2m0+qSNDrhX+wTLC8W73gAet3XxabfJSM+Rf0bFMZMe+2Hh8wgKfwr
         pEIR+Mrv2SLG4aUqwbyuEKbGhmYnvp8qNpiNbPqW1y0YwqEwBvAvyJQ6RzsgsFNZZYfB
         syEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EavHrjc2HwEPbHOa3N4yzK1CX7dCZK5nkbrXOfu5vOw=;
        b=lac6PaTNYFsRuenkej8BAgdcQmrOlfzqFdvKnX2fOgAU+b2dm7IWsSdGA5uJHxFRZY
         5lAVVGFdJYPJquYyxzCBvQVHQxAxnBwDHhOce+fD3Nb0oGE9iBt8BoWEYFemUPqAsWPo
         gim5m2ePkXbB9ys6pacq11m9NAmQZZ4w60chq3YAgOUl+jZnjy+W4hiYt8Weyw+VqgLM
         yoG6tnH8Or3v/lcsedCHPdqWa6qO6c3JRjdBEOWcqsFkw8HfgPu0/ITZPdjGWFLPvetO
         IOmugptXuIzmvNAOYxSYVtypzV+xdV5QUR4fbeAEXfsu1zynPSJrM+sxSreGoJqbA3TO
         g9SA==
X-Gm-Message-State: AG10YOQnxoFN5KhQP0QzpSfRljQzefDiYwfC4nW7y0g3ahFgNDbfIKW2vaDwJKwvu9Xe/g==
X-Received: by 10.98.7.146 with SMTP id 18mr20621129pfh.47.1455064209163;
        Tue, 09 Feb 2016 16:30:09 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:30:07 -0800 (PST)
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
Subject: [PATCH net-next v8 12/19] net: fcoe: use __ethtool_get_ksettings
Date:   Tue,  9 Feb 2016 16:29:21 -0800
Message-Id: <1455064168-5102-13-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51950
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
