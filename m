Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:42:05 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992364AbdI1RjJG69yF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fakpGIr22Hwuo1onX2MSJF3L5DSfmM/EgEDLpubhem0=;
 b=MfUS7Uq05YDFH2G/0onVix9XtGwOOP/qkEKOHcEicGxeH03jTuXHhPqIZL6b+WVe5SGAjU6MLRYMh1MOBEy2HDRssEQUN82JZoKZ/kWHoUO+cTpu5+HmaZfBltAdpJATg/8GS5jYSEVq/5Erna8pbPBuYesEpanwlWwdxHEoXZo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:02 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 08/12] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Thu, 28 Sep 2017 12:34:09 -0500
Message-Id: <1506620053-2557-9-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95683b90-06ff-47b4-425b-08d50697cf14
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:TFnJLs1rtZ+tQ3jTiP8az3M/bGyj7nJBld5tOL5UQ770c9557ro8nPKDytvey72nWn9ZR/2sVOlMCras1WxQYEuzuiKESFXRcP6FbhgUywZFF0EjzWJ11tmwp8RxZoIWHimT41NfNE5AInRw214Ui18ecn6cuNrNGziBVqdCLC0HnWPBHMGnAlmeV8PANuKqBG3Jdw8oh/YfuqZO4omjlyQg01QaixucEMeXoNPqK46I+WI/+Sk4yWcGI1SvMtkZ;25:XVbonwzOvtOwGq93JQkw5V+9SYYeChX47671Ef1tuuXq0VTWWs9UKVKY4NHAcK18O2Knha15FrkMs8U3gASXSK/7uVaHfz9jymEbW6dUmuYDCWABArq9ctAqf5pZHVlMhS59OawADxny4EdglSceMls+jfmy7XT2esZOtq4j1kI+g0UWldGR2i+tk3qar7ZA8oksM7atL2klhFEwjx83wkPUdP30kmBEz0hR3xcZM5B6ll3oFqlqZlvXeYi297gVGMG53oR9fJsXvLv9im9/hb9I9ZSNoVMxoDHffkMTmUtgaa+omB+qiuKNVGwRmmQtS+1RZqvql5VUifJ0mHqCsw==;31:rBLHBJMgPPzzbYyAmv1GWvunmizHBQudmCwAUaKWNWE+cEV50M29KHPNAeSRLLVx8K1kVsTsvB0H6r5+a4FSdoQfKrVRPiJzr/MHZDQUKVXx6oCAlENzN5i+nRoJ6SQURcYRwfPsKnqoUcbo7bgZt7AVM8HG+3xw2lzKlM4fw1OZGjarh+e9HHRjWA63fofLRBXLv0/9WxVw462NPYhkOhtEvDL0hKBdvDWaxu9j/tI=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:l3mUDppwvKKCLZMk+09NLDKaYdZ4yPLef228hrtP+yAumdl17GsqndHlOVwE+RRtETVOXFN3zF2vVU4ovkqxtD2bI+8K7IKCUCYkFSFlbr5iCzkFMMXKPpINRSczaNlz2ts3frs2+3k6tqYfZShpQYn3Fm1BA6dCF+B0Xjyg5dbhgYeZa9cf/RD/KzUQ90thToH4xOSW/CiikSx+GJVfOBSFLnXqwpLAJCgcgEi0ZYnYErdfuy04KAOYe3ltoBkr5rCdo9qY6jfUnMXoEaxSRCuU2qDxt8Ai74Fx+i+dc9Y1JYQ0VJCpk6k86kjqVBGzOHuTOwLq9Jw14k5HXNGQXwxSJiPFWoOudCQD1yz+Dxje5JaUE8sGYl/1jieyx/0VJ3+OU9RFnayPbYRHNQqmxEyYbb2LKrcSP2oqlEdnDPOfX99U3CDjRgwQ8EfbE2/Lc3iDf8gNABxgAEh58NScCzHYI0rCQGkncvcL/0A6SQWxcz0gEIx/v7vTA5C3VZ3/;4:h9OP30/W3sIj72DRVHi0/mggo8pYYX66YF68qfifpaK/6DRwDz/oT8yCnp9Pi9sC37RNj/dKBKdPW2vTN0xHxvyjX8XhufmWYK34S2+MCOhM7WNfMI97AwZOyu8vCwdND4R0eUarRcadWqYQSgnXh6AuTQVrNAIiG0NZENogu/tViB897qBfAdqHw/Rkc+g7NUGjsVhGQmg9BSYpCkhGFPDQPfjYDHYPSaGiNGYK9iN6xzFF2dLVTXCa50mWnho5
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807C155747889EC77201CB780790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(575784001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:X7gJXLsEMkk10OaQaucgftjoNlKvbVVPk2jY8Xe?=
 =?us-ascii?Q?zRp9DIaVJjxDwyPMjTSRh88jsvt3x7L8rY70Ua6txUFNtJJJfNqeQP1kx+z2?=
 =?us-ascii?Q?YbtfAMWad9QF3kLuMmXpCi4DvUJnbVY3LZ11OiMuOYqWvV5MPaohFaCqrch3?=
 =?us-ascii?Q?3VtquDJDDMP3kQ9WglEvPcLLL26c5p+dKLiQ+gk4/ngB4WuAse2SEcENPHrL?=
 =?us-ascii?Q?nmKdQ36633LUhZQndpt9dS6t7BYAHRSs+qc73sTajtwzxdzhfL3uDzl+PBs8?=
 =?us-ascii?Q?ClgAAIjoTCCF6BMyWtF4ElsoaNPSL6oBnkvFTJJjb4006ylwJpQ4lC5GaUGq?=
 =?us-ascii?Q?m2KOSNfvrRr80ZZHzPba47S9kjk85o6+pdfB6s668QlLBmkL2gQNjc3PHwyi?=
 =?us-ascii?Q?7ha6l19waCbVds9ZEhDGPysMjf5j/B3tVRaOPpJh8rORjJtWw0owsNh6XHIo?=
 =?us-ascii?Q?HJJX+QLSOIjEemmrUjVTjZ9CdMpAoA10lBXSg5bwM1LS2OLRG9kaX4TEhmpq?=
 =?us-ascii?Q?/w5xjM7zu8rlbluk14sFkYzOPs2OlQjgoVX19zI1X/XNbxSrza2STZXHGidY?=
 =?us-ascii?Q?SkLD4G3RaXst6aXB+tGohdF9U8BBndUGJclNgh8PzPOcKBpTKWdgUty59Q1F?=
 =?us-ascii?Q?giDljaQ5/YRj8o63r5TBQ/LQ72ZMqsK7V1AzrJEvfTKO/2WSc0o+VFOMocFL?=
 =?us-ascii?Q?ed2Ilici3Wf40BpsXzrUZeZZ+RLPtxWrCvIBWzIrm8uJNOxLKBi3u0AHvFDa?=
 =?us-ascii?Q?vEeOIIa3K/SdaFmbJ0BZIztDgOSx2FZzrriJFdfKMiLPB0DoTVy8H1WWRYTd?=
 =?us-ascii?Q?ycOr7zx70ha6KNBvbp6boYK5e8NMoJOtfmu0gDHo0Cgr+Z5hC5VDf+q7HFo7?=
 =?us-ascii?Q?Sq+BmTdnprkiIGBdOp92X7+Y7iGPWCq0LNYOH+Xpb3LYM2qmaNHT7dpYKZEF?=
 =?us-ascii?Q?yIUJp5ZXNwQGTmWML/l6ETH59KIxsAKCfVp+1ul+zZL8rxjOk9gBrISPwBeQ?=
 =?us-ascii?Q?h4c5SPR+B0NHENUvWh3ZSaPjittTaBHRg9xNuZBzk2krwcP5qQBncYbNfyEc?=
 =?us-ascii?Q?aTniNZTZmtstoE2zKaUzrMM1HRzPklQr8S76H3qkytY79p/8DQI8/wWwER+E?=
 =?us-ascii?Q?FwUIBH2TGowmOL9gwNcZq5cnOm13hVaGpKDuE+oOYAhIaCYD32v85WMW7QAT?=
 =?us-ascii?Q?HRrsT8eZ6gl/OREk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:SEbf/cqw2VnKmejWuMkNKamu95AGOAabpl5YuhqBf7ctCRzSnwDSv7Clf8ZfU00gEypefsIr5JCeovR3cqHOw3oPF+aYUv1X6Eh5F0iIvtII0YDHTdluRh3AATYJJYzCxyNiNtGvSJtcBOuEVRmydk850jIcf1cLzbDdBA9Ne0qeiMQkT/LM5ybU92w07pA7qOmAMcJ/95A/Z94gEU5Y3wc/HA6g2C62hCIYw9azx82akxi9nspuHyv1TKROEBSOoKPNfcbrAh/F0/rRkfSwgKto/126o0HdTGlZFFsjC/SWj5z2ME5sbhnHeMDs2wtavum3GHRvXfYhUgqHLDQuYQ==;5:XfiIP4dYctWmDfbn6zHnGehctLq3A3f4fPl32zDO64KJO3TDJS5PCkflId8wfF5diQ+Hjzj4SioAdB/R7wf7U0RBnClgTQ+d0km6Osr4lIDoDY3WKPjkbRVbQb7Y+4dOskICF4BZ01eUld7seUYvSQ==;24:yIjCpmCxXlioOe685Ar3qSHRZtSQnWRnChLhkqmzjlInb03P5D2dfiY/lRJMReLE6EQjP5So0FIPNP9I7ZY5BVCmWZe/D1+QVJySVLpBcv4=;7:FO2BFP7YWypHXqQEteMk9jLJzdsZClenvQa9k4gPZIVE1wiPs+2V2ZiUzzzGBKgXsOnNap3M9AD/Q7MAmWYmkm0VsEQveNhJD39gh35K/Ap+G1/xf3u96C0zWauO7nXLnfQGqNyXPzFlL+4C+x40GkXWHyvFVb4AmFePAKGvxl8Dwh/H018+NTk8CzEqUK4Q6WQAV8YxIpJD7m8X4XKtObkE4xHulA1Xna362WbFxfk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:02.1832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Get rid of obsolete KEXEC and CRASH_DUMP code. This is to
prepare for adding in the new hotplug CPU code.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 168 ++--------------------------------------
 1 file changed, 7 insertions(+), 161 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2085138..46e2bb0 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -100,56 +100,6 @@ static void octeon_kexec_smp_down(void *ignored)
 }
 #endif
 
-#define OCTEON_DDR0_BASE    (0x0ULL)
-#define OCTEON_DDR0_SIZE    (0x010000000ULL)
-#define OCTEON_DDR1_BASE    (0x410000000ULL)
-#define OCTEON_DDR1_SIZE    (0x010000000ULL)
-#define OCTEON_DDR2_BASE    (0x020000000ULL)
-#define OCTEON_DDR2_SIZE    (0x3e0000000ULL)
-#define OCTEON_MAX_PHY_MEM_SIZE (16*1024*1024*1024ULL)
-
-static struct kimage *kimage_ptr;
-
-static void kexec_bootmem_init(uint64_t mem_size, uint32_t low_reserved_bytes)
-{
-	int64_t addr;
-	struct cvmx_bootmem_desc *bootmem_desc;
-
-	bootmem_desc = cvmx_bootmem_get_desc();
-
-	if (mem_size > OCTEON_MAX_PHY_MEM_SIZE) {
-		mem_size = OCTEON_MAX_PHY_MEM_SIZE;
-		pr_err("Error: requested memory too large,"
-		       "truncating to maximum size\n");
-	}
-
-	bootmem_desc->major_version = CVMX_BOOTMEM_DESC_MAJ_VER;
-	bootmem_desc->minor_version = CVMX_BOOTMEM_DESC_MIN_VER;
-
-	addr = (OCTEON_DDR0_BASE + reserve_low_mem + low_reserved_bytes);
-	bootmem_desc->head_addr = 0;
-
-	if (mem_size <= OCTEON_DDR0_SIZE) {
-		__cvmx_bootmem_phy_free(addr,
-				mem_size - reserve_low_mem -
-				low_reserved_bytes, 0);
-		return;
-	}
-
-	__cvmx_bootmem_phy_free(addr,
-			OCTEON_DDR0_SIZE - reserve_low_mem -
-			low_reserved_bytes, 0);
-
-	mem_size -= OCTEON_DDR0_SIZE;
-
-	if (mem_size > OCTEON_DDR1_SIZE) {
-		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, OCTEON_DDR1_SIZE, 0);
-		__cvmx_bootmem_phy_free(OCTEON_DDR2_BASE,
-				mem_size - OCTEON_DDR1_SIZE, 0);
-	} else
-		__cvmx_bootmem_phy_free(OCTEON_DDR1_BASE, mem_size, 0);
-}
-
 static int octeon_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -181,72 +131,23 @@ static int octeon_kexec_prepare(struct kimage *image)
 			break;
 		}
 	}
-
-	/*
-	 * Information about segments will be needed during pre-boot memory
-	 * initialization.
-	 */
-	kimage_ptr = image;
 	return 0;
 }
 
 static void octeon_generic_shutdown(void)
 {
-	int i;
 #ifdef CONFIG_SMP
 	int cpu;
-#endif
-	struct cvmx_bootmem_desc *bootmem_desc;
-	void *named_block_array_ptr;
 
-	bootmem_desc = cvmx_bootmem_get_desc();
-	named_block_array_ptr =
-		cvmx_phys_to_ptr(bootmem_desc->named_block_array_addr);
-
-#ifdef CONFIG_SMP
+	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
+	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
 	/* disable watchdogs */
 	for_each_online_cpu(cpu)
 		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
 #else
 	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
-#endif
-	if (kimage_ptr != kexec_crash_image) {
-		memset(named_block_array_ptr,
-			0x0,
-			CVMX_BOOTMEM_NUM_NAMED_BLOCKS *
-			sizeof(struct cvmx_bootmem_named_block_desc));
-		/*
-		 * Mark all memory (except low 0x100000 bytes) as free.
-		 * It is the same thing that bootloader does.
-		 */
-		kexec_bootmem_init(octeon_bootinfo->dram_size*1024ULL*1024ULL,
-				0x100000);
-		/*
-		 * Allocate all segments to avoid their corruption during boot.
-		 */
-		for (i = 0; i < kimage_ptr->nr_segments; i++)
-			cvmx_bootmem_alloc_address(
-				kimage_ptr->segment[i].memsz + 2*PAGE_SIZE,
-				kimage_ptr->segment[i].mem - PAGE_SIZE,
-				PAGE_SIZE);
-	} else {
-		/*
-		 * Do not mark all memory as free. Free only named sections
-		 * leaving the rest of memory unchanged.
-		 */
-		struct cvmx_bootmem_named_block_desc *ptr =
-			(struct cvmx_bootmem_named_block_desc *)
-			named_block_array_ptr;
-
-		for (i = 0; i < bootmem_desc->named_block_num_blocks; i++)
-			if (ptr[i].size)
-				cvmx_bootmem_free_named(ptr[i].name);
-	}
 	kexec_args[2] = 1UL; /* running on octeon_main_processor */
 	kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
-#ifdef CONFIG_SMP
-	secondary_kexec_args[2] = 0UL; /* running on secondary cpu */
-	secondary_kexec_args[3] = (unsigned long)octeon_boot_desc_ptr;
 #endif
 }
 
@@ -928,7 +829,6 @@ void __init prom_init(void)
 }
 
 /* Exclude a single page from the regions obtained in plat_mem_setup. */
-#ifndef CONFIG_CRASH_DUMP
 static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 {
 	if (addr > *mem && addr < *mem + *size) {
@@ -944,7 +844,6 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 		*size -= PAGE_SIZE;
 	}
 }
-#endif /* CONFIG_CRASH_DUMP */
 
 void __init fw_init_cmdline(void)
 {
@@ -975,11 +874,7 @@ void __init plat_mem_setup(void)
 	uint64_t mem_alloc_size;
 	uint64_t total;
 	uint64_t crashk_end;
-#ifndef CONFIG_CRASH_DUMP
 	int64_t memory;
-	uint64_t kernel_start;
-	uint64_t kernel_size;
-#endif
 
 	total = 0;
 	crashk_end = 0;
@@ -1020,9 +915,6 @@ void __init plat_mem_setup(void)
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 		if (memory >= 0) {
 			u64 size = mem_alloc_size;
-#ifdef CONFIG_KEXEC
-			uint64_t end;
-#endif
 
 			/*
 			 * exclude a page at the beginning and end of
@@ -1035,66 +927,20 @@ void __init plat_mem_setup(void)
 			memory_exclude_page(CVMX_PCIE_BAR1_PHYS_BASE +
 					    CVMX_PCIE_BAR1_PHYS_SIZE,
 					    &memory, &size);
-#ifdef CONFIG_KEXEC
-			end = memory + mem_alloc_size;
 
 			/*
-			 * This function automatically merges address regions
-			 * next to each other if they are received in
-			 * incrementing order
+			 * This function automatically merges address
+			 * regions next to each other if they are
+			 * received in incrementing order.
 			 */
-			if (memory < crashk_base && end >  crashk_end) {
-				/* region is fully in */
-				add_memory_region(memory,
-						  crashk_base - memory,
-						  BOOT_MEM_RAM);
-				total += crashk_base - memory;
-				add_memory_region(crashk_end,
-						  end - crashk_end,
-						  BOOT_MEM_RAM);
-				total += end - crashk_end;
-				continue;
-			}
-
-			if (memory >= crashk_base && end <= crashk_end)
-				/*
-				 * Entire memory region is within the new
-				 *  kernel's memory, ignore it.
-				 */
-				continue;
-
-			if (memory > crashk_base && memory < crashk_end &&
-			    end > crashk_end) {
-				/*
-				 * Overlap with the beginning of the region,
-				 * reserve the beginning.
-				  */
-				mem_alloc_size -= crashk_end - memory;
-				memory = crashk_end;
-			} else if (memory < crashk_base && end > crashk_base &&
-				   end < crashk_end)
-				/*
-				 * Overlap with the beginning of the region,
-				 * chop of end.
-				 */
-				mem_alloc_size -= end - crashk_base;
-#endif
-			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			if (size)
+				add_memory_region(memory, size, BOOT_MEM_RAM);
 			total += mem_alloc_size;
-			/* Recovering mem_alloc_size */
-			mem_alloc_size = 4 << 20;
 		} else {
 			break;
 		}
 	}
 	cvmx_bootmem_unlock();
-	/* Add the memory region for the kernel. */
-	kernel_start = (unsigned long) _text;
-	kernel_size = _end - _text;
-
-	/* Adjust for physical offset. */
-	kernel_start &= ~0xffffffff80000000ULL;
-	add_memory_region(kernel_start, kernel_size, BOOT_MEM_RAM);
 #endif /* CONFIG_CRASH_DUMP */
 
 #ifdef CONFIG_CAVIUM_RESERVE32
-- 
2.1.4
