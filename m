Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 05:43:48 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:8684 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022030AbXFFEnC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 05:43:02 +0100
Received: (qmail 26335 invoked by uid 511); 6 Jun 2007 04:50:08 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 04:50:08 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH] work around for more than 256MB memory support
Date:	Wed,  6 Jun 2007 12:42:42 +0800
Message-Id: <11811049641189-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811049622818-git-send-email-tiansm@lemote.com>
References: <11811049622818-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 drivers/char/mem.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc9a9d0..a19b46a 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -82,8 +82,12 @@ static inline int uncached_access(struct file *file, unsigned long addr)
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
1.5.2.1
