Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 17:26:35 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:34265 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28581176AbYGPQ0A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 17:26:00 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 57CEE5BC00C;
	Wed, 16 Jul 2008 19:26:00 +0300 (EEST)
Date:	Wed, 16 Jul 2008 19:25:50 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [2.6 patch] remove include/asm-mips/mips-boards/sead{,int}.h
Message-ID: <20080716162550.GD17329@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

include/asm-mips/mips-boards/sead{,int}.h are now obsolete.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 include/asm-mips/mips-boards/sead.h    |   36 -------------------------
 include/asm-mips/mips-boards/seadint.h |   28 -------------------
 2 files changed, 64 deletions(-)

f4463077cfa3dd9df52dc3215d8d5140455f70b9 
diff --git a/include/asm-mips/mips-boards/sead.h b/include/asm-mips/mips-boards/sead.h
deleted file mode 100644
index 68c69de..0000000
--- a/include/asm-mips/mips-boards/sead.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
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
- * Defines of the SEAD board specific address-MAP, registers, etc.
- *
- */
-#ifndef _MIPS_SEAD_H
-#define _MIPS_SEAD_H
-
-#include <asm/addrspace.h>
-
-/*
- * SEAD UART register base.
- */
-#define SEAD_UART0_REGS_BASE    (0x1f000800)
-#define SEAD_BASE_BAUD ( 3686400 / 16 )
-
-#endif /* !(_MIPS_SEAD_H) */
diff --git a/include/asm-mips/mips-boards/seadint.h b/include/asm-mips/mips-boards/seadint.h
deleted file mode 100644
index e710bae..0000000
--- a/include/asm-mips/mips-boards/seadint.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
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
- * Defines for the SEAD interrupt controller.
- */
-#ifndef _MIPS_SEADINT_H
-#define _MIPS_SEADINT_H
-
-#include <irq.h>
-
-#define MIPSCPU_INT_UART0	2
-#define MIPSCPU_INT_UART1	3
-
-#endif /* !(_MIPS_SEADINT_H) */
