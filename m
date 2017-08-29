Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:47:08 +0200 (CEST)
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:51904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995046AbdH2PnRdtvC1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TyGFucagDeYf53qaM6knWmhachGUjvMnSHqe80ag7eE=;
 b=OYHrmMj5q8+wlV2JHhPexL5n7lUTnFxjnnoL487qiIWMKKv5DbNacLPiHUw2Ws7ku+mg/iO4UuKLTDpiJ8Y9IJmywg6+sdLyZiTwS353i11zUySLz5z0vU6+b5rDJ3+h97//ibh7b76eb4Jm16oqUQFEUuVCj9G5IoMJYbCdARI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:43:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 6/8] watchdog: octeon-wdt: File cleaning.
Date:   Tue, 29 Aug 2017 10:40:36 -0500
Message-Id: <1504021238-3184-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fbb67ce-41e6-4be4-9e3d-08d4eef4a123
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:SluZRR5wSHIeRUTwI45Q5a6Xf603WQkFaGlFf90ibXt0UqaTaDjHeIaUXdYrK44VyzbKY/W54CsKglnxGciFlfc6eSU8/FW8Vq8HBmOM/jEEiSHnY2c0J0aWB38TLBINsqWWdv6lWJtUkRGX5lReDUytpjCZghsy6rUvTNspJUuui5Z9pD9MsBCnP8x4f7hltsZwbBgeVNC8lQDoddVTYtGFdJF3R0LgHJgPS6MpSTtI3dMG/kOUG6nkmw4DZXC1;25:ydLwcTgyzjC1Kj4cXcnQs+YKo+lgnTQVrL7ylclVLAkElRijF233bFnjJBAJWNTDswo6K65N+3o406+zdeKvtgjCJF3GbedzF3opF16EHhZdRuk/8yL7C+LjbQ4vcQx5tVjmji3Dj6gEg9tWS0XHUG7sYMswMgQF4+J1HU09KDBuy0LOkv19qfplqzX4iW1n9v3OVYjboCIxz3Kft3TCiBy9mJVEEIMpxCsmzNu/HRnhwGLGYiLBZGUEbRUtgEJSntJDyZbb0vKtdCjUOJWkLuR95U92hE3qDloJoYyy/0pfzh2wXo6QY0jD2Ct8ZkbzPLBmmrkwYU4DO2UYpngXlA==;31:rJUeW5zrS/gIVHCoYZ9z62I3tYBSO0Ss0U8E/E3bPt+dNm5tD25LqfYwiMcXkMPby+4kDT+ge4+8VuEj9vTz0K4PhnjSrP2vMXc/7gURF9Iw8O8baJnN3AAslcgP064AIvBPf4W0BoGXrqEZhNGMWZOxgXw/SGcKA58rxnE3j9UFwqr124d3acH1mjDNoRy19auxO/UNH+I/ZplH3x4oWQyqtxqVA0nfIQyVbt8481o=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:IfpKqCi/8GCxRUyOidgOlPSuPSmuptVU7oDx0/bhrWbIQeAIKE0q0CmxRR152ERBfYkqFpFCCCtAmeHDFdxRsZXJ7FwGUNW5eg3SiPbUjP8xxlsaDHVnPbzqPQHVpqBN99w+GrCGjA4W466uDIGBXdfXjpb9gSEr/C8oeYsfPZD9KKwtNUyi8GyVfQ+YE6N1epE6tHK+QERYmovmF/M/nBVod3OW86YmvpO0kAzptj+ZSYIAoXZNclWrl/SaVFlQeUzsk5M9OCQjdrj2VWc4q00KSGp7gkUmNQnjHcaRSEZLCpy5NpmeLPC4S8oFQccVYce9L1r4Pr8sAzLDqkOirdd15ZLtvBBSGWvRidTndd3c1mJZOYji7zkxkqYzF8cs1X0QUqkgEegVV5YdBZU8ij71UHjitfQKxk0onOKbEfwpzXXrQIqQWEOJAwS2d88eZgsNemBW0CtmBQgl7vnasIJUiASOtdwPU5A7EOtvXi/uZRsIv/2ZM0bILc5O8pLK;4:+h3rejq6KxBtGDpLmlPMXQ38TUJQUDAOwDvaCbWTEkpXYpvmbmbZM0LOb6eFKbCZwdlqDX1D6EFjXkrb5EHER4RwQ6YDD2eDqNdkklBHja2n0FMqCaw0hhShXtw75BNE1aI68Ra/UcFqQi2gTGW4RVqWNe2sg7qaMgKR6EK0GQW+PBtg7W2feoqSn6rgfy3X9rOD+AfySacKAAIxexBBVXfQeHAoLyLwHmP25voJpCsPw8lrDZWw7RL0+92ngCn6
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB380338E1AF5B64783743D84C809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:Ytmbbsc7haLEw/BI4KqKatPIDs6R/MPVIkzzWtP?=
 =?us-ascii?Q?a/ICJKr8wOgJldtymbGXJjZIc+1pA+eE++pzBG14Ru4jQTJEX/sKwq/HyQlU?=
 =?us-ascii?Q?PkbeMO2uE2jXsURR0LpgKFAe5MFwRwyghRCRDq9QD0bcnMhTS2AcKsz13Xw3?=
 =?us-ascii?Q?vCF5vl1lMp+Lq52OFfyFDFq3wdHz84UzC3wwVk6cf+4FLuGsIOUrTB+Pj/iy?=
 =?us-ascii?Q?jLlYcpXRS+zUqfM5sglKtQpEhp2BaB3s9u3kHjqAqiBYCNYKc6FwXmMquncV?=
 =?us-ascii?Q?VgBx6h6o2fBjQ2TrU/aX5Yicv3DwklEPA+8sIPIsqo1LqsTUBkzF7y7lJXKd?=
 =?us-ascii?Q?U/Q3E7f1ehQVnoZxuywe9U2XjX+IHyCy914BJx6VHw7Uok0YBQZxjADqEBZY?=
 =?us-ascii?Q?GKEbQU1FqhJZ5FK7bsP9hhVrHQSUHg5LLaHDabzV/eFkk7++LBhcdAfrCrfm?=
 =?us-ascii?Q?M9YjmdzpRa4EtYswaGSD1IscdfrDmsCR+rZorVRjYXSONXNLVJe5ADMRRQoq?=
 =?us-ascii?Q?NCEvJASpo5EA0SJxZHWARPNBwJ/QJouDW6ReVD3C8EmCIkl5zUWfzmUo0k0t?=
 =?us-ascii?Q?Fi6HNTGWLGaj0WkwFJhzb2Pkt2nDn8LebSKgTDtvB6Zikn5jLgH5aZTylnto?=
 =?us-ascii?Q?/vbgrtT21NYLhEqlI1xEC8hnmRBgzUWRORTKFCmrj67bUe+byxei5H/Y0pA6?=
 =?us-ascii?Q?NJFvo5NswDAJ+vlXTuyDa/jAx8S0ZnZ2ET0FifQoSC20AR8xvw8jTXTkKKhM?=
 =?us-ascii?Q?E9LZq6cyIkK4oCkiyQ3fJQRvZOWhWiXgFulv0quXR4e+7dMEtYWeJlhbC9oR?=
 =?us-ascii?Q?cOv1mlQFb37G5v4cGlAuRd+lhi1qw4eFdBVkjriUdtPUOFhpvdDMFhlSqvwZ?=
 =?us-ascii?Q?kbZAaVmrdBh9H86dUi5hPw4vDGY/THNAthiaAfebH4IeTS3IqIef2NiWT22V?=
 =?us-ascii?Q?RnzVG671PaJMtFkhQ6OIS/3L5UBT7g0NEDaIB40JC8wEEcHEDxsjunLmOX53?=
 =?us-ascii?Q?HMo0FrK/2jYzNeeMS0g9bIwDkLitYaqwPDcTQrc1x5XgM0Ab55DEsP6zVKW+?=
 =?us-ascii?Q?qS7n/HweSTsXld8aXrsAbNLYqo1QN8en4AtW6RsHUsdYUzNerWA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:F0Ej8za2z/STxayMunFarHQvjJ9du19spo7nGunm+KDKv4C8rZD2koXpcYL5aMLrpK5p8w6cSLNCf+/L/M96YM/hP7GcNzKSu5XXi46d9k56qRqv4BLf9XX2F42GLWFpXfjUAU7U89dhhC3v07nek3NLDadz8Fcx8XgeQy/DysnxcoFDl3BsDztauOVIuOgXEidCLO5IGn8W6NYbqxiJk2cYch0GrYKABmdTd+zknrxMZoXGiLeDq7W5JIUDk7yeq2F2zSctPZAvAykT+WPmHYPyxY55HznbPyol9M3dIjl9U2ClNtGJ0phjbrCChL7i37WvZVsqucSdXNRdJtWpIw==;5:bAB6KPcsK2pc6aw2NGstmP7tIRFLCnGDd4LAuyF4lad9MHFFDPzuhqWR5yc52VjvQDPS158qTvJuK/CqwttN2mKamzxNk2C6hPgwq9Rq87KxZEF/3oaIFXK75B2Mtbo2UYkytYKaLHlKOuUbT9cyAQ==;24:E8nssVPa1QTp2WSX3a1GGDSR5lVfquGXK8O4mycG6oySgvcUhRvEzgAy1sFfrdaK6N8L47N/lNByCkJoXISNa79rSs7KboLxCX0on3UuNBY=;7:3KrMOrx1uWgemU4qSai+rlFaOvmNNpShNi2hYerL/EPYsVlq+dl462gMHKqOGy5Crwxccm1Bx3W5v0+gLby/K7eMOLolOEAjmLo7nBPDvSgxdeqZZmIh7uRRHHymljuvSSb4ooKBWzFSw6kCk7+ApUOmmdiBnKAeDwWoA7MOR7HIm8D8oOpReYUE0E1UvO4fWzGP80pnWN6gwooMLUG4gtTXfAYf6nxVQbrS0V12Sqk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:43:00.3823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59874
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

* Update copyright and company name.
* Remove unused headers.
* Fix variable spelling and data type.
* Use octal values for module parameters.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/watchdog/octeon-wdt-main.c | 45 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index fbdd484..73b5102 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -1,7 +1,7 @@
 /*
  * Octeon Watchdog driver
  *
- * Copyright (C) 2007, 2008, 2009, 2010 Cavium Networks
+ * Copyright (C) 2007-2017 Cavium, Inc.
  *
  * Converted to use WATCHDOG_CORE by Aaro Koskinen <aaro.koskinen@iki.fi>.
  *
@@ -59,14 +59,9 @@
 #include <linux/interrupt.h>
 #include <linux/watchdog.h>
 #include <linux/cpumask.h>
-#include <linux/bitops.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
-#include <linux/smp.h>
-#include <linux/fs.h>
 #include <linux/irq.h>
 
 #include <asm/mipsregs.h>
@@ -85,7 +80,7 @@ static unsigned int max_timeout_sec;
 static unsigned int timeout_sec;
 
 /* Set to non-zero when userspace countdown mode active */
-static int do_coundown;
+static bool do_countdown;
 static unsigned int countdown_reset;
 static unsigned int per_cpu_countdown[NR_CPUS];
 
@@ -94,17 +89,22 @@ static cpumask_t irq_enabled_cpus;
 #define WD_TIMO 60			/* Default heartbeat = 60 seconds */
 
 static int heartbeat = WD_TIMO;
-module_param(heartbeat, int, S_IRUGO);
+module_param(heartbeat, int, 0444);
 MODULE_PARM_DESC(heartbeat,
 	"Watchdog heartbeat in seconds. (0 < heartbeat, default="
 				__MODULE_STRING(WD_TIMO) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
-module_param(nowayout, bool, S_IRUGO);
+module_param(nowayout, bool, 0444);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+static int disable;
+module_param(disable, int, 0444);
+MODULE_PARM_DESC(disable,
+	"Disable the watchdog entirely (default=0)");
+
 static struct cvmx_boot_vector_element *octeon_wdt_bootvector;
 
 void octeon_wdt_nmi_stage2(void);
@@ -140,7 +140,7 @@ static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
 	unsigned int core = cvmx_get_core_num();
 	int cpu = core2cpu(core);
 
-	if (do_coundown) {
+	if (do_countdown) {
 		if (per_cpu_countdown[cpu] > 0) {
 			/* We're alive, poke the watchdog */
 			cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
@@ -324,11 +324,14 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
 	int cpu;
 	int coreid;
 
+	if (disable)
+		return 0;
+
 	for_each_online_cpu(cpu) {
 		coreid = cpu2core(cpu);
 		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
 		per_cpu_countdown[cpu] = countdown_reset;
-		if ((countdown_reset || !do_coundown) &&
+		if ((countdown_reset || !do_countdown) &&
 		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
 			/* We have to enable the irq */
 			int irq = OCTEON_IRQ_WDOG0 + coreid;
@@ -378,6 +381,9 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
 
 	octeon_wdt_calc_parameters(t);
 
+	if (disable)
+		return 0;
+
 	for_each_online_cpu(cpu) {
 		coreid = cpu2core(cpu);
 		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
@@ -394,13 +400,13 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
 static int octeon_wdt_start(struct watchdog_device *wdog)
 {
 	octeon_wdt_ping(wdog);
-	do_coundown = 1;
+	do_countdown = 1;
 	return 0;
 }
 
 static int octeon_wdt_stop(struct watchdog_device *wdog)
 {
-	do_coundown = 0;
+	do_countdown = 0;
 	octeon_wdt_ping(wdog);
 	return 0;
 }
@@ -473,6 +479,11 @@ static int __init octeon_wdt_init(void)
 		return ret;
 	}
 
+	if (disable) {
+		pr_notice("disabled\n");
+		return 0;
+	}
+
 	cpumask_clear(&irq_enabled_cpus);
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
@@ -493,6 +504,10 @@ static int __init octeon_wdt_init(void)
 static void __exit octeon_wdt_cleanup(void)
 {
 	watchdog_unregister_device(&octeon_wdt);
+
+	if (disable)
+		return;
+
 	cpuhp_remove_state(octeon_wdt_online);
 
 	/*
@@ -503,7 +518,7 @@ static void __exit octeon_wdt_cleanup(void)
 }
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
-MODULE_DESCRIPTION("Cavium Networks Octeon Watchdog driver.");
+MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium Inc. OCTEON Watchdog driver.");
 module_init(octeon_wdt_init);
 module_exit(octeon_wdt_cleanup);
-- 
2.1.4
