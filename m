Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2015 21:29:00 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44825 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026406AbbEBT1vt9GUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2015 21:27:51 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14372B50;
        Sat,  2 May 2015 19:27:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.19 039/177] MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
Date:   Sat,  2 May 2015 21:01:01 +0200
Message-Id: <20150502190121.370545948@linuxfoundation.org>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <20150502190119.666291882@linuxfoundation.org>
References: <20150502190119.666291882@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.19-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson/loongson-3/irq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -44,6 +44,7 @@ void mach_irq_dispatch(unsigned int pend
 
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
+	.flags = IRQF_NO_SUSPEND,
 	.name = "cascade",
 };
 
