Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 14:35:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:6635 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023175AbXJJNfV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 14:35:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9ADZJgf006395;
	Wed, 10 Oct 2007 14:35:19 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9ADZJMD006394;
	Wed, 10 Oct 2007 14:35:19 +0100
Date:	Wed, 10 Oct 2007 14:35:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] Add assembler equivalents to __init{,date}_refok
Message-ID: <20071010133519.GA6237@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

---
I need __INIT_REFOK to fix a MODPOST warning for a few MIPS configs which
have to call init code from .text very early in the game due to bootloader
issues.  __INITDATA_REFOK is just for consistency.

 include/linux/init.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/init.h b/include/linux/init.h
index 74b1f43..031edcc 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -66,8 +66,10 @@
 
 /* For assembly routines */
 #define __INIT		.section	".init.text","ax"
+#define __INIT_REFOK	.section	".text.init.refok","ax"
 #define __FINIT		.previous
 #define __INITDATA	.section	".init.data","aw"
+#define __INITDATA_REFOK .section	".data.init.refok","aw"
 
 #ifndef __ASSEMBLY__
 /*
