Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2016 02:34:34 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:43107 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012109AbcCGBeaRK6s4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2016 02:34:30 +0100
X-QQ-mid: bizesmtp11t1457314399t393t26
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 07 Mar 2016 09:32:29 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: JOVh5Yj1n8YYXt5/mvOETTSqYRUGOneglUX6R1uWmbax2Z+OluTh5dtqqxIKa
        0dibdSkKqTV6y35X0oAtRcV8LGIQUuPvqnPRwjADcj6SNrz65qwC/hJev+k2LAzduTiQS3B
        RyXjgkC00LG5NBRntgfp+Y2PhjmhQ5f+Kvn4Sr9wXepZmPs8g9YML+JuIbKt+8bZOnVdHcN
        BNBJ/B/z/cHVuJJIjFFXF4Z1XwYK04H5BkYo9PHsubPpf5t6qAxcqgpwj15cb+UdDioujvD
        SYZPY9w7niigDNa7Uwqji5tFE=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 3/3] MIPS: Loongson-3: Adjust irq dispatch to speedup processing
Date:   Mon,  7 Mar 2016 09:31:47 +0800
Message-Id: <1457314307-8510-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457314307-8510-1-git-send-email-chenhc@lemote.com>
References: <1457314307-8510-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52485
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
