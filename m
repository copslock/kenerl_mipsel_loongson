Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:43:31 +0100 (CET)
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:61227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992363AbeCNWmIt59RJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J9B1jrzx96aJpjsrAbWnkUZbt5qeuVkjmUvBgQxUweg=;
 b=VnT6J+HGfb0+cx10qgVKjUiGpYfHM3UNlu1sDfnxuznGHVj+Z2Wee2kXloS4jTSM6Cj0J4kJYJBre3mjPdVH/R0KXn26j845ZjpJvzIVvHiYgiG+D5pGNGiiTW2RBcPPFLhEC7UdMuDFUlL0e/sxA772zjmx1Vz0PPV/KLZb624=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:42:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v5 6/7] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Wed, 14 Mar 2018 17:24:17 -0500
Message-Id: <1521066258-11376-7-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 318e88a0-11bc-455c-b745-08d589fccd39
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:402fp2z18/q/W47HUd7MaVg8ObDQPdAsM9tHcrkIt9rNbsmaB3RvHb/GAJBEBQRki7cpZ/5OfravqUkXMDcAhe/qpHLVtDvXu6JtQ9olklMn3utaDO1BGq0iUlS7WTL2UHb8vjjzTJLuTevxwRVJuYni9dbBZS7eVCkVhAF4Dx1FMQqcMS1dh6uYxkitH48ZkL1dlN+2jCzrUUXPqFt9dOl9gc4lm+Vzex5w8Lo3xRJZkISLsloVO9mgM186NiXc;25:9NdX63yE+VXMBgp2uEzNEe3Fdn4Qp+TaDuiP6P9I5gdpSuyk8ZRMQFJwgD5S+0x6Ciop0JopwGJku9zptqLgxE/UuqhyPYMHnMwEBHQ7xh+yFY5y6iBeZisT5F3IUUQOPrUjt5q1rqEY/k6+ITt5YmlV4+NasdKXyH/pR9b4Uh54oT9sWxxC0oGdk4K2Ck8pdVKkeZV3/ZfuPT3WpMOS3gRdykjeUAYLGDwHyqCpdK9kW3HhxRLY/odTVoRAdBG4eNRqWpgMo2p/Vgmkn/cBVwhICcOsWrClq3Q2IPdfFregJPdlXKg8peuUu6ZbP5ldJP5ltI/zRblLuZO1Isf4/w==;31:3SBuN1ucBw/2UtZr6I6hA8d8vdfQ1Qzu/YBBe4Y0RhrtlwRJLLv4W35bwrBc8piNqSjr43wLRsMnANvZVX6379IhRSXQ1eVSnBIHwNn0LocLHLjheZG71YB1Y4UatTxmiG+eM4/NjY0bmL/VXPD6hxI1Hd9Vd/NxYbSkKeV/eBaQYv/wA/6aH8TcWSOqLs/YXBh3QEHQmdyY80JA9Ijd3QRJGhloS5uldn2a7+1hVJk=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:dJBHB0WTbYhf86VLJNZKZT0ODLfuFfYQLbVfjSt4fbh6DNSAn5Rz54cWLbpVPWXFuRHCogY0ZDoL4kmoFuiR9rDxzdISySUwb6t0t8xKFHydLQOw6jkobvyeTkoz+YBJi0ishv321Dx/+SDalN4+eDOwY1rZOZpDQPj5Kp9V26bj72HiDzlJG7drC9KId0be5TROxBvcHeE+9GRZt7TJb3soRNSgFUQs9T+dKzxqIyKJBJknJea/8w5mD9292psumw55XE1iV8ym6Lm4DtKZQRkBAzZIRdmYb50qkZUpiqn8RmkEHNbMGDg02mLy5mfoclWdOm23Nuu2zAm/c2pCPXZLkwBngdT8CAxWXNjPatkAlpV1DtAB0zMA7L9Sp3KQKrq0M3KmvzB9SHnKfTACaCW5ZFtrujoW97PBzjpeLtWFVSHWx7d69pmmGubRkhsGe+gK9nA8cqb0NUPlDXzrNdaC0JCBFhIdWC/Bww+L3II6PYz+dLEVvNuRz3AWgYxz;4:75Lo7YHegXGeeGkDyBkiJ81DvxS37KyZPk6yjmd2WfNkYS1Q9sRmSs/zV5lgRGExvilfszg8bQ9ZhtcjN5r2iemjBivTbJUW/xVRocJQOKiL4HBEi7L4CJokbu1XgQqXwjaMrVFGr+OEEpv0/wMBRKjoR2Jm3WHSG7DT9jP2LoCgDXk3isup4ms6C9//WLw4lxOsH7pvokC/9te80m8BweAwXA+dYEXSr7QRvGuaJXwPSb8qlTiD1qOmvFGG9W2zhEE4FBcZj4VWuTqO0x6B8g==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610FD1CE42B39812F4892C780D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(54906003)(81156014)(386003)(76176011)(316002)(575784001)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(2950100002)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(107886003)(4326008)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:wdI2l/ln87eWaZvcjoLz5oy7yRYt0OXYRdeArfxpE?=
 =?us-ascii?Q?bvpssWCxkWUuK7lEvynRBXxW18nK3NKXjy/92P6tcKKzMMYbR6JBA5DU4I4g?=
 =?us-ascii?Q?3ceqYwYO5KtcAYJFJ0TYFUhH8IUSA+wHGdmnidhG1OONF/EM56Go30nFM54r?=
 =?us-ascii?Q?Tfb2qtPCqr+3IJXwOaNKpwJaQqs7vcurcJPZkj/GaTo9fQWkGxNXaruXWv3s?=
 =?us-ascii?Q?S/N5iq6UoeaDnt02AVH1Myt3Lwm87g4GgnT/qvxmV3IdjinOxgCF6IBKt9El?=
 =?us-ascii?Q?0nM9WQKBuigAPwthkxROM0UjFdPpWc9xgEXVSc8+QOHZVrPwYgeHoA5m0jqQ?=
 =?us-ascii?Q?vZIf/leDkeeCvvhC1DrdpxNZ3F6rwqJAggUEdFjZAzNYALjVGdV97M5N03Gn?=
 =?us-ascii?Q?CVJqEmhW6+bY09GqTzwHokKaBAyass4AxusGZ33g5ADByg6MmPrn2LQZsD7P?=
 =?us-ascii?Q?SbWR9nt6CYxwICrwTHc0ZJ9Cal1+OuopTSa2itRatGkqy56vkn3PKltJwD6R?=
 =?us-ascii?Q?MCH3JJgi9mFxDtiDscu41xZvuY+hUBktL516sE097o/GoFNo6VV6oUn9tJsO?=
 =?us-ascii?Q?8HLicyolj1dTbOcCKSmIafsl6cJmYtuAhDVb++w1I6P6rjEtd6VLLzNE0pRx?=
 =?us-ascii?Q?xx7VSuYitram72Ab1Ijm+jp4sq+e+d5FE9Xt0UvoJZhx2I+fH2ujCGIFWqKd?=
 =?us-ascii?Q?VFdPLaRCdIqVeLw9xXLmTN5Bm9RijGnSsal0db1V42mNH4/5H3ta8RBOjGqv?=
 =?us-ascii?Q?SWA8WDRSJnI78He4tqOWIsypBXtJwhTBnNaUd2igw+CwpcYtoX+Tsm7T9RAp?=
 =?us-ascii?Q?nlcomByhL+8uM78sYIhVvPBHWOnOkE/JgJm+Eu9RVv0RSjCWrUqt+BoyjmS5?=
 =?us-ascii?Q?ii8KrS9qd83F3bklKAWaiKnoM0VQIlgFJYZKtEiRWoJxivWIZ2vBXIZctE4L?=
 =?us-ascii?Q?TVHx5AIlqFgQxAfTFIk1ijRx9NziTSq8zkDpdxRYmX/lkt+4Yx1ZTXck37S5?=
 =?us-ascii?Q?eHXlLJqckDN4zVxRWBnAgXCOX95tZFmFKQr3N+g8rWhSohnAb//qZl5GhUi4?=
 =?us-ascii?Q?ETsE/71Zi6oI3GR2NKwoiGZgi9aBFjTlxwp07ja0bzFr92wmCAdkUebtT0fk?=
 =?us-ascii?Q?N4ED1mcoSLrKv03N7DdkC/A91P0ywtv9rXlbUJe9Q+cZibILsme7dGkbjbU4?=
 =?us-ascii?Q?PeP+3Ur1kLnl5FmNxXqZODikgwYoITfv2OIRiTbmxp7pW9Hey3aI+w8B4rsT?=
 =?us-ascii?Q?tC2EkQY1QOJ66rYl9LFAjev4AOVyXezhqLf03AF?=
X-Microsoft-Antispam-Message-Info: uuBQKgEnd/+4s6FoJnRsi9LfNJohb4O/s6iHm/PCEcnUo0vGWmbwgh339rkeVbLml6szhG43AdVqTg6qtfmpWHKR5Kx7FQPlgHHdJrNf0arxGihQe3fZZtTIg2kbgxihNvwSc1zP7EnZNVjdcojXj/5lvm0gYVlOT4QpOrAm2S3/lXCmIjdqwGlScftadefF
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:QEXsqOhcwPmL1RNCPo/8tfNi34np8WMi3+KQu7Gs1C8JjTUYNYuVsxrrFlFZfX7KvLZdKOuZOYSKqi4duPyITa2SY1NTXfrBXam0vmbVSiPw3XBuUIy6aE5g9crzdKgLD31YadCIcSOBgpuus8n9eUXznyxACFzEAo4IM8kwNkuiYzt3dpLYuISnX9Blcm/HbZ299BAVHP8ITwL3oQbf5G+katlFoLJSTB3yqIsi+1lDmq7qcLi21YBW4KNQwhBwDQ8NOkZ7A6lge5+RHqP7rIa9XzlQtFGddLKkCWesUJFMVoTT3cmYtJD5bpxKNYOM8EJ2PBY/vkC+KQzmSkEUSshkWSeQee5R1oGAoLSEeFA=;5:Wl7zi4KElAtZOOYi//7Y5ImPp0YmEhMIp+Cd01vCFOSFvJMV2xHqxee6iwy2QoERyLh2fd1N/uUwMtqaEu0HW61Zuzx8ufldLMiZq01myyVMZxx3z3uAb2rfTAaqzfkXKYnF17gW51LpGjojKIKeZasA5QK3IgJbMww9lAMimO0=;24:kgcHqnd9+ZtZ3O6D1/J8/5Mo+HDSV/Q15XDHof1BayQAXFfV3+z1lMF625h7cTMQ8essOa0eUt53lkbiNPHG/HSVZsKi+zSCJEhgwzO0xIE=;7:KzOrHabhCjvQu2zQXTieDmNyZ2aBkW6kqP2+dAXc2U4Z0J8oWskv3Dykxa5dENxTAeyu60sAFwLVB5NERxxBaJbkq9Mp2ve5g9nvyNxgMGC9mDA65AsPC2w5hAbtutlWrS0JLGQ0e2eWxQBPisdTZdfDq1U7ghMF/VW7ssF29h/UyPZ8vzZRyePMlu1NiCcOfFgDV6wEi5sCC1AVDms9hNKZ2wu5EB1ddiYmC1n2jliT0HwTn5RtUn3/27v/y/Qb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:42:00.7543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318e88a0-11bc-455c-b745-08d589fccd39
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62984
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
index a301a8f..199f9aa 100644
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
index 5f8b0a9..9e2bb5fd 100644
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
@@ -833,6 +842,7 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
+	phys_addr_t kernel_begin, init_begin, init_end, kernel_end;
 
 #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
 	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
@@ -871,12 +881,13 @@ static void __init arch_mem_init(char **cmdline_p)
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
@@ -961,6 +972,7 @@ static void __init resource_init(void)
 		case BOOT_MEM_RAM:
 		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
+		case BOOT_MEM_KERNEL:
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
-- 
2.1.4
