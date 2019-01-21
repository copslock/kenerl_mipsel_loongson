Return-Path: <SRS0=dr9w=P5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9ECC282E9
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 08:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B8520823
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 08:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfAUIGB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:06:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729912AbfAUIGB (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 21 Jan 2019 03:06:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0L83qPM072923
        for <linux-mips@vger.kernel.org>; Mon, 21 Jan 2019 03:05:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q580ddgm5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@vger.kernel.org>; Mon, 21 Jan 2019 03:05:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 21 Jan 2019 08:05:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 08:05:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0L85ioZ56623206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 08:05:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A5794C059;
        Mon, 21 Jan 2019 08:05:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FCA34C046;
        Mon, 21 Jan 2019 08:05:39 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 21 Jan 2019 08:05:39 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 21 Jan 2019 10:05:38 +0200
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
Subject: [PATCH v2 15/21] sparc: add checks for the return value of memblock_alloc*()
Date:   Mon, 21 Jan 2019 10:04:02 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012108-0016-0000-0000-000002482BEC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012108-0017-0000-0000-000032A25B44
Message-Id: <1548057848-15136-16-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210066
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add panic() calls if memblock_alloc*() returns NULL.

Most of the changes are simply addition of

        if(!ptr)
                panic();

statements after the calls to memblock_alloc*() variants.

Exceptions are pcpu_populate_pte() and kernel_map_range() that were
slightly refactored to accommodate the change.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom_32.c  |  2 ++
 arch/sparc/kernel/setup_64.c |  6 ++++++
 arch/sparc/kernel/smp_64.c   | 12 ++++++++++++
 arch/sparc/mm/init_64.c      | 11 +++++++++++
 arch/sparc/mm/srmmu.c        |  8 ++++++++
 5 files changed, 39 insertions(+)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index e7126ca..869b16c 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -33,6 +33,8 @@ void * __init prom_early_alloc(unsigned long size)
 	void *ret;
 
 	ret = memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ret)
+		panic("%s: Failed to allocate %lu bytes\n", __func__, size);
 
 	prom_early_allocated += size;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 51c4d12..fd2182a 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -624,8 +624,14 @@ void __init alloc_irqstack_bootmem(void)
 
 		softirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
 						       THREAD_SIZE, node);
+		if (!softirq_stack[i])
+			panic("%s: Failed to allocate %lu bytes align=%lx nid=%d\n",
+			      __func__, THREAD_SIZE, THREAD_SIZE, node);
 		hardirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
 						       THREAD_SIZE, node);
+		if (!hardirq_stack[i])
+			panic("%s: Failed to allocate %lu bytes align=%lx nid=%d\n",
+			      __func__, THREAD_SIZE, THREAD_SIZE, node);
 	}
 }
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f45d876..a8275fe 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1628,6 +1628,8 @@ static void __init pcpu_populate_pte(unsigned long addr)
 		pud_t *new;
 
 		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
 		pgd_populate(&init_mm, pgd, new);
 	}
 
@@ -1636,6 +1638,8 @@ static void __init pcpu_populate_pte(unsigned long addr)
 		pmd_t *new;
 
 		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
 		pud_populate(&init_mm, pud, new);
 	}
 
@@ -1644,8 +1648,16 @@ static void __init pcpu_populate_pte(unsigned long addr)
 		pte_t *new;
 
 		new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
 		pmd_populate_kernel(&init_mm, pmd, new);
 	}
+
+	return;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index ef340e8..f2d70ff 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1809,6 +1809,8 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 
 			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
 						  PAGE_SIZE);
+			if (!new)
+				goto err_alloc;
 			alloc_bytes += PAGE_SIZE;
 			pgd_populate(&init_mm, pgd, new);
 		}
@@ -1822,6 +1824,8 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 			}
 			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
 						  PAGE_SIZE);
+			if (!new)
+				goto err_alloc;
 			alloc_bytes += PAGE_SIZE;
 			pud_populate(&init_mm, pud, new);
 		}
@@ -1836,6 +1840,8 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 			}
 			new = memblock_alloc_from(PAGE_SIZE, PAGE_SIZE,
 						  PAGE_SIZE);
+			if (!new)
+				goto err_alloc;
 			alloc_bytes += PAGE_SIZE;
 			pmd_populate_kernel(&init_mm, pmd, new);
 		}
@@ -1855,6 +1861,11 @@ static unsigned long __ref kernel_map_range(unsigned long pstart,
 	}
 
 	return alloc_bytes;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+	return -ENOMEM;
 }
 
 static void __init flush_all_kernel_tsbs(void)
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index a400ec3..aaebbc0 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -305,11 +305,17 @@ static void __init srmmu_nocache_init(void)
 
 	srmmu_nocache_pool = memblock_alloc(srmmu_nocache_size,
 					    SRMMU_NOCACHE_ALIGN_MAX);
+	if (!srmmu_nocache_pool)
+		panic("%s: Failed to allocate %lu bytes align=0x%x\n",
+		      __func__, srmmu_nocache_size, SRMMU_NOCACHE_ALIGN_MAX);
 	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
 
 	srmmu_nocache_bitmap =
 		memblock_alloc(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
 			       SMP_CACHE_BYTES);
+	if (!srmmu_nocache_bitmap)
+		panic("%s: Failed to allocate %zu bytes\n", __func__,
+		      BITS_TO_LONGS(bitmap_bits) * sizeof(long));
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
@@ -468,6 +474,8 @@ static void __init sparc_context_init(int numctx)
 
 	size = numctx * sizeof(struct ctx_list);
 	ctx_list_pool = memblock_alloc(size, SMP_CACHE_BYTES);
+	if (!ctx_list_pool)
+		panic("%s: Failed to allocate %lu bytes\n", __func__, size);
 
 	for (ctx = 0; ctx < numctx; ctx++) {
 		struct ctx_list *clist;
-- 
2.7.4

