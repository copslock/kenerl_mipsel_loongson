Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:23:09 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:13536 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038419AbWJSLUK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:20:10 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1027111nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 04:20:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=IA+t21Pg0ohDPH9njTyzhFyhpgA3fdpz6hKqwyBIqoYbXqMNidp1Oac4rKYX31oC7ygzd6+HlYgPhn30NhDNNJrNmjsNKUPUxf+S8MAW9HTHvXiTZN84drihF/c2bEN2gN6J9DPQXRBcZ/XEnvlhn5ctkTDteVH9tIYS4wiR4/I=
Received: by 10.49.93.13 with SMTP id v13mr5593433nfl;
        Thu, 19 Oct 2006 04:20:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id o9sm872202nfa.2006.10.19.04.20.08;
        Thu, 19 Oct 2006 04:20:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 83D8523F772; Thu, 19 Oct 2006 13:20:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 5/7] setup.c: use __pa_symbol() where needed
Date:	Thu, 19 Oct 2006 13:20:03 +0200
Message-Id: <1161256806520-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11612568052624-git-send-email-fbuihuu@gmail.com>
References: <11612568052624-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13033
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
index 715451a..b52cc97 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -260,7 +260,7 @@ static void __init bootmem_init(void)
 	 * of usable memory.
 	 */
 	reserved_end = init_initrd();
-	reserved_end = PFN_UP(__pa(max(reserved_end, (unsigned long)&_end)));
+	reserved_end = PFN_UP(max(__pa(reserved_end), __pa_symbol(&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
@@ -432,10 +432,10 @@ static void __init resource_init(void)
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
