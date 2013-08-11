Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:20:42 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4033 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825118Ab3HKJNkRbnsL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:40 +0200
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:07:11 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:20 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:20 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E8A67F2D74; Sun, 11
 Aug 2013 02:13:18 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 08/10] MIPS: Netlogic: XLP2xx update for I2C controller
Date:   Sun, 11 Aug 2013 14:43:58 +0530
Message-ID: <1376212440-21038-9-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198BB51R079371343-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37522
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

XLP2xx has a new I2C controller which has 4 buses connected to
it. Update the IO offset and IRQ mapping code to reflect this.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h |    3 +++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |    2 ++
 arch/mips/netlogic/xlp/nlm_hal.c               |   23 ++++++++++++++++-------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 9fac46f..61c84de 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -88,6 +88,9 @@
 #define XLP_IO_I2C0_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 2)
 #define XLP_IO_I2C1_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 3)
 #define XLP_IO_GPIO_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 4)
+/* on 2XX, all I2C busses are on the same block */
+#define XLP2XX_IO_I2C_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 7)
+
 /* system management */
 #define XLP_IO_SYS_OFFSET(node)		XLP_HDR_OFFSET(node, 0, 6, 5)
 #define XLP_IO_JTAG_OFFSET(node)	XLP_HDR_OFFSET(node, 0, 6, 6)
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 7a4a514..4950ea5 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -50,6 +50,8 @@
 #define PIC_MMC_IRQ			29
 #define PIC_I2C_0_IRQ			30
 #define PIC_I2C_1_IRQ			31
+#define PIC_I2C_2_IRQ			32
+#define PIC_I2C_3_IRQ			33
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 22e2e02..04adb75 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -93,11 +93,14 @@ int nlm_irq_to_irt(int irq)
 	case PIC_MMC_IRQ:
 		devoff = XLP_IO_SD_OFFSET(0);
 		break;
-	case PIC_I2C_0_IRQ:
-		devoff = XLP_IO_I2C0_OFFSET(0);
-		break;
+	case PIC_I2C_0_IRQ:	/* I2C will be fixed up */
 	case PIC_I2C_1_IRQ:
-		devoff = XLP_IO_I2C1_OFFSET(0);
+	case PIC_I2C_2_IRQ:
+	case PIC_I2C_3_IRQ:
+		if (cpu_is_xlpii())
+			devoff = XLP2XX_IO_I2C_OFFSET(0);
+		else
+			devoff = XLP_IO_I2C0_OFFSET(0);
 		break;
 	default:
 		devoff = 0;
@@ -107,9 +110,15 @@ int nlm_irq_to_irt(int irq)
 	if (devoff != 0) {
 		pcibase = nlm_pcicfg_base(devoff);
 		irt = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG) & 0xffff;
-		/* HW bug, I2C 1 irt entry is off by one */
-		if (irq == PIC_I2C_1_IRQ)
-			irt = irt + 1;
+		/* HW weirdness, I2C IRT entry has to be fixed up */
+		switch (irq) {
+		case PIC_I2C_1_IRQ:
+			irt = irt + 1; break;
+		case PIC_I2C_2_IRQ:
+			irt = irt + 2; break;
+		case PIC_I2C_3_IRQ:
+			irt = irt + 3; break;
+		}
 	} else if (irq >= PIC_PCIE_LINK_0_IRQ && irq <= PIC_PCIE_LINK_3_IRQ) {
 		/* HW bug, PCI IRT entries are bad on early silicon, fix */
 		irt = PIC_IRT_PCIE_LINK_INDEX(irq - PIC_PCIE_LINK_0_IRQ);
-- 
1.7.9.5
