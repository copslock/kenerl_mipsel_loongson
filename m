Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:43:48 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:25359 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022524AbXFDPmV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:42:21 +0100
Received: by ug-out-1314.google.com with SMTP id m3so851234ugc
        for <linux-mips@linux-mips.org>; Mon, 04 Jun 2007 08:41:20 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=szTJG0icWA/dOFQHlzBC7v1Bw2DvRPsBWHeEqOObXJIt7sEiiCH8+eh+qPxfUwVaPJt5bSzQo1rJRz6OaYtnTby84uVOuHfno+ZU77HxAjyXMhG/TCdhFLKNQCar/8X8ZjFoTxaCE4fqu0J0ittJR5dITGsYiyQaJ69UWTLmgOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=CvJ+4yH1ZedFC7eQD8+3Sm4rWuRzJjvYMmF05i1IBJCor6w1YWt4DYc4UGru7pzOJzeinyMfFifNf8QS4pTlTjwVVOYdZKw/541CH5nTMuMqYKoDUitk5vu+mXxRLs8ENJwjrYSspNMEiwg+v0LyqcwutWaPiXVPL6a4ywTuv3U=
Received: by 10.67.22.14 with SMTP id z14mr3185186ugi.1180971680504;
        Mon, 04 Jun 2007 08:41:20 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id z33sm1053147ikz.2007.06.04.08.41.19;
        Mon, 04 Jun 2007 08:41:19 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id B0E7923F774; Mon,  4 Jun 2007 17:46:36 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 5/5] Fix PHYS_OFFSET for 64-bits kernels with 32-bits symbols
Date:	Mon,  4 Jun 2007 17:46:35 +0200
Message-Id: <11809719962417-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1180971995757-git-send-email-fbuihuu@gmail.com>
References: <1180971995757-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15243
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
index 09c60d5..b92dd8c 100644
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
1.5.1.4
