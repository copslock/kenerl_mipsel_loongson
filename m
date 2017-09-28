Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:43:21 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992381AbdI1RjLqfrXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y5fZVGcRFaeeRkMdbQO4lerVLyKglTPaxFZz8XAATnI=;
 b=PtkKoDWyGUawQJYjF3Ggp+/x8f4nYuS2AxZzuhs9GPRhjyq4+9tdTqhJoYRifZ94OJvI3DrVcDRg+sAQu09d29Jq8bBQ0uN+8Sb9qcKzQakAcaqSULRNLgQs6VZwYoeoj5f8ZLsBvLOpJjoFIlEP4IdwCLUl7HJpgnSjaWn5Z/4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:03 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 10/12] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Thu, 28 Sep 2017 12:34:11 -0500
Message-Id: <1506620053-2557-11-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 643ea59e-1056-4a52-4c07-08d50697d000
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:vZFPHOcNcTzp1MXuTAe2uUPgzAYuLIN2kxr/Q7+ZSmUtToYM9a8P/VuNJ+izxncbJyXZ7rD/vOzdzJdSTYJHdfGYfleO/QsgYvdeopOCmmaWU4TEQFK7j6IX/hVQ7caEO4WrC18yx7zK7d9vXrFqBzxIKvIpfBjrvqAOuRvRoRy6B9LMqp2THIbnb661ZO7awutq/wBaxsV0dNB2RrT/F0GRJiJFFbkIa3MpXFyT8x3xl6wExUtNjpoGmVlLQWG7;25:BSG1VVXsqAb8SGqV0YX6W/G1F1q+Ra4k3IJbQJ8v4kEcA+mwQRZ1JrJYAt6OakuyCwA6idXWsKyd1MsmMp8O7DZ4VqhmrxADdy4ZlIeidk+BtGuQUjyFcYUHjY4Ox91dCAsSYfEhHYbAg/AHFeNf70csCPfDlfIDIV41Uxy8DDdmBpcd6879/6hiinXLH7FfGoyQtgtABWoTVc0JSUoGwqF0pBukakYCuQmaGQq12JvRyYjY6Fvbcf1Dd4sn2cNhopt/EhiV1ZdbANO2J59I7LJB+gJygv/i5L4uZN2gD8d8Qgg8svDbXQQLs4oMX5Pz8Ja0pAeRqtcMGHUPgTj40Q==;31:OqjHZ9ImyOL+EL1TJAB7i0ZBIWA3LBmNdIekS2j+S9quYF+eq49rADs6u3dgS6oBVAR7iX2G7GMtq1I0ds30wJssxOi9771vxHnyKZQAjv0s/Ciff6/anr5Jw/+dlL7K8QX57ovgEWRXOTrIxrYrvleBG0ZMZpA+mYx3unsKxPFJ3+WRBEr+SjRRnRi0VQlVxgBsdKc82TNaiQxV4EuYDvN38uga83Djwa5Fa7sQUvw=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:kwKYZ4HVesExsfD5tHxw/VQNgI9oFiM3CtEXmA6Wxtp78awjIBs+jnv0Q6FHRoL4AblNpPidN5RKyOmRxFQVh/74TSh7vK7/KDuYUWlvduLBHmkSfYK8rHaZZpPkfiC8Yrc3GmZmwf+P8RA2m42A4BzymrHbV5DSBBEV42i61YfGi9j5oj5kx+FqemTevjjJr2vE4xz6wqxlcWv9E96LLNKLUzCxBh2vE0ijBnV4blDOrAdWdbhDw1+jetT4lLonyxDLedenf5ya5ldLPpbQiflSNLGSqxLnVtUKTQs/uDzcTZhowvaqwE9asMiy18v0pfR5hk0XR7qaxJ+j1eEJ6stqv2RrohNF5eJ4gI+78Y37bbzj3dtBRXNK+Tn4Qm8xlQqboJgSLPHQNKLVB68KnA1vZecs6Ti58RYZnq675qVPnJshRTVQA/DNiDDo2wMHo14ERW50VlMmTCxZv+ZQ4XW7PrUIjh6NYq5fahd2MzCS/3c4FCwrZU1jUnIn/RLR;4:Qh7ZTSWMYdAoQfl+owC+KWEiYNXSYruM2g4LHEZttE/f38uFZ4+B/HQLcQVePekL69xq1KSs1TBcXC1gO42NhPJ2Aj5YnGrBTNtyfn9oHdF0MCNbcDveFY36m85NNAwhcg+tnuUr5slfctMsuEo+HZTHKgejCoAlnUI6AP02x6xBwSYdLKZFylZC8O4rL8oD8p9PXF6yzuxPgs1P2wnTjVMg0UQ/av74KdiyTKqtSEB9U8mnovUUOKs5gJw9tmjw
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807A7CBEAA9A33269D147FB80790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:GV9WzihSPVeAENKqbyR5woQHzhV90pFYnE0yqIQ?=
 =?us-ascii?Q?eMS9n9+3KLxLLyWJXZLow4xRajaGkXHlU+//8HpsA/tz/+xXzpfaDrLMNeJc?=
 =?us-ascii?Q?QPbsHcJAOKjcPFVOqijtyMQV8R31zt2807CgT2GLbnuY+pH78A0hxEZP9REP?=
 =?us-ascii?Q?a9QREj47zcThMB7hVlnDowp0jxaS/B3vQZ0ZTyjU4WwgSLMDBmctph5YyFDf?=
 =?us-ascii?Q?6Idh3TwZGwQD7gNetmvwdXbKYd3VpCiYN/NW1FAHTIFOmoThDwhBxEor+Sbn?=
 =?us-ascii?Q?aggWkOcXqXTSVqZPbpM2hJEY6XnPOs51bezbQ1jE8X7OcA81M+lnrRFsuX0k?=
 =?us-ascii?Q?UWnbeM2VSvBr4bRpeSgz7JMkutrCMpGNZcyKbkA+aj7/xM+5QySlUA+xP/5G?=
 =?us-ascii?Q?IZZgWYGJYDAc3CB06Uw+a5/6zAhy8Gh4EflWRx0RcOhgW+sL3pYwZk8GrIdZ?=
 =?us-ascii?Q?2lqawXEpr6j3Nm4Jq+OlcECZiVPs4ROEj7gB+pDzbqMufpyYh9Gs6ZNcvpMi?=
 =?us-ascii?Q?TvTj5QVBRnfEKjcM+PY5iUG2Mh7BNCpeORthATPtBEguGncGxWj5vlrXO214?=
 =?us-ascii?Q?7qoN2kXmMkhBTRzsFyxBviCo0Nxsd3Uw2C5C555C6SW274AGi1qRWCrvgYyl?=
 =?us-ascii?Q?48ooW37DV4tjWLNL76dc8zvyO23s8bX/5w0OlOgu2QybgSCqK7iccRmEMvpV?=
 =?us-ascii?Q?7Jf5QRRYuEf6S1VkhkG6CUzdDMMbIFXJs1bvPjUwcg8axYprPLH1J78tSp91?=
 =?us-ascii?Q?JZouLK8/tMnGBCijUqYPIwYKm3M38aHD053wVjDkLOoa+aOneEFt1iOUk0tq?=
 =?us-ascii?Q?iid5iNXXnhqC9T3TjK14y+7OHoTgRhpf8pGPDRiWO2daIaNTkhRqT/bPRFHx?=
 =?us-ascii?Q?fSQEctw/0cFnJvMcQQ9nQMgNTalXTbFiKDbU9vmGo5y7CvhtQsM1mfC8Ju7i?=
 =?us-ascii?Q?gJApIw3bm7hMH8XCEgPde9yP6hSaqZeRgu6aGBZivvuXQXC6i3uu+sM3imCr?=
 =?us-ascii?Q?fIb4cut8a01Xc2LtNt/jTvrmPo/JBCp+y/3O0EpJ1/lAaDifvEHivDRj1+Yy?=
 =?us-ascii?Q?3Y2gtMR3hACr8p/+SepzozCM74izYGptYMq+HISZ+bg8Z3MsEQ6dLoIfAowv?=
 =?us-ascii?Q?DZrQn12YIL7G7GLZIIZAKH64BuC8L+X3zdG0HaQZAceEqGOq5st2T7jpL0d3?=
 =?us-ascii?Q?E5lGaTXaji0PLwYc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:dFjqDE0uR8Q0HsoMC1iWdkDe+i1vFxGVtzvLYOv+CeXW8tfumR+wfC0BDNB4Pfl8CsayZIrWzFL/utDoHVA/8eIP0ADA6Sxi2t0o67SAeJ4wfEbvgekm76+JE/lwrwatkk95zYPOgrA+DZ/0UsugcgHLKP/jWtzQZDF27qEvpRUke8Y9BsVblBTb1EDhz+CftGA0wjPWY4ITql/h+xOc+9UYsfmh9Pbf2FBjjJQfTojmB0Rsgt8YUZWy0tOLkEVbOgBFHb7ppH6BRIekHafQMvaP570v1cpVu554pyV4+duHXwRAD3Nes2DV+Ia+r0p+e07R+zDtsx3HGTF+DZO5EA==;5:CBARCIIg80++eu7FATMb5Oa/AutTOL8kJ07sg/OIfdANOerG6BHx3loSmq4XtJ2KFnZJouV16ChwtKoq2iwf7HxXMqMnAaDssaW9CfBCU2Ovk4669hhJ9WbjVSxEcB6u47llxTSMqtqqPOgX44XM/Q==;24:Fy7fJCQ+QIIMAWwF84xHkBInHnjFVkNxxmMhaxB6pR1RpHsjMTn4cM4E3ED3MLiY7CyqEGeCkbYnLnW1v52h74eW9RU0+69hnaWVbZ//HTA=;7:hAdyjW9zSNP9dAnhWx9jVBvELRGXP/FPFkHcVZ3yWXMogGiit/cqLEeejWNEv36gDbXS66BvI4c0H9eT+bG4eMNraD0zAitqrwGiSvRSo/vxWYXZKM5P8GhSOjKHj129XOeUoh0oSQi1Uql1tMhJoHhLWCvHVWwZW2ngFfL3m0vUkSQ05g1+8aTh+cWlrJlKN9pSCPtyY2FhvYJzZmVcuowO0suCLrj2TcMblC2oCDg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:03.8708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60195
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
index fe39397..7a058821 100644
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
