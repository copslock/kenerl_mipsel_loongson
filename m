Return-Path: <SRS0=gHsu=PY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBF7C43387
	for <linux-mips@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4DA206C2
	for <linux-mips@archiver.kernel.org>; Wed, 16 Jan 2019 13:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbfAPNra (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:47:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390761AbfAPNpn (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Wed, 16 Jan 2019 08:45:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0GDeZIo036454
        for <linux-mips@vger.kernel.org>; Wed, 16 Jan 2019 08:45:42 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q240wd0ww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@vger.kernel.org>; Wed, 16 Jan 2019 08:45:41 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 16 Jan 2019 13:45:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Jan 2019 13:45:26 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0GDjP6Z49348698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 13:45:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 632F711C052;
        Wed, 16 Jan 2019 13:45:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BC7111C050;
        Wed, 16 Jan 2019 13:45:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Jan 2019 13:45:21 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 16 Jan 2019 15:45:20 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 12/21] arch: use memblock_alloc() instead of memblock_alloc_from(size, align, 0)
Date:   Wed, 16 Jan 2019 15:44:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011613-0012-0000-0000-000002E8D1C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-0013-0000-0000-0000211FE9F4
Message-Id: <1547646261-32535-13-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The last parameter of memblock_alloc_from() is the lower limit for the
memory allocation. When it is 0, the call is equivalent to
memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/kernel/core_cia.c  |  2 +-
 arch/alpha/kernel/pci_iommu.c |  4 ++--
 arch/alpha/kernel/setup.c     |  2 +-
 arch/ia64/kernel/mca.c        |  3 +--
 arch/mips/kernel/traps.c      |  2 +-
 arch/sparc/kernel/prom_32.c   |  2 +-
 arch/sparc/mm/init_32.c       |  2 +-
 arch/sparc/mm/srmmu.c         | 10 +++++-----
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
index 867e873..466cd44 100644
--- a/arch/alpha/kernel/core_cia.c
+++ b/arch/alpha/kernel/core_cia.c
@@ -331,7 +331,7 @@ cia_prepare_tbia_workaround(int window)
 	long i;
 
 	/* Use minimal 1K map. */
-	ppte = memblock_alloc_from(CIA_BROKEN_TBIA_SIZE, 32768, 0);
+	ppte = memblock_alloc(CIA_BROKEN_TBIA_SIZE, 32768);
 	pte = (virt_to_phys(ppte) >> (PAGE_SHIFT - 1)) | 1;
 
 	for (i = 0; i < CIA_BROKEN_TBIA_SIZE / sizeof(unsigned long); ++i)
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index aa0f50d..e4cf77b 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -87,13 +87,13 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 		printk("%s: couldn't allocate arena ptes from node %d\n"
 		       "    falling back to system-wide allocation\n",
 		       __func__, nid);
-		arena->ptes = memblock_alloc_from(mem_size, align, 0);
+		arena->ptes = memblock_alloc(mem_size, align);
 	}
 
 #else /* CONFIG_DISCONTIGMEM */
 
 	arena = memblock_alloc(sizeof(*arena), SMP_CACHE_BYTES);
-	arena->ptes = memblock_alloc_from(mem_size, align, 0);
+	arena->ptes = memblock_alloc(mem_size, align);
 
 #endif /* CONFIG_DISCONTIGMEM */
 
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 4b5b1b2..5d4c76a 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -293,7 +293,7 @@ move_initrd(unsigned long mem_limit)
 	unsigned long size;
 
 	size = initrd_end - initrd_start;
-	start = memblock_alloc_from(PAGE_ALIGN(size), PAGE_SIZE, 0);
+	start = memblock_alloc(PAGE_ALIGN(size), PAGE_SIZE);
 	if (!start || __pa(start) + size > mem_limit) {
 		initrd_start = initrd_end = 0;
 		return NULL;
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 91bd1e1..74d148b 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1835,8 +1835,7 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 /* Caller prevents this from being called after init */
 static void * __ref mca_bootmem(void)
 {
-	return memblock_alloc_from(sizeof(struct ia64_mca_cpu),
-				   KERNEL_STACK_SIZE, 0);
+	return memblock_alloc(sizeof(struct ia64_mca_cpu), KERNEL_STACK_SIZE);
 }
 
 /* Do per-CPU MCA-related initialization.  */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index c91097f..2bbdee5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2291,7 +2291,7 @@ void __init trap_init(void)
 		phys_addr_t ebase_pa;
 
 		ebase = (unsigned long)
-			memblock_alloc_from(size, 1 << fls(size), 0);
+			memblock_alloc(size, 1 << fls(size));
 
 		/*
 		 * Try to ensure ebase resides in KSeg0 if possible.
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 42d7f2a..38940af 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -32,7 +32,7 @@ void * __init prom_early_alloc(unsigned long size)
 {
 	void *ret;
 
-	ret = memblock_alloc_from(size, SMP_CACHE_BYTES, 0UL);
+	ret = memblock_alloc(size, SMP_CACHE_BYTES);
 	if (ret != NULL)
 		memset(ret, 0, size);
 
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d900952..a8ff298 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -264,7 +264,7 @@ void __init mem_init(void)
 	i = last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
 	i += 1;
 	sparc_valid_addr_bitmap = (unsigned long *)
-		memblock_alloc_from(i << 2, SMP_CACHE_BYTES, 0UL);
+		memblock_alloc(i << 2, SMP_CACHE_BYTES);
 
 	if (sparc_valid_addr_bitmap == NULL) {
 		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b609362..a400ec3 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -303,13 +303,13 @@ static void __init srmmu_nocache_init(void)
 
 	bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
 
-	srmmu_nocache_pool = memblock_alloc_from(srmmu_nocache_size,
-						 SRMMU_NOCACHE_ALIGN_MAX, 0UL);
+	srmmu_nocache_pool = memblock_alloc(srmmu_nocache_size,
+					    SRMMU_NOCACHE_ALIGN_MAX);
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
 	srmmu_nocache_bitmap =
-		memblock_alloc_from(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
-				    SMP_CACHE_BYTES, 0UL);
+		memblock_alloc(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
+			       SMP_CACHE_BYTES);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
@@ -467,7 +467,7 @@ static void __init sparc_context_init(int numctx)
 	unsigned long size;
 
 	size = numctx * sizeof(struct ctx_list);
-	ctx_list_pool = memblock_alloc_from(size, SMP_CACHE_BYTES, 0UL);
+	ctx_list_pool = memblock_alloc(size, SMP_CACHE_BYTES);
 
 	for (ctx = 0; ctx < numctx; ctx++) {
 		struct ctx_list *clist;
-- 
2.7.4

