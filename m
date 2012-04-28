Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:16:45 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1440 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903711Ab2D1NNH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:13:07 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:12:56 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:05 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 278B49F9F5; Sat, 28
 Apr 2012 06:12:44 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:43 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 07/12] MIPS: Netlogic: Remove NETLOGIC_ prefix
Date:   Sat, 28 Apr 2012 18:42:13 +0530
Message-ID: <1335618738-4679-8-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638533523JG2109447-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove NETLOGIC_ prefix from gpio register definitions, this will
bring it in-line with the other Netlogic headers.

Having NETLOGIC prefix here is misleading because these are XLR/XLS
specific register definitions.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/xlr/gpio.h |   59 +++++++++++++++--------------
 arch/mips/netlogic/xlr/setup.c            |    2 +-
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlr/gpio.h b/arch/mips/include/asm/netlogic/xlr/gpio.h
index 51f6ad4..8492e83 100644
--- a/arch/mips/include/asm/netlogic/xlr/gpio.h
+++ b/arch/mips/include/asm/netlogic/xlr/gpio.h
@@ -35,39 +35,40 @@
 #ifndef _ASM_NLM_GPIO_H
 #define _ASM_NLM_GPIO_H
 
-#define NETLOGIC_GPIO_INT_EN_REG		0
-#define NETLOGIC_GPIO_INPUT_INVERSION_REG	1
-#define NETLOGIC_GPIO_IO_DIR_REG		2
-#define NETLOGIC_GPIO_IO_DATA_WR_REG		3
-#define NETLOGIC_GPIO_IO_DATA_RD_REG		4
+#define GPIO_INT_EN_REG			0
+#define GPIO_INPUT_INVERSION_REG	1
+#define GPIO_IO_DIR_REG			2
+#define GPIO_IO_DATA_WR_REG		3
+#define GPIO_IO_DATA_RD_REG		4
 
-#define NETLOGIC_GPIO_SWRESET_REG		8
-#define NETLOGIC_GPIO_DRAM1_CNTRL_REG		9
-#define NETLOGIC_GPIO_DRAM1_RATIO_REG		10
-#define NETLOGIC_GPIO_DRAM1_RESET_REG		11
-#define NETLOGIC_GPIO_DRAM1_STATUS_REG		12
-#define NETLOGIC_GPIO_DRAM2_CNTRL_REG		13
-#define NETLOGIC_GPIO_DRAM2_RATIO_REG		14
-#define NETLOGIC_GPIO_DRAM2_RESET_REG		15
-#define NETLOGIC_GPIO_DRAM2_STATUS_REG		16
+#define GPIO_SWRESET_REG		8
+#define GPIO_DRAM1_CNTRL_REG		9
+#define GPIO_DRAM1_RATIO_REG		10
+#define GPIO_DRAM1_RESET_REG		11
+#define GPIO_DRAM1_STATUS_REG		12
+#define GPIO_DRAM2_CNTRL_REG		13
+#define GPIO_DRAM2_RATIO_REG		14
+#define GPIO_DRAM2_RESET_REG		15
+#define GPIO_DRAM2_STATUS_REG		16
 
-#define NETLOGIC_GPIO_PWRON_RESET_CFG_REG	21
-#define NETLOGIC_GPIO_BIST_ALL_GO_STATUS_REG	24
-#define NETLOGIC_GPIO_BIST_CPU_GO_STATUS_REG	25
-#define NETLOGIC_GPIO_BIST_DEV_GO_STATUS_REG	26
+#define GPIO_PWRON_RESET_CFG_REG	21
+#define GPIO_BIST_ALL_GO_STATUS_REG	24
+#define GPIO_BIST_CPU_GO_STATUS_REG	25
+#define GPIO_BIST_DEV_GO_STATUS_REG	26
 
-#define NETLOGIC_GPIO_FUSE_BANK_REG		35
-#define NETLOGIC_GPIO_CPU_RESET_REG		40
-#define NETLOGIC_GPIO_RNG_REG			43
+#define GPIO_FUSE_BANK_REG		35
+#define GPIO_CPU_RESET_REG		40
+#define GPIO_RNG_REG			43
 
-#define NETLOGIC_PWRON_RESET_PCMCIA_BOOT	17
-#define NETLOGIC_GPIO_LED_BITMAP	0x1700000
-#define NETLOGIC_GPIO_LED_0_SHIFT		20
-#define NETLOGIC_GPIO_LED_1_SHIFT		24
+#define PWRON_RESET_PCMCIA_BOOT		17
 
-#define NETLOGIC_GPIO_LED_OUTPUT_CODE_RESET	0x01
-#define NETLOGIC_GPIO_LED_OUTPUT_CODE_HARD_RESET 0x02
-#define NETLOGIC_GPIO_LED_OUTPUT_CODE_SOFT_RESET 0x03
-#define NETLOGIC_GPIO_LED_OUTPUT_CODE_MAIN	0x04
+#define GPIO_LED_BITMAP			0x1700000
+#define GPIO_LED_0_SHIFT		20
+#define GPIO_LED_1_SHIFT		24
+
+#define GPIO_LED_OUTPUT_CODE_RESET	0x01
+#define GPIO_LED_OUTPUT_CODE_HARD_RESET 0x02
+#define GPIO_LED_OUTPUT_CODE_SOFT_RESET 0x03
+#define GPIO_LED_OUTPUT_CODE_MAIN	0x04
 
 #endif
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index c9d066d..81b1d31 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -85,7 +85,7 @@ static void nlm_linux_exit(void)
 
 	gpiobase = nlm_mmio_base(NETLOGIC_IO_GPIO_OFFSET);
 	/* trigger a chip reset by writing 1 to GPIO_SWRESET_REG */
-	nlm_write_reg(gpiobase, NETLOGIC_GPIO_SWRESET_REG, 1);
+	nlm_write_reg(gpiobase, GPIO_SWRESET_REG, 1);
 	for ( ; ; )
 		cpu_wait();
 }
-- 
1.7.9.5
