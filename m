Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:38:35 +0100 (CET)
Received: from mail-sn1nam02on0076.outbound.protection.outlook.com ([104.47.36.76]:2752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993258AbdKBAgytAucm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=64hUgxWJO3gISBjk7i4oHGumBGNP5aRyGeiOcLNk4zk=;
 b=YkfgUdwEoetIrmAXidePbXNfdwwEt2VmEOir0Kxwa7QRMsiyBsy7SYInzfW9POTFaPgfY5X975qLyeWqt5H2yvfAFpteu+DfwCrFGjFXdA5joQFMR131QavLeg6rjXDntBIyqDCwqBjXFUXxpOGggdMDc4DDNf+91LWh9DtNLYU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:42 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH 5/7] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Wed,  1 Nov 2017 17:36:04 -0700
Message-Id: <20171102003606.19913-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171102003606.19913-1-david.daney@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5081ad2-6914-423b-10f0-08d52189cab5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:Ja98L5VVD9O21ea0Ji4JRSerrUYni3hIMXHHnqIked6MCXntURSWNYMDelYk7KOf3lUx+CCmScfEvjoakAPruv+NEIjbms5TrLC3sjssH6PqxeIkdzT9D+NDLoY0Ptt+4JNv1m3QBXqKQWK+yArUlMFQdLCq5cx8JkEqknt7pZ0SwIo8Rc9yNZwPN6MwOmpuUQ+WmaxxDXEox5xteRjS8gbvSp+m95xyTpaBplAlb8OdoEVW7rnyRNijEd7bNDVg;25:Hc1w6K75buBrQEk9gbDAL0QsqB6mCx80VPytGs6Edra/QbRhUkO2rNzMv3xNngbR+hgHDJKb8IgzGlHZslmYJ34JP7dozfoHD6J93DK2iwP78FC3+s7Z9ZnF95/87omTM/bb/4Q8peMNLqGvNMvFRot+LHu1qRIvJAipKEJukC0xlKo8DnuLzQcnOfI7rs6FDsEsSNC1YX2cYqBW/2c3Xqwj9PJ/WDDjmcZCJlc7kGcJsoQO7bW+BHRjjsAZTlsdRUBqTQd4lV1VtNxPJPGRNHUr/jNDmcNb17C/HNN3yelGMZfsVg2casQRUpyaGioOWI0eUzLDEKIZUPOsL0JSYA==;31:a7XyrzpqBcChYx4HHOF9Z7KN9k37BtHOAnT9/sfUQvkUEwCoSi/ejC2kxyhOOfcHWnaMw9BcrJKp6wfMn3AYNfBfBw9znjkrCDE9pz1YMM5Vu7a/52ujS3HciKEmT9M5KSDIdcFFgzfF3y4gs8Y8E3eFHKAuHrhHZpA6azPxMZPO8KuwxWLsd40emneOUTrJpyh/sdMWg9d5MtBfVaCeDMzKpP5WXSrlBBbV64ngz5g=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:6Id30a7veR0fRBSiwx74a+1qLi/rdESHqXAInULIU04OqmuiB1+VeGNnxnNt9lEireHRU0w8Fs0Sur5w1+QPxuLHs3G8rYyn126HaXpnbI0Qa88aHDk9CBRHTks/GKwL0/wenZjxtuoIkk1S4ovLVwZFFG1Hmg6XoXg7wZz+s+1mjCzlYOWCRtGWRJsvh4a+SJ+/NLNLlsfB9ey2wZHSnjitxaPxb7wmSRmg0/xhfX5FsB4789IWLKWhFPsIgpPb/b5lCgUsEADwb01q1pep/eBoJuqDyRq9MTLaiRHayrwj5z5fwJ6g+xnUwb+b0oDjS6Wn2qc2UQNAmEy49YyjNjDHYYrCpCi6Tu721YOut/cbY3qalgBHJer8rkZTckkda/1kHmPcf2xE2/SBYLt7HjXlSsnFX2vzYtilGvcvChlfAx6ykE93/8HBbh2UZsTCypexxCy2OdVq771NBgQl6gFaAJw19eeYmNUCWAqaq0zyxFACuYJUjzin5NND1qiL;4:/ldzQ5FKZmgydmTto57SyagAmlKO7mPEoRF3EUXF+J9j0po7CmE77Rg4xCoe9BRlvlcmsD6I5e+9wU7f8eToX0Q8FA2RbK8mhwAaoCjmQiWwsRdlj4p1YgVgmOtGSwQxFuV2uwPXM//s8wKZNpKu8l6Jt8ZPlkj1tbxAp3TlRhDKAQeP5lS6zfFbgEGOcFJtOI6DBIM5inAISBJQqYnE/hUF6twlNAa5cBjEgpGAufaYw2gfnU3qvsxivKpyTqJyPwDmVPk8CoLpeFQ3ZlA6RQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34965036E8E845D0508722B7975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(76176999)(50466002)(33646002)(47776003)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(2950100002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(1076002)(8676002)(575784001)(81166006)(81156014)(86362001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:d9660yZK5vSBT8+vutbD12ifhB4HJSSPwJ+k+nCiG?=
 =?us-ascii?Q?l6V6O2A/83t5AGeX7WhuWvLvMWleRx2Km5CWkOdPyoaNVaOZA95zquf0d6Eo?=
 =?us-ascii?Q?unfMgg9qlKP6lYhk1tJ0ISI+Ppr0r1GyfIWBXR8kOEBfpi9mhvWxP6q/q8Fe?=
 =?us-ascii?Q?JsICuCyqOor2nwSMgdw+0FeTJd+DrGd+qC5rIb5mJHAUt6ogHOZN/NFONNnn?=
 =?us-ascii?Q?Eph3sU+sh6SCFU20DbXmDnqGD/PrB6yAzba0nBCgN+kAqM6ebQMCbZjYBVxT?=
 =?us-ascii?Q?pvN8x3ORcotScsr8JY1+N4DLymU3FhYUemBW0wJe6t+aodpNqlIHDtOh6rej?=
 =?us-ascii?Q?tiZD3D0iMUdeNmMG6WMIfFXoeWiGYSH+y+oC7eiTCG0oSPKQPIYvioCzOmJW?=
 =?us-ascii?Q?CB1206vkX90RsP2le3Z46Tkx+BAqhxVB6WKzqHWy7fO7MpKbeQkGIFeKjOT0?=
 =?us-ascii?Q?Yl6A/IIeV+EI1FeX2/e1aAuYuG5YPLU2Fm66TrvPdvQqBKOxLPf+HV/7raJ7?=
 =?us-ascii?Q?yhvpVvYZqiYt3qWV8cT44CJYiAj+i8yqLglZG8r5DURvkWRADIgfeFOJSyRE?=
 =?us-ascii?Q?RjnkRlkTwjEZXqMiN5oqyBq301GL9cIXIUla04LMXx8rRBBaVUTKT2rD9LV8?=
 =?us-ascii?Q?IqnVUQsN5t9hRzV6KaKorsJRO4ToDcVtHfIszMMMrSrE7XaaNwJxZovVHbGC?=
 =?us-ascii?Q?hFae56CgtBZ6kaCDjPzinm04pXiTWCFyhaaMUDZn501c9c/XaTzjFUE9aw6+?=
 =?us-ascii?Q?I3gXvME84nP9LUDX2ukDTQUj6AOtQp8hha3izaMkSHGZ90wu1ruonR1Ng6si?=
 =?us-ascii?Q?2wfawlmpw+tog++VxykPtxK3lU8Xk3+KPJlZoiSWT3wkqFrODcADtnHtSJn7?=
 =?us-ascii?Q?CKJJCmI/ss7N1zqs8WVT196Rl6q9k/LRGE3OYBiAk2Li0D/T3lJ0eSIGkQyx?=
 =?us-ascii?Q?QuajpkZeGcWyTu+Lf7fXxg0eObxVyacqINiANKkIo9R5encKv16Wk7QPXV/R?=
 =?us-ascii?Q?lQZCVZ3mV0PE8leqHQ3bbopoax+SE4sSmQprb9d4U7myMKhGp7GAX9GEDk6e?=
 =?us-ascii?Q?hTOjLmiAVojA3ihEDX9beR1VKovba2T69+b62ewlsf+78OZ2yHwEWB4IXFhi?=
 =?us-ascii?Q?UzWRM3cC7MUvFW1RE9xztQ2IQVvmBVuAPEvLcNeiFth5QlVCaRTOuNlzwCBV?=
 =?us-ascii?Q?tL/9XZzO8upd0bTmzkBPxlRnYexDt2CdSX+?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:Kxp2GclyEfEna5AQ8E/rj1MEpwqIYzpNUf7uI8qJ9ZnOJ/MB7spcFxDkGQmgMsW3lLKzsuvkJmX7sxKYuJkrpUVNzB+cMRgpm1LT75rPRjiAI+mpXMU4BDwp006bfHWg8qQ5+RCAw1LFXpuKhZoT5pmnQPYr8D4JL1AYBZAt1V7OuXjPIgkShFXlr1S9SwqND4hPN7qnkP1wl263ryO5E6OxInKw0I1FYrVwwd4i9ptI/Jdl9VC8pE/HLFy8K3zwSqkSthQT/IXzde2Jp0JFR0sNF29s12Tq/Sy9fhQVBuKEjjKgALP5qL0pMuUdOI1E4oW5j4UOTUenHssM+WjQCSY656PG7UM/Icypc9lhLXU=;5:3YkrLIkU6xnF6AH/1Txx6RCLMw/yLt4Xr8Nj9W4Mq/s13cF6VpYGN/S3sNP9JQEs/FSF1S+ll/adJx3visqEH7uZk3nOHGkgYs64Vvgw6BL6sYyD3GKmUe6uEWAhP/6CNeDW9r+trllYuzSKpinKzh6a01Q1fOrvs50ujdbVEIs=;24:CFY2RMrzADRTISFxutHku8ZP7f5Iz6Gt1XD6CrzBw6OR3PH3WUSAo8l61u/O9KkZWFEaI+ptFfArylMGm/PrrKxioB6QMyijRWhZICResLg=;7:w+d769Ao8QPJ+jGkiyzrHeluRcnHIDfG5cVxT+RjMYfj+vQQto5bWChP2nj5nj/uz6skrKC1IYl7XDWZejzUDXHS+eB9nHcteygVaXW23FE2yeauverNH/roC3lPwWOnOINY7PdU3B19UxFRs4tx8rTS2naq1OFdhpDi5nQu1+dl4nfxrJeWMWuVgfykKTMGK/I7/bVZvdlGJPl+zsEUIB57hJYUNWnI6MsqNHTrpffHJ7jSjU5VAqbqqO6PwGrS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:42.9299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5081ad2-6914-423b-10f0-08d52189cab5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60650
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
 arch/mips/kernel/unaligned.c                       |  3 +++
 arch/mips/mm/tlbex.c                               | 29 ++++++----------------
 9 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 211ef5b57214..fc6a1b44605b 100644
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
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 2d0b912f9e3e..610f9b4ccdae 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -2281,6 +2281,9 @@ static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
 	force_sig(SIGILL, current);
 }
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+#include <asm/octeon/octeon.h>
+#endif
 asmlinkage void do_ade(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
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
-- 
2.13.6
