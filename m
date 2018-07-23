Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:50:06 +0200 (CEST)
Received: from mail-eopbgr700115.outbound.protection.outlook.com ([40.107.70.115]:35584
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993964AbeGWOsqOTkbn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nukfrWdXh83lKRbym2k8Q0B6gLVszuz5eduODgQ4ZRo=;
 b=CwfHK2cpnm6qepzVm+sDaXqi3gUykEoJNeFEW6D4JUZcV7sVCP1fY64WkhjOcUc3znbndIS0R9Dltoyls4rZMz4u27eV9Zyc2ELcOJw5Oyh+Cf+0gKab3D1ZuONjmULalI8jFhpxbjjzM2ymJRfEWFVgSvmuKzD5OyEVs2nd1EE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:32 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 1/6] MIPS: Make play_dead() work for kexec
Date:   Mon, 23 Jul 2018 07:48:14 -0700
Message-Id: <1532357299-8063-2-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5536708-4e09-4a78-fea8-08d5f0ab5ca4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:wxaglJzDm9V++fsMU5N8BohZ7XHVyNcrNv4w3or7WVjqG73okWAVvPmZc1glK1PEADlNSmhUGCXKvXHp+NavRSNLbQ5EayrZH/JCtd0Vsqk7NJ0c9HRNMjKMqU5J98F/dKS9nua51BVjLiwWVNYzti4yKdzVaVxtkUKFSxjCnRAaoMYG/HTA91NCk9v3qaIlUTxlIsuSqRqvE1GTyw+12QPJ8bww4LFs2mkpcJEUogtglexgTnAy3S9NQPp8y2sG;25:QHzVFzaSritVvQUK8rrMexeRYbwVERuJ46CxsIjfcT+/3eslbD8mLwm6QKfPX3CIHlt5xWjQLnkCz4xqE1jvkfHa9NR2Uk5dcWQEU6OCYuEq4b7CGp/mMIsjxO/s4LINASpst0uNSnAxOg8+0Y9YfVH5cQhkIEsjxjJeJgLLAvrXTRDUQ0i//+gQVJFfmjIG/44b2La1lHf/K53nY7csNVyeQ8u1MXSRUOjzIyFSF6XXT3/Ho8oTh6aTvFGbSRhwl1PZDZU7GHDT5V10BXSxmhid3uO39KAcSYyvJXf20XLM8SHgfMllMnXO9vYtscgRuMku2aHoqS6TlQ+V0fj2Hw==;31:bGa7S4y5pHqFvSgZBdhPvMcBPjq81PqE0IONqhwiVYX8cfqA6ZkzGbh07InYm7SGJd3alwImQfLNvm0r6XxjmQUz/8Km06iePd4xXy7gqcet/9t0dsu7NQAdVW/5svcToLK5+xuhwRAwqjoqZf0cm5Ngbu1FC3HEsnKXWom652PH7Y4X284js4Td1QtA5vKuCT3bVfXavDBzDE7mbXIP7EtnQhuK4oQA2Ap2RET3rRQ=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:rFr3cHwy6WcTTOUkXtWdD+IMpIaYnTbDHbYsbPkRt6IIr7g9uhq67xtI94qyDf71/bwxviPbk+BafmAi0ZEtpRGJsMjAqpjheTylLfxaaAKs6HNnNdzI2e9SZsamDdKkhITLQpEzr0erEpT9RY3/VC/ekSuIQPXc8uwcX75Pd/fqXk5TyhmOSLzZqGSak6GDOcGH2nTqNjd3pByUXVMgNXWjy00nvlZ/e4H7TzHZVjcu6sp98SLy+v3pSB5Nbjyd;4:EdH1ih+/zxYYTvib4bjlW5ezyZfx1WnmVj9cmX4/hQ1iZTy3PODC8JnilRu/y7+epU48zV4uZg0qHsiXBpu/iJOy/pxe6InkyAwk9SU+TYgoLkhj3O2Wod2CVMX+Ne1Jeb4v6cM4+B8Z1baYoCKf+7DoVpLhVFr4bvYRTET2MpLbUbn/oO40rF+EyVDA4yPBFyZgncBBDeO7av7O3m5Y3sXntn8RyQjYMPLEuvum1ABn4tdxbEchdVN6evisZjUZfKjn12C69q7onys+5uocf4qDnpO/6o4xa6CRVgGfI3zKQWKKR7nzTnMHrTWxI2M4
X-Microsoft-Antispam-PRVS: <CY1PR0801MB2155ED771112F57A203B171BA2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(575784001)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(76176011)(107886003)(4326008)(446003)(11346002)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:p7CTKAyloWr5oW16bPpcE4KUv+OyEUEGmagjE6X?=
 =?us-ascii?Q?dYq4WYuI4Pf2WwvPSZdErfLPj6xMBH8ESRlMyqzJY7nk17y4BvXPgFP0uq+O?=
 =?us-ascii?Q?2ArjUfjkdnrKkGB5tD2AvX84Ha3OkukCTuiOHZ9fTgzbFmm0aVdMnJMsu/gw?=
 =?us-ascii?Q?+ebsst3LbrP/cyuoWscYRJGP9muOSnrvUu6EgesOEtLRBKUr5ehkV0JuAxTq?=
 =?us-ascii?Q?0j6Ac95fjUg1uHIx2vz2PL3BrYgs2PL5ujKbP4ET96ixVnso6g4Zn3xMkKmI?=
 =?us-ascii?Q?SoRaCM9rzscWu8jsOHhn261Qv0G7qcc3ilsHHT5J/gXuKs0CXEpVCbES8EzV?=
 =?us-ascii?Q?OH9xY6SaHd9gXc6k/mC+lzDVn4lZuK2K6eqngH8L3T95ihKwuRp9U9ZFMnRH?=
 =?us-ascii?Q?XJ1o85bcJ3ANhkm7emIFjWXPDKECSRz9Whl1GHmEZ9CKVGm13S5/30jGCkOU?=
 =?us-ascii?Q?Zr5ScU9xJA2JYVqvaq4zSn5JlH0fF2mv2Um4VUSsCFlgJIqYlvC+9xPCP9aG?=
 =?us-ascii?Q?tANVdXZr8OnBpqYuPQ7xJVLKos05PVFQFgetU2eVTuxmitZpTUQBugsJ11ie?=
 =?us-ascii?Q?DguipL7uzGbFtM/g0BIAFFcIKre28y9eFyj4/6/NJSHF3Hzt3cuDVoZNNU1H?=
 =?us-ascii?Q?JIERcKSsLsKJ1uc8Aw7RmC+No7Qsy3WAmsWgM7SHqPbo0sj0Ty6hABO79Cna?=
 =?us-ascii?Q?6KNwszK2Ufv67y+3RGG04wGc0VnEI57KGR+VHVlxYMEiNebvQB172QfF28cc?=
 =?us-ascii?Q?9d9AYZ/dLYzZniixHfb9BXvfaQdqJp7LotkUnWivVTHZKDdD4mDTRbLxMj4m?=
 =?us-ascii?Q?NupkrSMdcdiqLL4TSftnKPliV118hj/XeRaBadnaV3JAGeJwp2FPPFTcDqYA?=
 =?us-ascii?Q?SwS0jRqTEmRR6DOgVIUfHkZUCL8yZ3Fq7DKWTKKvSwNXv0XIGQHkW/1Fa3vH?=
 =?us-ascii?Q?WjTlrvVJtHoh3B4JG9+Vt/rO/czCldCrHOc1RIENovMr7+qfNH1szDMInvi0?=
 =?us-ascii?Q?oY1mf0ShZ9kkpvQzxyxKwUVoY9imKmnRwnXz5VySlBiGatVa57+tK5dM1UU1?=
 =?us-ascii?Q?3Juk0rzdd2kkXGfWxBg35iKimdjHiqfGw04neizUcvJFg3fWf76aEpaVhdPW?=
 =?us-ascii?Q?FcpLvqc6zNbfuFaD8U4NnETQyM66EgV2OeC0UNuEfKOBxpd7iiEFIIuDtgnD?=
 =?us-ascii?Q?3TFsTEEp4wsYglDJwaBQTNiCaiCr79TMpQ96eo6tGfuWpGzapAQLZqW9u+RP?=
 =?us-ascii?Q?xOvrlzgdOG7y5zKE1WOo=3D?=
X-Microsoft-Antispam-Message-Info: 7XgpTTaF/k13hf9a90OoWjFZ8HL1qlvHYb4Rguc6mD9N6wi9HPb3wyylOG2cbsqMROufYRvQIEyHEHaptFf03xgU1vM+G7GCww5ATnVlNnZ3piRsutaqnXB1jMQRi0JsRwgcXVd0MeFQcc8EoEoUy/JyYBeWD0DyFytlIskA3rgp6pikFHY2dewCKUX3iqSrZ6aegChFabT+HnNp6cG7MX4UDgg4b/wNElCtkMiFbu/hHYwIJs5wN0whHyg6m2dncxXbPv8q4WOEm2DfjDMsRW629J2usj6JlOzfS1o4KaWFmpxeJ4soWfGWj5s8LG9PPaHtaG1MK9YbTYpSZX+88A==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:KZWqh754Kd//uGTFnXfrk8Qe75q9SDOJfofDcgylqMgeZVf/ZgNpea9iZZeOiq9AR76JFBwzS8XIJPEh+64XJsAXTJH+M8pqBufLiPR31YqVp3Iwxd7HgQoMFl2h5TfyZPlQQo/+BXzq5HZ5+GGvkhVEmh4AEnP3lMZ6q/caeYnsMQAm3P1KD8TVKjA0sG7gtB03I9XRwCTSIjlJDaURF4DTJN6D+JR55J0VOukDajNbCwQZYDLErxfjouVclMa1C4aICt+mMtCXQ5cI7Mn/689fIq/cNmAU5dNQIDvzmGcmcwiucCDCD3gCrrhRpiXf+AIpDVtYYQuWlIg0pwLhbgPOqYH+A9M9QKot0eAEfacA2cnb/YTRF3XRGzwNDhnGfWvD4waiasVo40O9wFIP40gHYSyDeMAZ4F7zsXyApe9cy5wGr44d3z7+URE4vY3yoVvHf8wSIlbPjJXYeZynig==;5:0PRcy22JGc94rufjrp/QTxDU3V6BjIRjMSgkKq11OmncDs88/pWmhDb9wjhwiglOHrR+HgPP5MgOojaBIuTCwWonIItPnLvotRCFibG/zE9fAOXlXMy9dRAiX4jIGQu7XOoIIJmwbyYUWojnq07MHCyWa8gzam4NOeW3vvgdF6c=;7:u7MLA1wJY5bsYe6uzpCh3iK2KPDGbwnAyXJMtzJ2nwMwhOpuLooAU1GdoEy036BAKLs1+cMgI47kR0RVz47DAB5Gz9ZHpvcCHJ3ALip/StwW+bMWO9OMGpZ7ZS4O0AdgAuZUrG5m5Io/88/wtJZt4u1JdTr7WulDswGY992uS+cmgk7Tpjxh0tQOsOdXxk3DVHpjT1Uf96t29twenfowGl7hTTl0CktHhuIy64Br+HZMCFfsAx1EH79nLjpg8f3F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:32.4684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5536708-4e09-4a78-fea8-08d5f0ab5ca4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65056
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

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* Code style adjustments.

 arch/mips/cavium-octeon/smp.c         | 36 +++++++++------
 arch/mips/include/asm/smp.h           |  4 +-
 arch/mips/kernel/process.c            |  2 +-
 arch/mips/kernel/smp-bmips.c          | 11 +++--
 arch/mips/kernel/smp-cps.c            | 60 ++++++++++++++----------
 arch/mips/loongson64/loongson-3/smp.c | 86 +++++++++++++++++++----------------
 6 files changed, 115 insertions(+), 84 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c86..6aaf4de 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -280,11 +280,31 @@ static void octeon_smp_finish(void)
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
@@ -343,20 +363,6 @@ static void octeon_cpu_die(unsigned int cpu)
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
index 88ebd83..c8035e5 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -77,8 +77,10 @@ static inline void __cpu_die(unsigned int cpu)
 
 	mp_ops->cpu_die(cpu);
 }
+#endif
 
-extern void play_dead(void);
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
+void play_dead(bool kexec);
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
index 03f1026..aeade5b 100644
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
@@ -480,6 +467,31 @@ void play_dead(void)
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
index 8501109..5fcf0f8 100644
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
@@ -668,13 +710,14 @@ static void loongson3b_play_dead(int *state_addr)
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
@@ -697,44 +740,7 @@ void play_dead(void)
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
