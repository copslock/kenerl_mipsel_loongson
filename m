Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:02:52 +0100 (BST)
Received: from mail-pz0-f134.google.com ([209.85.222.134]:60549 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024627AbZEZTCq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:02:46 +0100
Received: by pzk40 with SMTP id 40so3717361pzk.22
        for <multiple recipients>; Tue, 26 May 2009 12:02:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=230mElEDum++8i0fzb0dYnFrkeSdyNZuydbhkNKPEXY=;
        b=EHwTH3Wgeh04uJc5h6+5By0zpn8iulHEzXU9hDqNpA2tRfhocQjT2MgYRn7RSg4hYB
         OtddWRGuqSOfBSGNFOGvYIKKm5Y9Bafhy6AG1SGGjN8rCtzTpwE7zeSASn3S90P27AYF
         Wi1VG1KFOj3xNr2DL9pQaC8abywEmi01SHpbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vaKVF8H751tkvHYbyTEW1w25qN4P4GvgyLjMiOLkOWbRnJf8yBOqBy/Lhtm1eI05my
         dDemO5zfq6SzPmR9z12aRtz7BczgUEQMVFykeegGjeckXZw2FoThDzj1Xl0JQqc45x8D
         LKXQCn5KzNXyfVqIH0XimfL+zt2bhV8LiDX0c=
Received: by 10.115.54.7 with SMTP id g7mr17933197wak.69.1243364559298;
        Tue, 26 May 2009 12:02:39 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id m17sm11986819waf.68.2009.05.26.12.02.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:02:38 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 02/23] fix-warning: incompatible argument type of virt_to_phys
Date:	Wed, 27 May 2009 03:02:23 +0800
Message-Id: <812c8acb5148d8da2167a9dd849e9b0ec1193267.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22976
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
