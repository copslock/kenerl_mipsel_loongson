Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 21:22:40 +0200 (CEST)
Received: from mail-eopbgr680122.outbound.protection.outlook.com ([40.107.68.122]:5440
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994585AbeGCTW0MiOuf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 21:22:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfNnp68cfXV9aNITNZrLHPArsk0IlG1WEEj0y2ckKGY=;
 b=iD9mjVttvH96wEeFIH1nFsj0uuvI9FIpaJAwfzVgswGV69k52trKdF2lj2fb70ollPv4xM9sOdw39beaQ/O4N/XIpmxgjDVQ8Ii0nLz6Ak8Y30JljF6IQ0na6rY7XSno5hSPQ4ysD08ENAjmOA4dn7WdfCyeBMoxQlHhSHy2+2Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2154.namprd08.prod.outlook.com (2a01:111:e400:c611::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 19:22:08 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH 1/4] MIPS: Make play_dead() work for kexec
Date:   Tue,  3 Jul 2018 12:21:44 -0700
Message-Id: <1530645707-30259-2-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
References: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0100.namprd06.prod.outlook.com
 (2603:10b6:4:3a::41) To CY1PR0801MB2154.namprd08.prod.outlook.com
 (2a01:111:e400:c611::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56562de4-4357-44de-4ba5-08d5e11a4533
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;3:GGGLdoCCvvV1f7FAx+H9HutNUMqc2Sjywz72+v5sVMEAcUSMzvnBPFYW+IyxNxJW3pEsQGTaxKEQI+27KW6n1eWg+HqEHdhSrrFzcPsWaOyZH9ynN7M+5OLdpUreH4YeM1Yx9/9JaACUb1waYzA0AB46KKRtyMHtFcOakWD8m57Obw0K8QHn+rFkdeL0nQL9LrOOlJ4zpJjoeaqAt6OhcjtrAs0fpD66xTfcDLERuMhBweQ7UzcJo2wrZ1QjAncV;25:zhCGXihLfVpHjJBe7Nily7ZEHyf+kobNiScLwz8t+Du2olZKcIktbAbMpxf+KnfrwzMsQUcvunBMEP/NVCw8k7m6ny3fTGAUytf/mCHutHwG++Cs+JNuDfkEgdF2NxqdH/f/DstOK4RU3mk3fimtxa4OCE5oqhf4BOdIOMl9j+iZqaCKXzjiYsHOZ3VqQFBmGGYregABCgVhEItJhs58jneK3e+dqpw/sSWScoaS8XMNKbuXJ5Ngs8fkD2jxk5yp1R390mZ57VD2wNrIY8lsFolkI7upqblGSsREbR+VJtshcx9UR/09AZly8O4D6HoSOYhSTmUeD2FejBGxRJR0oQ==;31:2oRcsSK8dgfg+PfChfEBoxF1qm3zApG9+m679Q4ULto1RnYZHLpW56Z7ErWZBgGhEm+vBIdbzsZDiZhyyPl0q8l4WamehXqoPDqbHSgoBMwVe7MgEpueAYH8Wecwgds/ruvlr9XBMCjCs04jfkTwnpf4CV76diOCVGqH3YsDlWloS7pmFwRjs8Jm+/m/vvARuWvKNzUxvN/PGtkxGpsAU4nfR53nwuweXyK13jJxzKg=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;20:WUUKZoeNhOZD/H31drLu+tyUgAhFgt3Tg5XVaw6veCD3ICUq6PnNxLF0xvabFlCjXR3gK+TAOiQ8HSwFs38n+c2T+Xh5RSK/k4nJQlSJX/bCA36qbiyyq9P/qRoFmm48DsgkwQko9/8AYqu9l5xzUXqgxQY7jBr9o8JqBkxi5iJ92YSNVVbF4jsZ15vAxCnk6xSdWFaDUxpscOMCXIy5zOALY5YvT7KQKLqPYxYiCAd1bpZNBRuhV8n5iwiU8Hbs;4:Kh6H50Oyt0zaIkIqCRsTKnnkccy372ho/800jMgOrf2HkmNwDJS9rwO5xKLriC5q+WS+31Wx/yqrtymQ9v1VKcEjbnZ53Y86ceCYRGRdmUSk86hbEu+nc4hzHOItM4q6wCZBMjqfldTZ0wZEnSFCkFwnx0BAQQ6r8qmbcSmnpYXE41aoyMyi/nUtBwQtpMfrmlvSRvFZJTqh1mDetDR3OrJGJQVdmA0oGu4QechDVC4pey6IAknBYEvTiXxJ2M1pmUz0asp3jEnRTk6cJDhb5A==
X-Microsoft-Antispam-PRVS: <CY1PR0801MB21541B85119AE3D8360887D0A2420@CY1PR0801MB2154.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR0801MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2154;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(376002)(366004)(199004)(189003)(476003)(68736007)(478600001)(81156014)(81166006)(8676002)(97736004)(305945005)(486006)(11346002)(6116002)(3846002)(446003)(956004)(8936002)(69596002)(6512007)(2906002)(86362001)(2616005)(316002)(16586007)(6486002)(25786009)(6506007)(66066001)(50226002)(4326008)(53936002)(47776003)(107886003)(450100002)(53416004)(5660300001)(51416003)(52116002)(105586002)(7736002)(37156001)(386003)(16526019)(26005)(36756003)(106356001)(50466002)(6666003)(76176011)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2154;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2154;23:QuweWhVjdaw/t/C7YlZBkpBgT93TUouQNJ+L/78?=
 =?us-ascii?Q?JbbyxuKtFw37fZy1oUtveTtAMwRMSsK32hyRvGdf7pHOZJmgRP/VSxySmGVN?=
 =?us-ascii?Q?OKrSt0ebSLCkZBO2qUuqssqNijnnHl7A/SD96LUJ4rYiHMR8TQM7wUadzqSj?=
 =?us-ascii?Q?qFLh2396b2wlNhfgwq7HKLx889EHuPM7/ooY3RCAO/iOM58xHRCiTwDgog+W?=
 =?us-ascii?Q?uwT2ZeZ+3YqwnX7ndmL45lVJiNi7NIknswBTgTnVoEsAk+suBNFIz+QWyuPy?=
 =?us-ascii?Q?d0TuzLnAJiyaGIFUsbypys21F5riNMOMPjt8dLPe3NgUVnmxqmEaylXtQEV1?=
 =?us-ascii?Q?v9GnnL7J/pJXnisOfyWqYgmVgRXaVVRZwPnQ/HCKP7zKpHHOigRNkAG+bZBt?=
 =?us-ascii?Q?7vR5eK6sI6hv7K0Lgoq6lMpzXsEsPqvaOgDmoyxS9J/Lm2K0mUB/GL+0/Nux?=
 =?us-ascii?Q?jBewWjSloFmXwhrboXvOFol6XRHE/0Co2RDdh836bc3c/i5b9SKVAfo4/Ydv?=
 =?us-ascii?Q?RTKBuAQF8cS0SE2OSdvVyA3wTeTkKRboUZMmyZGGpGHPL7SuB775/t2uT7fD?=
 =?us-ascii?Q?Ws4xiAiLS1c9OmzGWCVhpOwQQ2ttrx5z/7bzF77yen7hSCSEie/8hFEcdLk6?=
 =?us-ascii?Q?UNFPrDd8cl4rExDjRAta8DYYdfupcN9dpLr+4gkm31GIJBwaugz123i4HVz5?=
 =?us-ascii?Q?sL9gaSd9q9fZ5Yxf22cVsot6K2bQV5giCsJmbwgNm9ru6xa43jubXavBpOqB?=
 =?us-ascii?Q?uSOUEJv9uo5vw5VVj7cS/slEQieznmUOVFP008YWRQsmlWcR7THoaDBRMNMR?=
 =?us-ascii?Q?WSZoP+ZUQYWntNBG8xVLlr2ctKUzo0H82tzy9bZU+rf42zY8EbZlIChQDkkB?=
 =?us-ascii?Q?ebtDORMQwdQ+6YrBQISAvgqedFbVtG3hO5mkB3fPpPjTBd2S2LgHZ0H/vrPa?=
 =?us-ascii?Q?TLvZBcWpqXCjoLHHtMRAwjdn2geC6QKKPTN6moegXMt6dxFsnEL4V/zZRDBS?=
 =?us-ascii?Q?5uDP6RsCqBfJyHIRw2HA+4QG5LfSu5VFagE90F7NjSS8DeQSBmwlJ7e3ldh2?=
 =?us-ascii?Q?8k0lctBij32iWJoMqYog/gbB3/NO2s5BSPaQHbf6YW9uv5+wacG83NQTJiLK?=
 =?us-ascii?Q?YzzF971JF++YYpmMd8CoCz410HNBPIaZKZ0rtxs4lJenug6iS0rumLNbxWbD?=
 =?us-ascii?Q?1YbKUAXOcbP856AoJhmRlrOs9oWD6cUAGbHzzS12FNuHwyv4L8TQbcuzipHU?=
 =?us-ascii?Q?q7gkpFhLigcjtJQsdEEE=3D?=
X-Microsoft-Antispam-Message-Info: ZQpa11tyQSKnwc4+d59nE+9hFTBJhz6VjKaIHGF0FZqJQJVOJR1eVkmB7MU1dA7jdh9+QpZLc7UckOeVW/dvB6E30dtgWOv96ubWX6+9zVaZQohcwni/IOVrskD2+L+Nl+RkXEE70OxSdXyNK+CpzVq7YSEbsjm6I2IHChsvUD/+9PN25NzVbeBKdcfXssftKHdAMrrhsB3ZeuuUrqS2PQZskH31ZKhy5r0eYBRoT6XrNeMZLdiNSMzTh5/d9wuWi8kErV7tgtSR3A6J5q+XUDwXB4aSHHlaPYcXMuYGQF1dZSBtbLEdv9tErLgM3MzbNIJWTySULbQRqHB5X2cy+ahBSSYV6tjhpEh5dvpZvns=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;6:FF6lbreoaXKqmk0zNJnrA+R+GckWrw+XTknhwIXVGGnuWl7m0cqXvfGPccYHpCB2PmVJ05ZQgZLVpO15REehvzisjG8BFHjPs9UeowNcOxMVxQAHcALkEVoHHaExFaYQNLINkA7HU6IIFam/XFSqtSIDM1GW+GjvzXVMhY3FGzeyCcJ1qp4B6V2iseGpHnWb9lwnBYVFyyVoUro/hUZUP5bU9iS3hdtHxMQa3bi0psJEs8sEy1W19tjbiprgAgUZCIAJlLymJjcKVyvQhL0FdRjOVozl4GNd2N9Bx0zfWbxlU0SWbxDrhWs0j2atVzEgLLqK+IEqgVwBTUJ/VNqN1g8nYpuGRhTsx5xs/TfRwi60i7ECJ0k1elLnEbnuJk3ggOOS99bhOHhPUiHMIzyIXGGupHOWj3Dj96E8HvC7IWkM96x4eTcIzX/VwLutGgGF8nxOsZTd9X+a3lKQDESilw==;5:WcCCZ9MdMiNKylJaiA+2sZpkAqWfsHaRoeFYMieQyetmtEW0GJun+oJ5B+PmjaD0uR5G1ja1R4e0xbncjAAuGWGh20GLzXaho2irOBoQYbXK5Xnhsqbf2Tzadfcit0BYVuNdkiBcZ12NjnWK38IpHrwTUrmXxWc/ulN0ebXvRaE=;24:FYEVx2xYYAwfZa+IjW/02elKcMxW+mVJ2csoaNBmzrtL9ymXtc+x/jlABzpZU9yOD/oohMiAQwyknaeuE4JHjNa9S5QwLRMhlb0+RmH37E0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;7:kwmA0EF3KzWE9PsAGtDhVFSFP62zQIxjWZoGC6bXkCLJ4omdijo+ZpzT0+m4glBhBixjAg7/StbPTwAis4dbeoM0gRyYBDE76oxiixCpp7o36tqjjiMuC2+BqO0mlrCwLVgh9CFw1IYlukpjabRtb+7N5MtjQCTpWsNbZFl46LoAt5bRbYfodC4ymp23FbgwzB+XWqMmuPdEW6JYjCmJnXeX/TzFtOWFxjsVZWcY18dOkPc1J0uMkwzr1wOyWGk2
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:22:08.5479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56562de4-4357-44de-4ba5-08d5e11a4533
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2154
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64585
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
Also, add one parameter to it to avoid doing unnecessary things in the case
of kexec.

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

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/cavium-octeon/smp.c         | 35 ++++++++-------
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/process.c            |  2 +-
 arch/mips/kernel/smp-bmips.c          | 11 +++--
 arch/mips/kernel/smp-cps.c            | 59 ++++++++++++++----------
 arch/mips/loongson64/loongson-3/smp.c | 85 ++++++++++++++++++-----------------
 6 files changed, 112 insertions(+), 84 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c86..31150a8 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -280,11 +280,30 @@ static void octeon_smp_finish(void)
 	local_irq_enable();
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
 
 /* State of each CPU. */
 DEFINE_PER_CPU(int, cpu_state);
 
+void play_dead(bool kexec)
+{
+	int cpu = cpu_number_map(cvmx_get_core_num());
+
+	if (!kexec)
+		idle_task_exit();
+	octeon_processor_boot = 0xff;
+	per_cpu(cpu_state, cpu) = CPU_DEAD;
+
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
@@ -343,20 +362,6 @@ static void octeon_cpu_die(unsigned int cpu)
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
index 88ebd83..3176053 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -77,8 +77,10 @@ static inline void __cpu_die(unsigned int cpu)
 
 	mp_ops->cpu_die(cpu);
 }
+#endif
 
-extern void play_dead(void);
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+extern void play_dead(bool kexec);
 #endif
 
 /*
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 8d85046..1aa24bb 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -53,7 +53,7 @@
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
-	play_dead();
+	play_dead(false);
 }
 #endif
 
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 159e83a..e1c11bd 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -381,9 +381,14 @@ static void bmips_cpu_die(unsigned int cpu)
 {
 }
 
-void __ref play_dead(void)
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+
+void __ref play_dead(bool kexec)
 {
-	idle_task_exit();
+	if (!kexec)
+		idle_task_exit();
 
 	/* flush data cache */
 	_dma_cache_wback_inv(0, ~0);
@@ -409,7 +414,7 @@ void __ref play_dead(void)
 	: : : "memory");
 }
 
-#endif /* CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
 
 const struct plat_smp_ops bmips43xx_smp_ops = {
 	.smp_setup		= bmips_smp_setup,
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 03f1026..4615702 100644
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
@@ -426,12 +406,18 @@ static enum {
 	CPU_DEATH_POWER,
 } cpu_death;
 
-void play_dead(void)
+void play_dead(bool kexec)
 {
 	unsigned int cpu, core, vpe_id;
 
 	local_irq_disable();
-	idle_task_exit();
+	/*
+	 * Don't bother dealing with idle task's mm as we are executing the
+	 * new kernel.
+	 */
+	if (!kexec)
+		idle_task_exit();
+
 	cpu = smp_processor_id();
 	core = cpu_core(&cpu_data[cpu]);
 	cpu_death = CPU_DEATH_POWER;
@@ -454,7 +440,8 @@ void play_dead(void)
 	}
 
 	/* This CPU has chosen its way out */
-	(void)cpu_report_death();
+	if (!kexec)
+		(void)cpu_report_death();
 
 	if (cpu_death == CPU_DEATH_HALT) {
 		vpe_id = cpu_vpe_id(&cpu_data[cpu]);
@@ -480,6 +467,30 @@ void play_dead(void)
 	panic("Failed to offline CPU %u", cpu);
 }
 
+#endif /* CONFIG_HOTPLUG_CPU || CONFIG_KEXEC */
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int cps_cpu_disable(void)
+{
+	unsigned cpu = smp_processor_id();
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
index 8501109..d426ce2 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -455,6 +455,47 @@ static void loongson3_cpu_die(unsigned int cpu)
 	mb();
 }
 
+static int loongson3_disable_clock(unsigned int cpu)
+{
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
+	uint64_t package_id = cpu_data[cpu].package;
+
+	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
+		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
+	} else {
+		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
+			LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
+	}
+	return 0;
+}
+
+static int loongson3_enable_clock(unsigned int cpu)
+{
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
+	uint64_t package_id = cpu_data[cpu].package;
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
@@ -668,13 +709,14 @@ static void loongson3b_play_dead(int *state_addr)
 		: "a1");
 }
 
-void play_dead(void)
+void play_dead(bool kexec)
 {
 	int *state_addr;
 	unsigned int cpu = smp_processor_id();
 	void (*play_dead_at_ckseg1)(int *);
 
-	idle_task_exit();
+	if (!kexec)
+		idle_task_exit();
 	switch (read_c0_prid() & PRID_REV_MASK) {
 	case PRID_REV_LOONGSON3A_R1:
 	default:
@@ -697,44 +739,7 @@ void play_dead(void)
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
2.7.4
