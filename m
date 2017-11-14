Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:41:54 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992314AbdKNEjFqw3B3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fakpGIr22Hwuo1onX2MSJF3L5DSfmM/EgEDLpubhem0=;
 b=QsJFumGCEYM0RBgCtA3rOrda+NQ2EbCHq0Aj/PnE5l7FN8f6/jwPVgv/JQSqCmyQ527alok+tfNguT3zwweUDLgrVagyoMx5x2ekboO8yDi6uMj5HZghK2XO1g/rvQ3zq/Adqumt5q6lEcPSzu/1sDfrqaM1A+bKozpd+NroylQ=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:38:59 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v3 08/11] MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
Date:   Mon, 13 Nov 2017 22:30:24 -0600
Message-Id: <1510633827-23548-9-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17d54f1e-742e-45cd-e4e8-08d52b19a00f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:3LUA7G9xzHkDi/UEuwRGQqfKLlGbv9DiYZiFteeEI6sLtbmMdoAt8YpHsE/b5oXTEId7Hd2A6p73sC/K2BeUYIsZSgpHxfAUDQTK7WXNsnNiRD9LyCBsRjqZZSGYu8IWXRiNqjjRdCe4Qa4a1JWh/zRW7ishYfQF7jQiT9eRZDJeKdFBYS6SX3W8sbQbK2UraOCPoGhr4+V2109QX0WP7Y/NPrfyQk3Y0JxPHSTvlDWI6K6V2akQoxBBJkJFA6i1;25:DZ3wV4yjZtcAdq2kEK5rDJ7qQFHqeCCmGQur3q3toFXbqK+K77d2uJoSCHT+ATlhDR7P4NW7jZ+cp+a5ZxrvMe2AKaC9aO8691gQI+0CbB9bvmlV4gHfxR6ODEauFyStdczU77w2HKRdUkPFvuAgoR1S+pRFCY/wZyVIAXrjCzTd8cAics8fQDQF8cJPF4x4QKQpz8Dy/TVqf9Q3/HfHmCG3bAYWfnisqFX3Cb5K/CoaP8fjudyjn2dvYCdXwKsvb0ckMQTkzWQrKbqdsVkVuBZa6HVecKuC1+CRnKViCwXjZNLDSGaK0wHh098/nxNjcIUwmL3n6b5QlK2Lk0kWUQ==;31:xIN1VSg5rYly58TNxYMAnUiDb93yrsKthN2+Mp97IxmyC0Xx4fUr0wrDxoeVJ0PZAFH828kOmK20C5o9ia0jaQDihPN3dXnB3qniEACVJm/IhN3O06zUgQ4yeMClAQlfCrXs7G1xcLRgy241SqYDx4z1u1Lv0vkJAMwWr8/8njQeEUuI6+l6qRdSQTHUmXVO2MqNfh2EeM9h0g4OFGmMPeJRenw/2YsJXqOwd5+z+WY=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:0jbTMQfIijsobYsM5daZZBx5TIxyQBbb4CDS41lKewnW2OQKkaIRx3U2Mkvc7rop7RUgZfLEnMl8oi9UFKHWVy1oUnz0Emfd+I8d3tFlNvn2XctTxlzhAkOIilsTdw+Loe+WF0Iy5qlM37BjCc2XGnaxDk+8CbRb9wRhvZ1qAtcHI6xG91kHsafhjch/h3vjDGr8IlP4B49gVoulIVRmR0nJ0tqyyjPy8da93zYHIScUoeYtmyQrO6ZMOIE5L33auyOaHVZuOMarF7FEYM9iJT7RFmpyGjmM9W4nU5YVYiQyME3Yp9izE1SxN31qgl9ZsCyIcbe+EZAAdcFYfEw8FNCZ/VEKcDx//8JhmmabLr4GMN5d19SmkhC6EyGL5JdNf4tpT3QNf5Iwpo79gAQIvjSzgTc826INwNFpeYRwt7twOIjDjNKnEignTb+y2yfqGehKArI9hLRgcKbdE5NfaAr9Cwd+5rWvt+42S9uS/F3o3sxMKrt7MR6vckhfeB9p;4:He45Bm781H3S4n7Qj1DGB8bZJ9SonQ07MAgu/AwoFMCdMn2MkCygB7MIMQe+89H9c4/Vsr8CAZvhxHHRFwZeIlWv4Yp+RgMDy9PTXmHYEE9rlKYvl2rU23i6FkAUQtQDzG9p3bhg4wmcNJs0suqAdUvav5dOLQLSR1fT/bu6ELPvD6TGHLITT7NGzFUtxBXyMYlhkn+lIbC0s/nmHw54TIpNRkdzBMV0yJHJ8o1ra3+tBSsi7nnzt1nwwwUNvGSI5OCUdAUkNjAzMUKI1FVBug==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806EA850376DA747D7FCE4B80280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(575784001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:l0ie0ig4diT4HgD1K0fyvw7szaY5mPJ4vDHXeNR?=
 =?us-ascii?Q?iAA+LqIMc1qejUtAA89BsiKoMIr93TX+gRXIwAx0ZwQ7Dhy2A9oy8TH+swLt?=
 =?us-ascii?Q?MJVuZikMCH51zHxdmZ4k4v1rMwCQ9me8Nq47/ay6mu7U26tdtYWBxIC/pZy6?=
 =?us-ascii?Q?jwnAstrWUBFvPFfrNIrClIeNCWwTX4AvE2iA+6PumUDeV2WbIvtLvGSL0LKN?=
 =?us-ascii?Q?EZz5KDJQder4uoJuo8mPkHRZcwDSnJGegSxs30xeUhb98LiilcfDtOsjiVYB?=
 =?us-ascii?Q?ecTAxn4IT/c9ZDCwD7iIDi0qas2op1uJhX/f6g7agf5dMf/pB5Xfp67JWMrK?=
 =?us-ascii?Q?jBbzsGfTh7/jMK3yC6bnGRF7hyMv7pcGoiqX8cfgypdPxkiMVuQRQdBICqcc?=
 =?us-ascii?Q?IlIcv3dNyP8XvQOVpPlyxTlyatVwfp0bcLhvQTSnAajD01Ipc8lpGPL0NFOJ?=
 =?us-ascii?Q?aVfTXgTY1wVLn/Ms8Hy985YOE4YhVDAbQsRgb7+k4lMmM8UzNSCnGDt++06p?=
 =?us-ascii?Q?TnzBJEKF+xv1fzakV7vwnBK2HieI4/2J2LelAw5gaMM+4LeAMbM9vGnHl4kT?=
 =?us-ascii?Q?A5LY1ckqpkboT/LwOkhyWlEd8FzBP34zS14TveMRhBMg0QIZAEO9/Iuks2fp?=
 =?us-ascii?Q?YDV5TG3QX9JKrtQ0vqzZNXOi/LzdIa2ZRQlYPzPF/dAsTKLETlu3yDqzkMQx?=
 =?us-ascii?Q?cZc4SWeCU5XQXD7LpWc90v1/FLKMUYqvvuyu2/B3kR5vSv7X1WZO54hFbbfl?=
 =?us-ascii?Q?KWLAi3Dsvtaf4Z8AKr7sTYJt+hcf1NS/1DK+yWILyuqAyXplsg7MvSEMitcG?=
 =?us-ascii?Q?jbwOn42I7Mzp8J1gSiTlh7/8w9jj2hpJVxAg8SIn1qXE/64QPE2/eznXhIRk?=
 =?us-ascii?Q?EOG57klr1vcIZdH7TOZszK55JzTxXp6tqWa8caWTIKSY9nvn72wX6wGT2QV1?=
 =?us-ascii?Q?cNCwbUqmamzECJ2Ne5/tjgtA0qPJVWc6eMeS2WnoDaK+3a7bSHtSH7EUf6ne?=
 =?us-ascii?Q?T3gJpWYmJy5c7O9HW92n401cwlgJS9OpeF+6rS2It8oZFVh0qdYkD/lKWqLQ?=
 =?us-ascii?Q?4giJ/khKn5jL4zDlinYdcrov4biZP1Z857diVb7Xtdpht7YMrwNAJ0IuQaKB?=
 =?us-ascii?Q?bsQ5KAzd4P1PYMbbebjWgMiEe0ngXe8SANhVZRqEpfHgtgZa3og9ahkC4/Wc?=
 =?us-ascii?Q?6AU0SXkIL+fKLBpAEmmGvXmSjJxoODI9KXB6W?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:/CK7P+wjaVzXOpXbWbGYV91aQRJWpEg0LwO4J0KDubRRCczCIDOI5JCuB9dOiUkV21zHLjQsiktxtzBYoXgQicI5aCNM3lPrwLqe4SsU2Z7kzfR1iIC0hrPiL+1m6Et/wlYNAr36I4K7T/IkddtFX8PURvMYje5WSwaprOY9WPNKIY4RJrjreZfa8TI5OnXrKeoG6e92H1Vrjfv6pmJEimb7AFVQ9G1HVKDyDwq99ws0wrSrs87B7MdUm+Htni7d5nU4/UElf2BCda8tEwWfcP7HPo2rdRRsduUhSU6uVa341zwbif0MS6Kpdp9YvyUfqm09wwbdN/leFrbyZpGP1TT0k4bmVqoPmYOKhR6+X4I=;5:IpGUq6ne46XbCu5O5yDo0Fyzl0N3lvZoisshZI5j4CrX6C7qAIBEmx6GuJXUC5wYwHqqkHZpOMMiRnAvRL2fhPGp9jx1LN5JSNvylRuPBU9zYPZj0f/G7B50NgbfNAnUFhvnEhAMjYKGwCZkWe8Ol68LoB5SMAYITPGd7PBsygA=;24:G0sKFMN0mld+ECFochRt0LDJ4HF4ykT+vlP2zZBf3t4/B8ZdWmjpbJmfnk+C+4XEGu186VKl1Am8GxeH0lNXG7uoOf6v3BmYMafGGGy6tZg=;7:9zO+na1MA4mqbnt1fc8smkTVUYF2Jl97+UOST+OHbT29S0pviS5uoGXhO9Vb0ul59fcppmX6Gx200YIX5DKULotZ2NX7OUzWagQeLjF73aEVeEHvGlYr4FfsvpAQhETd3UPwNhItKiuISgbo1CHKwjJjBb0XfK8O7QgHCo4VxUZRaXM69B65+ltHy6i29Dwt0I2NfKsOdQnlYhcCdoPCW4HxJF4c5JJdEYPapq9COyAVAM885H5fmDuUKBNjVP9q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:38:59.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d54f1e-742e-45cd-e4e8-08d52b19a00f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60899
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
