Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 14:17:19 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994583AbeINMNh2gxmF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 14:13:37 +0200
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EC4lpU026738
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:13:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mg9c78f95-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:13:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 13:13:32 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 13:13:19 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ECDICO61407312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 12:13:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB2F911C04C;
        Fri, 14 Sep 2018 15:13:05 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B893111C04A;
        Fri, 14 Sep 2018 15:13:00 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Sep 2018 15:13:00 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 14 Sep 2018 15:13:12 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 24/30] memblock: replace free_bootmem_late with memblock_free_late
Date:   Fri, 14 Sep 2018 15:10:39 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091412-4275-0000-0000-000002BA59FF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091412-4276-0000-0000-000037C3977D
Message-Id: <1536927045-23536-25-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140129
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

The free_bootmem_late and memblock_free_late do exactly the same thing:
they iterate over a range and give pages to the page allocator.

Replace calls to free_bootmem_late with calls to memblock_free_late and
remove the bootmem variant.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/sparc/kernel/mdesc.c               |  3 ++-
 arch/x86/platform/efi/quirks.c          |  6 +++---
 drivers/firmware/efi/apple-properties.c |  2 +-
 include/linux/bootmem.h                 |  2 --
 mm/nobootmem.c                          | 24 ------------------------
 5 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 59131e7..a41526b 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/export.h>
 #include <linux/refcount.h>
 
@@ -190,7 +191,7 @@ static void __init mdesc_memblock_free(struct mdesc_handle *hp)
 
 	alloc_size = PAGE_ALIGN(hp->handle_size);
 	start = __pa(hp);
-	free_bootmem_late(start, alloc_size);
+	memblock_free_late(start, alloc_size);
 }
 
 static struct mdesc_mem_ops memblock_mdesc_ops = {
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 844d31c..7b4854c 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -332,7 +332,7 @@ void __init efi_reserve_boot_services(void)
 
 		/*
 		 * Because the following memblock_reserve() is paired
-		 * with free_bootmem_late() for this region in
+		 * with memblock_free_late() for this region in
 		 * efi_free_boot_services(), we must be extremely
 		 * careful not to reserve, and subsequently free,
 		 * critical regions of memory (like the kernel image) or
@@ -363,7 +363,7 @@ void __init efi_reserve_boot_services(void)
 		 * doesn't make sense as far as the firmware is
 		 * concerned, but it does provide us with a way to tag
 		 * those regions that must not be paired with
-		 * free_bootmem_late().
+		 * memblock_free_late().
 		 */
 		md->attribute |= EFI_MEMORY_RUNTIME;
 	}
@@ -413,7 +413,7 @@ void __init efi_free_boot_services(void)
 			size -= rm_size;
 		}
 
-		free_bootmem_late(start, size);
+		memblock_free_late(start, size);
 	}
 
 	if (!num_entries)
diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 60a9571..2b675f7 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -235,7 +235,7 @@ static int __init map_properties(void)
 		 */
 		data->len = 0;
 		memunmap(data);
-		free_bootmem_late(pa_data + sizeof(*data), data_len);
+		memblock_free_late(pa_data + sizeof(*data), data_len);
 
 		return ret;
 	}
diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 706cf8e..bcc7e2f 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -30,8 +30,6 @@ extern unsigned long free_all_bootmem(void);
 extern void reset_node_managed_pages(pg_data_t *pgdat);
 extern void reset_all_zones_managed_pages(void);
 
-extern void free_bootmem_late(unsigned long physaddr, unsigned long size);
-
 /* We are using top down, so it is safe to use 0 here */
 #define BOOTMEM_LOW_LIMIT 0
 
diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index 85e1822..ee0f7fc 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -33,30 +33,6 @@ unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
-/**
- * free_bootmem_late - free bootmem pages directly to page allocator
- * @addr: starting address of the range
- * @size: size of the range in bytes
- *
- * This is only useful when the bootmem allocator has already been torn
- * down, but we are still initializing the system.  Pages are given directly
- * to the page allocator, no bootmem metadata is updated because it is gone.
- */
-void __init free_bootmem_late(unsigned long addr, unsigned long size)
-{
-	unsigned long cursor, end;
-
-	kmemleak_free_part_phys(addr, size);
-
-	cursor = PFN_UP(addr);
-	end = PFN_DOWN(addr + size);
-
-	for (; cursor < end; cursor++) {
-		__free_pages_bootmem(pfn_to_page(cursor), cursor, 0);
-		totalram_pages++;
-	}
-}
-
 static void __init __free_pages_memory(unsigned long start, unsigned long end)
 {
 	int order;
-- 
2.7.4
