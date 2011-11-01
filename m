Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:10:45 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab1KATE5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:57 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=21XyguvynHKA4mhD+YRt8wCGtW5D7xh9+grKt7vHZzg=;
        b=k7mE4N9Eh8Y9Gs9w4qeUY6uKC6t56UMojQhtujHAkN3k4GpYtVBrWzZTG03alv3jvN
         Z/+mT6hFMdNdMx8FOfxmq/vQt4em6hQeAHaJod7KabCYCNnPy+tf2mcMGuFss3Zo8JIo
         8X9NOxTBFP3mhN//I3JcN1Gl8XOxXJa4o5xeI=
Received: by 10.223.5.66 with SMTP id 2mr2495478fau.26.1320174297440;
        Tue, 01 Nov 2011 12:04:57 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:56 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 15/18] MIPS: Alchemy: remove unused board headers
Date:   Tue,  1 Nov 2011 20:03:41 +0100
Message-Id: <1320174224-27305-16-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 664

The information in those headers is no longer necessary.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Platform                 |    3 -
 arch/mips/include/asm/mach-db1x00/db1x00.h |   63 ------------------------
 arch/mips/include/asm/mach-pb1x00/pb1550.h |   73 ----------------------------
 3 files changed, 0 insertions(+), 139 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-db1x00/db1x00.h
 delete mode 100644 arch/mips/include/asm/mach-pb1x00/pb1550.h

diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index 33f80e8..7956274 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -8,21 +8,18 @@ platform-$(CONFIG_MIPS_ALCHEMY)	+= alchemy/common/
 # AMD Alchemy Pb1100 eval board
 #
 platform-$(CONFIG_MIPS_PB1100)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1100)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
 load-$(CONFIG_MIPS_PB1100)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Pb1500 eval board
 #
 platform-$(CONFIG_MIPS_PB1500)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1500)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
 load-$(CONFIG_MIPS_PB1500)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Pb1550 eval board
 #
 platform-$(CONFIG_MIPS_PB1550)	+= alchemy/devboards/
-cflags-$(CONFIG_MIPS_PB1550)	+= -I$(srctree)/arch/mips/include/asm/mach-pb1x00
 load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
 
 #
diff --git a/arch/mips/include/asm/mach-db1x00/db1x00.h b/arch/mips/include/asm/mach-db1x00/db1x00.h
deleted file mode 100644
index 51f1ebf..0000000
--- a/arch/mips/include/asm/mach-db1x00/db1x00.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * AMD Alchemy DBAu1x00 Reference Boards
- *
- * Copyright 2001, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- * Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
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
- *
- */
-#ifndef __ASM_DB1X00_H
-#define __ASM_DB1X00_H
-
-#include <asm/mach-au1x00/au1xxx_psc.h>
-
-/*
- * NAND defines
- *
- * Timing values as described in databook, * ns value stripped of the
- * lower 2 bits.
- * These defines are here rather than an Au1550 generic file because
- * the parts chosen on another board may be different and may require
- * different timings.
- */
-#define NAND_T_H		(18 >> 2)
-#define NAND_T_PUL		(30 >> 2)
-#define NAND_T_SU		(30 >> 2)
-#define NAND_T_WH		(30 >> 2)
-
-/* Bitfield shift amounts */
-#define NAND_T_H_SHIFT		0
-#define NAND_T_PUL_SHIFT	4
-#define NAND_T_SU_SHIFT		8
-#define NAND_T_WH_SHIFT		12
-
-#define NAND_TIMING	(((NAND_T_H   & 0xF) << NAND_T_H_SHIFT)   | \
-			 ((NAND_T_PUL & 0xF) << NAND_T_PUL_SHIFT) | \
-			 ((NAND_T_SU  & 0xF) << NAND_T_SU_SHIFT)  | \
-			 ((NAND_T_WH  & 0xF) << NAND_T_WH_SHIFT))
-#define NAND_CS 	1
-
-/* Should be done by YAMON */
-#define NAND_STCFG	0x00400005 /* 8-bit NAND */
-#define NAND_STTIME	0x00007774 /* valid for 396 MHz SD=2 only */
-#define NAND_STADDR	0x12000FFF /* physical address 0x20000000 */
-
-#endif /* __ASM_DB1X00_H */
diff --git a/arch/mips/include/asm/mach-pb1x00/pb1550.h b/arch/mips/include/asm/mach-pb1x00/pb1550.h
deleted file mode 100644
index 443b88a..0000000
--- a/arch/mips/include/asm/mach-pb1x00/pb1550.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * AMD Alchemy Semi PB1550 Reference Board
- * Board Registers defines.
- *
- * Copyright 2004 Embedded Edge LLC.
- * Copyright 2005 Ralf Baechle (ralf@linux-mips.org)
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
- *
- */
-#ifndef __ASM_PB1550_H
-#define __ASM_PB1550_H
-
-#include <linux/types.h>
-#include <asm/mach-au1x00/au1xxx_psc.h>
-
-#define DBDMA_AC97_TX_CHAN	AU1550_DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	AU1550_DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	AU1550_DSCR_CMD0_PSC3_TX
-#define DBDMA_I2S_RX_CHAN	AU1550_DSCR_CMD0_PSC3_RX
-
-#define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
-#define AC97_PSC_BASE		AU1550_PSC1_PHYS_ADDR
-#define SMBUS_PSC_BASE		AU1550_PSC2_PHYS_ADDR
-#define I2S_PSC_BASE		AU1550_PSC3_PHYS_ADDR
-
-/*
- * Timing values as described in databook, * ns value stripped of
- * lower 2 bits.
- * These defines are here rather than an SOC1550 generic file because
- * the parts chosen on another board may be different and may require
- * different timings.
- */
-#define NAND_T_H		(18 >> 2)
-#define NAND_T_PUL		(30 >> 2)
-#define NAND_T_SU		(30 >> 2)
-#define NAND_T_WH		(30 >> 2)
-
-/* Bitfield shift amounts */
-#define NAND_T_H_SHIFT		0
-#define NAND_T_PUL_SHIFT	4
-#define NAND_T_SU_SHIFT		8
-#define NAND_T_WH_SHIFT		12
-
-#define NAND_TIMING	(((NAND_T_H   & 0xF) << NAND_T_H_SHIFT)   | \
-			 ((NAND_T_PUL & 0xF) << NAND_T_PUL_SHIFT) | \
-			 ((NAND_T_SU  & 0xF) << NAND_T_SU_SHIFT)  | \
-			 ((NAND_T_WH  & 0xF) << NAND_T_WH_SHIFT))
-
-#define NAND_CS 1
-
-/* Should be done by YAMON */
-#define NAND_STCFG	0x00400005 /* 8-bit NAND */
-#define NAND_STTIME	0x00007774 /* valid for 396 MHz SD=2 only */
-#define NAND_STADDR	0x12000FFF /* physical address 0x20000000 */
-
-#endif /* __ASM_PB1550_H */
-- 
1.7.7.1
