Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 23:42:15 +0200 (CEST)
Received: from mail-eopbgr690128.outbound.protection.outlook.com ([40.107.69.128]:58060
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994659AbeGEVmGdFePh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jul 2018 23:42:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2kpnCaAd9sk52xa6Yhn7PrlGhpShzn0A9o8PUVAcp8=;
 b=b6SpwS0r6RG+hmXLtSVsg+jpQYJgQPDjNW74u7PDLBV3hjBRCv8dtl48/ioVi0VdeVW9/6l5X1GdC2Nz+YjoexQzZ1qQJn1KwuQ/+x+mjbldmo668nB8RksW4KyXPFjfO5+LMVeDgs+icLDGR2ThWuMceZLTW1TwazwLPma2X48=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 21:41:55 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, stable@vger.kernel.org
Subject: [PATCH] MIPS: Fix ioremap() RAM check
Date:   Thu,  5 Jul 2018 14:37:52 -0700
Message-Id: <20180705213752.27155-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb170f5a-4cb0-4fd6-da9a-08d5e2c02110
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:zvZBx+oDqgmC+pOLw/lY9bK1FPsbZ0FMXV1a053JFGZdYFrVMk9L+yw0tdUQ5Aq/Hd/maf9Os7h5bCYOJQt3nBhbhuXP6VbYnCv6IaUNuWB0gq+H2WIT9aJP4P6gWUUehPecB2OUBr/f2BzRVk+0sgkNteuJhDtdZ5c9C7b8NhrgOVxq6T+lt8HWMHV5M/ZCWuR9QPwOJFX2WujB3J2J8onalD9vHYPJZuzsf496Ur3jBljaxxUPa9yu7ql8mwQ0;25:JgnJsefzdXZjRW9NdQCGplMcPdKAtNjIETzVXnjfcFIBQQOW11CoqsziqbX0dCvzJPix2rCDRp4f5x6zSGPKGOXw/PiID56+EBgtFuqITYGOmhkM2hOCMd8EZX12t2FOQ7bW4jQgsiVtVyGpcrIaqUGJzguts5dExoOD+AUJU6VzhvdMT12ZJftIyH1Nr8exWaq9/BMu43jWBz4nRzvEuuIgUYHhi5DLNG1nbly0ixI8iDCRVZDLa8N8voQtQBZfxYzRIwpfvO26BfuvrwFse7vDXjEcgq86arRCeUSXMcNgYIr9kJLvTvd10Vu8T9oDM1iQ2keiHo1flNYV4Dsx4g==;31:C3GAbqfG2jZFW+jLTqVaT3M8SgkwoDSEnGjTR2frabgu4uUwS+6+01eX2oNBPl0eMTX1ivKYee9UCndIZv+eKe+M33bBwIkL2rK559xSfPowY0UIYmsncIHjk2614sdXbuyt/jFu7mkSn/5ztto4LDEPEVGgwmtDjmbDYL5LXvh+/pYLGeQoFOd64gKoyOsvvknojU833Dgmff4wFsor2OWq5VIJ1KFrz1sJ78f9AVY=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:maRUpHRItQA7s6QFlCM4WLXXddd5/5g8XFYwYaOPqTR4uD5bLrWE7+I/a/8cV7hjB7kvze/qO+XXijbAb+QlB82wpLqDrtOIOkupC6hkaGBhvpgLDnkWnYSzmFxHhsEsdKnNO8vBOqZwbxeQxHEQVE6UpyBcr/YX2xjdna4a+OA8Te7m18SkmfH7MNlM++AjmVcThdQJ4nA4xsCzAYkkhOTm5sPGBxqeZcI2Abs2Wun231h1JtJxNsDFrn4WxGMT;4:ApUq0fK2jDMESq1kj0ELga5O2u5mO3Z0k0ChOOUPgf2ERPDLblx9yfZD/8hGPL34r/YZ9XTKIY4LqZ+iVHPDbRRpv83oJBHs0cgvQJkbugnzzFlg/bMk/ufFMlIbu27Ni8LLQnSyM0I4Qrl1zYO72oTXTfQoe1olI2DhlNxj7babwdzJ84u64bgd6lpnstlgr03pE2rhvL6hLRVAAAxG67VVuov23qOi4QtFkLn5ywiTdYa7IeJ7Sz/S7e6CEhrBgWcvjtKAxuJxMxVRESKRsiP6SGRLIRFeKO9Lj86VPbUA6DJEMB4AZhgrqKi9ezP6/Ix4+3upo/FqBkgArCqnDfU57p3JLfdEe4nSx0ehFME=
X-Microsoft-Antispam-PRVS: <BN7PR08MB4930C688F626356D59983771C1400@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39840400004)(366004)(136003)(346002)(199004)(189003)(53936002)(97736004)(478600001)(50226002)(2351001)(6512007)(53416004)(36756003)(106356001)(105586002)(2361001)(50466002)(48376002)(66066001)(47776003)(68736007)(6486002)(6666003)(1076002)(2906002)(6916009)(54906003)(316002)(16586007)(7736002)(305945005)(3846002)(6116002)(956004)(81166006)(5660300001)(39060400002)(25786009)(69596002)(42882007)(44832011)(486006)(1857600001)(81156014)(8936002)(2616005)(52116002)(6506007)(386003)(476003)(4326008)(51416003)(26005)(16526019)(186003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:ZgY2D4lPWmkKkQ6x1MHhUdPzZhEghmGgiBBTmTtxy?=
 =?us-ascii?Q?Kr6zy/sX9s746OHGhuVeXn05DN85WixcjdqwjZAtTL9rA/h+USv30Ijz4KZL?=
 =?us-ascii?Q?2l4tz0JJ5rkIL+HJpcoaPQzOK3X+fyOttu4LTOa1c8VaE/WBkdSfa6C9MQh9?=
 =?us-ascii?Q?3T92ejwoHVGsRx+LCCNsV87Hv+a9i8RoSiNzLxv1kzPAQOPgxmY7l/I0yYwV?=
 =?us-ascii?Q?gO2v7AVMGMTSZ9BAFA6DXw4eoYqvLwILSynunLq2bkX2UYuhGhLSQUb8Ot9o?=
 =?us-ascii?Q?t+X+HJq0av//HRySzvuVolcvE1exDL73Sr9MFyt6hyxWIWlLyF6wUxMjprc3?=
 =?us-ascii?Q?p4z1eUdAfT4JIPpOBKEA8OzrriczimrvoT1TZxrXv5/8VKD6s/EnlIdDpa1a?=
 =?us-ascii?Q?9RGztWK9tiXpJ92il9CZ/vGRHJZ7lOTDulkWrhSwIUQTCQ3LdZYeII5Van7/?=
 =?us-ascii?Q?aPXSiK7RjxtfQhq/AJQ+tDUF/xAb8BS7mOr1E2zIBRQMYfu1xUTDaDr/hin+?=
 =?us-ascii?Q?7LIsz1TicLLURSojG3HVLfbTXzftqpzBhM8r/978ktcmvwV7roF5pI6w41qC?=
 =?us-ascii?Q?a2Ju+EVM5Y85uja6uYtP9ZPP22PlEC4DLyj1CEsKmsMlJkOKuREnhy7xdD8z?=
 =?us-ascii?Q?6U/nvF785RhQYEaxFFTSoTMuthSzbd3MKy/uOX4vig7aBxPv/QHh/l5kySx/?=
 =?us-ascii?Q?+Ha5bmcud1HeH06qA6H3RM0FdGaTtOR69C9R104J0ifHa6tACSULuk8hYZos?=
 =?us-ascii?Q?M78rVP3h7u1Ti8LFKJ1ftI8a/CmHndqWNnn/c5FPsnbnFx7GLuYogoQOEngG?=
 =?us-ascii?Q?pMpoTQxnuESASQhnfIXX8tr+w4uF01xm9TZM7xZceYkoCl8brN/C+8Xf7F1a?=
 =?us-ascii?Q?Pk8zLl0KV5jjHXYH/9MCMqKulxnJ5iK07utJY2QLJ18bAfX6WmYWGckKKaIf?=
 =?us-ascii?Q?OT0NPOpx1lPJu/3yUivKcQWVCzZsyU5+4mqMOffxnqft/CFfcpbUNX5ZCjC2?=
 =?us-ascii?Q?mdKANLNat6Spu66GGWFIwFjDJRZ45zGZG8HwS86/oU4MYHfq6Ui6mn/yPh5X?=
 =?us-ascii?Q?AboUYY19QJQBnoHoXABadUMBv/u7qjQGBo7zjZHnQKegV1XJ5D2GwmQsBDPy?=
 =?us-ascii?Q?3pah2uW3iVFw7I6k6O25f6Cj9LInR8zzuh2g+asPFC/edWyjSOw7UEt8rNSD?=
 =?us-ascii?Q?SCAsjNzdopvHGAM7JQ04AHS3oShtHisYdfr66KHZhgoT2VSh4DtXod5pLUpG?=
 =?us-ascii?Q?jBVqCg6OOiEoU481fSLVAaFagdAYpzDEDP/JGjXW90pLFr4uN7g8WKosGQST?=
 =?us-ascii?Q?oA9pmuyM2rbRIEA/hOMVqs=3D?=
X-Microsoft-Antispam-Message-Info: K+XpCFxVwoJ62FQ1sbuc9YEbK9wxHonn0o2nr2IuKGCmOAmcOTgIl5vHMf1Qtxf3WHta+MyB05IoJVxK4ZLy6Kmw+Z1mpZq0Qox9gaViuj66RfzWuoR0styoaRTbhqj3n+uYcVRqWIPJekVOSoIy2o+ScaQl0pfExltubvBGsYyTijKiVzOCq/Js3A+DhET0FP3vMBHsWJ1nSvnKvsOXv77fnV/HYwWEKnt7bOGXkcy0TmD0GwwAMy7NTsEpQKl+AxYwA9jGa05jXw4iC7K3IiIVcltL517GgIWGBUuXm5VK/QItd/Ue4pIwJQ5xNSk7MkVSuBEhSILcKcZJKDwESgJEiq4RCYsbQLmAtIJEydk=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:dC4dOzi9sLUr6YKlgQ6wK08WEAXZAZcj52jFVeucCxw/4eNWBz/FcpH5PVT/8fmM/l/474TSNANgy0VYVG4iFYCKvm5ODEPsXGWWgSvOEeLtkTKEHi15x6XxeheTfCD3qimQsoxhEGebTuXxNlRMrWHHrGx92SaPrRZo6uEUzHbTqcQg5QDk96EhsExRpzurCC2j4pUwoF7jySska9V5hdySKoLSbi+IwiD9bYOLIx//DfOiUZMaP9dLORvkYMFD1LFsrAXU5y5AVYZuUU85WcNFiEjMcFnahBL41ZKSIeMpnDLwwofqQ2mSBk5uPUp9sbhTF3kZ6opEzJipbtPvm7csD6ydF4Mfdzgtm7kPH/lDpjGqj2djMK2unGs3KRmR0pn8kKPfKBrRfURvQOsjW/JnOLaOlSaZcE1JH4RWTua7ebbAfgpFDzBaCKt2OpTXZtx9GcjO3zSd7pFdY+BSjA==;5:hZAD08j/1LtNcTU/XpQbwC/62TsUsgL10Dnq77nQflDJxrUD5A3PvQSu28IA0oJoIOKdIBFeBYC6FU/Q/+10dlaeWe69+AAPF6Xqq8psRMAUI5wmt6MpMBSfyC31rlF61fTUyjoxdLV9zCz9Akxvz13SXYxrVzHok2wy/kOaPfc=;24:jO5SVfNSZrTNVKB6HJQhM/cyxXqXtPUwrZX3oo3FSlClwvoyxMFQzO/mIAokpHKJ13UcWlkpczWxQGIT7SnTG9bYRs9+BGy/aGsj8ns1N68=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;7:SfzJoa2xQaJFBgnjw2+upHIrb7466vgpORy4D0nE4x3AWA5MHrYp42Wgju+T4Wvd4qa/n8mrEU19poyAVvp3y+wqoa5hLWC3eyqVrPyGjEt+u//yCrVOkyF7cvvG9Fkpdsq+yqBjhVBpbdbKT6RqwG2AFJhbRnb5kXY57yw8SVOKZ/QrLbb1Nm548CTbFDMLsWWsSol9PZXuTUnstKkn5Qs/7Gm0lFFWYi5Fq8ok56zKctMDiatNPAyPrOiJLTed
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 21:41:55.1588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb170f5a-4cb0-4fd6-da9a-08d5e2c02110
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

We currently attempt to check whether a physical address range provided
to __ioremap() may be in use by the page allocator by examining the
value of PageReserved for each page in the region - lowmem pages not
marked reserved are presumed to be in use by the page allocator, and
requests to ioremap them fail.

The way we check this has been broken since commit 92923ca3aace ("mm:
meminit: only set page reserved in the memblock region"), because
memblock will typically not have any knowledge of non-RAM pages and
therefore those pages will not have the PageReserved flag set. Thus when
we attempt to ioremap a region outside of RAM we incorrectly fail
believing that the region is RAM that may be in use.

In most cases ioremap() on MIPS will take a fast-path to use the
unmapped kseg1 or xkphys virtual address spaces and never hit this path,
so the only way to hit it is for a MIPS32 system to attempt to ioremap()
an address range in lowmem with flags other than _CACHE_UNCACHED.
Perhaps the most straightforward way to do this is using
ioremap_uncached_accelerated(), which is how the problem was discovered.

Fix this by making use of walk_system_ram_range() to test the address
range provided to __ioremap() against only RAM pages, rather than all
lowmem pages. This means that if we have a lowmem I/O region, which is
very common for MIPS systems, we're free to ioremap() address ranges
within it. A nice bonus is that the test is no longer limited to lowmem.

The approach here matches the way x86 performed the same test after
commit c81c8a1eeede ("x86, ioremap: Speed up check for RAM pages") until
x86 moved towards a slightly more complicated check using walk_mem_res()
for unrelated reasons with commit 0e4c12b45aa8 ("x86/mm, resource: Use
PAGE_KERNEL protection for ioremap of memory pages").

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Fixes: 92923ca3aace ("mm: meminit: only set page reserved in the memblock region")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.2+

---

 arch/mips/mm/ioremap.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index 1986e09fb457..1601d90b087b 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
+#include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -98,6 +99,20 @@ static int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
 	return error;
 }
 
+static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
+			       void *arg)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (pfn_valid(start_pfn + i) &&
+		    !PageReserved(pfn_to_page(start_pfn + i)))
+			return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Generic mapping function (not visible outside):
  */
@@ -116,8 +131,8 @@ static int remap_area_pages(unsigned long address, phys_addr_t phys_addr,
 
 void __iomem * __ioremap(phys_addr_t phys_addr, phys_addr_t size, unsigned long flags)
 {
+	unsigned long offset, pfn, last_pfn;
 	struct vm_struct * area;
-	unsigned long offset;
 	phys_addr_t last_addr;
 	void * addr;
 
@@ -137,18 +152,16 @@ void __iomem * __ioremap(phys_addr_t phys_addr, phys_addr_t size, unsigned long
 		return (void __iomem *) CKSEG1ADDR(phys_addr);
 
 	/*
-	 * Don't allow anybody to remap normal RAM that we're using..
+	 * Don't allow anybody to remap RAM that may be allocated by the page
+	 * allocator, since that could lead to races & data clobbering.
 	 */
-	if (phys_addr < virt_to_phys(high_memory)) {
-		char *t_addr, *t_end;
-		struct page *page;
-
-		t_addr = __va(phys_addr);
-		t_end = t_addr + (size - 1);
-
-		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
-			if(!PageReserved(page))
-				return NULL;
+	pfn = PFN_DOWN(phys_addr);
+	last_pfn = PFN_DOWN(last_addr);
+	if (walk_system_ram_range(pfn, last_pfn - pfn + 1, NULL,
+				  __ioremap_check_ram) == 1) {
+		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
+			  &phys_addr, &last_addr);
+		return NULL;
 	}
 
 	/*
-- 
2.18.0
