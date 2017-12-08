Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:11:22 +0100 (CET)
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:35584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990475AbdLHAKB1eS8A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:10:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E9Bi8jCDNzD7m378iOWee6PVoWMIEDtV4oXfyK403As=;
 b=fWRhW1o/KbSw1tAGK8iK//ZUHaq6L0ZLm2R/q54i/F6gaXNaEvBNBi4RMzf9TvnU4ERqMJ1Vy+j6WEvI+rWRgb72DEa5FhxT3KBmnjX/RsryAgGz5EuJABuLJrIIHOkpRNTeEuu5ksQFP60C4Ad/j+y2/TvB5XoBcqrVW+84FhU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:09:56 +0000
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
Subject: [PATCH v6 net-next,mips 3/7] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Thu,  7 Dec 2017 16:09:30 -0800
Message-Id: <20171208000934.6554-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3424e2d8-657a-4e74-8ad6-08d53dd00393
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:QGQymkZ0VWQCleFE2MChlFQ84y/wQjo87tNKsPVLPF0c8MmQ2vYGS/NRtwC4//pHK4MuyYP7G9rIdLeoqjW7BvD8XOp40DzkgrgQPLkw/Cbrt09Ql4b3G6hjlee2wiYwwZnX2io/7FB8v1AYbbBRyvTPJJvRGKTCiqPu4gKnD3rI8W2RrJ/MT2pBeazqrMS2EofvF0vsynKvPZKkkkEbIHboHZ3u4Yt480tfV5SOtFQuulCmy4jghXMIAPVUI6ry;25:Ny0IQI7TriwIyPTlEXeGkcFO+FCj23Nh6dOL1CfiGIGH+TYeUGX9mUiNOHWzML0qz8kjz7LQMVmQTLgdLc4pgYxcu1+LDeYoNzOZI+/YkeFxstMDO9PgcdAg9clR9wSWCCbgyzbd8RupwOgFu8ExJhCf6q2UOoCmjEAPocsuLp0MSPpTGH9OLrkmWLJq3VgwMO+UZ0Q8RmZDJQ/ycekEmgiV72aRIHYDs9OjjFWdgABdOY7ebtgPHr5THI9BlsyH9H6EzcJ6XfOu4Cml5POrocrGwAZrzGW/SceDjyXhWA0MbCU/MdTjYzeRJQ/cq0yCePe//cgSf464p6/1HPD9rA==;31:cExYAVl4wRBIAYbV4zqzyVx5tNoDhVxgK1wXXFH8NjDS0hoVwuyfSPIO3FdP2P8TPXVDLSNSqeRz6hgtj4ewMTIlr2sRo57+1mdejyEYlsWXz8MHWpdc4+2G/JKuxT2Y5HN+gX04OfySdXXEQFN4XJ3favILBKIrvZ7J3PNu323tbkwCTWvYJfs6SecVN4ln8eLHJf/w8Pry8tYD5oFM7j/79lJ3VssH/9/f0ZwA6Xw=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:sQf1+CjMUc56eipwwRKHDIDcWGkoACGqpm7njWG0LpjMn9L9JUKCxfvYBJdoMwXHoMPTrcq4UAE9My8bZNoBD/8LRkUt1nDybcMc0zb09vn8SBheiBBPIUvS008oSMH5let+irvPNpzk5Ayi41BAXzDQzfxMWzaPtVL0ITLIGKKjOb/z8+oGxykSoGbSXD+jeEyaHNR5hMZ8LYlTRB2DugbpGk7HP3o0qhx+3sgW5EcxhDWJKkR3Zv+wWzVvn0Bn60T81hL84vnCJ/n8guhAiGnT35YJgK7OcIMiNPQBSF8/aDaYEX5XvoTffdHGrO1vQi7ZEGnKe2s7//7K661N5H5UoqbojaRSE4Jsvc/arSSTSLpXqc4yzYd0JJvrfrm2mO7WM1XPkqBpB6h4ojcnu1coyInzE7B7L58uZvZ9felmwoC1lmOSd/r3PfAx0QTWTKRmRoY9IgAWA5tjBI2U+GOWpehEKZDjSKApl89ytwgBg/xFy30+K9fuiT1ntABx;4:HpIjaxCgT3G4GOvww7Ajzbvppj9WU3oLKU9vYOsKb+DxRoFVSweGPSr8Mj9Rx7l6s12dXqAxWyMnFze8CEpj6sMkj/DyWyA8K5rtiLWzhgNZUMLQrMj425Go+LXd3MvfJOgHPX4ux1XM240l4cDbCsAcFyydCCEIKGEeoneY6VQ8U2Q3hj5icrlfUmwHz9K2wa+PhGWxW8LPj3TdatgWDYNt/WFVpKW8XSrDkBYggMmm4u74Zx4snCUac8YNAsRdyz9FDod39D3EmiVgjk1m5w==
X-Microsoft-Antispam-PRVS: <MWHPR07MB35043AB8DC7CEE11ECD2B72497300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(199004)(189003)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(69596002)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(76176011)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(2950100002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:9Et+rHTYH0vYgaFyD51sgumRXGbQ6hVCq+Mne3wBA?=
 =?us-ascii?Q?fFaK0aCA1DDEnDzJPEo75LOXNxVBGVKGoBAedL2XkfNn8At3vbqUdiBFOUTt?=
 =?us-ascii?Q?iN9aH8z19kmiQXLlrJW4VsftsnKvPrgGgGujizgnvCydmcX+3GZm/AynwApn?=
 =?us-ascii?Q?faLr2cCnu1Q7bnK0pQ1iQw0/AbVT/+CiwUxV3x7aqoki1C3pUWBATU4OqL5J?=
 =?us-ascii?Q?H7aNkyBmHrg4CUeTrdkJF64aOWpBSgUJQQVoNXb5Pbz6whytVon+1oO93xvs?=
 =?us-ascii?Q?c/gHRQvZu2Dce/344F/aBswdB/nrYOVragIAAboG9r1QxD60Uz4D86EPgJQs?=
 =?us-ascii?Q?gTnLVZ1QuLuGZNWxoMKXPK7asl3x3nmukzQnB68u0/jxb9qrkyugszVyeC5a?=
 =?us-ascii?Q?8xlrEDIpeZkBQTCZQres5R1ZbZjNuWasjQiy90HurRlLnVkOEAV79P8tAlcL?=
 =?us-ascii?Q?lo7WGJdHFSpjBVlfT3jhv0FUpIDYhCY+xsKG94hLdJJ07Erz4SiZkwFKLMbQ?=
 =?us-ascii?Q?CdOcBHVe6UTYdBXDBeK0h5Tp+zkarwZGQ2iQwwl6HLwQ6Q1Orahe9Xvb3KfF?=
 =?us-ascii?Q?ZZaCCaPLnowynbekjwBu3JSNyMDlhwciISCua8DEb16HBXUSn5Iz5PFKyOaW?=
 =?us-ascii?Q?CmmY9kJF0ccGO7B6kBIwlpGN1Eo7mj12OYaM/0KTtAIe55zFxme/wyhkqqGS?=
 =?us-ascii?Q?8GRcUITNc7+dSAgzZZn4T3mHLUTQo9S816x3Ldi/NBWUMQh2TudZqjpBOqwb?=
 =?us-ascii?Q?KpmLaSxzBF8PN0aFKC8wwlFeW34B3X2sZiacRY0dYJXL8LgLe1I/mSwprrf4?=
 =?us-ascii?Q?DArmQ/bsZ0eI2qVVRfH8QHu/JrQLJ7MvwRCRZ0jATpcy66PC/baMrzAEEqUN?=
 =?us-ascii?Q?lxjZxQS4MW046LNelx/O5cvUNEbnjh9GASwwCwwA3IF/5EJ45YpVVl2eFjqx?=
 =?us-ascii?Q?1IibR8BNWjRx1Gqysi4aefH9eMIL1BO34Xw9DKnWK+LAEj23y8j9IvlFikux?=
 =?us-ascii?Q?b53NgBfytT2r9j4sZUUIxd7d+Z/qi4GgN2Bznr7v7eRpZ6nEvcW1JKa8R9jp?=
 =?us-ascii?Q?XRfrrXwPnqjGmePGcsH9c2lg9SDn1GVYYdbOiqHcBiDaGqVjagjtuUqcWgq7?=
 =?us-ascii?Q?W+G4OwSkQVXmQwaKYUxSqVvm1EMPM093u+0big/MuvK10ikbKUlj3s5Gzhdg?=
 =?us-ascii?Q?9nefX9xaxr8v5s6ZQ8nUZkNwC+6lRCYgHZM?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:SKvI+xQ1z1Zz3puvj82CpP/VbTX2ULcrtwlcqwrhMy3//Dwm40myYlJhHjrwc4j79FFd6a5YGHR5q7uI5QnQv/RA8KRaHPaxag56tpHpON0SfZwaB7NxmmKWwTMEfECsD9Yi15kTG9poHFvRxegd9/b1Qw1Dq20HZthzDyN4FDxn6VqcKGrapA/he2oXesbjRomqVtqV/TdI4Dp7CmAc4GemO4vThOM8XaOM1fDHw3isZycsO0Ke42DwSKmzdsm+Xm/L1E3pQSSlBK5rqL5TO/buIpEOkGkI228NSkpG0ly6VjLtlwoc2xWyi+pMfWz8NbN7ZmJ+nfS60QLK13vkhcuXEBmua8rKyaseaR+RDkw=;5:Fo2kUC1dNEhBWNEauLxbPMyHZBxUXTHvN7488noqqZRcb8JXuYEjonLMNCi+rcGHH9dUhluHlfrUPUCU6FRKHZ0VXpk2RmVIGpNtCoRlOiysrBZyyh+KEhwoUVdYNA+Dgw/NpkQpKjUv6QxF5XwDzDIGganm5GRE05W+VxO8ldU=;24:e82uBvwomqkHy/2imXUxgusUlknclaEmg1M5H09Eor3ddCDf4xL+2t/X1iOYDGWdgnivrikW+/cG2ezon5iR5nnpApvb/JjHtCdmkm9Yp8A=;7:y7pAZww947lt5wPqUGnqEMVkxRda24BFLl1IfKYAulxDCIz6uDJqkB+3X+M3H+j473K65/E6UUU/TqElLNgZqjtDk9W7DwXsXOXkbzV/1e5BRF0IMol3MydHP1e5P4VhaNlqUT8cphfwnEfd4MWqihYrIG8JC0baTA0RB2YNhWvsywHgeJeqTlf34+QU1WqvkbGsuEOI9n24ZyoT3bZbat14qH6LhfDwXkUzDoBCJ0BtulCIcQJ4cWgBsmZ4uNE9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:09:56.0911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3424e2d8-657a-4e74-8ad6-08d53dd00393
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61345
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
index 204a1670fd9b..a50d1aa5863b 100644
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
index 92a17d67c1fa..f01af2469874 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -359,6 +359,8 @@ static inline uint32_t octeon_npi_read32(uint64_t address)
 
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
