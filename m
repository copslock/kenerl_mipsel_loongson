Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 11:21:57 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:5245 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021713AbXC0KUs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 11:20:48 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2049673uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 03:19:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=aI8Y5XZdot2kFk6MqMcS2JWjg+QXLpUYp/C3wWtRlpwXvZ2lJHUB+vWthxfhu8MU0twI1hXHssp1ykq2+WaGigeVMsdofHl2G1bFV1FAp7CQb/JnySjEYHJo5G1LXsTsAuuZPXhAC/Y/i8Hh7cZKloB39XZMW0ZghNIzOsSFOjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Pmqq0ieJkTHoaT3fOvqcVCqj0gwtoggbcJgR/i7sGGUjA/yZMHoth4OtIg6Tg5C176bHoSn73faSSaf5j9+JkLxQ7SA4OzJC3IkjxHvGBdESYVtcKjpHPECwSr4JQeBeou7dZAkBJlXx4PqdsSUKmAA+hwvra0TdB94+r5T6m98=
Received: by 10.67.22.14 with SMTP id z14mr736767ugi.1174990787506;
        Tue, 27 Mar 2007 03:19:47 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id j34sm6834237ugc.2007.03.27.03.19.45;
        Tue, 27 Mar 2007 03:19:46 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id AD1EB23F774; Tue, 27 Mar 2007 11:19:41 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 4/4] Fix PHYS_OFFSET for 64-bits kernels with 32-bits symbols
Date:	Tue, 27 Mar 2007 11:19:40 +0200
Message-Id: <1174987181101-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
In-Reply-To: <11749871802730-git-send-email-fbuihuu@gmail.com>
References: <11749871802730-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

The current implementation of __pa() for 64-bits kernels with 32-bits
symbols is broken. In this configuration, we need 2 values for
PAGE_OFFSET, one in XKPHYS and the other in CKSEG0 space.

When the value in CKSEG0 space is used, it doesn't take into account
of PHYS_OFFSET. Even worse we can't redefine this value.

The patch restores CPHYSADDR() but in __pa()'s implementation because
it removes the need of 2 PAGE_OFFSET.

OTOH, CPHYSADDR() is quite bad when dealing with mapped kernels. So
this patch assumes there's no need to deal with such kernel in 64-bits
world.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/page.h |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index cc28a4f..62ee3d5 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -143,11 +143,15 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  * __pa()/__va() should be used only during mem init.
  */
 #if defined(CONFIG_64BIT) && !defined(CONFIG_BUILD_ELF64)
-#define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
+#define __pa(x)								\
+({									\
+    unsigned long __x = (unsigned long)(x);				\
+    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
+})
 #else
-#define __pa_page_offset(x)	PAGE_OFFSET
+#define __pa(x)								\
+    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
 #endif
-#define __pa(x)		((unsigned long)(x) - __pa_page_offset(x) + PHYS_OFFSET)
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x),0))
 
-- 
1.5.1.rc1.27.g1d848
