Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:56:44 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:64264 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133390AbVJTGzb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:55:31 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:55:15 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:55:13 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10680; Wed, 19 Oct 2005 23:55:13 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28073 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:55:12
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6tCov008675 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:55:12 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6tBv23934 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:55:11 -0700
Date:	Wed, 19 Oct 2005 23:55:11 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/12]  1480-headers
Message-ID: <20051020065511.GB23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E0D94NK4415844-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Add header files for BCM1480/1280/1455/1255 family of chips, and
update sb1250 headers which are shared by BCM1480 family.

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 include/asm-mips/sibyte/bcm1480_int.h   |  310 ++++++++++
 include/asm-mips/sibyte/bcm1480_l2c.h   |  176 +++++
 include/asm-mips/sibyte/bcm1480_mc.h    |  962 ++++++++++++++++++++++++++++++++
 include/asm-mips/sibyte/bcm1480_regs.h  |  869 ++++++++++++++++++++++++++++
 include/asm-mips/sibyte/bcm1480_scd.h   |  436 ++++++++++++++
 include/asm-mips/sibyte/sb1250.h        |   11 
 include/asm-mips/sibyte/sb1250_defs.h   |   33 -
 include/asm-mips/sibyte/sb1250_dma.h    |   65 +-
 include/asm-mips/sibyte/sb1250_genbus.h |  225 +++++++
 include/asm-mips/sibyte/sb1250_int.h    |    6 
 include/asm-mips/sibyte/sb1250_l2c.h    |    9 
 include/asm-mips/sibyte/sb1250_mac.h    |   33 -
 include/asm-mips/sibyte/sb1250_mc.h     |    4 
 include/asm-mips/sibyte/sb1250_regs.h   |   33 -
 include/asm-mips/sibyte/sb1250_scd.h    |  100 ++-
 include/asm-mips/sibyte/sb1250_smbus.h  |   53 +
 include/asm-mips/sibyte/sb1250_uart.h   |   11 
 17 files changed, 3237 insertions(+), 99 deletions(-)

Index: lmo/include/asm-mips/sibyte/bcm1480_int.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/include/asm-mips/sibyte/bcm1480_int.h	2005-10-19 22:34:11.000000000 -0700
@@ -0,0 +1,310 @@
+/*  *********************************************************************
+    *  BCM1280/BCM1480 Board Support Package
+    *
+    *  Interrupt Mapper definitions		File: bcm1480_int.h
+    *
+    *  This module contains constants for manipulating the
+    *  BCM1255/BCM1280/BCM1455/BCM1480's interrupt mapper and
+    *  definitions for the interrupt sources.
+    *
+    *  BCM1480 specification level: 1X55_1X80-UM100-D4 (11/24/03)
+    *
+    *********************************************************************
+    *
+    *  Copyright 2000,2001,2002,2003
+    *  Broadcom Corporation. All rights reserved.
+    *
+    *  This program is free software; you can redistribute it and/or
+    *  modify it under the terms of the GNU General Public License as
+    *  published by the Free Software Foundation; either version 2 of
+    *  the License, or (at your option) any later version.
+    *
+    *  This program is distributed in the hope that it will be useful,
+    *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+    *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    *  GNU General Public License for more details.
+    *
+    *  You should have received a copy of the GNU General Public License
+    *  along with this program; if not, write to the Free Software
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  MA 02111-1307 USA
+    ********************************************************************* */
+
+
+#ifndef _BCM1480_INT_H
+#define _BCM1480_INT_H
+
+#include "sb1250_defs.h"
+
+/*  *********************************************************************
+    *  Interrupt Mapper Constants
+    ********************************************************************* */
+
+/*
+ * The interrupt mapper deals with 128-bit logical registers that are
+ * implemented as pairs of 64-bit registers, with the "low" 64 bits in
+ * a register that has an address 0x1000 higher(!) than the
+ * corresponding "high" register.
+ *
+ * For appropriate registers, bit 0 of the "high" register is a
+ * cascade bit that summarizes (as a bit-OR) the 64 bits of the "low"
+ * register.
+ */
+
+/*
+ * This entire file uses _BCM1480_ in all the symbols because it is
+ * entirely BCM1480 specific.
+ */
+
+/*
+ * Interrupt sources (Table 22)
+ */
+
+#define K_BCM1480_INT_SOURCES               128
+
+#define _BCM1480_INT_HIGH(k)   (k)
+#define _BCM1480_INT_LOW(k)    ((k)+64)
+
+#define K_BCM1480_INT_ADDR_TRAP             _BCM1480_INT_HIGH(1)
+#define K_BCM1480_INT_GPIO_0                _BCM1480_INT_HIGH(4)
+#define K_BCM1480_INT_GPIO_1                _BCM1480_INT_HIGH(5)
+#define K_BCM1480_INT_GPIO_2                _BCM1480_INT_HIGH(6)
+#define K_BCM1480_INT_GPIO_3                _BCM1480_INT_HIGH(7)
+#define K_BCM1480_INT_PCI_INTA              _BCM1480_INT_HIGH(8)
+#define K_BCM1480_INT_PCI_INTB              _BCM1480_INT_HIGH(9)
+#define K_BCM1480_INT_PCI_INTC              _BCM1480_INT_HIGH(10)
+#define K_BCM1480_INT_PCI_INTD              _BCM1480_INT_HIGH(11)
+#define K_BCM1480_INT_CYCLE_CP0             _BCM1480_INT_HIGH(12)
+#define K_BCM1480_INT_CYCLE_CP1             _BCM1480_INT_HIGH(13)
+#define K_BCM1480_INT_CYCLE_CP2             _BCM1480_INT_HIGH(14)
+#define K_BCM1480_INT_CYCLE_CP3             _BCM1480_INT_HIGH(15)
+#define K_BCM1480_INT_TIMER_0               _BCM1480_INT_HIGH(20)
+#define K_BCM1480_INT_TIMER_1               _BCM1480_INT_HIGH(21)
+#define K_BCM1480_INT_TIMER_2               _BCM1480_INT_HIGH(22)
+#define K_BCM1480_INT_TIMER_3               _BCM1480_INT_HIGH(23)
+#define K_BCM1480_INT_DM_CH_0               _BCM1480_INT_HIGH(28)
+#define K_BCM1480_INT_DM_CH_1               _BCM1480_INT_HIGH(29)
+#define K_BCM1480_INT_DM_CH_2               _BCM1480_INT_HIGH(30)
+#define K_BCM1480_INT_DM_CH_3               _BCM1480_INT_HIGH(31)
+#define K_BCM1480_INT_MAC_0                 _BCM1480_INT_HIGH(36)
+#define K_BCM1480_INT_MAC_0_CH1             _BCM1480_INT_HIGH(37)
+#define K_BCM1480_INT_MAC_1                 _BCM1480_INT_HIGH(38)
+#define K_BCM1480_INT_MAC_1_CH1             _BCM1480_INT_HIGH(39)
+#define K_BCM1480_INT_MAC_2                 _BCM1480_INT_HIGH(40)
+#define K_BCM1480_INT_MAC_2_CH1             _BCM1480_INT_HIGH(41)
+#define K_BCM1480_INT_MAC_3                 _BCM1480_INT_HIGH(42)
+#define K_BCM1480_INT_MAC_3_CH1             _BCM1480_INT_HIGH(43)
+#define K_BCM1480_INT_PMI_LOW               _BCM1480_INT_HIGH(52)
+#define K_BCM1480_INT_PMI_HIGH              _BCM1480_INT_HIGH(53)
+#define K_BCM1480_INT_PMO_LOW               _BCM1480_INT_HIGH(54)
+#define K_BCM1480_INT_PMO_HIGH              _BCM1480_INT_HIGH(55)
+#define K_BCM1480_INT_MBOX_0_0              _BCM1480_INT_HIGH(56)
+#define K_BCM1480_INT_MBOX_0_1              _BCM1480_INT_HIGH(57)
+#define K_BCM1480_INT_MBOX_0_2              _BCM1480_INT_HIGH(58)
+#define K_BCM1480_INT_MBOX_0_3              _BCM1480_INT_HIGH(59)
+#define K_BCM1480_INT_MBOX_1_0              _BCM1480_INT_HIGH(60)
+#define K_BCM1480_INT_MBOX_1_1              _BCM1480_INT_HIGH(61)
+#define K_BCM1480_INT_MBOX_1_2              _BCM1480_INT_HIGH(62)
+#define K_BCM1480_INT_MBOX_1_3              _BCM1480_INT_HIGH(63)
+
+#define K_BCM1480_INT_BAD_ECC               _BCM1480_INT_LOW(1)
+#define K_BCM1480_INT_COR_ECC               _BCM1480_INT_LOW(2)
+#define K_BCM1480_INT_IO_BUS                _BCM1480_INT_LOW(3)
+#define K_BCM1480_INT_PERF_CNT              _BCM1480_INT_LOW(4)
+#define K_BCM1480_INT_SW_PERF_CNT           _BCM1480_INT_LOW(5)
+#define K_BCM1480_INT_TRACE_FREEZE          _BCM1480_INT_LOW(6)
+#define K_BCM1480_INT_SW_TRACE_FREEZE       _BCM1480_INT_LOW(7)
+#define K_BCM1480_INT_WATCHDOG_TIMER_0      _BCM1480_INT_LOW(8)
+#define K_BCM1480_INT_WATCHDOG_TIMER_1      _BCM1480_INT_LOW(9)
+#define K_BCM1480_INT_WATCHDOG_TIMER_2      _BCM1480_INT_LOW(10)
+#define K_BCM1480_INT_WATCHDOG_TIMER_3      _BCM1480_INT_LOW(11)
+#define K_BCM1480_INT_PCI_ERROR             _BCM1480_INT_LOW(16)
+#define K_BCM1480_INT_PCI_RESET             _BCM1480_INT_LOW(17)
+#define K_BCM1480_INT_NODE_CONTROLLER       _BCM1480_INT_LOW(18)
+#define K_BCM1480_INT_HOST_BRIDGE           _BCM1480_INT_LOW(19)
+#define K_BCM1480_INT_PORT_0_FATAL          _BCM1480_INT_LOW(20)
+#define K_BCM1480_INT_PORT_0_NONFATAL       _BCM1480_INT_LOW(21)
+#define K_BCM1480_INT_PORT_1_FATAL          _BCM1480_INT_LOW(22)
+#define K_BCM1480_INT_PORT_1_NONFATAL       _BCM1480_INT_LOW(23)
+#define K_BCM1480_INT_PORT_2_FATAL          _BCM1480_INT_LOW(24)
+#define K_BCM1480_INT_PORT_2_NONFATAL       _BCM1480_INT_LOW(25)
+#define K_BCM1480_INT_LDT_SMI               _BCM1480_INT_LOW(32)
+#define K_BCM1480_INT_LDT_NMI               _BCM1480_INT_LOW(33)
+#define K_BCM1480_INT_LDT_INIT              _BCM1480_INT_LOW(34)
+#define K_BCM1480_INT_LDT_STARTUP           _BCM1480_INT_LOW(35)
+#define K_BCM1480_INT_LDT_EXT               _BCM1480_INT_LOW(36)
+#define K_BCM1480_INT_SMB_0                 _BCM1480_INT_LOW(40)
+#define K_BCM1480_INT_SMB_1                 _BCM1480_INT_LOW(41)
+#define K_BCM1480_INT_PCMCIA                _BCM1480_INT_LOW(42)
+#define K_BCM1480_INT_UART_0                _BCM1480_INT_LOW(44)
+#define K_BCM1480_INT_UART_1                _BCM1480_INT_LOW(45)
+#define K_BCM1480_INT_UART_2                _BCM1480_INT_LOW(46)
+#define K_BCM1480_INT_UART_3                _BCM1480_INT_LOW(47)
+#define K_BCM1480_INT_GPIO_4                _BCM1480_INT_LOW(52)
+#define K_BCM1480_INT_GPIO_5                _BCM1480_INT_LOW(53)
+#define K_BCM1480_INT_GPIO_6                _BCM1480_INT_LOW(54)
+#define K_BCM1480_INT_GPIO_7                _BCM1480_INT_LOW(55)
+#define K_BCM1480_INT_GPIO_8                _BCM1480_INT_LOW(56)
+#define K_BCM1480_INT_GPIO_9                _BCM1480_INT_LOW(57)
+#define K_BCM1480_INT_GPIO_10               _BCM1480_INT_LOW(58)
+#define K_BCM1480_INT_GPIO_11               _BCM1480_INT_LOW(59)
+#define K_BCM1480_INT_GPIO_12               _BCM1480_INT_LOW(60)
+#define K_BCM1480_INT_GPIO_13               _BCM1480_INT_LOW(61)
+#define K_BCM1480_INT_GPIO_14               _BCM1480_INT_LOW(62)
+#define K_BCM1480_INT_GPIO_15               _BCM1480_INT_LOW(63)
+
+/*
+ * Mask values for each interrupt
+ */
+
+#define _BCM1480_INT_MASK1(n)               _SB_MAKEMASK1(((n) & 0x3F))
+#define _BCM1480_INT_OFFSET(n)              (((n) & 0x40) << 6)
+
+#define M_BCM1480_INT_CASCADE               _BCM1480_INT_MASK1(_BCM1480_INT_HIGH(0))
+
+#define M_BCM1480_INT_ADDR_TRAP             _BCM1480_INT_MASK1(K_BCM1480_INT_ADDR_TRAP)
+#define M_BCM1480_INT_GPIO_0                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_0)
+#define M_BCM1480_INT_GPIO_1                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_1)
+#define M_BCM1480_INT_GPIO_2                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_2)
+#define M_BCM1480_INT_GPIO_3                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_3)
+#define M_BCM1480_INT_PCI_INTA              _BCM1480_INT_MASK1(K_BCM1480_INT_PCI_INTA)
+#define M_BCM1480_INT_PCI_INTB              _BCM1480_INT_MASK1(K_BCM1480_INT_PCI_INTB)
+#define M_BCM1480_INT_PCI_INTC              _BCM1480_INT_MASK1(K_BCM1480_INT_PCI_INTC)
+#define M_BCM1480_INT_PCI_INTD              _BCM1480_INT_MASK1(K_BCM1480_INT_PCI_INTD)
+#define M_BCM1480_INT_CYCLE_CP0             _BCM1480_INT_MASK1(K_BCM1480_INT_CYCLE_CP0)
+#define M_BCM1480_INT_CYCLE_CP1             _BCM1480_INT_MASK1(K_BCM1480_INT_CYCLE_CP1)
+#define M_BCM1480_INT_CYCLE_CP2             _BCM1480_INT_MASK1(K_BCM1480_INT_CYCLE_CP2)
+#define M_BCM1480_INT_CYCLE_CP3             _BCM1480_INT_MASK1(K_BCM1480_INT_CYCLE_CP3)
+#define M_BCM1480_INT_TIMER_0               _BCM1480_INT_MASK1(K_BCM1480_INT_TIMER_0)
+#define M_BCM1480_INT_TIMER_1               _BCM1480_INT_MASK1(K_BCM1480_INT_TIMER_1)
+#define M_BCM1480_INT_TIMER_2               _BCM1480_INT_MASK1(K_BCM1480_INT_TIMER_2)
+#define M_BCM1480_INT_TIMER_3               _BCM1480_INT_MASK1(K_BCM1480_INT_TIMER_3)
+#define M_BCM1480_INT_DM_CH_0               _BCM1480_INT_MASK1(K_BCM1480_INT_DM_CH_0)
+#define M_BCM1480_INT_DM_CH_1               _BCM1480_INT_MASK1(K_BCM1480_INT_DM_CH_1)
+#define M_BCM1480_INT_DM_CH_2               _BCM1480_INT_MASK1(K_BCM1480_INT_DM_CH_2)
+#define M_BCM1480_INT_DM_CH_3               _BCM1480_INT_MASK1(K_BCM1480_INT_DM_CH_3)
+#define M_BCM1480_INT_MAC_0                 _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_0)
+#define M_BCM1480_INT_MAC_0_CH1             _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_0_CH1)
+#define M_BCM1480_INT_MAC_1                 _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_1)
+#define M_BCM1480_INT_MAC_1_CH1             _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_1_CH1)
+#define M_BCM1480_INT_MAC_2                 _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_2)
+#define M_BCM1480_INT_MAC_2_CH1             _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_2_CH1)
+#define M_BCM1480_INT_MAC_3                 _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_3)
+#define M_BCM1480_INT_MAC_3_CH1             _BCM1480_INT_MASK1(K_BCM1480_INT_MAC_3_CH1)
+#define M_BCM1480_INT_PMI_LOW               _BCM1480_INT_MASK1(K_BCM1480_INT_PMI_LOW)
+#define M_BCM1480_INT_PMI_HIGH              _BCM1480_INT_MASK1(K_BCM1480_INT_PMI_HIGH)
+#define M_BCM1480_INT_PMO_LOW               _BCM1480_INT_MASK1(K_BCM1480_INT_PMO_LOW)
+#define M_BCM1480_INT_PMO_HIGH              _BCM1480_INT_MASK1(K_BCM1480_INT_PMO_HIGH)
+#define M_BCM1480_INT_MBOX_0_0              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_0)
+#define M_BCM1480_INT_MBOX_0_1              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_1)
+#define M_BCM1480_INT_MBOX_0_2              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_2)
+#define M_BCM1480_INT_MBOX_0_3              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_0_3)
+#define M_BCM1480_INT_MBOX_1_0              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_1_0)
+#define M_BCM1480_INT_MBOX_1_1              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_1_1)
+#define M_BCM1480_INT_MBOX_1_2              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_1_2)
+#define M_BCM1480_INT_MBOX_1_3              _BCM1480_INT_MASK1(K_BCM1480_INT_MBOX_1_3)
+#define M_BCM1480_INT_BAD_ECC               _BCM1480_INT_MASK1(K_BCM1480_INT_BAD_ECC)
+#define M_BCM1480_INT_COR_ECC               _BCM1480_INT_MASK1(K_BCM1480_INT_COR_ECC)
+#define M_BCM1480_INT_IO_BUS                _BCM1480_INT_MASK1(K_BCM1480_INT_IO_BUS)
+#define M_BCM1480_INT_PERF_CNT              _BCM1480_INT_MASK1(K_BCM1480_INT_PERF_CNT)
+#define M_BCM1480_INT_SW_PERF_CNT           _BCM1480_INT_MASK1(K_BCM1480_INT_SW_PERF_CNT)
+#define M_BCM1480_INT_TRACE_FREEZE          _BCM1480_INT_MASK1(K_BCM1480_INT_TRACE_FREEZE)
+#define M_BCM1480_INT_SW_TRACE_FREEZE       _BCM1480_INT_MASK1(K_BCM1480_INT_SW_TRACE_FREEZE)
+#define M_BCM1480_INT_WATCHDOG_TIMER_0      _BCM1480_INT_MASK1(K_BCM1480_INT_WATCHDOG_TIMER_0)
+#define M_BCM1480_INT_WATCHDOG_TIMER_1      _BCM1480_INT_MASK1(K_BCM1480_INT_WATCHDOG_TIMER_1)
+#define M_BCM1480_INT_WATCHDOG_TIMER_2      _BCM1480_INT_MASK1(K_BCM1480_INT_WATCHDOG_TIMER_2)
+#define M_BCM1480_INT_WATCHDOG_TIMER_3      _BCM1480_INT_MASK1(K_BCM1480_INT_WATCHDOG_TIMER_3)
+#define M_BCM1480_INT_PCI_ERROR             _BCM1480_INT_MASK1(K_BCM1480_INT_PCI_ERROR)
+#define M_BCM1480_INT_PCI_RESET             _BCM1480_INT_MASK1(K_BCM1480_INT_PCI_RESET)
+#define M_BCM1480_INT_NODE_CONTROLLER       _BCM1480_INT_MASK1(K_BCM1480_INT_NODE_CONTROLLER)
+#define M_BCM1480_INT_HOST_BRIDGE           _BCM1480_INT_MASK1(K_BCM1480_INT_HOST_BRIDGE)
+#define M_BCM1480_INT_PORT_0_FATAL          _BCM1480_INT_MASK1(K_BCM1480_INT_PORT_0_FATAL)
+#define M_BCM1480_INT_PORT_0_NONFATAL       _BCM1480_INT_MASK1(K_BCM1480_INT_PORT_0_NONFATAL)
+#define M_BCM1480_INT_PORT_1_FATAL          _BCM1480_INT_MASK1(K_BCM1480_INT_PORT_1_FATAL)
+#define M_BCM1480_INT_PORT_1_NONFATAL       _BCM1480_INT_MASK1(K_BCM1480_INT_PORT_1_NONFATAL)
+#define M_BCM1480_INT_PORT_2_FATAL          _BCM1480_INT_MASK1(K_BCM1480_INT_PORT_2_FATAL)
+#define M_BCM1480_INT_PORT_2_NONFATAL       _BCM1480_INT_MASK1(K_BCM1480_INT_PORT_2_NONFATAL)
+#define M_BCM1480_INT_LDT_SMI               _BCM1480_INT_MASK1(K_BCM1480_INT_LDT_SMI)
+#define M_BCM1480_INT_LDT_NMI               _BCM1480_INT_MASK1(K_BCM1480_INT_LDT_NMI)
+#define M_BCM1480_INT_LDT_INIT              _BCM1480_INT_MASK1(K_BCM1480_INT_LDT_INIT)
+#define M_BCM1480_INT_LDT_STARTUP           _BCM1480_INT_MASK1(K_BCM1480_INT_LDT_STARTUP)
+#define M_BCM1480_INT_LDT_EXT               _BCM1480_INT_MASK1(K_BCM1480_INT_LDT_EXT)
+#define M_BCM1480_INT_SMB_0                 _BCM1480_INT_MASK1(K_BCM1480_INT_SMB_0)
+#define M_BCM1480_INT_SMB_1                 _BCM1480_INT_MASK1(K_BCM1480_INT_SMB_1)
+#define M_BCM1480_INT_PCMCIA                _BCM1480_INT_MASK1(K_BCM1480_INT_PCMCIA)
+#define M_BCM1480_INT_UART_0                _BCM1480_INT_MASK1(K_BCM1480_INT_UART_0)
+#define M_BCM1480_INT_UART_1                _BCM1480_INT_MASK1(K_BCM1480_INT_UART_1)
+#define M_BCM1480_INT_UART_2                _BCM1480_INT_MASK1(K_BCM1480_INT_UART_2)
+#define M_BCM1480_INT_UART_3                _BCM1480_INT_MASK1(K_BCM1480_INT_UART_3)
+#define M_BCM1480_INT_GPIO_4                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_4)
+#define M_BCM1480_INT_GPIO_5                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_5)
+#define M_BCM1480_INT_GPIO_6                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_6)
+#define M_BCM1480_INT_GPIO_7                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_7)
+#define M_BCM1480_INT_GPIO_8                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_8)
+#define M_BCM1480_INT_GPIO_9                _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_9)
+#define M_BCM1480_INT_GPIO_10               _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_10)
+#define M_BCM1480_INT_GPIO_11               _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_11)
+#define M_BCM1480_INT_GPIO_12               _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_12)
+#define M_BCM1480_INT_GPIO_13               _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_13)
+#define M_BCM1480_INT_GPIO_14               _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_14)
+#define M_BCM1480_INT_GPIO_15               _BCM1480_INT_MASK1(K_BCM1480_INT_GPIO_15)
+
+/*
+ * Interrupt mappings (Table 18)
+ */
+
+#define K_BCM1480_INT_MAP_I0    0		/* interrupt pins on processor */
+#define K_BCM1480_INT_MAP_I1    1
+#define K_BCM1480_INT_MAP_I2    2
+#define K_BCM1480_INT_MAP_I3    3
+#define K_BCM1480_INT_MAP_I4    4
+#define K_BCM1480_INT_MAP_I5    5
+#define K_BCM1480_INT_MAP_NMI   6		/* nonmaskable */
+#define K_BCM1480_INT_MAP_DINT  7		/* debug interrupt */
+
+/*
+ * Interrupt LDT Set Register (Table 19)
+ */
+
+#define S_BCM1480_INT_HT_INTMSG             0
+#define M_BCM1480_INT_HT_INTMSG             _SB_MAKEMASK(3,S_BCM1480_INT_HT_INTMSG)
+#define V_BCM1480_INT_HT_INTMSG(x)          _SB_MAKEVALUE(x,S_BCM1480_INT_HT_INTMSG)
+#define G_BCM1480_INT_HT_INTMSG(x)          _SB_GETVALUE(x,S_BCM1480_INT_HT_INTMSG,M_BCM1480_INT_HT_INTMSG)
+
+#define K_BCM1480_INT_HT_INTMSG_FIXED       0
+#define K_BCM1480_INT_HT_INTMSG_ARBITRATED  1
+#define K_BCM1480_INT_HT_INTMSG_SMI         2
+#define K_BCM1480_INT_HT_INTMSG_NMI         3
+#define K_BCM1480_INT_HT_INTMSG_INIT        4
+#define K_BCM1480_INT_HT_INTMSG_STARTUP     5
+#define K_BCM1480_INT_HT_INTMSG_EXTINT      6
+#define K_BCM1480_INT_HT_INTMSG_RESERVED    7
+
+#define M_BCM1480_INT_HT_TRIGGERMODE        _SB_MAKEMASK1(3)
+#define V_BCM1480_INT_HT_EDGETRIGGER        0
+#define V_BCM1480_INT_HT_LEVELTRIGGER       M_BCM1480_INT_HT_TRIGGERMODE
+
+#define M_BCM1480_INT_HT_DESTMODE           _SB_MAKEMASK1(4)
+#define V_BCM1480_INT_HT_PHYSICALDEST       0
+#define V_BCM1480_INT_HT_LOGICALDEST        M_BCM1480_INT_HT_DESTMODE
+
+#define S_BCM1480_INT_HT_INTDEST            5
+#define M_BCM1480_INT_HT_INTDEST            _SB_MAKEMASK(8,S_BCM1480_INT_HT_INTDEST)
+#define V_BCM1480_INT_HT_INTDEST(x)         _SB_MAKEVALUE(x,S_BCM1480_INT_HT_INTDEST)
+#define G_BCM1480_INT_HT_INTDEST(x)         _SB_GETVALUE(x,S_BCM1480_INT_HT_INTDEST,M_BCM1480_INT_HT_INTDEST)
+
+#define S_BCM1480_INT_HT_VECTOR             13
+#define M_BCM1480_INT_HT_VECTOR             _SB_MAKEMASK(8,S_BCM1480_INT_HT_VECTOR)
+#define V_BCM1480_INT_HT_VECTOR(x)          _SB_MAKEVALUE(x,S_BCM1480_INT_HT_VECTOR)
+#define G_BCM1480_INT_HT_VECTOR(x)          _SB_GETVALUE(x,S_BCM1480_INT_HT_VECTOR,M_BCM1480_INT_HT_VECTOR)
+
+/*
+ * Vector prefix (Table 4-7)
+ */
+
+#define M_BCM1480_HTVECT_RAISE_INTLDT_HIGH  0x00
+#define M_BCM1480_HTVECT_RAISE_MBOX_0       0x40
+#define M_BCM1480_HTVECT_RAISE_INTLDT_LO    0x80
+#define M_BCM1480_HTVECT_RAISE_MBOX_1       0xC0
+
+#endif /* _BCM1480_INT_H */
Index: lmo/include/asm-mips/sibyte/bcm1480_l2c.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/include/asm-mips/sibyte/bcm1480_l2c.h	2005-10-19 22:34:11.000000000 -0700
@@ -0,0 +1,176 @@
+/*  *********************************************************************
+    *  BCM1280/BCM1480 Board Support Package
+    *
+    *  L2 Cache constants and macros		File: bcm1480_l2c.h
+    *
+    *  This module contains constants useful for manipulating the
+    *  level 2 cache.
+    *
+    *  BCM1400 specification level:  1280-UM100-D2 (11/14/03)
+    *
+    *********************************************************************
+    *
+    *  Copyright 2000,2001,2002,2003
+    *  Broadcom Corporation. All rights reserved.
+    *
+    *  This program is free software; you can redistribute it and/or
+    *  modify it under the terms of the GNU General Public License as
+    *  published by the Free Software Foundation; either version 2 of
+    *  the License, or (at your option) any later version.
+    *
+    *  This program is distributed in the hope that it will be useful,
+    *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+    *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    *  GNU General Public License for more details.
+    *
+    *  You should have received a copy of the GNU General Public License
+    *  along with this program; if not, write to the Free Software
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  MA 02111-1307 USA
+    ********************************************************************* */
+
+
+#ifndef _BCM1480_L2C_H
+#define _BCM1480_L2C_H
+
+#include "sb1250_defs.h"
+
+/*
+ * Format of level 2 cache management address (Table 55)
+ */
+
+#define S_BCM1480_L2C_MGMT_INDEX            5
+#define M_BCM1480_L2C_MGMT_INDEX            _SB_MAKEMASK(12,S_BCM1480_L2C_MGMT_INDEX)
+#define V_BCM1480_L2C_MGMT_INDEX(x)         _SB_MAKEVALUE(x,S_BCM1480_L2C_MGMT_INDEX)
+#define G_BCM1480_L2C_MGMT_INDEX(x)         _SB_GETVALUE(x,S_BCM1480_L2C_MGMT_INDEX,M_BCM1480_L2C_MGMT_INDEX)
+
+#define S_BCM1480_L2C_MGMT_WAY              17
+#define M_BCM1480_L2C_MGMT_WAY              _SB_MAKEMASK(3,S_BCM1480_L2C_MGMT_WAY)
+#define V_BCM1480_L2C_MGMT_WAY(x)           _SB_MAKEVALUE(x,S_BCM1480_L2C_MGMT_WAY)
+#define G_BCM1480_L2C_MGMT_WAY(x)           _SB_GETVALUE(x,S_BCM1480_L2C_MGMT_WAY,M_BCM1480_L2C_MGMT_WAY)
+
+#define M_BCM1480_L2C_MGMT_DIRTY            _SB_MAKEMASK1(20)
+#define M_BCM1480_L2C_MGMT_VALID            _SB_MAKEMASK1(21)
+
+#define S_BCM1480_L2C_MGMT_ECC_DIAG         22
+#define M_BCM1480_L2C_MGMT_ECC_DIAG         _SB_MAKEMASK(2,S_BCM1480_L2C_MGMT_ECC_DIAG)
+#define V_BCM1480_L2C_MGMT_ECC_DIAG(x)      _SB_MAKEVALUE(x,S_BCM1480_L2C_MGMT_ECC_DIAG)
+#define G_BCM1480_L2C_MGMT_ECC_DIAG(x)      _SB_GETVALUE(x,S_BCM1480_L2C_MGMT_ECC_DIAG,M_BCM1480_L2C_MGMT_ECC_DIAG)
+
+#define A_BCM1480_L2C_MGMT_TAG_BASE         0x00D0000000
+
+#define BCM1480_L2C_ENTRIES_PER_WAY         4096
+#define BCM1480_L2C_NUM_WAYS                8
+
+
+/*
+ * Level 2 Cache Tag register (Table 59)
+ */
+
+#define S_BCM1480_L2C_TAG_MBZ               0
+#define M_BCM1480_L2C_TAG_MBZ               _SB_MAKEMASK(5,S_BCM1480_L2C_TAG_MBZ)
+
+#define S_BCM1480_L2C_TAG_INDEX             5
+#define M_BCM1480_L2C_TAG_INDEX             _SB_MAKEMASK(12,S_BCM1480_L2C_TAG_INDEX)
+#define V_BCM1480_L2C_TAG_INDEX(x)          _SB_MAKEVALUE(x,S_BCM1480_L2C_TAG_INDEX)
+#define G_BCM1480_L2C_TAG_INDEX(x)          _SB_GETVALUE(x,S_BCM1480_L2C_TAG_INDEX,M_BCM1480_L2C_TAG_INDEX)
+
+/* Note that index bit 16 is also tag bit 40 */
+#define S_BCM1480_L2C_TAG_TAG               17
+#define M_BCM1480_L2C_TAG_TAG               _SB_MAKEMASK(23,S_BCM1480_L2C_TAG_TAG)
+#define V_BCM1480_L2C_TAG_TAG(x)            _SB_MAKEVALUE(x,S_BCM1480_L2C_TAG_TAG)
+#define G_BCM1480_L2C_TAG_TAG(x)            _SB_GETVALUE(x,S_BCM1480_L2C_TAG_TAG,M_BCM1480_L2C_TAG_TAG)
+
+#define S_BCM1480_L2C_TAG_ECC               40
+#define M_BCM1480_L2C_TAG_ECC               _SB_MAKEMASK(6,S_BCM1480_L2C_TAG_ECC)
+#define V_BCM1480_L2C_TAG_ECC(x)            _SB_MAKEVALUE(x,S_BCM1480_L2C_TAG_ECC)
+#define G_BCM1480_L2C_TAG_ECC(x)            _SB_GETVALUE(x,S_BCM1480_L2C_TAG_ECC,M_BCM1480_L2C_TAG_ECC)
+
+#define S_BCM1480_L2C_TAG_WAY               46
+#define M_BCM1480_L2C_TAG_WAY               _SB_MAKEMASK(3,S_BCM1480_L2C_TAG_WAY)
+#define V_BCM1480_L2C_TAG_WAY(x)            _SB_MAKEVALUE(x,S_BCM1480_L2C_TAG_WAY)
+#define G_BCM1480_L2C_TAG_WAY(x)            _SB_GETVALUE(x,S_BCM1480_L2C_TAG_WAY,M_BCM1480_L2C_TAG_WAY)
+
+#define M_BCM1480_L2C_TAG_DIRTY             _SB_MAKEMASK1(49)
+#define M_BCM1480_L2C_TAG_VALID             _SB_MAKEMASK1(50)
+
+#define S_BCM1480_L2C_DATA_ECC              51
+#define M_BCM1480_L2C_DATA_ECC              _SB_MAKEMASK(10,S_BCM1480_L2C_DATA_ECC)
+#define V_BCM1480_L2C_DATA_ECC(x)           _SB_MAKEVALUE(x,S_BCM1480_L2C_DATA_ECC)
+#define G_BCM1480_L2C_DATA_ECC(x)           _SB_GETVALUE(x,S_BCM1480_L2C_DATA_ECC,M_BCM1480_L2C_DATA_ECC)
+
+
+/*
+ * L2 Misc0 Value Register (Table 60)
+ */
+
+#define S_BCM1480_L2C_MISC0_WAY_REMOTE      0
+#define M_BCM1480_L2C_MISC0_WAY_REMOTE      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC0_WAY_REMOTE)
+#define G_BCM1480_L2C_MISC0_WAY_REMOTE(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC0_WAY_REMOTE,M_BCM1480_L2C_MISC0_WAY_REMOTE)
+
+#define S_BCM1480_L2C_MISC0_WAY_LOCAL       8
+#define M_BCM1480_L2C_MISC0_WAY_LOCAL       _SB_MAKEMASK(8,S_BCM1480_L2C_MISC0_WAY_LOCAL)
+#define G_BCM1480_L2C_MISC0_WAY_LOCAL(x)    _SB_GETVALUE(x,S_BCM1480_L2C_MISC0_WAY_LOCAL,M_BCM1480_L2C_MISC0_WAY_LOCAL)
+
+#define S_BCM1480_L2C_MISC0_WAY_ENABLE      16
+#define M_BCM1480_L2C_MISC0_WAY_ENABLE      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC0_WAY_ENABLE)
+#define G_BCM1480_L2C_MISC0_WAY_ENABLE(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC0_WAY_ENABLE,M_BCM1480_L2C_MISC0_WAY_ENABLE)
+
+#define S_BCM1480_L2C_MISC0_CACHE_DISABLE   24
+#define M_BCM1480_L2C_MISC0_CACHE_DISABLE   _SB_MAKEMASK(2,S_BCM1480_L2C_MISC0_CACHE_DISABLE)
+#define G_BCM1480_L2C_MISC0_CACHE_DISABLE(x) _SB_GETVALUE(x,S_BCM1480_L2C_MISC0_CACHE_DISABLE,M_BCM1480_L2C_MISC0_CACHE_DISABLE)
+
+#define S_BCM1480_L2C_MISC0_CACHE_QUAD      26
+#define M_BCM1480_L2C_MISC0_CACHE_QUAD      _SB_MAKEMASK(2,S_BCM1480_L2C_MISC0_CACHE_QUAD)
+#define G_BCM1480_L2C_MISC0_CACHE_QUAD(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC0_CACHE_QUAD,M_BCM1480_L2C_MISC0_CACHE_QUAD)
+
+#define S_BCM1480_L2C_MISC0_MC_PRIORITY      30
+#define M_BCM1480_L2C_MISC0_MC_PRIORITY      _SB_MAKEMASK1(S_BCM1480_L2C_MISC0_MC_PRIORITY)
+
+#define S_BCM1480_L2C_MISC0_ECC_CLEANUP      31
+#define M_BCM1480_L2C_MISC0_ECC_CLEANUP      _SB_MAKEMASK1(S_BCM1480_L2C_MISC0_ECC_CLEANUP)
+
+
+/*
+ * L2 Misc1 Value Register (Table 60)
+ */
+
+#define S_BCM1480_L2C_MISC1_WAY_AGENT_0      0
+#define M_BCM1480_L2C_MISC1_WAY_AGENT_0      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC1_WAY_AGENT_0)
+#define G_BCM1480_L2C_MISC1_WAY_AGENT_0(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC1_WAY_AGENT_0,M_BCM1480_L2C_MISC1_WAY_AGENT_0)
+
+#define S_BCM1480_L2C_MISC1_WAY_AGENT_1      8
+#define M_BCM1480_L2C_MISC1_WAY_AGENT_1      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC1_WAY_AGENT_1)
+#define G_BCM1480_L2C_MISC1_WAY_AGENT_1(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC1_WAY_AGENT_1,M_BCM1480_L2C_MISC1_WAY_AGENT_1)
+
+#define S_BCM1480_L2C_MISC1_WAY_AGENT_2      16
+#define M_BCM1480_L2C_MISC1_WAY_AGENT_2      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC1_WAY_AGENT_2)
+#define G_BCM1480_L2C_MISC1_WAY_AGENT_2(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC1_WAY_AGENT_2,M_BCM1480_L2C_MISC1_WAY_AGENT_2)
+
+#define S_BCM1480_L2C_MISC1_WAY_AGENT_3      24
+#define M_BCM1480_L2C_MISC1_WAY_AGENT_3      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC1_WAY_AGENT_3)
+#define G_BCM1480_L2C_MISC1_WAY_AGENT_3(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC1_WAY_AGENT_3,M_BCM1480_L2C_MISC1_WAY_AGENT_3)
+
+#define S_BCM1480_L2C_MISC1_WAY_AGENT_4      32
+#define M_BCM1480_L2C_MISC1_WAY_AGENT_4      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC1_WAY_AGENT_4)
+#define G_BCM1480_L2C_MISC1_WAY_AGENT_4(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC1_WAY_AGENT_4,M_BCM1480_L2C_MISC1_WAY_AGENT_4)
+
+
+/*
+ * L2 Misc2 Value Register (Table 60)
+ */
+
+#define S_BCM1480_L2C_MISC2_WAY_AGENT_8      0
+#define M_BCM1480_L2C_MISC2_WAY_AGENT_8      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC2_WAY_AGENT_8)
+#define G_BCM1480_L2C_MISC2_WAY_AGENT_8(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC2_WAY_AGENT_8,M_BCM1480_L2C_MISC2_WAY_AGENT_8)
+
+#define S_BCM1480_L2C_MISC2_WAY_AGENT_9      8
+#define M_BCM1480_L2C_MISC2_WAY_AGENT_9      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC2_WAY_AGENT_9)
+#define G_BCM1480_L2C_MISC2_WAY_AGENT_9(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC2_WAY_AGENT_9,M_BCM1480_L2C_MISC2_WAY_AGENT_9)
+
+#define S_BCM1480_L2C_MISC2_WAY_AGENT_A      16
+#define M_BCM1480_L2C_MISC2_WAY_AGENT_A      _SB_MAKEMASK(8,S_BCM1480_L2C_MISC2_WAY_AGENT_A)
+#define G_BCM1480_L2C_MISC2_WAY_AGENT_A(x)   _SB_GETVALUE(x,S_BCM1480_L2C_MISC2_WAY_AGENT_A,M_BCM1480_L2C_MISC2_WAY_AGENT_A)
+
+
+#endif /* _BCM1480_L2C_H */
Index: lmo/include/asm-mips/sibyte/bcm1480_mc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/include/asm-mips/sibyte/bcm1480_mc.h	2005-10-19 22:34:11.000000000 -0700
@@ -0,0 +1,962 @@
+/*  *********************************************************************
+    *  BCM1280/BCM1480 Board Support Package
+    *
+    *  Memory Controller constants              File: bcm1480_mc.h
+    *
+    *  This module contains constants and macros useful for
+    *  programming the memory controller.
+    *
+    *  BCM1400 specification level:  1280-UM100-D1 (11/14/03 Review Copy)
+    *
+    *********************************************************************
+    *
+    *  Copyright 2000,2001,2002,2003
+    *  Broadcom Corporation. All rights reserved.
+    *
+    *  This program is free software; you can redistribute it and/or
+    *  modify it under the terms of the GNU General Public License as
+    *  published by the Free Software Foundation; either version 2 of
+    *  the License, or (at your option) any later version.
+    *
+    *  This program is distributed in the hope that it will be useful,
+    *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+    *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    *  GNU General Public License for more details.
+    *
+    *  You should have received a copy of the GNU General Public License
+    *  along with this program; if not, write to the Free Software
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  MA 02111-1307 USA
+    ********************************************************************* */
+
+
+#ifndef _BCM1480_MC_H
+#define _BCM1480_MC_H
+
+#include "sb1250_defs.h"
+
+/*
+ * Memory Channel Configuration Register (Table 81)
+ */
+
+#define S_BCM1480_MC_INTLV0                 0
+#define M_BCM1480_MC_INTLV0                 _SB_MAKEMASK(6,S_BCM1480_MC_INTLV0)
+#define V_BCM1480_MC_INTLV0(x)              _SB_MAKEVALUE(x,S_BCM1480_MC_INTLV0)
+#define G_BCM1480_MC_INTLV0(x)              _SB_GETVALUE(x,S_BCM1480_MC_INTLV0,M_BCM1480_MC_INTLV0)
+#define V_BCM1480_MC_INTLV0_DEFAULT         V_BCM1480_MC_INTLV0(0)
+
+#define S_BCM1480_MC_INTLV1                 8
+#define M_BCM1480_MC_INTLV1                 _SB_MAKEMASK(6,S_BCM1480_MC_INTLV1)
+#define V_BCM1480_MC_INTLV1(x)              _SB_MAKEVALUE(x,S_BCM1480_MC_INTLV1)
+#define G_BCM1480_MC_INTLV1(x)              _SB_GETVALUE(x,S_BCM1480_MC_INTLV1,M_BCM1480_MC_INTLV1)
+#define V_BCM1480_MC_INTLV1_DEFAULT         V_BCM1480_MC_INTLV1(0)
+
+#define S_BCM1480_MC_INTLV2                 16
+#define M_BCM1480_MC_INTLV2                 _SB_MAKEMASK(6,S_BCM1480_MC_INTLV2)
+#define V_BCM1480_MC_INTLV2(x)              _SB_MAKEVALUE(x,S_BCM1480_MC_INTLV2)
+#define G_BCM1480_MC_INTLV2(x)              _SB_GETVALUE(x,S_BCM1480_MC_INTLV2,M_BCM1480_MC_INTLV2)
+#define V_BCM1480_MC_INTLV2_DEFAULT         V_BCM1480_MC_INTLV2(0)
+
+#define S_BCM1480_MC_CS_MODE                32
+#define M_BCM1480_MC_CS_MODE                _SB_MAKEMASK(8,S_BCM1480_MC_CS_MODE)
+#define V_BCM1480_MC_CS_MODE(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_CS_MODE)
+#define G_BCM1480_MC_CS_MODE(x)             _SB_GETVALUE(x,S_BCM1480_MC_CS_MODE,M_BCM1480_MC_CS_MODE)
+#define V_BCM1480_MC_CS_MODE_DEFAULT        V_BCM1480_MC_CS_MODE(0)
+
+#define V_BCM1480_MC_CONFIG_DEFAULT         (V_BCM1480_MC_INTLV0_DEFAULT  | \
+                                     V_BCM1480_MC_INTLV1_DEFAULT  | \
+                                     V_BCM1480_MC_INTLV2_DEFAULT  | \
+				     V_BCM1480_MC_CS_MODE_DEFAULT)
+
+#define K_BCM1480_MC_CS01_MODE		    0x03
+#define K_BCM1480_MC_CS02_MODE		    0x05
+#define K_BCM1480_MC_CS0123_MODE	    0x0F
+#define K_BCM1480_MC_CS0246_MODE	    0x55
+#define K_BCM1480_MC_CS0145_MODE	    0x33
+#define K_BCM1480_MC_CS0167_MODE	    0xC3
+#define K_BCM1480_MC_CSFULL_MODE	    0xFF
+
+/*
+ * Chip Select Start Address Register (Table 82)
+ */
+
+#define S_BCM1480_MC_CS0_START              0
+#define M_BCM1480_MC_CS0_START              _SB_MAKEMASK(12,S_BCM1480_MC_CS0_START)
+#define V_BCM1480_MC_CS0_START(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_CS0_START)
+#define G_BCM1480_MC_CS0_START(x)           _SB_GETVALUE(x,S_BCM1480_MC_CS0_START,M_BCM1480_MC_CS0_START)
+
+#define S_BCM1480_MC_CS1_START              16
+#define M_BCM1480_MC_CS1_START              _SB_MAKEMASK(12,S_BCM1480_MC_CS1_START)
+#define V_BCM1480_MC_CS1_START(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_CS1_START)
+#define G_BCM1480_MC_CS1_START(x)           _SB_GETVALUE(x,S_BCM1480_MC_CS1_START,M_BCM1480_MC_CS1_START)
+
+#define S_BCM1480_MC_CS2_START              32
+#define M_BCM1480_MC_CS2_START              _SB_MAKEMASK(12,S_BCM1480_MC_CS2_START)
+#define V_BCM1480_MC_CS2_START(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_CS2_START)
+#define G_BCM1480_MC_CS2_START(x)           _SB_GETVALUE(x,S_BCM1480_MC_CS2_START,M_BCM1480_MC_CS2_START)
+
+#define S_BCM1480_MC_CS3_START              48
+#define M_BCM1480_MC_CS3_START              _SB_MAKEMASK(12,S_BCM1480_MC_CS3_START)
+#define V_BCM1480_MC_CS3_START(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_CS3_START)
+#define G_BCM1480_MC_CS3_START(x)           _SB_GETVALUE(x,S_BCM1480_MC_CS3_START,M_BCM1480_MC_CS3_START)
+
+/*
+ * Chip Select End Address Register (Table 83)
+ */
+
+#define S_BCM1480_MC_CS0_END                0
+#define M_BCM1480_MC_CS0_END                _SB_MAKEMASK(12,S_BCM1480_MC_CS0_END)
+#define V_BCM1480_MC_CS0_END(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_CS0_END)
+#define G_BCM1480_MC_CS0_END(x)             _SB_GETVALUE(x,S_BCM1480_MC_CS0_END,M_BCM1480_MC_CS0_END)
+
+#define S_BCM1480_MC_CS1_END                16
+#define M_BCM1480_MC_CS1_END                _SB_MAKEMASK(12,S_BCM1480_MC_CS1_END)
+#define V_BCM1480_MC_CS1_END(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_CS1_END)
+#define G_BCM1480_MC_CS1_END(x)             _SB_GETVALUE(x,S_BCM1480_MC_CS1_END,M_BCM1480_MC_CS1_END)
+
+#define S_BCM1480_MC_CS2_END                32
+#define M_BCM1480_MC_CS2_END                _SB_MAKEMASK(12,S_BCM1480_MC_CS2_END)
+#define V_BCM1480_MC_CS2_END(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_CS2_END)
+#define G_BCM1480_MC_CS2_END(x)             _SB_GETVALUE(x,S_BCM1480_MC_CS2_END,M_BCM1480_MC_CS2_END)
+
+#define S_BCM1480_MC_CS3_END                48
+#define M_BCM1480_MC_CS3_END                _SB_MAKEMASK(12,S_BCM1480_MC_CS3_END)
+#define V_BCM1480_MC_CS3_END(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_CS3_END)
+#define G_BCM1480_MC_CS3_END(x)             _SB_GETVALUE(x,S_BCM1480_MC_CS3_END,M_BCM1480_MC_CS3_END)
+
+/*
+ * Row Address Bit Select Register 0 (Table 84)
+ */
+
+#define S_BCM1480_MC_ROW00                  0
+#define M_BCM1480_MC_ROW00                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW00)
+#define V_BCM1480_MC_ROW00(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW00)
+#define G_BCM1480_MC_ROW00(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW00,M_BCM1480_MC_ROW00)
+
+#define S_BCM1480_MC_ROW01                  8
+#define M_BCM1480_MC_ROW01                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW01)
+#define V_BCM1480_MC_ROW01(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW01)
+#define G_BCM1480_MC_ROW01(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW01,M_BCM1480_MC_ROW01)
+
+#define S_BCM1480_MC_ROW02                  16
+#define M_BCM1480_MC_ROW02                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW02)
+#define V_BCM1480_MC_ROW02(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW02)
+#define G_BCM1480_MC_ROW02(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW02,M_BCM1480_MC_ROW02)
+
+#define S_BCM1480_MC_ROW03                  24
+#define M_BCM1480_MC_ROW03                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW03)
+#define V_BCM1480_MC_ROW03(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW03)
+#define G_BCM1480_MC_ROW03(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW03,M_BCM1480_MC_ROW03)
+
+#define S_BCM1480_MC_ROW04                  32
+#define M_BCM1480_MC_ROW04                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW04)
+#define V_BCM1480_MC_ROW04(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW04)
+#define G_BCM1480_MC_ROW04(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW04,M_BCM1480_MC_ROW04)
+
+#define S_BCM1480_MC_ROW05                  40
+#define M_BCM1480_MC_ROW05                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW05)
+#define V_BCM1480_MC_ROW05(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW05)
+#define G_BCM1480_MC_ROW05(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW05,M_BCM1480_MC_ROW05)
+
+#define S_BCM1480_MC_ROW06                  48
+#define M_BCM1480_MC_ROW06                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW06)
+#define V_BCM1480_MC_ROW06(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW06)
+#define G_BCM1480_MC_ROW06(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW06,M_BCM1480_MC_ROW06)
+
+#define S_BCM1480_MC_ROW07                  56
+#define M_BCM1480_MC_ROW07                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW07)
+#define V_BCM1480_MC_ROW07(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW07)
+#define G_BCM1480_MC_ROW07(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW07,M_BCM1480_MC_ROW07)
+
+/*
+ * Row Address Bit Select Register 1 (Table 85)
+ */
+
+#define S_BCM1480_MC_ROW08                  0
+#define M_BCM1480_MC_ROW08                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW08)
+#define V_BCM1480_MC_ROW08(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW08)
+#define G_BCM1480_MC_ROW08(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW08,M_BCM1480_MC_ROW08)
+
+#define S_BCM1480_MC_ROW09                  8
+#define M_BCM1480_MC_ROW09                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW09)
+#define V_BCM1480_MC_ROW09(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW09)
+#define G_BCM1480_MC_ROW09(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW09,M_BCM1480_MC_ROW09)
+
+#define S_BCM1480_MC_ROW10                  16
+#define M_BCM1480_MC_ROW10                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW10)
+#define V_BCM1480_MC_ROW10(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW10)
+#define G_BCM1480_MC_ROW10(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW10,M_BCM1480_MC_ROW10)
+
+#define S_BCM1480_MC_ROW11                  24
+#define M_BCM1480_MC_ROW11                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW11)
+#define V_BCM1480_MC_ROW11(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW11)
+#define G_BCM1480_MC_ROW11(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW11,M_BCM1480_MC_ROW11)
+
+#define S_BCM1480_MC_ROW12                  32
+#define M_BCM1480_MC_ROW12                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW12)
+#define V_BCM1480_MC_ROW12(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW12)
+#define G_BCM1480_MC_ROW12(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW12,M_BCM1480_MC_ROW12)
+
+#define S_BCM1480_MC_ROW13                  40
+#define M_BCM1480_MC_ROW13                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW13)
+#define V_BCM1480_MC_ROW13(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW13)
+#define G_BCM1480_MC_ROW13(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW13,M_BCM1480_MC_ROW13)
+
+#define S_BCM1480_MC_ROW14                  48
+#define M_BCM1480_MC_ROW14                  _SB_MAKEMASK(6,S_BCM1480_MC_ROW14)
+#define V_BCM1480_MC_ROW14(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_ROW14)
+#define G_BCM1480_MC_ROW14(x)               _SB_GETVALUE(x,S_BCM1480_MC_ROW14,M_BCM1480_MC_ROW14)
+
+#define K_BCM1480_MC_ROWX_BIT_SPACING  	    8
+
+/*
+ * Column Address Bit Select Register 0 (Table 86)
+ */
+
+#define S_BCM1480_MC_COL00                  0
+#define M_BCM1480_MC_COL00                  _SB_MAKEMASK(6,S_BCM1480_MC_COL00)
+#define V_BCM1480_MC_COL00(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL00)
+#define G_BCM1480_MC_COL00(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL00,M_BCM1480_MC_COL00)
+
+#define S_BCM1480_MC_COL01                  8
+#define M_BCM1480_MC_COL01                  _SB_MAKEMASK(6,S_BCM1480_MC_COL01)
+#define V_BCM1480_MC_COL01(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL01)
+#define G_BCM1480_MC_COL01(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL01,M_BCM1480_MC_COL01)
+
+#define S_BCM1480_MC_COL02                  16
+#define M_BCM1480_MC_COL02                  _SB_MAKEMASK(6,S_BCM1480_MC_COL02)
+#define V_BCM1480_MC_COL02(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL02)
+#define G_BCM1480_MC_COL02(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL02,M_BCM1480_MC_COL02)
+
+#define S_BCM1480_MC_COL03                  24
+#define M_BCM1480_MC_COL03                  _SB_MAKEMASK(6,S_BCM1480_MC_COL03)
+#define V_BCM1480_MC_COL03(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL03)
+#define G_BCM1480_MC_COL03(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL03,M_BCM1480_MC_COL03)
+
+#define S_BCM1480_MC_COL04                  32
+#define M_BCM1480_MC_COL04                  _SB_MAKEMASK(6,S_BCM1480_MC_COL04)
+#define V_BCM1480_MC_COL04(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL04)
+#define G_BCM1480_MC_COL04(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL04,M_BCM1480_MC_COL04)
+
+#define S_BCM1480_MC_COL05                  40
+#define M_BCM1480_MC_COL05                  _SB_MAKEMASK(6,S_BCM1480_MC_COL05)
+#define V_BCM1480_MC_COL05(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL05)
+#define G_BCM1480_MC_COL05(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL05,M_BCM1480_MC_COL05)
+
+#define S_BCM1480_MC_COL06                  48
+#define M_BCM1480_MC_COL06                  _SB_MAKEMASK(6,S_BCM1480_MC_COL06)
+#define V_BCM1480_MC_COL06(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL06)
+#define G_BCM1480_MC_COL06(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL06,M_BCM1480_MC_COL06)
+
+#define S_BCM1480_MC_COL07                  56
+#define M_BCM1480_MC_COL07                  _SB_MAKEMASK(6,S_BCM1480_MC_COL07)
+#define V_BCM1480_MC_COL07(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL07)
+#define G_BCM1480_MC_COL07(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL07,M_BCM1480_MC_COL07)
+
+/*
+ * Column Address Bit Select Register 1 (Table 87)
+ */
+
+#define S_BCM1480_MC_COL08                  0
+#define M_BCM1480_MC_COL08                  _SB_MAKEMASK(6,S_BCM1480_MC_COL08)
+#define V_BCM1480_MC_COL08(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL08)
+#define G_BCM1480_MC_COL08(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL08,M_BCM1480_MC_COL08)
+
+#define S_BCM1480_MC_COL09                  8
+#define M_BCM1480_MC_COL09                  _SB_MAKEMASK(6,S_BCM1480_MC_COL09)
+#define V_BCM1480_MC_COL09(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL09)
+#define G_BCM1480_MC_COL09(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL09,M_BCM1480_MC_COL09)
+
+#define S_BCM1480_MC_COL10                  16   /* not a valid position, must be prog as 0 */
+
+#define S_BCM1480_MC_COL11                  24
+#define M_BCM1480_MC_COL11                  _SB_MAKEMASK(6,S_BCM1480_MC_COL11)
+#define V_BCM1480_MC_COL11(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL11)
+#define G_BCM1480_MC_COL11(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL11,M_BCM1480_MC_COL11)
+
+#define S_BCM1480_MC_COL12                  32
+#define M_BCM1480_MC_COL12                  _SB_MAKEMASK(6,S_BCM1480_MC_COL12)
+#define V_BCM1480_MC_COL12(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL12)
+#define G_BCM1480_MC_COL12(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL12,M_BCM1480_MC_COL12)
+
+#define S_BCM1480_MC_COL13                  40
+#define M_BCM1480_MC_COL13                  _SB_MAKEMASK(6,S_BCM1480_MC_COL13)
+#define V_BCM1480_MC_COL13(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL13)
+#define G_BCM1480_MC_COL13(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL13,M_BCM1480_MC_COL13)
+
+#define S_BCM1480_MC_COL14                  48
+#define M_BCM1480_MC_COL14                  _SB_MAKEMASK(6,S_BCM1480_MC_COL14)
+#define V_BCM1480_MC_COL14(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_COL14)
+#define G_BCM1480_MC_COL14(x)               _SB_GETVALUE(x,S_BCM1480_MC_COL14,M_BCM1480_MC_COL14)
+
+#define K_BCM1480_MC_COLX_BIT_SPACING  	    8
+
+/*
+ * CS0 and CS1 Bank Address Bit Select Register (Table 88)
+ */
+
+#define S_BCM1480_MC_CS01_BANK0             0
+#define M_BCM1480_MC_CS01_BANK0             _SB_MAKEMASK(6,S_BCM1480_MC_CS01_BANK0)
+#define V_BCM1480_MC_CS01_BANK0(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_CS01_BANK0)
+#define G_BCM1480_MC_CS01_BANK0(x)          _SB_GETVALUE(x,S_BCM1480_MC_CS01_BANK0,M_BCM1480_MC_CS01_BANK0)
+
+#define S_BCM1480_MC_CS01_BANK1             8
+#define M_BCM1480_MC_CS01_BANK1             _SB_MAKEMASK(6,S_BCM1480_MC_CS01_BANK1)
+#define V_BCM1480_MC_CS01_BANK1(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_CS01_BANK1)
+#define G_BCM1480_MC_CS01_BANK1(x)          _SB_GETVALUE(x,S_BCM1480_MC_CS01_BANK1,M_BCM1480_MC_CS01_BANK1)
+
+#define S_BCM1480_MC_CS01_BANK2             16
+#define M_BCM1480_MC_CS01_BANK2             _SB_MAKEMASK(6,S_BCM1480_MC_CS01_BANK2)
+#define V_BCM1480_MC_CS01_BANK2(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_CS01_BANK2)
+#define G_BCM1480_MC_CS01_BANK2(x)          _SB_GETVALUE(x,S_BCM1480_MC_CS01_BANK2,M_BCM1480_MC_CS01_BANK2)
+
+/*
+ * CS2 and CS3 Bank Address Bit Select Register (Table 89)
+ */
+
+#define S_BCM1480_MC_CS23_BANK0             0
+#define M_BCM1480_MC_CS23_BANK0             _SB_MAKEMASK(6,S_BCM1480_MC_CS23_BANK0)
+#define V_BCM1480_MC_CS23_BANK0(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_CS23_BANK0)
+#define G_BCM1480_MC_CS23_BANK0(x)          _SB_GETVALUE(x,S_BCM1480_MC_CS23_BANK0,M_BCM1480_MC_CS23_BANK0)
+
+#define S_BCM1480_MC_CS23_BANK1             8
+#define M_BCM1480_MC_CS23_BANK1             _SB_MAKEMASK(6,S_BCM1480_MC_CS23_BANK1)
+#define V_BCM1480_MC_CS23_BANK1(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_CS23_BANK1)
+#define G_BCM1480_MC_CS23_BANK1(x)          _SB_GETVALUE(x,S_BCM1480_MC_CS23_BANK1,M_BCM1480_MC_CS23_BANK1)
+
+#define S_BCM1480_MC_CS23_BANK2             16
+#define M_BCM1480_MC_CS23_BANK2             _SB_MAKEMASK(6,S_BCM1480_MC_CS23_BANK2)
+#define V_BCM1480_MC_CS23_BANK2(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_CS23_BANK2)
+#define G_BCM1480_MC_CS23_BANK2(x)          _SB_GETVALUE(x,S_BCM1480_MC_CS23_BANK2,M_BCM1480_MC_CS23_BANK2)
+
+#define K_BCM1480_MC_CSXX_BANKX_BIT_SPACING  8
+
+/*
+ * DRAM Command Register (Table 90)
+ */
+
+#define S_BCM1480_MC_COMMAND                0
+#define M_BCM1480_MC_COMMAND                _SB_MAKEMASK(4,S_BCM1480_MC_COMMAND)
+#define V_BCM1480_MC_COMMAND(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_COMMAND)
+#define G_BCM1480_MC_COMMAND(x)             _SB_GETVALUE(x,S_BCM1480_MC_COMMAND,M_BCM1480_MC_COMMAND)
+
+#define K_BCM1480_MC_COMMAND_EMRS           0
+#define K_BCM1480_MC_COMMAND_MRS            1
+#define K_BCM1480_MC_COMMAND_PRE            2
+#define K_BCM1480_MC_COMMAND_AR             3
+#define K_BCM1480_MC_COMMAND_SETRFSH        4
+#define K_BCM1480_MC_COMMAND_CLRRFSH        5
+#define K_BCM1480_MC_COMMAND_SETPWRDN       6
+#define K_BCM1480_MC_COMMAND_CLRPWRDN       7
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define K_BCM1480_MC_COMMAND_EMRS2	    8
+#define K_BCM1480_MC_COMMAND_EMRS3	    9
+#define K_BCM1480_MC_COMMAND_ENABLE_MCLK    10
+#define K_BCM1480_MC_COMMAND_DISABLE_MCLK   11
+#endif
+
+#define V_BCM1480_MC_COMMAND_EMRS           V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_EMRS)
+#define V_BCM1480_MC_COMMAND_MRS            V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_MRS)
+#define V_BCM1480_MC_COMMAND_PRE            V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_PRE)
+#define V_BCM1480_MC_COMMAND_AR             V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_AR)
+#define V_BCM1480_MC_COMMAND_SETRFSH        V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_SETRFSH)
+#define V_BCM1480_MC_COMMAND_CLRRFSH        V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_CLRRFSH)
+#define V_BCM1480_MC_COMMAND_SETPWRDN       V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_SETPWRDN)
+#define V_BCM1480_MC_COMMAND_CLRPWRDN       V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_CLRPWRDN)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define V_BCM1480_MC_COMMAND_EMRS2          V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_EMRS2)
+#define V_BCM1480_MC_COMMAND_EMRS3          V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_EMRS3)
+#define V_BCM1480_MC_COMMAND_ENABLE_MCLK    V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_ENABLE_MCLK)
+#define V_BCM1480_MC_COMMAND_DISABLE_MCLK   V_BCM1480_MC_COMMAND(K_BCM1480_MC_COMMAND_DISABLE_MCLK)
+#endif
+
+#define S_BCM1480_MC_CS0		    4
+#define M_BCM1480_MC_CS0                    _SB_MAKEMASK1(4)
+#define M_BCM1480_MC_CS1                    _SB_MAKEMASK1(5)
+#define M_BCM1480_MC_CS2                    _SB_MAKEMASK1(6)
+#define M_BCM1480_MC_CS3                    _SB_MAKEMASK1(7)
+#define M_BCM1480_MC_CS4                    _SB_MAKEMASK1(8)
+#define M_BCM1480_MC_CS5                    _SB_MAKEMASK1(9)
+#define M_BCM1480_MC_CS6                    _SB_MAKEMASK1(10)
+#define M_BCM1480_MC_CS7                    _SB_MAKEMASK1(11)
+
+#define M_BCM1480_MC_CMD_ACTIVE             _SB_MAKEMASK1(16)
+
+/*
+ * DRAM Mode Register (Table 91)
+ */
+
+#define S_BCM1480_MC_EMODE                  0
+#define M_BCM1480_MC_EMODE                  _SB_MAKEMASK(15,S_BCM1480_MC_EMODE)
+#define V_BCM1480_MC_EMODE(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_EMODE)
+#define G_BCM1480_MC_EMODE(x)               _SB_GETVALUE(x,S_BCM1480_MC_EMODE,M_BCM1480_MC_EMODE)
+#define V_BCM1480_MC_EMODE_DEFAULT          V_BCM1480_MC_EMODE(0)
+
+#define S_BCM1480_MC_MODE                   16
+#define M_BCM1480_MC_MODE                   _SB_MAKEMASK(15,S_BCM1480_MC_MODE)
+#define V_BCM1480_MC_MODE(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_MODE)
+#define G_BCM1480_MC_MODE(x)                _SB_GETVALUE(x,S_BCM1480_MC_MODE,M_BCM1480_MC_MODE)
+#define V_BCM1480_MC_MODE_DEFAULT           V_BCM1480_MC_MODE(0)
+
+#define S_BCM1480_MC_DRAM_TYPE              32
+#define M_BCM1480_MC_DRAM_TYPE              _SB_MAKEMASK(4,S_BCM1480_MC_DRAM_TYPE)
+#define V_BCM1480_MC_DRAM_TYPE(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_DRAM_TYPE)
+#define G_BCM1480_MC_DRAM_TYPE(x)           _SB_GETVALUE(x,S_BCM1480_MC_DRAM_TYPE,M_BCM1480_MC_DRAM_TYPE)
+
+#define K_BCM1480_MC_DRAM_TYPE_JEDEC        0
+#define K_BCM1480_MC_DRAM_TYPE_FCRAM        1
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define K_BCM1480_MC_DRAM_TYPE_DDR2	    2
+#endif
+
+#define V_BCM1480_MC_DRAM_TYPE_JEDEC        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_JEDEC)
+#define V_BCM1480_MC_DRAM_TYPE_FCRAM        V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_FCRAM)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define V_BCM1480_MC_DRAM_TYPE_DDR2	    V_BCM1480_MC_DRAM_TYPE(K_BCM1480_MC_DRAM_TYPE_DDR2)
+#endif
+
+#define M_BCM1480_MC_GANGED                 _SB_MAKEMASK1(36)
+#define M_BCM1480_MC_BY9_INTF               _SB_MAKEMASK1(37)
+#define M_BCM1480_MC_FORCE_ECC64            _SB_MAKEMASK1(38)
+#define M_BCM1480_MC_ECC_DISABLE            _SB_MAKEMASK1(39)
+
+#define S_BCM1480_MC_PG_POLICY              40
+#define M_BCM1480_MC_PG_POLICY              _SB_MAKEMASK(2,S_BCM1480_MC_PG_POLICY)
+#define V_BCM1480_MC_PG_POLICY(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_PG_POLICY)
+#define G_BCM1480_MC_PG_POLICY(x)           _SB_GETVALUE(x,S_BCM1480_MC_PG_POLICY,M_BCM1480_MC_PG_POLICY)
+
+#define K_BCM1480_MC_PG_POLICY_CLOSED       0
+#define K_BCM1480_MC_PG_POLICY_CAS_TIME_CHK 1
+
+#define V_BCM1480_MC_PG_POLICY_CLOSED       V_BCM1480_MC_PG_POLICY(K_BCM1480_MC_PG_POLICY_CLOSED)
+#define V_BCM1480_MC_PG_POLICY_CAS_TIME_CHK V_BCM1480_MC_PG_POLICY(K_BCM1480_MC_PG_POLICY_CAS_TIME_CHK)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define M_BCM1480_MC_2T_CMD		    _SB_MAKEMASK1(42)
+#define M_BCM1480_MC_ECC_COR_DIS	    _SB_MAKEMASK1(43)
+#endif
+
+#define V_BCM1480_MC_DRAMMODE_DEFAULT	V_BCM1480_MC_EMODE_DEFAULT | V_BCM1480_MC_MODE_DEFAULT | V_BCM1480_MC_DRAM_TYPE_JEDEC | \
+                                V_BCM1480_MC_PG_POLICY(K_BCM1480_MC_PG_POLICY_CAS_TIME_CHK)
+
+/*
+ * Memory Clock Configuration Register (Table 92)
+ */
+
+#define S_BCM1480_MC_CLK_RATIO              0
+#define M_BCM1480_MC_CLK_RATIO              _SB_MAKEMASK(6,S_BCM1480_MC_CLK_RATIO)
+#define V_BCM1480_MC_CLK_RATIO(x)           _SB_MAKEVALUE(x,S_BCM1480_MC_CLK_RATIO)
+#define G_BCM1480_MC_CLK_RATIO(x)           _SB_GETVALUE(x,S_BCM1480_MC_CLK_RATIO,M_BCM1480_MC_CLK_RATIO)
+
+#define V_BCM1480_MC_CLK_RATIO_DEFAULT      V_BCM1480_MC_CLK_RATIO(10)
+
+#define S_BCM1480_MC_REF_RATE               8
+#define M_BCM1480_MC_REF_RATE               _SB_MAKEMASK(8,S_BCM1480_MC_REF_RATE)
+#define V_BCM1480_MC_REF_RATE(x)            _SB_MAKEVALUE(x,S_BCM1480_MC_REF_RATE)
+#define G_BCM1480_MC_REF_RATE(x)            _SB_GETVALUE(x,S_BCM1480_MC_REF_RATE,M_BCM1480_MC_REF_RATE)
+
+#define K_BCM1480_MC_REF_RATE_100MHz        0x31
+#define K_BCM1480_MC_REF_RATE_200MHz        0x62
+#define K_BCM1480_MC_REF_RATE_400MHz        0xC4
+
+#define V_BCM1480_MC_REF_RATE_100MHz        V_BCM1480_MC_REF_RATE(K_BCM1480_MC_REF_RATE_100MHz)
+#define V_BCM1480_MC_REF_RATE_200MHz        V_BCM1480_MC_REF_RATE(K_BCM1480_MC_REF_RATE_200MHz)
+#define V_BCM1480_MC_REF_RATE_400MHz        V_BCM1480_MC_REF_RATE(K_BCM1480_MC_REF_RATE_400MHz)
+#define V_BCM1480_MC_REF_RATE_DEFAULT       V_BCM1480_MC_REF_RATE_400MHz
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define M_BCM1480_MC_AUTO_REF_DIS	    _SB_MAKEMASK1(16)
+#endif
+
+/*
+ * ODT Register (Table 99)
+ */
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define M_BCM1480_MC_RD_ODT0_CS0	    _SB_MAKEMASK1(0)
+#define M_BCM1480_MC_RD_ODT0_CS2	    _SB_MAKEMASK1(1)
+#define M_BCM1480_MC_RD_ODT0_CS4	    _SB_MAKEMASK1(2)
+#define M_BCM1480_MC_RD_ODT0_CS6	    _SB_MAKEMASK1(3)
+#define M_BCM1480_MC_WR_ODT0_CS0	    _SB_MAKEMASK1(4)
+#define M_BCM1480_MC_WR_ODT0_CS2	    _SB_MAKEMASK1(5)
+#define M_BCM1480_MC_WR_ODT0_CS4	    _SB_MAKEMASK1(6)
+#define M_BCM1480_MC_WR_ODT0_CS6	    _SB_MAKEMASK1(7)
+#define M_BCM1480_MC_RD_ODT2_CS0	    _SB_MAKEMASK1(8)
+#define M_BCM1480_MC_RD_ODT2_CS2	    _SB_MAKEMASK1(9)
+#define M_BCM1480_MC_RD_ODT2_CS4	    _SB_MAKEMASK1(10)
+#define M_BCM1480_MC_RD_ODT2_CS6	    _SB_MAKEMASK1(11)
+#define M_BCM1480_MC_WR_ODT2_CS0	    _SB_MAKEMASK1(12)
+#define M_BCM1480_MC_WR_ODT2_CS2	    _SB_MAKEMASK1(13)
+#define M_BCM1480_MC_WR_ODT2_CS4	    _SB_MAKEMASK1(14)
+#define M_BCM1480_MC_WR_ODT2_CS6	    _SB_MAKEMASK1(15)
+#define M_BCM1480_MC_RD_ODT4_CS0	    _SB_MAKEMASK1(16)
+#define M_BCM1480_MC_RD_ODT4_CS2	    _SB_MAKEMASK1(17)
+#define M_BCM1480_MC_RD_ODT4_CS4	    _SB_MAKEMASK1(18)
+#define M_BCM1480_MC_RD_ODT4_CS6	    _SB_MAKEMASK1(19)
+#define M_BCM1480_MC_WR_ODT4_CS0	    _SB_MAKEMASK1(20)
+#define M_BCM1480_MC_WR_ODT4_CS2	    _SB_MAKEMASK1(21)
+#define M_BCM1480_MC_WR_ODT4_CS4	    _SB_MAKEMASK1(22)
+#define M_BCM1480_MC_WR_ODT4_CS6	    _SB_MAKEMASK1(23)
+#define M_BCM1480_MC_RD_ODT6_CS0	    _SB_MAKEMASK1(24)
+#define M_BCM1480_MC_RD_ODT6_CS2	    _SB_MAKEMASK1(25)
+#define M_BCM1480_MC_RD_ODT6_CS4	    _SB_MAKEMASK1(26)
+#define M_BCM1480_MC_RD_ODT6_CS6	    _SB_MAKEMASK1(27)
+#define M_BCM1480_MC_WR_ODT6_CS0	    _SB_MAKEMASK1(28)
+#define M_BCM1480_MC_WR_ODT6_CS2	    _SB_MAKEMASK1(29)
+#define M_BCM1480_MC_WR_ODT6_CS4	    _SB_MAKEMASK1(30)
+#define M_BCM1480_MC_WR_ODT6_CS6	    _SB_MAKEMASK1(31)
+
+#define M_BCM1480_MC_CS_ODD_ODT_EN	    _SB_MAKEMASK1(32)
+#endif
+
+/*
+ * Memory DLL Configuration Register (Table 93)
+ */
+
+#define S_BCM1480_MC_ADDR_COARSE_ADJ         0
+#define M_BCM1480_MC_ADDR_COARSE_ADJ         _SB_MAKEMASK(6,S_BCM1480_MC_ADDR_COARSE_ADJ)
+#define V_BCM1480_MC_ADDR_COARSE_ADJ(x)      _SB_MAKEVALUE(x,S_BCM1480_MC_ADDR_COARSE_ADJ)
+#define G_BCM1480_MC_ADDR_COARSE_ADJ(x)      _SB_GETVALUE(x,S_BCM1480_MC_ADDR_COARSE_ADJ,M_BCM1480_MC_ADDR_COARSE_ADJ)
+#define V_BCM1480_MC_ADDR_COARSE_ADJ_DEFAULT V_BCM1480_MC_ADDR_COARSE_ADJ(0x0)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_ADDR_FREQ_RANGE	    	8
+#define M_BCM1480_MC_ADDR_FREQ_RANGE	    	_SB_MAKEMASK(4,S_BCM1480_MC_ADDR_FREQ_RANGE)
+#define V_BCM1480_MC_ADDR_FREQ_RANGE(x)     	_SB_MAKEVALUE(x,S_BCM1480_MC_ADDR_FREQ_RANGE)
+#define G_BCM1480_MC_ADDR_FREQ_RANGE(x)     	_SB_GETVALUE(x,S_BCM1480_MC_ADDR_FREQ_RANGE,M_BCM1480_MC_ADDR_FREQ_RANGE)
+#define V_BCM1480_MC_ADDR_FREQ_RANGE_DEFAULT 	V_BCM1480_MC_ADDR_FREQ_RANGE(0x4)
+#endif
+
+#define S_BCM1480_MC_ADDR_FINE_ADJ          8
+#define M_BCM1480_MC_ADDR_FINE_ADJ          _SB_MAKEMASK(4,S_BCM1480_MC_ADDR_FINE_ADJ)
+#define V_BCM1480_MC_ADDR_FINE_ADJ(x)       _SB_MAKEVALUE(x,S_BCM1480_MC_ADDR_FINE_ADJ)
+#define G_BCM1480_MC_ADDR_FINE_ADJ(x)       _SB_GETVALUE(x,S_BCM1480_MC_ADDR_FINE_ADJ,M_BCM1480_MC_ADDR_FINE_ADJ)
+#define V_BCM1480_MC_ADDR_FINE_ADJ_DEFAULT  V_BCM1480_MC_ADDR_FINE_ADJ(0x8)
+
+#define S_BCM1480_MC_DQI_COARSE_ADJ         16
+#define M_BCM1480_MC_DQI_COARSE_ADJ         _SB_MAKEMASK(6,S_BCM1480_MC_DQI_COARSE_ADJ)
+#define V_BCM1480_MC_DQI_COARSE_ADJ(x)      _SB_MAKEVALUE(x,S_BCM1480_MC_DQI_COARSE_ADJ)
+#define G_BCM1480_MC_DQI_COARSE_ADJ(x)      _SB_GETVALUE(x,S_BCM1480_MC_DQI_COARSE_ADJ,M_BCM1480_MC_DQI_COARSE_ADJ)
+#define V_BCM1480_MC_DQI_COARSE_ADJ_DEFAULT V_BCM1480_MC_DQI_COARSE_ADJ(0x0)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_DQI_FREQ_RANGE	    	24
+#define M_BCM1480_MC_DQI_FREQ_RANGE	    	_SB_MAKEMASK(4,S_BCM1480_MC_DQI_FREQ_RANGE)
+#define V_BCM1480_MC_DQI_FREQ_RANGE(x)     	_SB_MAKEVALUE(x,S_BCM1480_MC_DQI_FREQ_RANGE)
+#define G_BCM1480_MC_DQI_FREQ_RANGE(x)     	_SB_GETVALUE(x,S_BCM1480_MC_DQI_FREQ_RANGE,M_BCM1480_MC_DQI_FREQ_RANGE)
+#define V_BCM1480_MC_DQI_FREQ_RANGE_DEFAULT 	V_BCM1480_MC_DQI_FREQ_RANGE(0x4)
+#endif
+
+#define S_BCM1480_MC_DQI_FINE_ADJ           24
+#define M_BCM1480_MC_DQI_FINE_ADJ           _SB_MAKEMASK(4,S_BCM1480_MC_DQI_FINE_ADJ)
+#define V_BCM1480_MC_DQI_FINE_ADJ(x)        _SB_MAKEVALUE(x,S_BCM1480_MC_DQI_FINE_ADJ)
+#define G_BCM1480_MC_DQI_FINE_ADJ(x)        _SB_GETVALUE(x,S_BCM1480_MC_DQI_FINE_ADJ,M_BCM1480_MC_DQI_FINE_ADJ)
+#define V_BCM1480_MC_DQI_FINE_ADJ_DEFAULT   V_BCM1480_MC_DQI_FINE_ADJ(0x8)
+
+#define S_BCM1480_MC_DQO_COARSE_ADJ         32
+#define M_BCM1480_MC_DQO_COARSE_ADJ         _SB_MAKEMASK(6,S_BCM1480_MC_DQO_COARSE_ADJ)
+#define V_BCM1480_MC_DQO_COARSE_ADJ(x)      _SB_MAKEVALUE(x,S_BCM1480_MC_DQO_COARSE_ADJ)
+#define G_BCM1480_MC_DQO_COARSE_ADJ(x)      _SB_GETVALUE(x,S_BCM1480_MC_DQO_COARSE_ADJ,M_BCM1480_MC_DQO_COARSE_ADJ)
+#define V_BCM1480_MC_DQO_COARSE_ADJ_DEFAULT V_BCM1480_MC_DQO_COARSE_ADJ(0x0)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_DQO_FREQ_RANGE	    	40
+#define M_BCM1480_MC_DQO_FREQ_RANGE	    	_SB_MAKEMASK(4,S_BCM1480_MC_DQO_FREQ_RANGE)
+#define V_BCM1480_MC_DQO_FREQ_RANGE(x)     	_SB_MAKEVALUE(x,S_BCM1480_MC_DQO_FREQ_RANGE)
+#define G_BCM1480_MC_DQO_FREQ_RANGE(x)     	_SB_GETVALUE(x,S_BCM1480_MC_DQO_FREQ_RANGE,M_BCM1480_MC_DQO_FREQ_RANGE)
+#define V_BCM1480_MC_DQO_FREQ_RANGE_DEFAULT 	V_BCM1480_MC_DQO_FREQ_RANGE(0x4)
+#endif
+
+#define S_BCM1480_MC_DQO_FINE_ADJ           40
+#define M_BCM1480_MC_DQO_FINE_ADJ           _SB_MAKEMASK(4,S_BCM1480_MC_DQO_FINE_ADJ)
+#define V_BCM1480_MC_DQO_FINE_ADJ(x)        _SB_MAKEVALUE(x,S_BCM1480_MC_DQO_FINE_ADJ)
+#define G_BCM1480_MC_DQO_FINE_ADJ(x)        _SB_GETVALUE(x,S_BCM1480_MC_DQO_FINE_ADJ,M_BCM1480_MC_DQO_FINE_ADJ)
+#define V_BCM1480_MC_DQO_FINE_ADJ_DEFAULT   V_BCM1480_MC_DQO_FINE_ADJ(0x8)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_DLL_PDSEL            44
+#define M_BCM1480_MC_DLL_PDSEL            _SB_MAKEMASK(2,S_BCM1480_MC_DLL_PDSEL)
+#define V_BCM1480_MC_DLL_PDSEL(x)         _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_PDSEL)
+#define G_BCM1480_MC_DLL_PDSEL(x)         _SB_GETVALUE(x,S_BCM1480_MC_DLL_PDSEL,M_BCM1480_MC_DLL_PDSEL)
+#define V_BCM1480_MC_DLL_DEFAULT_PDSEL    V_BCM1480_MC_DLL_PDSEL(0x0)
+
+#define	M_BCM1480_MC_DLL_REGBYPASS        _SB_MAKEMASK1(46)
+#define	M_BCM1480_MC_DQO_SHIFT            _SB_MAKEMASK1(47)
+#endif
+
+#define S_BCM1480_MC_DLL_DEFAULT            48
+#define M_BCM1480_MC_DLL_DEFAULT            _SB_MAKEMASK(6,S_BCM1480_MC_DLL_DEFAULT)
+#define V_BCM1480_MC_DLL_DEFAULT(x)         _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_DEFAULT)
+#define G_BCM1480_MC_DLL_DEFAULT(x)         _SB_GETVALUE(x,S_BCM1480_MC_DLL_DEFAULT,M_BCM1480_MC_DLL_DEFAULT)
+#define V_BCM1480_MC_DLL_DEFAULT_DEFAULT    V_BCM1480_MC_DLL_DEFAULT(0x10)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_DLL_REGCTRL	  54
+#define M_BCM1480_MC_DLL_REGCTRL       	  _SB_MAKEMASK(2,S_BCM1480_MC_DLL_REGCTRL)
+#define V_BCM1480_MC_DLL_REGCTRL(x)       _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_REGCTRL)
+#define G_BCM1480_MC_DLL_REGCTRL(x)       _SB_GETVALUE(x,S_BCM1480_MC_DLL_REGCTRL,M_BCM1480_MC_DLL_REGCTRL)
+#define V_BCM1480_MC_DLL_DEFAULT_REGCTRL  V_BCM1480_MC_DLL_REGCTRL(0x0)
+#endif
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_DLL_FREQ_RANGE	    	56
+#define M_BCM1480_MC_DLL_FREQ_RANGE	    	_SB_MAKEMASK(4,S_BCM1480_MC_DLL_FREQ_RANGE)
+#define V_BCM1480_MC_DLL_FREQ_RANGE(x)     	_SB_MAKEVALUE(x,S_BCM1480_MC_DLL_FREQ_RANGE)
+#define G_BCM1480_MC_DLL_FREQ_RANGE(x)     	_SB_GETVALUE(x,S_BCM1480_MC_DLL_FREQ_RANGE,M_BCM1480_MC_DLL_FREQ_RANGE)
+#define V_BCM1480_MC_DLL_FREQ_RANGE_DEFAULT 	V_BCM1480_MC_DLL_FREQ_RANGE(0x4)
+#endif
+
+#define S_BCM1480_MC_DLL_STEP_SIZE          56
+#define M_BCM1480_MC_DLL_STEP_SIZE          _SB_MAKEMASK(4,S_BCM1480_MC_DLL_STEP_SIZE)
+#define V_BCM1480_MC_DLL_STEP_SIZE(x)       _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_STEP_SIZE)
+#define G_BCM1480_MC_DLL_STEP_SIZE(x)       _SB_GETVALUE(x,S_BCM1480_MC_DLL_STEP_SIZE,M_BCM1480_MC_DLL_STEP_SIZE)
+#define V_BCM1480_MC_DLL_STEP_SIZE_DEFAULT  V_BCM1480_MC_DLL_STEP_SIZE(0x8)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_DLL_BGCTRL	  60
+#define M_BCM1480_MC_DLL_BGCTRL       	  _SB_MAKEMASK(2,S_BCM1480_MC_DLL_BGCTRL)
+#define V_BCM1480_MC_DLL_BGCTRL(x)       _SB_MAKEVALUE(x,S_BCM1480_MC_DLL_BGCTRL)
+#define G_BCM1480_MC_DLL_BGCTRL(x)       _SB_GETVALUE(x,S_BCM1480_MC_DLL_BGCTRL,M_BCM1480_MC_DLL_BGCTRL)
+#define V_BCM1480_MC_DLL_DEFAULT_BGCTRL  V_BCM1480_MC_DLL_BGCTRL(0x0)
+#endif
+
+#define	M_BCM1480_MC_DLL_BYPASS		    _SB_MAKEMASK1(63)
+
+/*
+ * Memory Drive Configuration Register (Table 94)
+ */
+
+#define S_BCM1480_MC_RTT_BYP_PULLDOWN       0
+#define M_BCM1480_MC_RTT_BYP_PULLDOWN       _SB_MAKEMASK(3,S_BCM1480_MC_RTT_BYP_PULLDOWN)
+#define V_BCM1480_MC_RTT_BYP_PULLDOWN(x)    _SB_MAKEVALUE(x,S_BCM1480_MC_RTT_BYP_PULLDOWN)
+#define G_BCM1480_MC_RTT_BYP_PULLDOWN(x)    _SB_GETVALUE(x,S_BCM1480_MC_RTT_BYP_PULLDOWN,M_BCM1480_MC_RTT_BYP_PULLDOWN)
+
+#define S_BCM1480_MC_RTT_BYP_PULLUP         6
+#define M_BCM1480_MC_RTT_BYP_PULLUP         _SB_MAKEMASK(3,S_BCM1480_MC_RTT_BYP_PULLUP)
+#define V_BCM1480_MC_RTT_BYP_PULLUP(x)      _SB_MAKEVALUE(x,S_BCM1480_MC_RTT_BYP_PULLUP)
+#define G_BCM1480_MC_RTT_BYP_PULLUP(x)      _SB_GETVALUE(x,S_BCM1480_MC_RTT_BYP_PULLUP,M_BCM1480_MC_RTT_BYP_PULLUP)
+
+#define M_BCM1480_MC_RTT_BYPASS             _SB_MAKEMASK1(8)
+#define M_BCM1480_MC_RTT_COMP_MOV_AVG       _SB_MAKEMASK1(9)
+
+#define S_BCM1480_MC_PVT_BYP_C1_PULLDOWN    10
+#define M_BCM1480_MC_PVT_BYP_C1_PULLDOWN    _SB_MAKEMASK(4,S_BCM1480_MC_PVT_BYP_C1_PULLDOWN)
+#define V_BCM1480_MC_PVT_BYP_C1_PULLDOWN(x) _SB_MAKEVALUE(x,S_BCM1480_MC_PVT_BYP_C1_PULLDOWN)
+#define G_BCM1480_MC_PVT_BYP_C1_PULLDOWN(x) _SB_GETVALUE(x,S_BCM1480_MC_PVT_BYP_C1_PULLDOWN,M_BCM1480_MC_PVT_BYP_C1_PULLDOWN)
+
+#define S_BCM1480_MC_PVT_BYP_C1_PULLUP      15
+#define M_BCM1480_MC_PVT_BYP_C1_PULLUP      _SB_MAKEMASK(4,S_BCM1480_MC_PVT_BYP_C1_PULLUP)
+#define V_BCM1480_MC_PVT_BYP_C1_PULLUP(x)   _SB_MAKEVALUE(x,S_BCM1480_MC_PVT_BYP_C1_PULLUP)
+#define G_BCM1480_MC_PVT_BYP_C1_PULLUP(x)   _SB_GETVALUE(x,S_BCM1480_MC_PVT_BYP_C1_PULLUP,M_BCM1480_MC_PVT_BYP_C1_PULLUP)
+
+#define S_BCM1480_MC_PVT_BYP_C2_PULLDOWN    20
+#define M_BCM1480_MC_PVT_BYP_C2_PULLDOWN    _SB_MAKEMASK(4,S_BCM1480_MC_PVT_BYP_C2_PULLDOWN)
+#define V_BCM1480_MC_PVT_BYP_C2_PULLDOWN(x) _SB_MAKEVALUE(x,S_BCM1480_MC_PVT_BYP_C2_PULLDOWN)
+#define G_BCM1480_MC_PVT_BYP_C2_PULLDOWN(x) _SB_GETVALUE(x,S_BCM1480_MC_PVT_BYP_C2_PULLDOWN,M_BCM1480_MC_PVT_BYP_C2_PULLDOWN)
+
+#define S_BCM1480_MC_PVT_BYP_C2_PULLUP      25
+#define M_BCM1480_MC_PVT_BYP_C2_PULLUP      _SB_MAKEMASK(4,S_BCM1480_MC_PVT_BYP_C2_PULLUP)
+#define V_BCM1480_MC_PVT_BYP_C2_PULLUP(x)   _SB_MAKEVALUE(x,S_BCM1480_MC_PVT_BYP_C2_PULLUP)
+#define G_BCM1480_MC_PVT_BYP_C2_PULLUP(x)   _SB_GETVALUE(x,S_BCM1480_MC_PVT_BYP_C2_PULLUP,M_BCM1480_MC_PVT_BYP_C2_PULLUP)
+
+#define M_BCM1480_MC_PVT_BYPASS             _SB_MAKEMASK1(30)
+#define M_BCM1480_MC_PVT_COMP_MOV_AVG       _SB_MAKEMASK1(31)
+
+#define M_BCM1480_MC_CLK_CLASS              _SB_MAKEMASK1(34)
+#define M_BCM1480_MC_DATA_CLASS             _SB_MAKEMASK1(35)
+#define M_BCM1480_MC_ADDR_CLASS             _SB_MAKEMASK1(36)
+
+#define M_BCM1480_MC_DQ_ODT_75              _SB_MAKEMASK1(37)
+#define M_BCM1480_MC_DQ_ODT_150             _SB_MAKEMASK1(38)
+#define M_BCM1480_MC_DQS_ODT_75             _SB_MAKEMASK1(39)
+#define M_BCM1480_MC_DQS_ODT_150            _SB_MAKEMASK1(40)
+#define M_BCM1480_MC_DQS_DIFF               _SB_MAKEMASK1(41)
+
+/*
+ * ECC Test Data Register (Table 95)
+ */
+
+#define S_BCM1480_MC_DATA_INVERT            0
+#define M_DATA_ECC_INVERT           _SB_MAKEMASK(64,S_BCM1480_MC_ECC_INVERT)
+
+/*
+ * ECC Test ECC Register (Table 96)
+ */
+
+#define S_BCM1480_MC_ECC_INVERT             0
+#define M_BCM1480_MC_ECC_INVERT             _SB_MAKEMASK(8,S_BCM1480_MC_ECC_INVERT)
+
+/*
+ * SDRAM Timing Register  (Table 97)
+ */
+
+#define S_BCM1480_MC_tRCD                   0
+#define M_BCM1480_MC_tRCD                   _SB_MAKEMASK(4,S_BCM1480_MC_tRCD)
+#define V_BCM1480_MC_tRCD(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRCD)
+#define G_BCM1480_MC_tRCD(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRCD,M_BCM1480_MC_tRCD)
+#define K_BCM1480_MC_tRCD_DEFAULT           3
+#define V_BCM1480_MC_tRCD_DEFAULT           V_BCM1480_MC_tRCD(K_BCM1480_MC_tRCD_DEFAULT)
+
+#define S_BCM1480_MC_tCL                    4
+#define M_BCM1480_MC_tCL                    _SB_MAKEMASK(4,S_BCM1480_MC_tCL)
+#define V_BCM1480_MC_tCL(x)                 _SB_MAKEVALUE(x,S_BCM1480_MC_tCL)
+#define G_BCM1480_MC_tCL(x)                 _SB_GETVALUE(x,S_BCM1480_MC_tCL,M_BCM1480_MC_tCL)
+#define K_BCM1480_MC_tCL_DEFAULT            2
+#define V_BCM1480_MC_tCL_DEFAULT            V_BCM1480_MC_tCL(K_BCM1480_MC_tCL_DEFAULT)
+
+#define M_BCM1480_MC_tCrDh                  _SB_MAKEMASK1(8)
+
+#define S_BCM1480_MC_tWR                    9
+#define M_BCM1480_MC_tWR                    _SB_MAKEMASK(3,S_BCM1480_MC_tWR)
+#define V_BCM1480_MC_tWR(x)                 _SB_MAKEVALUE(x,S_BCM1480_MC_tWR)
+#define G_BCM1480_MC_tWR(x)                 _SB_GETVALUE(x,S_BCM1480_MC_tWR,M_BCM1480_MC_tWR)
+#define K_BCM1480_MC_tWR_DEFAULT            2
+#define V_BCM1480_MC_tWR_DEFAULT            V_BCM1480_MC_tWR(K_BCM1480_MC_tWR_DEFAULT)
+
+#define S_BCM1480_MC_tCwD                   12
+#define M_BCM1480_MC_tCwD                   _SB_MAKEMASK(4,S_BCM1480_MC_tCwD)
+#define V_BCM1480_MC_tCwD(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tCwD)
+#define G_BCM1480_MC_tCwD(x)                _SB_GETVALUE(x,S_BCM1480_MC_tCwD,M_BCM1480_MC_tCwD)
+#define K_BCM1480_MC_tCwD_DEFAULT           1
+#define V_BCM1480_MC_tCwD_DEFAULT           V_BCM1480_MC_tCwD(K_BCM1480_MC_tCwD_DEFAULT)
+
+#define S_BCM1480_MC_tRP                    16
+#define M_BCM1480_MC_tRP                    _SB_MAKEMASK(4,S_BCM1480_MC_tRP)
+#define V_BCM1480_MC_tRP(x)                 _SB_MAKEVALUE(x,S_BCM1480_MC_tRP)
+#define G_BCM1480_MC_tRP(x)                 _SB_GETVALUE(x,S_BCM1480_MC_tRP,M_BCM1480_MC_tRP)
+#define K_BCM1480_MC_tRP_DEFAULT            4
+#define V_BCM1480_MC_tRP_DEFAULT            V_BCM1480_MC_tRP(K_BCM1480_MC_tRP_DEFAULT)
+
+#define S_BCM1480_MC_tRRD                   20
+#define M_BCM1480_MC_tRRD                   _SB_MAKEMASK(4,S_BCM1480_MC_tRRD)
+#define V_BCM1480_MC_tRRD(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRRD)
+#define G_BCM1480_MC_tRRD(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRRD,M_BCM1480_MC_tRRD)
+#define K_BCM1480_MC_tRRD_DEFAULT           2
+#define V_BCM1480_MC_tRRD_DEFAULT           V_BCM1480_MC_tRRD(K_BCM1480_MC_tRRD_DEFAULT)
+
+#define S_BCM1480_MC_tRCw                   24
+#define M_BCM1480_MC_tRCw                   _SB_MAKEMASK(5,S_BCM1480_MC_tRCw)
+#define V_BCM1480_MC_tRCw(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRCw)
+#define G_BCM1480_MC_tRCw(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRCw,M_BCM1480_MC_tRCw)
+#define K_BCM1480_MC_tRCw_DEFAULT           10
+#define V_BCM1480_MC_tRCw_DEFAULT           V_BCM1480_MC_tRCw(K_BCM1480_MC_tRCw_DEFAULT)
+
+#define S_BCM1480_MC_tRCr                   32
+#define M_BCM1480_MC_tRCr                   _SB_MAKEMASK(5,S_BCM1480_MC_tRCr)
+#define V_BCM1480_MC_tRCr(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRCr)
+#define G_BCM1480_MC_tRCr(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRCr,M_BCM1480_MC_tRCr)
+#define K_BCM1480_MC_tRCr_DEFAULT           9
+#define V_BCM1480_MC_tRCr_DEFAULT           V_BCM1480_MC_tRCr(K_BCM1480_MC_tRCr_DEFAULT)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define S_BCM1480_MC_tFAW                   40
+#define M_BCM1480_MC_tFAW                   _SB_MAKEMASK(6,S_BCM1480_MC_tFAW)
+#define V_BCM1480_MC_tFAW(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tFAW)
+#define G_BCM1480_MC_tFAW(x)                _SB_GETVALUE(x,S_BCM1480_MC_tFAW,M_BCM1480_MC_tFAW)
+#define K_BCM1480_MC_tFAW_DEFAULT           0
+#define V_BCM1480_MC_tFAW_DEFAULT           V_BCM1480_MC_tFAW(K_BCM1480_MC_tFAW_DEFAULT)
+#endif
+
+#define S_BCM1480_MC_tRFC                   48
+#define M_BCM1480_MC_tRFC                   _SB_MAKEMASK(7,S_BCM1480_MC_tRFC)
+#define V_BCM1480_MC_tRFC(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRFC)
+#define G_BCM1480_MC_tRFC(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRFC,M_BCM1480_MC_tRFC)
+#define K_BCM1480_MC_tRFC_DEFAULT           12
+#define V_BCM1480_MC_tRFC_DEFAULT           V_BCM1480_MC_tRFC(K_BCM1480_MC_tRFC_DEFAULT)
+
+#define S_BCM1480_MC_tFIFO                  56
+#define M_BCM1480_MC_tFIFO                  _SB_MAKEMASK(2,S_BCM1480_MC_tFIFO)
+#define V_BCM1480_MC_tFIFO(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_tFIFO)
+#define G_BCM1480_MC_tFIFO(x)               _SB_GETVALUE(x,S_BCM1480_MC_tFIFO,M_BCM1480_MC_tFIFO)
+#define K_BCM1480_MC_tFIFO_DEFAULT          0
+#define V_BCM1480_MC_tFIFO_DEFAULT          V_BCM1480_MC_tFIFO(K_BCM1480_MC_tFIFO_DEFAULT)
+
+#define S_BCM1480_MC_tW2R                  58
+#define M_BCM1480_MC_tW2R                  _SB_MAKEMASK(2,S_BCM1480_MC_tW2R)
+#define V_BCM1480_MC_tW2R(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_tW2R)
+#define G_BCM1480_MC_tW2R(x)               _SB_GETVALUE(x,S_BCM1480_MC_tW2R,M_BCM1480_MC_tW2R)
+#define K_BCM1480_MC_tW2R_DEFAULT          1
+#define V_BCM1480_MC_tW2R_DEFAULT          V_BCM1480_MC_tW2R(K_BCM1480_MC_tW2R_DEFAULT)
+
+#define S_BCM1480_MC_tR2W                  60
+#define M_BCM1480_MC_tR2W                  _SB_MAKEMASK(2,S_BCM1480_MC_tR2W)
+#define V_BCM1480_MC_tR2W(x)               _SB_MAKEVALUE(x,S_BCM1480_MC_tR2W)
+#define G_BCM1480_MC_tR2W(x)               _SB_GETVALUE(x,S_BCM1480_MC_tR2W,M_BCM1480_MC_tR2W)
+#define K_BCM1480_MC_tR2W_DEFAULT          0
+#define V_BCM1480_MC_tR2W_DEFAULT          V_BCM1480_MC_tR2W(K_BCM1480_MC_tR2W_DEFAULT)
+
+#define M_BCM1480_MC_tR2R		    _SB_MAKEMASK1(62)
+
+#define V_BCM1480_MC_TIMING_DEFAULT         (M_BCM1480_MC_tR2R | \
+                                     V_BCM1480_MC_tFIFO_DEFAULT | \
+                                     V_BCM1480_MC_tR2W_DEFAULT | \
+                                     V_BCM1480_MC_tW2R_DEFAULT | \
+                                     V_BCM1480_MC_tRFC_DEFAULT | \
+                                     V_BCM1480_MC_tRCr_DEFAULT | \
+                                     V_BCM1480_MC_tRCw_DEFAULT | \
+                                     V_BCM1480_MC_tRRD_DEFAULT | \
+                                     V_BCM1480_MC_tRP_DEFAULT | \
+                                     V_BCM1480_MC_tCwD_DEFAULT | \
+                                     V_BCM1480_MC_tWR_DEFAULT | \
+                                     M_BCM1480_MC_tCrDh | \
+                                     V_BCM1480_MC_tCL_DEFAULT | \
+                                     V_BCM1480_MC_tRCD_DEFAULT)
+
+/*
+ * SDRAM Timing Register 2
+ */
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+
+#define S_BCM1480_MC_tAL                   0
+#define M_BCM1480_MC_tAL                   _SB_MAKEMASK(4,S_BCM1480_MC_tAL)
+#define V_BCM1480_MC_tAL(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tAL)
+#define G_BCM1480_MC_tAL(x)                _SB_GETVALUE(x,S_BCM1480_MC_tAL,M_BCM1480_MC_tAL)
+#define K_BCM1480_MC_tAL_DEFAULT           0
+#define V_BCM1480_MC_tAL_DEFAULT           V_BCM1480_MC_tAL(K_BCM1480_MC_tAL_DEFAULT)
+
+#define S_BCM1480_MC_tRTP                   4
+#define M_BCM1480_MC_tRTP                   _SB_MAKEMASK(3,S_BCM1480_MC_tRTP)
+#define V_BCM1480_MC_tRTP(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRTP)
+#define G_BCM1480_MC_tRTP(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRTP,M_BCM1480_MC_tRTP)
+#define K_BCM1480_MC_tRTP_DEFAULT           2
+#define V_BCM1480_MC_tRTP_DEFAULT           V_BCM1480_MC_tRTP(K_BCM1480_MC_tRTP_DEFAULT)
+
+#define S_BCM1480_MC_tW2W                   8
+#define M_BCM1480_MC_tW2W                   _SB_MAKEMASK(2,S_BCM1480_MC_tW2W)
+#define V_BCM1480_MC_tW2W(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tW2W)
+#define G_BCM1480_MC_tW2W(x)                _SB_GETVALUE(x,S_BCM1480_MC_tW2W,M_BCM1480_MC_tW2W)
+#define K_BCM1480_MC_tW2W_DEFAULT           0
+#define V_BCM1480_MC_tW2W_DEFAULT           V_BCM1480_MC_tW2W(K_BCM1480_MC_tW2W_DEFAULT)
+
+#define S_BCM1480_MC_tRAP                   12
+#define M_BCM1480_MC_tRAP                  _SB_MAKEMASK(4,S_BCM1480_MC_tRAP)
+#define V_BCM1480_MC_tRAP(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_tRAP)
+#define G_BCM1480_MC_tRAP(x)                _SB_GETVALUE(x,S_BCM1480_MC_tRAP,M_BCM1480_MC_tRAP)
+#define K_BCM1480_MC_tRAP_DEFAULT           0
+#define V_BCM1480_MC_tRAP_DEFAULT           V_BCM1480_MC_tRAP(K_BCM1480_MC_tRAP_DEFAULT)
+
+#endif
+
+
+
+/*
+ * Global Registers: single instances per BCM1480
+ */
+
+/*
+ * Global Configuration Register (Table 99)
+ */
+
+#define S_BCM1480_MC_BLK_SET_MARK           8
+#define M_BCM1480_MC_BLK_SET_MARK           _SB_MAKEMASK(4,S_BCM1480_MC_BLK_SET_MARK)
+#define V_BCM1480_MC_BLK_SET_MARK(x)        _SB_MAKEVALUE(x,S_BCM1480_MC_BLK_SET_MARK)
+#define G_BCM1480_MC_BLK_SET_MARK(x)        _SB_GETVALUE(x,S_BCM1480_MC_BLK_SET_MARK,M_BCM1480_MC_BLK_SET_MARK)
+
+#define S_BCM1480_MC_BLK_CLR_MARK           12
+#define M_BCM1480_MC_BLK_CLR_MARK           _SB_MAKEMASK(4,S_BCM1480_MC_BLK_CLR_MARK)
+#define V_BCM1480_MC_BLK_CLR_MARK(x)        _SB_MAKEVALUE(x,S_BCM1480_MC_BLK_CLR_MARK)
+#define G_BCM1480_MC_BLK_CLR_MARK(x)        _SB_GETVALUE(x,S_BCM1480_MC_BLK_CLR_MARK,M_BCM1480_MC_BLK_CLR_MARK)
+
+#define M_BCM1480_MC_PKT_PRIORITY           _SB_MAKEMASK1(16)
+
+#define S_BCM1480_MC_MAX_AGE                20
+#define M_BCM1480_MC_MAX_AGE                _SB_MAKEMASK(4,S_BCM1480_MC_MAX_AGE)
+#define V_BCM1480_MC_MAX_AGE(x)             _SB_MAKEVALUE(x,S_BCM1480_MC_MAX_AGE)
+#define G_BCM1480_MC_MAX_AGE(x)             _SB_GETVALUE(x,S_BCM1480_MC_MAX_AGE,M_BCM1480_MC_MAX_AGE)
+
+#define M_BCM1480_MC_BERR_DISABLE           _SB_MAKEMASK1(29)
+#define M_BCM1480_MC_FORCE_SEQ              _SB_MAKEMASK1(30)
+#define M_BCM1480_MC_VGEN                   _SB_MAKEMASK1(32)
+
+#define S_BCM1480_MC_SLEW                   33
+#define M_BCM1480_MC_SLEW                   _SB_MAKEMASK(2,S_BCM1480_MC_SLEW)
+#define V_BCM1480_MC_SLEW(x)                _SB_MAKEVALUE(x,S_BCM1480_MC_SLEW)
+#define G_BCM1480_MC_SLEW(x)                _SB_GETVALUE(x,S_BCM1480_MC_SLEW,M_BCM1480_MC_SLEW)
+
+#define M_BCM1480_MC_SSTL_VOLTAGE           _SB_MAKEMASK1(35)
+
+/*
+ * Global Channel Interleave Register (Table 100)
+ */
+
+#define S_BCM1480_MC_INTLV0                 0
+#define M_BCM1480_MC_INTLV0                 _SB_MAKEMASK(6,S_BCM1480_MC_INTLV0)
+#define V_BCM1480_MC_INTLV0(x)              _SB_MAKEVALUE(x,S_BCM1480_MC_INTLV0)
+#define G_BCM1480_MC_INTLV0(x)              _SB_GETVALUE(x,S_BCM1480_MC_INTLV0,M_BCM1480_MC_INTLV0)
+
+#define S_BCM1480_MC_INTLV1                 8
+#define M_BCM1480_MC_INTLV1                 _SB_MAKEMASK(6,S_BCM1480_MC_INTLV1)
+#define V_BCM1480_MC_INTLV1(x)              _SB_MAKEVALUE(x,S_BCM1480_MC_INTLV1)
+#define G_BCM1480_MC_INTLV1(x)              _SB_GETVALUE(x,S_BCM1480_MC_INTLV1,M_BCM1480_MC_INTLV1)
+
+#define S_BCM1480_MC_INTLV_MODE             16
+#define M_BCM1480_MC_INTLV_MODE             _SB_MAKEMASK(3,S_BCM1480_MC_INTLV_MODE)
+#define V_BCM1480_MC_INTLV_MODE(x)          _SB_MAKEVALUE(x,S_BCM1480_MC_INTLV_MODE)
+#define G_BCM1480_MC_INTLV_MODE(x)          _SB_GETVALUE(x,S_BCM1480_MC_INTLV_MODE,M_BCM1480_MC_INTLV_MODE)
+
+#define K_BCM1480_MC_INTLV_MODE_NONE        0x0
+#define K_BCM1480_MC_INTLV_MODE_01          0x1
+#define K_BCM1480_MC_INTLV_MODE_23          0x2
+#define K_BCM1480_MC_INTLV_MODE_01_23       0x3
+#define K_BCM1480_MC_INTLV_MODE_0123        0x4
+
+#define V_BCM1480_MC_INTLV_MODE_NONE        V_BCM1480_MC_INTLV_MODE(K_BCM1480_MC_INTLV_MODE_NONE)
+#define V_BCM1480_MC_INTLV_MODE_01          V_BCM1480_MC_INTLV_MODE(K_BCM1480_MC_INTLV_MODE_01)
+#define V_BCM1480_MC_INTLV_MODE_23          V_BCM1480_MC_INTLV_MODE(K_BCM1480_MC_INTLV_MODE_23)
+#define V_BCM1480_MC_INTLV_MODE_01_23       V_BCM1480_MC_INTLV_MODE(K_BCM1480_MC_INTLV_MODE_01_23)
+#define V_BCM1480_MC_INTLV_MODE_0123        V_BCM1480_MC_INTLV_MODE(K_BCM1480_MC_INTLV_MODE_0123)
+
+/*
+ * ECC Status Register
+ */
+
+#define S_BCM1480_MC_ECC_ERR_ADDR           0
+#define M_BCM1480_MC_ECC_ERR_ADDR           _SB_MAKEMASK(37,S_BCM1480_MC_ECC_ERR_ADDR)
+#define V_BCM1480_MC_ECC_ERR_ADDR(x)        _SB_MAKEVALUE(x,S_BCM1480_MC_ECC_ERR_ADDR)
+#define G_BCM1480_MC_ECC_ERR_ADDR(x)        _SB_GETVALUE(x,S_BCM1480_MC_ECC_ERR_ADDR,M_BCM1480_MC_ECC_ERR_ADDR)
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define M_BCM1480_MC_ECC_ERR_RMW            _SB_MAKEMASK1(60)
+#endif
+
+#define M_BCM1480_MC_ECC_MULT_ERR_DET       _SB_MAKEMASK1(61)
+#define M_BCM1480_MC_ECC_UERR_DET           _SB_MAKEMASK1(62)
+#define M_BCM1480_MC_ECC_CERR_DET           _SB_MAKEMASK1(63)
+
+/*
+ * Global ECC Address Register (Table 102)
+ */
+
+#define S_BCM1480_MC_ECC_CORR_ADDR          0
+#define M_BCM1480_MC_ECC_CORR_ADDR          _SB_MAKEMASK(37,S_BCM1480_MC_ECC_CORR_ADDR)
+#define V_BCM1480_MC_ECC_CORR_ADDR(x)       _SB_MAKEVALUE(x,S_BCM1480_MC_ECC_CORR_ADDR)
+#define G_BCM1480_MC_ECC_CORR_ADDR(x)       _SB_GETVALUE(x,S_BCM1480_MC_ECC_CORR_ADDR,M_BCM1480_MC_ECC_CORR_ADDR)
+
+/*
+ * Global ECC Correction Register (Table 103)
+ */
+
+#define S_BCM1480_MC_ECC_CORRECT            0
+#define M_BCM1480_MC_ECC_CORRECT            _SB_MAKEMASK(64,S_BCM1480_MC_ECC_CORRECT)
+#define V_BCM1480_MC_ECC_CORRECT(x)         _SB_MAKEVALUE(x,S_BCM1480_MC_ECC_CORRECT)
+#define G_BCM1480_MC_ECC_CORRECT(x)         _SB_GETVALUE(x,S_BCM1480_MC_ECC_CORRECT,M_BCM1480_MC_ECC_CORRECT)
+
+/*
+ * Global ECC Performance Counters Control Register (Table 104)
+ */
+
+#define S_BCM1480_MC_CHANNEL_SELECT         0
+#define M_BCM1480_MC_CHANNEL_SELECT         _SB_MAKEMASK(4,S_BCM1480_MC_CHANNEL_SELECT)
+#define V_BCM1480_MC_CHANNEL_SELECT(x)      _SB_MAKEVALUE(x,S_BCM1480_MC_CHANNEL_SELECT)
+#define G_BCM1480_MC_CHANNEL_SELECT(x)      _SB_GETVALUE(x,S_BCM1480_MC_CHANNEL_SELECT,M_BCM1480_MC_CHANNEL_SELECT)
+#define K_BCM1480_MC_CHANNEL_SELECT_0       0x1
+#define K_BCM1480_MC_CHANNEL_SELECT_1       0x2
+#define K_BCM1480_MC_CHANNEL_SELECT_2       0x4
+#define K_BCM1480_MC_CHANNEL_SELECT_3       0x8
+
+#endif /* _BCM1480_MC_H */
Index: lmo/include/asm-mips/sibyte/bcm1480_regs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/include/asm-mips/sibyte/bcm1480_regs.h	2005-10-19 22:34:11.000000000 -0700
@@ -0,0 +1,869 @@
+/*  *********************************************************************
+    *  BCM1255/BCM1280/BCM1455/BCM1480 Board Support Package
+    *
+    *  Register Definitions                     File: bcm1480_regs.h
+    *
+    *  This module contains the addresses of the on-chip peripherals
+    *  on the BCM1280 and BCM1480.
+    *
+    *  BCM1480 specification level:  1X55_1X80-UM100-D4 (11/24/03)
+    *
+    *********************************************************************
+    *
+    *  Copyright 2000,2001,2002,2003
+    *  Broadcom Corporation. All rights reserved.
+    *
+    *  This program is free software; you can redistribute it and/or
+    *  modify it under the terms of the GNU General Public License as
+    *  published by the Free Software Foundation; either version 2 of
+    *  the License, or (at your option) any later version.
+    *
+    *  This program is distributed in the hope that it will be useful,
+    *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+    *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    *  GNU General Public License for more details.
+    *
+    *  You should have received a copy of the GNU General Public License
+    *  along with this program; if not, write to the Free Software
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  MA 02111-1307 USA
+    ********************************************************************* */
+
+#ifndef _BCM1480_REGS_H
+#define _BCM1480_REGS_H
+
+#include "sb1250_defs.h"
+
+/*  *********************************************************************
+    *  Pull in the BCM1250's registers since a great deal of the 1480's
+    *  functions are the same as the BCM1250.
+    ********************************************************************* */
+
+#include "sb1250_regs.h"
+
+
+/*  *********************************************************************
+    *  Some general notes:
+    *
+    *  Register addresses are grouped by function and follow the order
+    *  of the User Manual.
+    *
+    *  For the most part, when there is more than one peripheral
+    *  of the same type on the SOC, the constants below will be
+    *  offsets from the base of each peripheral.  For example,
+    *  the MAC registers are described as offsets from the first
+    *  MAC register, and there will be a MAC_REGISTER() macro
+    *  to calculate the base address of a given MAC.
+    *
+    *  The information in this file is based on the BCM1X55/BCM1X80
+    *  User Manual, Document 1X55_1X80-UM100-R, 22/12/03.
+    *
+    *  This file is basically a "what's new" header file.  Since the
+    *  BCM1250 and the new BCM1480 (and derivatives) share many common
+    *  features, this file contains only what's new or changed from
+    *  the 1250.  (above, you can see that we include the 1250 symbols
+    *  to get the base functionality).
+    *
+    *  In software, be sure to use the correct symbols, particularly
+    *  for blocks that are different between the two chip families.
+    *  All BCM1480-specific symbols have _BCM1480_ in their names,
+    *  and all BCM1250-specific and "base" functions that are common in
+    *  both chips have no special names (this is for compatibility with
+    *  older include files).  Therefore, if you're working with the
+    *  SCD, which is very different on each chip, A_SCD_xxx implies
+    *  the BCM1250 version and A_BCM1480_SCD_xxx implies the BCM1480
+    *  version.
+    ********************************************************************* */
+
+
+/*  *********************************************************************
+    * Memory Controller Registers (Section 6)
+    ********************************************************************* */
+
+#define A_BCM1480_MC_BASE_0                 0x0010050000
+#define A_BCM1480_MC_BASE_1                 0x0010051000
+#define A_BCM1480_MC_BASE_2                 0x0010052000
+#define A_BCM1480_MC_BASE_3                 0x0010053000
+#define BCM1480_MC_REGISTER_SPACING         0x1000
+
+#define A_BCM1480_MC_BASE(ctlid)            (A_BCM1480_MC_BASE_0+(ctlid)*BCM1480_MC_REGISTER_SPACING)
+#define A_BCM1480_MC_REGISTER(ctlid,reg)    (A_BCM1480_MC_BASE(ctlid)+(reg))
+
+#define R_BCM1480_MC_CONFIG                 0x0000000100
+#define R_BCM1480_MC_CS_START               0x0000000120
+#define R_BCM1480_MC_CS_END                 0x0000000140
+#define S_BCM1480_MC_CS_STARTEND            24
+
+#define R_BCM1480_MC_CS01_ROW0              0x0000000180
+#define R_BCM1480_MC_CS01_ROW1              0x00000001A0
+#define R_BCM1480_MC_CS23_ROW0              0x0000000200
+#define R_BCM1480_MC_CS23_ROW1              0x0000000220
+#define R_BCM1480_MC_CS01_COL0              0x0000000280
+#define R_BCM1480_MC_CS01_COL1              0x00000002A0
+#define R_BCM1480_MC_CS23_COL0              0x0000000300
+#define R_BCM1480_MC_CS23_COL1              0x0000000320
+
+#define R_BCM1480_MC_CSX_BASE               0x0000000180
+#define R_BCM1480_MC_CSX_ROW0               0x0000000000   /* relative to CSX_BASE */
+#define R_BCM1480_MC_CSX_ROW1               0x0000000020   /* relative to CSX_BASE */
+#define R_BCM1480_MC_CSX_COL0               0x0000000100   /* relative to CSX_BASE */
+#define R_BCM1480_MC_CSX_COL1               0x0000000120   /* relative to CSX_BASE */
+#define BCM1480_MC_CSX_SPACING              0x0000000080   /* CS23 relative to CS01 */
+
+#define R_BCM1480_MC_CS01_BA                0x0000000380
+#define R_BCM1480_MC_CS23_BA                0x00000003A0
+#define R_BCM1480_MC_DRAMCMD                0x0000000400
+#define R_BCM1480_MC_DRAMMODE               0x0000000420
+#define R_BCM1480_MC_CLOCK_CFG              0x0000000440
+#define R_BCM1480_MC_MCLK_CFG               R_BCM1480_MC_CLOCK_CFG
+#define R_BCM1480_MC_TEST_DATA              0x0000000480
+#define R_BCM1480_MC_TEST_ECC               0x00000004A0
+#define R_BCM1480_MC_TIMING1                0x00000004C0
+#define R_BCM1480_MC_TIMING2                0x00000004E0
+#define R_BCM1480_MC_DLL_CFG                0x0000000500
+#define R_BCM1480_MC_DRIVE_CFG              0x0000000520
+
+#if SIBYTE_HDR_FEATURE(1480, PASS2)
+#define R_BCM1480_MC_ODT		    0x0000000460
+#define R_BCM1480_MC_ECC_STATUS		    0x0000000540
+#endif
+
+/* Global registers (single instance) */
+#define A_BCM1480_MC_GLB_CONFIG             0x0010054100
+#define A_BCM1480_MC_GLB_INTLV              0x0010054120
+#define A_BCM1480_MC_GLB_ECC_STATUS         0x0010054140
+#define A_BCM1480_MC_GLB_ECC_ADDR           0x0010054160
+#define A_BCM1480_MC_GLB_ECC_CORRECT        0x0010054180
+#define A_BCM1480_MC_GLB_PERF_CNT_CONTROL   0x00100541A0
+
+/*  *********************************************************************
+    * L2 Cache Control Registers (Section 5)
+    ********************************************************************* */
+
+#define A_BCM1480_L2_BASE                   0x0010040000
+
+#define A_BCM1480_L2_READ_TAG               0x0010040018
+#define A_BCM1480_L2_ECC_TAG                0x0010040038
+#define A_BCM1480_L2_MISC0_VALUE            0x0010040058
+#define A_BCM1480_L2_MISC1_VALUE            0x0010040078
+#define A_BCM1480_L2_MISC2_VALUE            0x0010040098
+#define A_BCM1480_L2_MISC_CONFIG            0x0010040040	/* x040 */
+#define A_BCM1480_L2_CACHE_DISABLE          0x0010040060	/* x060 */
+#define A_BCM1480_L2_MAKECACHEDISABLE(x)    (A_BCM1480_L2_CACHE_DISABLE | (((x)&0xF) << 12))
+#define A_BCM1480_L2_WAY_ENABLE_3_0         0x0010040080	/* x080 */
+#define A_BCM1480_L2_WAY_ENABLE_7_4         0x00100400A0	/* x0A0 */
+#define A_BCM1480_L2_MAKE_WAY_ENABLE_LO(x)  (A_BCM1480_L2_WAY_ENABLE_3_0 | (((x)&0xF) << 12))
+#define A_BCM1480_L2_MAKE_WAY_ENABLE_HI(x)  (A_BCM1480_L2_WAY_ENABLE_7_4 | (((x)&0xF) << 12))
+#define A_BCM1480_L2_MAKE_WAY_DISABLE_LO(x)  (A_BCM1480_L2_WAY_ENABLE_3_0 | (((~x)&0xF) << 12))
+#define A_BCM1480_L2_MAKE_WAY_DISABLE_HI(x)  (A_BCM1480_L2_WAY_ENABLE_7_4 | (((~x)&0xF) << 12))
+#define A_BCM1480_L2_WAY_LOCAL_3_0          0x0010040100	/* x100 */
+#define A_BCM1480_L2_WAY_LOCAL_7_4          0x0010040120	/* x120 */
+#define A_BCM1480_L2_WAY_REMOTE_3_0         0x0010040140	/* x140 */
+#define A_BCM1480_L2_WAY_REMOTE_7_4         0x0010040160	/* x160 */
+#define A_BCM1480_L2_WAY_AGENT_3_0          0x00100400C0	/* xxC0 */
+#define A_BCM1480_L2_WAY_AGENT_7_4          0x00100400E0	/* xxE0 */
+#define A_BCM1480_L2_WAY_ENABLE(A, banks)   (A | (((~(banks))&0x0F) << 8))
+#define A_BCM1480_L2_BANK_BASE              0x00D0300000
+#define A_BCM1480_L2_BANK_ADDRESS(b)        (A_BCM1480_L2_BANK_BASE | (((b)&0x7)<<17))
+#define A_BCM1480_L2_MGMT_TAG_BASE          0x00D0000000
+
+
+/*  *********************************************************************
+    * PCI-X Interface Registers (Section 7)
+    ********************************************************************* */
+
+#define A_BCM1480_PCI_BASE                  0x0010061400
+
+#define A_BCM1480_PCI_RESET                 0x0010061400
+#define A_BCM1480_PCI_DLL                   0x0010061500
+
+#define A_BCM1480_PCI_TYPE00_HEADER         0x002E000000
+
+/*  *********************************************************************
+    * Ethernet MAC Registers (Section 11) and DMA Registers (Section 10.6)
+    ********************************************************************* */
+
+/* No register changes with Rev.C BCM1250, but one additional MAC */
+
+#define A_BCM1480_MAC_BASE_2        0x0010066000
+
+#ifndef A_MAC_BASE_2
+#define A_MAC_BASE_2                A_BCM1480_MAC_BASE_2
+#endif
+
+#define A_BCM1480_MAC_BASE_3        0x0010067000
+#define A_MAC_BASE_3                A_BCM1480_MAC_BASE_3
+
+#define R_BCM1480_MAC_DMA_OODPKTLOST        0x00000038
+
+#ifndef R_MAC_DMA_OODPKTLOST
+#define R_MAC_DMA_OODPKTLOST        R_BCM1480_MAC_DMA_OODPKTLOST
+#endif
+
+
+/*  *********************************************************************
+    * DUART Registers (Section 14)
+    ********************************************************************* */
+
+/* No significant differences from BCM1250, two DUARTs */
+
+/*  Conventions, per user manual:
+ *     DUART    generic, channels A,B,C,D
+ *     DUART0   implementing channels A,B
+ *     DUART1   inplementing channels C,D
+ */
+
+#define BCM1480_DUART_NUM_PORTS           4
+
+#define A_BCM1480_DUART0                    0x0010060000
+#define A_BCM1480_DUART1                    0x0010060400
+#define A_BCM1480_DUART(chan)               ((((chan)&2) == 0)? A_BCM1480_DUART0 : A_BCM1480_DUART1)
+
+#define BCM1480_DUART_CHANREG_SPACING       0x100
+#define A_BCM1480_DUART_CHANREG(chan,reg)   (A_BCM1480_DUART(chan) \
+                                     + BCM1480_DUART_CHANREG_SPACING*((chan)&1) \
+                                     + (reg))
+#define R_BCM1480_DUART_CHANREG(chan,reg)   (BCM1480_DUART_CHANREG_SPACING*((chan)&1) + (reg))
+
+#define R_BCM1480_DUART_IMRREG(chan)	    (R_DUART_IMR_A + ((chan)&1)*DUART_IMRISR_SPACING)
+#define R_BCM1480_DUART_ISRREG(chan)	    (R_DUART_ISR_A + ((chan)&1)*DUART_IMRISR_SPACING)
+
+#define A_BCM1480_DUART_IMRREG(chan)	    (A_BCM1480_DUART(chan) + R_BCM1480_DUART_IMRREG(chan))
+#define A_BCM1480_DUART_ISRREG(chan)	    (A_BCM1480_DUART(chan) + R_BCM1480_DUART_ISRREG(chan))
+
+/*
+ * These constants are the absolute addresses.
+ */
+
+#define A_BCM1480_DUART_MODE_REG_1_C        0x0010060400
+#define A_BCM1480_DUART_MODE_REG_2_C        0x0010060410
+#define A_BCM1480_DUART_STATUS_C            0x0010060420
+#define A_BCM1480_DUART_CLK_SEL_C           0x0010060430
+#define A_BCM1480_DUART_FULL_CTL_C          0x0010060440
+#define A_BCM1480_DUART_CMD_C               0x0010060450
+#define A_BCM1480_DUART_RX_HOLD_C           0x0010060460
+#define A_BCM1480_DUART_TX_HOLD_C           0x0010060470
+#define A_BCM1480_DUART_OPCR_C              0x0010060480
+#define A_BCM1480_DUART_AUX_CTRL_C          0x0010060490
+
+#define A_BCM1480_DUART_MODE_REG_1_D        0x0010060500
+#define A_BCM1480_DUART_MODE_REG_2_D        0x0010060510
+#define A_BCM1480_DUART_STATUS_D            0x0010060520
+#define A_BCM1480_DUART_CLK_SEL_D           0x0010060530
+#define A_BCM1480_DUART_FULL_CTL_D          0x0010060540
+#define A_BCM1480_DUART_CMD_D               0x0010060550
+#define A_BCM1480_DUART_RX_HOLD_D           0x0010060560
+#define A_BCM1480_DUART_TX_HOLD_D           0x0010060570
+#define A_BCM1480_DUART_OPCR_D              0x0010060580
+#define A_BCM1480_DUART_AUX_CTRL_D          0x0010060590
+
+#define A_BCM1480_DUART_INPORT_CHNG_CD      0x0010060600
+#define A_BCM1480_DUART_AUX_CTRL_CD         0x0010060610
+#define A_BCM1480_DUART_ISR_C               0x0010060620
+#define A_BCM1480_DUART_IMR_C               0x0010060630
+#define A_BCM1480_DUART_ISR_D               0x0010060640
+#define A_BCM1480_DUART_IMR_D               0x0010060650
+#define A_BCM1480_DUART_OUT_PORT_CD         0x0010060660
+#define A_BCM1480_DUART_OPCR_CD             0x0010060670
+#define A_BCM1480_DUART_IN_PORT_CD          0x0010060680
+#define A_BCM1480_DUART_ISR_CD              0x0010060690
+#define A_BCM1480_DUART_IMR_CD              0x00100606A0
+#define A_BCM1480_DUART_SET_OPR_CD          0x00100606B0
+#define A_BCM1480_DUART_CLEAR_OPR_CD        0x00100606C0
+#define A_BCM1480_DUART_INPORT_CHNG_C       0x00100606D0
+#define A_BCM1480_DUART_INPORT_CHNG_D       0x00100606E0
+
+
+/*  *********************************************************************
+    * Generic Bus Registers (Section 15) and PCMCIA Registers (Section 16)
+    ********************************************************************* */
+
+#define A_BCM1480_IO_PCMCIA_CFG_B	0x0010061A58
+#define A_BCM1480_IO_PCMCIA_STATUS_B	0x0010061A68
+
+/*  *********************************************************************
+    * GPIO Registers (Section 17)
+    ********************************************************************* */
+
+/* One additional GPIO register, placed _before_ the BCM1250's GPIO block base */
+
+#define A_BCM1480_GPIO_INT_ADD_TYPE         0x0010061A78
+#define R_BCM1480_GPIO_INT_ADD_TYPE         (-8)
+
+#define A_GPIO_INT_ADD_TYPE	A_BCM1480_GPIO_INT_ADD_TYPE
+#define R_GPIO_INT_ADD_TYPE	R_BCM1480_GPIO_INT_ADD_TYPE
+
+/*  *********************************************************************
+    * SMBus Registers (Section 18)
+    ********************************************************************* */
+
+/* No changes from BCM1250 */
+
+/*  *********************************************************************
+    * Timer Registers (Sections 4.6)
+    ********************************************************************* */
+
+/* BCM1480 has two additional watchdogs */
+
+/* Watchdog timers */
+
+#define A_BCM1480_SCD_WDOG_2                0x0010022050
+#define A_BCM1480_SCD_WDOG_3                0x0010022150
+
+#define BCM1480_SCD_NUM_WDOGS               4
+
+#define A_BCM1480_SCD_WDOG_BASE(w)       (A_BCM1480_SCD_WDOG_0+((w)&2)*0x1000 + ((w)&1)*0x100)
+#define A_BCM1480_SCD_WDOG_REGISTER(w,r) (A_BCM1480_SCD_WDOG_BASE(w) + (r))
+
+#define A_BCM1480_SCD_WDOG_INIT_2       0x0010022050
+#define A_BCM1480_SCD_WDOG_CNT_2        0x0010022058
+#define A_BCM1480_SCD_WDOG_CFG_2        0x0010022060
+
+#define A_BCM1480_SCD_WDOG_INIT_3       0x0010022150
+#define A_BCM1480_SCD_WDOG_CNT_3        0x0010022158
+#define A_BCM1480_SCD_WDOG_CFG_3        0x0010022160
+
+/* BCM1480 has two additional compare registers */
+
+#define A_BCM1480_SCD_ZBBUS_CYCLE_COUNT		A_SCD_ZBBUS_CYCLE_COUNT
+#define A_BCM1480_SCD_ZBBUS_CYCLE_CP_BASE       0x0010020C00
+#define A_BCM1480_SCD_ZBBUS_CYCLE_CP0           A_SCD_ZBBUS_CYCLE_CP0
+#define A_BCM1480_SCD_ZBBUS_CYCLE_CP1           A_SCD_ZBBUS_CYCLE_CP1
+#define A_BCM1480_SCD_ZBBUS_CYCLE_CP2           0x0010020C10
+#define A_BCM1480_SCD_ZBBUS_CYCLE_CP3           0x0010020C18
+
+/*  *********************************************************************
+    * System Control Registers (Section 4.2)
+    ********************************************************************* */
+
+/* Scratch register in different place */
+
+#define A_BCM1480_SCD_SCRATCH	 	0x100200A0
+
+/*  *********************************************************************
+    * System Address Trap Registers (Section 4.9)
+    ********************************************************************* */
+
+/* No changes from BCM1250 */
+
+/*  *********************************************************************
+    * System Interrupt Mapper Registers (Sections 4.3-4.5)
+    ********************************************************************* */
+
+#define A_BCM1480_IMR_CPU0_BASE             0x0010020000
+#define A_BCM1480_IMR_CPU1_BASE             0x0010022000
+#define A_BCM1480_IMR_CPU2_BASE             0x0010024000
+#define A_BCM1480_IMR_CPU3_BASE             0x0010026000
+#define BCM1480_IMR_REGISTER_SPACING        0x2000
+#define BCM1480_IMR_REGISTER_SPACING_SHIFT  13
+
+#define A_BCM1480_IMR_MAPPER(cpu)       (A_BCM1480_IMR_CPU0_BASE+(cpu)*BCM1480_IMR_REGISTER_SPACING)
+#define A_BCM1480_IMR_REGISTER(cpu,reg) (A_BCM1480_IMR_MAPPER(cpu)+(reg))
+
+/* Most IMR registers are 128 bits, implemented as non-contiguous
+   64-bit registers high (_H) and low (_L) */
+#define BCM1480_IMR_HL_SPACING                  0x1000
+
+#define R_BCM1480_IMR_INTERRUPT_DIAG_H          0x0010
+#define R_BCM1480_IMR_LDT_INTERRUPT_H           0x0018
+#define R_BCM1480_IMR_LDT_INTERRUPT_CLR_H       0x0020
+#define R_BCM1480_IMR_INTERRUPT_MASK_H          0x0028
+#define R_BCM1480_IMR_INTERRUPT_TRACE_H         0x0038
+#define R_BCM1480_IMR_INTERRUPT_SOURCE_STATUS_H 0x0040
+#define R_BCM1480_IMR_LDT_INTERRUPT_SET         0x0048
+#define R_BCM1480_IMR_MAILBOX_0_CPU             0x00C0
+#define R_BCM1480_IMR_MAILBOX_0_SET_CPU         0x00C8
+#define R_BCM1480_IMR_MAILBOX_0_CLR_CPU         0x00D0
+#define R_BCM1480_IMR_MAILBOX_1_CPU             0x00E0
+#define R_BCM1480_IMR_MAILBOX_1_SET_CPU         0x00E8
+#define R_BCM1480_IMR_MAILBOX_1_CLR_CPU         0x00F0
+#define R_BCM1480_IMR_INTERRUPT_STATUS_BASE_H   0x0100
+#define BCM1480_IMR_INTERRUPT_STATUS_COUNT      8
+#define R_BCM1480_IMR_INTERRUPT_MAP_BASE_H      0x0200
+#define BCM1480_IMR_INTERRUPT_MAP_COUNT         64
+
+#define R_BCM1480_IMR_INTERRUPT_DIAG_L          0x1010
+#define R_BCM1480_IMR_LDT_INTERRUPT_L           0x1018
+#define R_BCM1480_IMR_LDT_INTERRUPT_CLR_L       0x1020
+#define R_BCM1480_IMR_INTERRUPT_MASK_L          0x1028
+#define R_BCM1480_IMR_INTERRUPT_TRACE_L         0x1038
+#define R_BCM1480_IMR_INTERRUPT_SOURCE_STATUS_L 0x1040
+#define R_BCM1480_IMR_INTERRUPT_STATUS_BASE_L   0x1100
+#define R_BCM1480_IMR_INTERRUPT_MAP_BASE_L      0x1200
+
+#define A_BCM1480_IMR_ALIAS_MAILBOX_CPU0_BASE   0x0010028000
+#define A_BCM1480_IMR_ALIAS_MAILBOX_CPU1_BASE   0x0010028100
+#define A_BCM1480_IMR_ALIAS_MAILBOX_CPU2_BASE   0x0010028200
+#define A_BCM1480_IMR_ALIAS_MAILBOX_CPU3_BASE   0x0010028300
+#define BCM1480_IMR_ALIAS_MAILBOX_SPACING       0100
+
+#define A_BCM1480_IMR_ALIAS_MAILBOX(cpu)     (A_BCM1480_IMR_ALIAS_MAILBOX_CPU0_BASE + \
+                                        (cpu)*BCM1480_IMR_ALIAS_MAILBOX_SPACING)
+#define A_BCM1480_IMR_ALIAS_MAILBOX_REGISTER(cpu,reg) (A_BCM1480_IMR_ALIAS_MAILBOX(cpu)+(reg))
+
+#define R_BCM1480_IMR_ALIAS_MAILBOX_0           0x0000		/* 0x0x0 */
+#define R_BCM1480_IMR_ALIAS_MAILBOX_0_SET       0x0008		/* 0x0x8 */
+
+/*  *********************************************************************
+    * System Performance Counter Registers (Section 4.7)
+    ********************************************************************* */
+
+/* BCM1480 has four more performance counter registers, and two control
+   registers. */
+
+#define A_BCM1480_SCD_PERF_CNT_BASE         0x00100204C0
+
+#define A_BCM1480_SCD_PERF_CNT_CFG0         0x00100204C0
+#define A_BCM1480_SCD_PERF_CNT_CFG_0        A_BCM1480_SCD_PERF_CNT_CFG0
+#define A_BCM1480_SCD_PERF_CNT_CFG1         0x00100204C8
+#define A_BCM1480_SCD_PERF_CNT_CFG_1        A_BCM1480_SCD_PERF_CNT_CFG1
+
+#define A_BCM1480_SCD_PERF_CNT_0            A_SCD_PERF_CNT_0
+#define A_BCM1480_SCD_PERF_CNT_1            A_SCD_PERF_CNT_1
+#define A_BCM1480_SCD_PERF_CNT_2            A_SCD_PERF_CNT_2
+#define A_BCM1480_SCD_PERF_CNT_3            A_SCD_PERF_CNT_3
+
+#define A_BCM1480_SCD_PERF_CNT_4            0x00100204F0
+#define A_BCM1480_SCD_PERF_CNT_5            0x00100204F8
+#define A_BCM1480_SCD_PERF_CNT_6            0x0010020500
+#define A_BCM1480_SCD_PERF_CNT_7            0x0010020508
+
+/*  *********************************************************************
+    * System Bus Watcher Registers (Section 4.8)
+    ********************************************************************* */
+
+
+/* Same as 1250 except BUS_ERR_STATUS_DEBUG is in a different place. */
+
+#define A_BCM1480_BUS_ERR_STATUS_DEBUG      0x00100208D8
+
+/*  *********************************************************************
+    * System Debug Controller Registers (Section 19)
+    ********************************************************************* */
+
+/* Same as 1250 */
+
+/*  *********************************************************************
+    * System Trace Unit Registers (Sections 4.10)
+    ********************************************************************* */
+
+/* Same as 1250 */
+
+/*  *********************************************************************
+    * Data Mover DMA Registers (Section 10.7)
+    ********************************************************************* */
+
+/* Same as 1250 */
+
+
+/*  *********************************************************************
+    * HyperTransport Interface Registers (Section 8)
+    ********************************************************************* */
+
+#define BCM1480_HT_NUM_PORTS		   3
+#define BCM1480_HT_PORT_SPACING		   0x800
+#define A_BCM1480_HT_PORT_HEADER(x)	   (A_BCM1480_HT_PORT0_HEADER + ((x)*BCM1480_HT_PORT_SPACING))
+
+#define A_BCM1480_HT_PORT0_HEADER          0x00FE000000
+#define A_BCM1480_HT_PORT1_HEADER          0x00FE000800
+#define A_BCM1480_HT_PORT2_HEADER          0x00FE001000
+#define A_BCM1480_HT_TYPE00_HEADER         0x00FE002000
+
+
+/*  *********************************************************************
+    * Node Controller Registers (Section 9)
+    ********************************************************************* */
+
+#define A_BCM1480_NC_BASE                   0x00DFBD0000
+
+#define A_BCM1480_NC_RLD_FIELD              0x00DFBD0000
+#define A_BCM1480_NC_RLD_TRIGGER            0x00DFBD0020
+#define A_BCM1480_NC_RLD_BAD_ERROR          0x00DFBD0040
+#define A_BCM1480_NC_RLD_COR_ERROR          0x00DFBD0060
+#define A_BCM1480_NC_RLD_ECC_STATUS         0x00DFBD0080
+#define A_BCM1480_NC_RLD_WAY_ENABLE         0x00DFBD00A0
+#define A_BCM1480_NC_RLD_RANDOM_LFSR        0x00DFBD00C0
+
+#define A_BCM1480_NC_INTERRUPT_STATUS       0x00DFBD00E0
+#define A_BCM1480_NC_INTERRUPT_ENABLE       0x00DFBD0100
+#define A_BCM1480_NC_TIMEOUT_COUNTER        0x00DFBD0120
+#define A_BCM1480_NC_TIMEOUT_COUNTER_SEL    0x00DFBD0140
+
+#define A_BCM1480_NC_CREDIT_STATUS_REG0     0x00DFBD0200
+#define A_BCM1480_NC_CREDIT_STATUS_REG1     0x00DFBD0220
+#define A_BCM1480_NC_CREDIT_STATUS_REG2     0x00DFBD0240
+#define A_BCM1480_NC_CREDIT_STATUS_REG3     0x00DFBD0260
+#define A_BCM1480_NC_CREDIT_STATUS_REG4     0x00DFBD0280
+#define A_BCM1480_NC_CREDIT_STATUS_REG5     0x00DFBD02A0
+#define A_BCM1480_NC_CREDIT_STATUS_REG6     0x00DFBD02C0
+#define A_BCM1480_NC_CREDIT_STATUS_REG7     0x00DFBD02E0
+#define A_BCM1480_NC_CREDIT_STATUS_REG8     0x00DFBD0300
+#define A_BCM1480_NC_CREDIT_STATUS_REG9     0x00DFBD0320
+#define A_BCM1480_NC_CREDIT_STATUS_REG10    0x00DFBE0000
+#define A_BCM1480_NC_CREDIT_STATUS_REG11    0x00DFBE0020
+#define A_BCM1480_NC_CREDIT_STATUS_REG12    0x00DFBE0040
+
+#define A_BCM1480_NC_SR_TIMEOUT_COUNTER     0x00DFBE0060
+#define A_BCM1480_NC_SR_TIMEOUT_COUNTER_SEL 0x00DFBE0080
+
+
+/*  *********************************************************************
+    * H&R Block Configuration Registers (Section 12.4)
+    ********************************************************************* */
+
+#define A_BCM1480_HR_BASE_0                 0x00DF820000
+#define A_BCM1480_HR_BASE_1                 0x00DF8A0000
+#define A_BCM1480_HR_BASE_2                 0x00DF920000
+#define BCM1480_HR_REGISTER_SPACING         0x80000
+
+#define A_BCM1480_HR_BASE(idx)              (A_BCM1480_HR_BASE_0 + ((idx)*BCM1480_HR_REGISTER_SPACING))
+#define A_BCM1480_HR_REGISTER(idx,reg)      (A_BCM1480_HR_BASE(idx) + (reg))
+
+#define R_BCM1480_HR_CFG                    0x0000000000
+
+#define R_BCM1480_HR_MAPPING		    0x0000010010
+
+#define BCM1480_HR_RULE_SPACING             0x0000000010
+#define BCM1480_HR_NUM_RULES                16
+#define BCM1480_HR_OP_OFFSET                0x0000000100
+#define BCM1480_HR_TYPE_OFFSET              0x0000000108
+#define R_BCM1480_HR_RULE_OP(idx)           (BCM1480_HR_OP_OFFSET + ((idx)*BCM1480_HR_RULE_SPACING))
+#define R_BCM1480_HR_RULE_TYPE(idx)         (BCM1480_HR_TYPE_OFFSET + ((idx)*BCM1480_HR_RULE_SPACING))
+
+#define BCM1480_HR_LEAF_SPACING             0x0000000010
+#define BCM1480_HR_NUM_LEAVES               10
+#define BCM1480_HR_LEAF_OFFSET              0x0000000300
+#define R_BCM1480_HR_HA_LEAF0(idx)          (BCM1480_HR_LEAF_OFFSET + ((idx)*BCM1480_HR_LEAF_SPACING))
+
+#define R_BCM1480_HR_EX_LEAF0               0x00000003A0
+
+#define BCM1480_HR_PATH_SPACING             0x0000000010
+#define BCM1480_HR_NUM_PATHS                16
+#define BCM1480_HR_PATH_OFFSET              0x0000000600
+#define R_BCM1480_HR_PATH(idx)              (BCM1480_HR_PATH_OFFSET + ((idx)*BCM1480_HR_PATH_SPACING))
+
+#define R_BCM1480_HR_PATH_DEFAULT           0x0000000700
+
+#define BCM1480_HR_ROUTE_SPACING            8
+#define BCM1480_HR_NUM_ROUTES               512
+#define BCM1480_HR_ROUTE_OFFSET             0x0000001000
+#define R_BCM1480_HR_RT_WORD(idx)           (BCM1480_HR_ROUTE_OFFSET + ((idx)*BCM1480_HR_ROUTE_SPACING))
+
+
+/* checked to here - ehs */
+/*  *********************************************************************
+    * Packet Manager DMA Registers (Section 12.5)
+    ********************************************************************* */
+
+#define A_BCM1480_PM_BASE                   0x0010056000
+
+#define A_BCM1480_PMI_LCL_0                 0x0010058000
+#define A_BCM1480_PMO_LCL_0                 0x001005C000
+#define A_BCM1480_PMI_OFFSET_0              (A_BCM1480_PMI_LCL_0 - A_BCM1480_PM_BASE)
+#define A_BCM1480_PMO_OFFSET_0              (A_BCM1480_PMO_LCL_0 - A_BCM1480_PM_BASE)
+
+#define BCM1480_PM_LCL_REGISTER_SPACING     0x100
+#define BCM1480_PM_NUM_CHANNELS             32
+
+#define A_BCM1480_PMI_LCL_BASE(idx)             (A_BCM1480_PMI_LCL_0 + ((idx)*BCM1480_PM_LCL_REGISTER_SPACING))
+#define A_BCM1480_PMI_LCL_REGISTER(idx,reg)     (A_BCM1480_PMI_LCL_BASE(idx) + (reg))
+#define A_BCM1480_PMO_LCL_BASE(idx)             (A_BCM1480_PMO_LCL_0 + ((idx)*BCM1480_PM_LCL_REGISTER_SPACING))
+#define A_BCM1480_PMO_LCL_REGISTER(idx,reg)     (A_BCM1480_PMO_LCL_BASE(idx) + (reg))
+
+#define BCM1480_PM_INT_PACKING              8
+#define BCM1480_PM_INT_FUNCTION_SPACING     0x40
+#define BCM1480_PM_INT_NUM_FUNCTIONS        3
+
+/*
+ * DMA channel registers relative to A_BCM1480_PMI_LCL_BASE(n) and A_BCM1480_PMO_LCL_BASE(n)
+ */
+
+#define R_BCM1480_PM_BASE_SIZE              0x0000000000
+#define R_BCM1480_PM_CNT                    0x0000000008
+#define R_BCM1480_PM_PFCNT                  0x0000000010
+#define R_BCM1480_PM_LAST                   0x0000000018
+#define R_BCM1480_PM_PFINDX                 0x0000000020
+#define R_BCM1480_PM_INT_WMK                0x0000000028
+#define R_BCM1480_PM_CONFIG0                0x0000000030
+#define R_BCM1480_PM_LOCALDEBUG             0x0000000078
+#define R_BCM1480_PM_CACHEABILITY           0x0000000080   /* PMI only */
+#define R_BCM1480_PM_INT_CNFG               0x0000000088
+#define R_BCM1480_PM_DESC_MERGE_TIMER       0x0000000090
+#define R_BCM1480_PM_LOCALDEBUG_PIB         0x00000000F8   /* PMI only */
+#define R_BCM1480_PM_LOCALDEBUG_POB         0x00000000F8   /* PMO only */
+
+/*
+ * Global Registers (Not Channelized)
+ */
+
+#define A_BCM1480_PMI_GLB_0                 0x0010056000
+#define A_BCM1480_PMO_GLB_0                 0x0010057000
+
+/*
+ * PM to TX Mapping Register relative to A_BCM1480_PMI_GLB_0 and A_BCM1480_PMO_GLB_0
+ */
+
+#define R_BCM1480_PM_PMO_MAPPING            0x00000008C8   /* PMO only */
+
+#define A_BCM1480_PM_PMO_MAPPING	(A_BCM1480_PMO_GLB_0 + R_BCM1480_PM_PMO_MAPPING)
+
+/*
+ * Interrupt mapping registers
+ */
+
+
+#define A_BCM1480_PMI_INT_0                 0x0010056800
+#define A_BCM1480_PMI_INT(q)                (A_BCM1480_PMI_INT_0 + ((q>>8)<<8))
+#define A_BCM1480_PMI_INT_OFFSET_0          (A_BCM1480_PMI_INT_0 - A_BCM1480_PM_BASE)
+#define A_BCM1480_PMO_INT_0                 0x0010057800
+#define A_BCM1480_PMO_INT(q)                (A_BCM1480_PMO_INT_0 + ((q>>8)<<8))
+#define A_BCM1480_PMO_INT_OFFSET_0          (A_BCM1480_PMO_INT_0 - A_BCM1480_PM_BASE)
+
+/*
+ * Interrupt registers relative to A_BCM1480_PMI_INT_0 and A_BCM1480_PMO_INT_0
+ */
+
+#define R_BCM1480_PM_INT_ST                 0x0000000000
+#define R_BCM1480_PM_INT_MSK                0x0000000040
+#define R_BCM1480_PM_INT_CLR                0x0000000080
+#define R_BCM1480_PM_MRGD_INT               0x00000000C0
+
+/*
+ * Debug registers (global)
+ */
+
+#define A_BCM1480_PM_GLOBALDEBUGMODE_PMI    0x0010056000
+#define A_BCM1480_PM_GLOBALDEBUG_PID        0x00100567F8
+#define A_BCM1480_PM_GLOBALDEBUG_PIB        0x0010056FF8
+#define A_BCM1480_PM_GLOBALDEBUGMODE_PMO    0x0010057000
+#define A_BCM1480_PM_GLOBALDEBUG_POD        0x00100577F8
+#define A_BCM1480_PM_GLOBALDEBUG_POB        0x0010057FF8
+
+/*  *********************************************************************
+    *  Switch performance counters
+    ********************************************************************* */
+
+#define A_BCM1480_SWPERF_CFG	0xdfb91800
+#define A_BCM1480_SWPERF_CNT0	0xdfb91880
+#define A_BCM1480_SWPERF_CNT1	0xdfb91888
+#define A_BCM1480_SWPERF_CNT2	0xdfb91890
+#define A_BCM1480_SWPERF_CNT3	0xdfb91898
+
+
+/*  *********************************************************************
+    *  Switch Trace Unit
+    ********************************************************************* */
+
+#define A_BCM1480_SWTRC_MATCH_CONTROL_0		0xDFB91000
+#define A_BCM1480_SWTRC_MATCH_DATA_VALUE_0	0xDFB91100
+#define A_BCM1480_SWTRC_MATCH_DATA_MASK_0	0xDFB91108
+#define A_BCM1480_SWTRC_MATCH_TAG_VALUE_0	0xDFB91200
+#define A_BCM1480_SWTRC_MATCH_TAG_MAKS_0	0xDFB91208
+#define A_BCM1480_SWTRC_EVENT_0			0xDFB91300
+#define A_BCM1480_SWTRC_SEQUENCE_0		0xDFB91400
+
+#define A_BCM1480_SWTRC_CFG			0xDFB91500
+#define A_BCM1480_SWTRC_READ			0xDFB91508
+
+#define A_BCM1480_SWDEBUG_SCHEDSTOP		0xDFB92000
+
+#define A_BCM1480_SWTRC_MATCH_CONTROL(x) (A_BCM1480_SWTRC_MATCH_CONTROL_0 + ((x)*8))
+#define A_BCM1480_SWTRC_EVENT(x) (A_BCM1480_SWTRC_EVENT_0 + ((x)*8))
+#define A_BCM1480_SWTRC_SEQUENCE(x) (A_BCM1480_SWTRC_SEQUENCE_0 + ((x)*8))
+
+#define A_BCM1480_SWTRC_MATCH_DATA_VALUE(x) (A_BCM1480_SWTRC_MATCH_DATA_VALUE_0 + ((x)*16))
+#define A_BCM1480_SWTRC_MATCH_DATA_MASK(x) (A_BCM1480_SWTRC_MATCH_DATA_MASK_0 + ((x)*16))
+#define A_BCM1480_SWTRC_MATCH_TAG_VALUE(x) (A_BCM1480_SWTRC_MATCH_TAG_VALUE_0 + ((x)*16))
+#define A_BCM1480_SWTRC_MATCH_TAG_MASK(x) (A_BCM1480_SWTRC_MATCH_TAG_MASK_0 + ((x)*16))
+
+
+
+/*  *********************************************************************
+    *  High-Speed Port Registers (Section 13)
+    ********************************************************************* */
+
+#define A_BCM1480_HSP_BASE_0                0x00DF810000
+#define A_BCM1480_HSP_BASE_1                0x00DF890000
+#define A_BCM1480_HSP_BASE_2                0x00DF910000
+#define BCM1480_HSP_REGISTER_SPACING        0x80000
+
+#define A_BCM1480_HSP_BASE(idx)             (A_BCM1480_HSP_BASE_0 + ((idx)*BCM1480_HSP_REGISTER_SPACING))
+#define A_BCM1480_HSP_REGISTER(idx,reg)     (A_BCM1480_HSP_BASE(idx) + (reg))
+
+#define R_BCM1480_HSP_RX_SPI4_CFG_0           0x0000000000
+#define R_BCM1480_HSP_RX_SPI4_CFG_1           0x0000000008
+#define R_BCM1480_HSP_RX_SPI4_DESKEW_OVERRIDE 0x0000000010
+#define R_BCM1480_HSP_RX_SPI4_DESKEW_DATAPATH 0x0000000018
+#define R_BCM1480_HSP_RX_SPI4_PORT_INT_EN     0x0000000020
+#define R_BCM1480_HSP_RX_SPI4_PORT_INT_STATUS 0x0000000028
+
+#define R_BCM1480_HSP_RX_SPI4_CALENDAR_0      0x0000000200
+#define R_BCM1480_HSP_RX_SPI4_CALENDAR_1      0x0000000208
+
+#define R_BCM1480_HSP_RX_PLL_CNFG             0x0000000800
+#define R_BCM1480_HSP_RX_CALIBRATION          0x0000000808
+#define R_BCM1480_HSP_RX_TEST                 0x0000000810
+#define R_BCM1480_HSP_RX_DIAG_DETAILS         0x0000000818
+#define R_BCM1480_HSP_RX_DIAG_CRC_0           0x0000000820
+#define R_BCM1480_HSP_RX_DIAG_CRC_1           0x0000000828
+#define R_BCM1480_HSP_RX_DIAG_HTCMD           0x0000000830
+#define R_BCM1480_HSP_RX_DIAG_PKTCTL          0x0000000838
+
+#define R_BCM1480_HSP_RX_VIS_FLCTRL_COUNTER   0x0000000870
+
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_0       0x0000020020
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_1       0x0000020028
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_2       0x0000020030
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_3       0x0000020038
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_4       0x0000020040
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_5       0x0000020048
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_6       0x0000020050
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC_7       0x0000020058
+#define R_BCM1480_HSP_RX_PKT_RAMALLOC(idx)    (R_BCM1480_HSP_RX_PKT_RAMALLOC_0 + 8*(idx))
+
+/* XXX Following registers were shuffled.  Renamed/renumbered per errata. */
+#define R_BCM1480_HSP_RX_HT_RAMALLOC_0      0x0000020078
+#define R_BCM1480_HSP_RX_HT_RAMALLOC_1      0x0000020080
+#define R_BCM1480_HSP_RX_HT_RAMALLOC_2      0x0000020088
+#define R_BCM1480_HSP_RX_HT_RAMALLOC_3      0x0000020090
+#define R_BCM1480_HSP_RX_HT_RAMALLOC_4      0x0000020098
+#define R_BCM1480_HSP_RX_HT_RAMALLOC_5      0x00000200A0
+
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_0      0x00000200B0
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_1      0x00000200B8
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_2      0x00000200C0
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_3      0x00000200C8
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_4      0x00000200D0
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_5      0x00000200D8
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_6      0x00000200E0
+#define R_BCM1480_HSP_RX_SPI_WATERMARK_7      0x00000200E8
+#define R_BCM1480_HSP_RX_SPI_WATERMARK(idx)   (R_BCM1480_HSP_RX_SPI_WATERMARK_0 + 8*(idx))
+
+#define R_BCM1480_HSP_RX_VIS_CMDQ_0           0x00000200F0
+#define R_BCM1480_HSP_RX_VIS_CMDQ_1           0x00000200F8
+#define R_BCM1480_HSP_RX_VIS_CMDQ_2           0x0000020100
+#define R_BCM1480_HSP_RX_RAM_READCTL          0x0000020108
+#define R_BCM1480_HSP_RX_RAM_READWINDOW       0x0000020110
+#define R_BCM1480_HSP_RX_RF_READCTL           0x0000020118
+#define R_BCM1480_HSP_RX_RF_READWINDOW        0x0000020120
+
+#define R_BCM1480_HSP_TX_SPI4_CFG_0           0x0000040000
+#define R_BCM1480_HSP_TX_SPI4_CFG_1           0x0000040008
+#define R_BCM1480_HSP_TX_SPI4_TRAINING_FMT    0x0000040010
+
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_0       0x0000040020
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_1       0x0000040028
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_2       0x0000040030
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_3       0x0000040038
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_4       0x0000040040
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_5       0x0000040048
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_6       0x0000040050
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC_7       0x0000040058
+#define R_BCM1480_HSP_TX_PKT_RAMALLOC(idx)    (R_BCM1480_HSP_TX_PKT_RAMALLOC_0 + 8*(idx))
+#define R_BCM1480_HSP_TX_NPC_RAMALLOC         0x0000040078
+#define R_BCM1480_HSP_TX_RSP_RAMALLOC         0x0000040080
+#define R_BCM1480_HSP_TX_PC_RAMALLOC          0x0000040088
+#define R_BCM1480_HSP_TX_HTCC_RAMALLOC_0      0x0000040090
+#define R_BCM1480_HSP_TX_HTCC_RAMALLOC_1      0x0000040098
+#define R_BCM1480_HSP_TX_HTCC_RAMALLOC_2      0x00000400A0
+
+#define R_BCM1480_HSP_TX_PKT_RXPHITCNT_0      0x00000400B0
+#define R_BCM1480_HSP_TX_PKT_RXPHITCNT_1      0x00000400B8
+#define R_BCM1480_HSP_TX_PKT_RXPHITCNT_2      0x00000400C0
+#define R_BCM1480_HSP_TX_PKT_RXPHITCNT_3      0x00000400C8
+#define R_BCM1480_HSP_TX_PKT_RXPHITCNT(idx)   (R_BCM1480_HSP_TX_PKT_RXPHITCNT_0 + 8*(idx))
+#define R_BCM1480_HSP_TX_HTIO_RXPHITCNT       0x00000400D0
+#define R_BCM1480_HSP_TX_HTCC_RXPHITCNT       0x00000400D8
+
+#define R_BCM1480_HSP_TX_PKT_TXPHITCNT_0      0x00000400E0
+#define R_BCM1480_HSP_TX_PKT_TXPHITCNT_1      0x00000400E8
+#define R_BCM1480_HSP_TX_PKT_TXPHITCNT_2      0x00000400F0
+#define R_BCM1480_HSP_TX_PKT_TXPHITCNT_3      0x00000400F8
+#define R_BCM1480_HSP_TX_PKT_TXPHITCNT(idx)   (R_BCM1480_HSP_TX_PKT_TXPHITCNT_0 + 8*(idx))
+#define R_BCM1480_HSP_TX_HTIO_TXPHITCNT       0x0000040100
+#define R_BCM1480_HSP_TX_HTCC_TXPHITCNT       0x0000040108
+
+#define R_BCM1480_HSP_TX_SPI4_CALENDAR_0      0x0000040200
+#define R_BCM1480_HSP_TX_SPI4_CALENDAR_1      0x0000040208
+
+#define R_BCM1480_HSP_TX_PLL_CNFG             0x0000040800
+#define R_BCM1480_HSP_TX_CALIBRATION          0x0000040808
+#define R_BCM1480_HSP_TX_TEST                 0x0000040810
+
+#define R_BCM1480_HSP_TX_VIS_CMDQ_0           0x0000040840
+#define R_BCM1480_HSP_TX_VIS_CMDQ_1           0x0000040848
+#define R_BCM1480_HSP_TX_VIS_CMDQ_2           0x0000040850
+#define R_BCM1480_HSP_TX_RAM_READCTL          0x0000040860
+#define R_BCM1480_HSP_TX_RAM_READWINDOW       0x0000040868
+#define R_BCM1480_HSP_TX_RF_READCTL           0x0000040870
+#define R_BCM1480_HSP_TX_RF_READWINDOW        0x0000040878
+
+#define R_BCM1480_HSP_TX_SPI4_PORT_INT_STATUS 0x0000040880
+#define R_BCM1480_HSP_TX_SPI4_PORT_INT_EN     0x0000040888
+
+#define R_BCM1480_HSP_TX_NEXT_ADDR_BASE 0x000040400
+#define R_BCM1480_HSP_TX_NEXT_ADDR_REGISTER(x)  (R_BCM1480_HSP_TX_NEXT_ADDR_BASE+ 8*(x))
+
+
+
+/*  *********************************************************************
+    *  Physical Address Map (Table 10 and Figure 7)
+    ********************************************************************* */
+
+#define A_BCM1480_PHYS_MEMORY_0                 _SB_MAKE64(0x0000000000)
+#define A_BCM1480_PHYS_MEMORY_SIZE              _SB_MAKE64((256*1024*1024))
+#define A_BCM1480_PHYS_SYSTEM_CTL               _SB_MAKE64(0x0010000000)
+#define A_BCM1480_PHYS_IO_SYSTEM                _SB_MAKE64(0x0010060000)
+#define A_BCM1480_PHYS_GENBUS                   _SB_MAKE64(0x0010090000)
+#define A_BCM1480_PHYS_GENBUS_END               _SB_MAKE64(0x0028000000)
+#define A_BCM1480_PHYS_PCI_MISC_MATCH_BYTES     _SB_MAKE64(0x0028000000)
+#define A_BCM1480_PHYS_PCI_IACK_MATCH_BYTES     _SB_MAKE64(0x0029000000)
+#define A_BCM1480_PHYS_PCI_IO_MATCH_BYTES       _SB_MAKE64(0x002C000000)
+#define A_BCM1480_PHYS_PCI_CFG_MATCH_BYTES      _SB_MAKE64(0x002E000000)
+#define A_BCM1480_PHYS_PCI_OMAP_MATCH_BYTES     _SB_MAKE64(0x002F000000)
+#define A_BCM1480_PHYS_PCI_MEM_MATCH_BYTES      _SB_MAKE64(0x0030000000)
+#define A_BCM1480_PHYS_HT_MEM_MATCH_BYTES       _SB_MAKE64(0x0040000000)
+#define A_BCM1480_PHYS_HT_MEM_MATCH_BITS        _SB_MAKE64(0x0060000000)
+#define A_BCM1480_PHYS_MEMORY_1                 _SB_MAKE64(0x0080000000)
+#define A_BCM1480_PHYS_MEMORY_2                 _SB_MAKE64(0x0090000000)
+#define A_BCM1480_PHYS_PCI_MISC_MATCH_BITS      _SB_MAKE64(0x00A8000000)
+#define A_BCM1480_PHYS_PCI_IACK_MATCH_BITS      _SB_MAKE64(0x00A9000000)
+#define A_BCM1480_PHYS_PCI_IO_MATCH_BITS        _SB_MAKE64(0x00AC000000)
+#define A_BCM1480_PHYS_PCI_CFG_MATCH_BITS       _SB_MAKE64(0x00AE000000)
+#define A_BCM1480_PHYS_PCI_OMAP_MATCH_BITS      _SB_MAKE64(0x00AF000000)
+#define A_BCM1480_PHYS_PCI_MEM_MATCH_BITS       _SB_MAKE64(0x00B0000000)
+#define A_BCM1480_PHYS_MEMORY_3                 _SB_MAKE64(0x00C0000000)
+#define A_BCM1480_PHYS_L2_CACHE_TEST            _SB_MAKE64(0x00D0000000)
+#define A_BCM1480_PHYS_HT_SPECIAL_MATCH_BYTES   _SB_MAKE64(0x00D8000000)
+#define A_BCM1480_PHYS_HT_IO_MATCH_BYTES        _SB_MAKE64(0x00DC000000)
+#define A_BCM1480_PHYS_HT_CFG_MATCH_BYTES       _SB_MAKE64(0x00DE000000)
+#define A_BCM1480_PHYS_HS_SUBSYS                _SB_MAKE64(0x00DF000000)
+#define A_BCM1480_PHYS_HT_SPECIAL_MATCH_BITS    _SB_MAKE64(0x00F8000000)
+#define A_BCM1480_PHYS_HT_IO_MATCH_BITS         _SB_MAKE64(0x00FC000000)
+#define A_BCM1480_PHYS_HT_CFG_MATCH_BITS        _SB_MAKE64(0x00FE000000)
+#define A_BCM1480_PHYS_MEMORY_EXP               _SB_MAKE64(0x0100000000)
+#define A_BCM1480_PHYS_MEMORY_EXP_SIZE          _SB_MAKE64((508*1024*1024*1024))
+#define A_BCM1480_PHYS_PCI_UPPER                _SB_MAKE64(0x1000000000)
+#define A_BCM1480_PHYS_HT_UPPER_MATCH_BYTES     _SB_MAKE64(0x2000000000)
+#define A_BCM1480_PHYS_HT_UPPER_MATCH_BITS      _SB_MAKE64(0x3000000000)
+#define A_BCM1480_PHYS_HT_NODE_ALIAS            _SB_MAKE64(0x4000000000)
+#define A_BCM1480_PHYS_HT_FULLACCESS            _SB_MAKE64(0xF000000000)
+
+
+/*  *********************************************************************
+    *  L2 Cache as RAM (Table 54)
+    ********************************************************************* */
+
+#define A_BCM1480_PHYS_L2CACHE_WAY_SIZE         _SB_MAKE64(0x0000020000)
+#define BCM1480_PHYS_L2CACHE_NUM_WAYS           8
+#define A_BCM1480_PHYS_L2CACHE_TOTAL_SIZE       _SB_MAKE64(0x0000100000)
+#define A_BCM1480_PHYS_L2CACHE_WAY0             _SB_MAKE64(0x00D0300000)
+#define A_BCM1480_PHYS_L2CACHE_WAY1             _SB_MAKE64(0x00D0320000)
+#define A_BCM1480_PHYS_L2CACHE_WAY2             _SB_MAKE64(0x00D0340000)
+#define A_BCM1480_PHYS_L2CACHE_WAY3             _SB_MAKE64(0x00D0360000)
+#define A_BCM1480_PHYS_L2CACHE_WAY4             _SB_MAKE64(0x00D0380000)
+#define A_BCM1480_PHYS_L2CACHE_WAY5             _SB_MAKE64(0x00D03A0000)
+#define A_BCM1480_PHYS_L2CACHE_WAY6             _SB_MAKE64(0x00D03C0000)
+#define A_BCM1480_PHYS_L2CACHE_WAY7             _SB_MAKE64(0x00D03E0000)
+
+#endif /* _BCM1480_REGS_H */
Index: lmo/include/asm-mips/sibyte/bcm1480_scd.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/include/asm-mips/sibyte/bcm1480_scd.h	2005-10-19 22:34:11.000000000 -0700
@@ -0,0 +1,436 @@
+/*  *********************************************************************
+    *  BCM1280/BCM1400 Board Support Package
+    *
+    *  SCD Constants and Macros                     File: bcm1480_scd.h
+    *
+    *  This module contains constants and macros useful for
+    *  manipulating the System Control and Debug module.
+    *
+    *  BCM1400 specification level: 1X55_1X80-UM100-R (12/18/03)
+    *
+    *********************************************************************
+    *
+    *  Copyright 2000,2001,2002,2003
+    *  Broadcom Corporation. All rights reserved.
+    *
+    *  This program is free software; you can redistribute it and/or
+    *  modify it under the terms of the GNU General Public License as
+    *  published by the Free Software Foundation; either version 2 of
+    *  the License, or (at your option) any later version.
+    *
+    *  This program is distributed in the hope that it will be useful,
+    *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+    *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    *  GNU General Public License for more details.
+    *
+    *  You should have received a copy of the GNU General Public License
+    *  along with this program; if not, write to the Free Software
+    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+    *  MA 02111-1307 USA
+    ********************************************************************* */
+
+#ifndef _BCM1480_SCD_H
+#define _BCM1480_SCD_H
+
+#include "sb1250_defs.h"
+
+/*  *********************************************************************
+    *  Pull in the BCM1250's SCD since lots of stuff is the same.
+    ********************************************************************* */
+
+#include "sb1250_scd.h"
+
+/*  *********************************************************************
+    *  Some general notes:
+    *
+    *  This file is basically a "what's new" header file.  Since the
+    *  BCM1250 and the new BCM1480 (and derivatives) share many common
+    *  features, this file contains only what's new or changed from
+    *  the 1250.  (above, you can see that we include the 1250 symbols
+    *  to get the base functionality).
+    *
+    *  In software, be sure to use the correct symbols, particularly
+    *  for blocks that are different between the two chip families.
+    *  All BCM1480-specific symbols have _BCM1480_ in their names,
+    *  and all BCM1250-specific and "base" functions that are common in
+    *  both chips have no special names (this is for compatibility with
+    *  older include files).  Therefore, if you're working with the
+    *  SCD, which is very different on each chip, A_SCD_xxx implies
+    *  the BCM1250 version and A_BCM1480_SCD_xxx implies the BCM1480
+    *  version.
+    ********************************************************************* */
+
+/*  *********************************************************************
+    *  System control/debug registers
+    ********************************************************************* */
+
+/*
+ * System Identification and Revision Register (Table 12)
+ * Register: SCD_SYSTEM_REVISION
+ * This register is field compatible with the 1250.
+ */
+
+/*
+ * New part definitions
+ */
+
+#define K_SYS_PART_BCM1480          0x1406
+#define K_SYS_PART_BCM1280          0x1206
+#define K_SYS_PART_BCM1455          0x1407
+#define K_SYS_PART_BCM1255          0x1257
+
+/*
+ * Manufacturing Information Register (Table 14)
+ * Register: SCD_SYSTEM_MANUF
+ */
+
+/*
+ * System Configuration Register (Table 15)
+ * Register: SCD_SYSTEM_CFG
+ * Entire register is different from 1250, all new constants below
+ */
+
+#define M_BCM1480_SYS_RESERVED0             _SB_MAKEMASK1(0)
+#define M_BCM1480_SYS_HT_MINRSTCNT          _SB_MAKEMASK1(1)
+#define M_BCM1480_SYS_RESERVED2             _SB_MAKEMASK1(2)
+#define M_BCM1480_SYS_RESERVED3             _SB_MAKEMASK1(3)
+#define M_BCM1480_SYS_RESERVED4             _SB_MAKEMASK1(4)
+#define M_BCM1480_SYS_IOB_DIV               _SB_MAKEMASK1(5)
+
+#define S_BCM1480_SYS_PLL_DIV               _SB_MAKE64(6)
+#define M_BCM1480_SYS_PLL_DIV               _SB_MAKEMASK(5,S_BCM1480_SYS_PLL_DIV)
+#define V_BCM1480_SYS_PLL_DIV(x)            _SB_MAKEVALUE(x,S_BCM1480_SYS_PLL_DIV)
+#define G_BCM1480_SYS_PLL_DIV(x)            _SB_GETVALUE(x,S_BCM1480_SYS_PLL_DIV,M_BCM1480_SYS_PLL_DIV)
+
+#define S_BCM1480_SYS_SW_DIV                _SB_MAKE64(11)
+#define M_BCM1480_SYS_SW_DIV                _SB_MAKEMASK(5,S_BCM1480_SYS_SW_DIV)
+#define V_BCM1480_SYS_SW_DIV(x)             _SB_MAKEVALUE(x,S_BCM1480_SYS_SW_DIV)
+#define G_BCM1480_SYS_SW_DIV(x)             _SB_GETVALUE(x,S_BCM1480_SYS_SW_DIV,M_BCM1480_SYS_SW_DIV)
+
+#define M_BCM1480_SYS_PCMCIA_ENABLE         _SB_MAKEMASK1(16)
+#define M_BCM1480_SYS_DUART1_ENABLE         _SB_MAKEMASK1(17)
+
+#define S_BCM1480_SYS_BOOT_MODE             _SB_MAKE64(18)
+#define M_BCM1480_SYS_BOOT_MODE             _SB_MAKEMASK(2,S_BCM1480_SYS_BOOT_MODE)
+#define V_BCM1480_SYS_BOOT_MODE(x)          _SB_MAKEVALUE(x,S_BCM1480_SYS_BOOT_MODE)
+#define G_BCM1480_SYS_BOOT_MODE(x)          _SB_GETVALUE(x,S_BCM1480_SYS_BOOT_MODE,M_BCM1480_SYS_BOOT_MODE)
+#define K_BCM1480_SYS_BOOT_MODE_ROM32       0
+#define K_BCM1480_SYS_BOOT_MODE_ROM8        1
+#define K_BCM1480_SYS_BOOT_MODE_SMBUS_SMALL 2
+#define K_BCM1480_SYS_BOOT_MODE_SMBUS_BIG   3
+#define M_BCM1480_SYS_BOOT_MODE_SMBUS       _SB_MAKEMASK1(19)
+
+#define M_BCM1480_SYS_PCI_HOST              _SB_MAKEMASK1(20)
+#define M_BCM1480_SYS_PCI_ARBITER           _SB_MAKEMASK1(21)
+#define M_BCM1480_SYS_BIG_ENDIAN            _SB_MAKEMASK1(22)
+#define M_BCM1480_SYS_GENCLK_EN             _SB_MAKEMASK1(23)
+#define M_BCM1480_SYS_GEN_PARITY_EN         _SB_MAKEMASK1(24)
+#define M_BCM1480_SYS_RESERVED25            _SB_MAKEMASK1(25)
+
+#define S_BCM1480_SYS_CONFIG                26
+#define M_BCM1480_SYS_CONFIG                _SB_MAKEMASK(6,S_BCM1480_SYS_CONFIG)
+#define V_BCM1480_SYS_CONFIG(x)             _SB_MAKEVALUE(x,S_BCM1480_SYS_CONFIG)
+#define G_BCM1480_SYS_CONFIG(x)             _SB_GETVALUE(x,S_BCM1480_SYS_CONFIG,M_BCM1480_SYS_CONFIG)
+
+#define M_BCM1480_SYS_RESERVED32            _SB_MAKEMASK(32,15)
+
+#define S_BCM1480_SYS_NODEID                47
+#define M_BCM1480_SYS_NODEID                _SB_MAKEMASK(4,S_BCM1480_SYS_NODEID)
+#define V_BCM1480_SYS_NODEID(x)             _SB_MAKEVALUE(x,S_BCM1480_SYS_NODEID)
+#define G_BCM1480_SYS_NODEID(x)             _SB_GETVALUE(x,S_BCM1480_SYS_NODEID,M_BCM1480_SYS_NODEID)
+
+#define M_BCM1480_SYS_CCNUMA_EN             _SB_MAKEMASK1(51)
+#define M_BCM1480_SYS_CPU_RESET_0           _SB_MAKEMASK1(52)
+#define M_BCM1480_SYS_CPU_RESET_1           _SB_MAKEMASK1(53)
+#define M_BCM1480_SYS_CPU_RESET_2           _SB_MAKEMASK1(54)
+#define M_BCM1480_SYS_CPU_RESET_3           _SB_MAKEMASK1(55)
+#define S_BCM1480_SYS_DISABLECPU0           56
+#define M_BCM1480_SYS_DISABLECPU0           _SB_MAKEMASK1(S_BCM1480_SYS_DISABLECPU0)
+#define S_BCM1480_SYS_DISABLECPU1           57
+#define M_BCM1480_SYS_DISABLECPU1           _SB_MAKEMASK1(S_BCM1480_SYS_DISABLECPU1)
+#define S_BCM1480_SYS_DISABLECPU2           58
+#define M_BCM1480_SYS_DISABLECPU2           _SB_MAKEMASK1(S_BCM1480_SYS_DISABLECPU2)
+#define S_BCM1480_SYS_DISABLECPU3           59
+#define M_BCM1480_SYS_DISABLECPU3           _SB_MAKEMASK1(S_BCM1480_SYS_DISABLECPU3)
+
+#define M_BCM1480_SYS_SB_SOFTRES            _SB_MAKEMASK1(60)
+#define M_BCM1480_SYS_EXT_RESET             _SB_MAKEMASK1(61)
+#define M_BCM1480_SYS_SYSTEM_RESET          _SB_MAKEMASK1(62)
+#define M_BCM1480_SYS_SW_FLAG               _SB_MAKEMASK1(63)
+
+/*
+ * Scratch Register (Table 16)
+ * Register: SCD_SYSTEM_SCRATCH
+ * Same as BCM1250
+ */
+
+
+/*
+ * Mailbox Registers (Table 17)
+ * Registers: SCD_MBOX_{0,1}_CPU_x
+ * Same as BCM1250
+ */
+
+
+/*
+ * See bcm1480_int.h for interrupt mapper registers.
+ */
+
+
+/*
+ * Watchdog Timer Initial Count Registers (Table 23)
+ * Registers: SCD_WDOG_INIT_CNT_x
+ *
+ * The watchdogs are almost the same as the 1250, except
+ * the configuration register has more bits to control the
+ * other CPUs.
+ */
+
+
+/*
+ * Watchdog Timer Configuration Registers (Table 25)
+ * Registers: SCD_WDOG_CFG_x
+ */
+
+#define M_BCM1480_SCD_WDOG_ENABLE           _SB_MAKEMASK1(0)
+
+#define S_BCM1480_SCD_WDOG_RESET_TYPE       2
+#define M_BCM1480_SCD_WDOG_RESET_TYPE       _SB_MAKEMASK(5,S_BCM1480_SCD_WDOG_RESET_TYPE)
+#define V_BCM1480_SCD_WDOG_RESET_TYPE(x)    _SB_MAKEVALUE(x,S_BCM1480_SCD_WDOG_RESET_TYPE)
+#define G_BCM1480_SCD_WDOG_RESET_TYPE(x)    _SB_GETVALUE(x,S_BCM1480_SCD_WDOG_RESET_TYPE,M_BCM1480_SCD_WDOG_RESET_TYPE)
+
+#define K_BCM1480_SCD_WDOG_RESET_FULL       0	/* actually, (x & 1) == 0  */
+#define K_BCM1480_SCD_WDOG_RESET_SOFT       1
+#define K_BCM1480_SCD_WDOG_RESET_CPU0       3
+#define K_BCM1480_SCD_WDOG_RESET_CPU1       5
+#define K_BCM1480_SCD_WDOG_RESET_CPU2       9
+#define K_BCM1480_SCD_WDOG_RESET_CPU3       17
+#define K_BCM1480_SCD_WDOG_RESET_ALL_CPUS   31
+
+
+#define M_BCM1480_SCD_WDOG_HAS_RESET        _SB_MAKEMASK1(8)
+
+/*
+ * General Timer Initial Count Registers (Table 26)
+ * Registers: SCD_TIMER_INIT_x
+ *
+ * The timer registers are the same as the BCM1250
+ */
+
+
+/*
+ * ZBbus Count Register (Table 29)
+ * Register: ZBBUS_CYCLE_COUNT
+ *
+ * Same as BCM1250
+ */
+
+/*
+ * ZBbus Compare Registers (Table 30)
+ * Registers: ZBBUS_CYCLE_CPx
+ *
+ * Same as BCM1250
+ */
+
+
+/*
+ * System Performance Counter Configuration Register (Table 31)
+ * Register: PERF_CNT_CFG_0
+ *
+ * Since the clear/enable bits are moved compared to the
+ * 1250 and there are more fields, this register will be BCM1480 specific.
+ */
+
+#define S_BCM1480_SPC_CFG_SRC0              0
+#define M_BCM1480_SPC_CFG_SRC0              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC0)
+#define V_BCM1480_SPC_CFG_SRC0(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC0)
+#define G_BCM1480_SPC_CFG_SRC0(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC0,M_BCM1480_SPC_CFG_SRC0)
+
+#define S_BCM1480_SPC_CFG_SRC1              8
+#define M_BCM1480_SPC_CFG_SRC1              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC1)
+#define V_BCM1480_SPC_CFG_SRC1(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC1)
+#define G_BCM1480_SPC_CFG_SRC1(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC1,M_BCM1480_SPC_CFG_SRC1)
+
+#define S_BCM1480_SPC_CFG_SRC2              16
+#define M_BCM1480_SPC_CFG_SRC2              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC2)
+#define V_BCM1480_SPC_CFG_SRC2(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC2)
+#define G_BCM1480_SPC_CFG_SRC2(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC2,M_BCM1480_SPC_CFG_SRC2)
+
+#define S_BCM1480_SPC_CFG_SRC3              24
+#define M_BCM1480_SPC_CFG_SRC3              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC3)
+#define V_BCM1480_SPC_CFG_SRC3(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC3)
+#define G_BCM1480_SPC_CFG_SRC3(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC3,M_BCM1480_SPC_CFG_SRC3)
+
+#define S_BCM1480_SPC_CFG_SRC4              32
+#define M_BCM1480_SPC_CFG_SRC4              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC4)
+#define V_BCM1480_SPC_CFG_SRC4(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC4)
+#define G_BCM1480_SPC_CFG_SRC4(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC4,M_BCM1480_SPC_CFG_SRC4)
+
+#define S_BCM1480_SPC_CFG_SRC5              40
+#define M_BCM1480_SPC_CFG_SRC5              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC5)
+#define V_BCM1480_SPC_CFG_SRC5(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC5)
+#define G_BCM1480_SPC_CFG_SRC5(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC5,M_BCM1480_SPC_CFG_SRC5)
+
+#define S_BCM1480_SPC_CFG_SRC6              48
+#define M_BCM1480_SPC_CFG_SRC6              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC6)
+#define V_BCM1480_SPC_CFG_SRC6(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC6)
+#define G_BCM1480_SPC_CFG_SRC6(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC6,M_BCM1480_SPC_CFG_SRC6)
+
+#define S_BCM1480_SPC_CFG_SRC7              56
+#define M_BCM1480_SPC_CFG_SRC7              _SB_MAKEMASK(8,S_BCM1480_SPC_CFG_SRC7)
+#define V_BCM1480_SPC_CFG_SRC7(x)           _SB_MAKEVALUE(x,S_BCM1480_SPC_CFG_SRC7)
+#define G_BCM1480_SPC_CFG_SRC7(x)           _SB_GETVALUE(x,S_BCM1480_SPC_CFG_SRC7,M_BCM1480_SPC_CFG_SRC7)
+
+/*
+ * System Performance Counter Control Register (Table 32)
+ * Register: PERF_CNT_CFG_1
+ * BCM1480 specific
+ */
+
+#define M_BCM1480_SPC_CFG_CLEAR             _SB_MAKEMASK1(0)
+#define M_BCM1480_SPC_CFG_ENABLE            _SB_MAKEMASK1(1)
+
+/*
+ * System Performance Counters (Table 33)
+ * Registers: PERF_CNT_x
+ */
+
+#define S_BCM1480_SPC_CNT_COUNT             0
+#define M_BCM1480_SPC_CNT_COUNT             _SB_MAKEMASK(40,S_BCM1480_SPC_CNT_COUNT)
+#define V_BCM1480_SPC_CNT_COUNT(x)          _SB_MAKEVALUE(x,S_BCM1480_SPC_CNT_COUNT)
+#define G_BCM1480_SPC_CNT_COUNT(x)          _SB_GETVALUE(x,S_BCM1480_SPC_CNT_COUNT,M_BCM1480_SPC_CNT_COUNT)
+
+#define M_BCM1480_SPC_CNT_OFLOW             _SB_MAKEMASK1(40)
+
+
+/*
+ * Bus Watcher Error Status Register (Tables 36, 37)
+ * Registers: BUS_ERR_STATUS, BUS_ERR_STATUS_DEBUG
+ * Same as BCM1250.
+ */
+
+/*
+ * Bus Watcher Error Data Registers (Table 38)
+ * Registers: BUS_ERR_DATA_x
+ * Same as BCM1250.
+ */
+
+/*
+ * Bus Watcher L2 ECC Counter Register (Table 39)
+ * Register: BUS_L2_ERRORS
+ * Same as BCM1250.
+ */
+
+
+/*
+ * Bus Watcher Memory and I/O Error Counter Register (Table 40)
+ * Register: BUS_MEM_IO_ERRORS
+ * Same as BCM1250.
+ */
+
+
+/*
+ * Address Trap Registers
+ *
+ * Register layout same as BCM1250, almost.  The bus agents
+ * are different, and the address trap configuration bits are
+ * slightly different.
+ */
+
+#define M_BCM1480_ATRAP_INDEX		  _SB_MAKEMASK(4,0)
+#define M_BCM1480_ATRAP_ADDRESS		  _SB_MAKEMASK(40,0)
+
+#define S_BCM1480_ATRAP_CFG_CNT            0
+#define M_BCM1480_ATRAP_CFG_CNT            _SB_MAKEMASK(3,S_BCM1480_ATRAP_CFG_CNT)
+#define V_BCM1480_ATRAP_CFG_CNT(x)         _SB_MAKEVALUE(x,S_BCM1480_ATRAP_CFG_CNT)
+#define G_BCM1480_ATRAP_CFG_CNT(x)         _SB_GETVALUE(x,S_BCM1480_ATRAP_CFG_CNT,M_BCM1480_ATRAP_CFG_CNT)
+
+#define M_BCM1480_ATRAP_CFG_WRITE	   _SB_MAKEMASK1(3)
+#define M_BCM1480_ATRAP_CFG_ALL	  	   _SB_MAKEMASK1(4)
+#define M_BCM1480_ATRAP_CFG_INV	   	   _SB_MAKEMASK1(5)
+#define M_BCM1480_ATRAP_CFG_USESRC	   _SB_MAKEMASK1(6)
+#define M_BCM1480_ATRAP_CFG_SRCINV	   _SB_MAKEMASK1(7)
+
+#define S_BCM1480_ATRAP_CFG_AGENTID     8
+#define M_BCM1480_ATRAP_CFG_AGENTID     _SB_MAKEMASK(4,S_BCM1480_ATRAP_CFG_AGENTID)
+#define V_BCM1480_ATRAP_CFG_AGENTID(x)  _SB_MAKEVALUE(x,S_BCM1480_ATRAP_CFG_AGENTID)
+#define G_BCM1480_ATRAP_CFG_AGENTID(x)  _SB_GETVALUE(x,S_BCM1480_ATRAP_CFG_AGENTID,M_BCM1480_ATRAP_CFG_AGENTID)
+
+
+#define K_BCM1480_BUS_AGENT_CPU0            0
+#define K_BCM1480_BUS_AGENT_CPU1            1
+#define K_BCM1480_BUS_AGENT_NC              2
+#define K_BCM1480_BUS_AGENT_IOB             3
+#define K_BCM1480_BUS_AGENT_SCD             4
+#define K_BCM1480_BUS_AGENT_L2C             6
+#define K_BCM1480_BUS_AGENT_MC              7
+#define K_BCM1480_BUS_AGENT_CPU2            8
+#define K_BCM1480_BUS_AGENT_CPU3            9
+#define K_BCM1480_BUS_AGENT_PM              10
+
+#define S_BCM1480_ATRAP_CFG_CATTR           12
+#define M_BCM1480_ATRAP_CFG_CATTR           _SB_MAKEMASK(2,S_BCM1480_ATRAP_CFG_CATTR)
+#define V_BCM1480_ATRAP_CFG_CATTR(x)        _SB_MAKEVALUE(x,S_BCM1480_ATRAP_CFG_CATTR)
+#define G_BCM1480_ATRAP_CFG_CATTR(x)        _SB_GETVALUE(x,S_BCM1480_ATRAP_CFG_CATTR,M_BCM1480_ATRAP_CFG_CATTR)
+
+#define K_BCM1480_ATRAP_CFG_CATTR_IGNORE    0
+#define K_BCM1480_ATRAP_CFG_CATTR_UNC       1
+#define K_BCM1480_ATRAP_CFG_CATTR_NONCOH    2
+#define K_BCM1480_ATRAP_CFG_CATTR_COHERENT  3
+
+#define M_BCM1480_ATRAP_CFG_CATTRINV        _SB_MAKEMASK1(14)
+
+
+/*
+ * Trace Event Registers (Table 47)
+ * Same as BCM1250.
+ */
+
+/*
+ * Trace Sequence Control Registers (Table 48)
+ * Registers: TRACE_SEQUENCE_x
+ *
+ * Same as BCM1250 except for two new fields.
+ */
+
+
+#define M_BCM1480_SCD_TRSEQ_TID_MATCH_EN    _SB_MAKEMASK1(25)
+
+#define S_BCM1480_SCD_TRSEQ_SWFUNC          26
+#define M_BCM1480_SCD_TRSEQ_SWFUNC          _SB_MAKEMASK(2,S_BCM1480_SCD_TRSEQ_SWFUNC)
+#define V_BCM1480_SCD_TRSEQ_SWFUNC(x)       _SB_MAKEVALUE(x,S_BCM1480_SCD_TRSEQ_SWFUNC)
+#define G_BCM1480_SCD_TRSEQ_SWFUNC(x)       _SB_GETVALUE(x,S_BCM1480_SCD_TRSEQ_SWFUNC,M_BCM1480_SCD_TRSEQ_SWFUNC)
+
+/*
+ * Trace Control Register (Table 49)
+ * Register: TRACE_CFG
+ *
+ * Bits 0..8 are the same as the BCM1250, rest are different.
+ * Entire register is redefined below.
+ */
+
+#define M_BCM1480_SCD_TRACE_CFG_RESET       _SB_MAKEMASK1(0)
+#define M_BCM1480_SCD_TRACE_CFG_START_READ  _SB_MAKEMASK1(1)
+#define M_BCM1480_SCD_TRACE_CFG_START       _SB_MAKEMASK1(2)
+#define M_BCM1480_SCD_TRACE_CFG_STOP        _SB_MAKEMASK1(3)
+#define M_BCM1480_SCD_TRACE_CFG_FREEZE      _SB_MAKEMASK1(4)
+#define M_BCM1480_SCD_TRACE_CFG_FREEZE_FULL _SB_MAKEMASK1(5)
+#define M_BCM1480_SCD_TRACE_CFG_DEBUG_FULL  _SB_MAKEMASK1(6)
+#define M_BCM1480_SCD_TRACE_CFG_FULL        _SB_MAKEMASK1(7)
+#define M_BCM1480_SCD_TRACE_CFG_FORCE_CNT   _SB_MAKEMASK1(8)
+
+#define S_BCM1480_SCD_TRACE_CFG_MODE        16
+#define M_BCM1480_SCD_TRACE_CFG_MODE        _SB_MAKEMASK(2,S_BCM1480_SCD_TRACE_CFG_MODE)
+#define V_BCM1480_SCD_TRACE_CFG_MODE(x)     _SB_MAKEVALUE(x,S_BCM1480_SCD_TRACE_CFG_MODE)
+#define G_BCM1480_SCD_TRACE_CFG_MODE(x)     _SB_GETVALUE(x,S_BCM1480_SCD_TRACE_CFG_MODE,M_BCM1480_SCD_TRACE_CFG_MODE)
+
+#define K_BCM1480_SCD_TRACE_CFG_MODE_BLOCKERS	0
+#define K_BCM1480_SCD_TRACE_CFG_MODE_BYTEEN_INT	1
+#define K_BCM1480_SCD_TRACE_CFG_MODE_FLOW_ID	2
+
+#define S_BCM1480_SCD_TRACE_CFG_CUR_ADDR    24
+#define M_BCM1480_SCD_TRACE_CFG_CUR_ADDR    _SB_MAKEMASK(8,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
+#define V_BCM1480_SCD_TRACE_CFG_CUR_ADDR(x) _SB_MAKEVALUE(x,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
+#define G_BCM1480_SCD_TRACE_CFG_CUR_ADDR(x) _SB_GETVALUE(x,S_BCM1480_SCD_TRACE_CFG_CUR_ADDR,M_BCM1480_SCD_TRACE_CFG_CUR_ADDR)
+
+#endif /* _BCM1480_SCD_H */
Index: lmo/include/asm-mips/sibyte/sb1250_defs.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_defs.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_defs.h	2005-10-19 22:34:11.000000000 -0700
@@ -97,13 +97,17 @@
     *  ordering, so be careful when adding support for new minor revs.
     ********************************************************************* */
 
-#define	SIBYTE_HDR_FMASK_1250_ALL		0x00000ff
-#define	SIBYTE_HDR_FMASK_1250_PASS1		0x0000001
-#define	SIBYTE_HDR_FMASK_1250_PASS2		0x0000002
-#define	SIBYTE_HDR_FMASK_1250_PASS3		0x0000004
-
-#define	SIBYTE_HDR_FMASK_112x_ALL		0x0000f00
-#define	SIBYTE_HDR_FMASK_112x_PASS1		0x0000100
+#define	SIBYTE_HDR_FMASK_1250_ALL		0x000000ff
+#define	SIBYTE_HDR_FMASK_1250_PASS1		0x00000001
+#define	SIBYTE_HDR_FMASK_1250_PASS2		0x00000002
+#define	SIBYTE_HDR_FMASK_1250_PASS3		0x00000004
+
+#define	SIBYTE_HDR_FMASK_112x_ALL		0x00000f00
+#define	SIBYTE_HDR_FMASK_112x_PASS1		0x00000100
+
+#define SIBYTE_HDR_FMASK_1480_ALL		0x0000f000
+#define SIBYTE_HDR_FMASK_1480_PASS1		0x00001000
+#define SIBYTE_HDR_FMASK_1480_PASS2		0x00002000
 
 /* Bit mask for chip/revision.  (use _ALL for all revisions of a chip).  */
 #define	SIBYTE_HDR_FMASK(chip, pass)					\
@@ -111,8 +115,17 @@
 #define	SIBYTE_HDR_FMASK_ALLREVS(chip)					\
     (SIBYTE_HDR_FMASK_ ## chip ## _ALL)
 
+/* Default constant value for all chips, all revisions */
 #define	SIBYTE_HDR_FMASK_ALL						\
+    (SIBYTE_HDR_FMASK_1250_ALL | SIBYTE_HDR_FMASK_112x_ALL		\
+     | SIBYTE_HDR_FMASK_1480_ALL)
+
+/* This one is used for the "original" BCM1250/BCM112x chips.  We use this
+   to weed out constants and macros that do not exist on later chips like
+   the BCM1480  */
+#define SIBYTE_HDR_FMASK_1250_112x_ALL					\
     (SIBYTE_HDR_FMASK_1250_ALL | SIBYTE_HDR_FMASK_112x_ALL)
+#define SIBYTE_HDR_FMASK_1250_112x SIBYTE_HDR_FMASK_1250_112x_ALL
 
 #ifndef SIBYTE_HDR_FEATURES
 #define	SIBYTE_HDR_FEATURES			SIBYTE_HDR_FMASK_ALL
@@ -133,6 +146,12 @@
 #define SIBYTE_HDR_FEATURE_CHIP(chip)					\
     (!! (SIBYTE_HDR_FMASK_ALLREVS(chip) & SIBYTE_HDR_FEATURES))
 
+/* True for all versions of the BCM1250 and BCM1125, but not true for
+   anything else */
+#define SIBYTE_HDR_FEATURE_1250_112x \
+      (SIBYTE_HDR_FEATURE_CHIP(1250) || SIBYTE_HDR_FEATURE_CHIP(112x))
+/*    (!!  (SIBYTE_HDR_FEATURES & SIBYHTE_HDR_FMASK_1250_112x)) */
+
 /* True if header features enabled for that rev or later, inclusive.  */
 #define SIBYTE_HDR_FEATURE(chip, pass)					\
     (!! ((SIBYTE_HDR_FMASK(chip, pass)					\
Index: lmo/include/asm-mips/sibyte/sb1250_dma.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_dma.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_dma.h	2005-10-19 22:34:11.000000000 -0700
@@ -58,17 +58,17 @@
 #define M_DMA_RESERVED1             _SB_MAKEMASK1(2)
 
 #define S_DMA_DESC_TYPE		    _SB_MAKE64(1)
-#define M_DMA_DESC_TYPE		    _SB_MAKE64(2,S_DMA_DESC_TYPE)
+#define M_DMA_DESC_TYPE		    _SB_MAKEMASK(2,S_DMA_DESC_TYPE)
 #define V_DMA_DESC_TYPE(x)          _SB_MAKEVALUE(x,S_DMA_DESC_TYPE)
 #define G_DMA_DESC_TYPE(x)          _SB_GETVALUE(x,S_DMA_DESC_TYPE,M_DMA_DESC_TYPE)
 
 #define K_DMA_DESC_TYPE_RING_AL		0
 #define K_DMA_DESC_TYPE_CHAIN_AL	1
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define K_DMA_DESC_TYPE_RING_UAL_WI	2
 #define K_DMA_DESC_TYPE_RING_UAL_RMW	3
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define M_DMA_EOP_INT_EN            _SB_MAKEMASK1(3)
 #define M_DMA_HWM_INT_EN            _SB_MAKEMASK1(4)
@@ -111,11 +111,11 @@
 #define M_DMA_NO_DSCR_UPDT          _SB_MAKEMASK1(4)
 #define M_DMA_L2CA		    _SB_MAKEMASK1(5)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_DMA_RX_XTRA_STATUS	    _SB_MAKEMASK1(6)
 #define M_DMA_TX_CPU_PAUSE	    _SB_MAKEMASK1(6)
 #define M_DMA_TX_FC_PAUSE_EN	    _SB_MAKEMASK1(7)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define M_DMA_MBZ1                  _SB_MAKEMASK(6,15)
 
@@ -165,14 +165,14 @@
 #define S_DMA_CURDSCR_COUNT         _SB_MAKE64(40)
 #define M_DMA_CURDSCR_COUNT         _SB_MAKEMASK(16,S_DMA_CURDSCR_COUNT)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_DMA_TX_CH_PAUSE_ON	    _SB_MAKEMASK1(56)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 /*
  * Receive Packet Drop Registers
  */
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_DMA_OODLOST_RX           _SB_MAKE64(0)
 #define M_DMA_OODLOST_RX           _SB_MAKEMASK(16,S_DMA_OODLOST_RX)
 #define G_DMA_OODLOST_RX(x)        _SB_GETVALUE(x,S_DMA_OODLOST_RX,M_DMA_OODLOST_RX)
@@ -180,7 +180,7 @@
 #define S_DMA_EOP_COUNT_RX         _SB_MAKE64(16)
 #define M_DMA_EOP_COUNT_RX         _SB_MAKEMASK(8,S_DMA_EOP_COUNT_RX)
 #define G_DMA_EOP_COUNT_RX(x)      _SB_GETVALUE(x,S_DMA_EOP_COUNT_RX,M_DMA_EOP_COUNT_RX)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 /*  *********************************************************************
     *  DMA Descriptors
@@ -201,21 +201,21 @@
 
 #define M_DMA_DSCRA_A_ADDR_OFFSET   (M_DMA_DSCRA_OFFSET | M_DMA_DSCRA_A_ADDR)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_DMA_DSCRA_A_ADDR_UA        _SB_MAKE64(0)
 #define M_DMA_DSCRA_A_ADDR_UA        _SB_MAKEMASK(40,S_DMA_DSCRA_A_ADDR_UA)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define S_DMA_DSCRA_A_SIZE          _SB_MAKE64(40)
 #define M_DMA_DSCRA_A_SIZE          _SB_MAKEMASK(9,S_DMA_DSCRA_A_SIZE)
 #define V_DMA_DSCRA_A_SIZE(x)       _SB_MAKEVALUE(x,S_DMA_DSCRA_A_SIZE)
 #define G_DMA_DSCRA_A_SIZE(x)       _SB_GETVALUE(x,S_DMA_DSCRA_A_SIZE,M_DMA_DSCRA_A_SIZE)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_DMA_DSCRA_DSCR_CNT	    _SB_MAKE64(40)
 #define M_DMA_DSCRA_DSCR_CNT	    _SB_MAKEMASK(8,S_DMA_DSCRA_DSCR_CNT)
 #define G_DMA_DSCRA_DSCR_CNT(x)	    _SB_GETVALUE(x,S_DMA_DSCRA_DSCR_CNT,M_DMA_DSCRA_DSCR_CNT)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define M_DMA_DSCRA_INTERRUPT       _SB_MAKEMASK1(49)
 #define M_DMA_DSCRA_OFFSETB	    _SB_MAKEMASK1(50)
@@ -235,12 +235,12 @@
 #define V_DMA_DSCRB_OPTIONS(x)      _SB_MAKEVALUE(x,S_DMA_DSCRB_OPTIONS)
 #define G_DMA_DSCRB_OPTIONS(x)      _SB_GETVALUE(x,S_DMA_DSCRB_OPTIONS,M_DMA_DSCRB_OPTIONS)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_DMA_DSCRB_A_SIZE        _SB_MAKE64(8)
 #define M_DMA_DSCRB_A_SIZE        _SB_MAKEMASK(14,S_DMA_DSCRB_A_SIZE)
 #define V_DMA_DSCRB_A_SIZE(x)     _SB_MAKEVALUE(x,S_DMA_DSCRB_A_SIZE)
 #define G_DMA_DSCRB_A_SIZE(x)     _SB_GETVALUE(x,S_DMA_DSCRB_A_SIZE,M_DMA_DSCRB_A_SIZE)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define R_DMA_DSCRB_ADDR            _SB_MAKE64(0x10)
 
@@ -255,12 +255,12 @@
 
 #define M_DMA_DSCRB_B_VALID         _SB_MAKEMASK1(49)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_DMA_DSCRB_PKT_SIZE_MSB    _SB_MAKE64(48)
 #define M_DMA_DSCRB_PKT_SIZE_MSB    _SB_MAKEMASK(2,S_DMA_DSCRB_PKT_SIZE_MSB)
 #define V_DMA_DSCRB_PKT_SIZE_MSB(x) _SB_MAKEVALUE(x,S_DMA_DSCRB_PKT_SIZE_MSB)
 #define G_DMA_DSCRB_PKT_SIZE_MSB(x) _SB_GETVALUE(x,S_DMA_DSCRB_PKT_SIZE_MSB,M_DMA_DSCRB_PKT_SIZE_MSB)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define S_DMA_DSCRB_PKT_SIZE        _SB_MAKE64(50)
 #define M_DMA_DSCRB_PKT_SIZE        _SB_MAKEMASK(14,S_DMA_DSCRB_PKT_SIZE)
@@ -282,15 +282,16 @@
 #define M_DMA_ETHRX_BADIP4CS        _SB_MAKEMASK1(51)
 #define M_DMA_ETHRX_DSCRERR	    _SB_MAKEMASK1(52)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
-/* Note: BADTCPCS is actually in DSCR_B options field */
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
+/* Note: This bit is in the DSCR_B options field */
 #define M_DMA_ETHRX_BADTCPCS	_SB_MAKEMASK1(0)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
+/* Note: These bits are in the DSCR_B options field */
 #define M_DMA_ETH_VLAN_FLAG	_SB_MAKEMASK1(1)
 #define M_DMA_ETH_CRC_FLAG	_SB_MAKEMASK1(2)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define S_DMA_ETHRX_RXCH            53
 #define M_DMA_ETHRX_RXCH            _SB_MAKEMASK(2,S_DMA_ETHRX_RXCH)
@@ -438,7 +439,7 @@
                                      M_DM_CUR_DSCR_DSCR_COUNT)
 
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 /*
  * Data Mover Channel Partial Result Registers
  * Register: DM_PARTIAL_0
@@ -459,10 +460,10 @@
                                        M_DM_PARTIAL_TCPCS_PARTIAL)
 
 #define M_DM_PARTIAL_ODD_BYTE         _SB_MAKEMASK1(48)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 /*
  * Data Mover CRC Definition Registers
  * Register: CRC_DEF_0
@@ -479,10 +480,10 @@
 #define V_CRC_DEF_CRC_POLY(r)         _SB_MAKEVALUE(r,S_CRC_DEF_CRC_POLY)
 #define G_CRC_DEF_CRC_POLY(r)         _SB_GETVALUE(r,S_CRC_DEF_CRC_POLY,\
                                        M_CRC_DEF_CRC_POLY)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 /*
  * Data Mover CRC/Checksum Definition Registers
  * Register: CTCP_DEF_0
@@ -511,7 +512,7 @@
 #define K_CTCP_DEF_CRC_WIDTH_1        2
 
 #define M_CTCP_DEF_CRC_BIT_ORDER      _SB_MAKEMASK1(50)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 
 /*
@@ -560,12 +561,12 @@
 #define M_DM_DSCRA_L2C_DEST         _SB_MAKEMASK1(50)
 #define M_DM_DSCRA_L2C_SRC          _SB_MAKEMASK1(51)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_DM_DSCRA_RD_BKOFF	    _SB_MAKEMASK1(52)
 #define M_DM_DSCRA_WR_BKOFF	    _SB_MAKEMASK1(53)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_DM_DSCRA_TCPCS_EN         _SB_MAKEMASK1(54)
 #define M_DM_DSCRA_TCPCS_RES        _SB_MAKEMASK1(55)
 #define M_DM_DSCRA_TCPCS_AP         _SB_MAKEMASK1(56)
@@ -574,7 +575,7 @@
 #define M_DM_DSCRA_CRC_AP           _SB_MAKEMASK1(59)
 #define M_DM_DSCRA_CRC_DFN          _SB_MAKEMASK1(60)
 #define M_DM_DSCRA_CRC_XBIT         _SB_MAKEMASK1(61)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define M_DM_DSCRA_RESERVED2        _SB_MAKEMASK(3,61)
 
Index: lmo/include/asm-mips/sibyte/sb1250_genbus.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_genbus.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_genbus.h	2005-10-19 22:34:11.000000000 -0700
@@ -51,19 +51,21 @@
 #define M_IO_WIDTH_SEL		_SB_MAKEMASK(2,S_IO_WIDTH_SEL)
 #define K_IO_WIDTH_SEL_1	0
 #define K_IO_WIDTH_SEL_2	1
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) \
+    || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define K_IO_WIDTH_SEL_1L       2
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 #define K_IO_WIDTH_SEL_4	3
 #define V_IO_WIDTH_SEL(x)	_SB_MAKEVALUE(x,S_IO_WIDTH_SEL)
 #define G_IO_WIDTH_SEL(x)	_SB_GETVALUE(x,S_IO_WIDTH_SEL,M_IO_WIDTH_SEL)
 
 #define S_IO_PARITY_ENA		4
 #define M_IO_PARITY_ENA		_SB_MAKEMASK1(S_IO_PARITY_ENA)
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) \
+    || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_IO_BURST_EN		5
 #define M_IO_BURST_EN		_SB_MAKEMASK1(S_IO_BURST_EN)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 #define S_IO_PARITY_ODD		6
 #define M_IO_PARITY_ODD		_SB_MAKEMASK1(S_IO_PARITY_ODD)
 #define S_IO_NONMUX		7
@@ -96,8 +98,11 @@
 
 #define S_IO_ADDRBASE		16	 /* # bits to shift addr for this reg */
 
+#define M_IO_BLK_CACHE		_SB_MAKEMASK1(15)
+
+
 /*
- * Generic Bus Region 0 Timing Registers (Table 11-7)
+ * Generic Bus Timing 0 Registers (Table 11-7)
  */
 
 #define S_IO_ALE_WIDTH		0
@@ -105,21 +110,23 @@
 #define V_IO_ALE_WIDTH(x)	_SB_MAKEVALUE(x,S_IO_ALE_WIDTH)
 #define G_IO_ALE_WIDTH(x)	_SB_GETVALUE(x,S_IO_ALE_WIDTH,M_IO_ALE_WIDTH)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) \
+    || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_IO_EARLY_CS	        _SB_MAKEMASK1(3)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 #define S_IO_ALE_TO_CS		4
 #define M_IO_ALE_TO_CS		_SB_MAKEMASK(2,S_IO_ALE_TO_CS)
 #define V_IO_ALE_TO_CS(x)	_SB_MAKEVALUE(x,S_IO_ALE_TO_CS)
 #define G_IO_ALE_TO_CS(x)	_SB_GETVALUE(x,S_IO_ALE_TO_CS,M_IO_ALE_TO_CS)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) \
+    || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_IO_BURST_WIDTH           _SB_MAKE64(6)
 #define M_IO_BURST_WIDTH           _SB_MAKEMASK(2,S_IO_BURST_WIDTH)
 #define V_IO_BURST_WIDTH(x)        _SB_MAKEVALUE(x,S_IO_BURST_WIDTH)
 #define G_IO_BURST_WIDTH(x)        _SB_GETVALUE(x,S_IO_BURST_WIDTH,M_IO_BURST_WIDTH)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 #define S_IO_CS_WIDTH		8
 #define M_IO_CS_WIDTH		_SB_MAKEMASK(5,S_IO_CS_WIDTH)
@@ -141,9 +148,10 @@
 #define V_IO_ALE_TO_WRITE(x)	_SB_MAKEVALUE(x,S_IO_ALE_TO_WRITE)
 #define G_IO_ALE_TO_WRITE(x)	_SB_GETVALUE(x,S_IO_ALE_TO_WRITE,M_IO_ALE_TO_WRITE)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) \
+    || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_IO_RDY_SYNC	        _SB_MAKEMASK1(3)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 #define S_IO_WRITE_WIDTH	4
 #define M_IO_WRITE_WIDTH	_SB_MAKEMASK(4,S_IO_WRITE_WIDTH)
@@ -183,9 +191,127 @@
 #define M_IO_TIMEOUT_INT	_SB_MAKEMASK1(10)
 #define M_IO_ILL_ADDR_INT	_SB_MAKEMASK1(11)
 #define M_IO_MULT_CS_INT	_SB_MAKEMASK1(12)
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_IO_COH_ERR	        _SB_MAKEMASK1(14)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
+
+
+/*
+ * Generic Bus Output Drive Control Register 0 (Table 14-18)
+ */
+
+#define S_IO_SLEW0		0
+#define M_IO_SLEW0		_SB_MAKEMASK(2,S_IO_SLEW0)
+#define V_IO_SLEW0(x)		_SB_MAKEVALUE(x,S_IO_SLEW0)
+#define G_IO_SLEW0(x)		_SB_GETVALUE(x,S_IO_SLEW0,M_IO_SLEW0)
+
+#define S_IO_DRV_A		2
+#define M_IO_DRV_A		_SB_MAKEMASK(2,S_IO_DRV_A)
+#define V_IO_DRV_A(x)		_SB_MAKEVALUE(x,S_IO_DRV_A)
+#define G_IO_DRV_A(x)		_SB_GETVALUE(x,S_IO_DRV_A,M_IO_DRV_A)
+
+#define S_IO_DRV_B		6
+#define M_IO_DRV_B		_SB_MAKEMASK(2,S_IO_DRV_B)
+#define V_IO_DRV_B(x)		_SB_MAKEVALUE(x,S_IO_DRV_B)
+#define G_IO_DRV_B(x)		_SB_GETVALUE(x,S_IO_DRV_B,M_IO_DRV_B)
+
+#define S_IO_DRV_C		10
+#define M_IO_DRV_C		_SB_MAKEMASK(2,S_IO_DRV_C)
+#define V_IO_DRV_C(x)		_SB_MAKEVALUE(x,S_IO_DRV_C)
+#define G_IO_DRV_C(x)		_SB_GETVALUE(x,S_IO_DRV_C,M_IO_DRV_C)
+
+#define S_IO_DRV_D		14
+#define M_IO_DRV_D		_SB_MAKEMASK(2,S_IO_DRV_D)
+#define V_IO_DRV_D(x)		_SB_MAKEVALUE(x,S_IO_DRV_D)
+#define G_IO_DRV_D(x)		_SB_GETVALUE(x,S_IO_DRV_D,M_IO_DRV_D)
+
+/*
+ * Generic Bus Output Drive Control Register 1 (Table 14-19)
+ */
+
+#define S_IO_DRV_E		2
+#define M_IO_DRV_E		_SB_MAKEMASK(2,S_IO_DRV_E)
+#define V_IO_DRV_E(x)		_SB_MAKEVALUE(x,S_IO_DRV_E)
+#define G_IO_DRV_E(x)		_SB_GETVALUE(x,S_IO_DRV_E,M_IO_DRV_E)
+
+#define S_IO_DRV_F		6
+#define M_IO_DRV_F		_SB_MAKEMASK(2,S_IO_DRV_F)
+#define V_IO_DRV_F(x)		_SB_MAKEVALUE(x,S_IO_DRV_F)
+#define G_IO_DRV_F(x)		_SB_GETVALUE(x,S_IO_DRV_F,M_IO_DRV_F)
+
+#define S_IO_SLEW1		8
+#define M_IO_SLEW1		_SB_MAKEMASK(2,S_IO_SLEW1)
+#define V_IO_SLEW1(x)		_SB_MAKEVALUE(x,S_IO_SLEW1)
+#define G_IO_SLEW1(x)		_SB_GETVALUE(x,S_IO_SLEW1,M_IO_SLEW1)
+
+#define S_IO_DRV_G		10
+#define M_IO_DRV_G		_SB_MAKEMASK(2,S_IO_DRV_G)
+#define V_IO_DRV_G(x)		_SB_MAKEVALUE(x,S_IO_DRV_G)
+#define G_IO_DRV_G(x)		_SB_GETVALUE(x,S_IO_DRV_G,M_IO_DRV_G)
+
+#define S_IO_SLEW2		12
+#define M_IO_SLEW2		_SB_MAKEMASK(2,S_IO_SLEW2)
+#define V_IO_SLEW2(x)		_SB_MAKEVALUE(x,S_IO_SLEW2)
+#define G_IO_SLEW2(x)		_SB_GETVALUE(x,S_IO_SLEW2,M_IO_SLEW2)
+
+#define S_IO_DRV_H		14
+#define M_IO_DRV_H		_SB_MAKEMASK(2,S_IO_DRV_H)
+#define V_IO_DRV_H(x)		_SB_MAKEVALUE(x,S_IO_DRV_H)
+#define G_IO_DRV_H(x)		_SB_GETVALUE(x,S_IO_DRV_H,M_IO_DRV_H)
+
+/*
+ * Generic Bus Output Drive Control Register 2 (Table 14-20)
+ */
+
+#define S_IO_DRV_J		2
+#define M_IO_DRV_J		_SB_MAKEMASK(2,S_IO_DRV_J)
+#define V_IO_DRV_J(x)		_SB_MAKEVALUE(x,S_IO_DRV_J)
+#define G_IO_DRV_J(x)		_SB_GETVALUE(x,S_IO_DRV_J,M_IO_DRV_J)
+
+#define S_IO_DRV_K		6
+#define M_IO_DRV_K		_SB_MAKEMASK(2,S_IO_DRV_K)
+#define V_IO_DRV_K(x)		_SB_MAKEVALUE(x,S_IO_DRV_K)
+#define G_IO_DRV_K(x)		_SB_GETVALUE(x,S_IO_DRV_K,M_IO_DRV_K)
+
+#define S_IO_DRV_L		10
+#define M_IO_DRV_L		_SB_MAKEMASK(2,S_IO_DRV_L)
+#define V_IO_DRV_L(x)		_SB_MAKEVALUE(x,S_IO_DRV_L)
+#define G_IO_DRV_L(x)		_SB_GETVALUE(x,S_IO_DRV_L,M_IO_DRV_L)
+
+#define S_IO_DRV_M		14
+#define M_IO_DRV_M		_SB_MAKEMASK(2,S_IO_DRV_M)
+#define V_IO_DRV_M(x)		_SB_MAKEVALUE(x,S_IO_DRV_M)
+#define G_IO_DRV_M(x)		_SB_GETVALUE(x,S_IO_DRV_M,M_IO_DRV_M)
+
+/*
+ * Generic Bus Output Drive Control Register 3 (Table 14-21)
+ */
+
+#define S_IO_SLEW3		0
+#define M_IO_SLEW3		_SB_MAKEMASK(2,S_IO_SLEW3)
+#define V_IO_SLEW3(x)		_SB_MAKEVALUE(x,S_IO_SLEW3)
+#define G_IO_SLEW3(x)		_SB_GETVALUE(x,S_IO_SLEW3,M_IO_SLEW3)
+
+#define S_IO_DRV_N		2
+#define M_IO_DRV_N		_SB_MAKEMASK(2,S_IO_DRV_N)
+#define V_IO_DRV_N(x)		_SB_MAKEVALUE(x,S_IO_DRV_N)
+#define G_IO_DRV_N(x)		_SB_GETVALUE(x,S_IO_DRV_N,M_IO_DRV_N)
+
+#define S_IO_DRV_P		6
+#define M_IO_DRV_P		_SB_MAKEMASK(2,S_IO_DRV_P)
+#define V_IO_DRV_P(x)		_SB_MAKEVALUE(x,S_IO_DRV_P)
+#define G_IO_DRV_P(x)		_SB_GETVALUE(x,S_IO_DRV_P,M_IO_DRV_P)
+
+#define S_IO_DRV_Q		10
+#define M_IO_DRV_Q		_SB_MAKEMASK(2,S_IO_DRV_Q)
+#define V_IO_DRV_Q(x)		_SB_MAKEVALUE(x,S_IO_DRV_Q)
+#define G_IO_DRV_Q(x)		_SB_GETVALUE(x,S_IO_DRV_Q,M_IO_DRV_Q)
+
+#define S_IO_DRV_R		14
+#define M_IO_DRV_R		_SB_MAKEMASK(2,S_IO_DRV_R)
+#define V_IO_DRV_R(x)		_SB_MAKEVALUE(x,S_IO_DRV_R)
+#define G_IO_DRV_R(x)		_SB_GETVALUE(x,S_IO_DRV_R,M_IO_DRV_R)
+
 
 /*
  * PCMCIA configuration register (Table 12-6)
@@ -202,6 +328,22 @@
 #define M_PCMCIA_CFG_RDYMASK	_SB_MAKEMASK1(8)
 #define M_PCMCIA_CFG_PWRCTL	_SB_MAKEMASK1(9)
 
+#if SIBYTE_HDR_FEATURE_CHIP(1480)
+#define S_PCMCIA_MODE		16
+#define M_PCMCIA_MODE		_SB_MAKEMASK(3,S_PCMCIA_MODE)
+#define V_PCMCIA_MODE(x)	_SB_MAKEVALUE(x,S_PCMCIA_MODE)
+#define G_PCMCIA_MODE(x)	_SB_GETVALUE(x,S_PCMCIA_MODE,M_PCMCIA_MODE)
+
+#define K_PCMCIA_MODE_PCMA_NOB	0	/* standard PCMCIA "A", no "B" */
+#define K_PCMCIA_MODE_IDEA_NOB	1	/* IDE "A", no "B" */
+#define K_PCMCIA_MODE_PCMIOA_NOB 2	/* PCMCIA with I/O "A", no "B" */
+#define K_PCMCIA_MODE_PCMA_PCMB 4	/* standard PCMCIA "A", standard PCMCIA "B" */
+#define K_PCMCIA_MODE_IDEA_PCMB 5	/* IDE "A", standard PCMCIA "B" */
+#define K_PCMCIA_MODE_PCMA_IDEB 6	/* standard PCMCIA "A", IDE "B" */
+#define K_PCMCIA_MODE_IDEA_IDEB 7	/* IDE "A", IDE "B" */
+#endif
+
+
 /*
  * PCMCIA status register (Table 12-7)
  */
@@ -272,5 +414,62 @@
 #define V_GPIO_INTR_TYPE14(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_TYPE14)
 #define G_GPIO_INTR_TYPE14(x)	_SB_GETVALUE(x,S_GPIO_INTR_TYPE14,M_GPIO_INTR_TYPE14)
 
+#if SIBYTE_HDR_FEATURE_CHIP(1480)
+
+/*
+ * GPIO Interrupt Additional Type Register
+ */
+
+#define K_GPIO_INTR_BOTHEDGE	0
+#define K_GPIO_INTR_RISEEDGE	1
+#define K_GPIO_INTR_UNPRED1	2
+#define K_GPIO_INTR_UNPRED2	3
+
+#define S_GPIO_INTR_ATYPEX(n)	(((n)/2)*2)
+#define M_GPIO_INTR_ATYPEX(n)	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPEX(n))
+#define V_GPIO_INTR_ATYPEX(n,x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPEX(n))
+#define G_GPIO_INTR_ATYPEX(n,x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPEX(n),M_GPIO_INTR_ATYPEX(n))
+
+#define S_GPIO_INTR_ATYPE0	0
+#define M_GPIO_INTR_ATYPE0	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE0)
+#define V_GPIO_INTR_ATYPE0(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE0)
+#define G_GPIO_INTR_ATYPE0(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE0,M_GPIO_INTR_ATYPE0)
+
+#define S_GPIO_INTR_ATYPE2	2
+#define M_GPIO_INTR_ATYPE2	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE2)
+#define V_GPIO_INTR_ATYPE2(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE2)
+#define G_GPIO_INTR_ATYPE2(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE2,M_GPIO_INTR_ATYPE2)
+
+#define S_GPIO_INTR_ATYPE4	4
+#define M_GPIO_INTR_ATYPE4	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE4)
+#define V_GPIO_INTR_ATYPE4(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE4)
+#define G_GPIO_INTR_ATYPE4(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE4,M_GPIO_INTR_ATYPE4)
+
+#define S_GPIO_INTR_ATYPE6	6
+#define M_GPIO_INTR_ATYPE6	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE6)
+#define V_GPIO_INTR_ATYPE6(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE6)
+#define G_GPIO_INTR_ATYPE6(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE6,M_GPIO_INTR_ATYPE6)
+
+#define S_GPIO_INTR_ATYPE8	8
+#define M_GPIO_INTR_ATYPE8	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE8)
+#define V_GPIO_INTR_ATYPE8(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE8)
+#define G_GPIO_INTR_ATYPE8(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE8,M_GPIO_INTR_ATYPE8)
+
+#define S_GPIO_INTR_ATYPE10	10
+#define M_GPIO_INTR_ATYPE10	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE10)
+#define V_GPIO_INTR_ATYPE10(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE10)
+#define G_GPIO_INTR_ATYPE10(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE10,M_GPIO_INTR_ATYPE10)
+
+#define S_GPIO_INTR_ATYPE12	12
+#define M_GPIO_INTR_ATYPE12	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE12)
+#define V_GPIO_INTR_ATYPE12(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE12)
+#define G_GPIO_INTR_ATYPE12(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE12,M_GPIO_INTR_ATYPE12)
+
+#define S_GPIO_INTR_ATYPE14	14
+#define M_GPIO_INTR_ATYPE14	_SB_MAKEMASK(2,S_GPIO_INTR_ATYPE14)
+#define V_GPIO_INTR_ATYPE14(x)	_SB_MAKEVALUE(x,S_GPIO_INTR_ATYPE14)
+#define G_GPIO_INTR_ATYPE14(x)	_SB_GETVALUE(x,S_GPIO_INTR_ATYPE14,M_GPIO_INTR_ATYPE14)
+#endif
+
 
 #endif
Index: lmo/include/asm-mips/sibyte/sb1250_int.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_int.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_int.h	2005-10-19 22:34:11.000000000 -0700
@@ -47,6 +47,10 @@
  * First, the interrupt numbers.
  */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
+
+#define K_INT_SOURCES               64
+
 #define K_INT_WATCHDOG_TIMER_0      0
 #define K_INT_WATCHDOG_TIMER_1      1
 #define K_INT_TIMER_0               2
@@ -244,4 +248,6 @@
 #define M_LDTVECT_RAISEMBOX             0x40
 
 
+#endif	/* 1250/112x */
+
 #endif
Index: lmo/include/asm-mips/sibyte/sb1250_l2c.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_l2c.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_l2c.h	2005-10-19 22:34:11.000000000 -0700
@@ -89,8 +89,13 @@
 #define V_L2C_MGMT_WAY(x)           _SB_MAKEVALUE(x,S_L2C_MGMT_WAY)
 #define G_L2C_MGMT_WAY(x)           _SB_GETVALUE(x,S_L2C_MGMT_WAY,M_L2C_MGMT_WAY)
 
-#define S_L2C_MGMT_TAG              21
-#define M_L2C_MGMT_TAG              _SB_MAKEMASK(6,S_L2C_MGMT_TAG)
+#define S_L2C_MGMT_ECC_DIAG         21
+#define M_L2C_MGMT_ECC_DIAG         _SB_MAKEMASK(2,S_L2C_MGMT_ECC_DIAG)
+#define V_L2C_MGMT_ECC_DIAG(x)      _SB_MAKEVALUE(x,S_L2C_MGMT_ECC_DIAG)
+#define G_L2C_MGMT_ECC_DIAG(x)      _SB_GETVALUE(x,S_L2C_MGMT_ECC_DIAG,M_L2C_MGMT_ECC_DIAG)
+
+#define S_L2C_MGMT_TAG              23
+#define M_L2C_MGMT_TAG              _SB_MAKEMASK(4,S_L2C_MGMT_TAG)
 #define V_L2C_MGMT_TAG(x)           _SB_MAKEVALUE(x,S_L2C_MGMT_TAG)
 #define G_L2C_MGMT_TAG(x)           _SB_GETVALUE(x,S_L2C_MGMT_TAG,M_L2C_MGMT_TAG)
 
Index: lmo/include/asm-mips/sibyte/sb1250_mac.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_mac.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_mac.h	2005-10-19 22:34:11.000000000 -0700
@@ -81,7 +81,10 @@
 #define M_MAC_RESERVED1             _SB_MAKEMASK(8,9)
 
 #define M_MAC_AP_STAT_EN            _SB_MAKEMASK1(17)
-#define M_MAC_RESERVED2		    _SB_MAKEMASK1(18)
+
+#if SIBYTE_HDR_FEATURE_CHIP(1480)
+#define M_MAC_TIMESTAMP		    _SB_MAKEMASK1(18)
+#endif
 #define M_MAC_DRP_ERRPKT_EN         _SB_MAKEMASK1(19)
 #define M_MAC_DRP_FCSERRPKT_EN      _SB_MAKEMASK1(20)
 #define M_MAC_DRP_CODEERRPKT_EN     _SB_MAKEMASK1(21)
@@ -132,9 +135,9 @@
 #define M_MAC_RX_CH_SEL_MSB	    _SB_MAKEMASK1(44)
 #endif /* 1250 PASS2 || 112x PASS1 */
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_SPLIT_CH_SEL	    _SB_MAKEMASK1(45)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define S_MAC_BYPASS_IFG            _SB_MAKE64(46)
 #define M_MAC_BYPASS_IFG            _SB_MAKEMASK(8,S_MAC_BYPASS_IFG)
@@ -176,10 +179,22 @@
 
 #define M_MAC_PORT_RESET            _SB_MAKEMASK1(8)
 
+#if (SIBYTE_HDR_FEATURE_CHIP(1250) || SIBYTE_HDR_FEATURE_CHIP(112x))
 #define M_MAC_RX_ENABLE             _SB_MAKEMASK1(10)
 #define M_MAC_TX_ENABLE             _SB_MAKEMASK1(11)
 #define M_MAC_BYP_RX_ENABLE         _SB_MAKEMASK1(12)
 #define M_MAC_BYP_TX_ENABLE         _SB_MAKEMASK1(13)
+#endif
+
+/*
+ * MAC reset information register (1280/1255)
+ */
+#if SIBYTE_HDR_FEATURE_CHIP(1480)
+#define M_MAC_RX_CH0_PAUSE_ON	_SB_MAKEMASK1(8)
+#define M_MAC_RX_CH1_PAUSE_ON	_SB_MAKEMASK1(16)
+#define M_MAC_TX_CH0_PAUSE_ON	_SB_MAKEMASK1(24)
+#define M_MAC_TX_CH1_PAUSE_ON	_SB_MAKEMASK1(32)
+#endif
 
 /*
  * MAC DMA Control Register
@@ -267,12 +282,12 @@
 #define V_MAC_IFG_RX(x)             _SB_MAKEVALUE(x,S_MAC_IFG_RX)
 #define G_MAC_IFG_RX(x)             _SB_GETVALUE(x,S_MAC_IFG_RX,M_MAC_IFG_RX)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_MAC_PRE_LEN               _SB_MAKE64(0)
 #define M_MAC_PRE_LEN               _SB_MAKEMASK(6,S_MAC_PRE_LEN)
 #define V_MAC_PRE_LEN(x)            _SB_MAKEVALUE(x,S_MAC_PRE_LEN)
 #define G_MAC_PRE_LEN(x)            _SB_GETVALUE(x,S_MAC_PRE_LEN,M_MAC_PRE_LEN)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 #define S_MAC_IFG_TX                _SB_MAKE64(6)
 #define M_MAC_IFG_TX                _SB_MAKEMASK(6,S_MAC_IFG_TX)
@@ -458,9 +473,9 @@
 #define V_MAC_COUNTER_ADDR(x)       _SB_MAKEVALUE(x,S_MAC_COUNTER_ADDR)
 #define G_MAC_COUNTER_ADDR(x)       _SB_GETVALUE(x,S_MAC_COUNTER_ADDR,M_MAC_COUNTER_ADDR)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define M_MAC_TX_PAUSE_ON	    _SB_MAKEMASK1(52)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 /*
  * MAC Fifo Pointer Registers (Table 9-19)    [Debug register]
@@ -594,7 +609,7 @@
 #define V_MAC_IPHDR_OFFSET(x)	_SB_MAKEVALUE(x,S_MAC_IPHDR_OFFSET)
 #define G_MAC_IPHDR_OFFSET(x)	_SB_GETVALUE(x,S_MAC_IPHDR_OFFSET,M_MAC_IPHDR_OFFSET)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define S_MAC_RX_CRC_OFFSET     _SB_MAKE64(16)
 #define M_MAC_RX_CRC_OFFSET     _SB_MAKEMASK(8,S_MAC_RX_CRC_OFFSET)
 #define V_MAC_RX_CRC_OFFSET(x)	_SB_MAKEVALUE(x,S_MAC_RX_CRC_OFFSET)
@@ -612,7 +627,7 @@
 #define M_MAC_RX_CH_MSN_SEL     _SB_MAKEMASK(8,S_MAC_RX_CH_MSN_SEL)
 #define V_MAC_RX_CH_MSN_SEL(x)	_SB_MAKEVALUE(x,S_MAC_RX_CH_MSN_SEL)
 #define G_MAC_RX_CH_MSN_SEL(x)	_SB_GETVALUE(x,S_MAC_RX_CH_MSN_SEL,M_MAC_RX_CH_MSN_SEL)
-#endif /* 1250 PASS3 || 112x PASS1 */
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
 
 /*
  * MAC Receive Channel Select Registers (Table 9-25)
Index: lmo/include/asm-mips/sibyte/sb1250_regs.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_regs.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_regs.h	2005-10-19 22:34:11.000000000 -0700
@@ -61,6 +61,8 @@
  * XXX: can't remove MC base 0 if 112x, since it's used by other macros,
  * since there is one reg there (but it could get its addr/offset constant).
  */
+
+#if SIBYTE_HDR_FEATURE_1250_112x		/* This MC only on 1250 & 112x */
 #define A_MC_BASE_0                 0x0010051000
 #define A_MC_BASE_1                 0x0010052000
 #define MC_REGISTER_SPACING         0x1000
@@ -101,10 +103,14 @@
 #define R_MC_TEST_ECC               0x0000000420
 #define R_MC_MCLK_CFG               0x0000000500
 
+#endif	/* 1250 & 112x */
+
 /*  *********************************************************************
     * L2 Cache Control Registers
     ********************************************************************* */
 
+#if SIBYTE_HDR_FEATURE_1250_112x	/* This L2C only on 1250/112x */
+
 #define A_L2_READ_TAG               0x0010040018
 #define A_L2_ECC_TAG                0x0010040038
 #if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1)
@@ -125,13 +131,16 @@
 #define A_L2_READ_ADDRESS           A_L2_READ_TAG
 #define A_L2_EEC_ADDRESS            A_L2_ECC_TAG
 
+#endif
 
 /*  *********************************************************************
     * PCI Interface Registers
     ********************************************************************* */
 
+#if SIBYTE_HDR_FEATURE_1250_112x	/* This PCI/HT only on 1250/112x */
 #define A_PCI_TYPE00_HEADER         0x00DE000000
 #define A_PCI_TYPE01_HEADER         0x00DE000800
+#endif
 
 
 /*  *********************************************************************
@@ -264,15 +273,15 @@
     ********************************************************************* */
 
 
+#if SIBYTE_HDR_FEATURE_1250_112x		/* This MC only on 1250 & 112x */
 #define R_DUART_NUM_PORTS           2
 
 #define A_DUART                     0x0010060000
 
-#define A_DUART_REG(r)
-
 #define DUART_CHANREG_SPACING       0x100
 #define A_DUART_CHANREG(chan,reg)   (A_DUART + DUART_CHANREG_SPACING*(chan) + (reg))
 #define R_DUART_CHANREG(chan,reg)   (DUART_CHANREG_SPACING*(chan) + (reg))
+#endif	/* 1250 & 112x */
 
 #define R_DUART_MODE_REG_1	    0x100
 #define R_DUART_MODE_REG_2	    0x110
@@ -307,11 +316,13 @@
 
 #define DUART_IMRISR_SPACING        0x20
 
+#if SIBYTE_HDR_FEATURE_1250_112x		/* This MC only on 1250 & 112x */
 #define R_DUART_IMRREG(chan)	    (R_DUART_IMR_A + (chan)*DUART_IMRISR_SPACING)
 #define R_DUART_ISRREG(chan)	    (R_DUART_ISR_A + (chan)*DUART_IMRISR_SPACING)
 
 #define A_DUART_IMRREG(chan)	    (A_DUART + R_DUART_IMRREG(chan))
 #define A_DUART_ISRREG(chan)	    (A_DUART + R_DUART_ISRREG(chan))
+#endif	/* 1250 & 112x */
 
 
 
@@ -368,6 +379,8 @@
     ********************************************************************* */
 
 
+#if SIBYTE_HDR_FEATURE_1250_112x	/* sync serial only on 1250/112x */
+
 #define A_SER_BASE_0                0x0010060400
 #define A_SER_BASE_1                0x0010060800
 #define SER_SPACING                 0x400
@@ -457,6 +470,8 @@
 #define R_SER_RMON_RX_ERRORS        0x000001F0
 #define R_SER_RMON_RX_BADADDR       0x000001F8
 
+#endif	/* 1250/112x */
+
 /*  *********************************************************************
     * Generic Bus Registers
     ********************************************************************* */
@@ -634,12 +649,13 @@
 
 #if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
 #define A_SCD_SCRATCH		   0x0010020C10
+#endif /* 1250 PASS2 || 112x PASS1 */
 
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define A_SCD_ZBBUS_CYCLE_COUNT	   0x0010030000
 #define A_SCD_ZBBUS_CYCLE_CP0	   0x0010020C00
 #define A_SCD_ZBBUS_CYCLE_CP1	   0x0010020C08
-#endif /* 1250 PASS2 || 112x PASS1 */
-
+#endif
 
 /*  *********************************************************************
     * System Control Registers
@@ -667,15 +683,16 @@
 #define A_ADDR_TRAP_CFG_1           0x0010020448
 #define A_ADDR_TRAP_CFG_2           0x0010020450
 #define A_ADDR_TRAP_CFG_3           0x0010020458
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 #define A_ADDR_TRAP_REG_DEBUG	    0x0010020460
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 
 /*  *********************************************************************
     * System Interrupt Mapper Registers
     ********************************************************************* */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define A_IMR_CPU0_BASE                 0x0010020000
 #define A_IMR_CPU1_BASE                 0x0010022000
 #define IMR_REGISTER_SPACING            0x2000
@@ -700,6 +717,7 @@
 #define R_IMR_INTERRUPT_STATUS_COUNT    7
 #define R_IMR_INTERRUPT_MAP_BASE        0x0200
 #define R_IMR_INTERRUPT_MAP_COUNT       64
+#endif	/* 1250/112x */
 
 /*  *********************************************************************
     * System Performance Counter Registers
@@ -718,6 +736,7 @@
 #define A_SCD_BUS_ERR_STATUS        0x0010020880
 #if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
 #define A_SCD_BUS_ERR_STATUS_DEBUG  0x00100208D0
+#define A_BUS_ERR_STATUS_DEBUG  0x00100208D0
 #endif /* 1250 PASS2 || 112x PASS1 */
 #define A_BUS_ERR_DATA_0            0x00100208A0
 #define A_BUS_ERR_DATA_1            0x00100208A8
@@ -798,6 +817,7 @@
     *  Physical Address Map
     ********************************************************************* */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define A_PHYS_MEMORY_0                 _SB_MAKE64(0x0000000000)
 #define A_PHYS_MEMORY_SIZE              _SB_MAKE64((256*1024*1024))
 #define A_PHYS_SYSTEM_CTL               _SB_MAKE64(0x0010000000)
@@ -831,6 +851,7 @@
 #define A_PHYS_L2CACHE_WAY1             _SB_MAKE64(0x00D01A0000)
 #define A_PHYS_L2CACHE_WAY2             _SB_MAKE64(0x00D01C0000)
 #define A_PHYS_L2CACHE_WAY3             _SB_MAKE64(0x00D01E0000)
+#endif
 
 
 #endif
Index: lmo/include/asm-mips/sibyte/sb1250_scd.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_scd.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_scd.h	2005-10-19 22:34:11.000000000 -0700
@@ -51,26 +51,70 @@
 #define V_SYS_REVISION(x)           _SB_MAKEVALUE(x,S_SYS_REVISION)
 #define G_SYS_REVISION(x)           _SB_GETVALUE(x,S_SYS_REVISION,M_SYS_REVISION)
 
-#if SIBYTE_HDR_FEATURE_CHIP(1250)
-#define K_SYS_REVISION_BCM1250_PASS1	1
-#define K_SYS_REVISION_BCM1250_PASS2	3
-#define K_SYS_REVISION_BCM1250_A10	11
-#define K_SYS_REVISION_BCM1250_PASS2_2	16
-#define K_SYS_REVISION_BCM1250_B2	17
-#define K_SYS_REVISION_BCM1250_PASS3	32
-#define K_SYS_REVISION_BCM1250_C1	33
+#define K_SYS_REVISION_BCM1250_PASS1	0x01
+
+#define K_SYS_REVISION_BCM1250_PASS2	0x03
+#define K_SYS_REVISION_BCM1250_A1	0x03	/* Pass 2.0 WB */
+#define K_SYS_REVISION_BCM1250_A2	0x04	/* Pass 2.0 FC */
+#define K_SYS_REVISION_BCM1250_A3	0x05	/* Pass 2.1 FC */
+#define K_SYS_REVISION_BCM1250_A4	0x06	/* Pass 2.1 WB */
+#define K_SYS_REVISION_BCM1250_A6	0x07	/* OR 0x04 (A2) w/WID != 0 */
+#define K_SYS_REVISION_BCM1250_A8	0x0b	/* A8/A10 */
+#define K_SYS_REVISION_BCM1250_A9	0x08
+#define K_SYS_REVISION_BCM1250_A10	K_SYS_REVISION_BCM1250_A8
+
+#define K_SYS_REVISION_BCM1250_PASS2_2	0x10
+#define K_SYS_REVISION_BCM1250_B0	K_SYS_REVISION_BCM1250_B1
+#define K_SYS_REVISION_BCM1250_B1	0x10
+#define K_SYS_REVISION_BCM1250_B2	0x11
+
+#define K_SYS_REVISION_BCM1250_C0	0x20
+#define K_SYS_REVISION_BCM1250_C1	0x21
+#define K_SYS_REVISION_BCM1250_C2	0x22
+#define K_SYS_REVISION_BCM1250_C3	0x23
 
+#if SIBYTE_HDR_FEATURE_CHIP(1250)
 /* XXX: discourage people from using these constants.  */
 #define K_SYS_REVISION_PASS1	    K_SYS_REVISION_BCM1250_PASS1
 #define K_SYS_REVISION_PASS2	    K_SYS_REVISION_BCM1250_PASS2
 #define K_SYS_REVISION_PASS2_2	    K_SYS_REVISION_BCM1250_PASS2_2
 #define K_SYS_REVISION_PASS3	    K_SYS_REVISION_BCM1250_PASS3
+#define K_SYS_REVISION_BCM1250_PASS3	K_SYS_REVISION_BCM1250_C0
 #endif /* 1250 */
 
-#if SIBYTE_HDR_FEATURE_CHIP(112x)
-#define K_SYS_REVISION_BCM112x_A1	32
-#define K_SYS_REVISION_BCM112x_A2	33
-#endif /* 112x */
+#define K_SYS_REVISION_BCM112x_A1	0x20
+#define K_SYS_REVISION_BCM112x_A2	0x21
+#define K_SYS_REVISION_BCM112x_A3	0x22
+#define K_SYS_REVISION_BCM112x_A4	0x23
+
+#define K_SYS_REVISION_BCM1480_S0	0x01
+#define K_SYS_REVISION_BCM1480_A1	0x02
+#define K_SYS_REVISION_BCM1480_A2	0x03
+#define K_SYS_REVISION_BCM1480_A3	0x04
+#define K_SYS_REVISION_BCM1480_B0	0x11
+
+/*Cache size - 23:20  of revision register*/
+#define S_SYS_L2C_SIZE            _SB_MAKE64(20)
+#define M_SYS_L2C_SIZE            _SB_MAKEMASK(4,S_SYS_L2C_SIZE)
+#define V_SYS_L2C_SIZE(x)         _SB_MAKEVALUE(x,S_SYS_L2C_SIZE)
+#define G_SYS_L2C_SIZE(x)         _SB_GETVALUE(x,S_SYS_L2C_SIZE,M_SYS_L2C_SIZE)
+
+#define K_SYS_L2C_SIZE_1MB	0
+#define K_SYS_L2C_SIZE_512KB	5
+#define K_SYS_L2C_SIZE_256KB	2
+#define K_SYS_L2C_SIZE_128KB	1
+
+#define K_SYS_L2C_SIZE_BCM1250	K_SYS_L2C_SIZE_512KB
+#define K_SYS_L2C_SIZE_BCM1125	K_SYS_L2C_SIZE_256KB
+#define K_SYS_L2C_SIZE_BCM1122	K_SYS_L2C_SIZE_128KB
+
+
+/* Number of CPU cores, bits 27:24  of revision register*/
+#define S_SYS_NUM_CPUS            _SB_MAKE64(24)
+#define M_SYS_NUM_CPUS            _SB_MAKEMASK(4,S_SYS_NUM_CPUS)
+#define V_SYS_NUM_CPUS(x)         _SB_MAKEVALUE(x,S_SYS_NUM_CPUS)
+#define G_SYS_NUM_CPUS(x)         _SB_GETVALUE(x,S_SYS_NUM_CPUS,M_SYS_NUM_CPUS)
+
 
 /* XXX: discourage people from using these constants.  */
 #define S_SYS_PART                  _SB_MAKE64(16)
@@ -83,6 +127,8 @@
 #define K_SYS_PART_BCM1120          0x1121
 #define K_SYS_PART_BCM1125          0x1123
 #define K_SYS_PART_BCM1125H         0x1124
+#define K_SYS_PART_BCM1122          0x1113
+
 
 /* The "peripheral set" (SOC type) is the low 4 bits of the "part" field.  */
 #define S_SYS_SOC_TYPE              _SB_MAKE64(16)
@@ -96,6 +142,8 @@
 #define K_SYS_SOC_TYPE_BCM1125      0x3
 #define K_SYS_SOC_TYPE_BCM1125H     0x4
 #define K_SYS_SOC_TYPE_BCM1250_ALT2 0x5		/* 1250pass2 w/ 1/2 L2.  */
+#define K_SYS_SOC_TYPE_BCM1x80      0x6
+#define K_SYS_SOC_TYPE_BCM1x55      0x7
 
 /*
  * Calculate correct SOC type given a copy of system revision register.
@@ -127,10 +175,12 @@
 #define V_SYS_WID(x)                _SB_MAKEVALUE(x,S_SYS_WID)
 #define G_SYS_WID(x)                _SB_GETVALUE(x,S_SYS_WID,M_SYS_WID)
 
-/* System Manufacturing Register
-* Register: SCD_SYSTEM_MANUF
-*/
+/*
+ * System Manufacturing Register
+ * Register: SCD_SYSTEM_MANUF
+ */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 /* Wafer ID: bits 31:0 */
 #define S_SYS_WAFERID1_200        _SB_MAKE64(0)
 #define M_SYS_WAFERID1_200        _SB_MAKEMASK(32,S_SYS_WAFERID1_200)
@@ -139,8 +189,8 @@
 
 #define S_SYS_BIN                 _SB_MAKE64(32)
 #define M_SYS_BIN                 _SB_MAKEMASK(4,S_SYS_BIN)
-#define V_SYS_BIN                 _SB_MAKEVALUE(x,S_SYS_BIN)
-#define G_SYS_BIN                 _SB_GETVALUE(x,S_SYS_BIN,M_SYS_BIN)
+#define V_SYS_BIN(x)              _SB_MAKEVALUE(x,S_SYS_BIN)
+#define G_SYS_BIN(x)              _SB_GETVALUE(x,S_SYS_BIN,M_SYS_BIN)
 
 /* Wafer ID: bits 39:36 */
 #define S_SYS_WAFERID2_200        _SB_MAKE64(36)
@@ -163,12 +213,14 @@
 #define M_SYS_YPOS                _SB_MAKEMASK(6,S_SYS_YPOS)
 #define V_SYS_YPOS(x)             _SB_MAKEVALUE(x,S_SYS_YPOS)
 #define G_SYS_YPOS(x)             _SB_GETVALUE(x,S_SYS_YPOS,M_SYS_YPOS)
+#endif
 
 /*
  * System Config Register (Table 4-2)
  * Register: SCD_SYSTEM_CFG
  */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define M_SYS_LDT_PLL_BYP           _SB_MAKEMASK1(3)
 #define M_SYS_PCI_SYNC_TEST_MODE    _SB_MAKEMASK1(4)
 #define M_SYS_IOB0_DIV              _SB_MAKEMASK1(5)
@@ -253,6 +305,8 @@
 #define M_SYS_SW_FLAG		    _SB_MAKEMASK1(63)
 #endif /* 1250 PASS2 || 112x PASS1 */
 
+#endif
+
 
 /*
  * Mailbox Registers (Table 4-3)
@@ -326,6 +380,7 @@
  * System Performance Counters
  */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define S_SPC_CFG_SRC0            0
 #define M_SPC_CFG_SRC0            _SB_MAKEMASK(8,S_SPC_CFG_SRC0)
 #define V_SPC_CFG_SRC0(x)         _SB_MAKEVALUE(x,S_SPC_CFG_SRC0)
@@ -348,6 +403,7 @@
 
 #define M_SPC_CFG_CLEAR		_SB_MAKEMASK1(32)
 #define M_SPC_CFG_ENABLE	_SB_MAKEMASK1(33)
+#endif
 
 
 /*
@@ -412,6 +468,7 @@
  * Address Trap Registers
  */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
 #define M_ATRAP_INDEX		  _SB_MAKEMASK(4,0)
 #define M_ATRAP_ADDRESS		  _SB_MAKEMASK(40,0)
 
@@ -436,7 +493,6 @@
 #define K_BUS_AGENT_IOB0	2
 #define K_BUS_AGENT_IOB1	3
 #define K_BUS_AGENT_SCD	4
-#define K_BUS_AGENT_RESERVED	5
 #define K_BUS_AGENT_L2C	6
 #define K_BUS_AGENT_MC	7
 
@@ -454,10 +510,14 @@
 #define K_ATRAP_CFG_CATTR_NOTNONCOH	6
 #define K_ATRAP_CFG_CATTR_NOTCOHERENT   7
 
+#endif	/* 1250/112x */
+
 /*
  * Trace Buffer Config register
  */
 
+#if SIBYTE_HDR_FEATURE_1250_112x
+
 #define M_SCD_TRACE_CFG_RESET           _SB_MAKEMASK1(0)
 #define M_SCD_TRACE_CFG_START_READ      _SB_MAKEMASK1(1)
 #define M_SCD_TRACE_CFG_START           _SB_MAKEMASK1(2)
@@ -475,6 +535,8 @@
 #define V_SCD_TRACE_CFG_CUR_ADDR(x)     _SB_MAKEVALUE(x,S_SCD_TRACE_CFG_CUR_ADDR)
 #define G_SCD_TRACE_CFG_CUR_ADDR(x)     _SB_GETVALUE(x,S_SCD_TRACE_CFG_CUR_ADDR,M_SCD_TRACE_CFG_CUR_ADDR)
 
+#endif	/* 1250/112x */
+
 /*
  * Trace Event registers
  */
@@ -578,5 +640,7 @@
 #define M_SCD_TRSEQ_DEBUGPIN            _SB_MAKEMASK1(20)
 #define M_SCD_TRSEQ_DEBUGCPU            _SB_MAKEMASK1(21)
 #define M_SCD_TRSEQ_CLEARUSE            _SB_MAKEMASK1(22)
+#define M_SCD_TRSEQ_ALLD_A              _SB_MAKEMASK1(23)
+#define M_SCD_TRSEQ_ALL_A               _SB_MAKEMASK1(24)
 
 #endif
Index: lmo/include/asm-mips/sibyte/sb1250_smbus.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_smbus.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_smbus.h	2005-10-19 22:34:11.000000000 -0700
@@ -47,6 +47,7 @@
 
 #define K_SMB_FREQ_400KHZ	    0x1F
 #define K_SMB_FREQ_100KHZ	    0x7D
+#define K_SMB_FREQ_10KHZ	    1250
 
 #define S_SMB_CMD                   0
 #define M_SMB_CMD                   _SB_MAKEMASK(8,S_SMB_CMD)
@@ -58,7 +59,11 @@
 
 #define M_SMB_ERR_INTR              _SB_MAKEMASK1(0)
 #define M_SMB_FINISH_INTR           _SB_MAKEMASK1(1)
-#define M_SMB_DATA_OUT              _SB_MAKEMASK1(4)
+
+#define S_SMB_DATA_OUT              4
+#define M_SMB_DATA_OUT              _SB_MAKEMASK1(S_SMB_DATA_OUT)
+#define V_SMB_DATA_OUT(x)           _SB_MAKEVALUE(x,S_SMB_DATA_OUT)
+
 #define M_SMB_DATA_DIR              _SB_MAKEMASK1(5)
 #define M_SMB_DATA_DIR_OUTPUT       M_SMB_DATA_DIR
 #define M_SMB_CLK_OUT               _SB_MAKEMASK1(6)
@@ -71,8 +76,23 @@
 #define M_SMB_BUSY                  _SB_MAKEMASK1(0)
 #define M_SMB_ERROR                 _SB_MAKEMASK1(1)
 #define M_SMB_ERROR_TYPE            _SB_MAKEMASK1(2)
-#define M_SMB_REF                   _SB_MAKEMASK1(6)
-#define M_SMB_DATA_IN               _SB_MAKEMASK1(7)
+
+#if SIBYTE_HDR_FEATURE(1250, PASS3) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
+#define S_SMB_SCL_IN                5
+#define M_SMB_SCL_IN                _SB_MAKEMASK1(S_SMB_SCL_IN)
+#define V_SMB_SCL_IN(x)             _SB_MAKEVALUE(x,S_SMB_SCL_IN)
+#define G_SMB_SCL_IN(x)             _SB_GETVALUE(x,S_SMB_SCL_IN,M_SMB_SCL_IN)
+#endif /* 1250 PASS3 || 112x PASS1 || 1480 */
+
+#define S_SMB_REF                   6
+#define M_SMB_REF                   _SB_MAKEMASK1(S_SMB_REF)
+#define V_SMB_REF(x)                _SB_MAKEVALUE(x,S_SMB_REF)
+#define G_SMB_REF(x)                _SB_GETVALUE(x,S_SMB_REF,M_SMB_REF)
+
+#define S_SMB_DATA_IN               7
+#define M_SMB_DATA_IN               _SB_MAKEMASK1(S_SMB_DATA_IN)
+#define V_SMB_DATA_IN(x)            _SB_MAKEVALUE(x,S_SMB_DATA_IN)
+#define G_SMB_DATA_IN(x)            _SB_GETVALUE(x,S_SMB_DATA_IN,M_SMB_DATA_IN)
 
 /*
  * SMBus Start/Command registers (Table 14-9)
@@ -132,16 +152,14 @@
 #define V_SPEC_MB(x)                _SB_MAKEVALUE(x,S_SPEC_PEC)
 
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 
 #define S_SMB_CMDH                  8
-#define M_SMB_CMDH                  _SB_MAKEMASK(8,S_SMBH_CMD)
-#define V_SMB_CMDH(x)               _SB_MAKEVALUE(x,S_SMBH_CMD)
+#define M_SMB_CMDH                  _SB_MAKEMASK(8,S_SMB_CMDH)
+#define V_SMB_CMDH(x)               _SB_MAKEVALUE(x,S_SMB_CMDH)
 
 #define M_SMB_EXTEND		    _SB_MAKEMASK1(14)
 
-#define M_SMB_DIR		    _SB_MAKEMASK1(13)
-
 #define S_SMB_DFMT                  8
 #define M_SMB_DFMT                  _SB_MAKEMASK(3,S_SMB_DFMT)
 #define V_SMB_DFMT(x)               _SB_MAKEVALUE(x,S_SMB_DFMT)
@@ -165,6 +183,23 @@
 #define V_SMB_DFMT_CMD5BYTE	    V_SMB_DFMT(K_SMB_DFMT_CMD5BYTE)
 #define V_SMB_DFMT_RESERVED	    V_SMB_DFMT(K_SMB_DFMT_RESERVED)
 
-#endif /* 1250 PASS2 || 112x PASS1 */
+#define S_SMB_AFMT                  11
+#define M_SMB_AFMT                  _SB_MAKEMASK(2,S_SMB_AFMT)
+#define V_SMB_AFMT(x)               _SB_MAKEVALUE(x,S_SMB_AFMT)
+#define G_SMB_AFMT(x)               _SB_GETVALUE(x,S_SMB_AFMT,M_SMB_AFMT)
+
+#define K_SMB_AFMT_NONE             0
+#define K_SMB_AFMT_ADDR             1
+#define K_SMB_AFMT_ADDR_CMD1BYTE    2
+#define K_SMB_AFMT_ADDR_CMD2BYTE    3
+
+#define V_SMB_AFMT_NONE		    V_SMB_AFMT(K_SMB_AFMT_NONE)
+#define V_SMB_AFMT_ADDR		    V_SMB_AFMT(K_SMB_AFMT_ADDR)
+#define V_SMB_AFMT_ADDR_CMD1BYTE    V_SMB_AFMT(K_SMB_AFMT_ADDR_CMD1BYTE)
+#define V_SMB_AFMT_ADDR_CMD2BYTE    V_SMB_AFMT(K_SMB_AFMT_ADDR_CMD2BYTE)
+
+#define M_SMB_DIR		    _SB_MAKEMASK1(13)
+
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 #endif
Index: lmo/include/asm-mips/sibyte/sb1250_uart.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_uart.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_uart.h	2005-10-19 22:34:11.000000000 -0700
@@ -240,7 +240,12 @@
  */
 
 #define M_DUART_ISR_TX_A            _SB_MAKEMASK1(0)
-#define M_DUART_ISR_RX_A            _SB_MAKEMASK1(1)
+
+#define S_DUART_ISR_RX_A            1
+#define M_DUART_ISR_RX_A            _SB_MAKEMASK1(S_DUART_ISR_RX_A)
+#define V_DUART_ISR_RX_A(x)         _SB_MAKEVALUE(x,S_DUART_ISR_RX_A)
+#define G_DUART_ISR_RX_A(x)         _SB_GETVALUE(x,S_DUART_ISR_RX_A,M_DUART_ISR_RX_A)
+
 #define M_DUART_ISR_BRK_A           _SB_MAKEMASK1(2)
 #define M_DUART_ISR_IN_A            _SB_MAKEMASK1(3)
 #define M_DUART_ISR_TX_B            _SB_MAKEMASK1(4)
@@ -331,7 +336,7 @@
 #define M_DUART_OUT_PIN_CLR(chan) \
     (chan == 0 ? M_DUART_OUT_PIN_CLR0 : M_DUART_OUT_PIN_CLR1)
 
-#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1)
+#if SIBYTE_HDR_FEATURE(1250, PASS2) || SIBYTE_HDR_FEATURE(112x, PASS1) || SIBYTE_HDR_FEATURE_CHIP(1480)
 /*
  * Full Interrupt Control Register
  */
@@ -345,7 +350,7 @@
 #define M_DUART_INT_TIME           _SB_MAKEMASK(4,S_DUART_INT_TIME)
 #define V_DUART_INT_TIME(x)        _SB_MAKEVALUE(x,S_DUART_INT_TIME)
 #define G_DUART_INT_TIME(x)        _SB_GETVALUE(x,S_DUART_INT_TIME,M_DUART_INT_TIME)
-#endif /* 1250 PASS2 || 112x PASS1 */
+#endif /* 1250 PASS2 || 112x PASS1 || 1480 */
 
 
 /* ********************************************************************** */
Index: lmo/include/asm-mips/sibyte/sb1250_mc.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_mc.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_mc.h	2005-10-19 22:34:11.000000000 -0700
@@ -324,6 +324,10 @@
 #define K_MC_tRFC_DEFAULT         12
 #define V_MC_tRFC_DEFAULT         V_MC_tRFC(K_MC_tRFC_DEFAULT)
 
+#if SIBYTE_HDR_FEATURE(1250, PASS3)
+#define M_MC_tRFC_PLUS16          _SB_MAKEMASK1(51)	/* 1250C3 and later.  */
+#endif
+
 #define S_MC_tCwCr                40
 #define M_MC_tCwCr                _SB_MAKEMASK(4,S_MC_tCwCr)
 #define V_MC_tCwCr(x)             _SB_MAKEVALUE(x,S_MC_tCwCr)
Index: lmo/include/asm-mips/sibyte/sb1250.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250.h	2005-10-19 22:34:11.000000000 -0700
@@ -27,6 +27,9 @@
 
 #define SB1250_NR_IRQS 64
 
+#define BCM1480_NR_IRQS                 128
+#define BCM1480_NR_IRQS_HALF            64
+
 #define SB1250_DUART_MINOR_BASE		64
 
 #ifndef __ASSEMBLY__
@@ -35,6 +38,7 @@
 
 /* For revision/pass information */
 #include <asm/sibyte/sb1250_scd.h>
+#include <asm/sibyte/bcm1480_scd.h>
 extern unsigned int sb1_pass;
 extern unsigned int soc_pass;
 extern unsigned int soc_type;
@@ -46,6 +50,13 @@
 extern void sb1250_mask_irq(int cpu, int irq);
 extern void sb1250_unmask_irq(int cpu, int irq);
 extern void sb1250_smp_finish(void);
+
+extern void bcm1480_time_init(void);
+extern unsigned long bcm1480_gettimeoffset(void);
+extern void bcm1480_mask_irq(int cpu, int irq);
+extern void bcm1480_unmask_irq(int cpu, int irq);
+extern void bcm1480_smp_finish(void);
+
 extern void prom_printf(char *fmt, ...);
 
 #define AT_spin \
