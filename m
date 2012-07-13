Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:25:48 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2885 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903718Ab2GMQYc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:32 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:24 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:23:42 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 252499F9F5; Fri, 13
 Jul 2012 09:24:22 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:21 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 06/12] MIPS: Netlogic: early console fix
Date:   Fri, 13 Jul 2012 21:53:19 +0530
Message-ID: <1342196605-4260-7-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94F63NK5403962-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

In prom_putchar(), wait for just the TX empty bit to clear in the
UART LSR.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/common/earlycons.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/common/earlycons.c b/arch/mips/netlogic/common/earlycons.c
index f193f7b..53b200a5 100644
--- a/arch/mips/netlogic/common/earlycons.c
+++ b/arch/mips/netlogic/common/earlycons.c
@@ -54,7 +54,7 @@ void prom_putchar(char c)
 #elif defined(CONFIG_CPU_XLR)
 	uartbase = nlm_mmio_base(NETLOGIC_IO_UART_0_OFFSET);
 #endif
-	while (nlm_read_reg(uartbase, UART_LSR) == 0)
+	while ((nlm_read_reg(uartbase, UART_LSR) & 0x20) == 0)
 		;
 	nlm_write_reg(uartbase, UART_TX, c);
 }
-- 
1.7.9.5
