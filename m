Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2012 12:03:25 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4610 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903526Ab2GPKDQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jul 2012 12:03:16 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 16 Jul 2012 03:02:11 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 16 Jul 2012 03:02:55 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E4C6A9FA01; Mon, 16
 Jul 2012 03:02:52 -0700 (PDT)
Received: from jc-virtual-machine.netlogicmicro.com (10.7.2.153) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Mon, 16 Jul 2012 03:02:52 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Florian Fainelli" <florian@openwrt.org>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH UPDATED 06/12] MIPS: Netlogic: early console fix
Date:   Mon, 16 Jul 2012 15:33:37 +0530
Message-ID: <1342433017-24485-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2602396.OWAlsVeLic@flexo>
References: <2602396.OWAlsVeLic@flexo>
MIME-Version: 1.0
X-Originating-IP: [10.7.2.153]
X-WSS-ID: 7C1D39293MK10332603-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33930
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
[Updated to use UART_LSR_THRE instead of 0x20, as suggested by 
 Florian Fainelli <florian@openwrt.org>]

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
+	while ((nlm_read_reg(uartbase, UART_LSR) & UART_LSR_THRE) == 0)
 		;
 	nlm_write_reg(uartbase, UART_TX, c);
 }
-- 
1.7.9.5
