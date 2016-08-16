Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 08:24:38 +0200 (CEST)
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:1314
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992909AbcHPGXM3XrGa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 08:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ij2GhJwxdZNvCmwIjEzzMrCybRCWZRUQTGI9sntl0EA=;
 b=jCFik8T143dQzw2UYsupKuXDP/WPtMCneN/oG5lYRJmtw/dCJsHdJlWy4V4JZ4kyuy+F0yt0nSPJUEOvAbu81n1GIRG9/vLdgM1KIgbsYsYIF8SJC93FKUqWkWnWFVUjo9obY+JVStQuYJU7nYVZ4mC5uza1YEhbF9AXQn2DWK0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Belits@cavium.com; 
Received: from abelits-laptop1.caveonetworks.com (50.233.148.156) by
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Tue, 16 Aug 2016 06:23:04 +0000
From:   Alex Belits <alex.belits@cavium.com>
To:     <alex.belits@cavium.com>
CC:     David Saney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/3] mips: 48bit: 48-bit virtual address space support on MIPS using the 4th level of page tables.
Date:   Mon, 15 Aug 2016 23:22:56 -0700
Message-ID: <1471328576-16758-4-git-send-email-alex.belits@cavium.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
References: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN3PR11CA0028.namprd11.prod.outlook.com (10.162.169.38) To
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27)
X-MS-Office365-Filtering-Correlation-Id: 65fbff3d-bb4a-4037-dfdc-08d3c59dc8ac
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;2:hmtZ2UXo0IIEhKeyI9Ubqa/wDGl9bQuyMJk6MM9r5cCuPIfWa/GYUwABVJMm3xcj2heu1Xw3JwDb2aEIXwXdwbaFd5ifYl8piL6+p0Sz8HAoA3cYdRGPQS2xhHQNuyYlBM5JkNZtImBzrPWcDSoqbqrvHuPIFgCiP0hIxOmvPqdWCpECLmz79P45GXW0BJAK;3:xHTiQqIPV95ESOWiTpQJSE34eJUk2OFkPvAiq77FKXvKGsDcfS1+Nt9wGuDx2dAi7VXvQUE53IY+PE2qHynlwLGMFo1Iiday0etb8jcW/48MLFJ2jp+vHv2bCBvofytE
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;25:+lcgejULiDNowCeRLGyAMzLzAieBkaOad2S7KjbU3+npn4O8Y8/8Cr7C8ND7xyF2CdChE3S8rprQNRC0gMTjW9kXMkgOCDEAtbK6dkmI0isLUWob0uvIu5ZSMIjfohGpd2Bti8dZQTCFyBuRAUSgQ2cAz38b9eaO3kcX7t973656/fq+Q3jXqmp4CDBjwckRgjSVHkDlTEFFilk5m/ZfZR0RS6D8ixViu9ltCGs7wmn6itOSwNlq/oxpA0SK1fQMc3CDS7WX02mUqKp87EzP57K8n76OQ/CMtO+7GUwvo/LOL7jeF92X81NhCDUqvTwCrg3YdHQWM0NXW3MBw6FZsT86po6w6qSG+6ylPTGZkPnkuOD+9kRTKQDjBCwyA+394O37P0DrEP8aC/qJdv+oJHtdvMi4L1aLusJ4xRgkUg4TRsomzY5hDe7kZgVBAm7hlSzizgowNUjhsbio78nauW6XQSTuvCyBw7KrFDEHnwoDYIbFvMWw3/5FLt+YSltP7MMBWxSFUrXPitKqNiN5FGLpZ6qco7wl0/YxDzltApzmdIDPbTCLIBSLG3El8oUxMWvrDs42Voz5eOXhic+XbhQ7DLEtBj5NE/ILVVb45GrCFfb8ba+Vy1Q2VrKd6ik2GF4fJ7znWJuBVMI2csy9mIpVQELYZ332XUle3oVFXt9+3X4xjfAWTSZIZtQQK53b;31:hyplI1Wc2w8IPlspOkniTHkXUUqwnQ3N/50cxKi3IBi2RdNZkgt2/4egNf/beJdq2u8CZzovT+HeyaoFQ8KuzAWE0xmfZRb30guoSw/6NVo+91leW/kPL19jVT634HYELEBdYICNB2PTqUsHjd/HsrhmISdjrTGYcF+60nxOBrOa6PG6liOG1XlyeVjzFKsmgjvN57OQ07yl9bzswRJp4tHLNxCSX5+cNpROcM5Vklw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;20:woaxST/ohyuNnquJdhveFZrCyYKUro6g0Y+n5Qs5pqc4+ZCasKnWuETo6bh7ee9cmAg8LBvqXvDe5SDOZp+Et8hUpqoO/79xdd+9wXhz8Q5cfQS2jMylPXy78ywfZPdrKfejfvHc9AqAVTo0F/ymvsdYQ/Cl2kTR0mWQs7s6keB7/w4ZBacPyVrXtuZ0okY9/4WQWDBHBz+CbkRDjkqVdqvPW1ENhmPiTis2Qn2ZD5aT1MmDMIc8jSMC21jCb4uYuEPcvxPRt08XMn+B/4uE1sQ3YxEvETfC0SlS8Oh/E1KcuNo1Xm3/p9zW1ndj/anQv6azLKuEaspTGiKeXn8l6XiSGjmKZdOM+44kkgq24HHT3MFfdY30UPwkvaGme+T3sMM5fOXB/r7hWXkaSY3uWcPnuhg7iWLxAPZX/NVfwUIcBYeth4ln0BWrZ8MroJwYzXj59d5VhYBTISvwYoS1FxSpCXtSvvMHNtXt5BzEIzk9zAXnpz4KO/Hv4mwjJUT2;4:IGjSlM4YQWqR8A9Qu5BjKy4HaqnWDJNf1Jv2ZZBQa/pxSg5A+cLxrgwPyudsd+U4d50OeSZkR+TnNkJED6ztr4V45iEUbXGZ6XOMKOWv/U2vQrnCIb5t1xVBQbSkfO6LEyVNGglcXy1uVr1wQgfCq1rD0COreYxWk4/XvVApqlxuq5pPyBAm+jYO4M8Kpfzw4Q31TM1SG8X3FPMGnpQ35xqi4VnqFPHX5AUrAAelAwiwR0LkOZFlDNQm1TADQPCNtXGuJdzYhHWAs8akh+NUKrj6cny2zIhF2XfjR4Zby840RIGjeTbiVTS/4cxU66G3jYxIJCNKSVvtKph3J/e6Zvq1OjdGUtvjuVSqERyzp/UJPZMf1t8vigV1DfWDZQDM
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1693C4AA8747F13BBBD08EB28B130@CY1PR0701MB1693.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR0701MB1693;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Forefront-PRVS: 0036736630
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(97736004)(2950100001)(19580395003)(110136002)(189998001)(33646002)(450100001)(50466002)(8676002)(48376002)(66066001)(47776003)(2351001)(229853001)(92566002)(42186005)(86362001)(105586002)(106356001)(4001450100002)(5003940100001)(77096005)(53416004)(19580405001)(69596002)(101416001)(76176999)(2906002)(6116002)(3846002)(586003)(7736002)(305945005)(7846002)(6200100001)(81156014)(4326007)(81166006)(50986999)(50226002)(68736007)(7049001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1693;H:abelits-laptop1.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1693;23:cTDLdmMfTGpqyhYzQM5XwcgwefXz9/XJDLqhkNu?=
 =?us-ascii?Q?EIt40tbNtZ2mNkdjPZR+ZWLyfvEEniSADH33fE+fxEIdS8NwTEnKjW7aU6kf?=
 =?us-ascii?Q?PMjNdKcSlVjhwFsVhom3GIlRHCkSo6nneCGE0Wr4a9XI7danzTecZt3KfDyn?=
 =?us-ascii?Q?jrOnJ5Qmj0DEGdoI7CS4SpaUGAaI2UmyFbsoZEIzMZp1nH9XaxgdjNtvByok?=
 =?us-ascii?Q?dhd+qtejkyM7N3hLqqFyeG4m/dw0HIJCrinHVDKi/OxyYkb7RcDy8f8vOEke?=
 =?us-ascii?Q?i9g7+zTJZEyQEQtBaYnedTG6//lgHmVd+8/0riGl363Pzq22s9v5+B+Tn0iJ?=
 =?us-ascii?Q?gH90YzrCdannpzvwh2DspkGYqnoGlZnkQ656NKVl/qqSDw6HiJcYsvyox96U?=
 =?us-ascii?Q?Ol+QN7JlWy+PsEKlmhTvuvfSS9XB1Qm+9a55lnqHvLFzQgWb34VyFxqvpspc?=
 =?us-ascii?Q?ZELNbKDx3aTW0oyRcv9n86kRFpX8fJBWYz2BjiYUgkIH3d3g/h0KxMl+gBov?=
 =?us-ascii?Q?KSNkLCNcGWxtuLjstfK7Id0gxBKsysoSxwnjeDT/hasDsr0YVy9HQ6aVwbVe?=
 =?us-ascii?Q?EQtEzmDx48LdeYGgePD2yp9lfpNHiZapmUoFuimUNmlWYmXn/eFyDJJtKGxr?=
 =?us-ascii?Q?BCx+poB8BmyYRhJOfN0lqlzyPsd2aXo2EdVrkZAkM2dWSBQZmoMUuoFpQha0?=
 =?us-ascii?Q?mK9SyCkE3PdtFiKbRebQaVazfprt5tzUay/jz2oJDjvSYTlEu5lEnYmw4Qxu?=
 =?us-ascii?Q?5213JrvJIa9kcVEED7RCCbSopv5dAjIv7/cEv2IuLOk84r4mFpV7fQsPjmPL?=
 =?us-ascii?Q?hiOfocdQEx5UuEtRPg+XFHsXcTj6VrwgWW2ashfl6Wsw4qZjMn0WQzx8/75P?=
 =?us-ascii?Q?5RLTGYYyvJiumttm+XuZoFdtGXOhp/0OMkSD0ZKYs92/Jj5YBe9eyZ2qatBh?=
 =?us-ascii?Q?SWGCClEwxZh7LeTgOo1SIJXthzQ8w00GV5rtvqLxfUjuCr8tC2BoyFskYC0t?=
 =?us-ascii?Q?b1hakFICvf5fx9qMsOvz8wERE/ihbIqlp2GaZUxdLooepRHRkPA+S2KqneEz?=
 =?us-ascii?Q?rJWhaJXTsk2B0hT5uV6//BmHXSAYQeguhGWMB4Cu4p4XE8qqrL7uLDKkX0KL?=
 =?us-ascii?Q?DWDApdiYcu9ZBrMaOJ3izNN7LtiIouSeB8JHtxXskaOMzUGKmUcKSOgizPrg?=
 =?us-ascii?Q?rNYdhDIAfePvnAWKk1lu44ni/dEJohJHUTjxL?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;6:DEJSUQMMrkVDyCiD25sqLEK7FY0D1h0LMGGfMtcDmi2+MgS0haV0M5qo+taERT8x6G+gIErM1+tDFsMaAui9bNoJXuMmI/78oF6TbD4JO49rr5wGIax5lcTDA6WRWzR+hsgcQz53ya85nOxoedAr+pGlv76swA4XZsK06FfI18laLPQKAF0hkeo9l1+3zkZ6gXWT66GSua/hDzDTIjI6tUpiL95n6HcUw1N2ygJpIW6Aq6Is+ozuUyB1via2u5t/FwwGnIGRS5hUpjzUD4oTxFULboulRtet3y9TGdBgwuQ=;5:0R+2xVEXlAtKuc156F3fAwlNJQyhvj9MnKgJBsodbhF1jNYVO7pDfw/CiKTEbdX/kkvkkuIpwhM6WokvhzOfIKGoCCwxiPODTKSjVnMykDOKMxsVa/P9gqlblE1DF7V9Whcl6q1aMFC1x29t2ptz2A==;24:bOTdQ2Tf1HZOeRWHpLobqgmnbJx84EEiadyIQpMU/I7rxrVoTW6sOo5Kn2K9hs1/s9fwsVDRPE2YfYjV5H1NH/YQLoq0FqQnlx8ebkRnF6I=;7:wHK8xO4Gw4k8h9YsnnlI4Cx/6ipd14EhZ9p7bqzTnx3YCzaLDKM4dyvI1fsPfNDc7jYy9Vy/iuSUHQkgKtWoANH8m0BZsYrzwyvTdTZfDN+3U7YIcXeIMHzGCkI9vr5viR+OytiV9RYK0rVE/EZxWK4rYp0FIdI6C5sG/AvrexrVByD7gAjdQrrJIg5+CkxXiEhD1cTNrWEhnBHmuJYQczp7rUM3+TBBah4S2TS/yUbnaN+K0HCu656ZlMDVyC/p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2016 06:23:04.9425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1693
Return-Path: <Alex.Belits@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.belits@cavium.com
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

This is a set of patches to add 48-bit virtual address space support on 
MIPS to the kernel 3.10. It includes a port of existing patch for page 
size 16k and 64k, plus support for 4-level page table for the rest of 
the supported page sizes.

Cc: David Saney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

Signed-off-by: Alex Belits <alex.belits@cavium.com>

---
 arch/mips/Kconfig                  |   3 -
 arch/mips/include/asm/pgalloc.h    |  32 +++++
 arch/mips/include/asm/pgtable-64.h | 262 +++++++++++++++++++++++++++++++++++--
 arch/mips/include/asm/pgtable.h    |  13 +-
 arch/mips/include/asm/processor.h  |   2 +-
 arch/mips/kernel/asm-offsets.c     |   9 ++
 arch/mips/mm/init.c                |   3 +
 arch/mips/mm/pgtable-64.c          |  29 ++++
 arch/mips/mm/tlbex.c               |  30 ++++-
 9 files changed, 368 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2ee3067..e514a81 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1756,7 +1756,6 @@ choice
 config PAGE_SIZE_4KB
 	bool "4kB"
 	depends on !CPU_LOONGSON2
-	depends on !MIPS_VA_BITS_48
 	help
 	 This option select the standard 4kB Linux page size.  On some
 	 R3000-family processors this is the only available page size.  Using
@@ -1766,7 +1765,6 @@ config PAGE_SIZE_4KB
 config PAGE_SIZE_8KB
 	bool "8kB"
 	depends on CPU_R8000 || CPU_CAVIUM_OCTEON
-	depends on !MIPS_VA_BITS_48
 	help
 	  Using 8kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available
@@ -1785,7 +1783,6 @@ config PAGE_SIZE_16KB
 config PAGE_SIZE_32KB
 	bool "32kB"
 	depends on CPU_CAVIUM_OCTEON
-	depends on !MIPS_VA_BITS_48
 	help
 	  Using 32kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 881d18b4..97d4254 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -29,7 +29,18 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 /*
  * Initialize a new pmd table with invalid pointers.
  */
+#ifndef __PAGETABLE_PMD_FOLDED
 extern void pmd_init(unsigned long page, unsigned long pagetable);
+#endif
+
+#ifndef __PAGETABLE_PUD_FOLDED
+
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	set_pgd(pgd, __pgd((unsigned long)pud));
+}
+
+#endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
@@ -104,6 +115,27 @@ do {							\
 	tlb_remove_page((tlb), pte);			\
 } while (0)
 
+#ifndef __PAGETABLE_PUD_FOLDED
+
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	pud_t *pud;
+
+	pud = (pud_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PUD_ORDER);
+	if (pud)
+		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
+	return pud;
+}
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	free_pages((unsigned long)pud, PUD_ORDER);
+}
+
+#define __pud_free_tlb(tlb, x, addr)	pud_free((tlb)->mm, x)
+
+#endif
+
 #ifndef __PAGETABLE_PMD_FOLDED
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index e9805ad..7193212 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -17,13 +17,140 @@
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
 
-#if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_MIPS_VA_BITS_48)
+
+/*
+ * Memory mapping options:
+ *
+ * Virtual address bits supported by tables:
+ * +------+---------+----------+
+ * | Page | Default | "48 bit" |
+ * +------+---------+----------+
+ * | 4K   |  40     |  48      |
+ * | 8K   |  43     |  53      |
+ * | 16K  |  47     |  48      |
+ * | 32K  |  51     |  51      |
+ * | 64K  |  42     |  54      |
+ * +------+---------+----------+
+ *
+ *
+ * 4K pages:
+ * With two levels of page tables, one 4K page per level, and 4K page:
+ * PTE provides 12 + 9 = 21 bits
+ * PGD provides 9 bits
+ * Total 30 bits (not used).
+ *
+ * With three levels of page tables, one 4K page per level, and 4K page:
+ * PTE provides 12 + 9 = 21 bits
+ * PMD provides 9 bits
+ * PGD provides 9 bits
+ * Total 39 bits (not used).
+ *
+ * With three levels of page tables, one 4K page per level except for
+ * two-page PGD, and 4K page:
+ * PTE provides 12 + 9 = 21 bits
+ * PMD provides 9 bits
+ * PGD provides 10 bits
+ * Total 40 bits (the default for 4K pages).
+ *
+ * With four levels of page tables, one 4K page per level, and 4K page:
+ * PTE provides 12 + 9 = 21 bits
+ * PMD provides 9 bits
+ * PUD provides 9 bits
+ * PGD provides 9 bits
+ * Total 48 bits (used when 48 bit address is enabled with 4K pages).
+ *
+ *
+ * 8K pages:
+ * With two levels of page tables, one 8K page per level, and 8K page:
+ * PTE provides 13 + 10 = 23 bits
+ * PGD provides 10 bits
+ * Total 33 bits (not used).
+ *
+ * With three levels of page tables, one 8K page per level, and 8K page:
+ * PTE provides 13 + 10 = 23 bits
+ * PMD provides 10 bits
+ * PGD provides 10 bits
+ * Total 43 bits (what is set when 8K pages are selected).
+ *
+ * With four levels of page tables, one 8K page per level, and 8K page:
+ * PTE provides 13 + 10 = 23 bits
+ * PMD provides 10 bits
+ * PUD provides 10 bits
+ * PGD provides 10 bits
+ * Total 53 bits (used when 48 bit address is enabled with 8K pages).
+ *
+ *
+ * 16K pages:
+ * With two levels of page tables, one 16K page per level, and 16K page:
+ * PTE provides 14 + 11 = 25 bits
+ * PGD provides 11 bits
+ * Total 36 bits (not used).
+ *
+ * With three levels of page tables, one 16K page per level, and 16K page:
+ * PTE provides 14 + 11 = 25 bits
+ * PMD provides 11 bits
+ * PGD provides 11 bits
+ * Total 47 bits (the default for 16K pages).
+ *
+ * With three levels of page tables, one 16K page per level except for
+ * two-page PGD, and 16K page:
+ * PTE provides 14 + 11 = 25 bits
+ * PMD provides 11 bits
+ * PGD provides 12 bits
+ * Total 48 bits (used when 48 bit address is enabled with 16K pages).
+ *
+ *
+ * 32K pages:
+ * With two levels of page tables, one 32K page per level, and 32K page:
+ * PTE provides 15 + 12 = 27 bits
+ * PGD provides 12 bits
+ * Total 39 bits (not used).
+ *
+ * With three levels of page tables, one 32K page per level, and 32K page:
+ * PTE provides 15 + 12 = 27 bits
+ * PMD provides 12 bits
+ * PGD provides 12 bits
+ * Total 51 bit (the default for 32K pages).
+ *
+ *
+ * 64K pages:
+ * With two levels of page tables, one 64K page per level, and 64K page:
+ * PTE provides 16 + 13 = 29 bits
+ * PGD provides 13 bits
+ * Total 42 bits (the default for 64K pages).
+ *
+ * With three levels of page tables, one 64K page per level, and 64K page:
+ * PTE provides 16 + 13 = 29 bits
+ * PMD provides 13 bits
+ * PGD provides 13 bits
+ * Total 54 bits (used when 48 bit address is enabled with 64K pages).
+ *
+ * Actually supported virtual address bits can not exceed 48 bits
+ * or whatever is supported by CPU, see arch/mips/include/asm/processor.h
+ *
+ */
+
+#ifdef CONFIG_MIPS_VA_BITS_48
+/* 48-bit virtual memory */
+#if !defined(CONFIG_PAGE_SIZE_4KB) && !defined(CONFIG_PAGE_SIZE_8KB)
+/* All page sizes except 4K and 8K will use three-level page tables */
+#include <asm-generic/pgtable-nopud.h>
+#endif
+/* 4K and 8K pages use four-level page tables */
+#else
+/* Reduced (below 48 bit) virtual memory size */
+#ifdef CONFIG_PAGE_SIZE_64KB
+/* Two-level page table */
 #include <asm-generic/pgtable-nopmd.h>
 #else
+/* All other page sizes will use three-level page tables */
 #include <asm-generic/pgtable-nopud.h>
 #endif
+#endif
 
 /*
+ * Default configuration with 4K pages:
+ *
  * Each address space has 2 4K pages as its page directory, giving 1024
  * (== PTRS_PER_PGD) 8 byte pointers to pmd tables. Each pmd table is a
  * single 4K page, giving 512 (== PTRS_PER_PMD) 8 byte pointers to page
@@ -42,8 +169,9 @@
  * fault address - VMALLOC_START.
  */
 
+#ifdef __PAGETABLE_PUD_FOLDED
 
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
+/* Here PGDIR_SHIFT determines what a third-level page table entry can map */
 #ifdef __PAGETABLE_PMD_FOLDED
 #define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
 #else
@@ -56,9 +184,29 @@
 
 #define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
 #endif
+#else
+/* PUD is not folded */
+
+/* PMD_SHIFT determines the size of the area a second-level page table can map */
+#define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+
+/* PUD_SHIFT determines the size of the area a third-level page table can map */
+
+#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
+
+/* Here PGDIR_SHIFT determines what a fourth-level page table entry can map */
+
+#define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT + PUD_ORDER - 3))
+#endif
+
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
+
 /*
  * For 4kB page size we use a 3 level page tree and an 8kB pgd, which
  * permits us mapping 40 bits of virtual address space.
@@ -71,24 +219,34 @@
  * two levels would be easy to implement.
  *
  * For 16kB page size we use a 3 level page tree which permits a total of
- * 47 bits of virtual address space.  We could add a third level but it seems
- * like at the moment there's no need for this.
+ * 47 bits of virtual address space.
  *
  * For 64kB page size we use a 2 level page table tree for a total of 42 bits
  * of virtual address space.
  */
 #ifdef CONFIG_PAGE_SIZE_4KB
+#ifdef CONFIG_MIPS_VA_BITS_48
+#define PGD_ORDER		0
+#define PUD_ORDER		0
+#else
 #define PGD_ORDER		1
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#endif
 #define PMD_ORDER		0
 #define PTE_ORDER		0
 #endif
+
 #ifdef CONFIG_PAGE_SIZE_8KB
 #define PGD_ORDER		0
+#ifdef CONFIG_MIPS_VA_BITS_48
+#define PUD_ORDER		0
+#else
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
+#endif
 #define PMD_ORDER		0
 #define PTE_ORDER		0
 #endif
+
 #ifdef CONFIG_PAGE_SIZE_16KB
 #ifdef CONFIG_MIPS_VA_BITS_48
 #define PGD_ORDER		1
@@ -99,12 +257,14 @@
 #define PMD_ORDER		0
 #define PTE_ORDER		0
 #endif
+
 #ifdef CONFIG_PAGE_SIZE_32KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_ORDER		0
 #define PTE_ORDER		0
 #endif
+
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
@@ -117,6 +277,9 @@
 #endif
 
 #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#ifndef __PAGETABLE_PUD_FOLDED
+#define PTRS_PER_PUD	((PAGE_SIZE << PUD_ORDER) / sizeof(pud_t))
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) / sizeof(pmd_t))
 #endif
@@ -131,10 +294,18 @@
  * reliably trap.
  */
 #define VMALLOC_START		(MAP_BASE + (2 * PAGE_SIZE))
+#ifdef __PAGETABLE_PUD_FOLDED
 #define VMALLOC_END	\
 	(MAP_BASE + \
 	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
 	     (1UL << cpu_vmbits)) - (1UL << 32))
+#else
+#define VMALLOC_END	\
+	(MAP_BASE + \
+	 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE \
+	     * PAGE_SIZE,					       \
+	     (1UL << cpu_vmbits)) - (1UL << 32))
+#endif
 
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
 	VMALLOC_START != CKSSEG
@@ -149,12 +320,28 @@
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
 #endif
+#ifndef __PAGETABLE_PUD_FOLDED
+#define pud_ERROR(e) \
+	printk("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
+#endif
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
 extern pte_t empty_bad_page_table[PTRS_PER_PTE];
 
+#ifndef __PAGETABLE_PUD_FOLDED
+/*
+ * For 4-level pagetables we defines these ourselves, for 3-level the
+ * definitions are below, for 2-level the
+ * definitions are supplied by <asm-generic/pgtable-nopmd.h>.
+ */
+typedef struct { unsigned long pud; } pud_t;
+#define pud_val(x)	((x).pud)
+#define __pud(x)	((pud_t) { (x) })
+
+extern pud_t invalid_pud_table[PTRS_PER_PUD];
+#endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
 /*
@@ -200,6 +387,33 @@ static inline void pmd_clear(pmd_t *pmdp)
 {
 	pmd_val(*pmdp) = ((unsigned long) invalid_pte_table);
 }
+
+#ifndef __PAGETABLE_PUD_FOLDED
+
+/*
+ * Empty pgd entries point to the invalid_pud_table.
+ */
+static inline int pgd_none(pgd_t pgd)
+{
+	return pgd_val(pgd) == (unsigned long) invalid_pud_table;
+}
+
+static inline int pgd_bad(pgd_t pgd)
+{
+	return pgd_val(pgd) & ~PAGE_MASK;
+}
+
+static inline int pgd_present(pgd_t pgd)
+{
+	return pgd_val(pgd) != (unsigned long) invalid_pud_table;
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	pgd_val(*pgdp) = ((unsigned long) invalid_pud_table);
+}
+#endif
+
 #ifndef __PAGETABLE_PMD_FOLDED
 
 /*
@@ -238,18 +452,40 @@ static inline void pud_clear(pud_t *pudp)
 #endif
 
 #define __pgd_offset(address)	pgd_index(address)
-#define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#ifndef __PAGETABLE_PUD_FOLDED
+#define __pud_offset(address)	pud_index(address)
+#else
+#define __pud_offset(address)  (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#endif
 #define __pmd_offset(address)	pmd_index(address)
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
+#ifndef __PAGETABLE_PUD_FOLDED
+#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+#endif
 #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
 /* to find an entry in a page-table-directory */
 #define pgd_offset(mm, addr)	((mm)->pgd + pgd_index(addr))
 
+#ifndef __PAGETABLE_PUD_FOLDED
+static inline unsigned long pgd_page_vaddr(pgd_t pgd)
+{
+	return pgd_val(pgd);
+}
+
+/*
+ * Find an entry in the upper-level (below global) page table..
+ */
+static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
+{
+	return (pud_t *) pgd_page_vaddr(*pgd) + pud_index(address);
+}
+#endif
+
 #ifndef __PAGETABLE_PMD_FOLDED
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
@@ -258,14 +494,19 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 #define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
-/* Find an entry in the second-level page table.. */
+/*
+ * Find an entry in the middle-level (below upper, if any, otherwise global)
+ * page table..
+ */
 static inline pmd_t *pmd_offset(pud_t * pud, unsigned long address)
 {
 	return (pmd_t *) pud_page_vaddr(*pud) + pmd_index(address);
 }
 #endif
 
-/* Find an entry in the third-level page table.. */
+/*
+ * Find an entry in the low-level page table..
+ */
 #define __pte_offset(address)						\
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
@@ -277,10 +518,15 @@ static inline pmd_t *pmd_offset(pud_t * pud, unsigned long address)
 #define pte_unmap(pte) ((void)(pte))
 
 /*
- * Initialize a new pgd / pmd table with invalid pointers.
+ * Initialize a new pgd / pud / pmd table with invalid pointers.
  */
 extern void pgd_init(unsigned long page);
+#ifndef __PAGETABLE_PUD_FOLDED
+extern void pud_init(unsigned long page, unsigned long pagetable);
+#endif
+#ifndef __PAGETABLE_PMD_FOLDED
 extern void pmd_init(unsigned long page, unsigned long pagetable);
+#endif
 
 /*
  * Non-present pages:  high 24 bits are offset, next 8 bits type,
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index e821de7..12e3fce 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -201,20 +201,29 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 #endif
 
 /*
- * (pmds are folded into puds so this doesn't get actually called,
+ * (pmds may be folded into puds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
 #define set_pmd(pmdptr, pmdval) do { *(pmdptr) = (pmdval); } while(0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 /*
- * (puds are folded into pgds so this doesn't get actually called,
+ * (puds may be folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
  */
 #define set_pud(pudptr, pudval) do { *(pudptr) = (pudval); } while(0)
 #endif
 
+#ifndef __PAGETABLE_PUD_FOLDED
+/*
+ * (puds may be folded into pgds so this doesn't get actually called,
+ * but the define is needed for a generic inline function.)
+ */
+#define set_pgd(pgdptr, pgdval) do { *(pgdptr) = (pgdval); } while (0)
+#endif
+
 #define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
+#define PUD_T_LOG2	(__builtin_ffs(sizeof(pud_t)) - 1)
 #define PMD_T_LOG2	(__builtin_ffs(sizeof(pmd_t)) - 1)
 #define PTE_T_LOG2	(__builtin_ffs(sizeof(pte_t)) - 1)
 
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 083a56f..b5fc9de 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -74,7 +74,7 @@ extern unsigned int vced_count, vcei_count;
 #ifdef CONFIG_MIPS_VA_BITS_48
 #define TASK_SIZE64	(0x1UL << ((cpu_data[0].vmbits > 48) ? 48 : cpu_data[0].vmbits))
 #else
-#define TASK_SIZE64     0x10000000000UL
+#define TASK_SIZE64	0x10000000000UL
 #endif
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0845091..84b6db7 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -180,26 +180,35 @@ void output_mm_defines(void)
 	OFFSET(MM_CONTEXT, mm_struct, context);
 	BLANK();
 	DEFINE(_PGD_T_SIZE, sizeof(pgd_t));
+	DEFINE(_PUD_T_SIZE, sizeof(pud_t));
 	DEFINE(_PMD_T_SIZE, sizeof(pmd_t));
 	DEFINE(_PTE_T_SIZE, sizeof(pte_t));
 	BLANK();
 	DEFINE(_PGD_T_LOG2, PGD_T_LOG2);
+#ifndef __PAGETABLE_PUD_FOLDED
+	DEFINE(_PUD_T_LOG2, PUD_T_LOG2);
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 	DEFINE(_PMD_T_LOG2, PMD_T_LOG2);
 #endif
 	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
 	BLANK();
 	DEFINE(_PGD_ORDER, PGD_ORDER);
+#ifndef __PAGETABLE_PUD_FOLDED
+	DEFINE(_PUD_ORDER, PUD_ORDER);
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 	DEFINE(_PMD_ORDER, PMD_ORDER);
 #endif
 	DEFINE(_PTE_ORDER, PTE_ORDER);
 	BLANK();
 	DEFINE(_PMD_SHIFT, PMD_SHIFT);
+	DEFINE(_PUD_SHIFT, PUD_SHIFT);
 	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
 	BLANK();
 	DEFINE(_PTRS_PER_PGD, PTRS_PER_PGD);
 	DEFINE(_PTRS_PER_PMD, PTRS_PER_PMD);
+	DEFINE(_PTRS_PER_PUD, PTRS_PER_PUD);
 	DEFINE(_PTRS_PER_PTE, PTRS_PER_PTE);
 	BLANK();
 	DEFINE(_PAGE_SHIFT, PAGE_SHIFT);
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 9b973e0..25d7ce5 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -466,6 +466,9 @@ unsigned long pgd_current[NR_CPUS];
  * it in the linker script.
  */
 pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
+#ifndef __PAGETABLE_PUD_FOLDED
+pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
 #endif
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index e8adc00..a942256 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -18,11 +18,15 @@ void pgd_init(unsigned long page)
 	unsigned long *p, *end;
 	unsigned long entry;
 
+#ifdef __PAGETABLE_PUD_FOLDED
 #ifdef __PAGETABLE_PMD_FOLDED
 	entry = (unsigned long)invalid_pte_table;
 #else
 	entry = (unsigned long)invalid_pmd_table;
 #endif
+#else
+	entry = (unsigned long)invalid_pud_table;
+#endif
 
 	p = (unsigned long *) page;
 	end = p + PTRS_PER_PGD;
@@ -40,6 +44,28 @@ void pgd_init(unsigned long page)
 	} while (p != end);
 }
 
+#ifndef __PAGETABLE_PUD_FOLDED
+void pud_init(unsigned long addr, unsigned long pagetable)
+{
+	unsigned long *p, *end;
+
+	p = (unsigned long *) addr;
+	end = p + PTRS_PER_PUD;
+
+	do {
+		p[0] = pagetable;
+		p[1] = pagetable;
+		p[2] = pagetable;
+		p[3] = pagetable;
+		p[4] = pagetable;
+		p += 8;
+		p[-3] = pagetable;
+		p[-2] = pagetable;
+		p[-1] = pagetable;
+	} while (p != end);
+}
+#endif
+
 #ifndef __PAGETABLE_PMD_FOLDED
 void pmd_init(unsigned long addr, unsigned long pagetable)
 {
@@ -102,6 +128,9 @@ void __init pagetable_init(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
 #endif
+#ifndef __PAGETABLE_PUD_FOLDED
+	pud_init((unsigned long)invalid_pud_table, (unsigned long)invalid_pmd_table);
+#endif
 	pgd_base = swapper_pg_dir;
 	/*
 	 * Fixed mappings:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a91a7a9..2c6ac9e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -862,6 +862,13 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
+#ifndef __PAGETABLE_PUD_FOLDED
+	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	uasm_i_ld(p, ptr, 0, ptr); /* get pud pointer */
+	uasm_i_dsrl_safe(p, tmp, tmp, PUD_SHIFT-3); /* get pud offset in bytes */
+	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PUD - 1)<<3);
+	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pud offset */
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_ld(p, ptr, 0, ptr); /* get pmd pointer */
@@ -1188,10 +1195,29 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		UASM_i_LWX(p, LOC_PTEP, scratch, ptr);
 	} else {
 		uasm_i_daddu(p, ptr, ptr, scratch); /* add in pgd offset */
-		uasm_i_ld(p, LOC_PTEP, 0, ptr); /* get pmd pointer */
+		uasm_i_ld(p, LOC_PTEP, 0, ptr); /* get pud, pmd or pte pointer */
 	}
 
 #ifndef __PAGETABLE_PMD_FOLDED
+#ifndef __PAGETABLE_PUD_FOLDED
+	/* LOC_PTEP is ptr, and it contains a pointer to PUD entry */
+	/* tmp contains the address */
+	/* get pud offset in bytes */
+	uasm_i_dsrl_safe(p, scratch, tmp, PUD_SHIFT - 3);
+	uasm_i_andi(p, scratch, scratch, (PTRS_PER_PUD - 1) << 3);
+
+	if (use_lwx_insns()) {
+		UASM_i_LWX(p, ptr, scratch, ptr);
+	} else {
+		uasm_i_daddu(p, ptr, ptr, scratch); /* add in pmd offset */
+		UASM_i_LW(p, ptr, 0, ptr);
+	}
+	/* ptr contains a pointer to PMD entry */
+	/* tmp contains the address */
+#endif
+
+	/* LOC_PTEP is ptr, and it contains a pointer to PMD entry */
+	/* tmp contains the address */
 	/* get pmd offset in bytes */
 	uasm_i_dsrl_safe(p, scratch, tmp, PMD_SHIFT - 3);
 	uasm_i_andi(p, scratch, scratch, (PTRS_PER_PMD - 1) << 3);
@@ -1203,6 +1229,8 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		uasm_i_daddu(p, ptr, ptr, scratch); /* add in pmd offset */
 		UASM_i_LW(p, scratch, 0, ptr);
 	}
+	/* scratch contain a pointer to PTE entry */
+	/* tmp contains context */
 #endif
 	/* Adjust the context during the load latency. */
 	build_adjust_context(p, tmp);
-- 
2.8.1
