Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2009 05:11:39 +0000 (GMT)
Received: from yw-out-1718.google.com ([74.125.46.158]:54105 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20808163AbZCJFLe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Mar 2009 05:11:34 +0000
Received: by yw-out-1718.google.com with SMTP id 5so878840ywm.24
        for <multiple recipients>; Mon, 09 Mar 2009 22:11:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ox/QT7fLQ77qQ17iFZ7GtoWdGE01c9E7NMXgyR5NX9U=;
        b=crKD7B14ww9qAg3ABFucJ9sRoMW9dTGoAYUb0edJ7RNOMLw+hxMKXS8Nk0T1yL9XgG
         ZjZqqF4GCUBRKmbdX+0aFBeRreWrffO/LH5mq6zckzDeRAK8jXPd8J1zE9ghPjeURUiM
         shVqUHjsFUI8YWJ28tXoXO+xhOoxE2ENG7bHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GMLpsBDs+C6JLiTkzBIiB8MtHOLh0YsNhWB8lTCfZHgwTZXjQQ6xP1GyCHboptPTao
         M4T5Tc+4njjPJdS2YhvaHfWSTK9OpA0Q2Ssn1QETIMKaxOKaB4FLRPBOMtOhHdKV4wvo
         QnErs76c1iJtvol1AjxzkZFTkRXtxB2siQmss=
Received: by 10.100.44.4 with SMTP id r4mr4187806anr.100.1236661891410;
        Mon, 09 Mar 2009 22:11:31 -0700 (PDT)
Received: from localhost.localdomain (ppp-70-225-161-38.dsl.chmpil.ameritech.net [70.225.161.38])
        by mx.google.com with ESMTPS id c23sm8940194ana.52.2009.03.09.22.11.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Mar 2009 22:11:30 -0700 (PDT)
From:	Stoyan Gaydarov <stoyboyker@gmail.com>
To:	linux-kernel@vger.kernel.org
Cc:	Stoyan Gaydarov <stoyboyker@gmail.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: [PATCH 06/25] [mips] BUG to BUG_ON changes
Date:	Tue, 10 Mar 2009 00:10:31 -0500
Message-Id: <1236661850-8237-7-git-send-email-stoyboyker@gmail.com>
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1236661850-8237-6-git-send-email-stoyboyker@gmail.com>
References: <1236661850-8237-1-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-2-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-3-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-4-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-5-git-send-email-stoyboyker@gmail.com>
 <1236661850-8237-6-git-send-email-stoyboyker@gmail.com>
Return-Path: <stoyboyker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stoyboyker@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>
---
 arch/mips/jazz/jazzdma.c |    3 +--
 arch/mips/kernel/traps.c |    3 +--
 arch/mips/mm/ioremap.c   |    9 +++------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index c672c08..f0fd636 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -68,8 +68,7 @@ static int __init vdma_init(void)
 	 */
 	pgtbl = (VDMA_PGTBL_ENTRY *)__get_free_pages(GFP_KERNEL | GFP_DMA,
 						    get_order(VDMA_PGTBL_SIZE));
-	if (!pgtbl)
-		BUG();
+	BUG_ON(!pgtbl);
 	dma_cache_wback_inv((unsigned long)pgtbl, VDMA_PGTBL_SIZE);
 	pgtbl = (VDMA_PGTBL_ENTRY *)KSEG1ADDR(pgtbl);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b2d7041..89956d5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1277,8 +1277,7 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 	u32 *w;
 	unsigned char *b;
 
-	if (!cpu_has_veic && !cpu_has_vint)
-		BUG();
+	BUG_ON(!cpu_has_veic && !cpu_has_vint);
 
 	if (addr == NULL) {
 		handler = (unsigned long) do_default_vi;
diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index 59945b9..0c43248 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -27,8 +27,7 @@ static inline void remap_area_pte(pte_t * pte, unsigned long address,
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		if (!pte_none(*pte)) {
@@ -52,8 +51,7 @@ static inline int remap_area_pmd(pmd_t * pmd, unsigned long address,
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	phys_addr -= address;
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		pte_t * pte = pte_alloc_kernel(pmd, address);
 		if (!pte)
@@ -75,8 +73,7 @@ static int remap_area_pages(unsigned long address, phys_t phys_addr,
 	phys_addr -= address;
 	dir = pgd_offset(&init_mm, address);
 	flush_cache_all();
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
 	do {
 		pud_t *pud;
 		pmd_t *pmd;
-- 
1.6.1.3
