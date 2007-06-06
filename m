Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:58:39 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:1418 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021523AbXFFGyM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 07:54:12 +0100
Received: (qmail 7061 invoked by uid 511); 6 Jun 2007 07:00:19 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 07:00:19 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 06/15] define Hit_Invalidate_I to Index_Invalidate_I for loongson2
Date:	Wed,  6 Jun 2007 14:52:43 +0800
Message-Id: <11811127732934-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811127722019-git-send-email-tiansm@lemote.com>
References: <11811127722019-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/cacheops.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/cacheops.h b/include/asm-mips/cacheops.h
index c4a1ec3..df7f2de 100644
--- a/include/asm-mips/cacheops.h
+++ b/include/asm-mips/cacheops.h
@@ -20,7 +20,11 @@
 #define Index_Load_Tag_D	0x05
 #define Index_Store_Tag_I	0x08
 #define Index_Store_Tag_D	0x09
+#if defined(CONFIG_CPU_LOONGSON2)
+#define Hit_Invalidate_I    	0x00
+#else
 #define Hit_Invalidate_I	0x10
+#endif
 #define Hit_Invalidate_D	0x11
 #define Hit_Writeback_Inv_D	0x15
 
-- 
1.5.2.1
