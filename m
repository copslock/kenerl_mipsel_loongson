Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:34:33 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27795 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012779AbbEPOeWE3hGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:22 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYFsA004151
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYFa9012034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:15 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYFme012919;
        Sat, 16 May 2015 14:34:15 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:14 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Netlogic: Fix for SATA PHY init
Date:   Sat, 16 May 2015 10:33:16 -0400
Message-Id: <1431786833-25487-8-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 872cd4c2c617bb3a203ebe18115fd0c697112b87 ]

Update to the SATA PHY initialization. This is needed for SATA detection
to succeed in all configurations.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8886/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
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
2.1.0
