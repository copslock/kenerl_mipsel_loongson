Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:42:59 +0100 (CET)
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:61227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992312AbeCNWmHxTZSJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fakpGIr22Hwuo1onX2MSJF3L5DSfmM/EgEDLpubhem0=;
 b=e1jMCAzqc7VcnYkSrp7haUOkGIlPrxQXhQ/M3kRn+U+wVTleL1sJpwbaPITns1U86wgJw62fgvQTW38X3Dsj1PZZ6xdQN6BfaU5vqToiZncitQ+r69BrBkR3J029QkCXFCTiRtiYZ26tcHswAi2IM8q34SsUSmq4cxKm1uOZWhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:41:59 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v5 4/7] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Wed, 14 Mar 2018 17:24:15 -0500
Message-Id: <1521066258-11376-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
References: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:4:ad::47) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ddb2942-62e7-43b6-d40f-08d589fccc73
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:/fAISPcI2rv13iHau9VOOx6bYRr01iPFo8fMrKQCFEYjhHPSvpL0nbNII249tWGTHWQF4v6Z0ZzQd1omseMEn/RfZA+9JOmw0Vqo/N152tfqf+B//8iyBgZNq8WoKIEc67Hi286XY6M7HxMig89b6AdCqWYPKtOUEsrSsJtX5PeP83oOAHkDsNtxyJ3CwZysd9YS3kdBnGaG/AZ0ANSFSPaSdOG6YB0HjqtCOd/rfoICDoywhPNUk7D5koO352+A;25:fY44jcKVxVlSfcE0k6ZRz9r8iYO5EtOFWGurF01EUSleADkNj6rQzkOdEGo9FitFfQwnype1n8w9q6kKZH2n83y4m3nzcfar5WuVzlkfvgnt3/Uo3b0DXLUXIzNThs88pAvcQvCT8HyuAviM/jLEASTdGmfQyuCIJUm8THgDhAaB3+Grf9f1kzC7+peJmqBqO1nB8JFBj+NUx+B3Gy0GfVnBAQm8vX8OzSpVqNgql+Zk6w3DB6vi3JGnPa714qGv6bkKAeExtNHaPVZVBO9R3LZmE3+5F6PDgLZC5krf4E5ESFdd7jUWpsUtCwLyeLafeFtSmf/DvSZH9aZP8fmkDw==;31:fdwyvCxLW+uRKqsVwCX1WGyjYPUfo7b5ofZckMLDjLHKSxGSRbTSjfzPoqQpSf5RMM2Da8EJYn8KPIzRTulEfWIZs+RgD7uXNh3K4qmIVhyJOYjtnN4Y1y7qJXOLX6LPwK/HD9ycT/P0rMrAtiCHr9LOLGNPNTHSiOBAPndvyovIKRmkHXAIHcDoR2I1c0sOCYploB5l4JHUSUvUEHEaowaF5TK7HFKSkIzTIat/eRA=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:dtpejQ6vMvScujM3c9IiY4YjaVIA2+hr+vGtPWa3zv/3yTvrUn4VZsjdR6BswJtSk8DNT8s1WMRexy9IzSOx8hI6xUaEKL8IccACAeHkw57sIGlHvG54NLX5VFhc1Maz0iVkjJP3DrF1MCtkOlUNgrJb7ktj/A1HXU2Fhj4hQvlO7gNAR1wFUMuymOdrzI5q+XxbAZa9CroWNQz7aeTZ0guemKZVnqfvlhTPacoH5GRoGLnNXf24zqf+b19KpsfTxltXKfE0jAGTvwupfntoJ+1NIADouFw0QkMICQYYthHjsIN/xmOCbMA68C6fkXlLnZwnrGp219KQyyv6LfE30TK3ovP+o2XuDMXukZff4KZMPhFBmlZ/BXILp0xAK7L4Lj/xK17yruYuiP/h7yZ5hs5qpX0k9ujq5mDaGy6HBt/sE1TVSHUr/Ka+C+8sfeqkOn6M4MWwtTgoEM2uNGog9Kof54Zzq8azQuQaTEp1p7ojYHx8OnPBCBNTEoTyaxha;4:28mzmi+vPGeLu2o3JMCc+TzdgTuliVmT3GC8Mp9ISZ0CbDquhS2OU2uDLJTtVOtQUdMBJZe+5JPJWDt+wyta40d/XuUKE5r8+fQCdifNC+Bd2bbvBB/EcAblqRGBPHQ9rBMNSwfjRY13i+ioRrVN+iYwtaXk6ofUNse2OKy2gt25JuGJikpdCMhUmGhNhqil8pynV/SoS6gffBBltHVXFMGiqbv+2/Fm4Cw42VDaxh8NHFzK22Wr1SbUr7UTcrwOkxBml50ZOGAwDV1oYdKpgA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610A0448F9C7B0DA3124DE480D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(59450400001)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(81156014)(386003)(76176011)(316002)(575784001)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(2950100002)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(107886003)(4326008)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:8mAbzFf5LKYPgbyQi6Qf6gozM1hQja6o5vRrllVTq?=
 =?us-ascii?Q?X6Pd4M3US3IXyCv0a/rzwogyIFCyBddtjQVh+MUYSSCGnxjlfwwaCZV+e1OM?=
 =?us-ascii?Q?cqJeDb4K5QfZfEfUgtklIIKppj8REkYhK7Lro7UMjoG7/eNNLxjZqGlcEJqw?=
 =?us-ascii?Q?W/1dIxW7nIVJ3AQiXfb60D80IIyAF4QLxFl1E4DzLUSYlYLwCVdIzBlS8bir?=
 =?us-ascii?Q?LWn6OGXgzHyhmu8NqB60SyAmcFMnK0enZ4mpgLK8n9R6VOA8f3lFsMppV+E9?=
 =?us-ascii?Q?XLi3qsQ9axT0+LPv7tkA5k0Ennm1pUIx5BNw+hEO9hpv6HP75fwgplCd/jxA?=
 =?us-ascii?Q?WwvNRF8N1N3oJMYws1jvH+kqtixpZQbh//L38WhyRnPCKxPbBx4dj4qy+0gv?=
 =?us-ascii?Q?ef3ukjsD8lw+NDbS5tSOt8fANZkB1H52QoCodrYhCLweqQANL4uN8zUu76lY?=
 =?us-ascii?Q?IjATUO29QcW5BXKwoTQ4i80bpOqndjwf5BSZXiJtXvIRz2EQVwO0DHok9CIk?=
 =?us-ascii?Q?Lg6hp6fU7L6GPVyAzV8ETgHQSG78OwzAfo4/ESfRNLq/wEFOhjeNH1KUeWlj?=
 =?us-ascii?Q?jdMtu6OQm1f45kxaWrcrr8NDCGBR0Qqky0cCSVFRz+sCq/Q+HQRKgiiFof+4?=
 =?us-ascii?Q?s2DDDdSZOlpCkDqBYLno4RjFlK9mTOmUrMGAAy5r/1WTfiLPQItkQSsSKW6c?=
 =?us-ascii?Q?dflJMbyTLY47HbzMzaBcQZXQjj1GN6AjuTxx8x8eHR+SY8+GKscFWgg7i8Ln?=
 =?us-ascii?Q?hkVOXeVvujr7mCa/P3ycX5R6U00dIjMFWH1G4R5iQ881QSdlsNKYMIik2mcH?=
 =?us-ascii?Q?HxWsNwMjLeZsbVtAGT29gqvCxqHEwSEE5bYxnXfTJfhPgABFTlfTIOXM2PW1?=
 =?us-ascii?Q?R8vKUw6GiRmCjeTssUSaY26L88b/ygNdkY3mMe3KFKF1omJa9GODEMhlbabA?=
 =?us-ascii?Q?+dn0DhP8oYyGgf1B079BXG16l6asSSuTNsqYH8w4Urg4lzBHoJo6G4+iPm/t?=
 =?us-ascii?Q?u/r3ySdFmcFTjSPqBoBYH7bzhM6Qsx52UKQuiTzc2fBVgxrgEvHlYb7fRNdg?=
 =?us-ascii?Q?Nzy64IfTUB8wzBgLgSF/F0ipVCXSd9b7Q1mnB1bDmgRpvNo8U32uHTkTA/Dj?=
 =?us-ascii?Q?nFYEf0oPVcErqUcMpU78bQKxUp61+ax3hErk4dIuJSveBEbLcQoeqY4qEzcB?=
 =?us-ascii?Q?1QoBc/tOjzAO5mzC3dNKp+1rrYO4GmjLgYJGhwy1Guo2nGNeU6XDIr28kX0I?=
 =?us-ascii?Q?mhPsHnWwGo/OV0934GzRZvjq2cL0Ji6Epm/YiF4?=
X-Microsoft-Antispam-Message-Info: c7yCkQ/4bI97obm/bgwF4u3m4updKcAS0/BIFXGOynAWgAuP8lXxTJWv+km8pqIoWvmkyMdfPD5jIzk3DBoN/kQNrVodem1rLKPiiHH3nSraLYYIsS7ufMx2AYHXBU9kx5chyE0NgWCyPvi46UH8bZa1FJ6LLgu1Za3nBvWN0C8PsDs7qD/vyjMeXOcAPqS1
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:/ijZajxvbcxx6dIlgwjvI6io+g2AYanMvXSxKk2TtsUsvBxkz9Hd+SLEQQIEELdSwop8+HDAGsrOwNyyE0cK6qAp2Xob56JRE0uVYHAHzilaYZL2FPV4qGQMmVXH2laVx9b/ZVmX4/EEcjW59MbYFCr0hePdiYYrUBbDIOVA7SJssAJHjUa2VVZFFx8B4p7dgNF5yafCRZ7yHIWKloyH8IEzBYilkyLaWycDkELUpMlZO+Bnh0MRqd7a8RhBYC/hU407nCdM3KWWHUK53Zn8xOzK0+J+M4M6kULa1FYkosUu9luNXpIscF3dm0KuRf1YW4MiyzFZr1G3ZjOYeYfVBkL7e9lMfv+3b5iplQ29Xjs=;5:e6yt3e6BYL7GrJr/qfwgRTHxnsxg342PzPUs1/LYYa0lvKqp/Bq1v7Mtz7iPzToq2h5JLXP1TnSOC6kKnb5EtOlcRuFPdi3SrWD+QEyhZKyKknBddEVUrux04Ytrc9F9NMvYdgRpn8YOs1/mJFlvDzMjAKictvZcz4dnxIc5xm8=;24:NBu1GEvE/X36CxVhN22fIxMoO/gRj+7VpJVPCvZwquKKKvhdUEAIu/wc9vMGitrFll+owfHzBQWGj65/KuJz1P2oRycYkWwv+tFvIMudN1I=;7:Eq1XypDoWgXLSHDKYiA7jBOjNiirVkU/gQ+UQPWs/A7wcSdS/zWZIlfMzAQa9dx+hgXGAw+6DR+xMdo90k2eOLxthci991GEjvw33k4zndZHHxiwe5VwAIRe6qr+kmTMAua66cAuCOaTF7V7K7rcDFzGT9Sd/MpgwYIvbb/bVfMg57dPGIB7qe5DuEIqytze9fos6CTMvbTaBxBJP0NJoVrGbY7/WGSXgV9jRY/Do/VxLQKPicAkpnSaCGNTTETD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:41:59.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb2942-62e7-43b6-d40f-08d589fccc73
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62982
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
