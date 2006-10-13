Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:42:37 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:29165 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038829AbWJMMjM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:39:12 +0100
Received: by nf-out-0910.google.com with SMTP id a25so860042nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=pIa30hEnMSrRi3EdsouNoKrVf2LHSy/kZY+b4lpwHMIjbhcqscYI0GVO05kL7EkiQDozliPqHrWJpH7veUd7Xt0o/amUFFGN7FIUwMQmBXfgGRpsdRjTxiuFpusGx0JFH+/gThVVwoby/AyeCFZqlaiHVt+nsQ8ejFOlBBgR7qE=
Received: by 10.82.126.5 with SMTP id y5mr532296buc;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k24sm880251nfc.2006.10.13.05.39.09;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id C08CA23F772; Fri, 13 Oct 2006 14:39:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 4/7] Introduce __pa_symbol()
Date:	Fri, 13 Oct 2006 14:39:03 +0200
Message-Id: <11607431462945-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11607431461469-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12937
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
index 5da4733..662e009 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -137,6 +137,7 @@ #else
 #define __page_offset(x)	PAGE_OFFSET
 #endif
 #define __pa(x)			((unsigned long)(x) - __page_offset(x))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define __va(x)			((void *)((unsigned long)(x) + __page_offset(x)))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-- 
1.4.2.3
