Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 10:32:55 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53112 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493621Ab1HXIaF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2011 10:30:05 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 6/8] MIPS: lantiq: add basic support for FALC-ON
Date:   Wed, 24 Aug 2011 10:31:42 +0200
Message-Id: <1314174704-15549-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
References: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
X-archive-position: 30971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17649

Adds support for the FALC-ON SoC. This SoC is from the fiber to the home GPON
series.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 .../include/asm/mach-lantiq/falcon/falcon_irq.h    |  268 ++++++++++++++++++++
 arch/mips/include/asm/mach-lantiq/falcon/irq.h     |   18 ++
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |  140 ++++++++++
 arch/mips/include/asm/mach-lantiq/lantiq.h         |    1 +
 arch/mips/lantiq/Kconfig                           |    4 +
 arch/mips/lantiq/Makefile                          |    1 +
 arch/mips/lantiq/Platform                          |    1 +
 arch/mips/lantiq/falcon/Makefile                   |    1 +
 arch/mips/lantiq/falcon/clk.c                      |   44 ++++
 arch/mips/lantiq/falcon/devices.c                  |   87 +++++++
 arch/mips/lantiq/falcon/devices.h                  |   18 ++
 arch/mips/lantiq/falcon/prom.c                     |   72 ++++++
 arch/mips/lantiq/falcon/reset.c                    |   87 +++++++
 arch/mips/lantiq/falcon/sysctrl.c                  |  181 +++++++++++++
 14 files changed, 923 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/irq.h
 create mode 100644 arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
 create mode 100644 arch/mips/lantiq/falcon/Makefile
 create mode 100644 arch/mips/lantiq/falcon/clk.c
 create mode 100644 arch/mips/lantiq/falcon/devices.c
 create mode 100644 arch/mips/lantiq/falcon/devices.h
 create mode 100644 arch/mips/lantiq/falcon/prom.c
 create mode 100644 arch/mips/lantiq/falcon/reset.c
 create mode 100644 arch/mips/lantiq/falcon/sysctrl.c

diff --git a/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
new file mode 100644
index 0000000..4dc6466
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/falcon_irq.h
@@ -0,0 +1,268 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
+ */
+
+#ifndef _FALCON_IRQ__
+#define _FALCON_IRQ__
+
+#define INT_NUM_IRQ0			8
+#define INT_NUM_IM0_IRL0		(INT_NUM_IRQ0 + 0)
+#define INT_NUM_IM1_IRL0		(INT_NUM_IM0_IRL0 + 32)
+#define INT_NUM_IM2_IRL0		(INT_NUM_IM1_IRL0 + 32)
+#define INT_NUM_IM3_IRL0		(INT_NUM_IM2_IRL0 + 32)
+#define INT_NUM_IM4_IRL0		(INT_NUM_IM3_IRL0 + 32)
+#define INT_NUM_EXTRA_START		(INT_NUM_IM4_IRL0 + 32)
+#define INT_NUM_IM_OFFSET		(INT_NUM_IM1_IRL0 - INT_NUM_IM0_IRL0)
+
+#define MIPS_CPU_TIMER_IRQ			7
+
+/* HOST IF Event Interrupt */
+#define FALCON_IRQ_HOST				(INT_NUM_IM0_IRL0 + 0)
+/* HOST IF Mailbox0 Receive Interrupt */
+#define FALCON_IRQ_HOST_MB0_RX			(INT_NUM_IM0_IRL0 + 1)
+/* HOST IF Mailbox0 Transmit Interrupt */
+#define FALCON_IRQ_HOST_MB0_TX			(INT_NUM_IM0_IRL0 + 2)
+/* HOST IF Mailbox1 Receive Interrupt */
+#define FALCON_IRQ_HOST_MB1_RX			(INT_NUM_IM0_IRL0 + 3)
+/* HOST IF Mailbox1 Transmit Interrupt */
+#define FALCON_IRQ_HOST_MB1_TX			(INT_NUM_IM0_IRL0 + 4)
+/* I2C Last Single Data Transfer Request */
+#define FALCON_IRQ_I2C_LSREQ			(INT_NUM_IM0_IRL0 + 8)
+/* I2C Single Data Transfer Request */
+#define FALCON_IRQ_I2C_SREQ			(INT_NUM_IM0_IRL0 + 9)
+/* I2C Last Burst Data Transfer Request */
+#define FALCON_IRQ_I2C_LBREQ			(INT_NUM_IM0_IRL0 + 10)
+/* I2C Burst Data Transfer Request */
+#define FALCON_IRQ_I2C_BREQ			(INT_NUM_IM0_IRL0 + 11)
+/* I2C Error Interrupt */
+#define FALCON_IRQ_I2C_I2C_ERR			(INT_NUM_IM0_IRL0 + 12)
+/* I2C Protocol Interrupt */
+#define FALCON_IRQ_I2C_I2C_P			(INT_NUM_IM0_IRL0 + 13)
+/* SSC Transmit Interrupt */
+#define FALCON_IRQ_SSC_T			(INT_NUM_IM0_IRL0 + 14)
+/* SSC Receive Interrupt */
+#define FALCON_IRQ_SSC_R			(INT_NUM_IM0_IRL0 + 15)
+/* SSC Error Interrupt */
+#define FALCON_IRQ_SSC_E			(INT_NUM_IM0_IRL0 + 16)
+/* SSC Frame Interrupt */
+#define FALCON_IRQ_SSC_F			(INT_NUM_IM0_IRL0 + 17)
+/* Advanced Encryption Standard Interrupt */
+#define FALCON_IRQ_AES_AES			(INT_NUM_IM0_IRL0 + 27)
+/* Secure Hash Algorithm Interrupt */
+#define FALCON_IRQ_SHA_HASH			(INT_NUM_IM0_IRL0 + 28)
+/* PCM Receive Interrupt */
+#define FALCON_IRQ_PCM_RX			(INT_NUM_IM0_IRL0 + 29)
+/* PCM Transmit Interrupt */
+#define FALCON_IRQ_PCM_TX			(INT_NUM_IM0_IRL0 + 30)
+/* PCM Transmit Crash Interrupt */
+#define FALCON_IRQ_PCM_HW2_CRASH		(INT_NUM_IM0_IRL0 + 31)
+
+/* EBU Serial Flash Command Error */
+#define FALCON_IRQ_EBU_SF_CMDERR		(INT_NUM_IM1_IRL0 + 0)
+/* EBU Serial Flash Command Overwrite Error */
+#define FALCON_IRQ_EBU_SF_COVERR		(INT_NUM_IM1_IRL0 + 1)
+/* EBU Serial Flash Busy */
+#define FALCON_IRQ_EBU_SF_BUSY			(INT_NUM_IM1_IRL0 + 2)
+/* External Interrupt from GPIO P0 */
+#define FALCON_IRQ_GPIO_P0			(INT_NUM_IM1_IRL0 + 4)
+/* External Interrupt from GPIO P1 */
+#define FALCON_IRQ_GPIO_P1			(INT_NUM_IM1_IRL0 + 5)
+/* External Interrupt from GPIO P2 */
+#define FALCON_IRQ_GPIO_P2			(INT_NUM_IM1_IRL0 + 6)
+/* External Interrupt from GPIO P3 */
+#define FALCON_IRQ_GPIO_P3			(INT_NUM_IM1_IRL0 + 7)
+/* External Interrupt from GPIO P4 */
+#define FALCON_IRQ_GPIO_P4			(INT_NUM_IM1_IRL0 + 8)
+/* 8kHz backup interrupt derived from core-PLL */
+#define FALCON_IRQ_FSC_BKP			(INT_NUM_IM1_IRL0 + 10)
+/* FSC Timer Interrupt 0 */
+#define FALCON_IRQ_FSCT_CMP0			(INT_NUM_IM1_IRL0 + 11)
+/* FSC Timer Interrupt 1 */
+#define FALCON_IRQ_FSCT_CMP1			(INT_NUM_IM1_IRL0 + 12)
+/* 8kHz root interrupt derived from GPON interface */
+#define FALCON_IRQ_FSC_ROOT			(INT_NUM_IM1_IRL0 + 13)
+/* Time of Day */
+#define FALCON_IRQ_TOD				(INT_NUM_IM1_IRL0 + 14)
+/* PMA Interrupt from IntNode of the 200MHz Domain */
+#define FALCON_IRQ_PMA_200M			(INT_NUM_IM1_IRL0 + 15)
+/* PMA Interrupt from IntNode of the TX Clk Domain */
+#define FALCON_IRQ_PMA_TX			(INT_NUM_IM1_IRL0 + 16)
+/* PMA Interrupt from IntNode of the RX Clk Domain */
+#define FALCON_IRQ_PMA_RX			(INT_NUM_IM1_IRL0 + 17)
+/* SYS1 Interrupt */
+#define FALCON_IRQ_SYS1				(INT_NUM_IM1_IRL0 + 20)
+/* SYS GPE Interrupt */
+#define FALCON_IRQ_SYS_GPE			(INT_NUM_IM1_IRL0 + 21)
+/* Watchdog Access Error Interrupt */
+#define FALCON_IRQ_WDT_AEIR			(INT_NUM_IM1_IRL0 + 24)
+/* Watchdog Prewarning Interrupt */
+#define FALCON_IRQ_WDT_PIR			(INT_NUM_IM1_IRL0 + 25)
+/* SBIU interrupt */
+#define FALCON_IRQ_SBIU0			(INT_NUM_IM1_IRL0 + 27)
+/* FPI Bus Control Unit Interrupt */
+#define FALCON_IRQ_BCU0				(INT_NUM_IM1_IRL0 + 29)
+/* DDR Controller Interrupt */
+#define FALCON_IRQ_DDR				(INT_NUM_IM1_IRL0 + 30)
+/* Crossbar Error Interrupt */
+#define FALCON_IRQ_XBAR_ERROR			(INT_NUM_IM1_IRL0 + 31)
+
+/* ICTRLL 0 Interrupt */
+#define FALCON_IRQ_ICTRLL0			(INT_NUM_IM2_IRL0 + 0)
+/* ICTRLL 1 Interrupt */
+#define FALCON_IRQ_ICTRLL1			(INT_NUM_IM2_IRL0 + 1)
+/* ICTRLL 2 Interrupt */
+#define FALCON_IRQ_ICTRLL2			(INT_NUM_IM2_IRL0 + 2)
+/* ICTRLL 3 Interrupt */
+#define FALCON_IRQ_ICTRLL3			(INT_NUM_IM2_IRL0 + 3)
+/* OCTRLL 0 Interrupt */
+#define FALCON_IRQ_OCTRLL0			(INT_NUM_IM2_IRL0 + 4)
+/* OCTRLL 1 Interrupt */
+#define FALCON_IRQ_OCTRLL1			(INT_NUM_IM2_IRL0 + 5)
+/* OCTRLL 2 Interrupt */
+#define FALCON_IRQ_OCTRLL2			(INT_NUM_IM2_IRL0 + 6)
+/* OCTRLL 3 Interrupt */
+#define FALCON_IRQ_OCTRLL3			(INT_NUM_IM2_IRL0 + 7)
+/* OCTRLG Interrupt */
+#define FALCON_IRQ_OCTRLG			(INT_NUM_IM2_IRL0 + 9)
+/* IQM Interrupt */
+#define FALCON_IRQ_IQM				(INT_NUM_IM2_IRL0 + 10)
+/* FSQM Interrupt */
+#define FALCON_IRQ_FSQM				(INT_NUM_IM2_IRL0 + 11)
+/* TMU Interrupt */
+#define FALCON_IRQ_TMU				(INT_NUM_IM2_IRL0 + 12)
+/* LINK1 Interrupt */
+#define FALCON_IRQ_LINK1			(INT_NUM_IM2_IRL0 + 14)
+/* ICTRLC 0 Interrupt */
+#define FALCON_IRQ_ICTRLC0			(INT_NUM_IM2_IRL0 + 16)
+/* ICTRLC 1 Interrupt */
+#define FALCON_IRQ_ICTRLC1			(INT_NUM_IM2_IRL0 + 17)
+/* OCTRLC Interrupt */
+#define FALCON_IRQ_OCTRLC			(INT_NUM_IM2_IRL0 + 18)
+/* CONFIG Break Interrupt */
+#define FALCON_IRQ_CONFIG_BREAK			(INT_NUM_IM2_IRL0 + 19)
+/* CONFIG Interrupt */
+#define FALCON_IRQ_CONFIG			(INT_NUM_IM2_IRL0 + 20)
+/* Dispatcher Interrupt */
+#define FALCON_IRQ_DISP				(INT_NUM_IM2_IRL0 + 21)
+/* TBM Interrupt */
+#define FALCON_IRQ_TBM				(INT_NUM_IM2_IRL0 + 22)
+/* GTC Downstream Interrupt */
+#define FALCON_IRQ_GTC_DS			(INT_NUM_IM2_IRL0 + 29)
+/* GTC Upstream Interrupt */
+#define FALCON_IRQ_GTC_US			(INT_NUM_IM2_IRL0 + 30)
+/* EIM Interrupt */
+#define FALCON_IRQ_EIM				(INT_NUM_IM2_IRL0 + 31)
+
+/* ASC0 Transmit Interrupt */
+#define FALCON_IRQ_ASC0_T			(INT_NUM_IM3_IRL0 + 0)
+/* ASC0 Receive Interrupt */
+#define FALCON_IRQ_ASC0_R			(INT_NUM_IM3_IRL0 + 1)
+/* ASC0 Error Interrupt */
+#define FALCON_IRQ_ASC0_E			(INT_NUM_IM3_IRL0 + 2)
+/* ASC0 Transmit Buffer Interrupt */
+#define FALCON_IRQ_ASC0_TB			(INT_NUM_IM3_IRL0 + 3)
+/* ASC0 Autobaud Start Interrupt */
+#define FALCON_IRQ_ASC0_ABST			(INT_NUM_IM3_IRL0 + 4)
+/* ASC0 Autobaud Detection Interrupt */
+#define FALCON_IRQ_ASC0_ABDET			(INT_NUM_IM3_IRL0 + 5)
+/* ASC1 Modem Status Interrupt */
+#define FALCON_IRQ_ASC0_MS			(INT_NUM_IM3_IRL0 + 6)
+/* ASC0 Soft Flow Control Interrupt */
+#define FALCON_IRQ_ASC0_SFC			(INT_NUM_IM3_IRL0 + 7)
+/* ASC1 Transmit Interrupt */
+#define FALCON_IRQ_ASC1_T			(INT_NUM_IM3_IRL0 + 8)
+/* ASC1 Receive Interrupt */
+#define FALCON_IRQ_ASC1_R			(INT_NUM_IM3_IRL0 + 9)
+/* ASC1 Error Interrupt */
+#define FALCON_IRQ_ASC1_E			(INT_NUM_IM3_IRL0 + 10)
+/* ASC1 Transmit Buffer Interrupt */
+#define FALCON_IRQ_ASC1_TB			(INT_NUM_IM3_IRL0 + 11)
+/* ASC1 Autobaud Start Interrupt */
+#define FALCON_IRQ_ASC1_ABST			(INT_NUM_IM3_IRL0 + 12)
+/* ASC1 Autobaud Detection Interrupt */
+#define FALCON_IRQ_ASC1_ABDET			(INT_NUM_IM3_IRL0 + 13)
+/* ASC1 Modem Status Interrupt */
+#define FALCON_IRQ_ASC1_MS			(INT_NUM_IM3_IRL0 + 14)
+/* ASC1 Soft Flow Control Interrupt */
+#define FALCON_IRQ_ASC1_SFC			(INT_NUM_IM3_IRL0 + 15)
+/* GPTC Timer/Counter 1A Interrupt */
+#define FALCON_IRQ_GPTC_TC1A			(INT_NUM_IM3_IRL0 + 16)
+/* GPTC Timer/Counter 1B Interrupt */
+#define FALCON_IRQ_GPTC_TC1B			(INT_NUM_IM3_IRL0 + 17)
+/* GPTC Timer/Counter 2A Interrupt */
+#define FALCON_IRQ_GPTC_TC2A			(INT_NUM_IM3_IRL0 + 18)
+/* GPTC Timer/Counter 2B Interrupt */
+#define FALCON_IRQ_GPTC_TC2B			(INT_NUM_IM3_IRL0 + 19)
+/* GPTC Timer/Counter 3A Interrupt */
+#define FALCON_IRQ_GPTC_TC3A			(INT_NUM_IM3_IRL0 + 20)
+/* GPTC Timer/Counter 3B Interrupt */
+#define FALCON_IRQ_GPTC_TC3B			(INT_NUM_IM3_IRL0 + 21)
+/* DFEV0, Channel 1 Transmit Interrupt */
+#define FALCON_IRQ_DFEV0_2TX			(INT_NUM_IM3_IRL0 + 26)
+/* DFEV0, Channel 1 Receive Interrupt */
+#define FALCON_IRQ_DFEV0_2RX			(INT_NUM_IM3_IRL0 + 27)
+/* DFEV0, Channel 1 General Purpose Interrupt */
+#define FALCON_IRQ_DFEV0_2GP			(INT_NUM_IM3_IRL0 + 28)
+/* DFEV0, Channel 0 Transmit Interrupt */
+#define FALCON_IRQ_DFEV0_1TX			(INT_NUM_IM3_IRL0 + 29)
+/* DFEV0, Channel 0 Receive Interrupt */
+#define FALCON_IRQ_DFEV0_1RX			(INT_NUM_IM3_IRL0 + 30)
+/* DFEV0, Channel 0 General Purpose Interrupt */
+#define FALCON_IRQ_DFEV0_1GP			(INT_NUM_IM3_IRL0 + 31)
+
+/* ICTRLL 0 Error */
+#define FALCON_IRQ_ICTRLL0_ERR			(INT_NUM_IM4_IRL0 + 0)
+/* ICTRLL 1 Error */
+#define FALCON_IRQ_ICTRLL1_ERR			(INT_NUM_IM4_IRL0 + 1)
+/* ICTRLL 2 Error */
+#define FALCON_IRQ_ICTRLL2_ERR			(INT_NUM_IM4_IRL0 + 2)
+/* ICTRLL 3 Error */
+#define FALCON_IRQ_ICTRLL3_ERR			(INT_NUM_IM4_IRL0 + 3)
+/* OCTRLL 0 Error */
+#define FALCON_IRQ_OCTRLL0_ERR			(INT_NUM_IM4_IRL0 + 4)
+/* OCTRLL 1 Error */
+#define FALCON_IRQ_OCTRLL1_ERR			(INT_NUM_IM4_IRL0 + 5)
+/* OCTRLL 2 Error */
+#define FALCON_IRQ_OCTRLL2_ERR			(INT_NUM_IM4_IRL0 + 6)
+/* OCTRLL 3 Error */
+#define FALCON_IRQ_OCTRLL3_ERR			(INT_NUM_IM4_IRL0 + 7)
+/* ICTRLG Error */
+#define FALCON_IRQ_ICTRLG_ERR			(INT_NUM_IM4_IRL0 + 8)
+/* OCTRLG Error */
+#define FALCON_IRQ_OCTRLG_ERR			(INT_NUM_IM4_IRL0 + 9)
+/* IQM Error */
+#define FALCON_IRQ_IQM_ERR			(INT_NUM_IM4_IRL0 + 10)
+/* FSQM Error */
+#define FALCON_IRQ_FSQM_ERR			(INT_NUM_IM4_IRL0 + 11)
+/* TMU Error */
+#define FALCON_IRQ_TMU_ERR			(INT_NUM_IM4_IRL0 + 12)
+/* MPS Status Interrupt #0 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR0			(INT_NUM_IM4_IRL0 + 14)
+/* MPS Status Interrupt #1 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR1			(INT_NUM_IM4_IRL0 + 15)
+/* MPS Status Interrupt #2 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR2			(INT_NUM_IM4_IRL0 + 16)
+/* MPS Status Interrupt #3 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR3			(INT_NUM_IM4_IRL0 + 17)
+/* MPS Status Interrupt #4 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR4			(INT_NUM_IM4_IRL0 + 18)
+/* MPS Status Interrupt #5 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR5			(INT_NUM_IM4_IRL0 + 19)
+/* MPS Status Interrupt #6 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR6			(INT_NUM_IM4_IRL0 + 20)
+/* MPS Status Interrupt #7 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR7			(INT_NUM_IM4_IRL0 + 21)
+/* MPS Status Interrupt #8 (VPE1 to VPE0) */
+#define FALCON_IRQ_MPS_IR8			(INT_NUM_IM4_IRL0 + 22)
+/* VPE0 Exception Level Flag Interrupt */
+#define FALCON_IRQ_VPE0_EXL			(INT_NUM_IM4_IRL0 + 29)
+/* VPE0 Error Level Flag Interrupt */
+#define FALCON_IRQ_VPE0_ERL			(INT_NUM_IM4_IRL0 + 30)
+/* VPE0 Performance Monitoring Counter Interrupt */
+#define FALCON_IRQ_VPE0_PMCIR			(INT_NUM_IM4_IRL0 + 31)
+
+#endif /* _FALCON_IRQ__ */
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/irq.h b/arch/mips/include/asm/mach-lantiq/falcon/irq.h
new file mode 100644
index 0000000..2caccd9
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/irq.h
@@ -0,0 +1,18 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ */
+
+#ifndef __FALCON_IRQ_H
+#define __FALCON_IRQ_H
+
+#include <falcon_irq.h>
+
+#define NR_IRQS 328
+
+#include_next <irq.h>
+
+#endif
diff --git a/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
new file mode 100644
index 0000000..c092531
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
@@ -0,0 +1,140 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _LTQ_FALCON_H__
+#define _LTQ_FALCON_H__
+
+#ifdef CONFIG_SOC_FALCON
+
+#include <lantiq.h>
+
+/* Chip IDs */
+#define SOC_ID_FALCON		0x01B8
+
+/* SoC Types */
+#define SOC_TYPE_FALCON		0x01
+
+/* ASC0/1 - serial port */
+#define LTQ_ASC0_BASE_ADDR	0x1E100C00
+#define LTQ_ASC1_BASE_ADDR	0x1E100B00
+#define LTQ_ASC_SIZE		0x100
+
+#define LTQ_ASC_TIR(x)          (INT_NUM_IM3_IRL0 + (x * 8))
+#define LTQ_ASC_RIR(x)          (INT_NUM_IM3_IRL0 + (x * 8) + 1)
+#define LTQ_ASC_EIR(x)          (INT_NUM_IM3_IRL0 + (x * 8) + 2)
+
+/* during early_printk no ioremap possible at this early stage
+   lets use KSEG1 instead  */
+#define LTQ_EARLY_ASC		KSEG1ADDR(LTQ_ASC0_BASE_ADDR)
+
+/* ICU - interrupt control unit */
+#define LTQ_ICU_BASE_ADDR	0x1F880200
+#define LTQ_ICU_SIZE		0x100
+
+/* WDT */
+#define LTQ_WDT_BASE_ADDR	0x1F8803F0
+#define LTQ_WDT_SIZE		0x10
+
+#define LTQ_RST_CAUSE_WDTRST	0x0002
+
+/* EBU - external bus unit */
+#define LTQ_EBU_BASE_ADDR       0x18000000
+#define LTQ_EBU_SIZE            0x0100
+
+#define LTQ_EBU_MODCON  0x000C
+
+/* GPIO */
+#define LTQ_GPIO0_BASE_ADDR     0x1D810000
+#define LTQ_GPIO0_SIZE          0x0080
+#define LTQ_GPIO1_BASE_ADDR     0x1E800100
+#define LTQ_GPIO1_SIZE          0x0080
+#define LTQ_GPIO2_BASE_ADDR     0x1D810100
+#define LTQ_GPIO2_SIZE          0x0080
+#define LTQ_GPIO3_BASE_ADDR     0x1E800200
+#define LTQ_GPIO3_SIZE          0x0080
+#define LTQ_GPIO4_BASE_ADDR     0x1E800300
+#define LTQ_GPIO4_SIZE          0x0080
+#define LTQ_PADCTRL0_BASE_ADDR  0x1DB01000
+#define LTQ_PADCTRL0_SIZE       0x0100
+#define LTQ_PADCTRL1_BASE_ADDR  0x1E800400
+#define LTQ_PADCTRL1_SIZE       0x0100
+#define LTQ_PADCTRL2_BASE_ADDR  0x1DB02000
+#define LTQ_PADCTRL2_SIZE       0x0100
+#define LTQ_PADCTRL3_BASE_ADDR  0x1E800500
+#define LTQ_PADCTRL3_SIZE       0x0100
+#define LTQ_PADCTRL4_BASE_ADDR  0x1E800600
+#define LTQ_PADCTRL4_SIZE       0x0100
+
+/* CHIP ID */
+#define LTQ_STATUS_BASE_ADDR	0x1E802000
+
+#define LTQ_FALCON_CHIPID	((u32 *)(KSEG1 + LTQ_STATUS_BASE_ADDR + 0x0c))
+#define LTQ_FALCON_CHIPCONF	((u32 *)(KSEG1 + LTQ_STATUS_BASE_ADDR + 0x40))
+
+/* SYSCTL - start/stop/restart/configure/... different parts of the Soc */
+#define LTQ_SYS1_BASE_ADDR      0x1EF00000
+#define LTQ_SYS1_SIZE           0x0100
+#define LTQ_STATUS_BASE_ADDR	0x1E802000
+#define LTQ_STATUS_SIZE		0x0080
+#define LTQ_SYS_ETH_BASE_ADDR	0x1DB00000
+#define LTQ_SYS_ETH_SIZE	0x0100
+#define LTQ_SYS_GPE_BASE_ADDR	0x1D700000
+#define LTQ_SYS_GPE_SIZE	0x0100
+
+#define SYSCTL_SYS1		0
+#define SYSCTL_SYSETH		1
+#define SYSCTL_SYSGPE		2
+
+/* Activation Status Register */
+#define ACTS_ASC1_ACT	0x00000800
+#define ACTS_P0		0x00010000
+#define ACTS_P1		0x00010000
+#define ACTS_P2		0x00020000
+#define ACTS_P3		0x00020000
+#define ACTS_P4		0x00040000
+#define ACTS_PADCTRL0	0x00100000
+#define ACTS_PADCTRL1	0x00100000
+#define ACTS_PADCTRL2	0x00200000
+#define ACTS_PADCTRL3	0x00200000
+#define ACTS_PADCTRL4	0x00400000
+
+extern void ltq_sysctl_activate(int module, unsigned int mask);
+extern void ltq_sysctl_deactivate(int module, unsigned int mask);
+extern void ltq_sysctl_clken(int module, unsigned int mask);
+extern void ltq_sysctl_clkdis(int module, unsigned int mask);
+extern void ltq_sysctl_reboot(int module, unsigned int mask);
+extern int ltq_gpe_is_activated(unsigned int mask);
+
+/* global register ranges */
+extern __iomem void *ltq_ebu_membase;
+extern __iomem void *ltq_sys1_membase;
+#define ltq_ebu_w32(x, y)	ltq_w32((x), ltq_ebu_membase + (y))
+#define ltq_ebu_r32(x)		ltq_r32(ltq_ebu_membase + (x))
+#define ltq_ebu_w32_mask(clear, set, reg)   \
+	ltq_ebu_w32((ltq_ebu_r32(reg) & ~(clear)) | (set), reg)
+
+#define ltq_sys1_w32(x, y)	ltq_w32((x), ltq_sys1_membase + (y))
+#define ltq_sys1_r32(x)		ltq_r32(ltq_sys1_membase + (x))
+#define ltq_sys1_w32_mask(clear, set, reg)   \
+	ltq_sys1_w32((ltq_sys1_r32(reg) & ~(clear)) | (set), reg)
+
+/* gpio_request wrapper to help configure the pin */
+extern int ltq_gpio_request(unsigned int pin, unsigned int val,
+				unsigned int dir, const char *name);
+extern int ltq_gpio_mux_set(unsigned int pin, unsigned int mux);
+
+/* to keep the irq code generic we need to define these to 0 as falcon
+   has no EIU/EBU */
+#define LTQ_EIU_BASE_ADDR	0
+#define LTQ_EBU_PCC_ISTAT	0
+
+#define ltq_is_ar9()	0
+#define ltq_is_vr9()	0
+
+#endif /* CONFIG_SOC_FALCON */
+#endif /* _LTQ_XWAY_H__ */
diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 66d7300..188de0f 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -25,6 +25,7 @@ extern unsigned int ltq_get_soc_type(void);
 /* clock speeds */
 #define CLOCK_60M	60000000
 #define CLOCK_83M	83333333
+#define CLOCK_100M	100000000
 #define CLOCK_111M	111111111
 #define CLOCK_133M	133333333
 #define CLOCK_167M	166666667
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index 3fccf21..cb6b39f 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -16,8 +16,12 @@ config SOC_XWAY
 	bool "XWAY"
 	select SOC_TYPE_XWAY
 	select HW_HAS_PCI
+
+config SOC_FALCON
+	bool "FALCON"
 endchoice
 
 source "arch/mips/lantiq/xway/Kconfig"
+source "arch/mips/lantiq/falcon/Kconfig"
 
 endif
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index e5dae0e..7e9c69e 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -9,3 +9,4 @@ obj-y := irq.o setup.o clk.o prom.o devices.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 obj-$(CONFIG_SOC_TYPE_XWAY) += xway/
+obj-$(CONFIG_SOC_FALCON) += falcon/
diff --git a/arch/mips/lantiq/Platform b/arch/mips/lantiq/Platform
index f3dff05..b3ec498 100644
--- a/arch/mips/lantiq/Platform
+++ b/arch/mips/lantiq/Platform
@@ -6,3 +6,4 @@ platform-$(CONFIG_LANTIQ)	+= lantiq/
 cflags-$(CONFIG_LANTIQ)		+= -I$(srctree)/arch/mips/include/asm/mach-lantiq
 load-$(CONFIG_LANTIQ)		= 0xffffffff80002000
 cflags-$(CONFIG_SOC_TYPE_XWAY)	+= -I$(srctree)/arch/mips/include/asm/mach-lantiq/xway
+cflags-$(CONFIG_SOC_FALCON)	+= -I$(srctree)/arch/mips/include/asm/mach-lantiq/falcon
diff --git a/arch/mips/lantiq/falcon/Makefile b/arch/mips/lantiq/falcon/Makefile
new file mode 100644
index 0000000..e9c7455
--- /dev/null
+++ b/arch/mips/lantiq/falcon/Makefile
@@ -0,0 +1 @@
+obj-y := clk.o prom.o reset.o sysctrl.o devices.o
diff --git a/arch/mips/lantiq/falcon/clk.c b/arch/mips/lantiq/falcon/clk.c
new file mode 100644
index 0000000..1a550ea
--- /dev/null
+++ b/arch/mips/lantiq/falcon/clk.c
@@ -0,0 +1,44 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/ioport.h>
+#include <linux/module.h>
+
+#include <lantiq_soc.h>
+
+#include "devices.h"
+
+/* CPU0 Clock Control Register */
+#define LTQ_SYS1_CPU0CC		0x0040
+/* clock divider bit */
+#define LTQ_CPU0CC_CPUDIV	0x0001
+
+unsigned int
+ltq_get_io_region_clock(void)
+{
+	return CLOCK_200M;
+}
+EXPORT_SYMBOL(ltq_get_io_region_clock);
+
+unsigned int
+ltq_get_cpu_hz(void)
+{
+	if (ltq_sys1_r32(LTQ_SYS1_CPU0CC) & LTQ_CPU0CC_CPUDIV)
+		return CLOCK_200M;
+	else
+		return CLOCK_400M;
+}
+EXPORT_SYMBOL(ltq_get_cpu_hz);
+
+unsigned int
+ltq_get_fpi_hz(void)
+{
+	return CLOCK_100M;
+}
+EXPORT_SYMBOL(ltq_get_fpi_hz);
diff --git a/arch/mips/lantiq/falcon/devices.c b/arch/mips/lantiq/falcon/devices.c
new file mode 100644
index 0000000..c4606f2
--- /dev/null
+++ b/arch/mips/lantiq/falcon/devices.c
@@ -0,0 +1,87 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mtd/nand.h>
+
+#include <lantiq_soc.h>
+
+#include "devices.h"
+
+/* nand flash */
+/* address lines used for NAND control signals */
+#define NAND_ADDR_ALE		0x10000
+#define NAND_ADDR_CLE		0x20000
+/* Ready/Busy Status */
+#define MODCON_STS		0x0002
+/* Ready/Busy Status Edge */
+#define MODCON_STSEDGE		0x0004
+
+static const char *part_probes[] = { "cmdlinepart", NULL };
+
+static int
+falcon_nand_ready(struct mtd_info *mtd)
+{
+	u32 modcon = ltq_ebu_r32(LTQ_EBU_MODCON);
+
+	return (((modcon & (MODCON_STS | MODCON_STSEDGE)) ==
+						(MODCON_STS | MODCON_STSEDGE)));
+}
+
+static void
+falcon_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long nandaddr = (unsigned long) this->IO_ADDR_W;
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		nandaddr &= ~(NAND_ADDR_ALE | NAND_ADDR_CLE);
+
+		if (ctrl & NAND_CLE)
+			nandaddr |= NAND_ADDR_CLE;
+		if (ctrl & NAND_ALE)
+			nandaddr |= NAND_ADDR_ALE;
+
+		this->IO_ADDR_W = (void __iomem *) nandaddr;
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		writeb(cmd, this->IO_ADDR_W);
+}
+
+static struct platform_nand_data falcon_flash_nand_data = {
+	.chip = {
+		.nr_chips		= 1,
+		.chip_delay		= 25,
+		.part_probe_types	= part_probes,
+	},
+	.ctrl = {
+		.cmd_ctrl		= falcon_hwcontrol,
+		.dev_ready		= falcon_nand_ready,
+	}
+};
+
+static struct resource ltq_nand_res =
+	MEM_RES("nand", LTQ_FLASH_START, LTQ_FLASH_MAX);
+
+static struct platform_device ltq_flash_nand = {
+	.name		= "gen_nand",
+	.id		= -1,
+	.num_resources	= 1,
+	.resource	= &ltq_nand_res,
+	.dev		= {
+		.platform_data = &falcon_flash_nand_data,
+	},
+};
+
+void __init
+falcon_register_nand(void)
+{
+	platform_device_register(&ltq_flash_nand);
+}
diff --git a/arch/mips/lantiq/falcon/devices.h b/arch/mips/lantiq/falcon/devices.h
new file mode 100644
index 0000000..e802a7c
--- /dev/null
+++ b/arch/mips/lantiq/falcon/devices.h
@@ -0,0 +1,18 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef _FALCON_DEVICES_H__
+#define _FALCON_DEVICES_H__
+
+#include "../devices.h"
+
+extern void falcon_register_nand(void);
+
+#endif
diff --git a/arch/mips/lantiq/falcon/prom.c b/arch/mips/lantiq/falcon/prom.c
new file mode 100644
index 0000000..89367c4
--- /dev/null
+++ b/arch/mips/lantiq/falcon/prom.c
@@ -0,0 +1,72 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <lantiq_soc.h>
+
+#include "devices.h"
+
+#include "../prom.h"
+
+#define SOC_FALCON		"Falcon"
+
+#define PART_SHIFT	12
+#define PART_MASK	0x0FFFF000
+#define REV_SHIFT	28
+#define REV_MASK	0xF0000000
+#define SREV_SHIFT	22
+#define SREV_MASK	0x03C00000
+
+#define MUXC_SIF_RX_PIN		112
+#define MUXC_SIF_TX_PIN		113
+
+/* this parameter allows us enable/disable asc1 via commandline */
+static int register_asc1;
+static int __init
+ltq_parse_asc1(char *p)
+{
+	register_asc1 = 1;
+	return 0;
+}
+__setup("use_asc1", ltq_parse_asc1);
+
+void __init
+ltq_soc_setup(void)
+{
+	ltq_register_asc(0);
+	ltq_register_wdt();
+	falcon_register_gpio();
+	if (register_asc1) {
+		ltq_register_asc(1);
+		if (ltq_gpio_request(MUXC_SIF_RX_PIN, 3, 0, "asc1-rx"))
+			pr_err("failed to request asc1-rx");
+		if (ltq_gpio_request(MUXC_SIF_TX_PIN, 3, 1, "asc1-tx"))
+			pr_err("failed to request asc1-tx");
+		ltq_sysctl_activate(SYSCTL_SYS1, ACTS_ASC1_ACT);
+	}
+}
+
+void __init
+ltq_soc_detect(struct ltq_soc_info *i)
+{
+	i->partnum = (ltq_r32(LTQ_FALCON_CHIPID) & PART_MASK) >> PART_SHIFT;
+	i->rev = (ltq_r32(LTQ_FALCON_CHIPID) & REV_MASK) >> REV_SHIFT;
+	i->srev = (ltq_r32(LTQ_FALCON_CHIPCONF) & SREV_MASK) >> SREV_SHIFT;
+	sprintf(i->rev_type, "%c%d%d", (i->srev & 0x4) ? ('B') : ('A'),
+		i->rev & 0x7, i->srev & 0x3);
+	switch (i->partnum) {
+	case SOC_ID_FALCON:
+		i->name = SOC_FALCON;
+		i->type = SOC_TYPE_FALCON;
+		break;
+
+	default:
+		unreachable();
+		break;
+	}
+}
diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
new file mode 100644
index 0000000..d3289ca
--- /dev/null
+++ b/arch/mips/lantiq/falcon/reset.c
@@ -0,0 +1,87 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <asm/reboot.h>
+#include <linux/module.h>
+
+#include <lantiq_soc.h>
+
+/* CPU0 Reset Source Register */
+#define LTQ_SYS1_CPU0RS		0x0040
+/* reset cause mask */
+#define LTQ_CPU0RS_MASK		0x0003
+
+int
+ltq_reset_cause(void)
+{
+	return ltq_sys1_r32(LTQ_SYS1_CPU0RS) & LTQ_CPU0RS_MASK;
+}
+EXPORT_SYMBOL_GPL(ltq_reset_cause);
+
+#define BOOT_REG_BASE	(KSEG1 | 0x1F200000)
+#define BOOT_PW1_REG	(BOOT_REG_BASE | 0x20)
+#define BOOT_PW2_REG	(BOOT_REG_BASE | 0x24)
+#define BOOT_PW1	0x4C545100
+#define BOOT_PW2	0x0051544C
+
+#define WDT_REG_BASE	(KSEG1 | 0x1F8803F0)
+#define WDT_PW1		0x00BE0000
+#define WDT_PW2		0x00DC0000
+
+static void
+ltq_machine_restart(char *command)
+{
+	pr_notice("System restart\n");
+	local_irq_disable();
+
+	/* reboot magic */
+	ltq_w32(BOOT_PW1, (void *)BOOT_PW1_REG); /* 'LTQ\0' */
+	ltq_w32(BOOT_PW2, (void *)BOOT_PW2_REG); /* '\0QTL' */
+	ltq_w32(0, (void *)BOOT_REG_BASE); /* reset Bootreg RVEC */
+
+	/* watchdog magic */
+	ltq_w32(WDT_PW1, (void *)WDT_REG_BASE);
+	ltq_w32(WDT_PW2 |
+		(0x3 << 26) | /* PWL */
+		(0x2 << 24) | /* CLKDIV */
+		(0x1 << 31) | /* enable */
+		(1), /* reload */
+		(void *)WDT_REG_BASE);
+	unreachable();
+}
+
+static void
+ltq_machine_halt(void)
+{
+	pr_notice("System halted.\n");
+	local_irq_disable();
+	unreachable();
+}
+
+static void
+ltq_machine_power_off(void)
+{
+	pr_notice("Please turn off the power now.\n");
+	local_irq_disable();
+	unreachable();
+}
+
+static int __init
+mips_reboot_setup(void)
+{
+	_machine_restart = ltq_machine_restart;
+	_machine_halt = ltq_machine_halt;
+	pm_power_off = ltq_machine_power_off;
+	return 0;
+}
+
+arch_initcall(mips_reboot_setup);
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
new file mode 100644
index 0000000..d20b46b
--- /dev/null
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -0,0 +1,181 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2011 Thomas Langer <thomas.langer@lantiq.com>
+ * Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/ioport.h>
+#include <asm/delay.h>
+
+#include <lantiq_soc.h>
+
+#include "devices.h"
+
+/* infrastructure control register */
+#define SYS1_INFRAC		0x00bc
+/* Configuration fuses for drivers and pll */
+#define STATUS_CONFIG		0x0040
+
+/* GPE frequency selection */
+#define GPPC_OFFSET		24
+#define GPEFREQ_MASK		0x00000C0
+#define GPEFREQ_OFFSET		10
+/* Clock status register */
+#define LTQ_SYSCTL_CLKS		0x0000
+/* Clock enable register */
+#define LTQ_SYSCTL_CLKEN	0x0004
+/* Clock clear register */
+#define LTQ_SYSCTL_CLKCLR	0x0008
+/* Activation Status Register */
+#define LTQ_SYSCTL_ACTS		0x0020
+/* Activation Register */
+#define LTQ_SYSCTL_ACT		0x0024
+/* Deactivation Register */
+#define LTQ_SYSCTL_DEACT	0x0028
+/* reboot Register */
+#define LTQ_SYSCTL_RBT		0x002c
+
+static struct resource ltq_sysctl_res[] = {
+	MEM_RES("sys1", LTQ_SYS1_BASE_ADDR, LTQ_SYS1_SIZE),
+	MEM_RES("syseth", LTQ_SYS_ETH_BASE_ADDR, LTQ_SYS_ETH_SIZE),
+	MEM_RES("sysgpe", LTQ_SYS_GPE_BASE_ADDR, LTQ_SYS_GPE_SIZE),
+};
+
+static struct resource ltq_status_res =
+	MEM_RES("status", LTQ_STATUS_BASE_ADDR, LTQ_STATUS_SIZE);
+static struct resource ltq_ebu_res =
+	MEM_RES("ebu", LTQ_EBU_BASE_ADDR, LTQ_EBU_SIZE);
+
+static void __iomem *ltq_sysctl[3];
+static void __iomem *ltq_status_membase;
+void __iomem *ltq_sys1_membase;
+void __iomem *ltq_ebu_membase;
+
+#define ltq_reg_w32(m, x, y)	ltq_w32((x), ltq_sysctl[m] + (y))
+#define ltq_reg_r32(m, x)	ltq_r32(ltq_sysctl[m] + (x))
+#define ltq_reg_w32_mask(m, clear, set, reg)	\
+		ltq_reg_w32(m, (ltq_reg_r32(m, reg) & ~(clear)) | (set), reg)
+
+#define ltq_status_w32(x, y)	ltq_w32((x), ltq_status_membase + (y))
+#define ltq_status_r32(x)	ltq_r32(ltq_status_membase + (x))
+
+static inline void
+ltq_sysctl_wait(int module, unsigned int mask, unsigned int test)
+{
+	int err = 1000000;
+
+	do {} while (--err && ((ltq_reg_r32(module, LTQ_SYSCTL_ACTS)
+					& mask) != test));
+	if (!err)
+		pr_err("module de/activation failed %d %08X %08X\n",
+							module, mask, test);
+}
+
+void
+ltq_sysctl_activate(int module, unsigned int mask)
+{
+	if (module > SYSCTL_SYSGPE)
+		return;
+
+	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKEN);
+	ltq_reg_w32(module, mask, LTQ_SYSCTL_ACT);
+	ltq_sysctl_wait(module, mask, mask);
+}
+EXPORT_SYMBOL(ltq_sysctl_activate);
+
+void
+ltq_sysctl_deactivate(int module, unsigned int mask)
+{
+	if (module > SYSCTL_SYSGPE)
+		return;
+
+	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKCLR);
+	ltq_reg_w32(module, mask, LTQ_SYSCTL_DEACT);
+	ltq_sysctl_wait(module, mask, 0);
+}
+EXPORT_SYMBOL(ltq_sysctl_deactivate);
+
+void
+ltq_sysctl_clken(int module, unsigned int mask)
+{
+	if (module > SYSCTL_SYSGPE)
+		return;
+
+	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKEN);
+	ltq_sysctl_wait(module, mask, mask);
+}
+EXPORT_SYMBOL(ltq_sysctl_clken);
+
+void
+ltq_sysctl_clkdis(int module, unsigned int mask)
+{
+	if (module > SYSCTL_SYSGPE)
+		return;
+
+	ltq_reg_w32(module, mask, LTQ_SYSCTL_CLKCLR);
+	ltq_sysctl_wait(module, mask, 0);
+}
+EXPORT_SYMBOL(ltq_sysctl_clkdis);
+
+void
+ltq_sysctl_reboot(int module, unsigned int mask)
+{
+	unsigned int act;
+
+	if (module > SYSCTL_SYSGPE)
+		return;
+
+	act = ltq_reg_r32(module, LTQ_SYSCTL_ACT);
+	if ((~act & mask) != 0)
+		ltq_sysctl_activate(module, ~act & mask);
+	ltq_reg_w32(module, act & mask, LTQ_SYSCTL_RBT);
+	ltq_sysctl_wait(module, mask, mask);
+}
+EXPORT_SYMBOL(ltq_sysctl_reboot);
+
+/* enable the ONU core */
+static void
+ltq_gpe_enable(void)
+{
+	unsigned int freq;
+	unsigned int status;
+
+	/* if if the clock is already enabled */
+	status = ltq_reg_r32(SYSCTL_SYS1, SYS1_INFRAC);
+	if (status & (1 << (GPPC_OFFSET + 1)))
+		return;
+
+	if (ltq_status_r32(STATUS_CONFIG) == 0)
+		freq = 1; /* use 625MHz on unfused chip */
+	else
+		freq = (ltq_status_r32(STATUS_CONFIG) &
+			GPEFREQ_MASK) >>
+			GPEFREQ_OFFSET;
+
+	/* apply new frequency */
+	ltq_reg_w32_mask(SYSCTL_SYS1, 7 << (GPPC_OFFSET + 1),
+		freq << (GPPC_OFFSET + 2) , SYS1_INFRAC);
+	udelay(1);
+
+	/* enable new frequency */
+	ltq_reg_w32_mask(SYSCTL_SYS1, 0, 1 << (GPPC_OFFSET + 1), SYS1_INFRAC);
+	udelay(1);
+}
+
+void __init
+ltq_soc_init(void)
+{
+	int i;
+
+	for (i = 0; i < 3; i++)
+		ltq_sysctl[i] = ltq_remap_resource(&ltq_sysctl_res[i]);
+
+	ltq_sys1_membase = ltq_sysctl[0];
+	ltq_status_membase = ltq_remap_resource(&ltq_status_res);
+	ltq_ebu_membase = ltq_remap_resource(&ltq_ebu_res);
+
+	ltq_gpe_enable();
+}
-- 
1.7.2.3
