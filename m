Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 21:05:31 +0200 (CEST)
Received: from smtp-out-182.synserver.de ([212.40.180.182]:1047 "HELO
        smtp-out-182.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492618Ab0FBTEv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 21:04:51 +0200
Received: (qmail 29991 invoked by uid 0); 2 Jun 2010 19:04:43 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 28645
Received: from port-91163.pppoe.wtnet.de (HELO localhost.localdomain) [84.46.68.144]
  by 217.119.54.73 with SMTP; 2 Jun 2010 19:04:43 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC][PATCH 07/26] MIPS: JZ4740: Add setup code
Date:   Wed,  2 Jun 2010 21:02:58 +0200
Message-Id: <1275505397-16758-8-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1275505397-16758-1-git-send-email-lars@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
X-archive-position: 27006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1588

This patch adds plat_mem_setup and get_system_type for JZ4740 SoCs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/setup.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/jz4740/setup.c

diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
new file mode 100644
index 0000000..d449358
--- /dev/null
+++ b/arch/mips/jz4740/setup.c
@@ -0,0 +1,33 @@
+/*
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 setup code
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/clock.h>
+
+#include "reset.h"
+#include "clock.h"
+
+void __init plat_mem_setup(void)
+{
+	jz4740_reset_init();
+}
+
+const char *get_system_type(void)
+{
+	return "JZ4740";
+}
-- 
1.5.6.5
