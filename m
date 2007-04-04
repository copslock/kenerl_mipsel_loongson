Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:33:26 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:20711 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022028AbXDDObO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:14 +0100
Received: (qmail 16945 invoked by uid 511); 4 Apr 2007 14:30:21 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:21 -0000
Message-ID: <499517.799911217-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 15/16] work around for more than 256MB memory support
Date:	Wed, 4 Apr 2007 14:38:20 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-226124.783353047"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-226124.783353047
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 drivers/char/mem.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index f5c160c..580ad3e 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -83,8 +83,12 @@ static inline int uncached_access(struct file *file, unsigned long addr)
 	 */
 	if (file->f_flags & O_SYNC)
 		return 1;
+#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
+	return (addr >= __pa(high_memory)) || ((addr >=0x10000000) && (addr < 0x20000000));
+#else
 	return addr >= __pa(high_memory);
 #endif
+#endif
 }
 
 #ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
-- 
1.4.4.4



------MIME delimiter for sendEmail-226124.783353047--
