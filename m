Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:21:00 +0100 (CET)
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:52096
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993885AbdLAXTAcvi0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:19:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UkQz23AOh9hXdJQTCLoit2GRonqkF6wEu6wB97CTVWM=;
 b=m86wIaoNZrlMiE+9aP7yZs8Otf5/fmgHpL+9t2LiRIx8pn7TZxxu4hgvI42MB/3AMYsuHu4zn0nYX1Zxb+DotR0dUrMxefOUotEJat5WjpLy7v3g2m5pgVy2M1p8Pc6ehaxzEewa5krwfDuDytZcprL/xGI6uvUyMg+fg7MlLV8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:50 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v5 net-next,mips 5/7] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Fri,  1 Dec 2017 15:18:05 -0800
Message-Id: <20171201231807.25266-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819b6ace-9a8a-44a0-7298-08d53911e1f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:FFES+04POybr9Mf8W9B10iKXJGmT6o3caxNbkOWx0rZXKjtI1Z21Yys9tY8UG0I0yUujQChVA8R2uHHMAW7tca5RskJHhMlH6V1vimmtCESNwHpuNnOflYhIPorl0qQD5uS6wR1Ci4V/XZf2o3dO0dewQO1AO0cdl9F78SuEmr+erbeKM+UZ802ELEFoJhL2SzCrU2cewN97AIi3ycowEM39CFwlUGmpW6JW6uo/VqgbrItdyaLp88BRefKKpbGb;25:qG4BqKlizlk1RfNyYT02pHaYFD9rxG2kKWGYCHk5wffK/A/xIGSWDIzqX/X9BoYdzFRIxkPN5L8YWKeKyi1JoDv/cdzaq0yiRf84h6VD3nP3R43LIbANbJ/AN7ABGf0Snb+fvgHCTROolL1qDBOh/TZyV86QYY1RJbqp+xA6gDWXMERilwec7d9puQV2KWKwPrN8ywMB3IFoF4FZ4NNRaHoxlX8dOGRf5JpYDRTAT+U+AT1UpJn+YbtBTCJwRHmQwn1qMgf4saAja0SSdHX9YLcyK62ScZjl2pfZMncWI1H16E3rmeecZ/Oxl3UyQHnlMyD3J/8boIuqkx18CkK//A==;31:6CQzLPyyedOvkZYFpfwKf3uAMaH4fyLbbj/WkdWR/DZ+HkENqaI98G8a4mx9sezbr6ZpCyUBaQ5pBZxlQsqK9GwyOs7/Bk0Awu7LHzJiw6kjwai3Y8A7iGmRjprbBoS+aES1g/ovOgoLsuYaZSb0aAhKyhNOfUVD48vr0bqUYKHdtsz/vV1D0Jg8NhOOwxhrYFaxuyG7DK3hojK4OfXSeIjJiOBFrNMhAohXLaEvTWo=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:ib4658o2yli7asfLv34U7gUVgA205kVAlDiX9FRunxcF7FrlfSILPFosNWzg/84mk+/PhNJ0RxEoXkdo0MXBw6m51eOIy58BIuzYhA++dVowMddb/c/O5gyi1hvaZqys/XVjHI84g9uzsa0vis3baVGJ8w+I1XyPQPNGbA9trM1QArx29mfLksI458YWsIMyDTDxNbmt81AfvRp+L3q1C0CkdQcUrIiY8NEdRCXJYSMH5aa0HDNkx3ohFfixmtGoJV7cEmaj30IifCeFYEytD1P7/1dzagYYT7CV5voEt6uDNW7tD+vshsu7glI1Wxk+HAf/aHETFdPh/KoJqt93VQzTwE3dQ9wji0RN47Uflw45z3cvnSFU7hWxxtstDq1ZCuraI3cGPDqCXkbDAOwRZ5ArF9a2k7NaVIY6P1ip213S0/svWUQggE5/7KhmqPH4UO2mzAI+Yx46p1xVYV+r2Mk2B9ALusOC5F0HrIdxUbuWgkM0CMBreY6PzrXzTmZ2;4:wb+8zs9woB0Nh/bCqH4RBFCYAzW81pLdd+ycuRA3Yv/kMuVOtL+ZK0TVuv8u7H8OVoVbn2csNmgb1TZvgw/AHCQ8H8NLbzxU3Optlds5KN4VyXymJJWMd6YTAs0oIdjRs3Mok/xoxDgGe2kEWG0oxyQWFm70DJpwvJaXVol2pondsdVyaAUdlBxoMxuGHNRkTEcfyvyC8VXOThC6K4ybOSKIeoP5aErSCGeRnUgb5s8umDoraRBnTKNT1kEFkWmDVrtFr8OpWt2WxaThN5+o8A==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499434AB1A9830A945BCBC297390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(50226002)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:5FLs2x+u78/hIJaJPceCABqxoIz4dsZ6wg9BPFkbL?=
 =?us-ascii?Q?nvxD/7hamQKUwe4cDyhTJoBYm1md/vlPvFIsuJUq7e917YKvuQ//TVuxiwxA?=
 =?us-ascii?Q?NIzIAclghqoQrMjWP9mw9TFz6Oc89+MhVURG+8rZLWIFz31CQhufTMGWRUg2?=
 =?us-ascii?Q?HBWQtkupe1GpVLkJ6yta+kp8K2t5b+LAuNvhgw0Ugb5gNCRtbO411r2TuSPh?=
 =?us-ascii?Q?hx28YxNmboCrWmNGNOzZoPZzkQqTKkSCOfbtWdPxGewQAcBwEbYUb+kn9DPy?=
 =?us-ascii?Q?1y0Vk88EFn68Q4vsOwlgOI3rnOlzyhkrBbX32QeI81AG5xGP8AxNYP/p9xzw?=
 =?us-ascii?Q?Om15MwU5VExCCdhCSfCHT50Fh1tScHlf/K78/m+nZa9X6k4oAXx+o1iGeXnl?=
 =?us-ascii?Q?dTjxATauv0g6V5rLMY/1NO/is7z1/uS5fEqVfi7VGWeUyuvNpBg1DxTq+Xit?=
 =?us-ascii?Q?i0sw8sf7bjrrMfaFk9ya1k/nldJ8meDWxh0UAHXfKlkUnehD1BWLX0/NJC9r?=
 =?us-ascii?Q?nssc6ZYNE6NX0A3T4Iz1GUO3YRV9mt1FJ+Si6+A/KaSHiHHMS307NtYPZpZO?=
 =?us-ascii?Q?lre6L+OIuU6h3KFNmOJzzEjeeJnOcPRHd/PC4VN2++bhH7QTxskihID/l798?=
 =?us-ascii?Q?4Ed/A4ruuoD4EeBGcrNf4pGPFneGM7UyvfkciMNFiBMC4kh3AeM/5YObowBJ?=
 =?us-ascii?Q?qaIsQQDfOOH17T/rODhOLQ+EZs1ie10wWGhq7PiF2AqGwyLumsgjFXJfmwvE?=
 =?us-ascii?Q?gpYvycXTWgt4Sl/6Bz1o9uztTNl7EMuOoKFLI71a2ug9TaYfQo8GISX8DiRw?=
 =?us-ascii?Q?8xBQuaXUpLBWEBSVS2xY9Z2eRRY4at+CiKJrWp34wA26U5uxjg1znzMdBo7A?=
 =?us-ascii?Q?EGDOic2BBW2uARn+G5sFZZYXpMDIcBMueAnn1ax/8qNCWYA6ybnUBvm9u3GY?=
 =?us-ascii?Q?XWVg2vO77C0mn1VcI+kNEvKGkHk+dDBMZ8EdnokkO0/ty2BtwOUZXXYdxVkC?=
 =?us-ascii?Q?g0dFW6RawPYoLP1xqYhHi0l2frrIZvdRFlI5PEVWoqmA1PUdcUQv2QVQIaSW?=
 =?us-ascii?Q?O0vMbKXR0LoeaRngQ9QtTVwc1RiKYyNdI1l37VZnrpp8X75ZSQQrpGiozBxn?=
 =?us-ascii?Q?cAHQ5kUHlDzdOI5hUVZ2HRsKktY/WIJeqHGW4hjG3p3mKdoC7YgGqWrjC6Lr?=
 =?us-ascii?Q?MSaws+yjN5lOkYCoQGu9mEiG4KwMfHNQTL1NvPFHIi+7hA7pqmnogcUZkyMW?=
 =?us-ascii?Q?+tu6wTbZunP8JXQbi5m5xmAvF7hXFfes+mXhHns?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:GQ6dd7D+8FwLbqsmmyYn4LWZwtSUXSCW9UMB9HhObxAzIjPHR1wklB3E4bJ/L8u82jdD0NYMkCo4IRDpTzHyO2vwgcw+4hmVUeqCCVRWiKQuHubyPdcYwt5tqGoIYmrEuSp3H7bFrOZklUpYjchr8p2hekup4sF+7VurzMTcQ+gTmbDU14FE2jQPekH4JMC5Vl4rSaYPXdxyqMrzQd69kfGOONaFpDLnMDuykHdhQvp3SBbeiClW83/LvVq9mf7cbZT0DGOMQ0eePG6ujlFI9Uvisxjv214ditxXhE4Peor4ZZVyuaTTDJkyV478V/IbQI8S10hz47nBtHwhQz78SvCjlXfbzLvY2Y/VpaBrJj0=;5:FIbQMJgDlXoeghZJ3CgqCbqrSn93+xh22fMioeNZd2l93hjdlXdSUlrZQBa+J7sLd6Ruo7cihFY1l3mosSCAGANBGQg7OUvV9iqVS4urYI7B2wO93IJ486Tt5FpLhp98Le45MeUKoB4TAqGj1wp1jBah+9uI6i/7yVmym6ksQDU=;24:BLzCYL8Io3SFWVW/WF9XjGicaVt1VsuJu9JrTeSP11iEcEY3pVCCp/4W3OgW1XkZ4UeztBaFI/UVbtd7nlf1pc0kkwojOelfWUjtBiISjOM=;7:j6if6o7WZD38n2BExFpT65FUVtbDBoffkljteq3IZlcXDB7Gc2Jf1FJBb/aSukDQEcjRGmBCDtEFDmlOdzvsitXd5SdV9/CHalmvzZw5w+B0KWUgj2mFis5ehEw84KjjGsLHGdWWewdwh0gNZ7E8mczzg4FCM5JIVw5vYQyxct5Q93l57UId638cVAU3ZKZ/I87qXP5h90vG2GBZ511PJlQT8hA6bCNUFnz0kNrIQstUSZDdFnqNInC4XMYV7aqb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:50.0248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819b6ace-9a8a-44a0-7298-08d53911e1f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61274
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
index f36263c46e60..0d29bc1f0661 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -390,6 +390,8 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
 
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
