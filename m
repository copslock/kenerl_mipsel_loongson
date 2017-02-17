Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 02:27:54 +0100 (CET)
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:58144
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992121AbdBQB1sKJw6d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2017 02:27:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TBUsL9V/SptuDaCeB018YIrsj4o5inezl/Jqebkr/DE=;
 b=TSe1C+vgKi56QRQ8vd4azOiAdW5WIhRrR8uS32lmN+ls5msOS6XLWsHNWOLxfw4gI7IijJl0ECGdNLHytA4opGYjB40I4t4TOzuYVbxfP5owLzjX1D6T+dVf30P8ReWDbT0iVPQlye5DWNLEIP3/deG7Bnc2tHDFPxMOWGTe+AQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BLUPR0701MB1972.namprd07.prod.outlook.com (10.163.121.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.919.13; Fri, 17 Feb 2017 01:27:38 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, Alex Belits <alex.belits@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Add 48-bit VA space (and 4-level page tables) for 4K pages.
Date:   Thu, 16 Feb 2017 17:27:34 -0800
Message-Id: <20170217012734.19256-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0020.namprd07.prod.outlook.com (10.162.96.30) To
 BLUPR0701MB1972.namprd07.prod.outlook.com (10.163.121.23)
X-MS-Office365-Filtering-Correlation-Id: e9965b2d-5240-4177-2bdb-08d456d42950
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BLUPR0701MB1972;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1972;3:wvsXj0yF+hAuHOFoeph4ip2UU3Q4BleZQ9OlcvsWbwFrGjhXrDcZ3Sgx/ic4cDbeZ4JFgFlQTLcjOnkiRO8wmzYjuGodMXJ9bOp7jM4hAf3TMIgVYWk/Duyuw7fB5Q/IwfSaN14conW9mhRTCUw+rKL9XyhKQXdpzZZC3c5Q3O6ck+RuXffp2JktuMIFHwzZ/a1qXW6O2wsavSjF2MRvbBk2J9FC1CeD8mDjiewbgCAANpysaNA0Twc+C3dAYrVUBLKqGmxQ3P9RM8ooyLukwQ==;25:EmrDfI3kVZMrSH8s3Z4QFb5zrGIV2seyVwL5VsXHFwE5hGDI2Cyse9RdRk2QW/dS6BcQbCn8ipdqlICnNeJtWFOIPFfSvuZI2yKStT9gIA3ESjuno9fvtpvtXVRjmqKHl3WdwDehfOfEkOCujOdWfoMTYN/t7s7ZEZR2fSXnlG9GYmfzEKJbr9o2fXkm2FJPYew/wUEaz/fZ6yenDzup3DZWmKkqtgLjxnI3AD9LRz5lQPMwjARa6rq5UTYkRbO0FUlIpzKd8KuYXtgHgYASwdmg/5dNgq6tA1LwRaF+yZxF2hZd6hgkCzz4frI60lgIsDVl8ZT0EZXxXvvS1ZNvcSYIQD2ss4/pPOXQpMzI0xrFxTwrqLLbNv1GdGu0Em6VQm9lw22WYzo9xSkFbPMTyH6LgZtLc6OugtSxx0fJQjt3lOcVe05w6tF+3OaI8SUIoOv5U7WjZfpJGXhvDB8ALg==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1972;31:dhWPZJc47AY0MsJWq46k6b5SbNYBraHn0Uq2hOx743rMT8LHmArKTrJtctzNIVpqgx0Bq0AZV3kYozbXGoc1StO95R+DPJCX/dedgs8uTQetepsqFLkvMLuJQoP1gxhXzP7Ka0Pp9OmFe2iS6TsmhSTQGRkgg5rewW0iz7EUPXhbw9uUxSX6AGy9AGsnHHE1n9PFzZyKVRYYEIBljBpz/wTWFC3SbrETC+S8COBbSz5z3mdE3RMTPiEAFBF1Cgib;20:oLUEFuixOhxmNahuXEjybDcyDvZWiyVHJ/yJJZBFjg+OyjeqaGGFMX3QmIAsWH2ILPgiCftRd3fVowYBOGfMn/1P7tXZUKm35tFFMP3c8coVR4Ds6UF6k+WHiEnwqJqygAx7h8xvgZpVb0dHlX1Ka4mHCMB2exKMUD8EMdqam9bL9oacmi4ieg1e5cGZRAe4YjSFR5aufY0iu67VUzxb2FX1u2hHXJHP4m+cee1bGNzojWTPHiOyWeDBc1cIzg19FaJIHiN3tF/MTdeg9y7Q2m7gnIxoMIgozgRaP+J7EojW7kNW4DWZfU3gR5F7Zyp00/5MWApmfApeLGZbafuf03nmFHEz8IRIkZZkGkvPrUWzbxB1r9KbfP2BbaUCGf/OtmOv1zppxXusayBhTftA2fCzEpzcQmImmqByTHPn8rR/EqRrNARrINfHQoz4bCH1BiyGWJPKWdx9DlvBnEcj6Z49PMTlDK8RZBPsUbE1uN1wvYq7U0VlR8+JF3KoF4gl
X-Microsoft-Antispam-PRVS: <BLUPR0701MB1972577925CA6067DD4FB710975D0@BLUPR0701MB1972.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123562025)(20161123564025)(20161123558025)(20161123555025)(20161123560025)(6072148);SRVR:BLUPR0701MB1972;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1972;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1972;4:wCXXSsnCxFxUirc+6z4S7SuspbHuggokncf3QxQINcknzhpvW4LH/ihkGKGkWNdHteWO904ZftSwYTFpsqn3kZ0NGF/owOFKbhXOrcKi0cLlCTgFgvSI56GWs0pIJ3U7p6PANAaIgD5YpgWkpWDvuVgXC54o4DMgV6EXXFGeqaYwOzhj7eS3WVu+OaWHy+oOZe4N+YA+iKmBcF1nFUjNrJtlV4Komla6FsZ78htqGjs4zHWDRp1TZ1PB+/6jKoh60CjefVHOUYiC6uO8kg4UARWcGn/fyWSo9F3AJEEmKcQe/+bLEKbHIvjaqG0jHxRh5ocXn0nUs/R0tQtC16ZIHFu+umWBuL6uDF/H8o+z7p4AayUP40tOecVEQ5CGJIkGhIiZi+fOVnZvmYLK9cj7V63SLgk6vgDwtGXW8fE2Fckmzo7/4kdaXbtKQeQVHcNaVfVoExyCOP7JETWcPGl/W8BWudCBRfHjrLqe2N5gwhhLyQTmhMoBrIVCaINjfK9518Zn0m0e4oz9Hm7InXXgdA2iCbZfdvEg6w1z6bwSnFSTPH894x9pgoqXhflse0EKWq65R8gouyVDwNsu70+IVIyTKams5gH4Hvki0076etA=
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(199003)(25786008)(8676002)(69596002)(54906002)(6506006)(6116002)(68736007)(81156014)(50986999)(3846002)(6512007)(50226002)(81166006)(4326007)(106356001)(389900003)(50466002)(48376002)(105586002)(53936002)(2906002)(1076002)(101416001)(5003940100001)(42186005)(53416004)(36756003)(189998001)(6486002)(305945005)(66066001)(6916009)(6666003)(7736002)(97736004)(47776003)(33646002)(38730400002)(110136004)(86362001)(5660300001)(107886003)(92566002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1972;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB1972;23:uz5zt+vws7Vz9qVXb32PzLDZ25H4+Q8enCd960Q?=
 =?us-ascii?Q?swYojw6CnlUrCmgkPyv1KvGg83H6/q8j5EpPV1p+s/R50pj92nwxzqAA8eYj?=
 =?us-ascii?Q?LmOxQoex0OrD/I3DECw14Tcepb1Jb2629N2uicDhe/1bdoRKge4dqxo2IMZM?=
 =?us-ascii?Q?iF8yolL8SWrbMOoZ5s0j1T6oSZDF01TwHyqe2MdJEMOnHIrS583aKSNcqFRl?=
 =?us-ascii?Q?AwUHcVyQwZ8HxqPg1JgvrowtezDjyu0X6K+iVDl9ihq9pZv2GWomLHMAm15+?=
 =?us-ascii?Q?0swg7LVlWUU1E7lg2/xDI9fykMkemTQEUamfbhITibVP87tSHMYkGs39GY7t?=
 =?us-ascii?Q?EjwVSsBpSIFYP4q5OLmggHLr5EWwAAbHTKSYAY4DchuoK3DGjz/Wzto8JBJE?=
 =?us-ascii?Q?PuW4kQYiL0dkrnaCREvm5WSaOzRSUMOOeEuJCA33bfdJWXij1UfbYT8WAcZJ?=
 =?us-ascii?Q?dp4wJXnQNMFaHmPY1GxUYqD0R3KFRJMCpB/d69E89WNfzc0z6dGPxNzlLDFp?=
 =?us-ascii?Q?7Ukk4HrPtpmbP2u41F+HLOEmyLwxCHIpTVFej/8cMR/987HVsOJd8MXRfgJk?=
 =?us-ascii?Q?MqhYI8s1ukpEwxpJc7aMmS7e9OuY/fzfktUSehx7FGb8GZQowPc9ZFVtuyh3?=
 =?us-ascii?Q?P3mFGTs0XQ6jGMK/LkNoD6//Sjpc9uUNLJAz+FkxCBcnjfUbBySr1J8dufG9?=
 =?us-ascii?Q?AjBrJglETZXqrUrFDNZIlMKTt5pKKW+buWybL7i4TwEfUT5Haw5B1+V73l/e?=
 =?us-ascii?Q?MV2iyYil9PiP7pVOSQ6CWXKnUGsrc9yr3ZUv7pQjXs8JYoj97DYyEv8N6rCk?=
 =?us-ascii?Q?BRWFOQX/4LsfUYn5FLSXEbJs4VHhLIC5VjPF5Fw5e8porbJeHd3Lo1zI4u9T?=
 =?us-ascii?Q?7YfTuPYWio9SdD2ksCVQMc0/BlVhjulWBelFYkDyRw0vphxZmDyWQS25DJSk?=
 =?us-ascii?Q?G7/5uJwOH+iX/B1oM5kkIkOxyfBNoaXPhB0X/MIO9XOQdgVBBeWz8sAgXzd0?=
 =?us-ascii?Q?XdHmMNbi7pE0HNIwml90cJVDHby3sX8TtSPkD9iqIDyF4f+owe+Om2wU5e+Z?=
 =?us-ascii?Q?dSxtaVFFnZwZYYNGbgrBP1nfBL9slfmY1k0snxlPsXjdtTul8iKH7IHBQwaH?=
 =?us-ascii?Q?5oZlRRYxJdj5qN2TlAjtaVc86pXneidGLMOrjMxBcw/kj1q0OcX4fbCB+Teu?=
 =?us-ascii?Q?ynf0SDE9NHoa/fPY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1972;6:ZRNgmWRapMwcDETpJLnItTDlbw6tIjldv1k9TErG6MMOif9O1XPfksc7TK6oKt4AJHh4/cptx+JecbXcB01HdQbYwuJjLRvJ794hovFBStKWD6xETUAKT5wcdaA1oS+xWX5wuSfAo0x0Hc4BqZza88LizT60Vgnj4nFuTN2LbhHgEjgut0nWEKWF+exs5calPJQlJl0j232hKw6waEpkoRIKBd+ZzzTNXaljhcurTDUTMdsqxoEaAwZhAOFTwV75b3T+6+5bqBeOlVXueI23NJ8I9wOM7ymBtYtOhVBfLRhpe4lOnqodbAu6kqC+thnk1+CUVQgvyBjQ6+Lo/+AN7pdJY6WzTiEKwPBU5urkggXMG4JHyZtk2R7iyb4kaDwhhQjf/GTJOpyQPNP8e3/XhA==;5:jpHCZqQifGyg5F+nq48Lp+4UEstQh1Nm8kF4ZrZHiwpopXEp1Dwa0duTP/Lyf5cF3c9KcANOthln2D/gpECEWCiQn8p6bFTuMHh76C8u8Tl43X3N34D0+89SZB7ULLXagCstq1zZacscgTBozH9vfA==;24:/ZtlUQiTfouVwtdjljUC4ARmmq3tqRzN1eM8j2dwKiZVLKMkMYVcb3jw/xa8G365dBuEcDg9urLLTO3bkytU6JskmrQOq1tfIE0NLpT7lxY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1972;7:9qlGZDfDgcMy5IxoGkvH8rI9cI0hsuujS2bQjIV+HMa+/AZSlr99J4IaydWUQw9clHDU85RoVmUF3/c9+rtATnpSV/8EgRqt2YeB5ZLild26KezpjZOIsagALsx0ybFAlspV9UD8WX4sbzh7y7mH/kzmj7+ckEj2u/gv1H8RhfX33GtGFSVLfuvqnS6LMrBHxL7ewEvirddAHNBVV1h3LqyYlf1uOpTfxJ89nY+IuSKNyYngQkXkGFAHHNe66U0MuarJQgcddYUZit93Fy76a+u9AhH0NjTxebCYx+Z1Lx30Hq+gKuJ9pPLHm8VGUMOozLhRILMQ0WEBppvGBxbmkA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2017 01:27:38.6482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1972
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: Alex Belits <alex.belits@cavium.com>

Some users must have 4K pages while needing a 48-bit VA space size.
The cleanest way do do this is to go to a 4-level page table for this
case.  Each page table level using order-0 pages adds 9 bits to the
VA size (at 4K pages, so for four levels we get 9 * 4 + 12 == 48-bits.

For the 4K page size case only we add support functions for the PUD
level of the page table tree, also the TLB exception handlers get an
extra level of tree walk.

Signed-off-by: Alex Belits <alex.belits@cavium.com>
[david.daney@cavium.com] Forward port to v4.10
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                  | 13 +++---
 arch/mips/include/asm/pgalloc.h    | 26 +++++++++++
 arch/mips/include/asm/pgtable-64.h | 88 +++++++++++++++++++++++++++++++++++---
 arch/mips/mm/init.c                |  3 ++
 arch/mips/mm/pgtable-64.c          | 33 ++++++++++++--
 arch/mips/mm/tlbex.c               | 22 ++++++++++
 6 files changed, 172 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..cd83512 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2113,10 +2113,13 @@ config MIPS_VA_BITS_48
 	bool "48 bits virtual memory"
 	depends on 64BIT
 	help
-	  Support a maximum at least 48 bits of application virtual memory.
-	  Default is 40 bits or less, depending on the CPU.
-	  This option result in a small memory overhead for page tables.
-	  This option is only supported with 16k and 64k page sizes.
+	  Support a maximum at least 48 bits of application virtual
+	  memory.  Default is 40 bits or less, depending on the CPU.
+	  For page sizes 16k and above, this option results in a small
+	  memory overhead for page tables.  For 4k page size, a fourth
+	  level of page tables is added which imposes both a memory
+	  overhead as well as slower TLB fault handling.
+
 	  If unsure, say N.
 
 choice
@@ -2126,7 +2129,6 @@ choice
 config PAGE_SIZE_4KB
 	bool "4kB"
 	depends on !CPU_LOONGSON2 && !CPU_LOONGSON3
-	depends on !MIPS_VA_BITS_48
 	help
 	 This option select the standard 4kB Linux page size.  On some
 	 R3000-family processors this is the only available page size.  Using
@@ -2977,6 +2979,7 @@ config HAVE_LATENCYTOP_SUPPORT
 
 config PGTABLE_LEVELS
 	int
+	default 4 if PAGE_SIZE_4KB && MIPS_VA_BITS_48
 	default 3 if 64BIT && !PAGE_SIZE_64KB
 	default 2
 
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index a03e869..4fb20ff 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -124,6 +124,32 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 #endif
 
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
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
+{
+	set_pgd(pgd, __pgd((unsigned long)pud));
+}
+
+#define __pud_free_tlb(tlb, x, addr)	pud_free((tlb)->mm, x)
+
+#endif /* __PAGETABLE_PUD_FOLDED */
+
 #define check_pgt_cache()	do { } while (0)
 
 extern void pagetable_init(void);
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 514cbc0..a19d17d 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -19,7 +19,7 @@
 
 #if defined(CONFIG_PAGE_SIZE_64KB) && !defined(CONFIG_MIPS_VA_BITS_48)
 #include <asm-generic/pgtable-nopmd.h>
-#else
+#elif !(defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_MIPS_VA_BITS_48))
 #include <asm-generic/pgtable-nopud.h>
 #endif
 
@@ -53,9 +53,18 @@
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
+# ifdef __PAGETABLE_PUD_FOLDED
+# define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+# endif
+#endif
 
-#define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#ifndef __PAGETABLE_PUD_FOLDED
+#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
+#define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT + PUD_ORDER - 3))
 #endif
+
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -78,8 +87,13 @@
  * of virtual address space.
  */
 #ifdef CONFIG_PAGE_SIZE_4KB
-#define PGD_ORDER		1
-#define PUD_ORDER		aieeee_attempt_to_allocate_pud
+# ifdef CONFIG_MIPS_VA_BITS_48
+#  define PGD_ORDER		0
+#  define PUD_ORDER		0
+# else
+#  define PGD_ORDER		1
+#  define PUD_ORDER		aieeee_attempt_to_allocate_pud
+# endif
 #define PMD_ORDER		0
 #define PTE_ORDER		0
 #endif
@@ -117,6 +131,9 @@
 #endif
 
 #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#ifndef __PAGETABLE_PUD_FOLDED
+#define PTRS_PER_PUD	((PAGE_SIZE << PUD_ORDER) / sizeof(pud_t))
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) / sizeof(pmd_t))
 #endif
@@ -133,7 +150,7 @@
 #define VMALLOC_START		(MAP_BASE + (2 * PAGE_SIZE))
 #define VMALLOC_END	\
 	(MAP_BASE + \
-	 min(PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
+	 min(PTRS_PER_PGD * PTRS_PER_PUD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE, \
 	     (1UL << cpu_vmbits)) - (1UL << 32))
 
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
@@ -149,12 +166,72 @@
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
+
+/*
+ * Empty pgd entries point to the invalid_pud_table.
+ */
+static inline int pgd_none(pgd_t pgd)
+{
+	return pgd_val(pgd) == (unsigned long)invalid_pud_table;
+}
+
+static inline int pgd_bad(pgd_t pgd)
+{
+	if (unlikely(pgd_val(pgd) & ~PAGE_MASK))
+		return 1;
+
+	return 0;
+}
+
+static inline int pgd_present(pgd_t pgd)
+{
+	return pgd_val(pgd) != (unsigned long)invalid_pud_table;
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	pgd_val(*pgdp) = (unsigned long)invalid_pud_table;
+}
+
+#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+
+static inline unsigned long pgd_page_vaddr(pgd_t pgd)
+{
+	return pgd_val(pgd);
+}
+
+static inline pud_t *pud_offset(pgd_t *pgd, unsigned long address)
+{
+	return (pud_t *)pgd_page_vaddr(*pgd) + pud_index(address);
+}
+
+static inline void set_pgd(pgd_t *pgd, pgd_t pgdval)
+{
+	*pgd = pgdval;
+}
+
+#endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
 /*
@@ -280,6 +357,7 @@ static inline pmd_t *pmd_offset(pud_t * pud, unsigned long address)
  * Initialize a new pgd / pmd table with invalid pointers.
  */
 extern void pgd_init(unsigned long page);
+extern void pud_init(unsigned long page, unsigned long pagetable);
 extern void pmd_init(unsigned long page, unsigned long pagetable);
 
 /*
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index e86ebcf..b1000b8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -536,6 +536,9 @@ unsigned long pgd_current[NR_CPUS];
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
index ce4473e..335e3c9 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -18,10 +18,12 @@ void pgd_init(unsigned long page)
 	unsigned long *p, *end;
 	unsigned long entry;
 
-#ifdef __PAGETABLE_PMD_FOLDED
-	entry = (unsigned long)invalid_pte_table;
-#else
+#if !defined(__PAGETABLE_PUD_FOLDED)
+	entry = (unsigned long)invalid_pud_table;
+#elif !defined(__PAGETABLE_PMD_FOLDED)
 	entry = (unsigned long)invalid_pmd_table;
+#else
+	entry = (unsigned long)invalid_pte_table;
 #endif
 
 	p = (unsigned long *) page;
@@ -62,6 +64,28 @@ void pmd_init(unsigned long addr, unsigned long pagetable)
 }
 #endif
 
+#ifndef __PAGETABLE_PUD_FOLDED
+void pud_init(unsigned long addr, unsigned long pagetable)
+{
+	unsigned long *p, *end;
+
+	p = (unsigned long *)addr;
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
 pmd_t mk_pmd(struct page *page, pgprot_t prot)
 {
 	pmd_t pmd;
@@ -85,6 +109,9 @@ void __init pagetable_init(void)
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
+#ifndef __PAGETABLE_PUD_FOLDED
+	pud_init((unsigned long)invalid_pud_table, (unsigned long)invalid_pmd_table);
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
 #endif
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 55ce396..be30ed4 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -851,6 +851,13 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
+#ifndef __PAGETABLE_PUD_FOLDED
+	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	uasm_i_ld(p, ptr, 0, ptr); /* get pud pointer */
+	uasm_i_dsrl_safe(p, tmp, tmp, PUD_SHIFT - 3); /* get pud offset in bytes */
+	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PUD - 1) << 3);
+	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pud offset */
+#endif
 #ifndef __PAGETABLE_PMD_FOLDED
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_ld(p, ptr, 0, ptr); /* get pmd pointer */
@@ -1167,6 +1174,21 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
 		uasm_i_ld(p, LOC_PTEP, 0, ptr); /* get pmd pointer */
 	}
 
+#ifndef __PAGETABLE_PUD_FOLDED
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
 #ifndef __PAGETABLE_PMD_FOLDED
 	/* get pmd offset in bytes */
 	uasm_i_dsrl_safe(p, scratch, tmp, PMD_SHIFT - 3);
-- 
2.9.3
