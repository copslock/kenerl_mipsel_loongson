Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:32:41 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:18663 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021987AbXDDObN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:13 +0100
Received: (qmail 16911 invoked by uid 511); 4 Apr 2007 14:30:20 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:20 -0000
Message-ID: <927241.817207204-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 4/16] TO_PHYS_MASK for loongson2
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-696152.640347467"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-696152.640347467
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


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
1.4.4.4



------MIME delimiter for sendEmail-696152.640347467--
