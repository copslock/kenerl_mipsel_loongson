Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 15:56:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60475 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992483AbcHON4DwCl7j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 15:56:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 74AC5E7871F25;
        Mon, 15 Aug 2016 14:55:44 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 15 Aug 2016 14:55:47 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>
CC:     <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <Zubair.Kakakhel@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 1/9] microblaze: irqchip: Move intc driver to irqchip
Date:   Mon, 15 Aug 2016 14:55:27 +0100
Message-ID: <1471269335-58747-2-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54537
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

The Xilinx AXI Interrupt Controller IP block is used by the MIPS
based xilfpga platform.

Move the interrupt controller code out of arch/microblaze so that
it can be used by everyone

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/microblaze/Kconfig                                       | 1 +
 arch/microblaze/kernel/Makefile                               | 2 +-
 drivers/irqchip/Kconfig                                       | 4 ++++
 drivers/irqchip/Makefile                                      | 1 +
 arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx.c | 0
 5 files changed, 7 insertions(+), 1 deletion(-)
 rename arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx.c (100%)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 86f6572..198e921 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -27,6 +27,7 @@ config MICROBLAZE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_OPROFILE
 	select IRQ_DOMAIN
+	select XILINX_IRQ
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index f08baca..e098381 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -15,7 +15,7 @@ endif
 extra-y := head.o vmlinux.lds
 
 obj-y += dma.o exceptions.o \
-	hw_exception_handler.o intc.o irq.o \
+	hw_exception_handler.o irq.o \
 	platform.o process.o prom.o ptrace.o \
 	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7f87289..b5e40ee 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -203,6 +203,10 @@ config XTENSA_MX
 	bool
 	select IRQ_DOMAIN
 
+config XILINX_IRQ
+	bool
+	select IRQ_DOMAIN
+
 config IRQ_CROSSBAR
 	bool
 	help
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 4c203b6..2bd833d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
 obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
+obj-$(CONFIG_XILINX_IRQ)		+= irq-xilinx.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
 obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
 obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
diff --git a/arch/microblaze/kernel/intc.c b/drivers/irqchip/irq-xilinx.c
similarity index 100%
rename from arch/microblaze/kernel/intc.c
rename to drivers/irqchip/irq-xilinx.c
-- 
1.9.1
