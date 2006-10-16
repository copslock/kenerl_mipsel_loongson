Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 17:14:21 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:13132 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039625AbWJPQMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 17:12:24 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2530941nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 09:12:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=dQBDQHuWvZTWVt1yTXBLuLiizKVzlhnd7TrqyNGfmoOCqTnQARj6SK+u8SO0KEkzhpAI4YpxRmh3kYwB2M37Ofeg5Tm4S1OeiPUxyypMs52PTGqLUmeyK/2XksPKLuNTodieM3hCRZ7EdAmWmGM51IqYMs9cd6NOA6vIXG9qAFk=
Received: by 10.49.19.18 with SMTP id w18mr12436436nfi;
        Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id i1sm1143186nfe.2006.10.16.09.12.19;
        Mon, 16 Oct 2006 09:12:19 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 38E9223F772; Mon, 16 Oct 2006 18:12:22 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 4/7] Introduce __pa_symbol()
Date:	Mon, 16 Oct 2006 18:12:18 +0200
Message-Id: <11610151421902-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1161015141975-git-send-email-fbuihuu@gmail.com>
References: <1161015141975-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch introduces __pa_symbol() macro which should be used to
calculate the physical address of kernel symbols. It also relies
on RELOC_HIDE() to avoid any compiler's oddities when doing
arithmetics on symbols.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/page.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index df3a87e..2be5b4f 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -139,6 +139,7 @@ #else
 #define __pa_page_offset(x)	PAGE_OFFSET
 #endif
 #define __pa(x)			((unsigned long)(x) - __pa_page_offset(x))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define __va(x)			((void *)((unsigned long)(x) + PAGE_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-- 
1.4.2.3
