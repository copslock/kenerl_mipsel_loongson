Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 13:27:30 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:19382 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026666AbbEKL00NNLod (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 13:26:26 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4BBQEau011256
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2015 11:26:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQEqp008299
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 11 May 2015 11:26:14 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQEcK006511;
        Mon, 11 May 2015 11:26:14 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.243.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2015 04:26:13 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction
Date:   Mon, 11 May 2015 07:17:15 -0400
Message-Id: <1431343152-19437-54-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
References: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Huacai Chen <chenhc@lemote.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 0add9c2f1cff9f3f1f2eb7e9babefa872a9d14b9 ]

HPET irq is routed to i8259 and then to MIPS CPU irq (cascade). After
commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq on CPU IRQs), if without
IRQF_NO_SUSPEND in cascade_irqaction, HPET interrupts will lost during
suspend. The result is machine cannot be waken up.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: <stable@vger.kernel.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/9528/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/loongson/loongson-3/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index ca1c62a..8f5209a 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -44,6 +44,7 @@ void mach_irq_dispatch(unsigned int pending)
 
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
+	.flags = IRQF_NO_SUSPEND,
 	.name = "cascade",
 };
 
-- 
2.1.0
