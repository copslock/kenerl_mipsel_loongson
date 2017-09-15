Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:36:43 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992568AbdIOReESKzIM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fakpGIr22Hwuo1onX2MSJF3L5DSfmM/EgEDLpubhem0=;
 b=mLZgMeMf5nVhzVPSaHx09FlAqCNZEIIvi4kAmmsxGsaUQNyXuUnC0bAADBQkoxI5LjxxLPQscrKyJ6GepYYnXdEwJaJwUD5GFws7fTgAKPnAhJLj/qun+f/GV620GqeMsM+0WPXjIMwDG/CIWClOzQdeDyynPVSClpLZgMgbP0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:55 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 07/11] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Fri, 15 Sep 2017 12:30:09 -0500
Message-Id: <1505496613-27879-8-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc72411-8bf2-482f-29fa-08d4fc5ff110
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:reaCNxTjL/FusN40a1TiT6o1WqTHIETnVTqDakavORpnX3KjXYRo8cdhnQ/XCk31J7iKD9AIXVQAQqDXKltdjPASlQDGTHQudgzF3+/SxHhuiV9FhMmc0axuNIrmtTVThiaWiUPXSVZsh9JnLiRT1wGBwGM9U7fXAZD/8/D9G0I20hZ3vn2KCP2t+LnFsRrQ9eduxt5Rw5QcQ2oHgbR6RDxlrDxvdJtZ6WuMRUy0ybOd6+mBuY+SZx2D9vzZvuo9;25:zPvMqFNqhQbceUcM4lT3rRRa/l0R6fYrFL0ccxlcg4izIoKTv9uac8o2WY1naImsL4tQ7XVKdebXlsrA1RKFoHzCitvoRaiyvR0W3uXiZkepNldvkwydn2zfifKUJVQf2wYenq89yjfRd/OYj7GQfbASfCoXfeZR/NsMjTiIcp1J7IQELWw5cd2wrI0uvZwTLwBzzJ3/ViZcNqiyNcTm+mSIq8oD+4ImCs/jJSd27hMR+Ndl9P1oYWLp4KLrG12kjnY/FF6V+Nnptpi2kXov4i14WY749cZnNcjpzYqkDCgFbGNfmb3WiiZqwmRQSrRbhrVCltR9l+Drpx79lGgDbw==;31:nw/fSbjbU7nyU/OlRbNdV1LTnDI7tih4dP63lDTmwIiIhBNkALxiTbLUWPx4Z3hT8p+C1TzbnPzJ2R2LV0DMRnklV97cJWT5fLXYXKFrjPFTzs5MymWc2t1sDOLR9Og6QqylgTz/H/j0AlEyXJNmrCenZXMHPY6ppDH3IX/nPe5l1ADEEH+b/CbyAb+Lgu2DAO9+CZX9syiysacpbJ4C2Mr31oxFAQNy3R/bpYM077A=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:dtURoaX+IPxiz76wRptA6ZQL5pXjNVsKQHXADj6eDJHlfS7xivHeBREG0hlwkr6zYMgb0qgBsohEJzKSOHh1Z0iSvDdtcARpLcXeVXIpar9dpWXYy2S+8HW3liaIp9MQdWUdxG4alCmJep4JVVkV6T9rXiWhTn/60Eh1Talp0OM1hgJLSISi1vKIMhjrM4w/zL0yvRbB6cMh6RneFLbA8qTpilwy/xiodr5GsiS/TcS4J6DnxBIZuEx4GRENdXNLmn3qInQ3+tpsfx/0LqGDpkEqDfk2dQ6NKBKB8zSZc5Jgs2tX3CP9wBgs0YIhqfTNhT8hPzju5q/LbAgtFxqcjW+SMu7kSMyCTt5L9aY2xb0pje90RYsyXS8kJYlXViogojvnaw+UMHbZqZkPCIxcCstp1e50YFfxvSQ6lAOphcwUjFr+9T9/qzB8w1ekJuiqt+NndqJiruoIEi6J+7XiqUG8I8zfwmheCUNoMeMAMPz3nt6TDpnaYIJYa19aAM7p;4:yGrVrNzAA2RxD3UefFHkXya78WXlS23Zs9YdwrbNk0/AgmW5FkPg6JXj3F1sXKL/fE/s+sw8LbivUjN+JmW6PZS31xKxJQLRDrohLFVVZz9Fqnmcy0sZyvGQ75vm/qFPc+D48dW4a4rC9iKrFgJI6xwhzZ8FLEEKCVZaCMaarR1t0dsKKcIT2X7VAcLSDS6eL1+PIZMO7tJPTWMzq+yCrsvRjwZEHyTcRhDTid5Vd4uBwVmHw7hg8lSi2cPXuaOg
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB38004F2B2FB1AD155EB0D887806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(575784001)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:4ggfflGTaEc/PCR4ST4+BucLzsCEpfgxuGe/IfP?=
 =?us-ascii?Q?IfYYIAy+MAj8zB4eY8PpTe41SAJ3LpGov1FCm33y4ghaE7DNayCF77SQ57ae?=
 =?us-ascii?Q?YtUrRMke1u+1NC1h3bWx88TkDNSZRXsUO0UetmP4OMm/RzWj3PBr7VEmnUxi?=
 =?us-ascii?Q?ut1grRDycznk1+xyAy7Tg0LPeesnAsu+sm2tX9r3oqVfDeKk3yZTl9ZC0kMc?=
 =?us-ascii?Q?TMP2BKh58idAQ1rzntdtLuBPcDNX2JnkM/cot6WQQKyX5Kf2abT36JOXecSN?=
 =?us-ascii?Q?2EyARCBCMi2Pu7RwFYuhWvD5mas+loFo5THXGQ5Ms6CfIkMhbq7c3uifVZtw?=
 =?us-ascii?Q?/MKvZ70F/uawk0tF+ZDfhS92GF7Paq/VKHlTD63Vqc/dYY7SqCgivNjwcAUv?=
 =?us-ascii?Q?PsAuCvv9gSomUMu9PagGSup0FUC1lyJIXp7Z3ZXWiti0rFAUR/RAkkkf71gh?=
 =?us-ascii?Q?Cid8nYM8LEG3GZ6B6CRKTYL8IjznHqcVvDwohDFHf/WdUC2XjiJglCFbaari?=
 =?us-ascii?Q?wWXIg7jjzyckh4kyCKjp8DbBMmHSy8ecGsY7jgC7WITN0WuIe/lEa9Ms/hv6?=
 =?us-ascii?Q?mxhN6KJBoyhteLKOq7T95bKcjLE1IlQlmz6vQRgFgh3M0g8u87vJlOQFUAlI?=
 =?us-ascii?Q?dMWcd5u1/lth5bbgyBWcvm/NUClRaDQwV0BazFB1054tRR94IaxTqd/SThvu?=
 =?us-ascii?Q?prsrdI6FoZCgGm7R8eUwN90Se1BK2dsi3k+lHiqdo9h9Ddwubs7JvTzgkEtY?=
 =?us-ascii?Q?KsTaoHvHFE2r8l26+raXZPDTXg4PfRvDFIo1y1h7tUH9OoR46xHgAReYyik4?=
 =?us-ascii?Q?ks+VABPIcyvD7SuHpU/TEl9v//b/v4Tf30BBHfFi+YpTfioK8pGwJEV5njZS?=
 =?us-ascii?Q?n17JqAbifgAFcS0GxZdjOzYcicKKbiUmDlZco7D86iwFXl0nr4LuGJSa7wB1?=
 =?us-ascii?Q?ft94CxCj451VZCfqivRkK4/JR00vaKeBIzPq38A0K555z6v37Rtrb38w8KLE?=
 =?us-ascii?Q?Y9YPHhpHtRIjkisPZGrvztW6t6hIRFwO5fAGuOKJygVX5h1OrcCOjz0zOOlX?=
 =?us-ascii?Q?IGk5Lfa1bsCMbVtJqTRxSaKiQrdQeFt13CaIuyKXbGJACMRS6Otg7vDk7w5i?=
 =?us-ascii?Q?KVy7U17lG+Sjg1GCZCT2dj+V7Hw5ZZrwsSi/ckFD5obr+92Ns4xwBGWbYGq8?=
 =?us-ascii?Q?N74K0LzScMLmLcDc7ev/VqhWNYzr00/VMdHMMGdckfBV23mPC/nRi5aXfnw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:D6TKdCjf7Co0HQ2Tnz3E1vGWrVAxl4PsZ4w/5oV4KKj7AbqWAijEBpCGj80FLL3yPq8sPwpGMhxfgW66k5VTF6UbBbHM3b2X+4BVnsM2CzH0ZsMLYh09c7IggNWGGp7akvXr6ELflxSnv8bIyDbfIbvzWvF9weGbwDXgxKcbx7DRIipckaKquzPoQpP+ScKgRo7mRC46VYEJWmsh3LAVkUwXu2RvPH+VoQR1cuenWVnOJTImaxgodatvDzCXYPPWkuWiCIezppzGtPKXoyJmDLqdNEYc+mQzTayXF3+ztKV9VXi+5yOeP8g9XnIay9Zd1SdlRm/xPMIsLtvjXcWDPA==;5:aw/1qZLb8EeaAx/RbEPC8PzVmm96E3cbizLnElG2ZKAImZt2Qf16dWyEvy+P0qbn8lLI8MsgYBBRpNRYtaUYIIFur1sda3Z2nxhk1rsAmgEhWMeK/z5MAV91uZuswrG3YcPFid9YzqguA+N0HMXhLw==;24:nxXOWF0oIKp7+4JQi3tMN7vOaBFkXUFIv10V4vzYF42T3VH6y2V8OW8SQ12KpeR9IJudvuZNv4zxzddAsoQtbcGRFr7kwRhekgLATCo6/J0=;7:qbRAoB/wDRR4rP9xeuryntidYBQJ2oADic2b2poxe8BDkUte2A80ni0bvMajZ8EqtGtG4d/jNiEIvzYM+e4Fq6A3m7hW8+RyDm2IyLcwRS4RTVpvEBC9To0hy6h2yhkJqxKdfMveOOvNVqnjYaI1qFqpbl9JAhaZMxza341Xo5O3wAJpHl8WzNxgXNp2ZMP2QDlALUmPDgRKdIw1LttWu+eNf8PgVnDD5Q1tCPGKrHc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:55.9106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60019
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
