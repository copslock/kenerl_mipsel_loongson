Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:18:18 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990595AbdK3GQNjg9Ty (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D9j63pgJveBIywln0R9zk7RBfi/Vq0ykdtC/CvlsmxA=;
 b=G1FYmQzGORjFhpMKp4vc1toH8ku5B+yAvfgGrbwCHNLMNSDE2CoPD4huGZem4qwPG47C+ponWzcHsbLB4PyOptMe5zaSZuO8rj3Vh+m2jm03MUMUK4tQPZLNbtsfciibxLJOl0cpRUnmBQJ0Thsj//lWe48FKAfaVMbpxdkXJ28=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:05 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v4 6/7] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Thu, 30 Nov 2017 00:06:20 -0600
Message-Id: <1512021981-15560-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b069b993-9946-47df-a733-08d537b9d746
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:lGs0AKd0j206bzT2R+Ngiw6nkcpCSmtsfyDpHRTgQaKEdP7XQ+Od/AiCyc2Tof2FyPaugIpu8kj3RDp7mqBEK+xyqYX0nTbxOExDHiXNaS8AEUPMHtM2FeBG+AxS9s3O5VGD61lebc3CeIlyvs+lbhMn7ZumZu9ljkiPFPKA/EP1hjchVnw3pojJCYYf3jAN2xekAVY9vnbDytwQiW1wBxk/ncPiF6aPkz4YTetrkW16aCRAkwY3WbbVSXtieYXk;25:ZzsxapDshz4yu8ROPw6mikmxM67akdc+MFQLi0eeyftFtJ83M+gAtnfP7RL/g7B+oq/OTGBfv2gTzSMD4LpiuEiO+pEUNBrykbeXNZ7Lfjgq5UgzMArCDaADgtZbfJ/ScloNz7yJ9bq5yaaEg2pNpLXysyJymX6vjYmCjbePD+51dPT+frbgXl3Z9nsmIDUICYYTSUDmgEAjqh5/lce9frLOjp3JlQde0fNDlLgNCOm14YiXmjoWRdXK6pPXyzXynMypkn0MeQWnNvpaC6IAUXE9GH6bhSNke8WrAwq1KjMnbP2peecdpfLYxiQHQh7wCLMndCFkp9OAk61ESaFAEw==;31:ll7nGE7FFKyyU461lEH0BCI8x/dG86KJjrSYzkO1RNQPzJ5v3gMO+XiFfXLHpggtdf4xdQ/ghvbnh193NfIDqtYrdWV/l+GBviVDRUnnAFlSKIJ+RFvVH8JRS+LzKwo8x/b/pHESsV9vTLoKVNy5Ei0gU5qDTrgY2UFPFbXLT9j9Coy9dtsECe5BT038BCbdDADnwWa5mcPjdkNA/Vyr3jFBbXSHs5NtFqwx5wDA7Z4=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:8Dt59sIb5V9PqUHKtfcirTnQUlMfHHocSKY8AHdVKHrghJH706fQaYjg6soEqp1ufH2ayQDY1veCcIwlYlcfuXv9S/P5Eo/jWq6nErLGmE0upoVd4RKsDKZq5349JS8UtIETtrwEQIMZt9Y0WH1+hIT+ewq0HBareLy12wHBRfANi67HjGrDAasL4kLlmLlbdZzAGuxVCvtRCpzplHjL24EEEVMMIUKXUpMphnJtZdFq31D2UcHEHiqUyMqSK7nDWvZl4JgqRzbpCyFs/nVF6KWM1aBfurbuN3K+OKZ7isJVXUQ8orueu/tVhywagPZisEWV87hQ7pzBo0F12I9fcdO3NvaIpLWo1ZXoMqvSoFCTXJMYrV+uht3oFT73uxo9otbyRU4+Ccnk7uxrjktuBastsP8VlGUDYcynHMKUEsDmxUSEikExRDm3HDUsIwAwSuVF+m1KfhpLLaX1LfDWQfQYh6h1GjHNHtAmx9UTqOJAiH9j/EK6orIFfTzlDjMc;4:ESMSv+jLP8biriTf4hOJEg6UQiD4PLTc2nXCpfCjCkZpqMJ6xN1Q9Qet0uiWS26wXU9cyCky8FaU1yw+/sd3cH6sXv35PEjSP1h4NINqRh8rg35jhdLb3SPJ1W7O12jFI4wfwBKTkmdFP4/5+Gg2m1KyviiSxNoBRAEsji+iXCjCK/liXXpyd7jAZz3hSnJWRVavkjRjGlDQxWQ79A0rItDCBg0f/9S34DkM5qgRnoiTJZbWlEhPynLsEDauJg/zuPXMOPZfREyJEx5asm7YXA==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB380371AEEBC929FF8008CEF880380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(107886003)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(54906003)(450100002)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:UkIiDOC+Pm4gxgUsunjwqEcVvOCZ6/h1rkuUr57?=
 =?us-ascii?Q?MDTd3sSyTXg8RoNZbpvfDaEqYy52fvGMZ8Qe2FwuQYw4aI5vvuwFwzzn7p/H?=
 =?us-ascii?Q?JHCV5Y8ZT3o3goG//0rIAskcFOkiqe5CwGeJEwm2WRQynplEwwjCNPP0rY3Y?=
 =?us-ascii?Q?pxYXaLLVBDX/5ErBlAJnigadEdZV3WfFK5iDhp+12JbHsvFuCb5H5hrwfaro?=
 =?us-ascii?Q?Kflval/Zhp7HzqNriFHDIl731eEQhHAN4znDKCNhfGQVH2+MjDRlncsha2CY?=
 =?us-ascii?Q?Zoe9lcvc/17U8Xl2FFheEm8p/iZQbpjUV1N+odSstx+JnRN2EWs22MikrbXr?=
 =?us-ascii?Q?gb+qvmNWy4Hs52NobEVXqiT3LIG3F4PyPsey8z7P5Z0o1LCJNHQfIy7Tps4N?=
 =?us-ascii?Q?eirjGP/kZOhP7dIR7ypBTjXkENC/Qp7nsy8wIupnzgYTHIILhvHMwNPwmcD0?=
 =?us-ascii?Q?WoTIdQpJevCbXx/P8duaoso7Xq6CC+AKGPt5qa+CvHF3erWZhTyzXsPc41qe?=
 =?us-ascii?Q?EOEawwB8DDidrMfbkIkOFI5+u+BmHH4Zr5PgTXjA35hGL/+LN37UQBVZmviQ?=
 =?us-ascii?Q?xas7iMrRHq/WWhNpz7q8VcJJrjL4uyul3oiPpBviAekeuDVETYayJgoMYqXp?=
 =?us-ascii?Q?JdhYgfIIPY5ybUDF5nMVOCX2TgRq1no/MbMSojJSQOvNUhKpBR3EjbtKBtI6?=
 =?us-ascii?Q?/FhfsnXSFbwmA24nm0G5i2+EAxOZMZOrXXPBTye9EpTP/NPcfcmc9J33B/on?=
 =?us-ascii?Q?M0S4fslPZCFk9BtJLb/PILS/j/8xlFTChmwgkRS26RfE64Bj7oBRqk7fWHIt?=
 =?us-ascii?Q?nyks2Nd4jsVcxvO3tW6amP/v2iiLThxD6FcflbHuMvHL7TFxDl1NNPKZ55mg?=
 =?us-ascii?Q?CpgB8/JfNv2z5VRW1M010INnuDUdUAzIMAVSXBYrrEgTyRk9jLGibX69lV3B?=
 =?us-ascii?Q?lqNPTw0N6xvHcB13+UnIj8JeVSRGS4s2uEf2V8ILJBxHeZsF6i4WPm4Yxi1G?=
 =?us-ascii?Q?rFKWyMfTd0o9oyUPEE+/jF/NfJr0s9Q0LCjb4EEKhcUJ20UnGVlgNgDESTyR?=
 =?us-ascii?Q?paPGFnz+CpTNT+F4Wq9X4cDwSi2WzvnusfElNYpfnDU6hdfUihKG9M0T/YfM?=
 =?us-ascii?Q?is1zBUH7Rl4BTnN7+i+eJaucSNMioWi4cK4wAursp7axSqxEKvbkofWerlAF?=
 =?us-ascii?Q?OSHZLOX7Xqir9GMrRZCfP438tz0MP35L91jhvaFLikl+3XthvROsLc23yO1w?=
 =?us-ascii?Q?eL1JFpEI4RwvX6nBMk9g=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:SVkiqai3eUclfYFQHpXXL6OvFKfSR/hTKrpPZCbRYzuuAj5vXx5tQbnn848ZfCo0bLyuZ5NT2fVWntufUM2GNYi0CW/PwHfPzMUssFd986nAX0mjQpB+ggIDuFzdy6xQqydG0dTxdO1fPo8KyL9kDBl2icRNu2tZpdRi08NCGjV2+hSXhGG94nCNV/sxX0YHVLmkj9EfHexfVgomyjbk125XDTBKYdPAUKcq3+YecTiogotqbV7AyknIaPQ1R12iVAEUAPxSVvqz8L+CZ6oooR5GCiFqFuN6tlrPaeW/N1EPXB6FK0lJwZQ6C8lXwM1cSWSzxys0T0MXZAfrl1ac9FxeMT0Qe6ofIr9PH+FUV3Q=;5:qTQgDlNB4Yj0Xzc072jdIY13w6ciA+mdYD9HJfoBtvQkkN8QcSSuHs8x/FE4NmBEN9YGKmCHOZoA200oQwQ98jPkjbrwm/Ub/COe2pg6w6M9CJCxwECXwz/04nZLrT4u095vtiP5eE3Vf2j7E0BZnaDp9ZXW5wgCERNTQwKLGJU=;24:j4Sa+OBHGHwSElO4xj6lAXm4WAeizvccuPc+/ZfQs5h4iq71mnbnvdCqC4TqU8WM2qZEprbBn+7UG8QWbX9EgIp1mGgenYSH52zxolSNftE=;7:jB5BIoTi1YIBmf1av4RNIyWbF/gESjv/1qbZSApRjNBKYVWFtn/OMLeY+iyT044IZaZRowxNzGxMzLaKqe4WC79Qxpp2BxbLGoHvJR0fQHv7z/Hq+jfPZw8YMCWRHI2Y7253sSHyFgqOTLt4zpygkGIb/pnEP2wi+liJ1y5+zkhccanmuezWiY0W+Mm/C8ZvaKb32RuV+8C323zOqHs7zmHZvDWtRdkzyaELPrX5k0ek0pdrGB7xDBI6+3tJfVgx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:05.8158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b069b993-9946-47df-a733-08d537b9d746
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61237
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

No change to memory initialization, but this gets us ready for the
next patches adding hotplug CPU and NUMA support for Octeon.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/bootinfo.h |  1 +
 arch/mips/kernel/setup.c         | 30 +++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093..71dd16e 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -90,6 +90,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
 #define BOOT_MEM_INIT_RAM	4
+#define BOOT_MEM_KERNEL		5
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 702c678..a8c41f2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -190,9 +190,15 @@ static void __init print_memory_map(void)
 	const int field = 2 * sizeof(unsigned long);
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		printk(KERN_INFO " memory: %0*Lx @ %0*Lx ",
-		       field, (unsigned long long) boot_mem_map.map[i].size,
-		       field, (unsigned long long) boot_mem_map.map[i].addr);
+		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) &&
+		    (boot_mem_map.map[i].type == BOOT_MEM_KERNEL))
+			printk(KERN_INFO " memory: %.*s @ %.*s ",
+				field, "----------------",
+				field, "----------------");
+		else
+			printk(KERN_INFO " memory: %0*Lx @ %0*Lx ",
+			       field, (unsigned long long) boot_mem_map.map[i].size,
+			       field, (unsigned long long) boot_mem_map.map[i].addr);
 
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
@@ -201,6 +207,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_INIT_RAM:
 			printk(KERN_CONT "(usable after init)\n");
 			break;
+		case BOOT_MEM_KERNEL:
+			printk(KERN_CONT "(kernel data and code)\n");
+			break;
 		case BOOT_MEM_ROM_DATA:
 			printk(KERN_CONT "(ROM data)\n");
 			break;
@@ -825,6 +834,7 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
+	phys_addr_t kernel_begin, init_begin, init_end, kernel_end;
 
 	/* call board setup routine */
 	plat_mem_setup();
@@ -835,12 +845,13 @@ static void __init arch_mem_init(char **cmdline_p)
 	 * into another memory section you don't want that to be
 	 * freed when the initdata is freed.
 	 */
-	arch_mem_addpart(PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT,
-			 PFN_UP(__pa_symbol(&_edata)) << PAGE_SHIFT,
-			 BOOT_MEM_RAM);
-	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
-			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
-			 BOOT_MEM_INIT_RAM);
+	kernel_begin = PFN_DOWN(__pa_symbol(&_text)) << PAGE_SHIFT;
+	kernel_end = PFN_UP(__pa_symbol(&_end)) << PAGE_SHIFT;
+	init_begin = PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT;
+	init_end = PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT;
+	arch_mem_addpart(kernel_begin, init_begin, BOOT_MEM_KERNEL);
+	arch_mem_addpart(init_end, kernel_end, BOOT_MEM_KERNEL);
+	arch_mem_addpart(init_begin, init_end, BOOT_MEM_INIT_RAM);
 
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
@@ -952,6 +963,7 @@ static void __init resource_init(void)
 		case BOOT_MEM_RAM:
 		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
+		case BOOT_MEM_KERNEL:
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
-- 
2.1.4
