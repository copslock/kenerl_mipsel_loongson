Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:59:17 +0100 (CET)
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:6176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990482AbdK2A5i6OIWi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fMWO5VLWWPUc2vKV/YV+jHZgbEam9m7sxwFkwHvu1sc=;
 b=T78Q2yFT1u2OP/MSBjCx/kZrPgy88K6saHuOFHJWXYAwa8OyobbrwD31me5G0SH07pOm8JCVp3XK3tbdQ36eJ8CcnZKJquO2iTE6z0WafYjPMqFIrS+OJv7fE0s3L8vslNFj4CGP+VUneZrSgaE02X1H/uaX0QhgYZC7P78qRhU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:27 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v4 5/8] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Tue, 28 Nov 2017 16:55:37 -0800
Message-Id: <20171129005540.28829-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f834925f-b203-421d-5865-08d536c42945
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:9FnR/0B9u0QrzG2UwZHr0Qnn4Rjy4fQ/A13i/uCQCkxlBV6K0jBQMlieq8wvLgMQ/piXuBR/j+ktFvl/8ry+Nq5jVwA/qfvB6yImqqhC+lqU357LQJNprzV7cCami+Dhrsd+DhCqriMWyeOkfF84BsZ4IEpwrINioIvNdNRn3jSAGZaT3x7rl11++tETI42tUe9W08qMZ0PtSgjnU5E3+L/FpZA195GSs7/zKKAT+aa3hePl2mYpzW6c2aYmtgbE;25:iLIM0uf5/tGHmnkOFNinVJ6JwFvzlL1myDe7lkkyxsmZArZxuSfqfiK+mQXEofS0cDdQqMhJFD56xI5GG10VUAwAlvwdrilAQ8/+IhSIZjc2wf9SkVNEXd2CI+dtmfIgn60EPqfN+GWl/03gJ3xur3oojuxmPSt6S+IwhOTnJP3v311Wq31LPTy54cjYXAQJeU/yFc8u6r6HN87usmiWO3oz/ysNQ83u8s503la3DcPQuyLPj4fN4MSVpp7F3Ef560coqb/zgOhhwrmQgBpDqOpOZA+/luKRDnGv+EAQ/p2kIM4U0FW0Apkfxi2eIs/Mr5i0nPDTCRXjAK4Ql0SHX9MVsSn6X5J6uAXLbF3hwuY=;31:R8KdxDHEsO7x4tWCwe2GEuaMOVKpYgnHBr488zvNkePkptH/JGmDS+M+JLvHL+AQiUhLMPhoNkjV+MAveMOROCzdrkyOWLKi20dnGEwzzati3QvPlgTMhbAs3NHXni+ymr+lIkUEiFr710cvjsJ8nzv86oMN+pb0A0ZUKy3SnxVYimDNMvZRzzGJe25r/geTU2mBCIGiouQPrSLc//7SpYafJCd5xNcSQPiE0MQQQuc=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:Mm5Nf22i8j7KzlVdSrixgW6kswLrv1gpUWCmVWx7uO1Yhu2D+dzR+MAnanBboKHYh8jKcDyOmnrPfPoD0MrnI7yeu8YXkz1zSqudlmoBGgKyw1Q6bDTkwAUWqPDCrPBx7/iEbhLrZ86BbR6YS2V0fJrMOW93jmNgTxqpvDE7LBod6jfTLozAF1qbfmaImkTgGzUIT1BHa7cplM6HucnqBH+NYwdNtdgFplgArPqiCYbpDZ7YD9F6I+mBMvRGfe/bHFPD51a94F81/Kpy4cgwgJEGpbwmq376c42wFeL+PkMwYHZMRG2YDTLB0g6/aSkni9cxO9U5HKjz3xudY8PzZt5pBGjgVmDERKMqqnGgvu0HSsEHrBLQk0E/o9uyNVTKst20EzRvl+/0xqC8fTjRYUC7RX9FjizjSTf8FiYkRbAIC4CVbTGcK3WVVNUv0iLo+170KcU08KlFo0t3opLHMIn+d9vYTghecSJI9kQhfsGtKALhVdGKcBYhG6ucMBxb;4:Mkdujd+TsIGpxAnizqpUlPGinVPODWucOL1h1q5gDgq4HMcIfc9RGOo9Ov6luMn/VyBCe0EP59D0HpAM4EWC+z+EdOrS9aO8/HAHXulthTMdYATvlU080HTaVeO0qFelvLiqVOR9WZ3RWoPFUGRNNqZc8K0V/wc67/o2wW6trLCawPO7YMPEEPDvQjzbqzcf9wWE6+1oJvW6oFWHs0fjIm+pOzTIj5rNl1fGMB1ARHpdLjLWOb33vh0vK7TlT3kg5QTgCXsaQD/96Zg4oUof0g==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34951BC94B6EA29252477F9F973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:GFlCJmd3dh4qCNXgFE4Q73kwA7uaA9jwWTj0+73CN?=
 =?us-ascii?Q?TGLv1P3YZtnICuCN3ySLlJPZPFHKGe1BWHg2TFrbV04wvie+F89XrEkGpdp4?=
 =?us-ascii?Q?SSaUSWhNEmPWP/OOiXURBzBoJKG+dq0HvWgKqcpbD+aKmraLcU7MX/JFeRsG?=
 =?us-ascii?Q?pZSfuSRJ+YTmY1YlvmfcGuRUHnoQELrUPnOb+QwRSp36FMnYbDwxko21i8R/?=
 =?us-ascii?Q?9QuXafrWk+FTecrbw05aydDLyZs64nrl0Xz+fi9p7GXliPiALJjTxmWM1YLY?=
 =?us-ascii?Q?Bgom4U3AwwIMpzshnQXVQDR8N9iPslwnAlUcldwLtt6GsOcwcEVe5CJLxTeR?=
 =?us-ascii?Q?a6nygbHaINcBP13BI9/x7ttKZlfMgpUCtlp+6LQ/xa7tUZfcpwJ6rnQlQoxa?=
 =?us-ascii?Q?NvzB1t3Yh2wzeHrv0vgzEFg91WQieEYmErjBF1wIBmHNTmIkidSe7C1tp0nv?=
 =?us-ascii?Q?RCs/N+uJDCKe0jivKKcQHO8DgwwO5bOIhOu1pk3tqyP+h/mdA2hSFmyo6PCj?=
 =?us-ascii?Q?J0UstNPGkj+RBnKmUMWiAEvAEWVFBqw0vQW3vYYQiMjhEcxohRV/6H5GM8dG?=
 =?us-ascii?Q?uqVguiCqwFY2cgBkPRWmqyXDVmsmp/WYIp95Yc2xA5kutdmGTLY8r/+UYcxI?=
 =?us-ascii?Q?U+rlaHwnsKLJ+GVpry300MJkSup7pougkFcCYzBuQGweyUMkjC5VW0vyuuWy?=
 =?us-ascii?Q?0z1rheu+HPiv0/7GDPc2LobTsjwZAbkjhquqvwtNa3nPH/MlvfpGT5cNnPAB?=
 =?us-ascii?Q?v0irhg15jPE3/LF9xo5Vqz0qmEihPHtXtZoTVDeIMZG3gapMo4H4MGDksDd0?=
 =?us-ascii?Q?lwU7yEKA9Xxyh4djudniTyEYl+LHAzMVuAbYdxkBhZfqFFimvQClIbXEuH7Z?=
 =?us-ascii?Q?DsEN0rhFyT/06L23hX0F9r5kNUPKXpp/5Fhx9/5lxxds2XqE4E38d1ZtUSZC?=
 =?us-ascii?Q?R0pNV+zSukiz+Y6KJwEbD7qY68bC0hPHTgGekrPuZj2lGr1x07LyJN714JXX?=
 =?us-ascii?Q?SJWv1CwwknCI/qpO5LpuWNBwHvYSNR1q3ZIrS1Fi7A3aBsO5o1NcLL6mKdLA?=
 =?us-ascii?Q?Xa6Xrcnln7LJemJiZQCw0s/O4J5AaKXyG2D2ipOxQWAb2zzom5v2Uvm98cRB?=
 =?us-ascii?Q?hltHsyjGGjhbTseYSYovNtAdRKlrjbFURNDZkopF34/J80GIcHFTmVA+Fj8D?=
 =?us-ascii?Q?Q1h7ewkXYczyU7PC2EADL6SVwBtpNjWITUiIAVzoS5HFtjSuGVvWwb0MDyuR?=
 =?us-ascii?Q?3wLvcWc83Xbi6V27ReqcZmobCNXuEOsQ7dkf3GVtvGEjrTukTiI4QmxK2LzE?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:UGHCQuVPPaYYamqOJqzT/DTsgA1hCmctmsczALTWg+WUtrGrNBWp5QefAJCt+SKdl5oTZEhGKtutLvFinHkXhG3Kw8bTuzPoyLAvbP0TJHj6ETpCxW3PBnZW73VQPeiLYt6Zt9ZhTKKTRVAFVzgZ91GYMYFtUP6jbgtwcijCR7doevBqFrctC2WBiFv/39FBePO8yWHXLNsYAkS96nkd2do3qGn3OKvIi38clsaPuxxGl2vQj26glag2kI0KTBVwG7FXKOSgLOEJiZL1z52bpUE0feYaPeQ/7nfhx++MZ5JYVB+9zby3fBcr2MnA4msLWEhSoEvWc46DKKdHUnhce+IMH8BvCkRV8snBC2ZiMko=;5:M63n01v52ujoW8mCiOah7J59esypnoVIqHn78cKefWRAYiAXKyj2fMU6cDJX764Ur4DNXtWK8DX5XObzmTcfWyFWGuHLFLbuUojO9da2DaKyM/DcWrg6rOZERBZ/UvRjuunWZakbGQSRgXaIYTor44gr8gNAnvFFIgdvbjN5+Hk=;24:qH5SGoNp/dFK87ArMp/204qz5CDInCXJBf58xH7oTFxR+WW/+YFaAAmUbqcqHbSTwQMeaFCx3StoquHPmXNiVJ6esP8Yozq9lNFXNFvwhUg=;7:J2KhPaSsO0zQ6lCgFGL2p+LWtIcojJg9SmF7fiSGoYGIwtwiKzIcMfII0u/vpmibKw7dFRk99aoMsRxguAXobX+ZZxRb4bCucbuQx6FjZvF19/zD0B6KyIa0SkCLfyTWYGf80mUcIFFPtB+M2g8/jHYAZVysKhzOa706EcfVANO/HAVhZvAuVlm6rR1t/xMmFUjtkEL/U5R3v74wlgf9kIqcAUXAYhZMzL8iPZU2BQvDTjk911f3vsKUmq5MRcmy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:27.0759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f834925f-b203-421d-5865-08d536c42945
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Remove CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE and automatically calculate
the amount of CVMSEG space needed.

1st 128-bytes: Use by IOBDMA
2nd 128-bytes: Reserved by kernel for scratch/TLS emulation.
3rd 128-bytes: OCTEON-III LMTLINE

New config variable CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG provisions
additional lines, defaults to zero.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Kconfig                    | 27 ++++++++++++--------
 arch/mips/cavium-octeon/setup.c                    | 16 ++++++------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     | 20 +++++++++------
 arch/mips/include/asm/mipsregs.h                   |  2 ++
 arch/mips/include/asm/octeon/octeon.h              |  2 ++
 arch/mips/include/asm/processor.h                  |  2 +-
 arch/mips/kernel/octeon_switch.S                   |  2 --
 arch/mips/mm/tlbex.c                               | 29 ++++++----------------
 drivers/staging/octeon/ethernet-defines.h          |  2 +-
 9 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index ce469f982134..29c4d81364a6 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -11,21 +11,26 @@ config CAVIUM_CN63XXP1
 	  non-CN63XXP1 hardware, so it is recommended to select "n"
 	  unless it is known the workarounds are needed.
 
-config CAVIUM_OCTEON_CVMSEG_SIZE
-	int "Number of L1 cache lines reserved for CVMSEG memory"
-	range 0 54
-	default 1
-	help
-	  CVMSEG LM is a segment that accesses portions of the dcache as a
-	  local memory; the larger CVMSEG is, the smaller the cache is.
-	  This selects the size of CVMSEG LM, which is in cache blocks. The
-	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
-	  between zero and 6192 bytes).
-
 endif # CPU_CAVIUM_OCTEON
 
 if CAVIUM_OCTEON_SOC
 
+config CAVIUM_OCTEON_EXTRA_CVMSEG
+	int "Number of extra L1 cache lines reserved for CVMSEG memory"
+	range 0 50
+	default 0
+	help
+	  CVMSEG LM is a segment that accesses portions of the dcache
+	  as a local memory; the larger CVMSEG is, the smaller the
+	  cache is.  The kernel uses two or three blocks (one for TLB
+	  exception handlers, one for driver IOBDMA operations, and on
+	  models that need it, one for LMTDMA operations). This
+	  selects an optional extra number of CVMSEG lines for use by
+	  other software.
+
+	  Normally no extra lines are required, and this parameter
+	  should be set to zero.
+
 config CAVIUM_OCTEON_LOCK_L2
 	bool "Lock often used kernel code in the L2"
 	default "y"
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 99e6a68bc652..51c4d3c3cada 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -68,6 +68,12 @@ extern void pci_console_init(const char *arg);
 static unsigned long long max_memory = ULLONG_MAX;
 static unsigned long long reserve_low_mem;
 
+/*
+ * modified in hernel-entry-init.h, must have an initial value to keep
+ * it from being clobbered when bss is zeroed.
+ */
+u32 octeon_cvmseg_lines = 2;
+
 DEFINE_SEMAPHORE(octeon_bootbus_sem);
 EXPORT_SYMBOL(octeon_bootbus_sem);
 
@@ -604,11 +610,7 @@ void octeon_user_io_init(void)
 
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * kernel/debug mode. */
-#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	cvmmemctl.s.cvmsegenak = 1;
-#else
-	cvmmemctl.s.cvmsegenak = 0;
-#endif
 	if (OCTEON_IS_OCTEON3()) {
 		/* Enable LMTDMA */
 		cvmmemctl.s.lmtena = 1;
@@ -626,9 +628,9 @@ void octeon_user_io_init(void)
 
 	/* Setup of CVMSEG is done in kernel-entry-init.h */
 	if (smp_processor_id() == 0)
-		pr_notice("CVMSEG size: %d cache lines (%d bytes)\n",
-			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
-			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
+		pr_notice("CVMSEG size: %u cache lines (%u bytes)\n",
+			  octeon_cvmseg_lines,
+			  octeon_cvmseg_lines * 128);
 
 	if (octeon_has_feature(OCTEON_FEATURE_FAU)) {
 		union cvmx_iob_fau_timeout fau_timeout;
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38ce5a3d..cdcca60978a2 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -26,11 +26,18 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+	mfc0	v1, CP0_PRID_REG
+	andi	v1, 0xff00
+	li	v0, 0x9500		# cn78XX or later
+	subu	v1, v1, v0
+	li	t2, 2 + CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG
+	bltz	v1, 1f
+	addiu	t2, 1			# t2 has cvmseg_size
+1:
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
-	dins	v0, $0, 0, 6
-	ori	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
+	dins	v0, t2, 0, 6
 	dmtc0	v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
 	dmfc0	v0, CP0_CVMCTL_REG	# Read the cavium control register
 	# Disable unaligned load/store support but leave HW fixup enabled
@@ -70,7 +77,7 @@
 	# Flush dcache after config change
 	cache	9, 0($0)
 	# Zero all of CVMSEG to make sure parity is correct
-	dli	v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
+	move	v0, t2
 	dsll	v0, 7
 	beqz	v0, 2f
 1:	dsubu	v0, 8
@@ -126,12 +133,7 @@
 	LONG_L	sp, (t0)
 	# Set the SP global variable to zero so the master knows we've started
 	LONG_S	zero, (t0)
-#ifdef __OCTEON__
-	syncw
-	syncw
-#else
 	sync
-#endif
 	# Jump to the normal Linux SMP entry point
 	j   smp_bootstrap
 	nop
@@ -148,6 +150,8 @@
 
 #endif /* CONFIG_SMP */
 octeon_main_processor:
+	dla	v0, octeon_cvmseg_lines
+	sw	t2, 0(v0)
 	.set pop
 .endm
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 6b1f1ad0542c..0b588640b65a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1126,6 +1126,8 @@
 #define FPU_CSR_RD	0x3	/* towards -Infinity */
 
 
+#define CAVIUM_OCTEON_SCRATCH_OFFSET (2 * 128 - 16 - 32768)
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index d184592e6515..02eb194b2cdc 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -392,6 +392,8 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
 
 extern struct cvmx_bootinfo *octeon_bootinfo;
 
+extern u32 octeon_cvmseg_lines;
+
 extern uint64_t octeon_bootloader_entry_addr;
 
 extern void (*octeon_irq_setup_secondary)(void);
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index af34afbc32d9..1a20f9c5509f 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -216,7 +216,7 @@ struct octeon_cop2_state {
 	.cp2			= {0,},
 
 struct octeon_cvmseg_state {
-	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE]
+	unsigned long cvmseg[CONFIG_CAVIUM_OCTEON_EXTRA_CVMSEG + 3]
 			    [cpu_dcache_line_size() / sizeof(unsigned long)];
 };
 
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index e42113fe2762..4f56902d5ee7 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -29,7 +29,6 @@
 	cpu_save_nonscratch a0
 	LONG_S	ra, THREAD_REG31(a0)
 
-#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
 	dmfc0	t0, $11,7	/* CvmMemCtl */
 	bbit0	t0, 6, 3f	/* Is user access enabled? */
@@ -58,7 +57,6 @@
 	dmfc0	t0, $11,7	/* CvmMemCtl */
 	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
 	dmtc0	t0, $11,7	/* CvmMemCtl */
-#endif
 3:
 
 #if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 79b9f2ad3ff5..3d3dfba465ae 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -115,33 +115,17 @@ static int use_lwx_insns(void)
 		return 0;
 	}
 }
-#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE) && \
-    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
-static bool scratchpad_available(void)
-{
-	return true;
-}
-static int scratchpad_offset(int i)
-{
-	/*
-	 * CVMSEG starts at address -32768 and extends for
-	 * CAVIUM_OCTEON_CVMSEG_SIZE 128 byte cache lines.
-	 */
-	i += 1; /* Kernel use starts at the top and works down. */
-	return CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128 - (8 * i) - 32768;
-}
-#else
-static bool scratchpad_available(void)
-{
-	return false;
-}
+
 static int scratchpad_offset(int i)
 {
+	if (IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON))
+		return (CAVIUM_OCTEON_SCRATCH_OFFSET - (8 * i));
+
 	BUG();
 	/* Really unreachable, but evidently some GCC want this. */
 	return 0;
 }
-#endif
+
 /*
  * Found by experiment: At least some revisions of the 4kc throw under
  * some circumstances a machine check exception, triggered by invalid
@@ -1302,7 +1286,8 @@ static void build_r4000_tlb_refill_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
-	if (IS_ENABLED(CONFIG_64BIT) && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
+	if (IS_ENABLED(CONFIG_64BIT) && use_bbit_insns() &&
+	   (scratch_reg >= 0 || IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON))) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
 		vmalloc_mode = refill_scratch;
diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index 07bd2b87f6a0..e898df25b87f 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -32,7 +32,7 @@
 #define REUSE_SKBUFFS_WITHOUT_FREE  1
 #endif
 
-#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
+#define USE_ASYNC_IOBDMA	1
 
 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_OUT_QUEUE_DEPTH 1000
-- 
2.14.3
