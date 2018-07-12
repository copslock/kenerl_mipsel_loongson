Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:29:53 +0200 (CEST)
Received: from mail-eopbgr730125.outbound.protection.outlook.com ([40.107.73.125]:9107
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994002AbeGLB2Z3KQXt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfNnp68cfXV9aNITNZrLHPArsk0IlG1WEEj0y2ckKGY=;
 b=RNIjnIKEGO+c4zuvhC+LvpKp1CNc/Ug30aG+Nwf2Ol8kC4Z/edTC+sMjWB88CRkSaAHces8P52DcaSVoP01h9TBKJ/VLS1zssy8up4ViW8+rzljD/TmriW4ook3i8o8xank+Mk8bvsPpi0brcubFNKpSOu/iWWn+UWc1brAJlYk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:10 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 1/6] MIPS: Make play_dead() work for kexec
Date:   Wed, 11 Jul 2018 18:27:43 -0700
Message-Id: <1531358868-10101-2-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [73.162.151.67]
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f279bf-5063-431d-eb19-08d5e796bb01
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:vwrMpZ+D7AC1XNU6NQ9APBj/AdJGDI1Mf/YFegieXDARlyBBxGuNGF5N1rHbG9ynf3BNKNx0fe6l47erHeLZbYgMzM6SJQO/RI6mp3VvRus2OhmCj53v8yhAP+n7A//KCseTad8pvmATvXb22pfP6Sw3C9bCWJF8mvsBZ3I1E4h1GFUiuCZsl1LAPJwAJnFhBqXy+r0LYkOBP4VhmqP6NKWR9kjEvh5BebONRVEvgVVXgX/vvWr6NgGHS2ciULEC;25:KJnSk887UrBaUnGnGuMDbNjJ/Fnj4DruoBxO9JRhNiocrhBdM60+OEU3bOFFhZ36bwDKO7W6aCey9hKDL3dyfRzguObOs1N7uMTergTT7HjTpk4Nkjt9Jaxr5M3YICfEUUN2wPH+K+wOUVKxPeFBZABllWWZDpO4Bd6kAKU0HLm/rv5AfC10OT8i36GdntS+BtSAApG6j/B/FHPURijYYthWRpcrdspqf5nVT6nYRNzkyEODphKEmFkkaWuA8w9GB8uhCnlTcuxslU4pvy86MK9I8XqTsAs691eSgHFbzVP/qwWrR70BGeipuBD34xQ++krQ74j1swg8IZVLEbU00g==;31:8MCtN7Roi8O9gRo76EBNsrVoydUdTFbjj0bFxacFHjWI/FgLckONCZoc3DW4SOaggqi0XC1x5A8irQnpZsSN05ZdZyymG7zIg6qZq11HNM/Y+9XgnfBcvHRsYmV2p9abl0BSvQKu4R3zD7p1f9I7JoJf51F9eZQRVo7thzwCzcKKqtk6kA0O0C/w5cIXPEy0N5iDgSaRb8Oeh5vOO8/4Fj1h9L68PXiYUg0+fSz/TaQ=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:sp/cYzn62kLTLk+SlWDvi5rJ04USVaOZdxXBQrp53idXVJgETvMEuX88dDhD+d3vJozU0UbytEozHN6WCDKpqQMTMijXc4VJHoRVLoC7RDhtmg+Sr9575SS2ofhJQgRQnG0rED2KPXZX1b3EVEamz7gzCO+Dm/84mxXmA83HxC7eQ1/JEZ5JFtSIvklzSIcFif1qylg16TBr+lAyoPG3yBksE/vz25bK7GK6MSN3e85RdVpvdSSjt7S0okafK5MG;4:fFf7sWpfRfoWfybD1hM4oGp2Y/FOup4PwP8G8T1ZebFNkhDyYBsDWF59M1hwbmCxoS8dKd96o4TLHZmtOv4jf0mu5nPZQ2UN3kDFqPSaCzrhr6Knz0+V16pKzcTzhdldZqijb1J7XiAZmkjcp+TYFuEOY9KynHoXjBK9f7mPStS2J6YG9E7ReWe//DEYnl8izuRhyAQERHthrGiBoK3hleYxM+TPjsqikLmPfnNbaum4N8nCXBxPeDpUe8jFbyv+UE49mZVtE58yTFTLmS+gNw==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB2151F6656FB9A4D530A303F8A2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(446003)(486006)(11346002)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(76176011)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:UTCcZhsmdHggnhGTp1XOpdfcXELs2sGdoUQ/mg/?=
 =?us-ascii?Q?sv8S1SfSKi5vOQBs1RWysDIdcJJ2tPBqZPzI++urOpHCP6t34VkYbKlxBnMx?=
 =?us-ascii?Q?SkfcbEY3iYBJct4Pr5DuSsQTkvWnobapHPlVkxjj22VEjK9JYKWm+A7s6yAe?=
 =?us-ascii?Q?wWhB7/2dXb7LZLzTpXaYz1SRg4EVRGJYpylj5OpWiPqBnxTC6UnTlqwIBhEa?=
 =?us-ascii?Q?wxhSPUdq6NGM7ygkXSQSXSzG41AO33hjAoGT40WIqOznLFAptDUXXNVDq6B6?=
 =?us-ascii?Q?ji2bNp9d7H2D+JksOK9/+W8FP3/KCaiCq4Em8kV2OcYYB3rBezT7xhRmvn2o?=
 =?us-ascii?Q?2VV13/f67hncNAeVAWa0MJEvzdgG8Sr4Xgu5DbS9bjUsLdcQVJ67YaQHsCr6?=
 =?us-ascii?Q?FeRP7kDfBXBiw8kpACQirStAZQPBbiwEydfVt9TBRlNybG98WSCW5h++Do5x?=
 =?us-ascii?Q?JAxEFfAS1Z7m1dEl95p5JTU77icZBgjGeAGiJc562ekpiLXr/ovJPu1GYqjl?=
 =?us-ascii?Q?SpjTGUOd/qL2iqvUi5NKzLgJADGHxT7wXtce0W0AC0GtWtV9ZGveW7aXl41+?=
 =?us-ascii?Q?VWlt2DFJSt8sOfuz4t7PdlAMw9uKwHXit0iGVM+gF/LNjFRBPspcsdRCoaj5?=
 =?us-ascii?Q?lbC0RzCsUkaoC3PYI0zYvVvt/CUVn6+d7m4Dd/eahSecz9Y+FLJ8dSkLK8lr?=
 =?us-ascii?Q?y7cgIqPZOiUAVZrcIbl377M9KxcGuyEV0mH2evZw6q31FBYCQUaLUadQD+2t?=
 =?us-ascii?Q?6VIXES5ppaOciZ0zzjPwOEo1mp/K/gD9SAU6cIKxJHMxTAh2TuPWzO8PtG1t?=
 =?us-ascii?Q?+s6/LR/f6p8X7XyB9cXXS3e2/DYZhZYTIgfNa3bf1pIX++EdfWK7BQg7NLtj?=
 =?us-ascii?Q?soB1muhoJ+bw4zahbUV3ZwQt4C4lSjy8wnuXL62qJvQFAtVQm5kOxQN3huAG?=
 =?us-ascii?Q?E+oUeFkPxrUUiU3HTsai5oam5jOneUa56LV7JUezSHTzDxpaH1skF/HSgblf?=
 =?us-ascii?Q?cZIIZ+LPjCwYWKLS70oUV3J4ZWjbXyB8l+D4UuuBvt5zPcM6PtONTHc/COQE?=
 =?us-ascii?Q?fRRvNL5wlUpgUjDkx6J/xbQlohAuhLGiVIOo4dsulDTFbmBhXxo8eg3wz6xO?=
 =?us-ascii?Q?a44TaDt0SN2VUrly8dzV8x5ToCTj01YmNFDfZy5kmtDJU3Dr4JES6ro8/i52?=
 =?us-ascii?Q?ZpbNcOKMOmq8qkKl/6gsQCqGHjaRMsifw8agI?=
X-Microsoft-Antispam-Message-Info: gBj+Gjjb6ycdM1hlQBKtJAAiXGgk+jni4CR554Ii4cU8imx3HNhfVxW7qKowAJWFnuVGa07e98TUbJSH3f/vIx7smZaP5qaAPiM4tXZx1u+hy4tLm4rMuzPJ/QcDUqdcFDU55mzCcvlD2+OdKjkME3UZA309eWM1BWJXVAb8TScig3qx8czz+HjkLLQawq0SZzLoxdSQ9ScRMPmWF4kKeTO01c0GBa304knRFuemYhtJpZ+Yi7jVsTc0fn0KR6HZMGu1CqyPNx+YojAvRSLhdnAcFTeT0JOSyfz8ZmGtOY/RJwmYpCBNwXZSpHQmtjIB+F7Mj1dvNTC+XEpqxA0031xVOGC0vUIzfreV3g5lqlQ=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:hO8rh5fsiCD0uDLEIwgjb/e56E/fzBh+y/85F+23Y9zP7kRUz91PY/owNagC/3PFt9m5bjDVyq283tR6RcV8Xpj3EYzlmF6ngUvLknp8xgtGMi2zefg4cfJtCz0//r7vkaOlz7kG5BDY4hYywlWAy2i79gQu8EpugzAO/Wb8WDmPtrufXs6OupiJbYXHjVGZxSo6nJsHlG6ckkHcKcpVaXQttgJzHUK9a+Gtm4P/xMAeC6eSrOF/ibVxPObUdZFd9fKTvtpMGWQiMdbaOijL01EHoCA6KzTl5aB/mRRJmY2rUZRNgry4ckcA5C4hxg3ls6T2Ok+QlKDxVnw8uE97s+N2TQkBRz9j+1W1rh1ezZnYiOGvqwCZGB96of8PxH6Y8HOxN12alh6X3FUOq1GlTb1w48kjCuuBMFP0iF12wQO+hGgTRR1k+bUScdVgMbOxpZGXttAqoeJngKZyLOA9YQ==;5:+5lUXuxyIt1v4kP+xf02fMnjeeFxGqJKKZQct9fWlzqN4E8+8QDJcZbEZFEhob79WP86R/Xm27qfd1UPmSghfBxlF3P4sv+xWY9V4DURadKKtrtV31bkgZjo/+AFt8bI76MnOFiPifZ9IHhuyme4qQD72sh4+K95YLvuYHEAnMo=;24:Isbg8bzTPNcNPFH+wOzOuWJFtdO3gsUud6yojGyIU1yU3htEiQbwYvGIgCe9j80Lo1ANqckD1VTjsvqnWte3V9lsWPthnNefFMmXZJyMR0w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:DytWsCBmgjefb1pJotvvU1EsnT6ZH7dy+A/8dP9Q6ysTMyVW0hh949ApVbR6IHfKMacz7g354YTEn6NMw1OBVt6k6LZkYV40yx25ofqBvsu9X91+V7NKAJfrxlZ7JtI7KhwIgDvKkgCUgkY/Tr9hhdry1k7VmzCWzj2H3Hh6mJpgd3IbmGgsC9XMr8SrNs1A4JOdzwV6pJjJr7C385UwjChmbGvR46/p0To86i5co7C2vWoRAA9i4gm6rQ+ckTEY
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:10.8977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f279bf-5063-431d-eb19-08d5e796bb01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64815
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
