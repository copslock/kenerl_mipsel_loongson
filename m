Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 08:27:09 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.235]:50323 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20026831AbXJRH1B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 08:27:01 +0100
Received: by hu-out-0506.google.com with SMTP id 31so112284huc
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 00:26:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uZW4U0XP5+LW043WKSPpgH/+ntqjW3uAVrLfPz1IZSk=;
        b=ts6vjk0/5ti/Xs2pYfATAatyOXDDQ0bQ+8W0fzTmMk9kUko+Y238Lnbr5PXhBlcWIvbYWtH7ygf7TXxxO8WDQfuytwwenYjPxq0YHjlO9F+5NS/GK4QLqlFo0Val7BngJ/NsshrsAz+VvbHZFVfLTEul28ITb2XFjc+7LLTCQE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WKh1N577QrU3OgUdIZBKivoDElEhPGU2rhBqKBc73sGFB+KKdcWp4HDVjg4/08tLM7DFSXGiIBvydB7ZQyEWADCDsgDag1j5ClnJXgJYr+gC847jABaWA9RDWc5lAZkpLK9qcLi5bxv1mJPFqyX50DTUWvimeB/XVqr/AiFdPmM=
Received: by 10.86.26.11 with SMTP id 11mr198759fgz.1192691558707;
        Thu, 18 Oct 2007 00:12:38 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id m1sm814856fke.2007.10.18.00.12.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 00:12:37 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 2/4] tlbex.c: cleanup include files
Date:	Thu, 18 Oct 2007 09:11:15 +0200
Message-Id: <1192691477-4675-3-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
References: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 7f60e9c..aa14343 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -19,20 +19,11 @@
  * (Condolences to Napoleon XIV)
  */
 
-#include <stdarg.h>
-
-#include <linux/mm.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/init.h>
 
-#include <asm/pgtable.h>
-#include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/inst.h>
 #include <asm/elf.h>
-#include <asm/smp.h>
 #include <asm/war.h>
 
 static inline int r45k_bvahwbug(void)
-- 
1.5.3.4
