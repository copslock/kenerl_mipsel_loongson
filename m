Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:27:33 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:9945 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022619AbXDOP03 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:26:29 +0100
Received: (qmail 19447 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 5/16] add MACH_GROUP_LEMOTE & MACH_LEMOTE_FULONG
Date:	Sun, 15 Apr 2007 23:25:54 +0800
Message-Id: <11766507661526-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11766507661133-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 include/asm-mips/bootinfo.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index c7c945b..f4607f1 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -213,6 +213,12 @@
 #define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
 #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
 
+/*
+ * Valid machtype for group LEMOTE
+ */
+#define MACH_GROUP_LEMOTE          27
+#define  MACH_LEMOTE_FULONG        0
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
-- 
1.4.4.1
