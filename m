Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:43:00 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:54634 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014102AbcCQMm7PCw4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:42:59 +0100
X-QQ-mid: bizesmtp7t1458218529t676t156
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 17 Mar 2016 20:41:29 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK60B00A0000000
X-QQ-FEAT: QomKxL1UMBIjFufH19Qc8u0X1fJxraKSTimQEsyUvcRlj5/EXWmCwQyWPHzPp
        nq7h6ZB7Nv2k2/UO0QokeLt+5L5Lh4XSzCCuSBwrjFaPS9c19mg7owqGnSHuTuNa2bAqVe0
        Bx+LEs3l6r2VD1OoEvsDuzql6tl5UNC873OsWbMyuPVs0cRUw/nLVWhi1pEcxA+4+IFk6lh
        4PR4lsAklIfTsJdk6UFl9NCaWiwlpSiiC2RXtgjSxnrshYBK/+8e01EpIDH0TjhopF8xsiO
        pBDoaD0XrZGBzJAITxNi9u/pY=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 4/4] MIPS: Loongson-3: Adjust irq dispatch to speedup processing
Date:   Thu, 17 Mar 2016 20:41:07 +0800
Message-Id: <1458218467-12210-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458218467-12210-1-git-send-email-chenhc@lemote.com>
References: <1458218467-12210-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patch adjust the logic in mach_irq_dispatch(), allow multiple IPs
handled in the same dispatching. This can speedup interrupt processing.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/irq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
index 0f75b6b..8e76490 100644
--- a/arch/mips/loongson64/loongson-3/irq.c
+++ b/arch/mips/loongson64/loongson-3/irq.c
@@ -24,19 +24,21 @@ static void ht_irqdispatch(void)
 	}
 }
 
+#define UNUSED_IPS (CAUSEF_IP5 | CAUSEF_IP4 | CAUSEF_IP1 | CAUSEF_IP0)
+
 void mach_irq_dispatch(unsigned int pending)
 {
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
 #if defined(CONFIG_SMP)
-	else if (pending & CAUSEF_IP6)
+	if (pending & CAUSEF_IP6)
 		loongson3_ipi_interrupt(NULL);
 #endif
-	else if (pending & CAUSEF_IP3)
+	if (pending & CAUSEF_IP3)
 		ht_irqdispatch();
-	else if (pending & CAUSEF_IP2)
+	if (pending & CAUSEF_IP2)
 		do_IRQ(LOONGSON_UART_IRQ);
-	else {
+	if (pending & UNUSED_IPS) {
 		pr_err("%s : spurious interrupt\n", __func__);
 		spurious_interrupt();
 	}
-- 
2.7.0
