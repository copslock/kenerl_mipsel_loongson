Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:31:34 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:18919 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021835AbXDDObL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:11 +0100
Received: (qmail 16924 invoked by uid 511); 4 Apr 2007 14:30:20 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:20 -0000
Message-ID: <8477.97710181908-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 8/16] define MODULE_PROC_FAMILY for Loongson2
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-49769.2807848615"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-49769.2807848615
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


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
1.4.4.4



------MIME delimiter for sendEmail-49769.2807848615--
