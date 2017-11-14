Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:42:40 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992346AbdKNEjG0E8F3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Q2fPz8jb8wgf3z0g8lqp1E0c90gJuhZZmnKwESDd5E8=;
 b=X8MwYDYjNOcBQCLnXREFWroPH6hEyVNnRC9J9uqN4DX0pUv8bSUSZG8TFXxh3gHIH9W1OPo2DIdmc3W98B+7USlwnONq+l8CpI68P3NTAG+3qAfkj8qT8lz54zW8VwYc1TPGNFXJY1XwCc6j2hxw5dyUFeg6M/9ndTCIEj76jLk=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:39:01 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v3 10/11] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Mon, 13 Nov 2017 22:30:26 -0600
Message-Id: <1510633827-23548-11-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78b0a1e3-2af5-4113-1125-08d52b19a160
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:Y0h3WJyMg7xNiZHJAbY7SNSz1EFu9kGMVyC5M7s01jLzir6wI4y04DPLeM6l1Rvdoq+XqEuC0muFPaYC6t2J2D+83DDgcjAT0HHUxWShiWi6v1OqFVixjbCuFQft1DYuOkeKl/MAzNEu0OXnVNSXgWAhxnBNepJ+Uzj5QNl3NfOQnQtjnVeLQP6ml/wbyprNWmRgkKNLlxeSmpYTNtCT/T3+K1VCuTFVGuqlQcz535+N5ZjOYadIt122Leexs8Eu;25:4m+5aRG8u5VaPy4Asc9rv/Lh3u/7/a0R+x3yNjR183CsSfUZqfT/O3E1+ZbIKAE0IOrlVcNdoNmoLuIgaPZrHA7UYeTLm2ttLAxUG2Ej2BXRJhaAhVqYC0s8c2WIL+LNHAPCQ1uHNwX20mN7i3LGqBW8D19n3Kki1e373fllTXthW8NVV6aBH0hPcnR1dsMDjavYEKfxYgYVbZyxf/WfXGgFe5FVVU0OdeXLNwAzRG4FacZHqY3YtrV3SbcZjlnZxyyinKySnU5TEV2PaJOxar7E2fzoZDJie1LjgGODhu3v1p65skenRWNxrGDOcpEBTRmWFOqgdtTDRY61zWqEwg==;31:BReVEhbpXGXNU/dyHaZBmxjn5huuvOk0tDByVgDNY5iC1FWCIaRkDr22qjJ1+3nwkxRMH7cepqwnRfzcAPAnH1x5pIk/sQ08iki7Q2QfXPxbYcq1caThXiqMcQPslupnNXGSwBu9nxm6IWOQ1FouqtqvSelKRKA2lLWNuJ2sY5EQCTvz9Cdb9i1SX8twjV7U+yNkyQt1yI/O1yoD643qXZulwNEBh5szPTwNfrYHwRo=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:0mVcnQBnNhyjGY1QQaYeoLqrafPHz8HsSJIevqaeHmcQjc/zlLxWyDlCGxEkZZzxajuUsGcXMe1j1/yrHjR2he2mbLMzWtSyCl6cjkDBoib6tygiMsZmIkYRZIWA0P+2FS3Sc2UOqvdPuiGLjQ1iYhxgDe48moSUkJIJtd+l7EJOMmP2KdGdTjet1XkDnsBb+3C3c7pGgOu5v1opT5kzMY6DI1egYJZ3frjQaw8+MuYMJBjny5eQj4AlkHFhNEjAo21Iq2u1IV5NnQnjzs2bs63cR6jf6QRM7CV1XFJ7p2NX6217fZVsWHAP7QSLCIT9zY+HoGxUKFlr0P5ORGOR7RdPg4G/tb9pmMWLRbR1ydZuQbGqVKRVELIujSaowUJfwxKzFu2Q7CbcNlEWUcwpXDGW5MKyfcrXlM7bV+AviTPUxKmOCoTq65C5vnW/He0aASrlKbWAMqobJe86EsemCpuOnUQ9Lgdeiv1jFG9rwK3BPVN1SLXLLPT4/3zIQQtG;4:pHTo84LAHR5hplZIDf/bPPCLesok1SBWIjDziNKY11a7ZYfnWkXLF3H0VJMmXeucp93rAC+Z3eD2Jr0HzSHsCV/KazKKLXWiG4MFM0Qs4OjDrJJpsoVLTd6rNrUSOCL9HH4OVtU2fNIijyJq/1L54+B2MaqomYu4RnDsNzV3LDackXPX5etkQNyTLaWgbNdpnWirxX9b2uzgT+BlpGKtXoBcYhb6aHg51SJ6pkRq15WSZoMFTFo8Lyvy2rOA2fYCO8BB/JS3CulA07i4mgi4sQ==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806DD869EC80C3D89A3DDD680280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(54906003)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(450100002)(5003940100001)(107886003)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:OG+hZWmJUI4/F/7kT2n40VMrwV9Oj244k2GVWA+?=
 =?us-ascii?Q?e12t75hGkcEdarikHeo/jVrhvWPo+FOM5OOg1tbJu5KU8vteXM7SSmQzQGY6?=
 =?us-ascii?Q?ErFugeQyjDqHUew1RoP2tF6FIxonF46IsyABOKCtgf0NVfg2a96qyCqaw5Pa?=
 =?us-ascii?Q?EiX5cTfhoW0/1LRfDWMzHK3vcepHlJ7+vXktX6KZGf6vpsScwUV3Ja2uGrBC?=
 =?us-ascii?Q?1VYqyw6hNQe8/tb9yX9s8SSu5fsw2Y0BNWUZTMyNE3DcPjO26A7FHfwJS+yq?=
 =?us-ascii?Q?Kb/DKA06fWRhCF+5kERO9oYg3X/0M60vjHILyFpwlksIU9kkT3kg853Es02q?=
 =?us-ascii?Q?swK1rGk2eKjH9TfUJpCXIv0r/iwxULTFZpY9L+a73+KjkDpiIZpOcQIRhuGI?=
 =?us-ascii?Q?1JANrrTd6yi667iuG9Ft/+NVXEMApt5zp4/A5INtyCNgLQ6kRJ7Fig57J7Ry?=
 =?us-ascii?Q?nE+sP6Gk2dOiLGA2DqWThy35nTxR0wseqZ0utehai301GMtxM08kb2pULo5z?=
 =?us-ascii?Q?50bBqm+571qzYzhOS6zEunPOl6vVA9Mw/jIopKaUq56d1CDPd7jIvmtMlpec?=
 =?us-ascii?Q?bI97D+BVudv0LpCUm5OrMNJw72HdpS3XTL5albGVnAADzmw+I8WuBjeHCcWe?=
 =?us-ascii?Q?HuBmBmS/u5FmReTqHTu0pRtPGWepF1o9AhR6ykUzSYLElts4ZZ0trqeKHUbN?=
 =?us-ascii?Q?ov2VIIZDP/NqGXfX5GRIUbCdl9mzAD9/oc7Fg2i+x4/X92I78XX5UULacZxY?=
 =?us-ascii?Q?2I1FidJ4+krbA9c/HxxG4qdqYdugWe6bw4X1BhZFiSpOgeFE4CaT5RYvyc4r?=
 =?us-ascii?Q?8gr2cnLvBWhS9nRIXWVzVqZxYHmlwtuN5Dnruwb4o79o0YVAsCt+HFrwe9xI?=
 =?us-ascii?Q?39DaKwBlZt0RFGrXlTF+yNUxrtjcdJ3ntLW9waTIkFPqm01Esh//x/TSooAe?=
 =?us-ascii?Q?KiZNQrtO6bBLrgWG5XW06C+EiivhgjciE7LFr1CDV70Sil1mREATNgKwSThU?=
 =?us-ascii?Q?6kYwZSduZKirptt5uuxl7n+OShBk54qxd1FXrvOD4A1uqYfplY2RQ6APEx+f?=
 =?us-ascii?Q?L17xPBLPp+O3x958GXmEBOVHZYn+t7tiMdDGizZVxBaAvCZEyeZMWs7967dT?=
 =?us-ascii?Q?6GqNf2pecFdV4ySA9/rJ7u68X9+agRUik2VHD0EpTOnbeWFvRNR/cJ+hKWpt?=
 =?us-ascii?Q?UJS3WUautWSVL4xEAu+VZa0w/besHzP2HTppVpeaA4l6guHDZRJlThp8crg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:i4SDqTtPK5gdKNBsUw33b9k3kyH5p6NckXgHTkR65bWydOyVl66mDjTzqpukdWZ1ySW+vXItrX4BdAGictc/ye4Yjb1JsTy7vLYVMdgLxVnW13757CkHOwgA0p6frb6JuM6FlH2UUjILlsN+eOxg+sTzb27QaCqtOuw3YM8fzyaiC2akOqY86yVqiUzuUEgdLXBwmdZJkAy/+utewNedT/gdkRpkkK8qgPEpf5Xz3eLfV2LD58M4Ck7SOEGuE+/Usdhg+UIhVs1OAoKbWuRgjd+6LyXbHNf3q89A55oyRgDIyluGzFb7TEnaYj4wcoYKmSJgoa2RudhznmkcfSlziywx6fxYGUbTlC9RxlRCp+k=;5:OdhUzJF/4JBlULPdJ/+wJui67uGcMpcmfCIQif6Pkk3b3rzg1uZAXOs/TVPIDAg2rfvH0E0YEQKhxtnIOr4THVLmz4ZTpILBBsvhFxb/EdW4Q1ckoMHGuZOE+l9EH+rqYGC/n6hlxCmqXafA0cs/CrQQoURoSAoFufpLkOq6+zU=;24:Barl3OaMRfJgf3CdOcrr8D32QyXk1x8ax2gxXbkNUM0jWneDi9QFAN8/sP0P4unrB48lU2omisCbsPTsgySPVHALgo/y9KU+kgQ0gsh9gZc=;7:Zf/+ZB8+Vhj5D8dVgIIVNlO5zEVz6E/gVS2yDyqgAYKzRP0l9kLzAxbqmAfZhjkhoGjpf9FYd6iPrH7lorkXBxQVhePXW7jvjMw5gltfoUgiQlQFf4g3EkDZ02w9KxVEfnFy5rMgIwWEtpLLWy6u6/aBHg5P/IqSdA3ab1iWKyZihJwcdN+LjAFqi7Vn7QsbMtAp0d0aRpP2jIn4jyM5RHToPk7ucHtMT4ZEF88xjqXMe+7vH0DhLzYxu1qzKK9r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:39:01.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b0a1e3-2af5-4113-1125-08d52b19a160
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60901
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
index fe39397..7a05882 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -189,9 +189,15 @@ static void __init print_memory_map(void)
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
@@ -200,6 +206,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_INIT_RAM:
 			printk(KERN_CONT "(usable after init)\n");
 			break;
+		case BOOT_MEM_KERNEL:
+			printk(KERN_CONT "(kernel data and code)\n");
+			break;
 		case BOOT_MEM_ROM_DATA:
 			printk(KERN_CONT "(ROM data)\n");
 			break;
@@ -824,6 +833,7 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
+	phys_addr_t kernel_begin, init_begin, init_end, kernel_end;
 
 	/* call board setup routine */
 	plat_mem_setup();
@@ -834,12 +844,13 @@ static void __init arch_mem_init(char **cmdline_p)
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
@@ -949,6 +960,7 @@ static void __init resource_init(void)
 		case BOOT_MEM_RAM:
 		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
+		case BOOT_MEM_KERNEL:
 			res->name = "System RAM";
 			res->flags |= IORESOURCE_SYSRAM;
 			break;
-- 
2.1.4
