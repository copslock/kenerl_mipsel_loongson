Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:57:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50838 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025952AbbDUO4cXIkzM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:56:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E3EDD444F327;
        Tue, 21 Apr 2015 15:56:24 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:56:28 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:56:27 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 31/37] MIPS: JZ4740: remove clock.h
Date:   Tue, 21 Apr 2015 15:46:58 +0100
Message-ID: <1429627624-30525-32-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46989
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

The only thing remaining in arch/mips/jz4740/clock.h is declarations of
the jz4740_clock_{suspend,resume} functions. Move these to
arch/mips/include/asm/mach-jz4740/clock.h for consistency with similar
functions, and remove the redundant arch/mips/jz4740/clock.h header.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Changes in v3:
  - Rebase.

Changes in v2:
  - None.
---
 arch/mips/include/asm/mach-jz4740/clock.h |  3 +++
 arch/mips/jz4740/clock.h                  | 25 -------------------------
 arch/mips/jz4740/pm.c                     |  2 --
 3 files changed, 3 insertions(+), 27 deletions(-)
 delete mode 100644 arch/mips/jz4740/clock.h

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
index 16659cd..104d2df 100644
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ b/arch/mips/include/asm/mach-jz4740/clock.h
@@ -22,6 +22,9 @@ enum jz4740_wait_mode {
 
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
 
+void jz4740_clock_suspend(void);
+void jz4740_clock_resume(void);
+
 void jz4740_clock_udc_enable_auto_suspend(void);
 void jz4740_clock_udc_disable_auto_suspend(void);
 
diff --git a/arch/mips/jz4740/clock.h b/arch/mips/jz4740/clock.h
deleted file mode 100644
index 86a3e01..0000000
--- a/arch/mips/jz4740/clock.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC clock support
- *
- *  This program is free software; you can redistribute	 it and/or modify it
- *  under  the terms of	 the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef __MIPS_JZ4740_CLOCK_H__
-#define __MIPS_JZ4740_CLOCK_H__
-
-#include <linux/clk.h>
-#include <linux/list.h>
-
-void jz4740_clock_suspend(void);
-void jz4740_clock_resume(void);
-
-#endif
diff --git a/arch/mips/jz4740/pm.c b/arch/mips/jz4740/pm.c
index d8e2130..2d8653f 100644
--- a/arch/mips/jz4740/pm.c
+++ b/arch/mips/jz4740/pm.c
@@ -20,8 +20,6 @@
 
 #include <asm/mach-jz4740/clock.h>
 
-#include "clock.h"
-
 static int jz4740_pm_enter(suspend_state_t state)
 {
 	jz4740_clock_suspend();
-- 
2.3.5
