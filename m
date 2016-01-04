Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:24:12 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57779 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008821AbcADTYLCyURZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:24:11 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 69616280520;
        Mon,  4 Jan 2016 20:23:39 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:23:39 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/8] MIPS: ralink: add a symbol for INTC
Date:   Mon,  4 Jan 2016 20:23:54 +0100
Message-Id: <1451935441-40803-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Some of the newer SoCs use the GIC. This patch splits the INTC out into its
own symbol, allowing us to add the gic code in the following patch.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Kconfig  |    4 ++++
 arch/mips/ralink/Makefile |    2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index e9bc8c9..c578c5d9d 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -12,6 +12,10 @@ config RALINK_ILL_ACC
 	depends on SOC_RT305X
 	default y
 
+config IRQ_INTC
+	bool
+	default y
+
 choice
 	prompt "Ralink SoC selection"
 	default SOC_RT305X
diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index a6c9d00..06c315f 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_CLKEVT_RT3352) += cevt-rt3352.o
 
 obj-$(CONFIG_RALINK_ILL_ACC) += ill_acc.o
 
+obj-$(CONFIG_IRQ_INTC) += irq.o
+
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
 obj-$(CONFIG_SOC_RT3883) += rt3883.o
-- 
1.7.10.4
