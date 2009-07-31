Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2009 23:02:08 +0200 (CEST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:54578 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493872AbZGaVCB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2009 23:02:01 +0200
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6VKwRfY010906;
	Fri, 31 Jul 2009 16:58:27 -0400 (EDT)
Received: from localhost (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6VKwQTY019234;
	Fri, 31 Jul 2009 16:58:26 -0400 (EDT)
From:	Tim Abbott <tabbott@ksplice.com>
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Anders Kaseorg <andersk@ksplice.com>,
	Nelson Elhage <nelhage@ksplice.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] mips: make page.h constants available to assembly.
Date:	Fri, 31 Jul 2009 16:58:17 -0400
Message-Id: <1249073899-30145-1-git-send-email-tabbott@ksplice.com>
X-Mailer: git-send-email 1.6.3.3
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@ksplice.com
Precedence: bulk
X-list: linux-mips

From: Nelson Elhage <nelhage@ksplice.com>

page.h includes ifndef __ASSEMBLY__ guards, but PAGE_SIZE and some other
constants are defined using "1UL", which the assembler does not
support. Use the _AC macro from const.h to make them available to
assembly (and linker scripts).

Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/page.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 96a14a4..939ed8b 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -10,6 +10,7 @@
 #define _ASM_PAGE_H
 
 #include <spaces.h>
+#include <linux/const.h>
 
 /*
  * PAGE_SHIFT determines the page size
@@ -29,11 +30,11 @@
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PAGE_SHIFT	16
 #endif
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
 
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
-#define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
+#define HPAGE_SIZE	(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 
-- 
1.6.3.3
