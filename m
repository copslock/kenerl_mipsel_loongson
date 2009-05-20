Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:49:58 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:43711 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025156AbZETVtu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:49:50 +0100
Received: by pzk40 with SMTP id 40so623826pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:49:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zD3WymBm4fRS34QwdE8ZMoGcBWsyZRkrTQe8dCBtabo=;
        b=pveHPXd/IJn1wLQrgkX5WgzDWejLIHqeeNrfqCra/u1zfZ2UwlzTDpZ1nmKcbV4fGs
         avyCeyA1HusyNzeuaPlcSshUpjuF1NR1aYCO0iAuvnw2vqs1WJve79/q9qLnCYJ2Vno3
         MLxfUFI1UUd2Nj828MQ1XNSgeVLRgfLSxuAgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NQaY6WA8ED9w97auTPINK3LV+lw3LXtrcI2iaYZR6jhZgo8hpDqNltWOz15XZCIngY
         uKqh6kx6dpNGZdvreFBc5e5EVthqt+sYC7Fd7ZXKFl/nDxK/+Hu1+VUr3rPt+kiz0yuK
         4hmjgrkSeqWZz5KxGKCgj9YumnnZGyMl/f9JM=
Received: by 10.114.58.12 with SMTP id g12mr3577661waa.40.1242856183176;
        Wed, 20 May 2009 14:49:43 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id l28sm3922014waf.19.2009.05.20.14.49.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:49:42 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 02/27] fix-warning: incompatible argument type of virt_to_phys
Date:	Thu, 21 May 2009 05:49:30 +0800
Message-Id: <0e7026092faebce7caf6bfe9807146cffcd8842a.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

mm/page_alloc.c:1760: warning: passing argument 1 of ‘virt_to_phys’
makes pointer from integer without a cast

mm/page_alloc.c:1760
	...
	unsigned long addr;
	...
	split_page(virt_to_page(addr), order);

arch/mips/include/asm/page.h

	#define virt_to_page(kaddr) pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
	#define virt_addr_valid(kaddr)  pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))

arch/mips/include/asm/io.h
	static inline unsigned long virt_to_phys(volatile const void *address)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/page.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index fe7a88e..ee37e58 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -176,8 +176,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #endif
 
-#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
-#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
+#define virt_to_page(kaddr) \
+	pfn_to_page(PFN_DOWN(virt_to_phys((void *)kaddr)))
+#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys((void *)kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-- 
1.6.2.1
