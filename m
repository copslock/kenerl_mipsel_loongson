Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:31:30 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:13785 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022663AbXDOP11 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:27:27 +0100
Received: (qmail 19442 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 4/16] TO_PHYS_MASK for loongson2
Date:	Sun, 15 Apr 2007 23:25:53 +0800
Message-Id: <11766507661133-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11766507662638-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/addrspace.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index 964c5ed..a4d9a07 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -145,7 +145,7 @@
 #define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
-#if defined (CONFIG_CPU_R10000)
+#if defined (CONFIG_CPU_R10000) || defined (CONFIG_CPU_LOONGSON2)
 #define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
-- 
1.4.4.1
