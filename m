Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:42:18 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992334AbdKNEjGGlWP3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RL38Ub6ueRwznDM0kYcXPTqpgqN/BLoDeq40s6APEk4=;
 b=IzsP+wY/UuSIiVZrzP0gf27Nx0+jJEVtGR6GYRRZGDzIXHWz2Mai7RT+1t03Np3gfXkcmYnotkKnPUMnlro/20+NhShOuQIV0fFifNsBdaEWLuc+Wn5diRDg3siuvhj58ok471CSquYUrHiWEJIOg4iqbeG064cJ7GND6mNCakM=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:39:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Carlos Munoz <carlos.munoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 09/11] MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
Date:   Mon, 13 Nov 2017 22:30:25 -0600
Message-Id: <1510633827-23548-10-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fd53eb9-05fe-43a3-5343-08d52b19a0c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:B/K8rfXoFdu+emD24II+FG1/COmnzaeCh7vqx7+aU5AgTvH5LtH0Z7m2DyGsfDJVeAShc4lCG2wb00x1cMuYA+TeFPbCgkkRZb9czO7zF0vKIxx4fvBiycPgsjkN0EzYk9PgGETw/jjHerIHvL1Yl5Ffq4H8mril7ATsknX23LyVzIzlTPQjiOn3iGIH1JAO1biIRYkuq0aUbCdSC3JVSG1l7Z4vnZdr+J6w3N3LCpU74iDypdxBbvB67thQlSNE;25:KUY22cevBAiNUwQ0CkYjUycb9Ggf6WlnnGEsElkO09JNJuTIrq6MtkSmvhl4yEoheRai8//56vJou6fUrOOad+dzoouSvf+d59t55N7MA7t6SlQsADGWRybNQV7q9ovnrC93siL/g2zqffjasR5Zymb9J6tO3ln6w1M/cgMEslAJgP+jsK46GFhCbxrRY4XgP4JN8sK6Jtdo6E8vIgjKlbu2wlBX+ej56O2CYN1pedfVwERi1EccNj49R4aGKGPxYiGk0OBiRx7IdKUeSseK8CkhXxMeaw9+Rnf8ra/i6zmfNqqPbkYSN41aEXwshh56r4lwJGAfNKGeolmgkGMRhw==;31:fuKNLkqIlNdxtFtF3VBwndwRXUJvuROsz7k0GLgDxbGh5oX9dd+90Dy7bgaIokEHck9+3kAXHKb1aAxGjVBNpBt+8D9kudnc+c71JcS5EpFwkgCRDoCYuqbJByzI2pAZIvjIKmZ+GdWgxX5SkS9+NGSY5mYnXuWySuDibrVJVTyB4XFicVM8QVfP6axsU1I7dc5upCEs3iz60IzEub0h+gegzWg7lF45jNGaaTnmbNw=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:nf9z94r7ywr5yfIPKHRy4kvFWsrNCP001MOJSl4xxQBkh3Eo2ABmJWXnjxtqP9sRTZsdxauTU44ZPaSDuAR7YQuqdhYlv3U6Qb3xoPos12I20TaciFjpw9CIpT27G7IJnmpICnsLs8lJng5cap/bE9t1/3CEHd2RcaEvC05eNvsX1/dJiCJDExRPXtsG0FSnQ+62Go7wGonN/1OY0ybHwCLfTogaq2u5NFKJgCbrHtTqcRvM4URSomO12n4jtsKE8HebR66Ye7y5Qu22zeZdb0Hx2rk7HHTWKYzlwUHPRdzYgn4co/iEZ5t5e1y85yBToHDKxty0ruZEkOWV0CbTFWF7fVLO45YXYrV7hfd/37Umf6U67dLi95QBoErTdfHBUpp5eSJ0PpSKKW4VhJ5/tS9S4PTemlnv39GKJcnDt1v20juCW//Lt3G5popIs2BplMCuiINNgdoWoaBnoTe9VzzVoMzFSmhfFDScXZGLmqTA428NRD8ZSa35gZuKnP8k;4:TVvwRbNskxcQfU38+bEBObPR9H4jpYu8Ba0ff9XbFxrreqw4UriW03rvkgaxaTzmTYOgT2uPNbFpcHAadwgmg+g+Ut3Zc+bfdJe3XczQSJL4kaMwiyPZRKsGExKqNRq7CveRfh6ZKJdmkW6VXathxNWw6O2C2OVBck2jMs4T/eu4oBMLjR89Oxbfp5zkRsLXS5q3u6P1VoUwXYw9ZKkhVfqTNpy51Q/ADjYohhgWa6fmkXkwW9TNRxZ3xnZxnGOWHzb08kFBLCDDx812RR3X7Q==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806E1FDD97DF8ACF454EB2680280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(54906003)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(5003940100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:rTRoyyc4ItT6+tz2//VVLvDeQxYoK8VKmhd9r/H?=
 =?us-ascii?Q?5OXCnwHE8EEgoGZyLrqD4wcjtIgKoS+yTM3t3fZNZcdXqiV8MnhJ9tLCJcWc?=
 =?us-ascii?Q?f9Pkz3sZDC3LAywH/5qFhhU7VRIQfdAKDONL2CaztAkRuvPJ7DEUAFS/0Ba5?=
 =?us-ascii?Q?ITgJdY2v52kT4XeeoF6jACl8+ym7bJlubHFW83MtRU/t/tGXE7h/Gp7dmHE5?=
 =?us-ascii?Q?uM1XH+5ZqZxlo3PTqCTTJOyMAgymn/9wlbTVZv5VUhPZTfXm4dowjFqgyU+E?=
 =?us-ascii?Q?ydLDxePv3hhyS0STYG19FLjZwlVR7C3dZz6N4jn2cMCcxSOIiegV6LlDuEiw?=
 =?us-ascii?Q?nv+QddywGrYs6szCnangZqJFz0otu8oLv+k3R8tpJHV6DZt6Mi9/GNzyycCe?=
 =?us-ascii?Q?wbWCZ1D6D34uIMuUjXW5SddpsdhH8u4lViy8ejCBjVNsCiLrxSKUVThmBwff?=
 =?us-ascii?Q?8wbB6lMypdQYBWr8W8vWPZj0l0CGB+F6Br0KwFsrSJ+M+vwq9akMdkWSr0k3?=
 =?us-ascii?Q?EWUgHiQX12E4Kj3HoCnVkHprbfTK1mhUrGLasx2w/dj7M49QOLATu2fm+XBH?=
 =?us-ascii?Q?BrcfbhOpDQzj5XgjO5SlMLcKYDlzeIIoDR7L78QkyQwg16ZJ0OWIUDZLdcnI?=
 =?us-ascii?Q?8IBXoC36wo25aA01BV65tDOH+s2o7AbXyykdToTG9uUpWKzGSdUGvNuFVgbe?=
 =?us-ascii?Q?j3V/p8qfFWmfP/OxoweNPqRulEYqpRQ5MLWGJ2LBKK9oVSxp1uIHkXTGJGTQ?=
 =?us-ascii?Q?9KYT8AW2FBIommSvfqu4/c7pa2YodaQPQC0Ec9rOIIFeERkX2b0ZJadxrHFu?=
 =?us-ascii?Q?gLwLRAjbOgCg/YmoOhW6ieOOXlqPblCclKjXlYgpthEk36sGCzY/6sK2fVKt?=
 =?us-ascii?Q?yoaeNTfXiEQGPrtgjJ52ZXYkVBLUPGoif6+M3foz99DPU6BD7S67PSq27NOF?=
 =?us-ascii?Q?eoA+ziWtxVF3sVHYWi4agp5eEL3mFqsV+SHbmoT9Ifbf4JTsSM5j/NpdYluQ?=
 =?us-ascii?Q?bGkaNuNJw6aqYdl+QoGmkc8msCQBRk3+V5tQoSzJeHpBUQd4zshl4D8ldSy+?=
 =?us-ascii?Q?P5KX6u9tV6XLdHLtm8QtNPT67tNM2l0iqrYckvZQC5c1dXMIJ7U6hEZFrcLP?=
 =?us-ascii?Q?nupZ/xlPRRiGD59JeIaQp1oZiRyujse+8I4gorBbcCq1cCxAI3shff4f5VF3?=
 =?us-ascii?Q?BgoOG6SqxXmY6yWk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:japyKBt1ICnuyBg1rqRYbQSfZg8ZpiPA4uKR3GbJ7pvBlyym1J9M/ZPh2S4g+X4AHQPxfjQWqmpeC/VWiPfpX2AW9Go+Ma2NCS31pL4vx/hhU3iF1sdA1wH8t6vyZBcOSkGsoMvwN9wK2pCnJ6hfh6D+U5RNXLkV0X1l9pZgsw3J8ITT5f3MYHck/4dyK0JodF+FHFMcoGfk0CJszKLE3qXDCi2r18jTR8pg+CwJaZfYQsM0C08EzEsfk+NK0Wvu70s7ykACTce4VzHLwvX2V1LN/a8L9kTTFhW8NdUrqNECJ1VoQlePBX00LP+hqjKz+/j4+yohq2EWZFoSENlICCZwEReaJ7SGW80kxDvQEfw=;5:BGDTRotgF72pCniXN5zv/ojmwYAtCQGzKMNvqDdo79nxClu95AhmK6z5XMFHLTAMpCvqCaIV6ixbLQxKjnJto2FOAB3/qg9pHdO3xnYdhXRNLA7sz0j7lRmKlXkC53qxiztXxpwbg8CGpaDY0m1/3iVyDJ5qJrMvFRPfxjrZxuU=;24:D7JadkrFSw6zfV0EVVd1Jd/G5K9XoCR+xMeE54b+OrkKX1h5YArxrD9zE/U5/VBCRqsOYw2NV4WsusGUtzCVJKtkVG6bv7JG9UJydqqXMmk=;7:N6JWJHXSeoxqTQTahWLvP1a3sTqQQbYgtS4x4K6aEJvI30Y6ocECpPEJU/m3v3lLMiQYcdbAQU4OBLBR+3jB4yClOuRBFa3+Ae6UEIj7JsjJ3mCoH7tQYVjMyZgWNZhI/WcMoXP4DykTCtdR9r7XhFgnaRsKf+o5mwl+XyMkPOkleQcNdSFcrUldrXVy+WJvpeXclLJvZ6CwArLcnKKJHaSJHXsOt6QcjeFBhjlut6cbl9f7pxMv50iXI8o0yUpU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:39:00.5647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd53eb9-05fe-43a3-5343-08d52b19a0c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60900
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

From: David Daney <david.daney@cavium.com>

Command line syntax is:

  mem=block:block_name1,block_name2,...

A maximum of 4 blocks are currently supported

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <carlos.munoz@caviumnetworks.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 46e2bb0..2855d8d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -198,6 +198,9 @@ static int octeon_uart;
 
 extern asmlinkage void handle_int(void);
 
+/* Up to four blocks may be specified. */
+static char __initdata named_memory_blocks[4][CVMX_BOOTMEM_NAME_LEN];
+
 /**
  * Return non zero if we are currently running in the Octeon simulator
  *
@@ -774,7 +777,26 @@ void __init prom_init(void)
 	for (i = 0; i < argc; i++) {
 		const char *arg =
 			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
-		if ((strncmp(arg, "MEM=", 4) == 0) ||
+		if (strncmp(arg, "mem=block:", 10) == 0) {
+			const char *pos = arg + 10;
+			int j;
+
+			for (j = 0; pos[0] && j < ARRAY_SIZE(named_memory_blocks); j++) {
+				int len;
+				char *comma = strchr(pos, ',');
+				if (comma)
+					len = comma - pos;
+				else
+					len = max(strlen(pos), ARRAY_SIZE(named_memory_blocks[0]));
+				strncpy(named_memory_blocks[j], pos, len);
+				if (comma)
+					pos = comma + 1;
+				else
+					break;
+			}
+			for (j = 0; j < ARRAY_SIZE(named_memory_blocks); j++)
+				pr_err("Named Block[%d] = \"%s\"\n", j, named_memory_blocks[j]);
+		} else if ((strncmp(arg, "MEM=", 4) == 0) ||
 		    (strncmp(arg, "mem=", 4) == 0)) {
 			max_memory = memparse(arg + 4, &p);
 			if (max_memory == 0)
@@ -875,10 +897,35 @@ void __init plat_mem_setup(void)
 	uint64_t total;
 	uint64_t crashk_end;
 	int64_t memory;
+	const struct cvmx_bootmem_named_block_desc *named_block;
 
 	total = 0;
 	crashk_end = 0;
 
+	if (named_memory_blocks[0][0]) {
+		/* Memory from named blocks only */
+		int i;
+
+		for (i = 0;
+		     named_memory_blocks[i][0] && i < ARRAY_SIZE(named_memory_blocks);
+		     i++) {
+			named_block = cvmx_bootmem_find_named_block(named_memory_blocks[i]);
+			if (!named_block) {
+				pr_err("Error: Couldn't find cvmx_bootmem block \"%s\"",
+				       named_memory_blocks[i]);
+				return;
+			}
+			pr_info("Adding memory from \"%s\": %016lx @ %016lx\n",
+				named_memory_blocks[i],
+				(unsigned long)named_block->size,
+				(unsigned long)named_block->base_addr);
+			add_memory_region(named_block->base_addr, named_block->size,
+					  BOOT_MEM_RAM);
+			total += named_block->size;
+		}
+		goto mem_alloc_done;
+	}
+
 	/*
 	 * The Mips memory init uses the first memory location for
 	 * some memory vectors. When SPARSEMEM is in use, it doesn't
@@ -901,18 +948,23 @@ void __init plat_mem_setup(void)
 		crashk_end = crashk_base + crashk_size;
 	}
 #endif
-	/*
-	 * When allocating memory, we want incrementing addresses from
-	 * bootmem_alloc so the code in add_memory_region can merge
-	 * regions next to each other.
-	 */
 	cvmx_bootmem_lock();
 	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
 		&& (total < max_memory)) {
+#if defined(CONFIG_64BIT) || defined(CONFIG_64BIT_PHYS_ADDR)
 		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
 						__pa_symbol(&_end), -1,
 						0x100000,
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#elif defined(CONFIG_HIGHMEM)
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 1ull << 31,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#else
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 512 << 20,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#endif
 		if (memory >= 0) {
 			u64 size = mem_alloc_size;
 
@@ -942,7 +994,7 @@ void __init plat_mem_setup(void)
 	}
 	cvmx_bootmem_unlock();
 #endif /* CONFIG_CRASH_DUMP */
-
+mem_alloc_done:
 #ifdef CONFIG_CAVIUM_RESERVE32
 	/*
 	 * Now that we've allocated the kernel memory it is safe to
-- 
2.1.4
