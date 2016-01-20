Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 01:47:59 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35786 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014802AbcATAo2EfZ8w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 01:44:28 +0100
Received: by mail-pf0-f195.google.com with SMTP id 65so13873720pff.2
        for <linux-mips@linux-mips.org>; Tue, 19 Jan 2016 16:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EavHrjc2HwEPbHOa3N4yzK1CX7dCZK5nkbrXOfu5vOw=;
        b=KfJbQ1jSghxFOVFwjAyjJPoymSD2Kf477DjoDDjOrJ7jflDecVFzb8vTdHKDxj67Po
         NcqTG0tPI3BHC8riK1EHSPnNAv/bqE4Z4Zyb5eO4Si+qxInjXSsrN5Ucojgynmr+6ngB
         iZaI6e9E/SZ7k/BX3P1xYOmUsRMyzCdD2CXMhgqeu982H9wvVJigVEhqGoH5jsN7qteo
         vfS/ek9F5OzS9BisPDPsOhRZrVxZMPIqn+Tt5xs0qhpTewKE8XhyV/Bxi0P0MpwtWxJG
         4vEzfWSINWec4xRw07rWK0ST3/y3Lup4lthJRk3fJ5xBhnlCz9MmKcW6mkpYARQZ0j4i
         uelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EavHrjc2HwEPbHOa3N4yzK1CX7dCZK5nkbrXOfu5vOw=;
        b=KQTNCseYQgHoxsU7xbi8I6VRWAW9LjurhP2HgT15UTtSMYMe6zFZvYVG3r+c5MJMLv
         ipJmrFmmwXL/Qh7ooh3l0P/ao5eZGIxmlfsehvvSzRjztRYTK0tsZzwWPbWzkiqUw9W9
         aEeVW13SgQ1Qrw12afQvPmgysBbjl9PFiIOijTa6y9yF3QWv84BLlhbwTja7C9Ks8ktY
         R9Fo/4znrBy2guzreLay4V6+VnHjfeVQ1MiPnbZc+aFQrsx7sxV3rLB+xD9wUvyw3ODR
         j/Y8PlfDKR8sZL6+IVfRzb3FKFSlwCiSK1uKohttYNoyYd2FSVz6Spb6HZt+jBXlEs+h
         e58g==
X-Gm-Message-State: ALoCoQmKVB85sNbWxStbHG7dGZY1FGh72ey9ZzM4h/aL7E7kImFS60wTyFOAzG46ECcC5ICiZBSP3jsyjPIH3FI8GaQuWfT0MQ==
X-Received: by 10.98.16.139 with SMTP id 11mr48615142pfq.128.1453250662445;
        Tue, 19 Jan 2016 16:44:22 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id cq4sm44444099pad.28.2016.01.19.16.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 16:44:21 -0800 (PST)
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
Subject: [PATCH net-next v6 12/19] net: fcoe: use __ethtool_get_ksettings
Date:   Tue, 19 Jan 2016 16:43:57 -0800
Message-Id: <1453250644-14796-13-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
In-Reply-To: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
References: <1453250644-14796-1-git-send-email-ddecotig@gmail.com>
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51240
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
