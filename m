Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:31:07 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:14297 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022651AbXDOP1Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:27:25 +0100
Received: (qmail 19463 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 7/16] add Loongson processor definitions
Date:	Sun, 15 Apr 2007 23:25:56 +0800
Message-Id: <11766507661684-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11766507662650-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com> <11766507661526-git-send-email-tiansm@lemote.com> <11766507662650-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14852
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
1.4.4.1
