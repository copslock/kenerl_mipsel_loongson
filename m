Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:38:26 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993179AbdIOReGNwYzM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bpO2nouPKfpKA77U1ReUNM/LP71su3BSCO40EvJyGDQ=;
 b=Ycgekgl5KEnq//mF/7TjD3J7MmZh0K4KYQbBn71ehc/ZnipRTNPSQoKZaHphGMUvMo5+cZM+Wuy/dXoWO2QzmxoZGxzsJ+khtgZcYj0r76WYZdxFuTASjVvwYEo+ArGJye99Ew1rLGMsqQ0IP60npn3SpkMQroxxLiDPCBYD874=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 11/11] MIPS: Octeon: Add working hotplug CPU support.
Date:   Fri, 15 Sep 2017 12:30:13 -0500
Message-Id: <1505496613-27879-12-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 40e988e7-02ee-4323-1621-08d4fc5ff2e1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:gEglTpflZGGffyLdZ7a9JTTiO1m31uTtd+gHvhpON/Vi6eySOCvz1tmm//EsSJuMXptd5PgRxlIM+D5uK4fDI1JErM3wtbgJ6ig5m9n9JW6LLsYldk7bQmQXJQWf/dmax2jxZpgbfCpRaehLDqIEDSJDssYFgUn+GG76Gp4I1r00tlR9XZzUfpwtRyk5iNNQiag5g8go1ruPKp3yAYAFfJjdnLLcsXnBTDc2vyr8Pg2KY6cwOVdOE/SCTpkWOZXQ;25:8ZrwOEcmcHlNI7AT+7GDMmlr5GmMMhCh3eAEKvBtSHdzmmCrzA3B0ctF209DWU9+EjOTxrA4hKgr4J6sthtClqpiAus6i2nafaLV8eWlwPnqGdO/1CHLYhiCehq4sMhYWCUD8teu/wKdxiE5IvW8nytdVXPTGlsxSA3Qm3X0g+BtmOpbHejybQeVkUM/601yVMARJ0YfUNyc4njLKKcv0cU6AEuWpoh+Ne4aNMl3XoOhBT0ZR6b2d8fPLDrpBnrVB6sMNFVGfzlDtt8aHZSmOpfTOX6CLk6qnsetRfBTU4BngTLfPJAmjP7JT0kZugbjlSW/u13KxTVPikZCX4EKMQ==;31:2MOQD6jrHVqLTVSkReu49iVlEonI0UF/Oo6YbnGn3i6HItbaWOrvMJhVESGKRgPOdyZzCrXpDPdpB2h4yougBeMQ5hqpp18tPa/efVoxeTz6g/SBplxLwM8PDIQTEGp3hx4grapwYWTEWDeSiPy3vRt43EhmQ2942rtSOqZvlYpkQbM9L/sb+NadIPeon107U5ivEn9UyxJ3/GaRHDUmuiPzPVWd8iMyyR1YmqbZzDU=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:YOc0fQ/Eemf3Eb5Bpte+dzZTFlF3ET9h3zF3MwI4J7430tOgUlKj0U1VIaDeLzZrqs7EmvqY3ZDjPEFIEHTHRINjqktjtn4u+i+PPfIORsrqr3nTaWCycIfqbfzY4IoqwkwRRbHqUAq3s6FeascFPu0zJH2yBj0Te30riapRYoRZSFzKNBh58xSxZfcUsVn7wIFkD3EYzmwIVpWCIigHppoXQjpVTR+RI+zHz/TBMiq0X8ne5IJ6CqyP4SGX0dpf14Wqr5uXjf+QexbGXRib59gYAmRstp6OIxZOjU3JCjT/hvucwbtEN7eX8Un8QQUbCeOoRk5RKgc6G4L5EQt0ZkoFQavYy/IzX5QyKRl7HjzwoJTGFvn8nTtbeorFGvODJkrNkpD9fJq4UKHQBoIsGoBiCq0zzXokzGoiW6vfK2dwHndD7o9H6vQTemu2k6EKXSmKcSSso/txuegiBPEl7niBsSV22mY3OHT6CoWdBRYyXpqKXohMhjTrbUFa8qVr;4:N3/GHJlXWrQbmhzh7NXablwioopkX6qpRofxTSRPtnn4rZe27CmIIQiVQBCwau/U274+6OP0AInBeD7Z5TqbdIfhrgWl7iVVvew/Bi9hKm+UXnMHziQrvGLMcUUPlIctGu8jL3IxjSQwZUu4HZN71MOOBLDSOFxHti4dKeMEy3KQikEHdLQaeKPWqBQJ/9es76mUILFUXXVUX5S8kkHU0Zimsf7qLx+3uaftqwktL/MqKOrVc8j1F0nGEmDwt0AH
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800B7D605571E24F15A5026806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(5890100001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(575784001)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:HPNbDty8ebnWUVerVycTUV7++iuBSawUhtXOgub?=
 =?us-ascii?Q?R819ObAMVuIPpAkNIFHrSPwJkO1pkCidrZWhJOJ2zPn7Fi7NI3QJEn5XPmlt?=
 =?us-ascii?Q?Pj6IlvpRLTRwS3EdhcaoEk9cBcD/o7OEq5LqfeJr/OuaL5n+FF6IVUaPOIMr?=
 =?us-ascii?Q?/2eLRq50ytMKsnK7cDBA2gO1tDmc/NaFqNH7DC6HhVn/SyhvdnmsTamhyeg4?=
 =?us-ascii?Q?LXjzxYhHxHYUEXp3eEP2WKzm94LNTG8C8mb0SE6SUPyShjO21rGr6iCx8HRB?=
 =?us-ascii?Q?SESLrtNh3lvgJHeb9VkoQtRMaElBy8bx3RZi5rKcWR1sZq89NgYuchtDFH7m?=
 =?us-ascii?Q?THpJqtk8r5GfYL+of21FGjq1iSNlPlX0QcKDPXaU1rBCPVqEJpc5PWyWd+vm?=
 =?us-ascii?Q?wf5BFJZSktj9dQx9vPkp1c3XlS0HVqJttEHcREed0Q6fZ1RDSV2m36QtYQLN?=
 =?us-ascii?Q?/4ltXIYuGUVColbh+LOpm6Tu4lI7GS+EG+gKqHJzwYerE02dIlPzZ1aPNG/T?=
 =?us-ascii?Q?iuYm5t2O4bGpVgVixfQqLioWpHqOVStWlEXrU1/uxYjkb0Q6qgFFblpaiVY5?=
 =?us-ascii?Q?1Q7oFkbcJtwUte8CJQ/c56Q2RMSVatSNjrBYVK8ZI+OPsmJZwRaEkD0ry2+J?=
 =?us-ascii?Q?3OtNdurhKv6BgJ0/JXdGSIjeiHH9MoC5lOUm0dR66Mk6bgQEmzF4HZ0XfVPj?=
 =?us-ascii?Q?iLm/seR1itr422OAPjOx+VbmldMmhRKEI6K0Or9uDiXiMSbAOpqcH8O/uULE?=
 =?us-ascii?Q?WSZ1JrfZeQsieeffpVcti3gCL6fNX7VUPyG2IDOqFwenH/hU23z1fxsPWYXX?=
 =?us-ascii?Q?p2z3EReGbtzpScIUxh0+gSDH2A4BT8yyavlCXhWJGVK+nByTHwr5Llg/Ah1+?=
 =?us-ascii?Q?8agVAX2tRtvc23Z/xLGfNAlFgxdm9sOXtqmN4ePI5+vU6fOYwv7rmR3vwj62?=
 =?us-ascii?Q?9LF64ejAsR5BfSf6/6T46nCV7HGNX9xlben7oXatd19aSb9h+9RppAq/Y8En?=
 =?us-ascii?Q?V5z1ce+rdd3wv+KKqp+Y+dfr2LebMa5EuG5TsDoPv8wCILnJFwJUAKz/FcvD?=
 =?us-ascii?Q?Rd3K5NYL0EjzpsoKyRd8bAJA5eIL2LspVtLknr9R4xqnZvxb1TGPzhnfzLRP?=
 =?us-ascii?Q?H2dCR6P19LlgTj62pf1yuxFcFnGYKR/XY7FUjiirv5v8x+peszfFKnIodAy5?=
 =?us-ascii?Q?tiPgu4LzxEwgwcTxB/UCPB3/hQOBW7GgpAl1Khu/pvW5huuzhK+lVtdqQKfR?=
 =?us-ascii?Q?YhnkKw8BTJPKyBoUjfzDdBB7GR7zlBSZcFNCwGG6J?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:QkL/TMMDdjEPLRMk0pXsrhYgpLn6Muyp2pB+6H5gwIyPWxXSlU014hTpQ3azB9QK6y848xML/na0QMMnFDnpVnFXKcJgrRrDuQcWmUjyvpN04jpQVKmFsi8+6FThTKHE7VvOIjz3AEM0EqjLx+V/Wb1Z9ilK6bg1yihdm8sVReyJZUZzHn5GA9CmdcX/+NmDjgmSdjRtreMpiTa7+jf+ixPD8ru8vkZruZ8JkBizDbmTMROeR4ppKcdZ6T1d6QKvEtXxXK2ID+W5H0ldZI/bVjIMm55f2zoqSQBnXtat+ZrKzVKnTson65nihf+HSeHke0kh1MvyfGvvX5nuk4y/0Q==;5:e84NuWtGR0I9fLBASv194g0Syz8oG/8WFc3oq8f3CBb9qYHc9BoxZLXyE5wP0xaSJQOdRApP8ScxMtRDMVN9KDyimoE8Rpzj2wBVII7n1XxLkmAAU7muiPXeoznVSk2bT1e0+TT70c6RVBUCmoB9oA==;24:2NrV7Br2H4TcFCCb04ZMsMI614CVoSYSMzo/dMVBug7xs22ruWhWhF2nQaW4jh1ACCVETT56vPOzVhVg/tUXiF6TsY8pi9r6JQMVAcyuANs=;7:6mPHdf+E9nQ4h0Hy0dcL7WiCpg7gLiK+na2eKz7+5Lm+11xsFkM6UqYp1vi+6YU1SQ+ZXCfR/Ww5jg03pAFEiX8+Xmo8HFY8pGPlW4LjwMTxfmePzV0TVVdgK2CuuDe4aLuJ9q1NBDtl7bF/J44XccgtA8UJHbgZUl0k+lrJRX68J1oR2vmQ2/ZXeg0BAt6A0hAL2HBuE5PINBa1gdmbgrL0Ek0Te7+bO+WfQhOlEQU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:58.7856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60023
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

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/Kconfig                                  |  10 +-
 arch/mips/cavium-octeon/setup.c                    |   2 +-
 arch/mips/cavium-octeon/smp.c                      | 213 +++++++--------------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 129 ++++++++++++-
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx.h                |  17 +-
 drivers/watchdog/Kconfig                           |   1 +
 7 files changed, 249 insertions(+), 149 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed35fd1..3e19353 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -904,7 +904,7 @@ config CAVIUM_OCTEON_SOC
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
+	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
 	select HW_HAS_PCI
@@ -2737,6 +2737,14 @@ config NR_CPUS
 config MIPS_PERF_SHARED_TC_COUNTERS
 	bool
 
+config  MIPS_NR_CPU_NR_MAP_1024
+	bool
+
+config MIPS_NR_CPU_NR_MAP
+	int
+	default 1024 if MIPS_NR_CPU_NR_MAP_1024
+	default NR_CPUS if !MIPS_NR_CPU_NR_MAP_1024
+
 #
 # Timer Interrupt Frequency Configuration
 #
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2855d8d..068787d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -756,7 +756,7 @@ void __init prom_init(void)
 	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
 	    OCTEON_IS_MODEL(OCTEON_CN31XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
-	else
+	else if (!OCTEON_IS_MODEL(OCTEON_CN78XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
 
 	/* Default to 64MB in the simulator to speed things up */
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 3de7865..ef6c5ec 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -3,26 +3,26 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
+ * Copyright (C) 2004-2017 Cavium, Inc.
  */
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/init.h>
 #include <linux/export.h>
 
-#include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 #include <asm/octeon/octeon.h>
-
-#include "octeon_boot.h"
+#include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/cvmx-boot-vector.h>
 
 volatile unsigned long octeon_processor_boot = 0xff;
 volatile unsigned long octeon_processor_sp;
@@ -32,10 +32,14 @@ volatile unsigned long octeon_processor_relocated_kernel_entry;
 #endif /* CONFIG_RELOCATABLE */
 
 #ifdef CONFIG_HOTPLUG_CPU
-uint64_t octeon_bootloader_entry_addr;
-EXPORT_SYMBOL(octeon_bootloader_entry_addr);
+static struct cvmx_boot_vector_element *octeon_bootvector;
+static void *octeon_hotplug_entry_raw;
+extern asmlinkage void octeon_hotplug_entry(void);
 #endif
 
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state);
+
 extern void kernel_entry(unsigned long arg1, ...);
 
 static void octeon_icache_flush(void)
@@ -108,44 +112,22 @@ void octeon_send_ipi_single(int cpu, unsigned int action)
 static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 					unsigned int action)
 {
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		octeon_send_ipi_single(i, action);
-}
-
-/**
- * Detect available CPUs, populate cpu_possible_mask
- */
-static void octeon_smp_hotplug_setup(void)
-{
-#ifdef CONFIG_HOTPLUG_CPU
-	struct linux_app_boot_info *labi;
+	int cpu;
 
-	if (!setup_max_cpus)
-		return;
-
-	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-	if (labi->labi_signature != LABI_SIGNATURE) {
-		pr_info("The bootloader on this board does not support HOTPLUG_CPU.");
-		return;
-	}
-
-	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
-#endif
+	for_each_cpu(cpu, mask)
+		octeon_send_ipi_single(cpu, action);
 }
 
-static void __init octeon_smp_setup(void)
+static void octeon_smp_setup(void)
 {
 	const int coreid = cvmx_get_core_num();
 	int cpus;
 	int id;
-	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
-
 #ifdef CONFIG_HOTPLUG_CPU
-	int core_mask = octeon_get_boot_coremask();
 	unsigned int num_cores = cvmx_octeon_num_cores();
+	unsigned long t;
 #endif
+	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
 
 	/* The present CPUs are initially just the boot cpu (CPU 0). */
 	for (id = 0; id < NR_CPUS; id++) {
@@ -158,7 +140,7 @@ static void __init octeon_smp_setup(void)
 
 	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < CONFIG_MIPS_NR_CPU_NR_MAP; id++) {
 		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
 			set_cpu_possible(cpus, true);
 			set_cpu_present(cpus, true);
@@ -169,14 +151,22 @@ static void __init octeon_smp_setup(void)
 	}
 
 #ifdef CONFIG_HOTPLUG_CPU
+
+	octeon_bootvector = cvmx_boot_vector_get();
+	if (!octeon_bootvector) {
+		pr_err("Error: Cannot allocate boot vector.\n");
+		return;
+	}
+	t = __pa_symbol(octeon_hotplug_entry);
+	octeon_hotplug_entry_raw = phys_to_virt(t);
+
 	/*
 	 * The possible CPUs are all those present on the chip.	 We
 	 * will assign CPU numbers for possible cores as well.	Cores
 	 * are always consecutively numberd from 0.
 	 */
-	for (id = 0; setup_max_cpus && octeon_bootloader_entry_addr &&
-		     id < num_cores && id < NR_CPUS; id++) {
-		if (!(core_mask & (1 << id))) {
+	for (id = 0; id < num_cores && id < NR_CPUS; id++) {
+		if (!(cvmx_coremask_is_core_set(&sysinfo->core_mask, id))) {
 			set_cpu_possible(cpus, true);
 			__cpu_number_map[id] = cpus;
 			__cpu_logical_map[cpus] = id;
@@ -184,8 +174,6 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 #endif
-
-	octeon_smp_hotplug_setup();
 }
 
 
@@ -208,13 +196,31 @@ int plat_post_relocation(long offset)
 static void octeon_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int count;
+	int node;
+	int coreid = cpu_logical_map(cpu);
 
+	per_cpu(cpu_state, smp_processor_id()) = CPU_UP_PREPARE;
+	octeon_bootvector[coreid].target_ptr = (uint64_t)octeon_hotplug_entry_raw;
+	mb();
+	/* Convert coreid to node,core spair and send NMI to target core */
+	node = cvmx_coremask_core_to_node(coreid);
+	coreid = cvmx_coremask_core_on_node(coreid);
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
+		cvmx_write_csr_node(node, CVMX_CIU3_NMI, (1ull << coreid));
+	else
+		cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid));
 	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
 		cpu_logical_map(cpu));
 
 	octeon_processor_sp = __KSTK_TOS(idle);
 	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
-	octeon_processor_boot = cpu_logical_map(cpu);
+	/* This barrier is needed to guarangee the following is done last */
+	mb();
+
+	/* Indicate which core is being brought up out of pan */
+	octeon_processor_boot = coreid;
+
+	/* Push the last update out before polling */
 	mb();
 
 	count = 10000;
@@ -222,9 +228,13 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
 		/* Waiting for processor to get the SP and GP */
 		udelay(1);
 		count--;
+		mb();
 	}
 	if (count == 0)
 		pr_err("Secondary boot timeout\n");
+
+	octeon_processor_boot = ~0ul;
+	mb();
 }
 
 /**
@@ -251,11 +261,24 @@ static void octeon_init_secondary(void)
  */
 static void __init octeon_prepare_cpus(unsigned int max_cpus)
 {
+	u64 mask;
+	u64 coreid;
+
 	/*
 	 * Only the low order mailbox bits are used for IPIs, leave
 	 * the other bits alone.
 	 */
-	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		mask = 0xff;
+	else
+		mask = 0xffff;
+
+	coreid = cvmx_get_core_num();
+
+	/* Clear pending mailbox interrupts */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), mask);
+
+	/* Attach mailbox interrupt handler */
 	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
 			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-IPI",
 			mailbox_interrupt)) {
@@ -270,6 +293,8 @@ static void __init octeon_prepare_cpus(unsigned int max_cpus)
 static void octeon_smp_finish(void)
 {
 	octeon_user_io_init();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
+	mb();
 
 	/* to generate the first CPU timer interrupt */
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
@@ -278,9 +303,6 @@ static void octeon_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* State of each CPU. */
-DEFINE_PER_CPU(int, cpu_state);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -288,9 +310,6 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	if (!octeon_bootloader_entry_addr)
-		return -ENOTSUPP;
-
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	octeon_fixup_irqs();
@@ -303,40 +322,8 @@ static int octeon_cpu_disable(void)
 
 static void octeon_cpu_die(unsigned int cpu)
 {
-	int coreid = cpu_logical_map(cpu);
-	uint32_t mask, new_mask;
-	const struct cvmx_bootmem_named_block_desc *block_desc;
-
 	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
 		cpu_relax();
-
-	/*
-	 * This is a bit complicated strategics of getting/settig available
-	 * cores mask, copied from bootloader
-	 */
-
-	mask = 1 << coreid;
-	/* LINUX_APP_BOOT_BLOCK is initialized in bootoct binary */
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		labi->avail_coremask |= mask;
-		new_mask = labi->avail_coremask;
-	} else {		       /* alternative, already initialized */
-		uint32_t *p = (uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
-							       AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-		*p |= mask;
-		new_mask = *p;
-	}
-
-	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
-	mb();
-	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
 
 void play_dead(void)
@@ -344,71 +331,19 @@ void play_dead(void)
 	int cpu = cpu_number_map(cvmx_get_core_num());
 
 	idle_task_exit();
-	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
-
 	mb();
-
-	while (1)	/* core will be reset here */
-		;
-}
-
-static void start_after_reset(void)
-{
-	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
-}
-
-static int octeon_update_boot_vector(unsigned int cpu)
-{
-
-	int coreid = cpu_logical_map(cpu);
-	uint32_t avail_coremask;
-	const struct cvmx_bootmem_named_block_desc *block_desc;
-	struct boot_init_vector *boot_vect =
-		(struct boot_init_vector *)PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
-
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		avail_coremask = labi->avail_coremask;
-		labi->avail_coremask &= ~(1 << coreid);
-	} else {		       /* alternative, already initialized */
-		avail_coremask = *(uint32_t *)PHYS_TO_XKSEG_CACHED(
-			block_desc->base_addr + AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
+	local_irq_disable();
+	while (1) {	/* core will be reset here */
+		asm volatile ("nop\n"
+			      "	wait\n"
+			      "	nop\n");
 	}
-
-	if (!(avail_coremask & (1 << coreid))) {
-		/* core not available, assume, that caught by simple-executive */
-		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
-	}
-
-	boot_vect[coreid].app_start_func_addr =
-		(uint32_t) (unsigned long) start_after_reset;
-	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
-
-	mb();
-
-	cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid) & avail_coremask);
-
-	return 0;
-}
-
-static int register_cavium_notifier(void)
-{
-	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
-					 "mips/cavium:prepare",
-					 octeon_update_boot_vector, NULL);
 }
-late_initcall(register_cavium_notifier);
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
-struct plat_smp_ops octeon_smp_ops = {
+static struct plat_smp_ops octeon_smp_ops = {
 	.send_ipi_single	= octeon_send_ipi_single,
 	.send_ipi_mask		= octeon_send_ipi_mask,
 	.init_secondary		= octeon_init_secondary,
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38c..5093a2f 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -3,11 +3,13 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2008 Cavium Networks, Inc
+ * Copyright (C) 2005-2017 Cavium, Inc
  */
 #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 
+#include <asm/octeon/cvmx-asm.h>
+
 #define CP0_CVMCTL_REG $9, 7
 #define CP0_CVMMEMCTL_REG $11,7
 #define CP0_PRID_REG $15, 0
@@ -26,6 +28,131 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+#ifdef CONFIG_HOTPLUG_CPU
+	b	7f
+FEXPORT(octeon_hotplug_entry)
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	move	a3, zero
+7:
+#endif	/* CONFIG_HOTPLUG_CPU */
+	mfc0	v0, CP0_STATUS
+	/* Force 64-bit addressing enabled */
+	ori	v0, v0, (ST0_UX | ST0_SX | ST0_KX)
+	/* Clear NMI and SR as they are sometimes restored and 0 -> 1
+	 * transitions are not allowed
+	 */
+	li	v1, ~(ST0_NMI | ST0_SR)
+	and	v0, v1
+	mtc0	v0, CP0_STATUS
+
+	# Clear the TLB.
+	mfc0	v0, $16, 1	# Config1
+	dsrl	v0, v0, 25
+	andi	v0, v0, 0x3f
+	mfc0	v1, $16, 3	# Config3
+	bgez	v1, 1f
+	mfc0	v1, $16, 4	# Config4
+	andi	v1, 0x7f
+	dsll	v1, 6
+	or	v0, v0, v1
+1:				# Number of TLBs in v0
+
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	dla	t0, 0xffffffff90000000
+10:
+	dmtc0	t0, $10, 0	# EntryHi
+	tlbp
+	mfc0	t1, $0, 0	# Index
+	bltz	t1, 1f
+	tlbr
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	tlbwi			# Make it a 'normal' sized page
+	daddiu	t0, t0, 8192
+	b	10b
+1:
+	mtc0	v0, $0, 0	# Index
+	tlbwi
+	.set	noreorder
+	bne	v0, zero, 10b
+	 addiu	v0, v0, -1
+	.set	reorder
+
+	mtc0	zero, $0, 0	# Index
+	dmtc0	zero, $10, 0	# EntryHi
+
+#ifdef CONFIG_MAPPED_KERNEL
+	# Set up the TLB index 0 for wired access to kernel.
+	# Assume we were loaded with sufficient alignment so that we
+	# can cover the image with two pages.
+	dla	v0, _end
+	dla	s0, _text
+	dsubu	v0, v0, s0	# size of image
+	move	v1, zero
+	li	t1, -1		# shift count.
+1:	dsrl	v0, v0, 1	# mask into v1
+	dsll	v1, v1, 1
+	daddiu	t1, t1, 1
+	ori	v1, v1, 1
+	bne	v0, zero, 1b
+	daddiu	t2, t1, -6
+	mtc0	v1, $5, 0	# PageMask
+	dla	t3, 0xffffffffc0000000 # kernel address
+	dmtc0	t3, $10, 0	# EntryHi
+	.set push
+	.set noreorder
+	.set nomacro
+	bal	1f
+	nop
+1:
+	.set pop
+
+	dsra	v0, ra, 31
+	daddiu	v0, v0, 1	# if it were a ckseg0 address v0 will be zero.
+	beqz	v0, 3f
+	dli	v0, 0x07ffffffffffffff	# Otherwise assume xkphys.
+	b	2f
+3:
+	dli	v0, 0x7fffffff
+
+2:	and	ra, ra, v0	# physical address of pc in ra
+	dla	v0, 1b
+	dsubu	v0, v0, s0	# distance from _text to 1: in v0
+	dsubu	ra, ra, v0	# ra is physical address of _text
+	dsrl	v1, v1, 1
+	nor	v1, v1, zero
+	and	ra, ra, v1	# mask it with the page mask
+	dsubu	v1, t3, ra	# virtual to physical offset into v1
+	dsrlv	v0, ra, t1
+	dsllv	v0, v0, t2
+	ori	v0, v0, 0x1f
+	dmtc0	v0, $2, 0  # EntryLo1
+	dsrlv	v0, ra, t1
+	daddiu	v0, v0, 1
+	dsllv	v0, v0, t2
+	ori	v0, v0, 0x1f
+	dmtc0	v0, $3, 0  # EntryLo2
+	mtc0	$0, $0, 0  # Set index to zero
+	tlbwi
+	li	v0, 1
+	mtc0	v0, $6, 0  # Wired
+	dla	v0, phys_to_kernel_offset
+	sd	v1, 0(v0)
+	dla	v0, kernel_image_end
+	li	v1, 2
+	dsllv	v1, v1, t1
+	daddu	v1, v1, t3
+	sd	v1, 0(v0)
+#endif
+	dla	v0, continue_in_mapped_space
+	jr	v0
+
+continue_in_mapped_space:
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
diff --git a/arch/mips/include/asm/octeon/cvmx-coremask.h b/arch/mips/include/asm/octeon/cvmx-coremask.h
index 097dc09..a4de3c2 100644
--- a/arch/mips/include/asm/octeon/cvmx-coremask.h
+++ b/arch/mips/include/asm/octeon/cvmx-coremask.h
@@ -29,7 +29,6 @@
 #ifndef __CVMX_COREMASK_H__
 #define __CVMX_COREMASK_H__
 
-#define CVMX_MIPS_MAX_CORES 1024
 /* bits per holder */
 #define CVMX_COREMASK_ELTSZ 64
 
@@ -86,4 +85,29 @@ static inline void cvmx_coremask_clear_core(struct cvmx_coremask *pcm, int core)
 	pcm->coremask_bitmap[i] &= ~(1ull << n);
 }
 
+/**
+ * For multi-node systems, return the node a core belongs to.
+ *
+ * @param core - core number (0-1023)
+ *
+ * @return node number core belongs to
+ */
+static inline int cvmx_coremask_core_to_node(int core)
+{
+	return (core >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
+}
+
+/**
+ * Given a core number on a multi-node system, return the core number for a
+ * particular node.
+ *
+ * @param core - global core number
+ *
+ * @returns core number local to the node.
+ */
+static inline int cvmx_coremask_core_on_node(int core)
+{
+	return (core & ((1 << CVMX_NODE_NO_SHIFT) - 1));
+}
+
 #endif /* __CVMX_COREMASK_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 1c0a929..455d4f54 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -53,6 +53,17 @@ enum cvmx_mips_space {
 #define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
 #endif
 
+#define CVMX_MAX_CORES		(48)
+#define CVMX_MIPS_MAX_CORE_BITS	(10)    /** Maximum # of bits to define cores */
+#define CVMX_MIPS_MAX_CORES	(1 << CVMX_MIPS_MAX_CORE_BITS)
+#define CVMX_NODE_NO_SHIFT	(7)     /* Maximum # of bits to define core in node */
+#define CVMX_NODE_BITS		(2)     /* Number of bits to define a node */
+#define CVMX_NODE_MASK		(CVMX_MAX_NODES - 1)
+#define CVMX_MAX_NODES		(1 << CVMX_NODE_BITS)
+#define CVMX_NODE_IO_SHIFT	(36)
+#define CVMX_NODE_MEM_SHIFT	(40)
+#define CVMX_NODE_IO_MASK	((uint64_t)CVMX_NODE_MASK << CVMX_NODE_IO_SHIFT)
+
 #include <asm/octeon/cvmx-asm.h>
 #include <asm/octeon/octeon-model.h>
 
@@ -83,7 +94,6 @@ enum cvmx_mips_space {
 #define cvmx_dprintf(...)   {}
 #endif
 
-#define CVMX_MAX_CORES		(16)
 #define CVMX_CACHE_LINE_SIZE	(128)	/* In bytes */
 #define CVMX_CACHE_LINE_MASK	(CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
 #define CVMX_CACHE_LINE_ALIGNED __attribute__ ((aligned(CVMX_CACHE_LINE_SIZE)))
@@ -361,16 +371,11 @@ static inline unsigned int cvmx_get_core_num(void)
 	return core_num;
 }
 
-/* Maximum # of bits to define core in node */
-#define CVMX_NODE_NO_SHIFT	7
-#define CVMX_NODE_MASK		0x3
 static inline unsigned int cvmx_get_node_num(void)
 {
 	unsigned int core_num = cvmx_get_core_num();
-
 	return (core_num >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
 }
-
 static inline unsigned int cvmx_get_local_core_num(void)
 {
 	return cvmx_get_core_num() & ((1 << CVMX_NODE_NO_SHIFT) - 1);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c722cbf..b68708e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1511,6 +1511,7 @@ config TXX9_WDT
 config OCTEON_WDT
 	tristate "Cavium OCTEON SOC family Watchdog Timer"
 	depends on CAVIUM_OCTEON_SOC
+	depends on CPU_BIG_ENDIAN || !HOTPLUG_CPU
 	default y
 	select WATCHDOG_CORE
 	select EXPORT_UASM if OCTEON_WDT = m
-- 
2.1.4
