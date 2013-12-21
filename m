Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:14:53 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:33332 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867254Ab3LULLC3K9NI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:11:02 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4602649"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw2-out.broadcom.com with ESMTP; 21 Dec 2013 03:17:42 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:11:01 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:11:01 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 5133C246A4;    Sat, 21 Dec 2013 03:11:00 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 12/18] MIPS: Netlogic: XLP9XX UART offset
Date:   Sat, 21 Dec 2013 16:52:24 +0530
Message-ID: <1387624950-31297-13-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38785
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

Update IO offset of the early console UART.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/uart.h |    3 ++-
 arch/mips/netlogic/common/earlycons.c         |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/uart.h b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
index 86d16e1..a6c5442 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/uart.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
@@ -94,7 +94,8 @@
 #define nlm_read_uart_reg(b, r)		nlm_read_reg(b, r)
 #define nlm_write_uart_reg(b, r, v)	nlm_write_reg(b, r, v)
 #define nlm_get_uart_pcibase(node, inst)	\
-		nlm_pcicfg_base(XLP_IO_UART_OFFSET(node, inst))
+	nlm_pcicfg_base(cpu_is_xlp9xx() ?  XLP9XX_IO_UART_OFFSET(node) : \
+						XLP_IO_UART_OFFSET(node, inst))
 #define nlm_get_uart_regbase(node, inst)	\
 			(nlm_get_uart_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
 
diff --git a/arch/mips/netlogic/common/earlycons.c b/arch/mips/netlogic/common/earlycons.c
index 1902fa2..769f930 100644
--- a/arch/mips/netlogic/common/earlycons.c
+++ b/arch/mips/netlogic/common/earlycons.c
@@ -37,9 +37,11 @@
 
 #include <asm/mipsregs.h>
 #include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
 
 #if defined(CONFIG_CPU_XLP)
 #include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/uart.h>
 #elif defined(CONFIG_CPU_XLR)
 #include <asm/netlogic/xlr/iomap.h>
-- 
1.7.9.5
