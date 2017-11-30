Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:17:29 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990592AbdK3GQMq6Kiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fakpGIr22Hwuo1onX2MSJF3L5DSfmM/EgEDLpubhem0=;
 b=cpj9g2CPIKzhL/XmhQNAdVMbvD1Oi/gKYPceXOcKo2eJv1gpmxtoq/TI+j/sNr6MgKTk8uAGRPHV+YsmF6VoWnNty9joJXEptK2hoHUTktSaFs59cn/12udgLzRuMPWVHBVBqAWBWMs3gexpzpkXX6cKj0Xm6f7f/4eHEmDd6D4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:04 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v4 4/7] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Thu, 30 Nov 2017 00:06:18 -0600
Message-Id: <1512021981-15560-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa5a0325-15c2-440b-8ab0-08d537b9d647
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:khCrHFrehDUp93oZPQcRQIurOAGou9m/5eR4QX3+uKNhK0EG+3+f/xnl5PuherNVvvP7aCC7w7D2DxBHOufklCPzYoWq1ALHrknkzCjV2as5Gr2bAAF6Hl9y2jpbf0os+KkaCZdZiUoZNO0AzpnhhfT9RvbfKPxPKz3Xj7kFcHtdm90pQJV1UAjabiXGLUPdeFKL0+epP9aZnzUgSEE5B8KFJQ2NlIwdQAjuVl5kihBfVujEtSTZ1cDxMgQMcTNe;25:vmp1eZ8M39yvhVwiLcy+dwbEmeB7rahFgXZZvsOExOvs9eBfs2qAHyQKtVKRWm8XQYHybckg0cmm+yEG8y6oHNFL0J7GTAaC2CHjYQ2M42xQ93rbSCaoR9t5Acone6C1u3YE0Z8mu8IFuCER9nJZQL9JXa7DBK4txDml3WcsHhPKoSyqA/3BYF3u3NTqdzT8dXqjshPMfP60cFDNqYthGLG0CllqMO55+URoRCfx8nMpu4XdkiwnPzybnKjG+fD/zHMs9oSMKOIOw0hYoLlnsi2f4lNhzFSxbdqs63W5pzpDRqNRwReN9G/KtHBQwuDOsPcdeqlIXL71Ep45jWGHTA==;31:oTkn/tWLY0sqmgRFxjbiiNMiiba0LNkXdxdW1wQQG2Rlm3qxQJN6HRU4K0ZdWYt/J7dldbdwud6C1FWlE/Zjrf8bZGXWh6bzwn8wwdPsWaLyJ0H3Yrdt3zku3LXkqHjE3cEbFpNRP3cdr2IAVX6Yxv4zyiGtCfUAOa/Vsxs61WvWS0DK+eMIzONSdqmo1sD9FYi8rW3CBC7a7VxPfCm/z3mINY7fdYGSNEX2qgiuxEc=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:yroFX13ug5yXw0+6mKaNZ+IqrqPB8kDFtgdbYJzNhDKq9eNB1qUqKoGR1cB2UzukOQK9zG0q9wNhLcCKjhe3lBwx4JruvgWwyTGUkt3yqFM7oIl0d9dlFdZi14qedpuE1qMhzV2iU0Bh9ntfBhjbvWgQyOYd8Y+hFKgNCLRxzZDbcZBMfChuCoDDSQCjtfCyTLGd/ybhb4/zhs/idEPhzUR0/D5TCHC/9cNVpwdgxooFpaJUkRimugaRF8nKAQ63DGRmYdoHxGYh8zTMv4FyLxpO91e0kvIoDNBwBHoDZG455HRK7oPpkuBX52Wnjdcm81O1C74+I85+z3L0JfR8Fax8CoecPgucFQgOv6rmLNgQ6I4reXXQfLX5kpSuwBXCD+X4GRl6076V1lrq/q12cYp4ie/chDafa9vfAEkyQop9n5O90/P+l5LEYHOTVNVgtTbaCWZ5euKM1usT9mvipTNvuZe55TyYB5Jw1ZGqkae4d2WIgxBRMuCts7d1ppRl;4:LjpRUmrWKWrbIW1ipp2/A1X5I6nTOJxkrAyBDoYvL0x8kArtSwa8OwuwSV5ZUfX5rnaD28vTOK2YZGTYd7BXMwoEaw2TFf+QmFjCs480iWBal9KKccdmDd0/nThT0wYAPwajuyCvTJDa557Rix40TU4pNksV2S5edexhyw1CbpqzXhitsKxpPVf4dgeKF6LMFb+8ulBVbrXxAnOyDR4cOLNqE0y9gpEVmdJM9TfMURjpfg0kgLtWRRafudtUeGg4vFFcb3H2aeP4MO7XhapUtw==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB380314C1384BECA312B4FD9380380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(575784001)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(450100002)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:SxfPAA5VnrcRQ5FwpfZBN5P4bSjTcB/CdLhJ9D/?=
 =?us-ascii?Q?qMbnTUcJHHOY1eS9luhujOKJEXFa2FwtOCf8fDL2z7konU+bPlB+2XyfqaH7?=
 =?us-ascii?Q?Nyhl05VLZ0VttQ86vmUpNtBoWaRjMfbR5Y97GZZ7zVuo6/KxwTPitVAmHbbz?=
 =?us-ascii?Q?khNztaBCEZQ06YSXxKnem1AOJt7suvIJXFgTscMDQ6OzqQjBHeN5g+Y9xVUx?=
 =?us-ascii?Q?nslBegmLU79+nWthnj+HcxFk2MFLRqDr/L0udsc42MFB3zhe1l/0Ej7KwedH?=
 =?us-ascii?Q?j2xRjqz/0vboQ5yFb9xfkdnjGzbpkbBpmUuzYWPJOr2gjF/nn0SMJMFcxpHJ?=
 =?us-ascii?Q?VOkkiHMJjXeM4+RSi8S50B9HvcSwWk3/PMK9A1VdvqBn+7RbnYnQYwDdw0XI?=
 =?us-ascii?Q?5pB+vZt0IwCt0FGB+y831YYTynttNe0TVlVyJMT4w9TbE1ywI4nEZC7ENyWz?=
 =?us-ascii?Q?IhKeYK+EgiJMgbPRMa45IYA2vYNETOoe0dYT+c4c5XgrzOkxRn1VJb8HZr8f?=
 =?us-ascii?Q?GSfgTKsU0SvgKy1Oot5/80jQKD3++l4sy4YfkL8KTCYZd8x07z2gu1cMcBRC?=
 =?us-ascii?Q?UiEP5ScxISfkdM95dSpyKoj0rOGfPDNpnDG839k0OCTnoNayGopKaLKX7pJS?=
 =?us-ascii?Q?umJ6LHjYY6j2nt/QXBOw81kkj0PVFYM9UxpRvqEKJjqBGjDji6ybkNTSyhk/?=
 =?us-ascii?Q?c3MChMKseao5SmkDufF9yvgdb8yPu1C0QypXxDzC8UdB2GpiJa5nCt7Gf8v9?=
 =?us-ascii?Q?XjbdMQdA0TiEtvOj5xrwQOaSxza2LBvnxY4EFSrNvD2ROxmpo7fZmEHxPcpu?=
 =?us-ascii?Q?MP+4vehAn0oLMPex9JOrFLjweGc3wukmD/l2KQ9HVQZNFuwKDaOVPhd6oZT+?=
 =?us-ascii?Q?VjWdG6fh0WuA9t4AA9E5xVpxtk7ImKC5uG4N75C8fDOCZYpPRMppRN/fxtdJ?=
 =?us-ascii?Q?Qbh0F5yFTzN/dvRfp9pJ6glF1CZJr7+/hsiOWCrOlEfrbpRKmSqlDj7wuc9J?=
 =?us-ascii?Q?/vvE7JCYeHZMzIm8yE+hFiLng4MFlOubMgHXtgLLUtHazZDWodMaKflPc9hj?=
 =?us-ascii?Q?tQJwXegsFY9qa7Dv8TFLHsOxhb79flI/pj6fiV1CROcdtcTLPSRrkywRMMse?=
 =?us-ascii?Q?ezK2wdp0RE8eJH7VQ1lYlpgOKdLg0LejLAdDKweHj8VfRe0zfAHcS70jGajt?=
 =?us-ascii?Q?lPDLH/JBrkEujzvpVEpi4T9ke59TDfGDr3xKJggTLBPzh5YML40rhVBa5Tx1?=
 =?us-ascii?Q?a5+29AO1cTQ6hzGqbcAg=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:h2WFbakTm5lQA8xPigpRDdLg4j79AYqFd8P8PIWO9mkGDM/Iwkuqw3DOG3urkkJQfzoQd2v5F+WcksPLx2+FLkja0ywKvBiTKeXzpjr/9cfSTalaSrGRRVtO6qDiIIlnat44KuES0mTXv2266OcCWaKEbMcUFMXGPFlxTqYTNLJdLzJ6bi3k0FhLFKqeB1KD8oLvGxIhi0g7eCerWJOZheisZIdRoaZkjs05EyODfuB8Msbkbs41cAarLFRYjOWqvjpdwfXqcT9hmcfjjxauPPCRUp0KNj3iE16GO41NdkeRD+rNCcplqz1GiGklAg3b3+iDrQ+/atc/1gVY6phk1Jq+Zyx1ltCyIZS7G/Hwwmg=;5:NTaTNRI5imYFiQG4CxsNns1GxymLjz/QG1S+Q9rl8lGNfsSHjRD9EPob2DBKebjlkHAcz6fvtUiubo8TycZnYoyjD+0hm4Zc3cX0STA9BGu7ipNC2zB3LRNhLzFIfCwB7dt2YOJwZ8YQtMnN1i7Dw6MkQpzerlp+4XQ5/W53Cew=;24:068yv+vomSjwUVnuT2KHsk5uK0ft9XFkUgqYdGh0s8ZpJZ4S0zw9FE7T/EToIzf6hH46CbGXuTVUMjwIbsrH39H6XCVbtkXVyhk3qZlOyCA=;7:MyXVa4VOpbpl46M1MRxXzw9OfSBhQBw7/ZSFcD5jIAKDX+0+XhKHdsBYDoJD/AKZpv0pzv7tJnNlnb2JZ86GsQZbtt2hDMmgSnh/vBlezFgB/NN87Mqj/CJX/MQ9bXeRMM/PspDwRWLgEUTyHVBkHBO+r9zqC34zzF/rDzsRmFuOD3dIqsJ7YCs2/ujXGqpR2QoehS+kfKb6N0WfFGoL3zV5BiiqtzRRgkHutUs6s2gqqgUJoTfP6EEanovkz3Fh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:04.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a0325-15c2-440b-8ab0-08d537b9d647
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61235
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
