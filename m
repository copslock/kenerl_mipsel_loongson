Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Aug 2015 14:04:50 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:21695 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010940AbbHAMDnKxt8t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Aug 2015 14:03:43 +0200
X-IronPort-AV: E=Sophos;i="5.15,591,1432623600"; 
   d="scan'208";a="71459052"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 01 Aug 2015 06:19:21 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Sat, 1 Aug 2015 05:03:38 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.235.1; Sat, 1 Aug 2015 05:03:38 -0700
Received: from netl-snoppy.ban.broadcom.com (unknown [10.132.128.129])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id CD25840FE5;  Sat,  1 Aug
 2015 05:01:22 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Subhendu Sekhar Behera <sbehera@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 4/4] MIPS: Netlogic: NAND IRQ mapping
Date:   Sat, 1 Aug 2015 17:44:23 +0530
Message-ID: <1438431263-12427-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
References: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48525
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

Add NAND IRQ mapping for XLP9xx processor.

Signed-off-by: Subhendu Sekhar Behera <sbehera@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/nlm_hal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index a8f4144..80ec929 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -91,6 +91,8 @@ static int xlp9xx_irq_to_irt(int irq)
 		return 134;
 	case PIC_SATA_IRQ:
 		return 143;
+	case PIC_NAND_IRQ:
+		return 151;
 	case PIC_SPI_IRQ:
 		return 152;
 	case PIC_MMC_IRQ:
-- 
1.9.1
