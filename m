Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:56:56 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35697 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027464AbbEKRzo57u0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:44 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C8CCBB4;
        Mon, 11 May 2015 17:55:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 14/72] MIPS: Netlogic: Fix for SATA PHY init
Date:   Mon, 11 May 2015 10:54:20 -0700
Message-Id: <20150511175437.539346851@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Ganesan Ramalingam <ganesanr@broadcom.com>

Commit 872cd4c2c617bb3a203ebe18115fd0c697112b87 upstream.

Update to the SATA PHY initialization. This is needed for SATA detection
to succeed in all configurations.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8886/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/netlogic/xlp/ahci-init-xlp2.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/netlogic/xlp/ahci-init-xlp2.c
+++ b/arch/mips/netlogic/xlp/ahci-init-xlp2.c
@@ -203,6 +203,7 @@ static u8 read_phy_reg(u64 regbase, u32
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
 
