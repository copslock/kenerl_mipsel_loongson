Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:28:42 +0200 (CEST)
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:48896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbeGLB2WI5Qft (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4MTDvJo6lJhBd59IOsxD/uHw9r8pzkd1/j06Xp03ms=;
 b=DSSgg3izcbswnl0idPwc85XH07K8xHjJcwM3FHXvuLiQNingCgX85w71+89GK7J6aynocVelejtRrmJZ7Gkktl0fKseSHaeT8/b4gijcZzfIR48sMWORQvUnm0crUpBnp60R4ULMCX6IzJV3dy3sYhxpsJ2ozy2FmBEJruVFVFY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:11 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 2/6] MIPS: kexec: Let the new kernel handle all CPUs
Date:   Wed, 11 Jul 2018 18:27:44 -0700
Message-Id: <1531358868-10101-3-git-send-email-dzhu@wavecomp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 410e24be-5a45-4220-4d18-08d5e796bb74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:kpt5Vu51khTVPE4qqmA5CjL8X5VdWzcl9Kv0AdaDj5QHpX1Xs4lsMV6fNJJS1LDyCar+jTD+pFYHzkEV3gpHuIrKuMNYic+Ulg0tkTaF4GPvCumK3ZBs2z9lfRGojeaVZANGKBPaSwqYYg3fzwBhTRfM7oTHHh91Ua5vV5oTxnDbS5+xuQZ4ECStz/E9WsqTsuRLorkqaJTPcUKTtDwYU0As1GArNsYL2cXqrR/VeEbexxMfWmbmrdBdkaBeDM66;25:1iduhuKIdOcHhoEWyCLT8h1k+cVykGZEB+glxmDord9f1C7oz4lxP8yMF+Mn3PN1Yf6jWJmqNr5FTs1jw/0Xilfd5BsoZ9rN6Uqidm59cFXp3CqFCjXHocJ21MpxCFa5K0lc1Ka72va+DfWC7aMH2uyjZWDAdE+nhDIvMYKQoz3YdSlhQBD07hcgvCZ0P+QakqRpzY6Cw8dWezlXwKQTPqLEOxG1IwracauiIreeNn5cyvKwpdrscD31sjM9hMwwL6lo4Kt4lBtmOF8snbZBk0ZQsfaeEOE1jcK+AetFbf/d6IHBDM02kyVGjIIMM4G+9alB4r21aEliDOlfwsb+5A==;31:AtYttOUbJoHljBv4bUfxJdrpwSvXolCmwSigxeC/PFxUH+lheKHqG2T+UcXJl8M0CdpEgLcpyMF8BvvhduqOCAFKqwSBg8oS2kqR8YDUdWoROMTzXu6th6qYS7s6J1iqALKkZhb2mK/RUVb644iIyXOcXWJPkujziL1wo80+TGXYKEDV4nUf39784fWSpBjtILqrP4DQsFw2HpUaP6BQ6MK7rDiO7FTWz4ALYLvvGZM=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:52msDqFzUHrQh2QwehpLhRwEzRlDQ29XdCydgqPqDOCvFFo2SbQ21QFLYvfTn54oPTxNEHdeyJhFKL+a4dQyh0XO0LRhZ2Zmb1M65acp+b1EpQ399DZGdHGJQeQtDMv9p0liEM1NjhNEVuaSz1RFj16K5XXX2JH4BMkuLfcpFTvAxz4SG/i4SZ2sZibfC6tbXl2Yh9MPrsHM5r+eh1CMsCKukt60JxOfBbw3Xggw5kv36vTjFIzw3IdKmk5G31HZ;4:MhbOuTL4xkGprgttlZW6nZfdaQu1Szbvl27E0LjEjsHS7tFIhkG6wJgtY5VNlotlF7FF3dO2c8aHP5/Oj1L86YSP/EZ41ZBIWTOq3Csaevse6R2gg1d2dA801Fm7Hoz4Ue1sYxnJLt6AM1WOJFFQbpBfJtRoE4FT+Tyn2wXLghUt4jClNiVrPXfaHbb9/mMyj3NKUPjA9qpvH1Cu8qbW+GJHd9M+jXvvCnWQ1l9UhofRBOM7LeZOhOmk+9gyJ0DCfEtqyjHuW2X5IBtSKw+xXw==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB21510C4A29F42D1461D11E64A2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(575784001)(446003)(486006)(11346002)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(76176011)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:3NW9V59gafhTUx2gyZOr/TwBwRE3DxhgC+U8g/x?=
 =?us-ascii?Q?igj4ce1k/I2QX9KAQZyZuitkujcM4sP3gu0VlFZF/qDk3szvlnUEEJ8nJUF9?=
 =?us-ascii?Q?DqY4qJRGA2TTVeAtqFAC0Ki/+9giaTgvugMsTuImg0z6v43LA2LU1gLwS8am?=
 =?us-ascii?Q?B63y2Eh6OyR45b48rNr+vZg3oymFXyWmEHMoyJhdXuxNq40eEBTCP0OxLanp?=
 =?us-ascii?Q?daIUGiLGdQVUfUcGdu0AyjmNhytBiTrRXrAwuNAqpE72ZHr6AhuE8lX9lQji?=
 =?us-ascii?Q?12W3gnUjzUWa4jQbLkiloqXRG7tg3mjGCrD/IWZYCN+MY6KW+8+3R0oYCRfk?=
 =?us-ascii?Q?tP5Du3ZMatVedf1vqimJeNb+XXMh8i8REkyjP7JHUGfuxwQmHLBtXAPItW4h?=
 =?us-ascii?Q?vsf3NVDXajpRphC7U8aiP1rYupcdZ8hJeMoSJE4mw6D5K46thb3I+pRuMUJk?=
 =?us-ascii?Q?YCRpd6uKiEYzLaLUEH4c+hqZIBGGXjf+MFRKeiBV41iKwNOUOqPRl9TQ4tTJ?=
 =?us-ascii?Q?KB0ugKW3+jQPkhD4KbARGC/5sH+9hhn3HzJleKATVNDCYjNsUhvYCZ6GJPbT?=
 =?us-ascii?Q?j11pPHQMMB0q8U4fKWcSvgOeV9hY7wpIgYVevIHTH4TwBwF+MU1eMnuIX+Gx?=
 =?us-ascii?Q?+xg/jN3U7OgOtfPDc1Xwo/OQ+Z3UqFgo4VTRDlDEpMbCOmhxUMQnhLbSsECM?=
 =?us-ascii?Q?Rj60X1smgcyLfQ04402bozuus8PkHASqqQznk9WcxV5FE+duokCohrDlSE1p?=
 =?us-ascii?Q?DzT9tq2JJkFavpiNAK+3PR87BYbZSjlzKRRNADOgviwSDKsDXRO2TW6/8Inf?=
 =?us-ascii?Q?H8nditpSIWGbR+TYNPtouiZ4c/mo3ZOspF12Y+pC+Rbg32sSj+dxUndTsl08?=
 =?us-ascii?Q?yBD2w8kkj2KCeiEZkwisS1TZBFvFvHVM4TozGqwmQBcjlolE2QrAdlOrnnsj?=
 =?us-ascii?Q?Yft49FagoX9g8igEV6JbErcKZN5QrpS7qMx/8JJ8B1HZWgGdClkg+Ybj1QqE?=
 =?us-ascii?Q?TwKoxQhPJaDcXFFjemH0htL7zsd5SEnuyE6x5gIwel/JMCBvjOP1uQh8GtN9?=
 =?us-ascii?Q?vcpqOqy46yRhMLOahrfcAEKuMo8po6RtCVCcBbtQahVpl8byheRaJ4DXuVSI?=
 =?us-ascii?Q?y3eylLP0pBc2RycHGUkRvJVw9qeaz2qX3l5cS0OqPKWCzVm031F5J4wevYtu?=
 =?us-ascii?Q?lHiu9bNW1GY/VVDd9HLrRrHTp4JFjOcQwuwGvnQ2fGsGkk3IWSE6KTbDlOw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: i/8RJfAnBcxUgtLvhHG85+ao/ckcUpnyxbIXdClVMcin5y7Mru01EB83BhMZZbL8018j95dAagRlSDxRvR10uqc85u/uEjRjmb7YFVmJ6IB1OOWx5L3vlN1U5N55oG6Untc5IFelpYeIId3xqE7SHNj4CIpt/jWcnqlaa36MUjpnM5yPE3GOi56dTesWK5g87JehwuRfUVgeIVccMyNsA/eqzU6nK8+N0HVd0wJs0GiaXYs6qefXitx6LSG54x3aL3K15Ip+/J5SQKqb6OGBrhOoqxax9WtrJoAvn6di9ExV3UTxfn+yOMmR+dO8QhFvInag85oGEI6qgCnO+vUzvhkbAjil3a7Vbn/ca9IcZGE=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:Uk38fiWO7+W+SQkB1zrCbO00MplUEWSNkfvbrAoFKDpwRsRSeFHKcNBU0HTCEASC6h+xHuF1O9FQhu9iUkBX/xRoXKQ+p6hf/HCaMIZuQOCscyUvfLCQXm3ylKMkcFQgHzhR/R3ORkprml6fu8XYhAwUTFw96lzeR48Lmy0O9J7Uuv5JmDyNbjydRR7gJENDkvqs4IucnSXM9btudXLvY+RNuGweCqEML11scpfaws+Zi8ToHXysTBPiQ+OwFd1C5XnIidLKZfcIBexNM5hfPPi5x1wF5xtqLD7u5RJp6glzkf8DmpYUglYq2eHGCbkW06znMw/Mut2Q26YM/r0cPm2imTSmGf7p8p1oozGcVFRb4laPuqw10MfMqQ78RCGm4HbjhGQjF0aYOBZtqAxhe3PjsTARyM9na9QymsKSEauWu9NlQT+30pjWQR7F7//TeVTtq/IXgCfXIE2lyOuAxw==;5:39CzJvLTd5C0F0yMos+xIySkrY8Y3b+N4e3m54CFHooC/AUmSWcK0CU0iuaY8ah5tk/4CffsUJQJPzfwC749O9nCREYgeasZ7MQMKtPDtr+PXQW9vxEx2+du0FhCIMhWF6AtpTbUlDlqBNy7NoDSGaB7qjthopanvep1wYr2OWQ=;24:wjsR055KP6T4P9felp86W9KLS9mGQLw1CNkxNJoJqK26o/r6Tj8Nx1s0gcvi86oUIneLfjSoZhYEAdqqOjUaJy7w/Jemwd5qZmTv4cvTUus=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:HBFrAiKtHS0sVNk1TB2EZgGuzo08EGXBIMjjzeJBxFA027oGCCDhIzgy2gykKTKczwA5ia5/Fwok3FY9xm3lQkeekFUefQRmIVe3OsLbeH8Tn5UbfR6n06oRYjwXc5cQHSgzNT/oEJWmG+tuONbilUh+GLqz+tD2fiFqk3DYPDSXYA92VE1kBrRhsfuItmHDx7nC0aJ8FmD/8jdl+4E3RCVPt/a28W/lCny08TQfeeJJFkIDFdp2tmioUbZVMTQ7
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:11.6493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 410e24be-5a45-4220-4d18-08d5e796bb74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64810
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
Changes:

* Removed "#include <asm/mipsmtregs.h>", which is unnecessary.

 arch/mips/cavium-octeon/setup.c  |  2 +-
 arch/mips/include/asm/kexec.h    |  1 +
 arch/mips/kernel/crash.c         |  4 +++-
 arch/mips/kernel/machine_kexec.c | 27 +++++++++++++++++++++++----
 4 files changed, 28 insertions(+), 6 deletions(-)

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
index 8b574bc..7111fa8 100644
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
@@ -26,6 +30,19 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
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
@@ -79,12 +96,9 @@ machine_crash_shutdown(struct pt_regs *regs)
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
 
@@ -132,6 +146,11 @@ machine_kexec(struct kimage *image)
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
