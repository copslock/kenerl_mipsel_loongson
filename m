Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 14:32:33 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47432 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903821Ab1KPN3N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 14:29:13 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Matti Laakso <malaakso@elisanet.fi>
Subject: [PATCH V2 3/6] MIPS: lantiq: fix STP gpio groups
Date:   Wed, 16 Nov 2011 15:28:39 +0100
Message-Id: <1321453722-2689-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321453722-2689-1-git-send-email-blogic@openwrt.org>
References: <1321453722-2689-1-git-send-email-blogic@openwrt.org>
X-archive-position: 31666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13399

The STP engine has 3 groups of 8 pins. Only the first was activated by default.
This patch activates the 2 missing groups.

Signed-off-by: Matti Laakso <malaakso@elisanet.fi>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/gpio_stp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/gpio_stp.c b/arch/mips/lantiq/xway/gpio_stp.c
index 2c78660..cb6f170 100644
--- a/arch/mips/lantiq/xway/gpio_stp.c
+++ b/arch/mips/lantiq/xway/gpio_stp.c
@@ -35,6 +35,8 @@
 #define LTQ_STP_ADSL_SRC	(3 << 24)
 
 #define LTQ_STP_GROUP0		(1 << 0)
+#define LTQ_STP_GROUP1		(1 << 1)
+#define LTQ_STP_GROUP2		(1 << 2)
 
 #define LTQ_STP_RISING		0
 #define LTQ_STP_FALLING		(1 << 26)
@@ -93,8 +95,9 @@ static int ltq_stp_hw_init(void)
 	/* rising or falling edge */
 	ltq_stp_w32_mask(LTQ_STP_EDGE_MASK, LTQ_STP_FALLING, LTQ_STP_CON0);
 
-	/* per default stp 15-0 are set */
-	ltq_stp_w32_mask(0, LTQ_STP_GROUP0, LTQ_STP_CON1);
+	/* enable all three led groups */
+	ltq_stp_w32_mask(0, LTQ_STP_GROUP0 | LTQ_STP_GROUP1 | LTQ_STP_GROUP2,
+		LTQ_STP_CON1);
 
 	/* stp are update periodically by the FPI bus */
 	ltq_stp_w32_mask(LTQ_STP_UPD_MASK, LTQ_STP_UPD_FPI, LTQ_STP_CON1);
-- 
1.7.7.1
