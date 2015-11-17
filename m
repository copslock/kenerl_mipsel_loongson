Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 17:11:34 +0100 (CET)
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:35140 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27005125AbbKRQLcMhtoG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 17:11:32 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 547CADAC9CB;
        Tue, 17 Nov 2015 20:36:16 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 70A81A6274;
        Tue, 17 Nov 2015 20:35:59 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 5/6] MIPS: ath79: Allow using ath79_ddr_wb_flush() from drivers
Date:   Tue, 17 Nov 2015 20:34:55 +0100
Message-Id: <1447788896-15553-6-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447788896-15553-1-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Move the declaration of ath79_ddr_wb_flush() to asm/mach-ath79/ath79.h
to allow using it from drivers. This is needed to move the CPU IRQ
driver to drivers/irqchip.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/common.h                 | 1 -
 arch/mips/include/asm/mach-ath79/ath79.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index ca7cc19..870c6b2 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -23,7 +23,6 @@ void ath79_clocks_init(void);
 unsigned long ath79_get_sys_clk_rate(const char *id);
 
 void ath79_ddr_ctrl_init(void);
-void ath79_ddr_wb_flush(unsigned int reg);
 
 void ath79_gpio_init(void);
 
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index ce493fc..22a2f56 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -115,6 +115,7 @@ static inline int soc_is_qca955x(void)
 	return soc_is_qca9556() || soc_is_qca9558();
 }
 
+void ath79_ddr_wb_flush(unsigned int reg);
 void ath79_ddr_set_pci_windows(void);
 
 extern void __iomem *ath79_pll_base;
-- 
2.0.0
