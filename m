Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:31:12 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:19943 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021836AbXDDObK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:10 +0100
Received: (qmail 16936 invoked by uid 511); 4 Apr 2007 14:30:21 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:21 -0000
Message-ID: <667328.695158602-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 12/16] cheat for support of more than 256MB memory
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-279305.257908167"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-279305.257908167
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/kernel/setup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4975da0..92a27bb 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -509,6 +509,14 @@ static void __init resource_init(void)
 		res->end = end;
 
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
+		/* to keep memory continous, we tell system 0x10000000 - 0x20000000 is reserved
+		 * for memory, in fact it is io region, don't occupy it
+		 *
+		 * SPARSEMEM? 
+		 */
+		if (boot_mem_map.map[i].type != BOOT_MEM_RESERVED)
+#endif
 		request_resource(&iomem_resource, res);
 
 		/*
-- 
1.4.4.4



------MIME delimiter for sendEmail-279305.257908167--
