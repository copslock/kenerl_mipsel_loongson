Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:26:25 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:7129 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022598AbXDOP0X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:26:23 +0100
Received: (qmail 19499 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 15/16] work around for more than 256MB memory support
Date:	Sun, 15 Apr 2007 23:26:04 +0800
Message-Id: <11766507672043-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11766507672298-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com> <11766507661526-git-send-email-tiansm@lemote.com> <11766507662650-git-send-email-tiansm@lemote.com> <11766507661684-git-send-email-tiansm@lemote.com> <117665076617-git-send-email-tiansm@lemote.com> <1176650766907-git-send-email-tiansm@lemote.com> <11766507663301-git-send-email-tiansm@lemote.com> <11766507663039-git-send-email-tiansm@lemote.com> <1176650766685-git-send-email-tiansm@lemote.com> <11766507661790-git-send-email-tiansm@lemote.com> <11766507672298-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14840
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
1.4.4.1
