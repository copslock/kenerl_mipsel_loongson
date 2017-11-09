Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:54:03 +0100 (CET)
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:17152
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990493AbdKIAwRg0wFQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:52:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZdxxpzyVo8L/0iv2itn2BcJbM1eyksWoYsroXQLjyPM=;
 b=T9D8klh75dDtQ54D4mdVRgvqfp4E0UVXcAtRdrMl1jgcBkY0hH7e3ZhpF2vnzVHnnmWa7PLSJces8IGtuWwEHjMqJVQ+qerBbCZH3lT+kXpI6n//wnBJGPapHr2ra0mhCkTTKHqwVB/2HV2WdKYclqII2x9nStuKu68yRPDhBF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:52:05 +0000
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
Subject: [PATCH v2 5/8] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Wed,  8 Nov 2017 16:51:23 -0800
Message-Id: <20171109005126.21341-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d550d4-9741-42de-e062-08d5270c19f3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:/589jhaYPp8fl4vm5cQO0scQKmsFw5VB3Byw2A/4onqTUAXjbObjIJF3HY8+QN+QKpM0WO8yNatnUQAn/HdOOHcHqAuKLT1oqrY521054mDqMK3hDg7wfh73pUH932vzdXMTmE8ByRd0FjzF049k9eHeL7jAhiQl9Ca0jYDhubvXvqk885e5WKTUR+OoUzMNXGq6/vqz5MUUHMA9k11blBfQV1c3RqrdeAMqjvdzojsWaHcxZ295tGnDGbFrHVcB;25:34W7zQnP7ScOvwLUzSV+SqDbAz7qxdbA0ztm+Fj9EbZk6nY5phcuUYrQ35c0hBjhJ7xyzZ2p8Mbax3Kj5pLjWIITJ5ZiUi0ET+plc6ppPhqXVYiKmv9HATsLu/s7ee54Te95jD1soUGWiXKhLImNC9FVAsQq5q0Y0hUJdbzOoaiSBBDPG28AFBcjM2+19pnTKejAs4KsfdJZVagS7EAcq95MeWW+7cqvPCi/9SS0PGG36Vu9W4Bt9YqWPCeuA0WCy1DZCfGtLa9QvWy6ygBrZSzUwjPHm0wRxXsV8gTNL7uULYQXBMYuby3yPX9uwGrNiUMSjqIygpZxQ3JRic3xRQ==;31:hI1zQcsx5CemtMHHs2iw4rAU5tB3wMn+LbospjH6mcGuNh8zdi0uu03rDIR9l7BNE8lNlBgMsUPiOyHcA+k+CaC83cXKvJc/2cdY2H3IIYkV5xfYkIkeBrGyICKK7xEOoG/0QHojPY3cAg8P/PNe5cHZN51fL9HvWW+4BtG5ulYQXr1JFOfRiPiXc9daZs3ecz3y5Q3Zuvv8lgsCksf2dDCLYaWLmXVewEh7D2r8wEY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:1VoFXvdtS10BnKrzfz+zxhgcilt9Q5JAv8w8WAiGnyqw0slMDx/8dXNhhXVAx/nbekFpNY/4lOOUijGqjJgIiixbSd6X8ZNum05HaVqCxs1OpNlaXxZbrq+G8NFDTk/wZQPQO2uYn7TLVssT2eLd1GPQPWpFneC0MugHHbbvQ/JhqOaI/mV4H5UL54ctgF5tsP+ryFSPE1D6AaESKm//B2d3LMy/D6OWQbGNNLV0luLEfST/jeHeW30Mm+83hHS1MYGuuZbURhK3rjwXRHWLOssF8jepPnHx4uvObYr8/9DEY6QL1SjwBnGMR0MSlaWORxwVJXtv6/LKhRtGsvJFJl+wYWTWWS+S9zPXm4hyfdYHUDL+CYWLjKaQUUjtGJIPcqiTcSZeBMLM3E0amQ/EhdeFUcLnDBrs5AV9Q937GN6TbqTiqflh2OhD6CzeTiWYq/9W0fJmO09fPnduGvyUVdIFMveJ4XYLsz9YWpx8crbwzCQNg36N5ECEb7pcf6VH;4:SVAiPl0od6ax1oklfUamRuqExck/6HZAUy8BWv/8IyK9v8w+UmmurZipDN3Vx6CaO80k9WEt0TxTJ18ku1WhKC9OEGZ20oX7CABwVZ4v+rnCw44oxfV9DbHSVwO5NY15tAgSZgV15ZpilDZCnnxm0t9oQLTDkk1vVUcu9Kts+ndfVuESKx183MSu3LMUvnSB062pBMZgpl3+KXJf4t5r+vkBX05A5ylZfP6xez45JH+SAfZAdNcUEzXo9bRO6bWlN6MG3b+LVdkK7ZomnKFYLA==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34957658044FFA61F8271FFB97570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:m/FTQAodAN9/UXCkzfKMxJOMcSboxSeJ/GyZupPBp?=
 =?us-ascii?Q?I4j018IZ/ZOMW5mHbKHnfG0SlK5NsBMEoQb3mH5J04EQG3D7jBe9GCN68Dvg?=
 =?us-ascii?Q?2vP7ZEcWBl3gSpwltFaQ2Zr1QIMRUEfWraE03cKuer0eSyrKZimQXl74XerC?=
 =?us-ascii?Q?PGxAyPxE3PIkpu9JSNhMkjLWwIJL7ADXChV6zfQuqLN+diD0Ploh4Hn4gbPS?=
 =?us-ascii?Q?PuEiVoGUsQuTtDxlJY454cOMTKUNDEPuZM35boo3+t+TKctXfuM72D1RRZt1?=
 =?us-ascii?Q?+aeaQ0E6KpknRiKQ8BoKzMSh3Kd+mF+GCnUQkkKTG8xaE28h60rPRQQOzgba?=
 =?us-ascii?Q?kNUaSSCzji4+3/vvofTWUeR/0x/rNLPwDdfpNXZpoU5q1eTeqXll64tlTEDx?=
 =?us-ascii?Q?gQbD1rPCis2oJKaLwUTEaFXhFcjTGiqH3PJH6c+k2wDiPhd85Ce1PYXAMgmq?=
 =?us-ascii?Q?N8KeyEbLmpoE/gHo0UNlOMLUZl7ynWgeKEpxCx0vcy2EUwXY5Nwg1kX0Uc1W?=
 =?us-ascii?Q?qy+S2xFbcDSzLYWjlWe0zEcmUBeiNek3jkHy4Cb0TYVdlx2cZUz0rpu/HnXk?=
 =?us-ascii?Q?HY+2e0nPPhPdACgBTbD+ty0/g+Mo/lgJ3xoa5uvwHdnG11U1EypQF0YH0ZI/?=
 =?us-ascii?Q?bh11osCJizPHfD0rjUfHQP6ttlkvbR0o+sjL+V1/CBZwjDBPhdG8dtebMpxR?=
 =?us-ascii?Q?FcySwBGNlZA6GNayA1pau2AkzNRS/itkn8tdzRZRy8aOxOqhjf27ZsfSY+XH?=
 =?us-ascii?Q?1QN7SebuIzZX7BRep0WNkonAoTRAksefTYZycPAuEqhAzFyqx9UygQbWoLHY?=
 =?us-ascii?Q?PArT2V5Tyt+GhHBLqyYjZQevwNnJZQwyPjuK5kaBlEfM8pIrz03Y7324Mv/Q?=
 =?us-ascii?Q?cBnGHMYmlyCm0z3yS08xF/E+PsZnvrlBnap7kYC4GMGEilwrRBsHixCHcCR4?=
 =?us-ascii?Q?+z/n5m/trE81mLjWKMB+HGu2wHmYx7L/EWhDiKFxgmYlcpLLhHe7BmvY5d7t?=
 =?us-ascii?Q?81lCPMp3ZjY+XmKFTAymYshwEMh5vhjFjA61Y2d4sA+m+j7cOwvR3Zirwa7r?=
 =?us-ascii?Q?jaQzLs6ouFJZLSuFGlUMwHtpv8LBdGSBqmU9U+Upevpbe5HimBWR/M9CPtpE?=
 =?us-ascii?Q?/VfyRD2YK5ahVrv7+pHG1jd6fqtH4wKRsOUO47pXi4+z5mqodwCO0Yrs+JZK?=
 =?us-ascii?Q?kYiP9QfW5O4xVPgwnz6aMhsrYKZagSntEq+c+XMR8ihQvUdxbuBBdzRow=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:2S249YT4GTmPdPc/DM6F8O7Ono5tKcrxPmtMnPaCdGVKhVmzzyNfYtz/hcY6zwU+ZtU0KRvKsU4jmnNrZmIzoeKJCWVhO9u32YQK+n4zgkSQYrJb2kQGr8NTUrq5a7X5LiMVGbisZy695Wa5xrcnWxCsNCjzE1Aj7+SvyUsppFdZdgIYRCWQgNHTYGiAspIpwERxOeGOzVZOrSklYwkKjGhVFfBy+ffFsrcqew8Y4L+gd6VwRCU2cyXVL3iYI27JWp7T+gHOHFY4E/GIB+UhhOYwaRv8dDgfoxDEonhljTzHkjG5JgBDeFWzBzPiQzUNqJWMjwepOBm64aFNy1UPtJQVF4x6bs8+vPTIf/+X/6g=;5:C8u7ExqlGZuvzE3klIHn4/AbdFZQZqC7yN7Mu1S8cOSGEjN8shL1L/+DJcrIJ/P/bcdNPRZIO8UXHr0pjO6gwgKc6VRBAaIwgesAXyKZxOPJWsL9s5FEvyFUBitmfTWfjy/LAJ2GuTKOrL8OP1EOlDCKFNx2nh7setdOOke1U9Q=;24:9yEwz9UhjR5N/VUjUS4FR9Nfwstj323GO7OCsnOW/jiHc429VRiBfznFaPvv62FfSRXpQSOWKa42afpsVPWGu/8kaiI1/6lwbjxOKp7YJOI=;7:C7W62ytIWeO5aFQg8GMuP25SNV6+bFcERAlcFD40Kgsfbsr7klQOqPRMuzIABn1DrGGHxgxXxlcql9yQYBARIXrSvoE4KBPB5cqCW0cYzH4/8xiiZPXdjbv2b8evTieasYSbcQnUaIrgobZqdGLQZqV5Ls/2t4hHajBLdJPmbo6+HsCBU2kKMx0HayQgc46VxWt39m1rX744nQjD48eZrCBVkS4mrwm1WrOSV3N0MU75D/ioLfXn2Q6oC2ZW69ui
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:52:05.8297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d550d4-9741-42de-e062-08d5270c19f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60788
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
index 4dffe78fe6b9..a526bb80aa16 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -10,21 +10,26 @@ config CAVIUM_CN63XXP1
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
index a6810923b3f0..df7654d7333d 100644
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
index 95b8c471f572..3d264008afcb 100644
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
2.13.6
