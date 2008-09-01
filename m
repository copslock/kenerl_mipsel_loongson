Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 14:23:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:43484 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031168AbYIANWm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 14:22:42 +0100
Received: from localhost.localdomain (p5198-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1F692B562; Mon,  1 Sep 2008 22:22:37 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/6] TXx9: stop_unused_modules
Date:	Mon,  1 Sep 2008 22:22:36 +0900
Message-Id: <1220275361-5001-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TXx9 SoCs have pin multiplex.  Stop some controller modules which can
not be used due to pin configurations.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup_tx4927.c |   31 ++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   56 +++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index c4248cb..914e93c 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -252,3 +252,34 @@ void __init tx4927_mtd_init(int ch)
 		return;	/* disabled */
 	txx9_physmap_flash_init(ch, start, size, &pdata);
 }
+
+static void __init tx4927_stop_unused_modules(void)
+{
+	__u64 pcfg, rst = 0, ckd = 0;
+	char buf[128];
+
+	buf[0] = '\0';
+	local_irq_disable();
+	pcfg = ____raw_readq(&tx4927_ccfgptr->pcfg);
+	if (!(pcfg & TX4927_PCFG_SEL2)) {
+		rst |= TX4927_CLKCTR_ACLRST;
+		ckd |= TX4927_CLKCTR_ACLCKD;
+		strcat(buf, " ACLC");
+	}
+	if (rst | ckd) {
+		txx9_set64(&tx4927_ccfgptr->clkctr, rst);
+		txx9_set64(&tx4927_ccfgptr->clkctr, ckd);
+	}
+	local_irq_enable();
+	if (buf[0])
+		pr_info("%s: stop%s\n", txx9_pcode_str, buf);
+}
+
+static int __init tx4927_late_init(void)
+{
+	if (txx9_pcode != 0x4927)
+		return -ENODEV;
+	tx4927_stop_unused_modules();
+	return 0;
+}
+late_initcall(tx4927_late_init);
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 0d8517a..af724e5 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -334,3 +334,59 @@ void __init tx4938_mtd_init(int ch)
 		return;	/* disabled */
 	txx9_physmap_flash_init(ch, start, size, &pdata);
 }
+
+static void __init tx4938_stop_unused_modules(void)
+{
+	__u64 pcfg, rst = 0, ckd = 0;
+	char buf[128];
+
+	buf[0] = '\0';
+	local_irq_disable();
+	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);
+	switch (txx9_pcode) {
+	case 0x4937:
+		if (!(pcfg & TX4938_PCFG_SEL2)) {
+			rst |= TX4938_CLKCTR_ACLRST;
+			ckd |= TX4938_CLKCTR_ACLCKD;
+			strcat(buf, " ACLC");
+		}
+		break;
+	case 0x4938:
+		if (!(pcfg & TX4938_PCFG_SEL2) ||
+		    (pcfg & TX4938_PCFG_ETH0_SEL)) {
+			rst |= TX4938_CLKCTR_ACLRST;
+			ckd |= TX4938_CLKCTR_ACLCKD;
+			strcat(buf, " ACLC");
+		}
+		if ((pcfg &
+		     (TX4938_PCFG_ATA_SEL | TX4938_PCFG_ISA_SEL |
+		      TX4938_PCFG_NDF_SEL))
+		    != TX4938_PCFG_NDF_SEL) {
+			rst |= TX4938_CLKCTR_NDFRST;
+			ckd |= TX4938_CLKCTR_NDFCKD;
+			strcat(buf, " NDFMC");
+		}
+		if (!(pcfg & TX4938_PCFG_SPI_SEL)) {
+			rst |= TX4938_CLKCTR_SPIRST;
+			ckd |= TX4938_CLKCTR_SPICKD;
+			strcat(buf, " SPI");
+		}
+		break;
+	}
+	if (rst | ckd) {
+		txx9_set64(&tx4938_ccfgptr->clkctr, rst);
+		txx9_set64(&tx4938_ccfgptr->clkctr, ckd);
+	}
+	local_irq_enable();
+	if (buf[0])
+		pr_info("%s: stop%s\n", txx9_pcode_str, buf);
+}
+
+static int __init tx4938_late_init(void)
+{
+	if (txx9_pcode != 0x4937 && txx9_pcode != 0x4938)
+		return -ENODEV;
+	tx4938_stop_unused_modules();
+	return 0;
+}
+late_initcall(tx4938_late_init);
-- 
1.5.6.3
