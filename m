Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:31:59 +0100 (CET)
Received: from mail-sn1nam01on0067.outbound.protection.outlook.com ([104.47.32.67]:13737
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991743AbdKITaAr4GhL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:30:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZdxxpzyVo8L/0iv2itn2BcJbM1eyksWoYsroXQLjyPM=;
 b=SyqsUDtG7CE12prSpo88sQ8+gPPhzlUNaQc4UwHcoJJ5Bjr9JYKv2G2yG+bwznTWHmjfQD/lLEnOJKCDWF64edEV8ji8GWIJciw4YvbEZpz6POXYGelBld8Grnqr7/D54OZcTNu2wOjMOY1zJuLUqYPTqjgRumfo6I9g53pcwuo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:50 +0000
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
Subject: [PATCH v3 5/8] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Thu,  9 Nov 2017 11:29:12 -0800
Message-Id: <20171109192915.11912-6-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d81fd59b-4e82-4153-c1f2-08d527a83f74
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:n/PMrlf2pvHEOIsvgKXCATZHJ/bTlpmrjXbbEQpc9ow3lDN7wBPcAv00n08idVGoUzmJGQgjTQvwRk8mlCb97TilSgPkvY1c9KJKRVyeM+rJppHqLtmBzxt55Jbv9pQT7yOgDTRHeQGYgnAE7svUdVLt/VoRtK3GQgwMTK9aN4u46n23mW8NPZEJ2pA8pZk/NJtk9FYlOSVz1zZRp3SR0oHQIY90VoK2FyZKLDM4RrasXAdJ6ZOmGic0tPjq1s0+;25:nkLy7t1zawLCYSROnRsqTbpA1czW0UfYeNgTArw+I0TADaJIRuyftPtU25JExKuOp4R+aQk3C32BYIy05r8jHV/4QYb4pqrIApKjM6qvYTaveYED9biRRX2OKo465OiDqps4R8/PR6X8+GA/+RLNNsW2Aln1cWcsbo2Qjk+FqxLBECuj+EINiVhFQo+JmjlmLhpYx6UaYXtfGgcxEDjRAOCu+EULm1voMXWA8iyAdfQbfrpE4MZmG2Kow9oHz+PwhQsG1l275r0s4U/IWQ/0uEqLMurXE845s1pXmXSpWJhiANZEVWh6wjsCLlelGcBSzJ+CcCGiK4vr4S2zyzFBwg==;31:5QY1JtRwd8RK+auamprU6hIJDcknLH4KFGw8woRB9IbRJaw8lGjPPJoWH8VD1iYpV0345zSi4P1XWCJQC6EEA/BYxJElIPiuJUvdidlA+lFNAtvXGJj9bAZxXaeJowPWOvw/8JH4b1ngOfEv5Jehd05cEYF8jynj42xW74/Le5dgWIcfqxFlyVF4hpfuQTP7d9PxwuFQl+sxHtShzAo22TRRbhRG90pNyTFOJcqra/c=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:Vl4oqsP7/BJez0AIPbpN4eLpkdKf91FxvHCq/hNdq45jsMoPTjolaRPtqwFpUaCAlIz2ij+fDIQFn6O4HmU/qYcmOXmRV1GO6NkdaaUAp1kz5YQ1Jzaba4f80hBUwMITI798ggEUWtdrKyjoBxcC2gyRkltk/LxyC+1Goq9TBD+tPtWm+pjYofUH7tDcZbwuh+2THvZLM2gVxb5A8xmJO5nLLpTRK9XGr2wonDySodqiuJNu5xgOS6Zptl//S3dcSU4ELFwOLghTvMe+PWk387w4TPglbwEQvs8OVtuONjM+nQbymPhpwZijZQRvYYXff7Jf+Al6DzKzDlOHaejAjEtvNTKwAs7lkBaYmXSyiBpucJXKPtNsm1ApzuRmjuy1Miu3m7fy76qeXunBbBPolhNYZWIpLAnh7VQZd6M4RRahacriIh29i72iczGvx52q4vzAz2ltXBPdN2MZSqC2OD3cuM1Q5XNu4gbhGThWSsomknlBUVqgBh7uYe6MwEpm;4:ua8Pc7V1Oo0r/SC0aUxaUtaznO4NCcgIhnZ/ZnXFADFVUTXpF2wSbJLiSKFCYVcYfAuw2e9qQ9TUQUUs+CAyh89E3eED81VipNbL91nnZN0TMl1jyLTyK28KfiFrUAL94+Ui1wzfJ7LweqxvbjKPQx1dUoYGxmyn3KLdIN5jmolJR91B6eG4tR8Akg6FUfdK8eSHIGOOxUkeS0QbxwTJOk5BWDBIqB4Cw8nVv9+rkC9Mb18eVhmL2F49+X5IPpclDs8H7/biVt+W9OzInUjBzg==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496F15D87A58D24030C22B197570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:1zLX5YdTyfB73mLnbBkXw24du6bUuo2Gias4LnAiC?=
 =?us-ascii?Q?IwBJf3p5WWVRoYWGAAJvaiYWqCrSEEMm+ykL37HWTa01wN4k/INfhwmjbG0r?=
 =?us-ascii?Q?tKTm+PQJ/1ir/ARZI+zmvRHpeC0iTd/Dkj8vx6SkPI0VAhW8gWMsGxAE9Ezd?=
 =?us-ascii?Q?9RNKUgiagT9iuIGKmrhv1D594rmrEfljhfadltBCOV5qMDGFFp6yAZuSbG/g?=
 =?us-ascii?Q?ozmWZ1bB38zEQ0z3MpP5qJdfYTjIT1BqPAgHFkXmB9lpuYE4qXcWbmKbXIa0?=
 =?us-ascii?Q?R9TnYJE7kBgqPo4rIpQeYtIsANBdABFzZhrZst4OEUT8if1tJa2Os/ywfLsF?=
 =?us-ascii?Q?wVaPhmSAWgKhZr6onqQHJxVPr5ntkKeVQGi7vufGy+rA2VfBTN+8yB4zpgPx?=
 =?us-ascii?Q?jpvUxWzn+hF6LTHHAFY1Yod5NGxsSejVAp0o4bB36xNbD7HuIZoypJnv6c7P?=
 =?us-ascii?Q?zeL+8fJRE/ZOX9sD8hxC8Pcz68NVllrVYa6NCH9Oezg1IATzDmYf/oOksm1B?=
 =?us-ascii?Q?WlQPx58cvBNYodV7XBG/2D0u8h5IAriTAmwVJK76mVM0JiYs8SVQDDqHfwwn?=
 =?us-ascii?Q?qle7bL9E3qQkMHkruZlz9FtZvXjLv0rQqUjz0OVLbsJLzvQeS6T26d+puqK+?=
 =?us-ascii?Q?cTOO/CrGlWLj2sHBi0ezheiPvbuZ4fiDCGkEGHnoFGodpf+mAktD+XOoEpAx?=
 =?us-ascii?Q?BuYMhGAAbuCeBUqToMuxrgGImRhGVO54jcB6+cmeqx52IxCgtVzA5PLOpuA8?=
 =?us-ascii?Q?f5T0EPB92Giw4iJh6tcrLAZ7sJLZuQKYZdOAB3eJZwp3VlWao7trden6539y?=
 =?us-ascii?Q?mkF5sIhuxL3PkOMLR659mT2/0dLjLuBvsgAhcXMbQ0FChcpEZLRBI/toGjvd?=
 =?us-ascii?Q?YQew/7RFpjZn+pcSPcktvtikH0tOZ/dQuXyKQurtN4u72LXmZ/6Ljcjg5tqq?=
 =?us-ascii?Q?jaZ+dtmEkUaycuKWnjmU/vYXhEszZegD5iEbtMoPUPWVsF1ugkr5CXkmkCol?=
 =?us-ascii?Q?pJszsgHirrKGj+WufHLNaxkm2ceEe2+4t02ckUAziR0Ndvi93b0wOzVX68kV?=
 =?us-ascii?Q?9RMDkc6FX/aIMknFWiWFjIoyqPjDJID5A+YQ4uOoGJgwqunFGrsV1P2lK+4V?=
 =?us-ascii?Q?NrHWq0+1p7WR6ju/pWliexsmFEvqFGM7RrmP201R8LpItz7AWsoBBd0dR3Hs?=
 =?us-ascii?Q?16k2zPDcDTBD29kYzukCIrHFY7+4PmiJEVPXa1yIlrQWX0kbmd+KWqs/w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:m22sQsPgFD71AQEHKjdKqn2LS5oYmNXYZlMtVw8ZHUgD7vK/kzS+7xj8HU7wUi1mEaRWFxWUbEYz7UnY0M5MuaW94T4a9TdJvpx6M4f6q+qQRQeu51PyChsTdL6C1b7ppx5+lxVaACii7jYPDelScZ78X+MkVgdjqfGiQwvDw2hJz3MiFI8duDNUMaqwXotgFlro+9r2HnDwWQkRbrKZ0TgjufPzCCtVFFpe+DIzMd00m0ZvwmuPMkO4+Nbk6qNhS798atXjjNKmFJWIua0qEYp4XuTQFhaLdvEr0jyatMRRZHyAbhy3YqrR1/i9SNmw/XQx/VIRT9hj8qZ55xkROtg4d935YafP5QOxYh8hPuc=;5:HhGcrago8GjOMUjDW9r9YcZrX7I5xExXrb+iGwn7b68Hol6rvRYaaPUI7XdGcv663rxgitI0G7LPPrOMS0nr+FmW+2pdYTbQxUbfgtAoxXtNR3zPHOyD2xc9MG1xI2tFRDAdj0/S/ileeD8kBQ1X0r80stbFPQ7QVohzwPEq0qs=;24:fuh62rtRPl/2Bk8I5LOkzYgS9LrD3T7rfWHfXM77xbuCV6xyxFc7b1o2CZX6r+CrunqjhdHRn0ne2W0FGBI5S02dvL/dpTiHVGJQMcKFqfU=;7:eVQ38WbmA9h+6TRo5UgfejQaqXLjd4lGpNaGu/oY387oMprnsdH37fyMHC/qUvKEEPvtDL6BWxCdfB+HBBDmVZoezmcgxXvEKDykBBpuQrqGprXrKXRrrhZ7xxG491C3/q5BTHHfq3u64kB+8BdXKlW5SCrbL19J+JbDYo8qC/T0Zdja8MiTZIDEZhNsDQfVdaojTaK/HCxC/T4wGy7CfS0kx3CeQFIMbrPAqHyZPK32im6XJqTHQpvkle2oDLej
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:50.6804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d81fd59b-4e82-4153-c1f2-08d527a83f74
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60820
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
