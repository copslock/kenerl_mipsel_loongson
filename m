Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2015 11:47:58 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:59309 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012164AbbEGJrzMSVNN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 May 2015 11:47:55 +0200
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1YqIPF-0002Fa-F8; Thu, 07 May 2015 09:47:49 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 067/180] MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
Date:   Thu,  7 May 2015 10:44:36 +0100
Message-Id: <1430991989-23170-68-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430991989-23170-1-git-send-email-luis.henriques@canonical.com>
References: <1430991989-23170-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt11 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 0add9c2f1cff9f3f1f2eb7e9babefa872a9d14b9 upstream.

HPET irq is routed to i8259 and then to MIPS CPU irq (cascade). After
commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq on CPU IRQs), if without
IRQF_NO_SUSPEND in cascade_irqaction, HPET interrupts will lost during
suspend. The result is machine cannot be waken up.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/9528/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/loongson/loongson-3/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index f240828181ff..f2077f201a2a 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -42,6 +42,7 @@ void mach_irq_dispatch(unsigned int pending)
 
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
+	.flags = IRQF_NO_SUSPEND,
 	.name = "cascade",
 };
 
