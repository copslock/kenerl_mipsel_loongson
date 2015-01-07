Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:23:08 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:25072 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010419AbbAGLV040MM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:26 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54169598"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 07 Jan 2015 03:35:55 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:38 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:37 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 576F940FE8;    Wed,  7 Jan 2015 03:20:35 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 05/17] MIPS: Netlogic: Fix for SATA PHY init
Date:   Wed, 7 Jan 2015 16:58:26 +0530
Message-ID: <1420630118-17198-6-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Update to the SATA PHY initialization. This is needed for SATA detection
to succeed in all configurations.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/ahci-init-xlp2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/netlogic/xlp/ahci-init-xlp2.c b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
index c83dbf3..7b066a4 100644
--- a/arch/mips/netlogic/xlp/ahci-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
@@ -203,6 +203,7 @@ static u8 read_phy_reg(u64 regbase, u32 addr, u32 physel)
 static void config_sata_phy(u64 regbase)
 {
 	u32 port, i, reg;
+	u8 val;
 
 	for (port = 0; port < 2; port++) {
 		for (i = 0, reg = RXCDRCALFOSC0; reg <= CALDUTY; reg++, i++)
@@ -210,6 +211,18 @@ static void config_sata_phy(u64 regbase)
 
 		for (i = 0, reg = RXDPIF; reg <= PPMDRIFTMAX_HI; reg++, i++)
 			write_phy_reg(regbase, reg, port, sata_phy_config2[i]);
+
+		/* Fix for PHY link up failures at lower temperatures */
+		write_phy_reg(regbase, 0x800F, port, 0x1f);
+
+		val = read_phy_reg(regbase, 0x0029, port);
+		write_phy_reg(regbase, 0x0029, port, val | (0x7 << 1));
+
+		val = read_phy_reg(regbase, 0x0056, port);
+		write_phy_reg(regbase, 0x0056, port, val & ~(1 << 3));
+
+		val = read_phy_reg(regbase, 0x0018, port);
+		write_phy_reg(regbase, 0x0018, port, val & ~(0x7 << 0));
 	}
 }
 
-- 
1.9.1
