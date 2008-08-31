Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2008 17:10:01 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:7603 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20033258AbYHaQJ7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2008 17:09:59 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KZpUz-000467-00; Sun, 31 Aug 2008 18:09:57 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 183A2DE3B2; Sun, 31 Aug 2008 18:09:54 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP22: Fix handling of memory for I2 with more than 256MB
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080831160954.183A2DE3B2@solo.franken.de>
Date:	Sun, 31 Aug 2008 18:09:54 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Indigo2 machines support up to 384MB of memory, but the memory layout
for IP22 didn't support that and caused a lockup during kernel
startup. IP22 uses now the default 64bit space setup like most of
the other machines.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 include/asm-mips/mach-ip22/spaces.h |   27 ---------------------------
 2 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/include/asm-mips/mach-ip22/spaces.h b/include/asm-mips/mach-ip22/spaces.h
deleted file mode 100644
index 7f9fa6f..0000000
--- a/include/asm-mips/mach-ip22/spaces.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
- * Copyright (C) 2000, 2002  Maciej W. Rozycki
- * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
- */
-#ifndef _ASM_MACH_IP22_SPACES_H
-#define _ASM_MACH_IP22_SPACES_H
-
-
-#ifdef CONFIG_64BIT
-
-#define PAGE_OFFSET		0xffffffff80000000UL
-
-#define CAC_BASE		0xffffffff80000000
-#define IO_BASE			0xffffffffa0000000
-#define UNCAC_BASE		0xffffffffa0000000
-#define MAP_BASE		0xc000000000000000
-
-#endif /* CONFIG_64BIT */
-
-#include <asm/mach-generic/spaces.h>
-
-#endif /* __ASM_MACH_IP22_SPACES_H */
