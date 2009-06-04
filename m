Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:01:02 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:41739 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022564AbZFDNAe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:00:34 +0100
Received: by mail-pz0-f202.google.com with SMTP id 40so735719pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:00:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=230mElEDum++8i0fzb0dYnFrkeSdyNZuydbhkNKPEXY=;
        b=P1u2P06laT0e1jVsgU1CI3V77cMBMj53J6pVefwHV5XlawX/P96o2XbB+8MK0/JRgT
         tPkmgAycGduCoUlx5QaKQTuYNUEwg5cipvh4GzO0geSRFgYB0x9ywnW7794Q/smChEpY
         xFUm97bAYdnb6crFXd5o6J8tvgOGlX0qp4FLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XL/UvcSisagrAEr9FdOCXbeuq/7P1P5YqMCtCK8eRIu1J4L6fKVdd642xaPuK7vxEt
         j69bUbTwPcPlPq6EB0+j1Io84oSK5MhGnzma3nMiUcBZTxPtUX2lKdr251u+LOlC2Fmr
         JppMxIv5qdrG9et72GzvMMx6X+5W6YLtAiJ7Q=
Received: by 10.114.103.1 with SMTP id a1mr3368764wac.218.1244120433422;
        Thu, 04 Jun 2009 06:00:33 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id m31sm3230344wag.69.2009.06.04.06.00.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:00:31 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 03/25] fix-warning: incompatible argument type of virt_to_phys
Date:	Thu,  4 Jun 2009 21:00:19 +0800
Message-Id: <ac55c17220fb6e382e862bac76cec87018de4b88.1244120172.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120172.git.wuzj@lemote.com>
References: <cover.1244120172.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

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
index 9f946e4..d148e87 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -179,8 +179,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #endif
 
-#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
-#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
+#define virt_to_page(kaddr) \
+	pfn_to_page(PFN_DOWN(virt_to_phys((void *)kaddr)))
+#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys((void *)kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-- 
1.6.0.4
