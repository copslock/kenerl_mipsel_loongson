Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 05:45:00 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:9964 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022036AbXFFEnF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 05:43:05 +0100
Received: (qmail 26299 invoked by uid 511); 6 Jun 2007 04:50:07 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 04:50:07 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH] define MODULE_PROC_FAMILY for Loongson2
Date:	Wed,  6 Jun 2007 12:42:35 +0800
Message-Id: <11811049632588-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811049622818-git-send-email-tiansm@lemote.com>
References: <11811049622818-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/module.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/module.h b/include/asm-mips/module.h
index 399d03f..f615324 100644
--- a/include/asm-mips/module.h
+++ b/include/asm-mips/module.h
@@ -112,6 +112,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "RM9000 "
 #elif defined CONFIG_CPU_SB1
 #define MODULE_PROC_FAMILY "SB1 "
+#elif defined CONFIG_CPU_LOONGSON2
+#define MODULE_PROC_FAMILY "LOONGSON2 "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
-- 
1.5.2.1
