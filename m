Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:01:01 +0200 (CEST)
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:38103
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994640AbeIEQAJoV03O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QMObg3on5LmU6jcvjzbMAByB4e+7nUzk9+pjeSxFAY=;
 b=UKHGcz+cpvTYQ+JbPNnZTrrr3/npm94Jt+463orfzC6XsJh5oORdzWXDoUo6/Ryf2bb8b9nVHjDyytGReTcNgFAOFmGn7af5GW1Qld/0bpZ5uiikvyTgw5FBVLRFPDMsddCVjk5I98v2M0Xg8GP4FJul879PiHHDb5eGJJSBvOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 16:00:00 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 2/6] MIPS: kexec: Let the new kernel handle all CPUs
Date:   Wed,  5 Sep 2018 08:59:05 -0700
Message-Id: <20180905155909.30454-3-dzhu@wavecomp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 051a2f7d-aa42-4191-7dc8-08d61348a2be
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:sOx4TqvNoU8lKKnERTfBVudo/6zyZSull2v1sDlZSx58In2u9ues6n5ZpUJiyAF2dxOIZ/krpNcMcdtnqyhlrAYLln9TFC1s292c9eeK0+vVT4vganyzH82a3M0y74vID9j3TP9bJsREwZ2hcOZl+z7puzgAfJSkRRMNGJJNKCWVkAyMA1wR36tEt7mBAieSPupDvTBf0WBUxPgROexOetmJJePo5dIYztjUgLJ7lbBaI2ydXa3qhfEFWLmFCGJw;25:BPMNSPRDogkmOALpjbrgPNiPZjTVQ4YMf9bLIrnw7Z/GrThWAvy3KW1z4YdAhJa6C+gNGyT/iXoGx2lVK63q9i6F63S8pjIQ2QYzD/J3ZNnzPIDxjLdDFWYkRSYIIuPgnE4hv9LQ8/Br28BFWqATh+xqCVwWazTG31x4sPgFeXs847JkVUUfGRgtNXd+U8iJledhqilJPmlfyU1iWc9lD4g2PAgt7X0FXAiJOxRjGczAYFymm8WYaQ+0rRXgtHmFu8D3DuD8WypnHQTFl7ppVLSnxLByMHxMNCMO2nS7whwusUtwEJRcQX9hmq7L8Q1kao34MuPl1bYOZtqCAE9DFA==;31:nNWrxuC2w+vub8JoOFMaFhKmKKod/Ir9BzBGPK9W2sO/+MyKHskyK03SN1MB4PlqUUlTGrurdt3pv/eU5G5AqugIOxcMl3qP8Neqjf9Zp1OM7MaDg+uGlyNcK/9q70DbWmB27np22RbVpz5KbL8YAXL2qOjO1rRJiVp9/+xI6IXT9kh0TCfUtcP8G9iG4c+PF+AzZzCn4JFzXX2L/aS1+XGYUmWqed/wprvi3pt38BY=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:aA3pdHbcwyppplA/ww8WOGCTWpgDhLxtNiKL0GRVDaKvOW3aIk3YIeLk1ifPXvfdJ6PJrZjbU4YSbi5jEa3s9lDCYHug0xweJwK8ePSHxxXfSXT7xH5Y2ndUMfuLStOZJzKsLtZjPbQn8KulgJituECYsm6QC0dsOZZVKuWF1cP9C8Qve5sKoOffEK7rvZbkbBgVc3MqiO/mykBWRMUiAjNFUobdITpIpxsLapk+g+eQziMikqsUW9+LMv6a6t/v;4:7sAalg+w042J7izf60+9chFU1VyCI8h8gvYQ7zRQm/qDwdUeHoaxHM+x2VFxgzvtzbmeOu4DZeOk8uP4QgrnZ8mKD7i9HY3L5dixoqbfBglXU9pFdxEspNVNphF4Nx8jiOfybErvidJg4fvwYIr++GPudCLwtpruRAESzktDCeGgdDzYHySOfoMKlPvts+nRDeYKt6nndswMCDjSVjcplWuJs22YluE4y8aXPohmr5JbyyNlBRchMQLcO759cquqf+L6hOjVfWbfx4Du1rXRE2ofI24PjcfhIs6qiHSczPGAY3/0Mzpneq7MLrOCU5Go
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21450C60886A54C957D18994A2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(11346002)(956004)(476003)(446003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(76176011)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(575784001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:vlXHBFk6WBQCuBfxxVEDjCLgJmcrznIaJx/FU4k?=
 =?us-ascii?Q?/TlOr/+AnEbbpldO/bDyfvMbj8LF3xOHvfimc3zALEmIwbTJ5VRt4gj3Nfym?=
 =?us-ascii?Q?leL1HyIb5GhI4K9Yzsfz8eOa/qHz+IY51tVYSQs3gFmNHnRDQs6Id0p5zmAe?=
 =?us-ascii?Q?f+SIc4qWp32kG9tKVN41BgwkjYByvvoIIivVp6Iv3wLeFAD0+dNDcAo0zXng?=
 =?us-ascii?Q?JNujQ8GTEAafDlajx+EJniFi+9s647MWw499ithTKFL81S2bO7C6O0RPGshc?=
 =?us-ascii?Q?RVBkvPxADrdREqP8kDEFy1UiBxoTo2FHMC+zvE+YdNv77EqbqkVlvcrAbGo2?=
 =?us-ascii?Q?+BDhfZsXgr7/9Rer2iHZ2iMt4p/eomH6q0tinnwYIRBslnqta4vDP8BuXN0X?=
 =?us-ascii?Q?9ldgUh7kD+ANVrOPtlz6MSgbLNav8llkQ9Rn51IfyUb1rGF8mi/D5HP2f9jF?=
 =?us-ascii?Q?ePhOWvMsESQw8sASeYVdnIHM7MmA2DblkvwizP7dEy60bwyB3fETwDqtOSPD?=
 =?us-ascii?Q?IGycqpaSDPoV3tu8YqoIgWsMWROabF7BkLwLaFaJmKAANdQJNo4/+4P93go3?=
 =?us-ascii?Q?tAtQr/TeR5iG57ZfxDQ/dz6dTutLg9VTKKJ3yQnmKEEZWHXaVEavE4mWLuzd?=
 =?us-ascii?Q?zC74T+uxeVWbRwzpDZcNe0Eg5FFBRD/+/Tx1dEb7yHTZA2E5G/MKSYZvyfvk?=
 =?us-ascii?Q?VaqdLlaFpvkgXK9CO/ZUEdqNe0988wsf5KRZ89Ztd/2NDaBtiVIxyRq1rgYd?=
 =?us-ascii?Q?w0x8uyFeeYo8q2khk/DvRbMqvK7amJYOOz7LYDUcbhEgYt18dc5sOFnw53MO?=
 =?us-ascii?Q?mgSy7p3ShkFR3mJoG8qg/1a06T3INHsc66nBRzzMHiXhgptZ8JAusH3TBDVd?=
 =?us-ascii?Q?5QWe1N3iHd6wCQeHhMGwnBIBbjw1SVt1susiL1s7jwEoHLZn74uuDpZqXDyN?=
 =?us-ascii?Q?MnpIxoxipze+zZnJkFv9NeH93MOgKkeJeg/aIkZ7bXhDKhEVStV0SE0Q7otf?=
 =?us-ascii?Q?7jz20o98OsLellPf/w6cyamtYw1uoUqx/P/o7S3hU3JDjRBnmrTWi7DUo0DA?=
 =?us-ascii?Q?kEllhJoCO44fZRb2Lvo93Fj5XTVfaBPcxgLaMbeOh9+4kS9LIQy8/rApiI1h?=
 =?us-ascii?Q?u/hrG7FKKOHrUHhuEAoL+RPmx7MR3zCz9c6tu6iEHqWR04Dgz1PB+g/hFL8R?=
 =?us-ascii?Q?WiaTa3ntCJj3Kviqja2PHpHheALnfdVU18uj07GVveJZuExMisMQCrqIHKCk?=
 =?us-ascii?Q?WlVrlk0oeU6RTXBZYXZ8=3D?=
X-Microsoft-Antispam-Message-Info: OTL8r1VTVs+2R19n1F39cPCmTUCbaqlhnhr7dzb5N7MoX2Mv2qHlzEYlR9k9V/J216uJqDVCYekf/qPFJEzbbGHKXOwtUBWNlbOjR58bOOQnMLe7Y9DGVF4/u7hDqP5YZv1dd68ufVF/cjzADvr6SUcw4CVibEQFOm4u/tCnJQvMWLPvtKXj0qM5HcmwfmaXOFROYudlIkgAh62EsbzCys6WKiHIIJOoBMZUissuglM4+C6IBobVMBeSQ/haO8SfdQJmI7A5aDF3TwXNZ8w+tg5M6cgKcpjTleKIWp+kXljUPj4kMt9ac5L9zleHNeLgBAjmkHG30Vi/Jo47Crv1H7xo9XTolewuBOGqcuNjPXI=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:u9XV2XYkBvjvbofciynH9d0WayH1Cvb6mUs/i7wbiIRVP4QEqtzSWIxnk4nKMqBlgERyg5uUYVTLfptGUjdplAK8r4IpGNiX+di0tYkl76hZDgZwV2tL1rHxL6ymWQFqwH85TjTbU0NRVjkRnJnfkv8HJPKAEc05ZHT1tEynbq8HJSub9V9vKW+34tGn+ayMXc24K38AL6lP01g85gWIiePVyg/KxwzPjqRdjx1j2oJqfMJi+hEO0tMoSbZwGfUDYnxeL/3oOnsblKaqgfjc3yDwyNcLJodX7+4zQDk8U6XOf8DQ60qfCpbZslf2wsKn06ucj4hws3UK+ShAPlc5fR24IDnaCw6S4+iZFXamdKDiLhaCCTp/U8AR9i8Fk2hCy0r7SSf6u8712FuugOIXBgzHPspvyR0DwMHo50e1cR+Nqdl8AnCQInnuTum9s7h0KogQlE/kI43yBvBpBmFizQ==;5:TOZCq9ssmU2hNdL73BOgEkRfgM+f8IIqI3AVIjszYuJq9/wcCJ/2SGHeRGhikzZIvrKLWAnL5Ecr+UjWqpLgeHoTK50rcBj3OitZXC12U4bj6Bv3qR6AbrFKiasOaO1pRbRbjboczCSJR/fLSdTuiAqBqCcu66MY2iqawHlNThg=;7:dly+/5JhzGZ9d8mXohfcOfbPf7mL1QhVDJo4PYYSnrkW67bXgBQiQSCvA8SHoEbW/c7Kn64R2m27Tiq9cabC37jDeX5BY7JfBWUrT9r5ffcia6okp6sUpyYSSGGx+eEb0/r6LB8DeIyTqfv7rMfHLEgKW+zdHe84sJYz2vGTAguZaeHw6Ppz5mYaShMyhttxsUKtn93x70LLEAB2l8jTE68vUoomB06HMQE/umSxhH9tNSJsaaG4uPItemDk0QpQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:00:00.2531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051a2f7d-aa42-4191-7dc8-08d61348a2be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65957
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

Use play_dead() to prepare an environment for the new kernel. Do not rely
on non-crashing CPUs jumping to kexec_start_address.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
Changes:

* Use play_dead() without an extra parameter.

 arch/mips/cavium-octeon/setup.c  |  2 +-
 arch/mips/include/asm/kexec.h    |  3 ++-
 arch/mips/kernel/crash.c         |  4 +++-
 arch/mips/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++----
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..3a1f7fa42413 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -95,7 +95,7 @@ static void octeon_kexec_smp_down(void *ignored)
 	"	sync						\n"
 	"	synci	($0)					\n");
 
-	relocated_kexec_smp_wait(NULL);
+	kexec_smp_reboot();
 }
 #endif
 
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc7c39a..a8e0bfc0da19 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -39,12 +39,13 @@ extern unsigned long kexec_args[4];
 extern int (*_machine_kexec_prepare)(struct kimage *);
 extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
-extern void default_machine_crash_shutdown(struct pt_regs *regs);
+void default_machine_crash_shutdown(struct pt_regs *regs);
 #ifdef CONFIG_SMP
 extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
 extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
+void kexec_smp_reboot(void);
 extern void (*_crash_smp_send_stop)(void);
 #endif
 #endif
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d455363d51c3..6d4320067cff 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -43,7 +43,9 @@ static void crash_shutdown_secondary(void *passed_regs)
 
 	while (!atomic_read(&kexec_ready_to_reboot))
 		cpu_relax();
-	relocated_kexec_smp_wait(NULL);
+
+	kexec_smp_reboot();
+
 	/* NOTREACHED */
 }
 
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bcd39ba..900475ae256d 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -19,6 +19,10 @@ extern const size_t relocate_new_kernel_size;
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 
+static unsigned long reboot_code_buffer;
+
+typedef void (*noretfun_t)(void) __noreturn;
+
 int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
@@ -26,6 +30,20 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 void (*relocated_kexec_smp_wait) (void *);
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
+
+void kexec_smp_reboot(void)
+{
+	if (smp_processor_id() > 0) {
+		/*
+		 * Instead of cpu_relax() or wait, this is needed for kexec
+		 * smp reboot. Kdump usually doesn't require an smp new
+		 * kernel, but kexec may do.
+		 */
+		play_dead();
+	} else {
+		((noretfun_t)reboot_code_buffer)();
+	}
+}
 #endif
 
 static void kexec_image_info(const struct kimage *kimage)
@@ -79,12 +97,9 @@ machine_crash_shutdown(struct pt_regs *regs)
 		default_machine_crash_shutdown(regs);
 }
 
-typedef void (*noretfun_t)(void) __noreturn;
-
 void
 machine_kexec(struct kimage *image)
 {
-	unsigned long reboot_code_buffer;
 	unsigned long entry;
 	unsigned long *ptr;
 
@@ -132,6 +147,11 @@ machine_kexec(struct kimage *image)
 		(void *)(kexec_smp_wait - relocate_new_kernel);
 	smp_wmb();
 	atomic_set(&kexec_ready_to_reboot, 1);
-#endif
+
+	kexec_smp_reboot();
+
+	/* NOT REACHED */
+#else
 	((noretfun_t) reboot_code_buffer)();
+#endif
 }
-- 
2.17.1
