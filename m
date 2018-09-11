Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:51:25 +0200 (CEST)
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:6784
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992891AbeIKVumnno0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rna7rJ2w8e8T3E+fe4/m4iT/s+182pdsBhAIwRJh3M=;
 b=e+o+8DXYtcCrvSCnSxwily4P3OxJ6NBIXKFwKZkJx7Z1DUSkjST3emY41waDEcT8omXAJNDZ8rrQj1mbQ9bJKLaAGP/STtF8ULdDCfevOg7vpF5yn4F4pJllKhsDR0vUZzo13RBk1OdzEnbGY1v3QkHbaB7UMyCPmoZ3B+bOEqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:49:55 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v5 2/5] MIPS: kexec: Make a framework for both jumping and halting on nonboot CPUs
Date:   Tue, 11 Sep 2018 14:49:21 -0700
Message-Id: <20180911214924.21993-3-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911214924.21993-1-dzhu@wavecomp.com>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:3:129::17) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db148b85-cb53-4de2-cff9-08d618308342
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:Ey4Fuw4JJEMGGt+vzwF2SrTjyWEHWVRXi4jpR4NW9rtDIq6V11KjyMt8yyrSFAhoW9ltmtz7McHDzrIg5VzaVYr199wkoIDDi4a4UxEwfojf3KegYvLWfS0wxaW7IOi0jwgZHNCZdw0HAejGLTgqfnP6IJG/AAKmI8uDl1k30d4bFxR8TlYcka8CK+a6W1oLstWzipnAOpqKe+CEgjf+rL2/h4DiyYI/npIdLUHv/ylBP4FspX3zFeK7TjQGFVT6;25:k58ll8zClbwkjGikZB7kItRqOmegfgUJ4hxwqqBNJHIQiuPuy5sI0MroiOoNshqTc+B/pqqb13pTWrinJvXMEe7DQonXYvytoMzYu+JRLmVcwGywvJX9QNAblnC2ATPS2jUPvI4a+GgfILDYSxltEO0pSyu78/35/NDEw0rj1CKhn9TQ2eChd9q8SVgX5uc+nYT4Cld7baSV9d1ResloYfyOx71JbF6GtGMEVxwyJvEY37PTbKLBBmCOwKD92M/DfmIEkE4DUSaR6qv8+95M/Pqmi7gg3+iQenMC7PgRJsmQ+qF7pb2NWKo1gC22nScXqvu5VeyBkSDR+8gsFjEc4w==;31:g6S2hd7dSisrc33KgTHI7dxRoooWBACleBrqEJv2rU8AQIcSV3+bJonhJZIRK85V9XVfI1MLISNNWM+uP97ILPpO/qIpmaoA1q9surPm3VkT8tI3jLWOhR5OtpHuL+Krz70Z8VOUjBkUYCNIwLyrVWHrhwxZgJsQ8LvZXnpidubiQdRUqivWx9cuaNi9XYT+oWxVID0TWQaiag6ingRmw2FGsw59gBGmjs2iUKPy91Y=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:QfV4MoJzcRBYwiPAty18MQJ2LGgUBQ836h0VOAbR3NwVt//B/OLmAafGY7voA92mDX/4+7hLM5eBVWEcIdWHR3i5fjiOsoaINUBkHuUoh4V36HZlTJ7UK1WTonTvmEE57fp6qitpLVEyuUo4nzV17C89JrHRAqXUmcxSGVGOl02au9fWqVL5omtWs1IrjTTxxBxE2wqa2A4wWyujVeZygk9ReIWG4hM2XQCfjiolZADk8DzCFL/kfO//vBdTBsTP;4:4RKB9qA+gphoc1c5u4K8IgMv06D8bV38A/yEsWRiaFV+or/GxBJKZqbOp0JpNztmLKqfCoFstKmbEnRF8FMypdzqkeALMjg7POg/5dgDAkOYGJQAj/3vd6sR5aL5YnA9rI2qM1/zfDOGa05jG22stWQmjKb5VZifkZIjCC9d/Rum9JmceIlOaV14HUSsufI09cz/zqDe0exOBa4lD5eoKBl0A6CL/GChmGFiWW6tjyFK35tCuHU5UZFk8Mhb1jmltqJRgwTWmRg5RQ2f68C56A==
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21457FC3A6553AD14431972AA2040@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(199004)(189003)(6486002)(4326008)(316002)(2906002)(68736007)(8676002)(36756003)(16586007)(8936002)(53416004)(105586002)(37156001)(86362001)(48376002)(106356001)(25786009)(50226002)(50466002)(6666003)(66066001)(47776003)(305945005)(53936002)(5660300001)(76176011)(81156014)(52116002)(69596002)(16526019)(51416003)(6512007)(97736004)(3846002)(6116002)(6506007)(7736002)(386003)(26005)(81166006)(1076002)(2616005)(11346002)(446003)(478600001)(107886003)(486006)(956004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:ntWeO3chzFUkhK8kMCsGYsYCmtc1adxwYnQXQYZ?=
 =?us-ascii?Q?SPifngW7Qgerjvqsdn0HvAJPudN92IR3oJzGbMvKv7CZKr4Z988n/sEX8VWF?=
 =?us-ascii?Q?k9CJ9L6SbxAaWZG8uzGbOobcWkjH/AmlITsmZrxQ1PW2ZANDc8PsnZFdn92s?=
 =?us-ascii?Q?vhWDUOaBNjfu2DxOfsW2k0GKHu0vFFG+S9VahPZkrJDT0cTOGAmggRnS+IYd?=
 =?us-ascii?Q?mnRv6Huttq38ogTAOoJk07cQC5TwySNv3+hu2d3XwX5cfvkDVcxUbvgf5+lt?=
 =?us-ascii?Q?fjYpRkH9Xj7lAOXo7p4Z0FV3eP3JatY+HmPYQiHRpQrIG/xAK9GxYpT2wW+s?=
 =?us-ascii?Q?zj5Z6/m3Q/OL0r94dXyOjDR6g4BhF/EukyBKcDDcv5Ji4NTnqAumbdu8k7h6?=
 =?us-ascii?Q?hNIDvl6T/saybquGEIe0VqAshk6chwjfnn6ClWZEaptKZ7b82FYna0Nw89/s?=
 =?us-ascii?Q?7mBKltHRmwu5jgT6TnJR+p303IrTOS/P3iWIIWHLfoJ1QBPfuykaASwXUeax?=
 =?us-ascii?Q?stktPFYt3la+PucxFO1Uq7m6ew9JV1Qzl4alNtSLDoDRyGA4xFrjKnIkKXMg?=
 =?us-ascii?Q?3P570HqsU9YjRzuGcFoZnERyz7TXeismlBo72/U4JgGi7cE7a5wcEBR1TQ2d?=
 =?us-ascii?Q?CdD2n0TTfzoZzGPtQYtB/nnswtlr/IeKO6Yy1EU4S0vVqCWIvBNJOGvBdIe6?=
 =?us-ascii?Q?9KBiOiEdUmkKTa9msy1XCiZvCmOsesZ/kbMHl2QPFcO7NeSekpWqDHYKcV3B?=
 =?us-ascii?Q?ENikxVgpAAWURZm8/4WJVeCmWi6mxgpcLGr6J1kaQ5ephIDe88+ZE1Tth2m5?=
 =?us-ascii?Q?EIDFi95KebPW/DGR+WThWQ003NZgPSjSMCd6VLl6c1M7o97r47NYm6npDFuE?=
 =?us-ascii?Q?02TjnRtVWlQlkKea3OinBAxnlg66TSEbAUwuKVt4tQU4IvKSJ7xKPocW26td?=
 =?us-ascii?Q?GXZMacFL6+uzY6/ymqkBz+paNozqJe/Tar7OJrYhzQo1rw2rjdBa5V+v8AQZ?=
 =?us-ascii?Q?QxuRIEi3iCZJ7+tO+Byn9zEXqGCFFrbqXruT0rA/RIDkVlPKlRNcHP6Sm8ce?=
 =?us-ascii?Q?nbgEW+LQM8HQ5AOekaweRxGzG5hV0RJVK4B46ufV2uhNNediaXN3pO1W3PxS?=
 =?us-ascii?Q?+oCy7Jr0QLqMK/pU9d9qF7P6ea0iU6FJsFtVx1COxe+JkYVzQFeBW426i92z?=
 =?us-ascii?Q?yPuqLJpOYFr35SQ7GRqMSUEIhmQfrEkKnydje/O/U+lQs4I9NC+YJFLvTJg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: epyyPc0LhiRGIJgVquHZ1cDMGaFnmsPbocBi08WNNjMgZLqYYDMN4iQZME9lsaIV0BFuPcCd+tQ1UD22HxR1DU9pmbYjOKoWP32qPqkMeAsYFUrRZshWuglSOsfB+1A6rk2p+/OLSk77MDefE2PtdnsNZYpx5IdQ9ZkojfJmvFOLzzktjmimyxDUcdoZCPjXw6mWbk3KzZeJCYdAvLqLZI7mDnNgKqVir5CbVW8ON3c9zK/R13FPks9A5/NAuthx6iL4TXZOYil23jcl86dXjcFk2fjRhynNoFQ5YTyAy1Li6KuIj9kUun/3WilzRplaYiSQK4/OxCcko8odNvhX/pcnzWFnWZ2+t+yPwbOHT30=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:frmfTsmNleHAaOx5OHBzBTHFYSzZX20XKAgRmqyA0zriJqnmbA4tZwHDxgQOtzYb6eWpXTxfV2ZE5mgMjErCVyy9JapSB2hsPl4jOjn5qtqzMz4C1j7XTDDj5PQXem4xROZ18YdCWh7bju6RCWJSYAfKBQ2oG6rhT9vNTqB4j2TP++9n5IkzpM0X2ZLGf75PIwkLD1FFWuqrGQRcOZvsS+G1K4seYGp/a+gnVDBwtRwpyNhWzSvnUMlXORWbwwNmJV3I3Ul4sTveXFBI9QzSnWaPnx1ky17ELsoYUkH4UXEOtZw3N2xYCk1VtFFYYq3/p5AYJUiuRTb35+g5ndDKL/aI69VzBo8s0o/5HmyJ1UOsThijgDBWY4IS6YGhUHnLqxzPhHPBywaGwUT6wCDuENzWa86mDnGPVvhaT/YReKiJ2VXzjCaMQMm8zABg69Kr7fnChVpkMfk8x3ferX6NmQ==;5:ynYB636Wi8A7OaTyZXrJsVyI5p8ifss1oMjq6qmePNU1aU6/3TET0/2Mhi5qvB5jmOGGB/cFQPr6ip7ylcmDAa2nQiRWCZWDzcStG8Bio9wKtcTKK/BD38HmiZLQttZfcGuqccypGGSFZGy9c5mWCvg8pxrr2WE/Mtl0egeIiB0=;7:ne8/bO16FpiGVODRb7mcoKtAHKC72Ag/+GAcYMSyexKTqLPUYbhh4EzJBmHF1P3atr8NUQ3GOOEwYyRYkGRnJfv5ql1B69KS5O9rIQmHcgggv6STsd0OkGcwB9GuuiSuqyX/H5LfH6Rg9pADZ+dAqCzVQcQ7lw+Dthny5wKA91J2lVB3WcLuYOSn+ri16lXnzq1UzqxGHiIfbjaEtF3i7QLWMEPo7GLttMmo64QD+eTG5cHmgjxR/BQcfdIUaDtg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:49:55.3399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db148b85-cb53-4de2-cff9-08d618308342
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66211
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

The existing implementation lets machine_kexec() CPU jump to reboot code
buffer, whereas other CPUs to relocated_kexec_smp_wait. The natural way to
bring up an SMP new kernel would be to let CPU0 do it while others being
halted. For those failing to do so, fall back to the jumping method.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/cavium-octeon/smp.c         |  7 +++
 arch/mips/include/asm/kexec.h         |  5 +-
 arch/mips/include/asm/smp-ops.h       |  3 +
 arch/mips/include/asm/smp.h           | 16 +++++
 arch/mips/kernel/crash.c              |  4 +-
 arch/mips/kernel/machine_kexec.c      | 88 ++++++++++++++++++++++++---
 arch/mips/kernel/smp-bmips.c          |  7 +++
 arch/mips/loongson64/loongson-3/smp.c |  4 ++
 8 files changed, 124 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c8625659..39f2a2ec1286 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -15,6 +15,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/kexec.h>
 
 #include <asm/mmu_context.h>
 #include <asm/time.h>
@@ -424,6 +425,9 @@ const struct plat_smp_ops octeon_smp_ops = {
 	.cpu_disable		= octeon_cpu_disable,
 	.cpu_die		= octeon_cpu_die,
 #endif
+#ifdef CONFIG_KEXEC
+	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
+#endif
 };
 
 static irqreturn_t octeon_78xx_reched_interrupt(int irq, void *dev_id)
@@ -501,6 +505,9 @@ static const struct plat_smp_ops octeon_78xx_smp_ops = {
 	.cpu_disable		= octeon_cpu_disable,
 	.cpu_die		= octeon_cpu_die,
 #endif
+#ifdef CONFIG_KEXEC
+	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
+#endif
 };
 
 void __init octeon_setup_smp(void)
diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 493a3cc7c39a..5eeb648c4e3a 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -39,11 +39,12 @@ extern unsigned long kexec_args[4];
 extern int (*_machine_kexec_prepare)(struct kimage *);
 extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
-extern void default_machine_crash_shutdown(struct pt_regs *regs);
+void default_machine_crash_shutdown(struct pt_regs *regs);
+void kexec_nonboot_cpu_jump(void);
+void kexec_reboot(void);
 #ifdef CONFIG_SMP
 extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
-extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
 extern void (*_crash_smp_send_stop)(void);
 #endif
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 53b2cb8e5966..b7123f9c0785 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -33,6 +33,9 @@ struct plat_smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 #endif
+#ifdef CONFIG_KEXEC
+	void (*kexec_nonboot_cpu)(void);
+#endif
 };
 
 extern void register_smp_ops(const struct plat_smp_ops *ops);
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 056a6bf13491..7990c1c70471 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -91,6 +91,22 @@ static inline void __cpu_die(unsigned int cpu)
 extern void play_dead(void);
 #endif
 
+#ifdef CONFIG_KEXEC
+static inline void kexec_nonboot_cpu(void)
+{
+	extern const struct plat_smp_ops *mp_ops;	/* private */
+
+	return mp_ops->kexec_nonboot_cpu();
+}
+
+static inline void *kexec_nonboot_cpu_func(void)
+{
+	extern const struct plat_smp_ops *mp_ops;	/* private */
+
+	return mp_ops->kexec_nonboot_cpu;
+}
+#endif
+
 /*
  * This function will set up the necessary IPIs for Linux to communicate
  * with the CPUs in mask.
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index 4c07a43a3242..2c7288041a99 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -46,7 +46,9 @@ static void crash_shutdown_secondary(void *passed_regs)
 
 	while (!atomic_read(&kexec_ready_to_reboot))
 		cpu_relax();
-	relocated_kexec_smp_wait(NULL);
+
+	kexec_reboot();
+
 	/* NOTREACHED */
 }
 
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 4b3726e4fe3a..c63c1f52d1c5 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -19,15 +19,19 @@ extern const size_t relocate_new_kernel_size;
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 
-int (*_machine_kexec_prepare)(struct kimage *) = NULL;
-void (*_machine_kexec_shutdown)(void) = NULL;
-void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
+static unsigned long reboot_code_buffer;
+
 #ifdef CONFIG_SMP
-void (*relocated_kexec_smp_wait) (void *);
+static void (*relocated_kexec_smp_wait)(void *);
+
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
 #endif
 
+int (*_machine_kexec_prepare)(struct kimage *) = NULL;
+void (*_machine_kexec_shutdown)(void) = NULL;
+void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
+
 static void kexec_image_info(const struct kimage *kimage)
 {
 	unsigned long i;
@@ -51,10 +55,16 @@ static void kexec_image_info(const struct kimage *kimage)
 int
 machine_kexec_prepare(struct kimage *kimage)
 {
+#ifdef CONFIG_SMP
+	if (!kexec_nonboot_cpu_func())
+		return -EINVAL;
+#endif
+
 	kexec_image_info(kimage);
 
 	if (_machine_kexec_prepare)
 		return _machine_kexec_prepare(kimage);
+
 	return 0;
 }
 
@@ -63,11 +73,41 @@ machine_kexec_cleanup(struct kimage *kimage)
 {
 }
 
+#ifdef CONFIG_SMP
+static void kexec_shutdown_secondary(void *param)
+{
+	int cpu = smp_processor_id();
+
+	if (!cpu_online(cpu))
+		return;
+
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
+	local_irq_disable();
+	while (!atomic_read(&kexec_ready_to_reboot))
+		cpu_relax();
+
+	kexec_reboot();
+
+	/* NOTREACHED */
+}
+#endif
+
 void
 machine_shutdown(void)
 {
 	if (_machine_kexec_shutdown)
 		_machine_kexec_shutdown();
+
+#ifdef CONFIG_SMP
+	smp_call_function(kexec_shutdown_secondary, NULL, 0);
+
+	while (num_online_cpus() > 1) {
+		cpu_relax();
+		mdelay(1);
+	}
+#endif
 }
 
 void
@@ -79,12 +119,45 @@ machine_crash_shutdown(struct pt_regs *regs)
 		default_machine_crash_shutdown(regs);
 }
 
-typedef void (*noretfun_t)(void) __noreturn;
+void kexec_nonboot_cpu_jump(void)
+{
+	local_flush_icache_range((unsigned long)relocated_kexec_smp_wait,
+				 reboot_code_buffer + relocate_new_kernel_size);
+
+	relocated_kexec_smp_wait(NULL);
+}
+
+void kexec_reboot(void)
+{
+	void (*do_kexec)(void) __noreturn;
+
+#ifdef CONFIG_SMP
+	if (smp_processor_id() > 0) {
+		/*
+		 * Instead of cpu_relax() or wait, this is needed for kexec
+		 * smp reboot. Kdump usually doesn't require an smp new
+		 * kernel, but kexec may do.
+		 */
+		kexec_nonboot_cpu();
+
+		/* NOTREACHED */
+	}
+#endif
+
+	/*
+	 * Make sure we get correct instructions written by the
+	 * machine_kexec() CPU.
+	 */
+	local_flush_icache_range(reboot_code_buffer,
+				 reboot_code_buffer + relocate_new_kernel_size);
+
+	do_kexec = (void *)reboot_code_buffer;
+	do_kexec();
+}
 
 void
 machine_kexec(struct kimage *image)
 {
-	unsigned long reboot_code_buffer;
 	unsigned long entry;
 	unsigned long *ptr;
 
@@ -128,6 +201,7 @@ machine_kexec(struct kimage *image)
 
 	printk("Will call new kernel at %08lx\n", image->start);
 	printk("Bye ...\n");
+	/* Make reboot code buffer available to the boot CPU. */
 	__flush_cache_all();
 #ifdef CONFIG_SMP
 	/* All secondary cpus now may jump to kexec_wait cycle */
@@ -136,5 +210,5 @@ machine_kexec(struct kimage *image)
 	smp_wmb();
 	atomic_set(&kexec_ready_to_reboot, 1);
 #endif
-	((noretfun_t) reboot_code_buffer)();
+	kexec_reboot();
 }
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 159e83add4bb..76fae9b79f13 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -25,6 +25,7 @@
 #include <linux/linkage.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 
 #include <asm/time.h>
 #include <asm/pgtable.h>
@@ -423,6 +424,9 @@ const struct plat_smp_ops bmips43xx_smp_ops = {
 	.cpu_disable		= bmips_cpu_disable,
 	.cpu_die		= bmips_cpu_die,
 #endif
+#ifdef CONFIG_KEXEC
+	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
+#endif
 };
 
 const struct plat_smp_ops bmips5000_smp_ops = {
@@ -437,6 +441,9 @@ const struct plat_smp_ops bmips5000_smp_ops = {
 	.cpu_disable		= bmips_cpu_disable,
 	.cpu_die		= bmips_cpu_die,
 #endif
+#ifdef CONFIG_KEXEC
+	.kexec_nonboot_cpu	= kexec_nonboot_cpu_jump,
+#endif
 };
 
 #endif /* CONFIG_SMP */
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index fea95d003269..3da1a7890ab9 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -21,6 +21,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/smp.h>
 #include <linux/cpufreq.h>
+#include <linux/kexec.h>
 #include <asm/processor.h>
 #include <asm/time.h>
 #include <asm/clock.h>
@@ -749,4 +750,7 @@ const struct plat_smp_ops loongson3_smp_ops = {
 	.cpu_disable = loongson3_cpu_disable,
 	.cpu_die = loongson3_cpu_die,
 #endif
+#ifdef CONFIG_KEXEC
+	.kexec_nonboot_cpu = kexec_nonboot_cpu_jump,
+#endif
 };
-- 
2.17.1
