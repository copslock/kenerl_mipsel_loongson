Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:56:02 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:64649 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021471AbXFFGyE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 07:54:04 +0100
Received: (qmail 7066 invoked by uid 511); 6 Jun 2007 07:00:19 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 07:00:19 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 07/15] add Loongson processor definitions
Date:	Wed,  6 Jun 2007 14:52:44 +0800
Message-Id: <11811127742520-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811127722019-git-send-email-tiansm@lemote.com>
References: <11811127722019-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/cpu.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index d38fdbf..d289359 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -89,6 +89,8 @@
 #define PRID_IMP_34K		0x9500
 #define PRID_IMP_24KE		0x9600
 #define PRID_IMP_74K		0x9700
+#define PRID_IMP_LOONGSON1      0x4200
+#define PRID_IMP_LOONGSON2      0x6300
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -200,7 +202,10 @@
 #define CPU_SB1A		62
 #define CPU_74K			63
 #define CPU_R14000		64
-#define CPU_LAST		64
+#define CPU_LOONGSON1           65
+#define CPU_LOONGSON2           66
+
+#define CPU_LAST		66
 
 /*
  * ISA Level encodings
-- 
1.5.2.1
