Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2014 10:42:25 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:55206 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822084AbaCZJmCG9GK- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Mar 2014 10:42:02 +0100
Received: by mail-ee0-f51.google.com with SMTP id c13so1411429eek.24
        for <linux-mips@linux-mips.org>; Wed, 26 Mar 2014 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E22wdT0ghY6lmPNFXrRko9Nn9XbZOyBrTqUtSHKN7AY=;
        b=F2sO9JXjI3bclZnFsLhE3igiQ56so9so8uu2hPgoUcvu1dtKLi6Uim23XfWR7MeXVf
         Tq1pT4P0knQRQguLG4vG84B4Ha1bSzyKrXlwr7L9P/Mv5MPGRheM9Tujkh0HBJPX1Zby
         LepLGizSuA7ZxPILo52vl+HDB1CCY/hEwG+6gN4VLLqwexX97nYEAz4bZya6ZuQywpfl
         8w3BlwGZPiWf9y/eGoGeYsuSENMEtB+cZcTSu/UaoUtMHZAK2DfdokXBAp7zlJQvGc2/
         BlxZXiNnc5z4pRP6Fc910te5MSNn3KwEQ0SzaxviXb+lWg1ENiLOPPkXV/Tk+W3AuUte
         AwRw==
X-Received: by 10.15.81.135 with SMTP id x7mr7698907eey.61.1395826915131;
        Wed, 26 Mar 2014 02:41:55 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D458.dip0.t-ipconnect.de. [79.216.212.88])
        by mx.google.com with ESMTPSA id w12sm46087849eez.36.2014.03.26.02.41.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Mar 2014 02:41:54 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/3] MIPS: Alchemy: fold mach-db1xxx/db1x00 headers into board code
Date:   Wed, 26 Mar 2014 10:41:48 +0100
Message-Id: <1395826909-14772-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395826909-14772-1-git-send-email-manuel.lauss@gmail.com>
References: <1395826909-14772-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Merge the db1200.h and db1300.h headers into their only users.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200.c       | 48 +++++++++++++++-
 arch/mips/alchemy/devboards/db1300.c       | 34 ++++++++++-
 arch/mips/include/asm/mach-db1x00/db1200.h | 91 ------------------------------
 arch/mips/include/asm/mach-db1x00/db1300.h | 40 -------------
 4 files changed, 80 insertions(+), 133 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-db1x00/db1200.h
 delete mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index a60d0a3..4bcf2f4 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -38,13 +38,59 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-au1x00/au1200fb.h>
 #include <asm/mach-au1x00/au1550_spi.h>
 #include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-db1x00/db1200.h>
 
 #include "platform.h"
 
+#define BCSR_INT_IDE		0x0001
+#define BCSR_INT_ETH		0x0002
+#define BCSR_INT_PC0		0x0004
+#define BCSR_INT_PC0STSCHG	0x0008
+#define BCSR_INT_PC1		0x0010
+#define BCSR_INT_PC1STSCHG	0x0020
+#define BCSR_INT_DC		0x0040
+#define BCSR_INT_FLASHBUSY	0x0080
+#define BCSR_INT_PC0INSERT	0x0100
+#define BCSR_INT_PC0EJECT	0x0200
+#define BCSR_INT_PC1INSERT	0x0400
+#define BCSR_INT_PC1EJECT	0x0800
+#define BCSR_INT_SD0INSERT	0x1000
+#define BCSR_INT_SD0EJECT	0x2000
+#define BCSR_INT_SD1INSERT	0x4000
+#define BCSR_INT_SD1EJECT	0x8000
+
+#define DB1200_IDE_PHYS_ADDR	0x18800000
+#define DB1200_IDE_REG_SHIFT	5
+#define DB1200_IDE_PHYS_LEN	(16 << DB1200_IDE_REG_SHIFT)
+#define DB1200_ETH_PHYS_ADDR	0x19000300
+#define DB1200_NAND_PHYS_ADDR	0x20000000
+
+#define PB1200_IDE_PHYS_ADDR	0x0C800000
+#define PB1200_ETH_PHYS_ADDR	0x0D000300
+#define PB1200_NAND_PHYS_ADDR	0x1C000000
+
+#define DB1200_INT_BEGIN	(AU1000_MAX_INTR + 1)
+#define DB1200_IDE_INT		(DB1200_INT_BEGIN + 0)
+#define DB1200_ETH_INT		(DB1200_INT_BEGIN + 1)
+#define DB1200_PC0_INT		(DB1200_INT_BEGIN + 2)
+#define DB1200_PC0_STSCHG_INT	(DB1200_INT_BEGIN + 3)
+#define DB1200_PC1_INT		(DB1200_INT_BEGIN + 4)
+#define DB1200_PC1_STSCHG_INT	(DB1200_INT_BEGIN + 5)
+#define DB1200_DC_INT		(DB1200_INT_BEGIN + 6)
+#define DB1200_FLASHBUSY_INT	(DB1200_INT_BEGIN + 7)
+#define DB1200_PC0_INSERT_INT	(DB1200_INT_BEGIN + 8)
+#define DB1200_PC0_EJECT_INT	(DB1200_INT_BEGIN + 9)
+#define DB1200_PC1_INSERT_INT	(DB1200_INT_BEGIN + 10)
+#define DB1200_PC1_EJECT_INT	(DB1200_INT_BEGIN + 11)
+#define DB1200_SD0_INSERT_INT	(DB1200_INT_BEGIN + 12)
+#define DB1200_SD0_EJECT_INT	(DB1200_INT_BEGIN + 13)
+#define PB1200_SD1_INSERT_INT	(DB1200_INT_BEGIN + 14)
+#define PB1200_SD1_EJECT_INT	(DB1200_INT_BEGIN + 15)
+#define DB1200_INT_END		(DB1200_INT_BEGIN + 15)
+
 const char *get_system_type(void);
 
 static int __init db1200_detect_board(void)
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index 509602c..1aed6be 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -26,12 +26,44 @@
 #include <asm/mach-au1x00/au1200fb.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
-#include <asm/mach-db1x00/db1300.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <asm/mach-au1x00/prom.h>
 
 #include "platform.h"
 
+/* FPGA (external mux) interrupt sources */
+#define DB1300_FIRST_INT	(ALCHEMY_GPIC_INT_LAST + 1)
+#define DB1300_IDE_INT		(DB1300_FIRST_INT + 0)
+#define DB1300_ETH_INT		(DB1300_FIRST_INT + 1)
+#define DB1300_CF_INT		(DB1300_FIRST_INT + 2)
+#define DB1300_VIDEO_INT	(DB1300_FIRST_INT + 4)
+#define DB1300_HDMI_INT		(DB1300_FIRST_INT + 5)
+#define DB1300_DC_INT		(DB1300_FIRST_INT + 6)
+#define DB1300_FLASH_INT	(DB1300_FIRST_INT + 7)
+#define DB1300_CF_INSERT_INT	(DB1300_FIRST_INT + 8)
+#define DB1300_CF_EJECT_INT	(DB1300_FIRST_INT + 9)
+#define DB1300_AC97_INT		(DB1300_FIRST_INT + 10)
+#define DB1300_AC97_PEN_INT	(DB1300_FIRST_INT + 11)
+#define DB1300_SD1_INSERT_INT	(DB1300_FIRST_INT + 12)
+#define DB1300_SD1_EJECT_INT	(DB1300_FIRST_INT + 13)
+#define DB1300_OTG_VBUS_OC_INT	(DB1300_FIRST_INT + 14)
+#define DB1300_HOST_VBUS_OC_INT (DB1300_FIRST_INT + 15)
+#define DB1300_LAST_INT		(DB1300_FIRST_INT + 15)
+
+/* SMSC9210 CS */
+#define DB1300_ETH_PHYS_ADDR	0x19000000
+#define DB1300_ETH_PHYS_END	0x197fffff
+
+/* ATA CS */
+#define DB1300_IDE_PHYS_ADDR	0x18800000
+#define DB1300_IDE_REG_SHIFT	5
+#define DB1300_IDE_PHYS_LEN	(16 << DB1300_IDE_REG_SHIFT)
+
+/* NAND CS */
+#define DB1300_NAND_PHYS_ADDR	0x20000000
+#define DB1300_NAND_PHYS_END	0x20000fff
+
+
 static struct i2c_board_info db1300_i2c_devs[] __initdata = {
 	{ I2C_BOARD_INFO("wm8731", 0x1b), },	/* I2S audio codec */
 	{ I2C_BOARD_INFO("ne1619", 0x2d), },	/* adm1025-compat hwmon */
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
deleted file mode 100644
index d3cce73..0000000
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * AMD Alchemy DBAu1200 Reference Board
- * Board register defines.
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
-#ifndef __ASM_DB1200_H
-#define __ASM_DB1200_H
-
-#include <linux/types.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_psc.h>
-
-/* Bit positions for the different interrupt sources */
-#define BCSR_INT_IDE		0x0001
-#define BCSR_INT_ETH		0x0002
-#define BCSR_INT_PC0		0x0004
-#define BCSR_INT_PC0STSCHG	0x0008
-#define BCSR_INT_PC1		0x0010
-#define BCSR_INT_PC1STSCHG	0x0020
-#define BCSR_INT_DC		0x0040
-#define BCSR_INT_FLASHBUSY	0x0080
-#define BCSR_INT_PC0INSERT	0x0100
-#define BCSR_INT_PC0EJECT	0x0200
-#define BCSR_INT_PC1INSERT	0x0400
-#define BCSR_INT_PC1EJECT	0x0800
-#define BCSR_INT_SD0INSERT	0x1000
-#define BCSR_INT_SD0EJECT	0x2000
-#define BCSR_INT_SD1INSERT	0x4000
-#define BCSR_INT_SD1EJECT	0x8000
-
-#define IDE_REG_SHIFT		5
-
-#define DB1200_IDE_PHYS_ADDR	0x18800000
-#define DB1200_IDE_PHYS_LEN	(16 << IDE_REG_SHIFT)
-#define DB1200_ETH_PHYS_ADDR	0x19000300
-#define DB1200_NAND_PHYS_ADDR	0x20000000
-
-#define PB1200_IDE_PHYS_ADDR	0x0C800000
-#define PB1200_ETH_PHYS_ADDR	0x0D000300
-#define PB1200_NAND_PHYS_ADDR	0x1C000000
-
-/*
- * External Interrupts for DBAu1200 as of 8/6/2004.
- * Bit positions in the CPLD registers can be calculated by taking
- * the interrupt define and subtracting the DB1200_INT_BEGIN value.
- *
- *   Example: IDE bis pos is  = 64 - 64
- *	      ETH bit pos is  = 65 - 64
- */
-enum external_db1200_ints {
-	DB1200_INT_BEGIN	= AU1000_MAX_INTR + 1,
-
-	DB1200_IDE_INT		= DB1200_INT_BEGIN,
-	DB1200_ETH_INT,
-	DB1200_PC0_INT,
-	DB1200_PC0_STSCHG_INT,
-	DB1200_PC1_INT,
-	DB1200_PC1_STSCHG_INT,
-	DB1200_DC_INT,
-	DB1200_FLASHBUSY_INT,
-	DB1200_PC0_INSERT_INT,
-	DB1200_PC0_EJECT_INT,
-	DB1200_PC1_INSERT_INT,
-	DB1200_PC1_EJECT_INT,
-	DB1200_SD0_INSERT_INT,
-	DB1200_SD0_EJECT_INT,
-	PB1200_SD1_INSERT_INT,
-	PB1200_SD1_EJECT_INT,
-
-	DB1200_INT_END		= DB1200_INT_BEGIN + 15,
-};
-
-#endif /* __ASM_DB1200_H */
diff --git a/arch/mips/include/asm/mach-db1x00/db1300.h b/arch/mips/include/asm/mach-db1x00/db1300.h
deleted file mode 100644
index 3d1ede4..0000000
--- a/arch/mips/include/asm/mach-db1x00/db1300.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * NetLogic DB1300 board constants
- */
-
-#ifndef _DB1300_H_
-#define _DB1300_H_
-
-/* FPGA (external mux) interrupt sources */
-#define DB1300_FIRST_INT	(ALCHEMY_GPIC_INT_LAST + 1)
-#define DB1300_IDE_INT		(DB1300_FIRST_INT + 0)
-#define DB1300_ETH_INT		(DB1300_FIRST_INT + 1)
-#define DB1300_CF_INT		(DB1300_FIRST_INT + 2)
-#define DB1300_VIDEO_INT	(DB1300_FIRST_INT + 4)
-#define DB1300_HDMI_INT		(DB1300_FIRST_INT + 5)
-#define DB1300_DC_INT		(DB1300_FIRST_INT + 6)
-#define DB1300_FLASH_INT	(DB1300_FIRST_INT + 7)
-#define DB1300_CF_INSERT_INT	(DB1300_FIRST_INT + 8)
-#define DB1300_CF_EJECT_INT	(DB1300_FIRST_INT + 9)
-#define DB1300_AC97_INT		(DB1300_FIRST_INT + 10)
-#define DB1300_AC97_PEN_INT	(DB1300_FIRST_INT + 11)
-#define DB1300_SD1_INSERT_INT	(DB1300_FIRST_INT + 12)
-#define DB1300_SD1_EJECT_INT	(DB1300_FIRST_INT + 13)
-#define DB1300_OTG_VBUS_OC_INT	(DB1300_FIRST_INT + 14)
-#define DB1300_HOST_VBUS_OC_INT (DB1300_FIRST_INT + 15)
-#define DB1300_LAST_INT		(DB1300_FIRST_INT + 15)
-
-/* SMSC9210 CS */
-#define DB1300_ETH_PHYS_ADDR	0x19000000
-#define DB1300_ETH_PHYS_END	0x197fffff
-
-/* ATA CS */
-#define DB1300_IDE_PHYS_ADDR	0x18800000
-#define DB1300_IDE_REG_SHIFT	5
-#define DB1300_IDE_PHYS_LEN	(16 << DB1300_IDE_REG_SHIFT)
-
-/* NAND CS */
-#define DB1300_NAND_PHYS_ADDR	0x20000000
-#define DB1300_NAND_PHYS_END	0x20000fff
-
-#endif	/* _DB1300_H_ */
-- 
1.9.1
