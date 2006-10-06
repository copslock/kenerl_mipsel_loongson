Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 14:35:50 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:65078 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039042AbWJFNfp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Oct 2006 14:35:45 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1172375nfc
        for <linux-mips@linux-mips.org>; Fri, 06 Oct 2006 06:35:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=PUvzbMO2DBl/JUa7hfo3xhNZhiGRA7+Ybjbrr6CCezfpgPZP6scjW2ByiO6Ept6Wrh4g3dKoV4zHaWPlf2x29GJ7lOjdqInxUFnIWSrrwNmDfMBblPbmPvn+dosI3ZVW6gefS1I9QVMeS4M1QiEh7X8kWG851Dc92LVwf7ha+J8=
Received: by 10.49.8.1 with SMTP id l1mr5483971nfi;
        Fri, 06 Oct 2006 06:35:44 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id l38sm3589587nfc.2006.10.06.06.35.43;
        Fri, 06 Oct 2006 06:35:43 -0700 (PDT)
Message-ID: <45265BF0.8080103@innova-card.com>
Date:	Fri, 06 Oct 2006 15:36:48 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch introduces __pa_symbol() macro which should be used to
calculate the physical address of kernel symbols. We should fix any
linker issues in this macro, if any, but more importantly
__pa_symbol() uses __pa() to do the real conversion.

One resulting thing is that we can see that most of CPHYSADDR() uses
weren't needed.

It also rely on RELOC_HIDE() to avoid any compiler's oddities when
doing arithmetics on symbols.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   17 ++++++++++-------
 include/asm-mips/page.h  |    1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fdbb508..cccccd5 100644
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
@@ -256,7 +256,10 @@ static void __init bootmem_init(void)
 	 * of usable memory.
 	 */
 	reserved_end = init_initrd();
-	reserved_end = PFN_UP(CPHYSADDR(max(reserved_end, (unsigned long)&_end)));
+	if (reserved_end > (unsigned long)&_end)
+		reserved_end = PFN_UP(__pa(reserved_end));
+	else
+		reserved_end = PFN_UP(__pa_symbol(&_end));
 
 	/*
 	 * Find the highest page frame number we have available.
@@ -428,10 +431,10 @@ static void __init resource_init(void)
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
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 32e5625..1d5f4a3 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -132,6 +132,7 @@ #endif /* !__ASSEMBLY__ */
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
 #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-- 
1.4.2.3
