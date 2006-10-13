Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:39:49 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:48362 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038799AbWJMMjK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:39:10 +0100
Received: by nf-out-0910.google.com with SMTP id a25so860038nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=kyVJDgCQB6PU9u/ei2OCjczwarCIXus7YjmT8C1EML6aV8ZuHXGWTR+xZw+MEkNcGumPGIpkD27xf4Q2NJ+91eBqUlNtuv4VZ8hiefPtRn+iCYFI5BRs+zh19aYxQvc3iqyc8CJ6xaTl/90MhSIhiIf55s8L8k1iIwulQHM0/Lg=
Received: by 10.49.55.13 with SMTP id h13mr6924582nfk;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id a23sm861046nfc.2006.10.13.05.39.08;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 76A3823F76F; Fri, 13 Oct 2006 14:39:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for 64 bit kernels
Date:	Fri, 13 Oct 2006 14:39:01 +0200
Message-Id: <1160743146824-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11607431461469-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

During early boot mem init, some configs couldn't use __pa() to
convert virtual into physical addresses. Specially for 64 bit
kernel cases when CONFIG_BUILD_ELF64=n. This patch make __pa()
work for _all_ configs and thus make CPHYSADDR() useless.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/page.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 0821eb0..5da4733 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -131,8 +131,13 @@ #endif /* !__ASSEMBLY__ */
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
+#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
+#define __page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
+#else
+#define __page_offset(x)	PAGE_OFFSET
+#endif
+#define __pa(x)			((unsigned long)(x) - __page_offset(x))
+#define __va(x)			((void *)((unsigned long)(x) + __page_offset(x)))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-- 
1.4.2.3
