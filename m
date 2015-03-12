Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 04:53:01 +0100 (CET)
Received: from smtpbg62.qq.com ([103.7.29.139]:22135 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006539AbbCLDw6rTb0o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Mar 2015 04:52:58 +0100
X-QQ-mid: bizesmtp5t1426132356t188t174
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 12 Mar 2015 11:52:20 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52000A0000000
X-QQ-FEAT: xflb0yrtfs90dNpFCAaQbUIvf38ClDW428lZ5FS4H0A5UFAcCe2Xja0SBBgFp
        Qgrcz/XKqyqNckLWvAAg0QJFFAwftQmLbXfybZxFlccY+i7UfvOvO3HRUcZ3t+A5ITU41GG
        mkIZYENhBDnlujyPoQbgCplXgU9OQ9jGV1GnEFJJjrB+pvFJMLpwFm1kJOw9Ojk7JytRpuJ
        voRcA2x6hKipZXHGkmf8vu43Get/IcBKolPXA1rpzXw==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
Date:   Thu, 12 Mar 2015 11:51:06 +0800
Message-Id: <1426132266-30379-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46342
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

HPET irq is routed to i8259 and then to MIPS CPU irq (cascade). After
commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq on CPU IRQs), if without
IRQF_NO_SUSPEND in cascade_irqaction, HPET interrupts will lost during
suspend. The result is machine cannot be waken up.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson/loongson-3/irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index 21221ed..0f75b6b 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -44,6 +44,7 @@ void mach_irq_dispatch(unsigned int pending)
 
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
+	.flags = IRQF_NO_SUSPEND,
 	.name = "cascade",
 };
 
-- 
1.7.7.3
