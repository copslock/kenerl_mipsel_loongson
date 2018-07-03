Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 21:22:59 +0200 (CEST)
Received: from mail-eopbgr680122.outbound.protection.outlook.com ([40.107.68.122]:5440
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994587AbeGCTW0jXB7f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 21:22:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jsk/ItE1TAf9wH9fOh9VTlcAa6oE9lcVJFWa3ubx3I=;
 b=qy7HwzjWU3tmcmuql3Ng0/HD3uhuuGsm/blH8LzNYyoNHHdw2mOkUv3k6Vc15DI/YL2rwu3QadmLX7kAguipTBDU9yiVTLbnBYpGhqmthxH8denRuUuehYPnqHNqAOva2+iAHhKXfk4OqropLacBlwrcui3hBcr/BwMXofU82qs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2154.namprd08.prod.outlook.com (2a01:111:e400:c611::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 19:22:09 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH 2/4] MIPS: kexec: Let the new kernel handle all CPUs
Date:   Tue,  3 Jul 2018 12:21:45 -0700
Message-Id: <1530645707-30259-3-git-send-email-dzhu@wavecomp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cd0c8a0-c63f-4e65-fc8a-08d5e11a459a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;3:XQal38zpqFPSlvRfRy51oj0VNknglljaBwonW/5QkLOxzHnvTHCrlylRmeu2+Wj1i8fNDZYfVxlpwjLaY8/uTxx8aHgNvCi315ypXBeIXf27AI7lYwmc064SysfDY9hqVq38WGt2xVbtD6EX3gkwUeYAf07e+xCa1FaKhJ+cM5G5uYx080sSoNjV8ENu9qHaOoTi8TxuI+QHlv2obEafoYWNwgfy1/n/0tgG4vvdpTupisRrF5XxFFeYPu4jcsNw;25:FSr8hGXXE+8VmfrLWbxyK1uCdjqYXOkVXebPs0THTB1K9XosUwj8a6yEx9Eg0qvIa3FaTWzDkfV8eLwR8/lSDHNilz75tlaK1sb0xLvN3M0t7aOxGQ8uqh5uANg9Ye/OxXGRAu8XOWzT4OIiSCK1G9XHG2x+uNmldr11wkH/EyN/z1UmqjqUDorGSbpLGmqIwpjmw4zo0ZiXWsWZ6uCPQnydgkjWtJykBBdLzskYhafRQym0pXpxY+AyfjfpNbSe9T+CrnfQ+ewLCbtC7wJGmWqet/l7STnhmPIyfpNt/dN+cpIhWVX/Peq9VRddnLyTJwnOMhKhO4xkUxdRZROXZw==;31:/qcZQ3ROCmG8LyvG6Wx0P6LOJMlT1ZGgIvL5c7VU2bEQWNDOCUScBYQGpVrs+pQfcKyh5Azeg2i8mkB7xCa/bIj46H20O2/ZtQhgo9j4lBgERoSvPDqGyab1y15TsUWtO1owPy7V9jICo+sXTfqvGMcWqfCCkShNLzHfSxd6wFstAQa2yfz7bV+8jwvp1+qC9z7Erg3wu4WKqPxG+YYfyEmsjVswy0xTFsMuhQRInqU=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;20:eZlpksyednLcvjiWvYT9JK+Do5XUSdtjX4LJ7OrvXYG+3m62fOqEymxdSXyD29j5gqitVJYNXxc+s3fIqBIIKcCSTB56CW5XSMkVrJo06Np5T9FkrV4sy+ITW/q4Pw11a7c9w96O6EZawYaUbgKz4gxGb7wdh9Blu0eYBAKi0wlF9UfsHhMA9rvyqfIEzRsyBYvTq2cjQjtIk+vjOeR51JDhFwa+0IxCt8u+JEob7p1cScyXpIBIZ5c5xNYm2Sn5;4:ZykQqxBmwLek5c6tHT4V91B1wS9PLRPEKAq7K/MIrrLbDWBmS3G8wj3QQmz/ZmBLuPpS9tZvCGaxQHyv3JwLyQkb8xPGM049Koh9NsMD1Tpm4rViePprfPp3RU95liUwB0r1KaEnHFrx1F4sKr8s8/BH8aWZ8R8R+U1BwGldTxBq2Z5Kb5EKdu7T3kC5XCucW6yn4K8JSGHDvepZop5URP3gfGXgbV1YBDV4dsYIIhOtNoJV5VhsoUcNNlhImkvf5KOvGeLQ7t830A/D8vHBqQ==
X-Microsoft-Antispam-PRVS: <CY1PR0801MB215426C128DC8E4385D20CCCA2420@CY1PR0801MB2154.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR0801MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2154;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(376002)(366004)(199004)(189003)(476003)(68736007)(478600001)(81156014)(81166006)(8676002)(97736004)(305945005)(486006)(11346002)(6116002)(3846002)(446003)(956004)(8936002)(69596002)(6512007)(2906002)(86362001)(2616005)(316002)(16586007)(575784001)(6486002)(25786009)(6506007)(66066001)(50226002)(4326008)(53936002)(47776003)(107886003)(450100002)(53416004)(5660300001)(51416003)(52116002)(105586002)(7736002)(37156001)(386003)(16526019)(26005)(36756003)(106356001)(50466002)(6666003)(76176011)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2154;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2154;23:zNCnuHm2iGwzj9FBfyzeCYimp+hnaGqAn3p+jhC?=
 =?us-ascii?Q?iayHJQo0yTSCl4qtdnbUsf6fGMi4ptV9kp8tLBPLLYGAzAFCjLn2CXhVYxTz?=
 =?us-ascii?Q?UtIPlrQIVekOXMeJkHlaY+9/FhTdmq8LaALeoTMWHQNNT1gONPBfBirnquOZ?=
 =?us-ascii?Q?KUPWSMZsFZce2vY61OxnCryXtTX2ZzxV8oaaoi7DMIFkh1DRzthuOIwWYfmh?=
 =?us-ascii?Q?fTiQ7rGQE7hrPvdu+VbVXHKgvsn2Fr11IEzA++YW1/jjm18dPhl2//unxtSQ?=
 =?us-ascii?Q?PqeEPY94EIQvTOgCY94tFeg89cEEi0D3Ke/TuX5WmXQf0wfA5jdiAayZtDaM?=
 =?us-ascii?Q?GDmzDC925iyuIfuf8KxQvrigdjbJbZgo5f9tKFjfJf0I/qT9EvPI6tyoxzXs?=
 =?us-ascii?Q?cCPjJmmyo1RsmD3C29OuwSUTU6VKciz/j8/Sy+x9Fxi/bON6W3EzoyBsyOPW?=
 =?us-ascii?Q?3OKNp/sP298HufARUKgNMT7yyvdG84O1sq3L1ezCY2piVKUKLRES7I7IaBTu?=
 =?us-ascii?Q?EDWE5UjULYneIvYRzLpkREy8l6KBaxddF8RABAG8GZb4F7At1RbldqAaf80t?=
 =?us-ascii?Q?NyKPRrpSRsXgvamgRSoGF8mamtiSSHNZgbJ8n3n93NXYlP7qeK3NgS/oBG9S?=
 =?us-ascii?Q?zZwslIGKRub+riD2uVKK6SWJcCbnqL0I/jtENOSQP1LPa/MOnUwC+qYiiofB?=
 =?us-ascii?Q?ZNeDuA9QiPvBZOpq0i6nmEgzuiZmnsPpy32KuCX2DB9P6s3p/WEu8ZKCNOO/?=
 =?us-ascii?Q?IivwgVOcmbNCm3wRJvR26F+lCiGbGvukAoQvIvVvRqpsvai0zi0k9cIVF722?=
 =?us-ascii?Q?b5FiXtiIQqOaviH9ggIOGKO777sUNf3lZ/cjKTzh+CI1PvIf49pJVapdg5+d?=
 =?us-ascii?Q?fwwP1usumtIhR3AQS4BlTj1tYX6nhFxKzBH+SjIcbG0d+0XBvXXjDlwz4Jig?=
 =?us-ascii?Q?WkZVADp/av6u+m1zS27xLoWxdn6ZoTNv0nHNcJNWLITqIMk4VJHaBAuHKBA/?=
 =?us-ascii?Q?yshtiBx3CXOrMhIb2h0EYp4nPamtSskYVoOeISr84DhDJJBK8XwtQy0EHSe5?=
 =?us-ascii?Q?8psUPg9Zpe1J04nQXn6nqAZ+xOw2L2ncv98Cf6isp5fBqCMWov8LZLkiZybu?=
 =?us-ascii?Q?ZpV2Vn51Dwi9YejRbmOqkKwZgU5aC8y9A6rNC5ACH8lP+aWWQKy30CXZI9Dy?=
 =?us-ascii?Q?vJTF3kGG9L3jTMFI8z0G5NnujcMKmXOP31iLOhNG1/lP/vxnVwM6MlyNFuKb?=
 =?us-ascii?Q?X7cDCAJcyLuin9KC2jb8xDRc1diLKNZi5Mrpst/Ll?=
X-Microsoft-Antispam-Message-Info: v3E4kqtZOnMlbBWoV2JBaVKKJzCeGv0F8zT1TQC/bGnLU4uigBBJ5uLGhELnfidzB2Go2TJT7Fgju+W4SD76TiBXLicjh5F9nSKE1AdRWQ/1EKJq4kY2xKDxpKrmZC/FQEg4tJI7k0mgAcycmXOC0VpD16f0z/g+2r4NRDCJSy2j5zI+/GxdxajytdysC+EnmhjBFT5wLx9cQHw7xMUmydExxUYKbFu0Y1SFwhAy3/+fadbh/5x4LhsM751ARyDnCQFt1OXw4VSwUfza4cxgzr19ATixMQcdv+u+5/8uKaW/ICGdBUs8UOQZ0u7M52AbGwv1JNjRhnzyo/MTkvu69ljwhNjEyoBL/k8cwrCDvIY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;6:1hPl1mqTf7BJAyW/yPej8Or9sCl7vyDB6AIouPbFwNr06GV0CQXGAlMd44cviUa5WuvbZffx6ElwTLWzLYqfjHQ4nYi0ECB6ElP3N87yeqBJ9t8jXIedPSkwhmDb2vPTNOVjO/7qMBVYBlxQU8MMhXuzB05McQZJ7rEF17Zrz7Kem0ef28KMmRgE9dfLqI8lUKqRrQRotk3KowUU8UYKpS7FILwlbp4XYIw1uBHZ0j6OARg+4i6fDSCo4RSrq2cyQ5Qa3UzOZq1rvGFnAIIwBTjBbugRr5/Mw6v3ZJZbHpEoBw/AjoJ0O7BkeXlkeNpEKpFNeR2+UBZPGIF1GuajhweDyYXIfLx8n1aWfVncDgb0Yt/dol8oOu1AQtYoU8aCFBGO7x24NJmXqRoX3bQYzcAipLF47jnS2mY2N35XZjn5UX9fRMgBFldIhUdVTnUInqUwtzq9UOM8NfxtuHczeQ==;5:zMLhV4FiEkJD7/K5947t4u9MZpHjY8vD3ObP3HaHQvB/tcQ+oOJdImnN9aGaz25UDE5B3TNoraEW+F0s5McY1z1BYAXkpYUO66x+ul5PIgHdLyFpdnUBcOUFN/nRygya9QQ1UuHo2c/lvOE047oRuAQZTaHBD0U6CJKuYqFUaPk=;24:0VU9+bXuEwpIfcBsBbc+AdF6fJexwJI6VAiODppdll3l/pRzsQ18vdzS5LWJLkKuxVQev7KLK2Ta3bGTR1jYW0u4kwIzRd02M87bFiGM2mQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;7:4WtRJZJUiBS6v5fcdE7+4LkgGyBHB0YMSXCPQSlTZxul4SFNlrsgV85GHyMUqTCqB1VTEgMlrSJ9CGdISCv41BO9AmXkXLkgXuc++7DmnUQ7eqn30GP4SMY+omrZse+Mg7XUbgfGFvilc+rHTTlo6++lU1U7nmJp7J/9wSsrOScliscFUkKeMU05xi9wIAfuUuM7qSp3qBonT4D+vxzIQeiequnsCoVU159QsIBrDWNTnz9NPOMqVxVAT7czFPdE
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:22:09.2304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd0c8a0-c63f-4e65-fc8a-08d5e11a459a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2154
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64586
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

Use the new play_dead() interface to prepare an environment for the new
kernel. Do not rely on non-crashing CPUs jumping to kexec_start_address.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/cavium-octeon/setup.c  |  2 +-
 arch/mips/include/asm/kexec.h    |  1 +
 arch/mips/kernel/crash.c         |  4 +++-
 arch/mips/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++----
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0..3a1f7fa 100644
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
index 493a3cc..8f1d0ef 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -45,6 +45,7 @@ extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
 extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
+extern void kexec_smp_reboot(void);
 extern void (*_crash_smp_send_stop)(void);
 #endif
 #endif
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d455363..6d43200 100644
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
index 8b574bc..02146ad 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -12,6 +12,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
+#include <asm/mipsmtregs.h>
 
 extern const unsigned char relocate_new_kernel[];
 extern const size_t relocate_new_kernel_size;
@@ -19,6 +20,10 @@ extern const size_t relocate_new_kernel_size;
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 
+static unsigned long reboot_code_buffer;
+
+typedef void (*noretfun_t)(void) __noreturn;
+
 int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
@@ -26,6 +31,19 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
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
+		play_dead(true);
+	} else
+		((noretfun_t) reboot_code_buffer)();
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
2.7.4
