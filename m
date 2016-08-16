Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 08:24:11 +0200 (CEST)
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:1314
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992897AbcHPGXMC6yy9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 08:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IDoBgsa7jsCOUO/cTpkqOvlz2WEIh6z/JSEdS54Ixn0=;
 b=jJgPfwDBN0ZVWHkqo5iDtSVdKj462t/EmScoSMHmYnq6KadPW+vXdVDuxQbukEE5XdZ8oeIzNlFPQT/LzkiCxRiLYOcIV9n1bbUOe8O062+ksJQKCs3Jebv+dXAI6an7wMq9Ioo6Kb823ieJBHtv08A3Y1QTDQ63AvtPIbHWqHA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Belits@cavium.com; 
Received: from abelits-laptop1.caveonetworks.com (50.233.148.156) by
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Tue, 16 Aug 2016 06:23:03 +0000
From:   Alex Belits <alex.belits@cavium.com>
To:     <alex.belits@cavium.com>
CC:     David Saney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 2/3] mips: 48bit: A part of 48 bit virtual address space support. Formatting and comment changes.
Date:   Mon, 15 Aug 2016 23:22:55 -0700
Message-ID: <1471328576-16758-3-git-send-email-alex.belits@cavium.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
References: <1471328576-16758-1-git-send-email-alex.belits@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN3PR11CA0028.namprd11.prod.outlook.com (10.162.169.38) To
 CY1PR0701MB1693.namprd07.prod.outlook.com (10.163.20.27)
X-MS-Office365-Filtering-Correlation-Id: 7791440c-4c06-46e9-4046-08d3c59dc806
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;2:Aj0LenFWWi4ym7aXrVGIODcooYTcnVD3HtC+ghkhW4emajDKNtC9WuI8U4nLHtly3F/5/MvGZQKQnqM45VisBkA/pdcd3Ule8q7P4um+vXWf2rSlnS9+fvuccyKz/yTN/xUi07+WmcZP/4U4sie7D5d28vqVY8NwWRF1GNw+hU+C9VBCtTHDNLo/UIC4k9lp;3:6QTtB5wDZYZaun0oqVBvPeFTMrYd6pdlMNokIQM1SpO63svYYtpcRoloh6YxWfITGJmvZi0lomXczcTkL11XVwyzv5I/cETr8HQmB54h++G+NpK3bfsy2nTXTbTkTrqs
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;25:KBCTA84vm9TRx5hY2jg3aBJ9E6ANyV/JDyoDpcjfHO0vTGGUKpOdf/d1oIu7JLth6i+fxGMNeASBuh88korP7aiwsrVIi+bE+iF2IX1/HDtaz5nCM0He9Y+bltKu5VVy11h0RUIZzOgJBnWCgcWKe2s9v2NqSENez0+BbCP3s0+sJmsAS1f5qjBnuX6SH6tCXT1I4amIhQmd+hUWepNdpg+OeKw+V44PKDLUkYxjvp/ihsiKaFtJHnWJPGKyQ9e57B8j4mM/QAXami5FIgpZg2TzHwr75pMcpaiERWRO8V9MCh99QeQjgJYlHWBMP1d/XKHbKLstoBZOlq1cbz5sqLxcTQ/nw1XEuv3jDAdZ21VliUjoTQEs84rdgjMlgB8a+jYFdgpQopZ0bJtlxE9XSZSmTjH0MBxMVvWOY6TUDJWPoVHvPflbOoE0TALp07g2LVszWiqPbvlQOZwXxU3uv8doO+3gM5effddHxv7zRH+JIYmEEQ+d8g2C57vCalM+Nss2HVEQshDklRbOO/WA0rGiB3vJ8iscvb8tZXLuEOkZWVC21sUFGa5SiO+wn9j5wLTSTc6q3LSnGNQbkAdBTP1xAcjaLSZOVMLF+3XyLSq/jonuzcVRv2AU3uD6ZqkV6e7IsjJ0BZNwhOaUFKpdd56HENH03y7rs7cCmbveyRcNuUIOVdPDbSMwViQwAyWI;31:bUMnSb5+iHgnIeKu2QuLG/QFuespXZRh5PR8daTCNX1hsGUdx47PrkGO0nZaAz5dCWqAdw0nXW6lBSHZ0xqbFeuEHTOoizuN2sal/OXZnURfL/Kmf4EcoNxJezLXEPF9UuinhIl8OyYQZt6/gsg2MFvGslCcno02QF8aaFDrPeetrFD5uHpltyj4P40ud3JUnba7nYO7ngb3GTBaokwsLP0nhKnFbCR+IFeuaLOxE4Q=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;20:IwGle3yOo8jv2M8hBwgvkashZnmFMk7J4xWCCcr1CIS5yf4/HGA62OHMNr2I0017qSxHp6aJ3d74WYofVSiixIfZ0bBUq/lTFDZXvBv6iP+c+8P3eGY4DbQKbNPaoGM6dhQuE0c17BJRTsRcoI7aBRVbiZxCwZUzLuNWmIy7nEdqi12Wh5EaXtEVPdZY/XSPabUkga+o1W5+tfoVSnV2aW3TXYCZ+kvpwlih6vBoe7LS2VozgUAs4KPErO72ZlK9DyGw8mcGNSgdP6YTBVAc6IHVNtDVEa7mjm2XfGLqOQ9sqXzxfgWZTOeqq0YaTftjgJMTgXwDYkTim45LhG7Hutri/TRxIz4fwzXCllsazWp8w0jAt9m9kq+p6WAIkSTKXIvmUQzW0MnBbC7ZeoqxS0O63Bkt5r07aG5+xV4piBnEdJmhYPXXRTrdfZ49S/qOfVyjZ6JpJjOQFJoC+xfObmVjrYPayHAYl2xBjcX5Uw0bOzF4M+gVIu+KyJquyDUd;4:SkJ3zqA3/WDYsVKezch50oMGUJZsd2NefZ9D249Oc1EOCm7iq7SNSIZ71djyBDrDvKVFpmiu5KlhSaNDWaQxiGipVRLoeFeal9CwoZcR1tO8D5y+cyVBjw0n2ZUw36ZdQkX3UWocIULZ23EST7Xn9KWpSpW5BODTTgk3ngzYx2ORkE6aBKd+RUqZxaLn5hg4Dg74VuyIY3q/86tSGH8UuGRhmGz3NIvHmq6Xw1ZEkDUmUpJhA9wDCAY92H/NSja2Zd1+WYJlU/1FOF0fTga9p8TPmHIBz/ezyREtxs+PHiAPcYGeIekV6/91P7C1XbOLuigLnU84scEQOKj2S5niq1CA0d5k3thFm5SPtgxb2546nm++HA5Z8cASnmyPON0Y
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1693DF715E11FB396ECDA26D8B130@CY1PR0701MB1693.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:CY1PR0701MB1693;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1693;
X-Forefront-PRVS: 0036736630
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(97736004)(2950100001)(19580395003)(110136002)(189998001)(33646002)(450100001)(50466002)(8676002)(48376002)(66066001)(47776003)(2351001)(229853001)(92566002)(42186005)(86362001)(575784001)(105586002)(106356001)(4001450100002)(5003940100001)(77096005)(53416004)(19580405001)(69596002)(101416001)(76176999)(2906002)(6116002)(3846002)(586003)(7736002)(305945005)(7846002)(6200100001)(81156014)(4326007)(81166006)(50986999)(50226002)(68736007)(7049001)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1693;H:abelits-laptop1.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1693;23:Wdkhfvjp8rGM/o/CeJ8+3btCRISzqu/fhTX8POt?=
 =?us-ascii?Q?fa/axzApJfHDuXmJVy809uOZ2Hl68afXYKzO823obIC7oICccgF3NxVFW4c1?=
 =?us-ascii?Q?DFYzQcye8Ofyr7yodjATAjoh1mUgBthifeVULajMDHVwMqE3fL9jQW6WHutS?=
 =?us-ascii?Q?+gS05Ow95y3w447QFZpIWjXBAe2pJv2LVn9aUElQFxI+4Lf+01wsetQ2scfv?=
 =?us-ascii?Q?nHPQIAavpx6KbipURIp4LmQUw3b56pOUx0Tv4iXIv5Ejr4sBAr/vsccUA7sX?=
 =?us-ascii?Q?JthUduO0iazBz7R9t4pB+pzSN8FIdfrmNK6Fca5NOR6xm9gAp6OAe+ou3tsq?=
 =?us-ascii?Q?wMHM7IaGN/foI8DzhnWs/7dGqTtZJZLGCSdlUf0G2sI79QYypWBgSaE/7W/z?=
 =?us-ascii?Q?UurbWY6Fo7O72Gzlu28FwUb+4yBz0oDLgzrNNqmOMg0YWbq2h1obHJmL+iKa?=
 =?us-ascii?Q?ru/yBgtzR3ka7tN4PLX5EDVVvCpAaS/FKG3+iAyaWQkgvXgoLDYT/ztRoaUT?=
 =?us-ascii?Q?6BCXbuJJ41iUrm3J7YeuCuVuGY10RH1IEBw9PiaLVrZJLECGA2Nu83qLAA/p?=
 =?us-ascii?Q?y2P1ZYYmNRuDeWdCmKa9qRbJoXtt9vJBLP1BkMRQSnWJVeQqx6TTYxolc/DD?=
 =?us-ascii?Q?TVCnW3Fh9IyWLfnjlH3N02Y0Q8gVAOEnKnSCzWdrk/rh/0N8I7jSEeA5Vhu8?=
 =?us-ascii?Q?W3qsvTCMqWnFTeu8VkcIHLKzt0p8VwCs/kMTtmOpq4biHECNzh5HDYIrZqjB?=
 =?us-ascii?Q?yhzAh4jp0f6E/qhKYNEVKIQjAThQ5xFRQ9rGH29fHZBXrSPzpgWjDBUxjCGn?=
 =?us-ascii?Q?LIBX4vHoR9p4DBRLO3VkoYCTOnCLgex4g55R1CBN/haTSOIEc89rgH8NHcBS?=
 =?us-ascii?Q?yZr6dAWwrMv3ZegBGBgjQqkxAnbHoMIXKHibcVgeUmhR00cLt6MLcfM+lLB4?=
 =?us-ascii?Q?JZqDFTAOnhAcDQM/HW4zEdbwvbsj5aQSkr19kkYSu4jxVwJos4PAedw5Y1Qw?=
 =?us-ascii?Q?hM5Kw/GVyDMN4QVJOTMLhqWo2r1KHuLX4DAnN/zpKKt403LO7kphA2HhZ6pT?=
 =?us-ascii?Q?outdAZiH2Y85uomB3+Lc5Tx2LiaAmAmPKQL7ZAV8qOk5caM3hYbv1FpC9Iua?=
 =?us-ascii?Q?mGA/rIC8JtQjZPM8ZCpB3Ar9zlD1pwIO9KaGnZWfJKoZ/yGpz/pttvQwnKo1?=
 =?us-ascii?Q?EofioJV9iDS11vOEDtGWnNBKblwQ00Hz3Qe6v4WrY6g3KVNE+TOrCrEOJ8A?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1693;6:6m8sHx2rXOcXlEyIQYNXTojc3LDqDWvaS170e6VvQU7RmghELCuSeghzmR1CzoGIFDSCQ2e3/G6u4oZZ8+w0zIaF6/6tKwj1EbSg5h5xNecdsknnBZuFSf46QSWSNSivzjpLm/OQjGD1bbuOu6tnnqL1yRZGsxSh7SxSd9s2U6wSFyvnVdqO+DD51nda51S9S61g1abxNjrMaaRakG0bmU/P5l+728eWEiyCkUnRB1k8mr8pJV233SrMMifepBdFcwM7GI2bVtCNgy84P32gY/fgAygeGaTruF8msqRoRRM=;5:Fokrq/nFkhq1XVbdE8ubJuSOT22+tZa0Y4gJAGE2gK8uyQ4juXUXWnqtfaW00OrWtJK3Gebi0dtjVcGhQwemZiM19fY0vEVuSq3ez5k1aHB3waeNzQ5gMizFMOl39rhx1CX5FEIekv44MqMd6oa4LQ==;24:yKqj5nrRvP3hw0tJ/A8xtn+6YILWteGu4wm7sp4bxAHsYQULojXiGqXavLnFYuBVfoEBIJpKCDw/AUUvjfhi+xBRIgI0MYUVSnSew63tRaw=;7:uv/BWpUrf2Lf3ryirUbgqHPgRCbIB4JPwWqBnJqjTKuLni64iTSwdqB1eN6Ax1+Ve9aeBJC9Tkb3e0kbX+cOu6+tP6/RRTCbwa0gcMgy8RezO3K0b3EDGM5EK6rt+MLjJRsXXDwDoF4RpBTaWL1+An/mS5C5f44hgIznB+zX/uvpHJUdlKgWg0zao/wD2Z9NIiU2wkBjWkQ2cbfFtoi7SyP/jpEIhVSZULj3RtEpwkPexhP5ivs6PAea0S9CjELF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2016 06:23:03.8475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1693
Return-Path: <Alex.Belits@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54562
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
 arch/mips/include/asm/pgtable-64.h | 14 +++++++-------
 arch/mips/include/asm/processor.h  |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index a86bb73..e9805ad 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -45,7 +45,7 @@
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 #ifdef __PAGETABLE_PMD_FOLDED
-#define PGDIR_SHIFT	(PAGE_SHIFT + PAGE_SHIFT + PTE_ORDER - 3)
+#define PGDIR_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
 #else
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
@@ -60,7 +60,7 @@
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
 /*
- * For 4kB page size we use a 3 level page tree and an 8kB pud, which
+ * For 4kB page size we use a 3 level page tree and an 8kB pgd, which
  * permits us mapping 40 bits of virtual address space.
  *
  * We used to implement 41 bits by having an order 1 pmd level but that seemed
@@ -70,8 +70,8 @@
  * 8TB of address space.  Alternatively a 33-bit / 8GB organization using
  * two levels would be easy to implement.
  *
- * For 16kB page size we use a 2 level page tree which permits a total of
- * 36 bits of virtual address space.  We could add a third level but it seems
+ * For 16kB page size we use a 3 level page tree which permits a total of
+ * 47 bits of virtual address space.  We could add a third level but it seems
  * like at the moment there's no need for this.
  *
  * For 64kB page size we use a 2 level page table tree for a total of 42 bits
@@ -91,9 +91,9 @@
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
 #ifdef CONFIG_MIPS_VA_BITS_48
-#define PGD_ORDER               1
+#define PGD_ORDER		1
 #else
-#define PGD_ORDER               0
+#define PGD_ORDER		0
 #endif
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
 #define PMD_ORDER		0
@@ -122,7 +122,7 @@
 #endif
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
-#define USER_PTRS_PER_PGD       ((TASK_SIZE64 / PGDIR_SIZE)?(TASK_SIZE64 / PGDIR_SIZE):1)
+#define USER_PTRS_PER_PGD	((TASK_SIZE64 / PGDIR_SIZE) ? (TASK_SIZE64 / PGDIR_SIZE) : 1)
 #define FIRST_USER_ADDRESS	0UL
 
 /*
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index fc1c0af..083a56f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -72,7 +72,7 @@ extern unsigned int vced_count, vcei_count;
  */
 #define TASK_SIZE32	0x7fff8000UL
 #ifdef CONFIG_MIPS_VA_BITS_48
-#define TASK_SIZE64     (0x1UL << ((cpu_data[0].vmbits>48)?48:cpu_data[0].vmbits))
+#define TASK_SIZE64	(0x1UL << ((cpu_data[0].vmbits > 48) ? 48 : cpu_data[0].vmbits))
 #else
 #define TASK_SIZE64     0x10000000000UL
 #endif
-- 
2.8.1
