Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 04:03:05 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:61018 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026315AbZELDC7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 04:02:59 +0100
Received: by pxi17 with SMTP id 17so81472pxi.22
        for <multiple recipients>; Mon, 11 May 2009 20:02:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=jM57I49SF87IRx4TBxDTGnIGFreEzEupQ+XeOTd6Idc=;
        b=uXS2BwdU9NqNbVy1+vAOps90EeI86VF77NbU5PE4DZFxFAdf+58CZW4RaNJDCHbY5i
         abhBn04NhSkJlAuWw8BTvf19brCfKP74xFO6Ebcu41UwmZ8zB9MbF1vEG6S2BngQqx7+
         PEIoT3TUYIINmsBB7CCr1e+LJLD69qbtvrYR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=RHEyHlISjhHXx7Cik3q/wi3SzYEYdkWlIzS+MIk6HJvJ+ddR8e4GtwqvHGouxCHD8F
         /l0hvMvBrOw97OOTeZVFrzZgaCghSbEuZrKClNbe0XwB4Jch1/JXUH6aHUeD1VokQpag
         3eQJjw/60phHkrAVTBB+MsIvgVfe/WQMaYkTk=
Received: by 10.114.158.1 with SMTP id g1mr5943470wae.126.1242097372038;
        Mon, 11 May 2009 20:02:52 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id l27sm6781361waf.55.2009.05.11.20.02.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 20:02:51 -0700 (PDT)
Subject: [PATCH] Fix warning: incompatible argument type of virt_to_phys
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>, zhangfx@lemote.com,
	yanh@lemote.com
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 12 May 2009 11:02:43 +0800
Message-Id: <1242097363.4890.4.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From f326164c8ef7950abc1e7bbe0a7490d6d69e2f73 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Tue, 12 May 2009 10:46:07 +0800
Subject: [PATCH 2/2] Fix warning: incompatible argument type of
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
