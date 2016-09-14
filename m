Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2016 17:32:07 +0200 (CEST)
Received: from conuserg-07.nifty.com ([210.131.2.74]:44575 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992940AbcINPcAYkki5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2016 17:32:00 +0200
Received: from grover.sesame (FL1-111-169-71-157.osk.mesh.ad.jp [111.169.71.157]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id u8EFV3Si012149;
        Thu, 15 Sep 2016 00:31:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com u8EFV3Si012149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1473867067;
        bh=DQESqf1BAqFYEoRcV4Yf+u+UbEzHdA7U+E11f4A/gGY=;
        h=From:To:Cc:Subject:Date:From;
        b=VAsIIfj/AKnWGeTClAeNOMnzCXb2kb/yzTc7xre0QJ4yrGjFG6lIoFS3U3Kd7y3hD
         Wz7Vy8z5SJeO1PKdrn7B0KrIo7R1RnyCt80VF7Vcfm0MWKo2U6hLdgNQSdSM22lrnK
         PNgmSjbN1XTCB5hf56StggkqukZAIk6N61uE248yzdj8L9KlTcZPB9o4Uu03XcrAHY
         W9VinYjZKsazK++PgdRzQVevVwDWxf4/UuOfBWOdafuZeTM1A88PxLXFfSQ6OK60mj
         XgtUI+e9XEYZIBJU3Zf6nj2nSpNNWVDHql4iFnGsQCLllH23N/FBKbNLDayhiorYWd
         XZZsptxuhU7mw==
X-Nifty-SrcIP: [111.169.71.157]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mips@linux-mips.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mips: squash lines for simple wrapper functions
Date:   Thu, 15 Sep 2016 00:31:01 +0900
Message-Id: <1473867061-9735-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Remove unneeded variables and assignments.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/include/asm/mach-generic/floppy.h | 6 +-----
 arch/mips/include/asm/pgalloc.h             | 6 +-----
 arch/mips/mti-malta/malta-platform.c        | 8 +-------
 arch/mips/pnx833x/common/platform.c         | 8 ++------
 4 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/floppy.h b/arch/mips/include/asm/mach-generic/floppy.h
index e2561d9..9ec2f6a 100644
--- a/arch/mips/include/asm/mach-generic/floppy.h
+++ b/arch/mips/include/asm/mach-generic/floppy.h
@@ -115,11 +115,7 @@ static inline unsigned long fd_getfdaddr1(void)
 
 static inline unsigned long fd_dma_mem_alloc(unsigned long size)
 {
-	unsigned long mem;
-
-	mem = __get_dma_pages(GFP_KERNEL, get_order(size));
-
-	return mem;
+	return __get_dma_pages(GFP_KERNEL, get_order(size));
 }
 
 static inline void fd_dma_mem_free(unsigned long addr, unsigned long size)
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 93c079a..a03e869 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -67,11 +67,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 	unsigned long address)
 {
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_ZERO, PTE_ORDER);
-
-	return pte;
+	return (pte_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER);
 }
 
 static inline struct page *pte_alloc_one(struct mm_struct *mm,
diff --git a/arch/mips/mti-malta/malta-platform.c b/arch/mips/mti-malta/malta-platform.c
index e1dd1c1..20a53e7 100644
--- a/arch/mips/mti-malta/malta-platform.c
+++ b/arch/mips/mti-malta/malta-platform.c
@@ -135,13 +135,7 @@ struct resource malta_rtc_resources[] = {
 
 static int __init malta_add_devices(void)
 {
-	int err;
-
-	err = platform_add_devices(malta_devices, ARRAY_SIZE(malta_devices));
-	if (err)
-		return err;
-
-	return 0;
+	return platform_add_devices(malta_devices, ARRAY_SIZE(malta_devices));
 }
 
 device_initcall(malta_add_devices);
diff --git a/arch/mips/pnx833x/common/platform.c b/arch/mips/pnx833x/common/platform.c
index 3cd3577..7cf4eb5 100644
--- a/arch/mips/pnx833x/common/platform.c
+++ b/arch/mips/pnx833x/common/platform.c
@@ -232,12 +232,8 @@ struct pnx8xxx_port pnx8xxx_ports[] = {
 
 static int __init pnx833x_platform_init(void)
 {
-	int res;
-
-	res = platform_add_devices(pnx833x_platform_devices,
-				   ARRAY_SIZE(pnx833x_platform_devices));
-
-	return res;
+	return platform_add_devices(pnx833x_platform_devices,
+				    ARRAY_SIZE(pnx833x_platform_devices));
 }
 
 arch_initcall(pnx833x_platform_init);
-- 
1.9.1
