Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 01:50:02 +0100 (CET)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:30945
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbdLMAtKJeePl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Dec 2017 01:49:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E9Bi8jCDNzD7m378iOWee6PVoWMIEDtV4oXfyK403As=;
 b=nkOeFbROX6C7zvIPfCAa6kSZqt7pyxggQLdGIlZgBogEbUQsj2NBamxz5jApJmkt6egVPBHPe/mW2Opm2DfIQ/Kw2MhZJp9XLxYkxT2f3OJ5pPKKrIbAo9gZrpPoaLKTJolSUilA4RndfxXm9niJ4cYQms0e7xluIGiCPnMOthg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Wed, 13 Dec 2017 00:49:04 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: [PATCH v7 2/4] MIPS: Octeon: Automatically provision CVMSEG space.
Date:   Tue, 12 Dec 2017 16:48:46 -0800
Message-Id: <20171213004848.15086-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171213004848.15086-1-david.daney@cavium.com>
References: <20171213004848.15086-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0037.namprd07.prod.outlook.com (10.168.109.23) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6396ac8d-e9c0-4c0b-7c5d-08d541c34fd2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:1NEdeBZBzzkBWu6m2W3fM04LaEsrLyrP2NuLjHK0NbkKq59VggMBe00cdXCfK2OxOqStgMSsov26x5l/WO/0hCSAuXsTZhG7GUYma8ZepqqWqPpeveKAtOIohiYxj/nzZluboz0pO7c8SwndXIQCaLAItKCGQ6lSrn2SRHPnr2peTbCRYGCmRUIHoODShC5wNhlToZgSAKkiUeoeQO+Rlj0JkwvVy8OguZKiLtFBX0hjB1FnN4qXZ4sybSCYg4t4;25:Uj6eIPWziMXkriFJyw3PygwhfUOs53dr3/oUlgEDV1KOmAyzR6L3QCmnITw0n7KQrdpqcWhTZYzGH0G8DWahWPCohctI42HcKqqO97aX5sMoUafVCEyn5TmBvJ8KnpqYXq0ZsU0GFthYZJeX4mlIiGeT/+nbn1Xt7ERTWgKgDLqZFsiBnDYoe6uAN+Aw0/IZGUr0MEJI6U/iRLknk4aXLKgOTQnTI/xP1OU6kVnagsh23xUu8TZUXJDpxVrU/eLp6E94CD9kCycYZE3cIZCyAcU1DJt2GMvwFjVlzISvaK4ZQqp9UBjdSx4DaReODLdnXlxW3xmdVnDMh4YuaXsC1okApfn6z8Jlq8LCCbPfVoo=;31:p/9ZaurUOYx9uFnmChFHdmN6lQgP2rDDhR1gdF8KGr64W8mMrBZTkmv5mvgWPQiYVP4n4QNCfeayD3TVp68m9yeIuzQySb9Tk6sLOF3vcnG9EUhoFqC0bTYF2B7u0Qvd228Pdk4CYI7/U+eY/oCCuayD7hZwTF9AxV/RMaDajw3tYef1sU9LqcpB47A4DSrjJDrHK+UsKWFfUaq7Lic536RI27/JZetbR7/ZXwM68HY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:jHFQhWcI1WLpB9k1ieaDjpVUY9Du+JsgGIS0uYBzqXnAIyDdMoVflEpZoOiAdvBv08/6DpRVBNYFd3YHiGfyPbZCEUwdZwZf1z9w4SFSyxwSEWK9nvXS/dNG4ZVkL3tE00TjBfgiQug7lroHWm4wFAQ0i0OZM+nVu9uZ2NKhPP0PxTyOC5sBpvdHOihYwboRsR85bVzmu7B5T93bVEVVEXY3DSfEShmu7ehwLUzEvecb7yd82Riffxs2q/7pUzl1lv1Z/hw5GT2Yq2uGivpZQRaLtwFLDjtWTu3GOwIoiItIP5u525RH8VNcSaKMAuyzfekOSEY7CSjCh1m6TSf/4ctgHgxD3mN/RpbSQ/V8N8yv7/JZT3inwSxDYPqtgSrzJT22keHwx5sXsm9DYTYGVQoh7au852S0Wp1YMHZMdZWQrQ1FAwtsGfpKnW1FIcv4AowkMl0TqhZrkA7n9NV2EChVZ2EE9uTC44f44U6rdcvizoflmHQ/vdL7OAMHNl2s;4:7DmOph5995dj2LcB86hdGSbSLncYVfBPyAxRk3zlHdBajXuhtq+mhg8R89//y9YNSxMehJ66LZ0ot6JCSZBVNHzRr67A9Ygk2fyEI0oqNhoFyfxrNNidHWJSo4ayEAVjc/cQIqzltJ99qOEGj7TweB+wK9BFtdRsyLY8BoyXCa7w+dAkyUxVJBmsUkkrbUSkjC3mtWifHAkfpXcxEdFhNkWEv0xH2AUorSLEXe8nkgtlE6fir556ddHEYK9NlrLOuJOJIoh0snBlyIh5keYuyw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB349512556CE284D328A80ED597350@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3002001)(3231023)(93006095)(93001095)(10201501046)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 052017CAF1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(199004)(189003)(106356001)(52116002)(105586002)(53416004)(16526018)(6512007)(16586007)(107886003)(1076002)(4326008)(53936002)(47776003)(25786009)(6506007)(386003)(54906003)(3846002)(2906002)(6486002)(316002)(66066001)(6116002)(59450400001)(69596002)(68736007)(81166006)(5660300001)(6666003)(72206003)(2950100002)(50226002)(36756003)(305945005)(7736002)(8936002)(6916009)(51416003)(81156014)(8676002)(97736004)(76176011)(86362001)(48376002)(478600001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:GGP27i7qxMHyzs8xPCtBuFeE9HuIza16Srtns9cF2?=
 =?us-ascii?Q?008BQYxeNj5X91d33keoWJl+77s99aagekUM7/fOKj7GOTyufZvDchPgHQf1?=
 =?us-ascii?Q?REmPsBjx1DSDVbrtUSP3j41CK3YIQANw88hCh2umrwILuMAtPjmq4CSkIbPS?=
 =?us-ascii?Q?t1ov7mCAuw8ojFsQFOH441nqbv8VoTFvuIVGSmqjXPM/YF5UgDDHWV1CsM7A?=
 =?us-ascii?Q?1Xl3oMyzVBWLIdtVH9TYL2DQ7+/66m+3TNIrhcDTLmAsgikV+jXDDlyqm3PX?=
 =?us-ascii?Q?TDVMwRBQsg1IuukckWUxYk+8/qjF0rBcB3AUOJOTA9ZavbknJu/CzRr7os0+?=
 =?us-ascii?Q?76/6YIGtrVvxM6wUUh2nFX1Uwu3wKNkQnyHn87Rj5PDte9AemIN/sF6We+3j?=
 =?us-ascii?Q?k+T+5mDVU+hSUos6/8Lf+QLDwdxwSiRwwchY6TPV4U/pB+GAdxjFNtkh9Q7v?=
 =?us-ascii?Q?gC5cFasJG3hlFhFjjZrU4d4kkUFTLrSSWTWgOAQ01Oc873O+24wFj01PoWhP?=
 =?us-ascii?Q?FjvppP3rEpshGlm2fC+iBc9DHkUb/DpWHA7hxXp5qcOeIEsx9mLpSVDZIydZ?=
 =?us-ascii?Q?tS3q4SJixH0yxaxnqeQ+Zc+0IZlbNl/YJTu2ukqy7aMr9PxWD1pmvkY2q+Uw?=
 =?us-ascii?Q?MNOPoSyDJYwuqRUuxtmd//v2XtHi7GkWPvBdfYQcxQR/iPN1LUOgvVmRwNoQ?=
 =?us-ascii?Q?hAUWHY8Y0rgcF2kWfXN2CcnzTz88SRcB4D9JsZCqgBaMxNViSMAzuwVtkd++?=
 =?us-ascii?Q?pR7bU3rpshylW8PPHNZoxYhOtRQVETpxHg7+OptOiAiKXOtwv5SF6Pb/b6vS?=
 =?us-ascii?Q?gZBWxFyz+wDjzGDylLMUy3/Qi5NMxJjTzPU2fdzbB2XLgUPT38WedVhQ5GK2?=
 =?us-ascii?Q?1x8x+oB3O/gOzlCsoS9/+sMepj7lnl2gTe5fSxWbzSuVJmjXqEwBgBVrjaQY?=
 =?us-ascii?Q?XMMxVpty6BWQygTdIYdH7p36DfylLPH/6BxsEU7K5TE6kEO6FCdwhaYwowPS?=
 =?us-ascii?Q?81kSNVKrOUo7xTLMItOxbHtcHqwF1gVzdVM0H7LCYtzhRREaFLX31z6lFcYk?=
 =?us-ascii?Q?e0sBx5FwHdJh/23A+zUujjVWYu1Nqsnuj83Ps8RnMZkSsCO94JcMaRQqIvN2?=
 =?us-ascii?Q?hlfkR5GwPOXcOvaBql1VnjvXWQzNIVHykFGgDdicIOWMAnlICTcMg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:HZ3jmJc4Xp16irIl36DLtoj0kVF5eDvh4W0ScLdfLUiHcSWl1gwr52Du/PE5OffPJoYAUr/GfK7UO/OcKGQVA7LGYpgkDkwTbSrbaA2pNdRorJb07Yuzpiw0ZdsE2iQ+8eSQjOqPzYy9ePRXfD6iNgr4bZOPkNkE9syRcdrkJbQoV6ybea96BN7RRW7yGTsyPGNJzSB2Sr5C/VRniMM71vwmqmoR8mzrdJqWM4aLNc3R8ldvmkgajje1KYW6oSF5cV6aBglvkUnhYAAi8A1rxECnriFbZXzDThK3b6hOPpdVvuaimmn73ug/2bDQxTi7LXcxfYBZa0+hSSz+juW7SLy73FlYrMsVbAJ1ftzo7V0=;5:BGlwKvRxizXBEq0r2f9DEXUzid31cl8ZGYloCe3bfeAfUxm9CkI78rILvqDLBw3Ykn+CaVEp9DizfxMk1GQBTGi4WOaAl/bOY2pz5KUfsIpzkWXNuNxV4z7aFMP1rAcDWLqI6dT4+3Hgiam+VyauBYnTxSbQpBW2qMDqk9ccwBQ=;24:dvQlqJOBjy/zLOtru+LI9nlbyOf4hdZYlcsvLdyytsHTPCUAC7zHHpMIICrWQR4ty8IJfULHHWc379z7HZ5epqnho3zUhWP+N3D4at3iAzc=;7:g1itlEVszwZ+kB8zsT5Mocwo1gE7oA9dvaMWdgNw5nbBDe6tlk5JysAw1ubAfRvPqAJXIuiYXOh2ZAXc+6W+PAyRaSYQNovsiK5DdKCtdeTubawCG8S0NU62YXvvAo6tFN4IHyfEYZ4/cwd11N+o6UkSIA14Cuu2wh2QTZWRPTOeNlCwtTxOwCwrcU26dv8mUmVzQ/8zRC4ji5tu6LImwZISTB6sWlVOMzsKgUNu5s31VpE0lSEojDt0iW5s0GtM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2017 00:49:04.9384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6396ac8d-e9c0-4c0b-7c5d-08d541c34fd2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61459
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
