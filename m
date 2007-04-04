Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:34:57 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:21991 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022086AbXDDObS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:18 +0100
Received: (qmail 16917 invoked by uid 511); 4 Apr 2007 14:30:20 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:20 -0000
Message-ID: <554353.261224122-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 6/16] define Hit_Invalidate_I to Index_Invalidate_I for loongson2
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-413557.267355831"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-413557.267355831
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


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
1.4.4.4



------MIME delimiter for sendEmail-413557.267355831--
