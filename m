Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:20:31 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:18911 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038189AbWJSLUE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:20:04 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1027109nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=AYkah2C5lJ3GdtH1xwHYtltBBma7VfCoRTD4FG6OnuxO2CblOihsigaEwup9QfQu5TjPInsV9FNuavrrffljCOGrJPhstWt0ByIe9Fa3wpCSVzFwt3qYH7ly+BayWVlDlqITlrf+3DUOfMjOlY5hU4MQak25qZGBvNeOFoPCD5Q=
Received: by 10.49.91.6 with SMTP id t6mr5612656nfl;
        Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id n23sm851025nfc.2006.10.19.04.20.02;
        Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 7C19A23F770; Thu, 19 Oct 2006 13:20:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 4/7] Introduce __pa_symbol()
Date:	Thu, 19 Oct 2006 13:20:02 +0200
Message-Id: <11612568062682-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11612568052624-git-send-email-fbuihuu@gmail.com>
References: <11612568052624-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13027
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
index 119daee..5c4284b 100644
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
