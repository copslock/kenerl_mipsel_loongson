Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:36:56 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:21223 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022094AbXDDOcD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:32:03 +0100
Received: (qmail 16920 invoked by uid 511); 4 Apr 2007 14:30:20 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:20 -0000
Message-ID: <215567.009846808-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 7/16] add Loongson processor definitions
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-434393.153599562"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-434393.153599562
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


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
1.4.4.4



------MIME delimiter for sendEmail-434393.153599562--
