Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 18:53:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1433 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993111AbcKVRwyy8KPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2016 18:52:54 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C92A0544A950F;
        Tue, 22 Nov 2016 17:52:45 +0000 (GMT)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 22 Nov 2016 17:52:48 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] MIPS: xilfpga: Use irqchip instead of the legacy way
Date:   Tue, 22 Nov 2016 17:52:38 +0000
Message-ID: <20161122175243.8853-2-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161122175243.8853-1-Zubair.Kakakhel@imgtec.com>
References: <20161122175243.8853-1-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

This prepares the code to use the Xilinx Interrupt Controller
driver in drivers/irqchip/irq-xilinx-intc.c

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/xilfpga/intc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/xilfpga/intc.c b/arch/mips/xilfpga/intc.c
index c4d1a71..a127cca 100644
--- a/arch/mips/xilfpga/intc.c
+++ b/arch/mips/xilfpga/intc.c
@@ -11,15 +11,12 @@
 
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/irqchip.h>
 
 #include <asm/irq_cpu.h>
 
-static struct of_device_id of_irq_ids[] __initdata = {
-	{ .compatible = "mti,cpu-interrupt-controller", .data = mips_cpu_irq_of_init },
-	{},
-};
 
 void __init arch_init_irq(void)
 {
-	of_irq_init(of_irq_ids);
+	irqchip_init();
 }
-- 
2.10.2
