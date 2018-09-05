Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:01:54 +0200 (CEST)
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:45312
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994646AbeIEQAVYBKcO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I61mbHHlUlGoVoPzMb9XVR/lf5x978gbN2xmfBkv6DA=;
 b=XuDESyFCB737aDe1l7oMk4YwEQOZrKum7nHgC+3EQbc3NMrqRd0EX7X+b2dtxQjMIsNidc4smS4Wg6hvzKWwGKI7lEv5mnDhidALRZuyN4U3wBlQyzgV1STaLDld6w2n9paYbAIl5KvOTyAIM2FPurgEoPW/8OUX17zE16+0pGI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 15:59:59 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 1/6] MIPS: Make play_dead() work for kexec
Date:   Wed,  5 Sep 2018 08:59:04 -0700
Message-Id: <20180905155909.30454-2-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905155909.30454-1-dzhu@wavecomp.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c89a8e8-128b-4fac-3335-08d61348a215
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:cmruDVRnLPSyYQHw9P2bd90n3pfXJ8Y6p5Fpu9K3ucQRyXF648aI2PDtakfNwORiA5QEEZKmmMNcG4JpTtA8gmaEw3jfGYilzJ50c9N+n5yxAY4yD2i7AdRvETYNKgUCFdR5LpiRZ/aNfPoKjMmm0GrEzJiNyUUo87d/opfi3rjCNefyEM0iidcwwX5oDKTcAXW+dKAbhtxEphjV+FFyOZyFNe1OZnbcHwOVlMYahHGb/0zvOQStalFb52iLBP+K;25:6uQkdhwgBKIUzkk8BjpGycY64jUE8Vt27iU1lJgXBKauKBP27G5csfJ9zcsiLsvJdGgpJ/qXM3MjzqMi2SIjAAQeghhBRCrGVHIwdU+5+UDr4N4LPbX2WU53dXSc2BWR+ERrYEGi0TTHEmxnBFgBmiggY7FvirXXYDTbaH03m2RICMRNI9kBKQXk2HqKBpr8yi2fZqlWxGnUh+x2mqxHonXyyjpIeQZ4YNGniwe7egTMY96YfP9c2WW9cr3JxLCQ+73qSHmHFwjhNWnAMc64i771fzVOqy8H7M7J7RVw8kVHzdWwV3kJFX/OsrmBMM4/EvN4AFl1aYrRFp0n4DfJKA==;31:2tgj1Tjr4I3ofYeLhiYw0ZWP/vaNGHNcInVMxoluKY/G7QvS0jlXdTPAS1XjyJqQcwZ0luzo5PlJ8V40O5wnYM5APsTVz2XwX+9sEBMEEVTn2vXkog1X9TDA8ivN+rgJ7mFR3Y3pnPVD7vCiQbFgGN6kMR9PH4dD+MEFeu5RhtWD6u94/dlxQK7dNAx1AIsxQaBV4QOQcddHHl89s7PPBzM/HXpi2WStiGY1GCwoDXQ=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:dE1x/uFSMicTkJLEHWm+gXNWS1C3UPBJf99SVR00QBf/3nNjssrPfJAIWlSG7BedzcOFUKJ6eos5EFeyki/VfRwmFLA1DiRrTbMdJlcyJu/XaGB7f0CkD+wIeGA1lGe+noSZY2iNhDkZbN++xz9v0SXxtjj4x5LbraG5S9gFcLiNIlb+3TFULQT/2G+iY/FD6oZasdM3sANvPcjE0k/5u3cdqPQVc6yD8hP3zmjqEezPBxo8aEyXiIo/qb1d8F/G;4:NDPkD+b/CBDFvMfeithEf0wttSTUALUPYFnsuz/S7qT8FUHR/J9khta85SpK97UxxHOuxsh8pck3i/wBxjOntqOiarX+3XZIijki4zUVG+vIfpmnOJ/OYQoyQdsiPV5hxQ10T8UagsAc3SbyW0Ir01TxaL+1/T+XWjO7IgAFQ+o5WKEuY/bUdhRZGLg/nG38gsCvU2GRC4IlYuIehA6IDcZ78RjEiNaTTAtt62cwEnZOuMCE+uXsBn93MRneTehKvp+pDDqOEtukf/mYDdIbutck+TA6VdQjCkhEcx8UEzgF2dXsoW/XQ08FVU6Q7g30
X-Microsoft-Antispam-PRVS: <BN3PR0801MB214559F7141F5A49B841CFC8A2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(11346002)(956004)(476003)(446003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(6666003)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(76176011)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(575784001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:cUWqZyKswkmb3XH1H1/ml697zl5cwd+LvD+V8Ec?=
 =?us-ascii?Q?4JS7aQU8j9RcWHKRu/a/G7I+qmNeTnVktF63dPHaxomqIxTaraJ3UTKZo0QX?=
 =?us-ascii?Q?I2Du1IjC3alhJvLxt7AZIR98VE6QpAaRMLFI6nWh6V8wI9tzFhwdN56rXJEa?=
 =?us-ascii?Q?bEdxgnncd74C4GiEkUXw7kerLc2YEmGU9zSp7P+oBuyhk9+6qhVtO9vm1jJb?=
 =?us-ascii?Q?FxZUkyZtlw/ymDpZSYUOsYGo/aOw7XmV3FUqMYECzhtF8QBN8bBeGCcIwVNy?=
 =?us-ascii?Q?2b3SY0/IJiwGR4KSx7wTtV9DRmbeK36yv+sXWrs8vu522iL2Vl+WhE49RnyT?=
 =?us-ascii?Q?+L615ek/Jcmjz3Ug2ndst5w6Zh2Iwo6PQmJeAqlcEpn4BgTUBcsfKp7diGuI?=
 =?us-ascii?Q?njV7JL1VDZPQchsEv8pKdFk4MCh/cejg34YceOpBD1wGzyKE9Y1QIo8oeM5H?=
 =?us-ascii?Q?qKRaRLh8zxk91Bg8yd1hSxJrQjXHvZTKo0ix1oehGzZ4jYkCTK6e8BzBPjMp?=
 =?us-ascii?Q?DWDCZcp3U1/Naw5I4M7L2u3iGYZU/YaoaZogCcXsGi+mfl6ZE7OGpvxoSnle?=
 =?us-ascii?Q?USF9qxiq/JDlHFGNoDqqgAdBPjzw2hXQP9bqJUPQEOjsAXcJao9HK69O3qrm?=
 =?us-ascii?Q?6HuofY+OOA45sjPFi07SWFaGWVuCWMqo4lxG0Mca7Dhld/rsOhuo1bDMyOqW?=
 =?us-ascii?Q?2LJB22uqdaYyxdwGKDxXINBQoZs8V5XuiwlaD7cBjwr6C/J5cwQApfDqobLX?=
 =?us-ascii?Q?NBx3qDD3vKvba1w6zN4LCVCS3x1m39ztwVpNV7m+/4qLR04ccvsXAkuuFugC?=
 =?us-ascii?Q?25+bi9aSSVXX4qMNK82FwK6nMUbegm3WXwDT7RLq9UD5KU+scdc/7Elgm8BZ?=
 =?us-ascii?Q?iOP0KEbMaCqisIVkNwiFpbdXqcbK8A6HxShQl0yXtt+qowznkbvhiu8ApdSC?=
 =?us-ascii?Q?23rUE17jaaP7kvPK6fEiUUyTWj4fn99hbri+QGVnFtMb01fnOVN8r3IkQolx?=
 =?us-ascii?Q?18D6xsiGacSOOjrKNOg6WT0XLw5xEH7lvrgYivw0KRROwyBlGL3AutojTU4i?=
 =?us-ascii?Q?Zd/1M3oNNgfR+jBANE2M5SQBBQqW+1xHIhKRV7Td1G3Mj4MrMryYBDYueDJ/?=
 =?us-ascii?Q?Be4QemNjxnTRPwv6PvVKwAw8evXkz4pAlvypfLZIVQM25q5JsIug4yknuuCi?=
 =?us-ascii?Q?dFKpNEtYZ2JkFfsbRJGiKjnUcGHrSdQSyUXi+peuNf+NmQyqOQTYYmF6MyqV?=
 =?us-ascii?Q?kScVhnKTft+PbhpDdsNrud8Ncq3eZiYbKYO6kkBap?=
X-Microsoft-Antispam-Message-Info: DXtGtETyxa+jatncbGqCZCn+BM86LMZtLDvYQLOx9HHoECTPw9e5vr8MXD3yHdTpXcyYsU3xdqWninDHOgQqU+JqGYGJz87yIU+Ne2GVcAcsSUp9mB+3O0ymGc2UijaTgH6UPmCV74Il+uTl27jf41aCMh6lwBg9WGk/VdsqqqvUYq3uLv070ju8IG2ilS2yjGnLfxYHTHlIk8MQPg/IuBVzghdfRIv6StPV1wwSAzhf1duSuE+MYRrXZTwowShN14fFza8iAhZF6EqxJSPmCSmKpDNHFuDTQ32/bMsg+DG56T10NaB0wYeMh8OHunS0qPU/RKeyR4O8MjRu2+nZoe1FW6wElbqPbswsAV97jqY=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:NbdaBZBbSilOs3gix2eLO78n9eB984iPj/1g7HX7XKp3lmzJyzBhaG0jG6m9nU0AwPf7MQdzn3q8qmNLAd1vMp+nzFrrBKYgM5XfieSZTlMxPQ9Db+1dfF94TTno2Pd1ZhHvap9psCuhpqgM2939Yn41R0JDPt4BQU4YDbXvGHs84OAHmhWkQvg/DIB32ZLJPMTuHk6l/FgBpvFYNDw80S9f3CQWaAuSy9LcSJQ7VNYNDngFtnlvgkiw94JehNN2TaQ+clFeJ2GP5zbVVh+QyluN8ndh70rAUMbe4lT9BmGHL+lGLmhq/+T9aH3zhgiooc2yYeva2b5og1kDIoPF3Vjyai1y2CG60BSWw+uurPe5/D4etOy/WFKAG4VgQQmvlRewe6LDrZohCFQLdGi6O8i+qGGj4zwDN9dGv4g3vTXMjZl01/rqxO76HVhSOlQFC9GqTdRskSM/aIkcvaaBSg==;5:+ypDMiH+moNpUSFRy8cqNTbS6nVw8gdP7Rs6Ock4zLaAYwm9TIZ+KaPHz1yQESC5vSRqHh8PZqxaOTyfAK9+ILojUy2XH9Ikp7R1Ia+u49cShwLq/XREisuC2XuL8b6UCXWKwddWlZxYUTBkK+9ZXooH/UFrMNvKKmTPVga0BDs=;7:5VcyRBnqMqOPYqUGcDII0+cxesYFAFJ0VCmNnBA7irBubQSXCTGTarGZsibM77iPTE+Ee9ktDpXvsSmRVHOZF/88haUqj0MOJL23doGQ58AJ5BPpxQjCx9A9H5+HU15C3KTWmalGySbaDtjwnvsfVt57pzIdyGFnE1IuDEqlVPNw+0k1LWeh33vCmpoLbPI+2kiVQPBtVrGyg+GRFfR4rQILX32XCUTOuFPB2O9Ld/9Vx9/A8q5AMqhPR/572QIA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 15:59:59.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c89a8e8-128b-4fac-3335-08d61348a215
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Extract play_dead() from CONFIG_HOTPLUG_CPU and share with CONFIG_KEXEC.
Meanwhile, move idle_task_exit() out to arch_cpu_idle_dead() because it's
not meant for kexec.

This is needed to correctly support SMP new kernel in kexec. Before doing
this, all non-crashing CPUs are waiting for the reboot signal
(kexec_ready_to_reboot) to jump to kexec_start_address in kexec_smp_wait(),
which creates some problems like incorrect CPU topology upon booting from
new UP kernel, sluggish performance in MT environment during and after
reboot, new SMP kernel not able to bring up secondary CPU etc.

It would make sense to let the new (SMP) kernel manage all CPUs, instead of
crashing CPU booting from reboot_code_buffer whereas others jumping to
kexec_start_address. To do this, play_dead() is well suitable for preparing
a boot environment for the new kernel.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* idle_task_exit() is moved out from play_dead() to its sole caller
  arch_cpu_idle_dead(). So no interface change of play_dead().

 arch/mips/cavium-octeon/smp.c         | 34 ++++++-----
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/process.c            |  2 +
 arch/mips/kernel/smp-bmips.c          |  8 ++-
 arch/mips/kernel/smp-cps.c            | 49 +++++++++-------
 arch/mips/loongson64/loongson-3/smp.c | 82 ++++++++++++++-------------
 6 files changed, 99 insertions(+), 80 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c8625659..19dea9622fe5 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -280,11 +280,29 @@ static void octeon_smp_finish(void)
 	local_irq_enable();
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 
 /* State of each CPU. */
 DEFINE_PER_CPU(int, cpu_state);
 
+void play_dead(void)
+{
+	int cpu = cpu_number_map(cvmx_get_core_num());
+
+	octeon_processor_boot = 0xff;
+	per_cpu(cpu_state, cpu) = CPU_DEAD;
+
+	/* make the change visible before going off */
+	mb();
+
+	while (1)	/* core will be reset here */
+		;
+}
+
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
+
+#ifdef CONFIG_HOTPLUG_CPU
+
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -343,20 +361,6 @@ static void octeon_cpu_die(unsigned int cpu)
 	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
 
-void play_dead(void)
-{
-	int cpu = cpu_number_map(cvmx_get_core_num());
-
-	idle_task_exit();
-	octeon_processor_boot = 0xff;
-	per_cpu(cpu_state, cpu) = CPU_DEAD;
-
-	mb();
-
-	while (1)	/* core will be reset here */
-		;
-}
-
 static void start_after_reset(void)
 {
 	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 88ebd83b3bf9..cad5e78889c0 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -77,8 +77,10 @@ static inline void __cpu_die(unsigned int cpu)
 
 	mp_ops->cpu_die(cpu);
 }
+#endif
 
-extern void play_dead(void);
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+void play_dead(void);
 #endif
 
 /*
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8d85046adcc8..8e5868362e55 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -14,6 +14,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/hotplug.h>
 #include <linux/tick.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -53,6 +54,7 @@
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
+	idle_task_exit();
 	play_dead();
 }
 #endif
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 159e83add4bb..284e49c8222f 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -381,10 +381,12 @@ static void bmips_cpu_die(unsigned int cpu)
 {
 }
 
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+
 void __ref play_dead(void)
 {
-	idle_task_exit();
-
 	/* flush data cache */
 	_dma_cache_wback_inv(0, ~0);
 
@@ -409,7 +411,7 @@ void __ref play_dead(void)
 	: : : "memory");
 }
 
-#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
 
 const struct plat_smp_ops bmips43xx_smp_ops = {
 	.smp_setup		= bmips_smp_setup,
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 03f1026ad148..2b0ab25109f9 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -398,27 +398,7 @@ static void cps_smp_finish(void)
 	local_irq_enable();
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-
-static int cps_cpu_disable(void)
-{
-	unsigned cpu = smp_processor_id();
-	struct core_boot_config *core_cfg;
-
-	if (!cpu)
-		return -EBUSY;
-
-	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
-		return -EINVAL;
-
-	core_cfg = &mips_cps_core_bootcfg[cpu_core(&current_cpu_data)];
-	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
-	smp_mb__after_atomic();
-	set_cpu_online(cpu, false);
-	calculate_cpu_foreign_map();
-
-	return 0;
-}
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 
 static unsigned cpu_death_sibling;
 static enum {
@@ -431,7 +411,7 @@ void play_dead(void)
 	unsigned int cpu, core, vpe_id;
 
 	local_irq_disable();
-	idle_task_exit();
+
 	cpu = smp_processor_id();
 	core = cpu_core(&cpu_data[cpu]);
 	cpu_death = CPU_DEATH_POWER;
@@ -480,6 +460,31 @@ void play_dead(void)
 	panic("Failed to offline CPU %u", cpu);
 }
 
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int cps_cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct core_boot_config *core_cfg;
+
+	if (!cpu)
+		return -EBUSY;
+
+	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
+		return -EINVAL;
+
+	core_cfg = &mips_cps_core_bootcfg[cpu_core(&current_cpu_data)];
+	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
+	/* make sure the change is perceived before setting offline */
+	smp_mb__after_atomic();
+	set_cpu_online(cpu, false);
+	calculate_cpu_foreign_map();
+
+	return 0;
+}
+
 static void wait_for_sibling_halt(void *ptr_cpu)
 {
 	unsigned cpu = (unsigned long)ptr_cpu;
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 8501109bb0f0..29628beed0f2 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -455,6 +455,48 @@ static void loongson3_cpu_die(unsigned int cpu)
 	mb();
 }
 
+static int loongson3_disable_clock(unsigned int cpu)
+{
+	u64 core_id = cpu_core(&cpu_data[cpu]);
+	u64 package_id = cpu_data[cpu].package;
+
+	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
+		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
+	} else {
+		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
+			LOONGSON_FREQCTRL(package_id) &=
+				~(1 << (core_id * 4 + 3));
+	}
+	return 0;
+}
+
+static int loongson3_enable_clock(unsigned int cpu)
+{
+	u64 core_id = cpu_core(&cpu_data[cpu]);
+	u64 package_id = cpu_data[cpu].package;
+
+	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
+		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
+	} else {
+		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
+			LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
+	}
+	return 0;
+}
+
+static int register_loongson3_notifier(void)
+{
+	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
+					 "mips/loongson:prepare",
+					 loongson3_enable_clock,
+					 loongson3_disable_clock);
+}
+early_initcall(register_loongson3_notifier);
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+
 /* To shutdown a core in Loongson 3, the target core should go to CKSEG1 and
  * flush all L1 entries at first. Then, another core (usually Core 0) can
  * safely disable the clock of the target core. loongson3_play_dead() is
@@ -674,7 +716,6 @@ void play_dead(void)
 	unsigned int cpu = smp_processor_id();
 	void (*play_dead_at_ckseg1)(int *);
 
-	idle_task_exit();
 	switch (read_c0_prid() & PRID_REV_MASK) {
 	case PRID_REV_LOONGSON3A_R1:
 	default:
@@ -697,44 +738,7 @@ void play_dead(void)
 	play_dead_at_ckseg1(state_addr);
 }
 
-static int loongson3_disable_clock(unsigned int cpu)
-{
-	uint64_t core_id = cpu_core(&cpu_data[cpu]);
-	uint64_t package_id = cpu_data[cpu].package;
-
-	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
-		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
-	} else {
-		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
-			LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
-	}
-	return 0;
-}
-
-static int loongson3_enable_clock(unsigned int cpu)
-{
-	uint64_t core_id = cpu_core(&cpu_data[cpu]);
-	uint64_t package_id = cpu_data[cpu].package;
-
-	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
-		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
-	} else {
-		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
-			LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
-	}
-	return 0;
-}
-
-static int register_loongson3_notifier(void)
-{
-	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
-					 "mips/loongson:prepare",
-					 loongson3_enable_clock,
-					 loongson3_disable_clock);
-}
-early_initcall(register_loongson3_notifier);
-
-#endif
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
 
 const struct plat_smp_ops loongson3_smp_ops = {
 	.send_ipi_single = loongson3_send_ipi_single,
-- 
2.17.1
