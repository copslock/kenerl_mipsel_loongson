Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 12:20:56 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:13536 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038404AbWJSLUE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 12:20:04 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1027111nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 04:20:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=cjacj64wvvNYmtrHXHRi87DdKO7Ruh5+WtIq22SmER3aqKmYTBpUXOUTQN7B5OYIs1RCRUgDtmRQcoEBFwhiM+bf8MKg9Y9oEizMj4x+nx9BKf7ImoEfq0Yd4Kniw+SNT2yx9FVvZPaTYtSR3zWo01E1Ke8s/dQwF9lNEI5seXA=
Received: by 10.49.8.1 with SMTP id l1mr5657339nfi;
        Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id m15sm841016nfc.2006.10.19.04.20.03;
        Thu, 19 Oct 2006 04:20:03 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 53F2323F76F; Thu, 19 Oct 2006 13:20:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 3/7] setup.c: get ride of CPHYSADDR()
Date:	Thu, 19 Oct 2006 13:20:01 +0200
Message-Id: <11612568063333-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11612568052624-git-send-email-fbuihuu@gmail.com>
References: <11612568052624-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

and use new __pa() implementation instead introduced by the previous
patch. Indeed this macro can be used now even by the 64 bit kernels
with CONFIG_BUILD_ELF64=n config.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8f6e896..715451a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -204,12 +204,12 @@ static void __init finalize_initrd(void)
 		printk(KERN_INFO "Initrd not found or empty");
 		goto disable;
 	}
-	if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
 		printk("Initrd extends beyond end of memory");
 		goto disable;
 	}
 
-	reserve_bootmem(CPHYSADDR(initrd_start), size);
+	reserve_bootmem(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	printk(KERN_INFO "Initial ramdisk at: 0x%lx (%lu bytes)\n",
@@ -260,7 +260,7 @@ static void __init bootmem_init(void)
 	 * of usable memory.
 	 */
 	reserved_end = init_initrd();
-	reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned long)&_end)));
+	reserved_end = PFN_UP(__pa(max(reserved_end, (unsigned long)&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
-- 
1.4.2.3
