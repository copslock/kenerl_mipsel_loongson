Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 13:37:26 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:64162 "EHLO
        tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492191Ab0FQLhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 13:37:22 +0200
Received: from mailgate3.nec.co.jp ([10.7.69.195])
        by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5HBbKix010954
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:37:20 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o5HBbJm19877 for linux-mips@linux-mips.org; Thu, 17 Jun 2010 20:37:19 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.9]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o5HBbJ420264 for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:37:19 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay41.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:37:18 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:37:18 +0900
Message-ID: <4C1A08E9.9030808@renesas.com>
Date:   Thu, 17 Jun 2010 20:37:13 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 4/4] MIPS: EMMA2RH: Replace EMMA2RH_SW_IRQ_INTxx with EMMA2RH_SW_IRQ(n)
References: <4C1A0801.60405@renesas.com>
In-Reply-To: <4C1A0801.60405@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11958

Don't duplicate worthless lines.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/mips/include/asm/emma/markeins.h |   33 +--------------------------------
 1 files changed, 1 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/emma/markeins.h b/arch/mips/include/asm/emma/markeins.h
index 507f125..bf2d229 100644
--- a/arch/mips/include/asm/emma/markeins.h
+++ b/arch/mips/include/asm/emma/markeins.h
@@ -31,38 +31,7 @@
 #define EMMA2RH_SW_IRQ_BASE	(EMMA2RH_IRQ_BASE + NUM_EMMA2RH_IRQ)
 #define EMMA2RH_GPIO_IRQ_BASE	(EMMA2RH_SW_IRQ_BASE + NUM_EMMA2RH_IRQ_SW)
 
-#define EMMA2RH_SW_IRQ_INT0	(0+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT1	(1+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT2	(2+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT3	(3+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT4	(4+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT5	(5+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT6	(6+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT7	(7+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT8	(8+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT9	(9+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT10	(10+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT11	(11+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT12	(12+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT13	(13+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT14	(14+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT15	(15+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT16	(16+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT17	(17+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT18	(18+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT19	(19+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT20	(20+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT21	(21+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT22	(22+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT23	(23+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT24	(24+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT25	(25+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT26	(26+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT27	(27+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT28	(28+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT29	(29+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT30	(30+EMMA2RH_SW_IRQ_BASE)
-#define EMMA2RH_SW_IRQ_INT31	(31+EMMA2RH_SW_IRQ_BASE)
+#define EMMA2RH_SW_IRQ_INT(n)	(EMMA2RH_SW_IRQ_BASE + (n))
 
 #define MARKEINS_PCI_IRQ_INTA	EMMA2RH_GPIO_IRQ_BASE+15
 #define MARKEINS_PCI_IRQ_INTB	EMMA2RH_GPIO_IRQ_BASE+16
-- 
1.7.1
