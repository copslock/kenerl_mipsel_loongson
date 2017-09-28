Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:44:08 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992399AbdI1RjMgx82F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4k2lNuDUsppcYSs3XBZwiXNdFEwQgF3Ufa38aKVmb1g=;
 b=BNa8cQY0DmViSHps9Ni6aixL4kIXUDwAToCWpZF2jNDenVkfdqSx1lcmZegiB0icaDMw9jAlX6CnECHKzRoEHx43EsuDFTLCOBHhRVtt1K89h4BiLW7UvmMSeIg3xKYqkVTGRS5P9nZrcfv2zgyWx5pWwSjkJ97xDjXSpnTf3hM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:05 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 12/12] MIPS: Octeon: Add working hotplug CPU support.
Date:   Thu, 28 Sep 2017 12:34:13 -0500
Message-Id: <1506620053-2557-13-git-send-email-steven.hill@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e2ab24f-c885-435f-8e5c-08d50697d125
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:leo+JwUHcOaNDDgVdkH7WOy/S/1sp0Pr7enuD/4luuuJThdskz/Kmm7IJueI0nLohjartzFRi3eAnF/DTBGYKrrtr9/jXAfcmE+s2NnwSRcvOnukfsNvqBunmGsY2jbIDR7tXSbRHUsNVXkmKV6EDOv/qcTfR9iWrE6X+XtxPgqmZTjfLkm7EG1tGViCwaH8ZLj4BXMn1BljGP5mMaveTznX6+guxaaVnYsD5gm+436Kl93nBxrTHYTXg1uCH0rr;25:6iA6I8OVV5DjehXkYeut5BcDeSAnkxP4Fpn/aZx4SVfIq7f0sYyw5go5bToeArlqf2FdEwPnWRdkOHzetmeIUrc2ZM0/3iP1rCE8hYdV1VqnKYHK8RGdnjrArb4i6rvEcoLkr3GHTrUT+DjFXyWikV1xmDuRR+C7Z5dBYXE3cWAQpn+2RZdlLkUiCeTV80PBi+Ynm1ZiTuUXHX7AunXKhvoqzZdgWLfs29e3N9DwVOQQjt1i+2jphUC4XQ3tFa+Oh/VuFneRkXtfWsq453j/G1BINOXOppoVwRpsGOPA9LfoeRLMPc5Aufz2rpgTW/EeX6tUr6T2vcJcOZl1yVm11w==;31:vHoCN02xKnHqk+FWshAOrfS7bzm3WKz53N0doDU7EP4aITgO8CfkFznwEP7hD07TZnKbbYfLxKY8eiZMEeC0wNgp/N4H4SbwpBH7hRBjcW2fYTrfhyTnRqJcZJ6lkVC8iO6iHptBOBBepE/2PNBvGkZ1kwNFXFdgz1MdzQz/mINHMTaLhlnatBCYxulVdVNpGvkP7vA/JBaESlJ3WGfGcRGJK/3buGZznP+i5fJak4Y=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:b+4KtCoGw0Cd18hmwIB+iXV/f3blY2ZCQkP5Fw7Wf7DoykgYzclU9XXmaN0WLkn6yt4vfKpFKFOpmNpiLz0EMqS+852X3Le4Y3OOciGjNMLRhkbGUSyXY8OREVSVR9EWdRdi7O4qYoRLEnjOenrax8wZdzLLOZg0XVmrpEFibLmUYryDG6r+26Q0mS29Oi+T+QluZpRF0RSCW+azhfTbBbi059feeXiJfgZrIIYdj21y6wH+t9vrzNL8wpoynLbxz70x5UDTDiNpGKFjFoJNsl7PmUQwIIrs3pKPnu1WR+DAJu13lilUhcE9m8ZkshjMJhCf43nW0o79ukq4UWRukxanbO7Eu0FGUups0OFx+lA30KAPNsRDSCKAGqQwYDyP+eyLKX35w2hoVZ3SviBlscWJ388iKmZZhi6+Zh3/AyBr1BldKhf9hYPqNXARekobCnjCHeJVMqi5t+mUhCWDhC756AJdacmSeEaXqS3ipg6MOccKBZ5hL6Q+zWu+QqrR;4:pC6CMvXaAupVApWE7tvgNaTi9cFyVVrAFNUi5oA6WG0nkFILJE5MW/PjES6VgeDlw2Aku0YoUPRMDJ/+4hGZTK5gFjV6V8YIHQQeH7K+/nXCx6nCa3hiZPASrPxkDGz+2NAi1JloDPqkErI2oHiSGJHEKYaPdnTw1A1rw+x8A80787A+NWW7bMp7R7qhiBmBP7Aaw02/SUI1ekF1f0EdDiRpiqQufhBTdkY1xfeYHRdCJlMAO6YKvkYyPZLNvoP7
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807F26EB51CFF5C20931EAF80790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(575784001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(5890100001)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:CLeTqVlysJxPTp1ulC8gY3bUpT/CWbQSl5/5Fsw?=
 =?us-ascii?Q?WpVEsSacZHNraWAEKMJ1iYyQvm7YQOGxYfjS2TbG6ImlVCzZg6X3vCFSpHWS?=
 =?us-ascii?Q?XYe99AI/ay9LdJBs6WiQuE1x3hPLnDYMGwYmZjjf6OTh5XOb12nkYQ2YRmOb?=
 =?us-ascii?Q?VoocCQ3VXQT+sthc3/aT+gWqhdBV33Dalj+rKUF2gVr28rMYxNj0KIUwtlzD?=
 =?us-ascii?Q?7DeEstyl6OT4M5ttPcAVQet2g9QLN8THm737wvquRoipZ3kY1R1OAr0ucAu8?=
 =?us-ascii?Q?6/8Xj2sJ4EX/VumZNPfbOoB2VpHbbA+cVI5EF8s0bF4Nb486tVB78G7kdT4U?=
 =?us-ascii?Q?BfuY+0Uwh2Af2zNwXBlDckpHnNm3nqniZgQlP1k1+5lb65qLgNPuAuDMNOjR?=
 =?us-ascii?Q?88dsBvFx26ZK5P/8Dq5ZIO2CFM1y/H+uIoRV75QonXozApDcLlftybNaefbk?=
 =?us-ascii?Q?+FZeVc5lpBdp41FVc3QaCHIoIz4cqFZDot3+uuSX6WVqaggCQgOhJg4CJiJ9?=
 =?us-ascii?Q?E3WmwK4CTDfzuYNah1J7sC6auSjNCUFCvSMGlNjCcQQp/Ym5hnRd/938O+76?=
 =?us-ascii?Q?LHJU/9RrKgd2BwNDtv0iE7JBseYiGg3yKb0KcxZnXjaely1BdEhoNFN6Nya7?=
 =?us-ascii?Q?tsPnEnlKPkPYrD9DfGqxm+CYzxRpb/zfHK6IN9RoLjPLf4UI/gMwrONsXLtJ?=
 =?us-ascii?Q?kYJ65UZwLSdhUxrdJGTY9dphlRtknz+0m7AOJDjPrJDQSC820+toVk451M4o?=
 =?us-ascii?Q?mb5yYwszAeIAdyv3hvaZzEeri8LOlEynt6Vvzbsupcd7sYIHZokozzPFSOoJ?=
 =?us-ascii?Q?ZHufWLosUPin5/zLgEpJYu6uJChZgtoFJJ4QviDU065ksWN65QRbZWsB460e?=
 =?us-ascii?Q?mcBpexmWNPi7n6n3vnT4HZaOE1xdY3fiTVH3Pwxr7x3T//H2+nZa01698uHK?=
 =?us-ascii?Q?s1rAgD3/c1QPx70W6hXv64QxFTDfRhPyuj9XZ6CpvkANN3wCB7D+Ij5YImwJ?=
 =?us-ascii?Q?lCF1boBUCBt3cm/zylgMlI0MeQUxAoyuWPjPXBksxWKzZgPfYzPE5n2swxSH?=
 =?us-ascii?Q?I1udwchinZ81RjxAUqVpl2RZ4hsuF5UonL7a3n3zrm5mmkTVG3lkZIRFQVTv?=
 =?us-ascii?Q?2y9Zja8xjvrDPUB4V5e5m6BLd8JG/hq26zlkO27ri7dO3Wrk4caIHEfOYiC9?=
 =?us-ascii?Q?fBLPOjB1eW8fm3AZWCRfubg6WYvtC7vAQBUYZpKpGuLOq5BI6aHMxhskRoec?=
 =?us-ascii?Q?quFPOFonL/HJ46Etesh4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:HPNfE/UsZIVAJuQ0ojYjOESWsjwJqRRZ7uhWRRjEwb2jnwVvLKT/zAjusksYN6sKxHVK10QVALmAkOB5YlFJ5B0mTXPQcPnyie5j+EseAg30SkI12Fc1eBsaRaWABWVXOopRlyVbuF2YKR3g/Kv7EmD4DLPNV5RgxnkIVdmDhe827ds70eQDmco30jN6NVcUuG1A5FTM5ArurCmeOv5AeA6NIKX9ldww7XwhbsRsl8Urg4ZUOGn9DE1ubyt9HVo6npaBAhEy2nFBLmRNZ3qmqyvYyXRYe5SHY0MJts97X18/SvoEw+O83HBf3wXt/2jEM7xU+VdGV/mVTv4gHAN6HA==;5:0Lkfb6qgQVImQ7+pVSRh2v/G7eR2+HSXVgMFFzfdsCHs+GQ1iJb/ZHUeQVtSzty0LtrHueAKoTPPYLmUnFUHilall126KG5wElCdHlHG6oJrmpm2Zfyf2zsuakB1JDpKMr9A6vun2hQNz/x0N4jRfg==;24:5KnqcmnxO3bCZufxIDD+do5sO3nnkK/eZd8ONNLeV7Uk2aOo32pP3mIo3xpt8cN7K66EtfCsRYoX/T245wNLKxUYI9u5jgYSqd/DToFOvhQ=;7:OkulTuRqASo+1kd/gMtWX3cpjOQ3WEA+FPqlbutf/Dl3q/i4ybbLOe878d3fKuShnuvk+b+XklYtWOQV+uy0oIbMq/ODUMfxi9q8DluYF5oTEW54PNI9Y9dbQcmTe6TsLw+CQyVdbmDbXDVbX2/ra6RYSQ1ZK4n3T+lC5CP+DFJ1K81VSVJmDW5cward2cJmsfyveTgHqZjjkocMzxAeNgKrE05gJYJ8AEbxxBdySsc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:05.2145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60197
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
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/cavium-octeon/setup.c                    |   2 +-
 arch/mips/cavium-octeon/smp.c                      | 209 +++++++--------------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  60 +++++-
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx.h                |  17 +-
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 7 files changed, 168 insertions(+), 150 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index da74db1..e24444f 100644
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
index 01da400..6eca1f8 100644
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
 
 unsigned long octeon_processor_boot = 0xff;
 unsigned long octeon_processor_sp;
@@ -32,10 +32,13 @@ unsigned long octeon_processor_relocated_kernel_entry;
 #endif /* CONFIG_RELOCATABLE */
 
 #ifdef CONFIG_HOTPLUG_CPU
-uint64_t octeon_bootloader_entry_addr;
-EXPORT_SYMBOL(octeon_bootloader_entry_addr);
+static struct cvmx_boot_vector_element *octeon_bootvector;
+static void *octeon_hotplug_entry_raw;
 #endif
 
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state);
+
 static void octeon_icache_flush(void)
 {
 	asm volatile ("synci 0($0)\n");
@@ -103,44 +106,22 @@ void octeon_send_ipi_single(int cpu, unsigned int action)
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
 	for (id = 0; id < num_possible_cpus(); id++) {
@@ -153,7 +134,7 @@ static void __init octeon_smp_setup(void)
 
 	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < CONFIG_MIPS_NR_CPU_NR_MAP; id++) {
 		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
 			set_cpu_possible(cpus, true);
 			set_cpu_present(cpus, true);
@@ -164,14 +145,21 @@ static void __init octeon_smp_setup(void)
 	}
 
 #ifdef CONFIG_HOTPLUG_CPU
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
+	for (id = 0; id < num_cores && id < num_possible_cpus(); id++) {
+		if (!(cvmx_coremask_is_core_set(&sysinfo->core_mask, id))) {
 			set_cpu_possible(cpus, true);
 			__cpu_number_map[id] = cpus;
 			__cpu_logical_map[cpus] = id;
@@ -179,8 +167,6 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 #endif
-
-	octeon_smp_hotplug_setup();
 }
 
 
@@ -203,13 +189,32 @@ int plat_post_relocation(long offset)
 static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int count;
+	int node;
+	int coreid = cpu_logical_map(cpu);
 
+	per_cpu(cpu_state, smp_processor_id()) = CPU_UP_PREPARE;
+#ifdef CONFIG_HOTPLUG_CPU
+	octeon_bootvector[coreid].target_ptr = (uint64_t)octeon_hotplug_entry_raw;
+#endif
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
+	/* This barrier is needed to guarantee the following is done last */
+	mb();
+
+	/* Indicate which core is being brought up out of pan */
+	octeon_processor_boot = coreid;
+
+	/* Push the last update out before polling */
 	mb();
 
 	count = 10000;
@@ -223,6 +228,8 @@ static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 		return -ETIMEDOUT;
 	}
 
+	octeon_processor_boot = ~0ul;
+
 	return 0;
 }
 
@@ -250,11 +257,24 @@ static void octeon_init_secondary(void)
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
@@ -269,6 +289,7 @@ static void __init octeon_prepare_cpus(unsigned int max_cpus)
 static void octeon_smp_finish(void)
 {
 	octeon_user_io_init();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 
 	/* to generate the first CPU timer interrupt */
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
@@ -277,9 +298,6 @@ static void octeon_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* State of each CPU. */
-DEFINE_PER_CPU(int, cpu_state);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -287,9 +305,6 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	if (!octeon_bootloader_entry_addr)
-		return -ENOTSUPP;
-
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	octeon_fixup_irqs();
@@ -302,40 +317,8 @@ static int octeon_cpu_disable(void)
 
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
@@ -343,71 +326,17 @@ void play_dead(void)
 	int cpu = cpu_number_map(cvmx_get_core_num());
 
 	idle_task_exit();
-	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
+	local_irq_disable();
 
-	mb();
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
-	}
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
+	/* core will be reset here */
+	while (1)
+		asm volatile ("	wait\n");
 }
-late_initcall(register_cavium_notifier);
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
-const struct plat_smp_ops octeon_smp_ops = {
+static struct plat_smp_ops octeon_smp_ops = {
 	.send_ipi_single	= octeon_send_ipi_single,
 	.send_ipi_mask		= octeon_send_ipi_mask,
 	.init_secondary		= octeon_init_secondary,
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38c..bef5092 100644
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
@@ -26,6 +28,62 @@
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
+	mfc0	v0, CP0_CONFIG, 1
+	ext	v0, v0, MIPS_CONF1_TLBS_SHIFT, MIPS_CONF1_TLBS_SIZE
+	mfc0	v1, CP0_CONFIG, 3
+	bgez	v1, 1f
+	mfc0	v1, CP0_CONFIG, 4
+	andi	v1, v1, MIPS_CONF4_MMUSIZEEXT_SIZE
+	ins	v0, v1, MIPS_CONF1_TLBS_SIZE, MIPS_CONF4_MMUSIZEEXT_SIZE
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
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
diff --git a/arch/mips/include/asm/octeon/cvmx-coremask.h b/arch/mips/include/asm/octeon/cvmx-coremask.h
index 097dc09..625cf94 100644
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
+	return (core & GENMASK((CVMX_NODE_NO_SHIFT - 1), 0));
+}
+
 #endif /* __CVMX_COREMASK_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 392556a..2b0c836 100644
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
@@ -339,16 +349,11 @@ static inline unsigned int cvmx_get_core_num(void)
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
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6..0980628 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -355,6 +355,8 @@ extern uint64_t octeon_bootloader_entry_addr;
 
 extern void (*octeon_irq_setup_secondary)(void);
 
+extern asmlinkage void octeon_hotplug_entry(void);
+
 typedef void (*octeon_irq_ip4_handler_t)(void);
 void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t);
 
-- 
2.1.4
