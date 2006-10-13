Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:40:44 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:48362 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038813AbWJMMjL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:39:11 +0100
Received: by nf-out-0910.google.com with SMTP id a25so860038nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 05:39:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=AqeZUbPfte2zhdDbQxDD85cOUtqjGiYzLCSR++qwicEXW6x223DEYTBawKiDf0DXJwONJw84qtACRTuCw+838hjGIQqe7M6pY/A4KsVr5KBwIEwNCC6ZvKy96RSRbjiY4DRjjlkan2DFsRsh7Lyvm6wks3IHzh6+V6C8yUI2iLc=
Received: by 10.49.19.18 with SMTP id w18mr6936574nfi;
        Fri, 13 Oct 2006 05:39:10 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm898297nfc.2006.10.13.05.39.10;
        Fri, 13 Oct 2006 05:39:10 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id E337B23F759; Fri, 13 Oct 2006 14:39:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 5/7] setup.c: use __pa_symbol() where needed
Date:	Fri, 13 Oct 2006 14:39:04 +0200
Message-Id: <11607431463774-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11607431461469-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

It should fix the broken code in resource_init() too.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 00d62bd..84faa4b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -256,7 +256,7 @@ static void __init bootmem_init(void)
 	 * of usable memory.
 	 */
 	reserved_end = init_initrd();
-	reserved_end = PFN_UP(__pa(max(reserved_end, (unsigned long)&_end)));
+	reserved_end = PFN_UP(max(__pa(reserved_end), __pa_symbol(&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
@@ -428,10 +428,10 @@ static void __init resource_init(void)
 	if (UNCAC_BASE != IO_BASE)
 		return;
 
-	code_resource.start = virt_to_phys(&_text);
-	code_resource.end = virt_to_phys(&_etext) - 1;
-	data_resource.start = virt_to_phys(&_etext);
-	data_resource.end = virt_to_phys(&_edata) - 1;
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext) - 1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata) - 1;
 
 	/*
 	 * Request address space for all standard RAM.
-- 
1.4.2.3
