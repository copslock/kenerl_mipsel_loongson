Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:00:01 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.242]:16400 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023285AbZEOV7t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 22:59:49 +0100
Received: by rv-out-0708.google.com with SMTP id k29so1215076rvb.24
        for <multiple recipients>; Fri, 15 May 2009 14:59:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=hkKjcNJHPrSOypiHB8get6qF4/fKMjHgGZP/PsTns48=;
        b=PYjMTdpJXbIJvpUfgPueRsXxnwK7fBKABy30dcWyWCsZSaBQyOICwr+QPFJXjioS0G
         zHKQR4NwTfNnIQyl17FB1z3sLzll5jSjjhXKRS0MDcuZkBxnN4kYb8rJCXVXpFGqzEDa
         wB+buleYAkXG3Iof424OUlWliRv9hqLD214HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BjuVc8uiDtKVAiqTJjPjBbRbtvKg3IwyDHcPOdQbuLIWIZkPF3oKpSxBSQ/d0Ea+RE
         AGsAuYVZkD+fGUKyU3OsCEt9hafV3/lU/ogFReeepD95X6aSGT3xd1XO3DWdC+zXn94A
         qR45aeYpXkQSIF2UblTd0ZitaIvfg024Ye5ug=
Received: by 10.141.154.8 with SMTP id g8mr1553399rvo.88.1242424788114;
        Fri, 15 May 2009 14:59:48 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id k41sm5171925rvb.17.2009.05.15.14.59.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 14:59:47 -0700 (PDT)
Subject: [PATCH 02/30] Fix warning: incompatible argument type of
 virt_to_phys
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 05:59:25 +0800
Message-Id: <1242424765.10164.141.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From f326164c8ef7950abc1e7bbe0a7490d6d69e2f73 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Tue, 12 May 2009 10:46:07 +0800
Subject: [PATCH 02/30] Fix warning: incompatible argument type of
virt_to_phys
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

mm/page_alloc.c:1760: warning: passing argument 1 of ‘virt_to_phys’
makes pointer from integer without a cast

mm/page_alloc.c:1760
	...
	unsigned long addr;
	...
	split_page(virt_to_page(addr), order);

arch/mips/include/asm/page.h

	#define virt_to_page(kaddr) pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
	#define virt_addr_valid(kaddr)
pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))

arch/mips/include/asm/io.h
	static inline unsigned long virt_to_phys(volatile const void *address)
---
 arch/mips/include/asm/page.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index fe7a88e..15d93ec 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -176,8 +176,8 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #endif
 
-#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
-#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
+#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys((void
*)kaddr)))
+#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys((void
*)kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-- 
1.6.2.1
