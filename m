Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:51:26 +0200 (CEST)
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:25310
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994701AbeFEFtdpY0mB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfNYOb4coOiRynY3rQVWJufJZeZwOh4fUmwgbtyGziM=;
 b=m4AIzG6NHgkE/JAxH9TXtnSJFxkLhQE4jtvkIOB8VAKlyzFAKRdgS56V8ouIWGJw/0YXyOuxkMgGo7q2mJaAQKlhhqLB4VCuRleVRbv5GQYTkEhPTmJbQ7Rf0SGdiDT1n2UwOOCOFLS2PYGqSpbZrOVrnuDlzdbf/6gIVtQEzp8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:22 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v7 7/8] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Tue,  5 Jun 2018 00:24:56 -0500
Message-Id: <1528176297-21697-8-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
References: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [12.108.191.226]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com
 (2a01:111:e400:5173::22) To SN1PR07MB3966.namprd07.prod.outlook.com
 (2603:10b6:802:26::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3966;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:yFkOeIiyzHe8nLJulpUzqFWMEh6rmkOEW+f0LmW2fOq9YDK0MfBgEJByI/pu5HxOpTcQUWJoG6FLLQEJn0jldJqCjc401gxjdmTmJ4fguHiqmyN9cBK48piZRvlRzDRsyEYc/TyuG6dVbHlGwQ05SduPYh++/B72otYUQ2IWF00f6nr8Z2GdgAB5VD47ENxR6QxUDtNXCnCEVBaUflq39n/Y/H19eneU8kxwNklB5ZeIcH+ddCLRuBH31QoD2jjM;25:20/DMKdWkMrKMMqOMeydRtoa4WkWaxzqj6ZaTpQPIob/c9WURUX2H4LNjRtCCMcA69fVc5x3q4WlPV0Om3+S/2/HqXk3i+Uc01Ety04Vt/gsks0X+yFCZ57+SpvNt/H2/WGVv4E8EUE9+V/1dhkMbeXPIYRI2s4lDdWQOI7ZZ7AY5NvgaA34FVDkYFnhNJRFPJaiI2EkOK0sNdn70vWa9Dpf425ewByOfVKZRp0Oa60VoKEvDbu+giyF2rq+4rjYVDcVsuyKwBLx92a60N8ksfHRzkSyuFr8mGRNxzw6LUglfn/3PGLfAq94GQZqKRIQl8B22z5tT7o/Q0YZN4h9MA==;31:TI64f3SsCUI6cP2lZAhOwn+L79YcuJF2q65U5+GEnE3Ru5muOWUEPJmqdqseO23Y7M7zPnYB78NJQJXGA1L4kynTJcMAXkHOyJts1dRU2AiMmcdULKwIqTgQ2nNKfDk67tH4zNzG/K7WqyTvqkWbgdf/81RUauL7rgTEHBSPbsNOR9tEGk6wkTlYFlg3LYbgZer/aygmWBHGRkhJCCOP5A3TqfuLpIvvBlff5BUbwJI=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:xW5Kv5m8jwjkxPngsKPf6qQTfCGo2wuwuu84vYtHUW1Yo1/Xb0kS1Fb+u7B3x5KFeCXFuhcwbcJiJ0HkYGQcpl/YrEnaI3ILowgZxcgXi9gsnHJNCpQW8T6FBdblW7Ef+0i0klRxP/ysxrUvVm76qsWtFCYC4dpd6KqcFspi0p7dxAhont1MRxD/9Htklk6kj81IPuJEyEwDq3jVmK8rJ6uVIQ6VVGmpsW+CaBKQ4bNM3K37282j5wJJvZsbhBHPBdDta2fYJaOmCoqB+qjCwSPoJr7D4tX65+HxRNgmy0ebh/B7ElYCUDdpX1QZQxdbvHQSywP40EHgrHVpY7MXUBC+yXKV9Oqvv1Ha+d5KFkzAeI/BUkcFMforLSDvezU4uvWRpOz0rQmLjYn/j9ZUJwCiBJWq5AO0zRQuaJmkzNIJQCOHuDsP+MIj8JCXIZxquuORm2epLdOB/jmcs5lFzRjy69v9Xus4XCZreelsmxi7inkQA9gfWxdzYaMlGQZE;4:/qPK0RbrMtlAILPgB76B33auUPJGHIsTqTjWBjEvydFdpuhnl+F1F1e4SyvojKZoMuJqauPStgseaS4Iz/nhApb+Vefd6IlQGMrJ/i3T0kssQNN5yTrsn1PtWPXxWmkUPKHfXP5Yp61ZnAm5A4EtOhZnuZT9OuAal2edkbuCJcZJVMl8wp7Lb96BSCmenIAfy76K2bYLcDO2SldlriCSHNfHo4nP4ShQYNJXwjzkPFg4rDhwWj0OH61mVioIZd44OhJEEsIv8Zgc46uXBjoaUA==
X-Microsoft-Antispam-PRVS: <SN1PR07MB39666E202E241DB7755A94A280660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(11346002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(446003)(54906003)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(107886003)(305945005)(48376002)(6916009)(7736002)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(2351001)(6512007)(105586002)(86362001)(2906002)(8676002)(106356001)(69596002)(76176011)(81166006)(81156014)(2361001)(6486002)(36756003)(4326008)(51416003)(68736007)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:quAw64okfRKiNVlg07UyaylzS39Yp1SjnWg2Zhjyl?=
 =?us-ascii?Q?+Qp47UBGtvaZW9VHg1MmuRlU04S/Fha91NT1zEEKaO1PFnprQVIMeLYZjUrU?=
 =?us-ascii?Q?Fi17G5UVkTSIKGHaYvBFiRDTtch7AGif7gk8ntUt7BBMnJ7o2v0r0bUuH1P3?=
 =?us-ascii?Q?TIv8caYPW/I100Gezwk93dCgNZrTMWgwDrPSsBVsw8tN6hmiT9nehZU978QY?=
 =?us-ascii?Q?Dm5LXN8As4GjU/5Ca6ejEeenkqm5L3HEzsNQyyohGp20aUvElbZZiNt2mEIs?=
 =?us-ascii?Q?zdS2kiUffn5jtVcCpdTadcwR3un8iZAi+yrE599k2BEVejPMrmIm2yJZRkeQ?=
 =?us-ascii?Q?11wLwgo7lEEnlYvxub+igXJR+ew/hE70A6ZTolEo3Rrotue66wsd0jHeXUMp?=
 =?us-ascii?Q?6xJFXNruqbdhJz883hTH4VHTZRXJDZbvNI3FJlRXOPhNH33u2bDe4jJQz40L?=
 =?us-ascii?Q?8ZgQyOOan0ZqCbRNcxMNqW0ApwB1UJXrog/nkPCxaT5y1MdL7VJVVcUowwpB?=
 =?us-ascii?Q?5u0PuUZNb6MI0uZ925yLGHTZ1Xhg8dCqYmowx5mhRDYVdn43b7Nk663CIQ84?=
 =?us-ascii?Q?nxnxMgiRSfUszyFrlI4uvRuu/3wvGxUyaBQih/4Uhg1ofuYlEENN7NhmALyr?=
 =?us-ascii?Q?3Ir2omcvZWy6qGXMOUTzRSy2mZwJaXh2mR/xg92bIUt2uVf6H7oaXl4xryU8?=
 =?us-ascii?Q?Z25lwpFzRTfgDEAIoF7QVgpXe5PIc3Cn+JaPst7aE62D1HEMrd28AdAXTwDI?=
 =?us-ascii?Q?cJwOjYOiGKZvJYFBE/4x+XEfgmKAjork2AAsJIthZhuEXH3hQkEiqbd4/fF7?=
 =?us-ascii?Q?+2AuwBfRAnV6bc3kBtf2a7lKTzuXl9cYRIIwy8BzInccNVScLTRMjKkruo5Q?=
 =?us-ascii?Q?NalrrCekasm3ZEnqFJJ220Hi3/lrXm/js+F6AN8o3PGb4Jt4oG2Km+Aw5BtX?=
 =?us-ascii?Q?SjW4bdfAvRZFxRkk45RGnkFfoNAmm+idrkXg+0njQyUEUH17Z3M6uW9e+NQs?=
 =?us-ascii?Q?oXLDwX/ZoK5wzwtOD58NDR89SfV9WjvyeK8EN6B+/1QPSer4f5fenuLVON6T?=
 =?us-ascii?Q?Fvf2rCO/SKFC1xDHShHgz6Q+HvloDmFISMJeOnJYxIHBNEE35IBK4BitHeDF?=
 =?us-ascii?Q?xyXp/VO4fx9fQwW4D9diU2GuikfTuyk8vVvM4nDxg90cgvH11pHiKseTh24L?=
 =?us-ascii?Q?pqJHSAztFAqKavDcUN/eaOTI1vQQLuJCffB8UQoPJ3LUBgufa3Oaij7Sul/N?=
 =?us-ascii?Q?yT/ogoWWeCdlEfM7NOTWWSNwvbQmNgU13aSG6XlpLOM4m8rebl74M7eqvRbu?=
 =?us-ascii?Q?hGi0/XUOyv9ZvXQQiftBTc=3D?=
X-Microsoft-Antispam-Message-Info: JsdC88MYl08yxceXAlpH0a0S6EBymGurihHRAbyMfwONpw7GvnRAxFFv3VD9xqumZ/HTdhyjWxMP3aeiAVWQTWBO1PhQZ3L6pt5Khv5zHmiCmFyqRm9H8YfYrDkYxF5ShrJXRqFTStjgjoMVabmdCL8MB7uzn3HEpVeB8r3ok/dkV7HPi9VWPQ+ph1FSlCly
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:SWNK5Gz+mfXYi4uphL+420+L+NAmoV3zw8BPA2QdsimwAWke8SM9IJ4Yp+/zJDcuNeb+uKIdMkBBYwSx4TKguqH4GEsSAe2JPYhmWquxpReD+iLgK9XXLh1S1lyxU0aXAXMB2woC6iis+xFdHynw0/3wvu5soOA7AYe8PhU5NzXr4cQ/JxCoO1Vn1qiXn1OcZ6neH3Tc3RfBmp3g4CstpSsoaBpYmVUv/F7OkCPYU4jgXGLKY9epBHDKgrQXMMnOQRpA9BFS6CdoNPlCYRs31sCPRC0oM24d3KzMQ6XZmabE/WLHpr1Yl/DM7+/3p6PF+7LDexsP0QjR2uqD4tPUzAuN1Y880pkYsdcwPRKeg9NQPdvJCOBZLGMpvFyGQ/jMCVau1dsCdZ0unq9KEkmWbbsqBDt3mPmeyf16VwGRQ0HV5ytmbP30+Q6H83y6DvFQHkljNdxDLr2BuRTk3H65+g==;5:eamHRDGeRXUfbsyJQVCjFNwjAMqChoCxMW71X3PNA9vhO/HxGu8bcHaVydxKtynS6mA+RqtS5/SKRnXCqa+RPyhNJktS5DooEry4lIO08YIxtY1TSHbtOy1nlhkkZS0do7Mr988qXrku7SoRAIuTA5F6IRsqq637v7LyttWdwrg=;24:oNUVpkPbnPw5ZBx54RxAz0mjESl83B4/Zw3TaCx1j+iTEPGbJxRECsJDdd3vtQnjI+2dTMCKTE382ZHGQ03agHyLNyDIH/XQ3VHcFCUKbls=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:GvuEAlIxI/pHfkwoS7ZhfuQM9h5b5ejfSAPNVfp4JHXOTtAHwuPHXx4S0OgTUzEbHSq5XwtvPtLntvSv/+EF+E4afzQ550Fhn72xUU5rAOgWf3t55MjhVjRwqnQle9R7mXfyr9Rumw3UMQ4f7fgeZq0xK550h+l7MKsDRvsP1oqLm8GySR/nWaY14h36qbHAxGxz3y72PoV4BOMLmBo2eoOXj50KC+a1umyNy8X98isWQEapAKiJUVQN9zWoDfvk
X-MS-Office365-Filtering-Correlation-Id: 12671334-36af-4d92-767c-08d5caa81724
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:22.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12671334-36af-4d92-767c-08d5caa81724
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64187
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
index 07c3242..f7202af 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -92,6 +92,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
 #define BOOT_MEM_INIT_RAM	4
+#define BOOT_MEM_KERNEL		5
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 563188a..dc14893 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -191,9 +191,15 @@ static void __init print_memory_map(void)
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
@@ -202,6 +208,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_INIT_RAM:
 			printk(KERN_CONT "(usable after init)\n");
 			break;
+		case BOOT_MEM_KERNEL:
+			printk(KERN_CONT "(kernel data and code)\n");
+			break;
 		case BOOT_MEM_ROM_DATA:
 			printk(KERN_CONT "(ROM data)\n");
 			break;
@@ -834,6 +843,7 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
+	phys_addr_t kernel_begin, init_begin, init_end, kernel_end;
 
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
@@ -872,12 +882,13 @@ static void __init arch_mem_init(char **cmdline_p)
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
@@ -962,6 +973,7 @@ static void __init resource_init(void)
 		case BOOT_MEM_RAM:
 		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
+		case BOOT_MEM_KERNEL:
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
-- 
2.1.4
