Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 17:12:58 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:12876 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039583AbWJPQMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 17:12:24 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2530932nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=CqkZqKrIBC8WtGz5g8pEs6WOu8sJhj+H6PrRJ60ayvZFjlLX48XUBKuqhQkXMTh/STf3Axkcc/QWC60M29XnRijRTM/VNr4mgoOhz8YLFziY2h9Bg4oXNCB0HJ7bk4dUBVVvDHhS8j47GrsJbk6n1zQ8/baLdfEZc0HO1Ynz/SM=
Received: by 10.49.8.15 with SMTP id l15mr12454580nfi;
        Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l38sm1142394nfc.2006.10.16.09.12.18;
        Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id E3FA523F76F; Mon, 16 Oct 2006 18:12:21 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for 64 bit kernels
Date:	Mon, 16 Oct 2006 18:12:16 +0200
Message-Id: <11610151413935-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1161015141975-git-send-email-fbuihuu@gmail.com>
References: <1161015141975-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12972
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
index fa4e4d9..df3a87e 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -133,8 +133,13 @@ #endif /* !__ASSEMBLY__ */
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
+#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
+#define __pa_page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
+#else
+#define __pa_page_offset(x)	PAGE_OFFSET
+#endif
+#define __pa(x)			((unsigned long)(x) - __pa_page_offset(x))
+#define __va(x)			((void *)((unsigned long)(x) + PAGE_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-- 
1.4.2.3
