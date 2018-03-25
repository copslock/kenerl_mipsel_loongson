Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Mar 2018 08:48:43 +0200 (CEST)
Received: from mail-by2nam01on0057.outbound.protection.outlook.com ([104.47.34.57]:59066
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991172AbeCYGrLmDLhM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Mar 2018 08:47:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J9B1jrzx96aJpjsrAbWnkUZbt5qeuVkjmUvBgQxUweg=;
 b=VmrI1Zt25yQHnP6gjFgJ5/8pPuCUXEflGTx7je//YpCIPrFfcXFcPBoYZlAV+TNaZt5hxYN5SUtnmUJhvKmLhGAdgmXWhTC/5tZNvUEilHzPEWkorqAs0SWMXKjJ0LZt+fQi5SVbcaKMubzE1bDqeFMGXoCpkXeDCzdtn5n8Uik=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.609.10; Sun, 25
 Mar 2018 06:46:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v6 6/7] MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
Date:   Sun, 25 Mar 2018 01:28:28 -0500
Message-Id: <1521959309-29335-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
References: <1521959309-29335-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: SN1PR0701CA0055.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::23) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d43dc43f-0369-4c7a-1377-08d5921c3568
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:+Ad06OllA2yE03CCrpSNPBv9vzJpnlxD3BIH82AYStFJubKqJxnKv7/U2Se/ZJENoLvkQEsSNjRUH+LvpscF6y3VRiDP/gQe8GY7ykZa6bYhc6jP3z6M/nazFk2hT3TgfCiiH7IgFT4lKS/D5yrpmcLRUYzXlEXy+yAT6qJpTQh6aAFo9N2BHCkPKjkqHTO1Dyfi2kvfh7sf7mgqiKEFfUfEykN9wUl9xVXYmdAG3D4ObTYuLvQgdgyJ7CTdnV5G;25:88QGcYxrvMDjFXJCm3LVq165tvuVdHz0JGmzGGDu3EKwWFbp+E7z/YDdTsLwOW9X780vr3V9R9/Wy5niOQ2FdRZ09vuC1fD0r8RXiBJVK8S3rSdX1APiDNoCSwQgo4ZNqB+eGao70K3pcEufCYWYexpe/q6Hz8dIH8f0cvrhHKSNtUIniyawKyFU+HFzfFPLCxz5pJezT2ICYXE/hfAdloQJ2friRudmecE9IXRCY7b5y/pd8C9/SLRMap68Hu9sOvXzHY+CSLOCLvNqJxYh21cS4X95aChxDBt+uFj7Z2V/Ob1GDfhqhLmOeqIdmxfIAU9Hsgz/ImvTPSETdlO82Q==;31:UuyoZF4TD5JMRvMJjHQ3PBbuytHtdxDObCJrpNNq1t6A2sKvrl3hdYXN1KLbBq1kz8J95WKr/YiBixGVXdHaSNRMCb2nUGtx1cc4a2+uasRCv4PZTSs4J34/ONnV3V3JqDk1Ynpol7NXJ4iPELmagZUNo20aoqePXxsHSoggcyCa1Dt7/ttTuD0tEldVDAYlwrntjpJRTg6FJRE8bv/tNwg2JpmJAEhTbJDblaACn9o=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:YIuwqKLGwDUmvA/JcMn31Woht8KIINlYQKAE1dG7aZHl5ch6JTQHgcG+w69Jq6ZxGipvPvIeDzLEXbn48CrfsxpkoZrmJbC5YYGbPUmB2fiJEOBMkD7Pt8ZBxNH6vS/C53NJym2ZuATWUJS9PDlJyWl5sHgTXPEAp7oDJRm2pQcFFmLJs/Y5IPflYNZ9q1L+PDVYqTQD1r1bCOSzGGWLpihiXXhS3WNtsr0D3IlvIuyYUXX7T/pfyUTJ6fv+0pBzXQhDhWDVukGJRUcIndvcs0hGOasRf/dPopSaIgJQkk/NAa0OyeYAwUe1yGXeJLY4IxtMatDK3yoWieexuEqVCsJbtM3Fsu41BnUNKKWuL1DaZ1bKtvYkucYzTE2Mw0gmyWyg+vBqeWftbAWH5jyCGs+rwyRd3cUR4ccmH90iPcmgPS2JSc8kR4WC9B4d4ZyhbnIs6qSgfl5hFuIY9TX6UmWp+imhIC2ivTevpEMfSJ7sf3yA7N3Cf3aMVmkhvcpU;4:Uf2C6x89sdF+CtG8T5j1Njtm/ZD//G11zqPJxoFSS/laJJ6hIqGIobPERb6x8YdpZ2bZXqgEb7e3onrKEi2ucaVgX6yJwINHAF6ruEv472FACt0m1YUPgESmNjtLX2fQjcdwSQbrMKWzs9W60m+Y2LdafP1oZs2lRCq4NXCsJT9P1nAU6FKPEg6fdZ0O/z+bW1vhnQIeo6C40AFCtr+1Z+nJAzM+9XQBBB/VlUXDlWUtKUJ3OxTu9UphPvNRZpVwGkqcPoGz2c4SKuz7T/5K0Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB36102FEEA6552AB5ACFA7F7380AE0@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39850400004)(39380400002)(199004)(189003)(97736004)(51416003)(4326008)(8936002)(52116002)(48376002)(478600001)(5660300001)(6512007)(105586002)(76176011)(8676002)(81156014)(81166006)(25786009)(11346002)(53416004)(6486002)(6666003)(2351001)(6916009)(6506007)(2616005)(68736007)(575784001)(386003)(86362001)(2361001)(956004)(47776003)(446003)(69596002)(6116002)(106356001)(50466002)(305945005)(7736002)(3846002)(72206003)(36756003)(26005)(107886003)(50226002)(66066001)(316002)(54906003)(16586007)(2906002)(53936002)(16526019)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:Brta+cg4s4kNycqVVtYbkSR+iiNPkWvJkniQ/cXMQ?=
 =?us-ascii?Q?ysSn4S5JxhxBqxmt9YrK46fX2BeIWh+gZYcANs2ieTW7rlY56wsClP4eMZtg?=
 =?us-ascii?Q?+sgify5IeMgBNZMoAi3migysuO1i/SWRnwzxcwt4o+n5A2LQnjwnIoM/h1st?=
 =?us-ascii?Q?dH8lPyW7u5ed7/5rnzpU5O+KZGo+Mdv2dSXLY3I7Lem+YfGePq3IlM1adi+B?=
 =?us-ascii?Q?9v710KOq+9lzn1L2J5dDSgBIUTthCqAGYECZrIebcl1qkEJHchs7lxaAr0Pe?=
 =?us-ascii?Q?nQlZBIxoAHrw38K8M/zCf86Z+IDpgqEpJjcv42BhnfBpLE4rhHsq7v4Be5wR?=
 =?us-ascii?Q?TtoCxaY+oM7N5dYVRrreXP01rUhPlvFjfA2Q/81ldKx+oXZyRgRikhNAfK9d?=
 =?us-ascii?Q?lAikOXlNvf7SofhhYjwpQT1DgYcRoNj1PNCCkZDcnWk4hZ11iXcBRzTpSglF?=
 =?us-ascii?Q?t9/QqsKulAYSwDv3+OylSUNR4b/lZeSN5uhYLEu7/y2q7ejn4p/5c8DGlQdc?=
 =?us-ascii?Q?51PXBjxqATb9JjoamyvPWT3bfn6V3c1lqyBJKG1EP/v+kOL8C9Vtb1VoqRAt?=
 =?us-ascii?Q?YjOXn4f98cT8RqcH6xqU82Q4CXgb7HXRCS3GSztyFQpRYYn0DPe/bipGE8X1?=
 =?us-ascii?Q?QM9pW9mTTrT9+J30dSKfrZCJ5wZS6RxoJU65RT5z185uVRJ0jYv9Fx/wX8y8?=
 =?us-ascii?Q?2rn4r/L3GxBu/sQfX1BbIVF23OcKizK9EsT8xv0uKadfZc7XqdbO+CPSCWGt?=
 =?us-ascii?Q?NbD/WDEfMwyq3YGa2h3MpfNtZd4gMoCQn81WmuZ7iJhn1qOjMkFcXM5sZVV9?=
 =?us-ascii?Q?z7C7bTmaUpT8h1j0LfxVb7rhIUs7MsUaR92eyC7e5g0SOioxQr4D/LX2W7cQ?=
 =?us-ascii?Q?+htReDWDm97+GoUiJoPgL2x9RevGNP+Zdg2pawMEl1PQMOcsHo8Il53CEkkL?=
 =?us-ascii?Q?cPk+mMICBgUkNzeLeCiA5eMidJRtQrf6KbXL7+r7I9DSJ4B/a8MZPt7WASwp?=
 =?us-ascii?Q?1dbsO6B1rplhiNJyjCv2D+EssSlgyb3F0AsbVk6pyj4i6CxAurMGiBibQx1a?=
 =?us-ascii?Q?UGB/sGKBFH/vw3ihDRAEblIhY5LxHQ++Yq7ESxtt7mhwAC3S7A+o0+qDAJgX?=
 =?us-ascii?Q?2Y6AFn/yIUtFYT6QsGw9oNeN9xWmP5QWfIMUvBVvwc+wyDSjPHzPkGp2KpgA?=
 =?us-ascii?Q?BnOOu8LluFKRp+rZp4QmK63HY7OdJpxbSQE9L3uHXyqHvo3iyDMzbO7uhiEs?=
 =?us-ascii?Q?HgMTISm8jVAFCyiE9dwdbk3WOh+fhYT4Y9Sddu8vwhtFUst/MVlDzXd0iVF1?=
 =?us-ascii?Q?ATiInzbLteKMGC7+HfPlRE=3D?=
X-Microsoft-Antispam-Message-Info: 7MXKKoaosppF9KAQUhTgeaCN3xovJeFZylo9mH/oC07tP4XTLU+tmYJ6cHWJgg1r9D1pdj3YkE7hlnG6dzuoZnwoOYLNo2GVFcuN694/zmNy8nFWWxLoJ2+Fnn1w++lghvUE2oP+9PAlXcVf8IJp6a2wWe4T6mYkWtxPHLUvL0ZpL/jYYWYWWDDO+KhPY6rR
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:LUb5PUsThDdMu2awCwpuSWuaDy17lhygCHhPlcTcNKuTje7YJTA5HO+iO06kx/SV2fykiHlBOvFZMdJyIlPh1LGSXdH05kOzWzW5cIISA58GcyuIMdgS3UnMPMocATFIdSzkU/MRkFJ/JUrak1+lIycTXTv1eKYoa0PKeF5Q5R/6pr5OkD23/cQqBS7MP5kRkBvvTVi2Lim0Pcw/ZT3wy/oQBtB5D4SW/51oOAvaPbM1HZXW5OEnSmZUS8VNgfixR11tTvBigQ/An/U32/8jtXpNkf/e462NeiFyyNlvqg3und0xUWH7MZT6npq1s9fPFAMuJRX36rDwGvLO6s9yy8tbEgVNmg8IZPuwr+ZKYHzzWtX0Wqi/aRSPVjmmeLTsJLCymKigyz7nwqBALR3g363uIGq0+FNoPkAL0wxv2mtkLcGQmPl9gDF1KOtvLQYQvmHVlwsWxFg9vRlL9li7jw==;5:dTZYnFRNvl8/bShU4Zn2yL6pN67U6f+qCeb4a9ej5kgMejJ7Rof/Uozz3VQYhGblRruh6f8kLJYUipOWvtDjFjjuhhXbBc5Wk2k7UK3sdj1BvtJHmH2fatmmtMQrcROOybgIDgiI8gxiRAPe/XawoZt05ZFosQNEyC79/EbW/JI=;24:p3taUhRXxnK+3uq+kz2peWwVGSc+gjXVDoEJEeAAsJ9+Ba0tB2fZqeU/WCpBtz6SyNEvS5zDHdhxLeCMTJw9P4eRcMJs7CQrn4oE33KN2EY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;7:eT/+9WOi2EJEXUR/SIEz7BpJOIQ4K3Szc/tS++tS0i+kM6/9aL4ZqPMWtXgsFGPupx7VCQyb0SQYI+PoVEffUAfs0xtNxQsCL0vAL08YMC1tpzZ1LSfBWQL+4yx0+2UyZ/zOqs5RQhcI+E16UCkMFaZXYsk6+SX4eu4NLQnFeABaMM1gOhBuOF9Dt3sMbJJu+J5Hp4kJm3zgY8cttkF5WseKmUollIQipm950MXEIgGufLrzbueA3TVdMyQ7tKh5
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 06:46:58.7970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d43dc43f-0369-4c7a-1377-08d5921c3568
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63221
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
