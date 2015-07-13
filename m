Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 18:15:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40985 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010459AbbGMQPNOiVy8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 18:15:13 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3EEC57108342;
        Mon, 13 Jul 2015 17:15:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 13 Jul 2015 17:15:07 +0100
Received: from localhost (10.100.200.70) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 13 Jul
 2015 17:15:06 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: drop CONFIG_RUNTIME_DEBUG & debug.h
Date:   Mon, 13 Jul 2015 17:14:22 +0100
Message-ID: <1436804062-30041-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436804062-30041-1-git-send-email-paul.burton@imgtec.com>
References: <1436804062-30041-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.70]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48228
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

The debug.h header provided some MIPS-specific debug macros, which are
no longer used at all. Remove them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig.debug       |  9 --------
 arch/mips/include/asm/debug.h | 48 -------------------------------------------
 2 files changed, 57 deletions(-)
 delete mode 100644 arch/mips/include/asm/debug.h

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 3a2b775..e250524 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -87,15 +87,6 @@ config SB1XXX_CORELIS
 	  Select compile flags that produce code that can be processed by the
 	  Corelis mksym utility and UDB Emulator.
 
-config RUNTIME_DEBUG
-	bool "Enable run-time debugging"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, some debugging macros will do run-time checking.
-	  If you say N here, those macros will mostly turn to no-ops.  See
-	  arch/mips/include/asm/debug.h for debugging macros.
-	  If unsure, say N.
-
 config DEBUG_ZBOOT
 	bool "Enable compressed kernel support debugging"
 	depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT
diff --git a/arch/mips/include/asm/debug.h b/arch/mips/include/asm/debug.h
deleted file mode 100644
index 1fd5a2b..0000000
--- a/arch/mips/include/asm/debug.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Debug macros for run-time debugging.
- * Turned on/off with CONFIG_RUNTIME_DEBUG option.
- *
- * Copyright (C) 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-#ifndef _ASM_DEBUG_H
-#define _ASM_DEBUG_H
-
-
-/*
- * run-time macros for catching spurious errors.  Eable CONFIG_RUNTIME_DEBUG in
- * kernel hacking config menu to use them.
- *
- * Use them as run-time debugging aid.  NEVER USE THEM AS ERROR HANDLING CODE!!!
- */
-
-#ifdef CONFIG_RUNTIME_DEBUG
-
-#include <linux/kernel.h>
-
-#define db_assert(x)  if (!(x)) { \
-	panic("assertion failed at %s:%d: %s", __FILE__, __LINE__, #x); }
-#define db_warn(x)  if (!(x)) { \
-	printk(KERN_WARNING "warning at %s:%d: %s", __FILE__, __LINE__, #x); }
-#define db_verify(x, y) db_assert(x y)
-#define db_verify_warn(x, y) db_warn(x y)
-#define db_run(x)  do { x; } while (0)
-
-#else
-
-#define db_assert(x)
-#define db_warn(x)
-#define db_verify(x, y) x
-#define db_verify_warn(x, y) x
-#define db_run(x)
-
-#endif
-
-#endif /* _ASM_DEBUG_H */
-- 
2.4.5
