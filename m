Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:55:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19895 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006683AbbEVPzAaJHN8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:55:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F3E5C1B2AD085;
        Fri, 22 May 2015 16:54:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:53:53 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:53:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "David Daney" <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Jeffrey Deans" <jeffrey.deans@imgtec.com>
Subject: [PATCH 07/15] MIPS: remove [SR]ocIt(2) IRQ handling code
Date:   Fri, 22 May 2015 16:51:06 +0100
Message-ID: <1432309875-9712-8-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This code is only invoked from Malta's corehi_irqdispatch function,
which would then promptly die() even if it did service an interrupt.
It most definitely isn't needed for any vaguely recent Malta system
and since it seems to be broken for any older ones & nobody even
noticed, just remove it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/msc01_ic.h | 147 ------------------------------------
 arch/mips/kernel/Makefile        |   1 -
 arch/mips/kernel/irq-msc01.c     | 159 ---------------------------------------
 arch/mips/mti-malta/malta-int.c  |  53 -------------
 arch/mips/mti-malta/malta-time.c |   1 -
 5 files changed, 361 deletions(-)
 delete mode 100644 arch/mips/include/asm/msc01_ic.h
 delete mode 100644 arch/mips/kernel/irq-msc01.c

diff --git a/arch/mips/include/asm/msc01_ic.h b/arch/mips/include/asm/msc01_ic.h
deleted file mode 100644
index ff7f074..0000000
--- a/arch/mips/include/asm/msc01_ic.h
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * PCI Register definitions for the MIPS System Controller.
- *
- * Copyright (C) 2004 MIPS Technologies, Inc.  All rights reserved.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef __ASM_MIPS_BOARDS_MSC01_IC_H
-#define __ASM_MIPS_BOARDS_MSC01_IC_H
-
-/*****************************************************************************
- * Register offset addresses
- *****************************************************************************/
-
-#define MSC01_IC_RST_OFS     0x00008	/* Software reset	       */
-#define MSC01_IC_ENAL_OFS    0x00100	/* Int_in enable mask 31:0     */
-#define MSC01_IC_ENAH_OFS    0x00108	/* Int_in enable mask 63:32    */
-#define MSC01_IC_DISL_OFS    0x00120	/* Int_in disable mask 31:0    */
-#define MSC01_IC_DISH_OFS    0x00128	/* Int_in disable mask 63:32   */
-#define MSC01_IC_ISBL_OFS    0x00140	/* Raw int_in 31:0	       */
-#define MSC01_IC_ISBH_OFS    0x00148	/* Raw int_in 63:32	       */
-#define MSC01_IC_ISAL_OFS    0x00160	/* Masked int_in 31:0	       */
-#define MSC01_IC_ISAH_OFS    0x00168	/* Masked int_in 63:32	       */
-#define MSC01_IC_LVL_OFS     0x00180	/* Disable priority int_out    */
-#define MSC01_IC_RAMW_OFS    0x00180	/* Shadow set RAM (EI)	       */
-#define MSC01_IC_OSB_OFS     0x00188	/* Raw int_out		       */
-#define MSC01_IC_OSA_OFS     0x00190	/* Masked int_out	       */
-#define MSC01_IC_GENA_OFS    0x00198	/* Global HW int enable	       */
-#define MSC01_IC_BASE_OFS    0x001a0	/* Base address of IC_VEC      */
-#define MSC01_IC_VEC_OFS     0x001b0	/* Active int's vector address */
-#define MSC01_IC_EOI_OFS     0x001c0	/* Enable lower level ints     */
-#define MSC01_IC_CFG_OFS     0x001c8	/* Configuration register      */
-#define MSC01_IC_TRLD_OFS    0x001d0	/* Interval timer reload val   */
-#define MSC01_IC_TVAL_OFS    0x001e0	/* Interval timer current val  */
-#define MSC01_IC_TCFG_OFS    0x001f0	/* Interval timer config       */
-#define MSC01_IC_SUP_OFS     0x00200	/* Set up int_in line 0	       */
-#define MSC01_IC_ENA_OFS     0x00800	/* Int_in enable mask 63:0     */
-#define MSC01_IC_DIS_OFS     0x00820	/* Int_in disable mask 63:0    */
-#define MSC01_IC_ISB_OFS     0x00840	/* Raw int_in 63:0	       */
-#define MSC01_IC_ISA_OFS     0x00860	/* Masked int_in 63:0	       */
-
-/*****************************************************************************
- * Register field encodings
- *****************************************************************************/
-
-#define MSC01_IC_RST_RST_SHF	  0
-#define MSC01_IC_RST_RST_MSK	  0x00000001
-#define MSC01_IC_RST_RST_BIT	  MSC01_IC_RST_RST_MSK
-#define MSC01_IC_LVL_LVL_SHF	  0
-#define MSC01_IC_LVL_LVL_MSK	  0x000000ff
-#define MSC01_IC_LVL_SPUR_SHF	  16
-#define MSC01_IC_LVL_SPUR_MSK	  0x00010000
-#define MSC01_IC_LVL_SPUR_BIT	  MSC01_IC_LVL_SPUR_MSK
-#define MSC01_IC_RAMW_RIPL_SHF	  0
-#define MSC01_IC_RAMW_RIPL_MSK	  0x0000003f
-#define MSC01_IC_RAMW_DATA_SHF	  6
-#define MSC01_IC_RAMW_DATA_MSK	  0x00000fc0
-#define MSC01_IC_RAMW_ADDR_SHF	  25
-#define MSC01_IC_RAMW_ADDR_MSK	  0x7e000000
-#define MSC01_IC_RAMW_READ_SHF	  31
-#define MSC01_IC_RAMW_READ_MSK	  0x80000000
-#define MSC01_IC_RAMW_READ_BIT	  MSC01_IC_RAMW_READ_MSK
-#define MSC01_IC_OSB_OSB_SHF	  0
-#define MSC01_IC_OSB_OSB_MSK	  0x000000ff
-#define MSC01_IC_OSA_OSA_SHF	  0
-#define MSC01_IC_OSA_OSA_MSK	  0x000000ff
-#define MSC01_IC_GENA_GENA_SHF	  0
-#define MSC01_IC_GENA_GENA_MSK	  0x00000001
-#define MSC01_IC_GENA_GENA_BIT	  MSC01_IC_GENA_GENA_MSK
-#define MSC01_IC_CFG_DIS_SHF	  0
-#define MSC01_IC_CFG_DIS_MSK	  0x00000001
-#define MSC01_IC_CFG_DIS_BIT	  MSC01_IC_CFG_DIS_MSK
-#define MSC01_IC_CFG_SHFT_SHF	  8
-#define MSC01_IC_CFG_SHFT_MSK	  0x00000f00
-#define MSC01_IC_TCFG_ENA_SHF	  0
-#define MSC01_IC_TCFG_ENA_MSK	  0x00000001
-#define MSC01_IC_TCFG_ENA_BIT	  MSC01_IC_TCFG_ENA_MSK
-#define MSC01_IC_TCFG_INT_SHF	  8
-#define MSC01_IC_TCFG_INT_MSK	  0x00000100
-#define MSC01_IC_TCFG_INT_BIT	  MSC01_IC_TCFG_INT_MSK
-#define MSC01_IC_TCFG_EDGE_SHF	  16
-#define MSC01_IC_TCFG_EDGE_MSK	  0x00010000
-#define MSC01_IC_TCFG_EDGE_BIT	  MSC01_IC_TCFG_EDGE_MSK
-#define MSC01_IC_SUP_PRI_SHF	  0
-#define MSC01_IC_SUP_PRI_MSK	  0x00000007
-#define MSC01_IC_SUP_EDGE_SHF	  8
-#define MSC01_IC_SUP_EDGE_MSK	  0x00000100
-#define MSC01_IC_SUP_EDGE_BIT	  MSC01_IC_SUP_EDGE_MSK
-#define MSC01_IC_SUP_STEP	  8
-
-/*
- * MIPS System controller interrupt register base.
- *
- */
-
-/*****************************************************************************
- * Absolute register addresses
- *****************************************************************************/
-
-#define MSC01_IC_RST	 (MSC01_IC_REG_BASE + MSC01_IC_RST_OFS)
-#define MSC01_IC_ENAL	 (MSC01_IC_REG_BASE + MSC01_IC_ENAL_OFS)
-#define MSC01_IC_ENAH	 (MSC01_IC_REG_BASE + MSC01_IC_ENAH_OFS)
-#define MSC01_IC_DISL	 (MSC01_IC_REG_BASE + MSC01_IC_DISL_OFS)
-#define MSC01_IC_DISH	 (MSC01_IC_REG_BASE + MSC01_IC_DISH_OFS)
-#define MSC01_IC_ISBL	 (MSC01_IC_REG_BASE + MSC01_IC_ISBL_OFS)
-#define MSC01_IC_ISBH	 (MSC01_IC_REG_BASE + MSC01_IC_ISBH_OFS)
-#define MSC01_IC_ISAL	 (MSC01_IC_REG_BASE + MSC01_IC_ISAL_OFS)
-#define MSC01_IC_ISAH	 (MSC01_IC_REG_BASE + MSC01_IC_ISAH_OFS)
-#define MSC01_IC_LVL	 (MSC01_IC_REG_BASE + MSC01_IC_LVL_OFS)
-#define MSC01_IC_RAMW	 (MSC01_IC_REG_BASE + MSC01_IC_RAMW_OFS)
-#define MSC01_IC_OSB	 (MSC01_IC_REG_BASE + MSC01_IC_OSB_OFS)
-#define MSC01_IC_OSA	 (MSC01_IC_REG_BASE + MSC01_IC_OSA_OFS)
-#define MSC01_IC_GENA	 (MSC01_IC_REG_BASE + MSC01_IC_GENA_OFS)
-#define MSC01_IC_BASE	 (MSC01_IC_REG_BASE + MSC01_IC_BASE_OFS)
-#define MSC01_IC_VEC	 (MSC01_IC_REG_BASE + MSC01_IC_VEC_OFS)
-#define MSC01_IC_EOI	 (MSC01_IC_REG_BASE + MSC01_IC_EOI_OFS)
-#define MSC01_IC_CFG	 (MSC01_IC_REG_BASE + MSC01_IC_CFG_OFS)
-#define MSC01_IC_TRLD	 (MSC01_IC_REG_BASE + MSC01_IC_TRLD_OFS)
-#define MSC01_IC_TVAL	 (MSC01_IC_REG_BASE + MSC01_IC_TVAL_OFS)
-#define MSC01_IC_TCFG	 (MSC01_IC_REG_BASE + MSC01_IC_TCFG_OFS)
-#define MSC01_IC_SUP	 (MSC01_IC_REG_BASE + MSC01_IC_SUP_OFS)
-#define MSC01_IC_ENA	 (MSC01_IC_REG_BASE + MSC01_IC_ENA_OFS)
-#define MSC01_IC_DIS	 (MSC01_IC_REG_BASE + MSC01_IC_DIS_OFS)
-#define MSC01_IC_ISB	 (MSC01_IC_REG_BASE + MSC01_IC_ISB_OFS)
-#define MSC01_IC_ISA	 (MSC01_IC_REG_BASE + MSC01_IC_ISA_OFS)
-
-/*
- * Soc-it interrupts are configurable.
- * Every board describes its IRQ mapping with this table.
- */
-typedef struct msc_irqmap {
-	int	im_irq;
-	int	im_type;
-	int	im_lvl;
-} msc_irqmap_t;
-
-/* im_type */
-#define MSC01_IRQ_LEVEL		0
-#define MSC01_IRQ_EDGE		1
-
-extern void __init init_msc_irqs(unsigned long icubase, unsigned int base, msc_irqmap_t *imp, int nirq);
-extern void ll_msc_irq(void);
-
-#endif /* __ASM_MIPS_BOARDS_MSC01_IC_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d3d2ff2..738d943 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -64,7 +64,6 @@ obj-$(CONFIG_MIPS_VPE_APSP_API_MT) += rtlx-mt.o
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
 obj-$(CONFIG_IRQ_CPU_RM7K)	+= irq-rm7000.o
-obj-$(CONFIG_MIPS_MSC)		+= irq-msc01.o
 obj-$(CONFIG_IRQ_TXX9)		+= irq_txx9.o
 obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
 
diff --git a/arch/mips/kernel/irq-msc01.c b/arch/mips/kernel/irq-msc01.c
deleted file mode 100644
index a734b2c..0000000
--- a/arch/mips/kernel/irq-msc01.c
+++ /dev/null
@@ -1,159 +0,0 @@
-/*
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Copyright (c) 2004 MIPS Inc
- * Author: chris@mips.com
- *
- * Copyright (C) 2004, 06 Ralf Baechle <ralf@linux-mips.org>
- */
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/msc01_ic.h>
-#include <asm/traps.h>
-
-static unsigned long _icctrl_msc;
-#define MSC01_IC_REG_BASE	_icctrl_msc
-
-#define MSCIC_WRITE(reg, data)	do { *(volatile u32 *)(reg) = data; } while (0)
-#define MSCIC_READ(reg, data)	do { data = *(volatile u32 *)(reg); } while (0)
-
-static unsigned int irq_base;
-
-/* mask off an interrupt */
-static inline void mask_msc_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq;
-
-	if (irq < (irq_base + 32))
-		MSCIC_WRITE(MSC01_IC_DISL, 1<<(irq - irq_base));
-	else
-		MSCIC_WRITE(MSC01_IC_DISH, 1<<(irq - irq_base - 32));
-}
-
-/* unmask an interrupt */
-static inline void unmask_msc_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq;
-
-	if (irq < (irq_base + 32))
-		MSCIC_WRITE(MSC01_IC_ENAL, 1<<(irq - irq_base));
-	else
-		MSCIC_WRITE(MSC01_IC_ENAH, 1<<(irq - irq_base - 32));
-}
-
-/*
- * Masks and ACKs an IRQ
- */
-static void level_mask_and_ack_msc_irq(struct irq_data *d)
-{
-	mask_msc_irq(d);
-	if (!cpu_has_veic)
-		MSCIC_WRITE(MSC01_IC_EOI, 0);
-}
-
-/*
- * Masks and ACKs an IRQ
- */
-static void edge_mask_and_ack_msc_irq(struct irq_data *d)
-{
-	unsigned int irq = d->irq;
-
-	mask_msc_irq(d);
-	if (!cpu_has_veic)
-		MSCIC_WRITE(MSC01_IC_EOI, 0);
-	else {
-		u32 r;
-		MSCIC_READ(MSC01_IC_SUP+irq*8, r);
-		MSCIC_WRITE(MSC01_IC_SUP+irq*8, r | ~MSC01_IC_SUP_EDGE_BIT);
-		MSCIC_WRITE(MSC01_IC_SUP+irq*8, r);
-	}
-}
-
-/*
- * Interrupt handler for interrupts coming from SOC-it.
- */
-void ll_msc_irq(void)
-{
-	unsigned int irq;
-
-	/* read the interrupt vector register */
-	MSCIC_READ(MSC01_IC_VEC, irq);
-	if (irq < 64)
-		do_IRQ(irq + irq_base);
-	else {
-		/* Ignore spurious interrupt */
-	}
-}
-
-static void msc_bind_eic_interrupt(int irq, int set)
-{
-	MSCIC_WRITE(MSC01_IC_RAMW,
-		    (irq<<MSC01_IC_RAMW_ADDR_SHF) | (set<<MSC01_IC_RAMW_DATA_SHF));
-}
-
-static struct irq_chip msc_levelirq_type = {
-	.name = "SOC-it-Level",
-	.irq_ack = level_mask_and_ack_msc_irq,
-	.irq_mask = mask_msc_irq,
-	.irq_mask_ack = level_mask_and_ack_msc_irq,
-	.irq_unmask = unmask_msc_irq,
-	.irq_eoi = unmask_msc_irq,
-};
-
-static struct irq_chip msc_edgeirq_type = {
-	.name = "SOC-it-Edge",
-	.irq_ack = edge_mask_and_ack_msc_irq,
-	.irq_mask = mask_msc_irq,
-	.irq_mask_ack = edge_mask_and_ack_msc_irq,
-	.irq_unmask = unmask_msc_irq,
-	.irq_eoi = unmask_msc_irq,
-};
-
-
-void __init init_msc_irqs(unsigned long icubase, unsigned int irqbase, msc_irqmap_t *imp, int nirq)
-{
-	_icctrl_msc = (unsigned long) ioremap(icubase, 0x40000);
-
-	/* Reset interrupt controller - initialises all registers to 0 */
-	MSCIC_WRITE(MSC01_IC_RST, MSC01_IC_RST_RST_BIT);
-
-	board_bind_eic_interrupt = &msc_bind_eic_interrupt;
-
-	for (; nirq > 0; nirq--, imp++) {
-		int n = imp->im_irq;
-
-		switch (imp->im_type) {
-		case MSC01_IRQ_EDGE:
-			irq_set_chip_and_handler_name(irqbase + n,
-						      &msc_edgeirq_type,
-						      handle_edge_irq,
-						      "edge");
-			if (cpu_has_veic)
-				MSCIC_WRITE(MSC01_IC_SUP+n*8, MSC01_IC_SUP_EDGE_BIT);
-			else
-				MSCIC_WRITE(MSC01_IC_SUP+n*8, MSC01_IC_SUP_EDGE_BIT | imp->im_lvl);
-			break;
-		case MSC01_IRQ_LEVEL:
-			irq_set_chip_and_handler_name(irqbase + n,
-						      &msc_levelirq_type,
-						      handle_level_irq,
-						      "level");
-			if (cpu_has_veic)
-				MSCIC_WRITE(MSC01_IC_SUP+n*8, 0);
-			else
-				MSCIC_WRITE(MSC01_IC_SUP+n*8, imp->im_lvl);
-		}
-	}
-
-	irq_base = irqbase;
-
-	MSCIC_WRITE(MSC01_IC_GENA, MSC01_IC_GENA_GENA_BIT);	/* Enable interrupt generation */
-
-}
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 3fe5c17..ea809cf 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -35,7 +35,6 @@
 #include <asm/gt64120.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/msc01_pci.h>
-#include <asm/msc01_ic.h>
 #include <asm/setup.h>
 #include <asm/rtlx.h>
 
@@ -126,12 +125,6 @@ static void corehi_irqdispatch(void)
 	*/
 
 	switch (mips_revision_sconid) {
-	case MIPS_REVISION_SCON_SOCIT:
-	case MIPS_REVISION_SCON_ROCIT:
-	case MIPS_REVISION_SCON_SOCITSC:
-	case MIPS_REVISION_SCON_SOCITSCP:
-		ll_msc_irq();
-		break;
 	case MIPS_REVISION_SCON_GT64120:
 		intrcause = GT_READ(GT_INTRCAUSE_OFS);
 		datalo = GT_READ(GT_CPUERR_ADDRLO_OFS);
@@ -225,27 +218,6 @@ static struct irqaction corehi_irqaction = {
 	.flags = IRQF_NO_THREAD,
 };
 
-static msc_irqmap_t msc_irqmap[] __initdata = {
-	{MSC01C_INT_TMR,		MSC01_IRQ_EDGE, 0},
-	{MSC01C_INT_PCI,		MSC01_IRQ_LEVEL, 0},
-};
-static int msc_nr_irqs __initdata = ARRAY_SIZE(msc_irqmap);
-
-static msc_irqmap_t msc_eicirqmap[] __initdata = {
-	{MSC01E_INT_SW0,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_SW1,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_I8259A,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_SMI,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_COREHI,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_CORELO,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_TMR,		MSC01_IRQ_EDGE, 0},
-	{MSC01E_INT_PCI,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_PERFCTR,		MSC01_IRQ_LEVEL, 0},
-	{MSC01E_INT_CPUCTR,		MSC01_IRQ_LEVEL, 0}
-};
-
-static int msc_nr_eicirqs __initdata = ARRAY_SIZE(msc_eicirqmap);
-
 void __init arch_init_ipiirq(int irq, struct irqaction *action)
 {
 	setup_irq(irq, action);
@@ -258,31 +230,6 @@ void __init arch_init_irq(void)
 
 	irqchip_init();
 
-	switch (mips_revision_sconid) {
-	case MIPS_REVISION_SCON_SOCIT:
-	case MIPS_REVISION_SCON_ROCIT:
-		if (cpu_has_veic)
-			init_msc_irqs(MIPS_MSC01_IC_REG_BASE,
-					MSC01E_INT_BASE, msc_eicirqmap,
-					msc_nr_eicirqs);
-		else
-			init_msc_irqs(MIPS_MSC01_IC_REG_BASE,
-					MSC01C_INT_BASE, msc_irqmap,
-					msc_nr_irqs);
-		break;
-
-	case MIPS_REVISION_SCON_SOCITSC:
-	case MIPS_REVISION_SCON_SOCITSCP:
-		if (cpu_has_veic)
-			init_msc_irqs(MIPS_SOCITSC_IC_REG_BASE,
-					MSC01E_INT_BASE, msc_eicirqmap,
-					msc_nr_eicirqs);
-		else
-			init_msc_irqs(MIPS_SOCITSC_IC_REG_BASE,
-					MSC01C_INT_BASE, msc_irqmap,
-					msc_nr_irqs);
-	}
-
 	if (gic_present) {
 		corehi_irq = MIPS_CPU_IRQ_BASE + MIPSCPU_INT_COREHI;
 	} else {
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 185e682..fcdc156 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -37,7 +37,6 @@
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/mc146818-time.h>
-#include <asm/msc01_ic.h>
 
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/maltaint.h>
-- 
2.4.1
