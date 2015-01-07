Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:26:10 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:30940 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010502AbbAGLVst0Qn0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:48 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54298915"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw2-out.broadcom.com with ESMTP; 07 Jan 2015 03:56:16 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:41 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:56 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 101E540FE5;    Wed,  7 Jan 2015 03:20:53 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Subhendu Sekhar Behera <sbehera@broadcom.com>,
        <ralf@linux-mips.org>, Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 16/17] MIPS: Netlogic: i2c IRQ mappings for XLP9XX
Date:   Wed, 7 Jan 2015 16:58:37 +0530
Message-ID: <1420630118-17198-17-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45001
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

From: Subhendu Sekhar Behera <sbehera@broadcom.com>

The new I2C block in XLP9XX has 4 interrupts, add the mapping for
these in nlm_hal.c

Signed-off-by: Subhendu Sekhar Behera <sbehera@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/nlm_hal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 8d743d0..a8f4144 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -71,6 +71,14 @@ static int xlp9xx_irq_to_irt(int irq)
 	switch (irq) {
 	case PIC_GPIO_IRQ:
 		return 12;
+	case PIC_I2C_0_IRQ:
+		return 125;
+	case PIC_I2C_1_IRQ:
+		return 126;
+	case PIC_I2C_2_IRQ:
+		return 127;
+	case PIC_I2C_3_IRQ:
+		return 128;
 	case PIC_9XX_XHCI_0_IRQ:
 		return 114;
 	case PIC_9XX_XHCI_1_IRQ:
-- 
1.9.1
