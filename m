Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 17:26:15 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:49324 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28581177AbYGPQZz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 17:25:55 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 8FC505BC031;
	Wed, 16 Jul 2008 19:25:54 +0300 (EEST)
Date:	Wed, 16 Jul 2008 19:25:44 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [2.6 patch] remove asm-mips/mips-boards/atlas{,int}.h
Message-ID: <20080716162544.GC17329@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

asm-mips/mips-boards/atlas{,int}.h are now obsolete.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-mips/mips-boards/atlas.h    |   80 -----------------
 include/asm-mips/mips-boards/atlasint.h |  109 ------------------------
 2 files changed, 189 deletions(-)

e814acdcf5b635e1da6aaff33d7a27bfb3dad058 
diff --git a/include/asm-mips/mips-boards/atlas.h b/include/asm-mips/mips-boards/atlas.h
deleted file mode 100644
index a8ae12d..0000000
--- a/include/asm-mips/mips-boards/atlas.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * Defines of the Atlas board specific address-MAP, registers, etc.
- *
- */
-#ifndef _MIPS_ATLAS_H
-#define _MIPS_ATLAS_H
-
-#include <asm/addrspace.h>
-
-/*
- * Atlas RTC-device indirect register access.
- */
-#define ATLAS_RTC_ADR_REG       0x1f000800
-#define ATLAS_RTC_DAT_REG       0x1f000808
-
-/*
- * Atlas interrupt controller register base.
- */
-#define ATLAS_ICTRL_REGS_BASE   0x1f000000
-
-/*
- * Atlas registers are memory mapped on 64-bit aligned boundaries and
- * only word access are allowed.
- */
-struct atlas_ictrl_regs {
-	volatile unsigned int intraw;
-	int dummy1;
-	volatile unsigned int intseten;
-	int dummy2;
-	volatile unsigned int intrsten;
-	int dummy3;
-	volatile unsigned int intenable;
-	int dummy4;
-	volatile unsigned int intstatus;
-	int dummy5;
-};
-
-/*
- * Atlas UART register base.
- */
-#define ATLAS_UART_REGS_BASE    0x1f000900
-#define ATLAS_BASE_BAUD ( 3686400 / 16 )
-
-/*
- * Atlas PSU standby register.
- */
-#define ATLAS_PSUSTBY_REG       0x1f000600
-#define ATLAS_GOSTBY            0x4d
-
-/*
- * We make a universal assumption about the way the bootloader (YAMON)
- * have located the Philips SAA9730 chip.
- * This is not ideal, but is needed for setting up remote debugging as
- * soon as possible.
- */
-#define ATLAS_SAA9730_REG	0x10800000
-
-#define ATLAS_SAA9730_BAUDCLOCK	3692300
-
-#endif /* !(_MIPS_ATLAS_H) */
diff --git a/include/asm-mips/mips-boards/atlasint.h b/include/asm-mips/mips-boards/atlasint.h
deleted file mode 100644
index 93ba1c1..0000000
--- a/include/asm-mips/mips-boards/atlasint.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * Copyright (C) 1999, 2006  MIPS Technologies, Inc.  All rights reserved.
- *	Authors: Carsten Langgaard <carstenl@mips.com>
- *		 Maciej W. Rozycki <macro@mips.com>
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * Defines for the Atlas interrupt controller.
- *
- */
-#ifndef _MIPS_ATLASINT_H
-#define _MIPS_ATLASINT_H
-
-#include <irq.h>
-
-/* CPU interrupt offsets */
-#define MIPSCPU_INT_SW0		0
-#define MIPSCPU_INT_SW1		1
-#define MIPSCPU_INT_MB0		2
-#define MIPSCPU_INT_ATLAS	MIPSCPU_INT_MB0
-#define MIPSCPU_INT_MB1		3
-#define MIPSCPU_INT_MB2		4
-#define MIPSCPU_INT_MB3		5
-#define MIPSCPU_INT_MB4		6
-
-/*
- * Interrupts 8..39 are used for Atlas interrupt controller interrupts
- */
-#define ATLAS_INT_BASE		8
-#define ATLAS_INT_UART		(ATLAS_INT_BASE + 0)
-#define ATLAS_INT_TIM0		(ATLAS_INT_BASE + 1)
-#define ATLAS_INT_RES2		(ATLAS_INT_BASE + 2)
-#define ATLAS_INT_RES3		(ATLAS_INT_BASE + 3)
-#define ATLAS_INT_RTC		(ATLAS_INT_BASE + 4)
-#define ATLAS_INT_COREHI	(ATLAS_INT_BASE + 5)
-#define ATLAS_INT_CORELO	(ATLAS_INT_BASE + 6)
-#define ATLAS_INT_RES7		(ATLAS_INT_BASE + 7)
-#define ATLAS_INT_PCIA		(ATLAS_INT_BASE + 8)
-#define ATLAS_INT_PCIB		(ATLAS_INT_BASE + 9)
-#define ATLAS_INT_PCIC		(ATLAS_INT_BASE + 10)
-#define ATLAS_INT_PCID		(ATLAS_INT_BASE + 11)
-#define ATLAS_INT_ENUM		(ATLAS_INT_BASE + 12)
-#define ATLAS_INT_DEG		(ATLAS_INT_BASE + 13)
-#define ATLAS_INT_ATXFAIL	(ATLAS_INT_BASE + 14)
-#define ATLAS_INT_INTA		(ATLAS_INT_BASE + 15)
-#define ATLAS_INT_INTB		(ATLAS_INT_BASE + 16)
-#define ATLAS_INT_ETH		ATLAS_INT_INTB
-#define ATLAS_INT_INTC		(ATLAS_INT_BASE + 17)
-#define ATLAS_INT_SCSI		ATLAS_INT_INTC
-#define ATLAS_INT_INTD		(ATLAS_INT_BASE + 18)
-#define ATLAS_INT_SERR		(ATLAS_INT_BASE + 19)
-#define ATLAS_INT_RES20		(ATLAS_INT_BASE + 20)
-#define ATLAS_INT_RES21		(ATLAS_INT_BASE + 21)
-#define ATLAS_INT_RES22		(ATLAS_INT_BASE + 22)
-#define ATLAS_INT_RES23		(ATLAS_INT_BASE + 23)
-#define ATLAS_INT_RES24		(ATLAS_INT_BASE + 24)
-#define ATLAS_INT_RES25		(ATLAS_INT_BASE + 25)
-#define ATLAS_INT_RES26		(ATLAS_INT_BASE + 26)
-#define ATLAS_INT_RES27		(ATLAS_INT_BASE + 27)
-#define ATLAS_INT_RES28		(ATLAS_INT_BASE + 28)
-#define ATLAS_INT_RES29		(ATLAS_INT_BASE + 29)
-#define ATLAS_INT_RES30		(ATLAS_INT_BASE + 30)
-#define ATLAS_INT_RES31		(ATLAS_INT_BASE + 31)
-#define ATLAS_INT_END		(ATLAS_INT_BASE + 31)
-
-/*
- * Interrupts 64..127 are used for Soc-it Classic interrupts
- */
-#define MSC01C_INT_BASE		64
-
-/* SOC-it Classic interrupt offsets */
-#define MSC01C_INT_TMR		0
-#define MSC01C_INT_PCI		1
-
-/*
- * Interrupts 64..127 are used for Soc-it EIC interrupts
- */
-#define MSC01E_INT_BASE		64
-
-/* SOC-it EIC interrupt offsets */
-#define	MSC01E_INT_SW0		1
-#define	MSC01E_INT_SW1		2
-#define	MSC01E_INT_MB0		3
-#define	MSC01E_INT_ATLAS	MSC01E_INT_MB0
-#define	MSC01E_INT_MB1		4
-#define	MSC01E_INT_MB2		5
-#define	MSC01E_INT_MB3		6
-#define	MSC01E_INT_MB4		7
-#define	MSC01E_INT_TMR		8
-#define	MSC01E_INT_PCI		9
-#define	MSC01E_INT_PERFCTR	10
-#define	MSC01E_INT_CPUCTR	11
-
-#endif /* !(_MIPS_ATLASINT_H) */
