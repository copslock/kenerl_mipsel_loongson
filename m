Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:17:25 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:57964 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992940AbeFYRQBonqow (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:16:01 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 04/25] MIPS: ath79: fix register address in ath79_ddr_wb_flush()
Date:   Mon, 25 Jun 2018 19:15:28 +0200
Message-Id: <20180625171549.4618-5-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Felix Fietkau <nbd@nbd.name>

ath79_ddr_wb_flush_base has the type void __iomem *, so register offsets
need to be a multiple of 4.

Cc: Alban Bedel <albeu@free.fr>
Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/ath79/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index fad32543a968..cd6055f9e7a0 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
 
 void ath79_ddr_wb_flush(u32 reg)
 {
-	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
+	void __iomem *flush_reg = ath79_ddr_wb_flush_base + (reg * 4);
 
 	/* Flush the DDR write buffer. */
 	__raw_writel(0x1, flush_reg);
-- 
2.11.0
