Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 13:36:33 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:64033 "EHLO
        tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492189Ab0FQLgX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 13:36:23 +0200
Received: from mailgate3.nec.co.jp ([10.7.69.195])
        by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5HBaJVL010593
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:36:19 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o5HBaJN18655 for linux-mips@linux-mips.org; Thu, 17 Jun 2010 20:36:19 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.64]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o5HBaI420090 for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:36:18 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay61.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:36:18 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:36:18 +0900
Message-ID: <4C1A08AD.7060708@renesas.com>
Date:   Thu, 17 Jun 2010 20:36:13 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 2/4] MIPS: EMMA2RH: Remove EMMA2RH_CPU_CASCADE
References: <4C1A0801.60405@renesas.com>
In-Reply-To: <4C1A0801.60405@renesas.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11956

Although all EMMAxxx SoCs can support IP2 and IP3 hardware interrupts,
current EMMA2RH plat_irq_dispatch() supports IP2 only.  We can make it
configurable in the future, but for the time being, would like to make
things explicitly allcated to IP2 in accordance with plat_irq_dispatch().

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/mips/emma/markeins/irq.c        |    2 +-
 arch/mips/include/asm/emma/emma2rh.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/emma/markeins/irq.c b/arch/mips/emma/markeins/irq.c
index 1d1c806..3a96799 100644
--- a/arch/mips/emma/markeins/irq.c
+++ b/arch/mips/emma/markeins/irq.c
@@ -301,7 +301,7 @@ void __init arch_init_irq(void)
 	/* setup cascade interrupts */
 	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_SW_CASCADE, &irq_cascade);
 	setup_irq(EMMA2RH_IRQ_BASE + EMMA2RH_GPIO_CASCADE, &irq_cascade);
-	setup_irq(MIPS_CPU_IRQ_BASE + CPU_EMMA2RH_CASCADE, &irq_cascade);
+	setup_irq(MIPS_CPU_IRQ_BASE + 2, &irq_cascade);
 }
 
 asmlinkage void plat_irq_dispatch(void)
diff --git a/arch/mips/include/asm/emma/emma2rh.h b/arch/mips/include/asm/emma/emma2rh.h
index fcc0064..95d0b7e 100644
--- a/arch/mips/include/asm/emma/emma2rh.h
+++ b/arch/mips/include/asm/emma/emma2rh.h
@@ -101,7 +101,6 @@
 
 #define NUM_EMMA2RH_IRQ		96
 
-#define CPU_EMMA2RH_CASCADE	2
 #define EMMA2RH_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)
 
 /*
-- 
1.7.1
