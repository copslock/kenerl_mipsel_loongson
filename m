Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2018 03:24:24 +0200 (CEST)
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:62912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993016AbeG1BXvTPfs0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jul 2018 03:23:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imDIlaVewcfHLYP7767ybJETsm5yhRA87yJvM72ufwY=;
 b=f4JU/56nNeEbayD8Q32WEkyawGsQqfSXYW38E6+EzXFCFqiJeolb4cxkRsXw7diiuqhhf4Rd/2s+uhB1dPVrz1GNhtT4HDLcgniFJKMmmytM7k/2BOerZ+gkuVTwtfzdx/wksve01dMrUK7jL7cawBksWYLPbud+8xryXh0nwFQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 01:23:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/4] MIPS: Allow auto-dection of ARCH_PFN_OFFSET & PHYS_OFFSET
Date:   Fri, 27 Jul 2018 18:23:20 -0700
Message-Id: <20180728012321.29654-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728012321.29654-1-paul.burton@mips.com>
References: <20180728012321.29654-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0042.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::28) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c578d193-340b-4487-f7df-08d5f428c1f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:ubTWsOxspgacXh6cMCVhZXs/eCOPAnSq/tX7+ziwCzNElhDEszDgr72jgwmGW3xONruxIZZnXq9FGDJ1tmWXmEYPT+Clu8DGXc137+/qw+T/rezyqgz2Nw/RBi2MDjPA7argsw1jsqlNPOGAtzoxmAnXOOqRIHiLtmwuyOjxLOzEichIQooy6p22EEynWoHNSb75V9kBHqADkcqROB77aS6pdN3ZBe6joGq2kj+Ami0LhstIKtRKeJRXortukL2H;25:FodMKlIJ3jJDst9GYULKz/GTTQA/zg/3fdADLDvt2qmZ5dZzk4wicTINUDJoauqRCNayTR3mNaqR47Fe9yAmfrawqHdHms7ui6QUJ+dWkZrELhXT/3rs+NZ8yD+ndD2FRod9f+/LvxOm6TOey9ngcSNCYKINcH66OVrSGOuxk46gAU0C6mk0sQhBzRG28TxMePryyKfmyQx4LHJyGXfiVj5AkBz26pElqfKtbYSYA0sDIsJaEh6/JRg+bwJ/V6NEn0AVv+I+Kals23QD6lldXWP+36BmgPfvcQaDgpzlLtGydrAbHLuaC9IjpIXTDhwbdyTLjHV8+KoFlIC6ts594w==;31:jpnPMbDXTPThsXjeVffHnDCQF1cbzrPLkMpVb/L3llkxAtcyvOD2XbDkbeUM0bBK/mVC1FeK7CztEpH39Lwy4v15ec5d73e6H5mQn/wOhdpdtxomwhurDy09T4WRfRJjbYG4aIa0wg96ut/f5VDgJuePNyIIo7NuJpM+UQ7Zp1LWyVGX7s6a9fl0liimf09/cxx+p2kv+A5YPvyy81djs+yWnC1XdY2e6ITm4rOQnjs=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:ycSCyMIiFUCjKRgEe9jX5xrst+1TOqC0wWblu107bXzSjtcgVoww0PqqJD7n7bUyB+WHHXit2d0DEe/pdLYL8TJvEpYv57LmrnBeBpcIkgYVH3hecTf7pQQ2MHHhJ5PpC9tgkpBKObmhkAlvu17cuAWcVMoSa/YowyEPmd5kVplle4OP4IHSLaRZxZNBYzGkxnqziSQN7EOe9Br/0xHbo+gW2wu5Kk+4m9xDVKmV38DrnQ0/L9Zqk8fPI+tv2WSY;4:b9H6phaJEMX0wwZmiH2YKvzxWvVyRIJqMSUca04Qc303Ntwgc6YUZ/S7hiHv+PyZ7keC75b+jhtoogp87UWb28gLKnx1Bi2m4F8T069PBrlhL3kHiQI+SKsswph13ZWx4PqAHCXFfjf1fo9vhM+SesnIC2Qb1CEYl++3/RvsSAMo/3VWrSYCG5nmptV2z8kqRo5OVJvJCb9hf4Qx73iPfRQ1DRzRQ7UFpc/mwG3N25s2L4OAI2UzbV9SUyIjANxYeQD7qGja8lrPcASZjVblwgYo7FhxSFv2Dcp40rQk3VLfoSSfpnNuSp8rmDM4zIHe
X-Microsoft-Antispam-PRVS: <SN6PR08MB494294330B0E51686BCD1B25C1290@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(51416003)(575784001)(48376002)(50466002)(14444005)(47776003)(52116002)(956004)(76176011)(446003)(42882007)(486006)(6486002)(6512007)(11346002)(476003)(66066001)(53416004)(44832011)(2361001)(105586002)(106356001)(2351001)(97736004)(2616005)(69596002)(36756003)(6916009)(16586007)(81156014)(8676002)(81166006)(478600001)(3846002)(1076002)(316002)(6116002)(6666003)(68736007)(5660300001)(8936002)(25786009)(305945005)(4326008)(7736002)(26005)(53936002)(50226002)(16526019)(2906002)(386003)(54906003)(6506007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:dI79OPhao8DTnetrona/y0VnOjOtUEQmCk+t6Ml6n?=
 =?us-ascii?Q?SKtHAySSYjzVs9Ol9DjFXhBc/2nFuGel998fles6i52vKZq+BG3MutZP0aq5?=
 =?us-ascii?Q?3hD68IvUThCtkbdlNwgONuyxM9SlE+dNW8MKolms+wMs7jKD/2LPlEXwAEQ7?=
 =?us-ascii?Q?le0bIyW4SPFJmC82qEpFmQlVUeYSAYUJuOGHfFamqCkrcNayKpz6t6BicSjr?=
 =?us-ascii?Q?PrpGuuDMguf3quDSwoKWNTxzIODFgN4v/CqHZTShxDWZoDEZpXeWHr0ZE6rg?=
 =?us-ascii?Q?Jk7mbSkDx3FPAiXaNrCDotOWm/KBrFcx59Mgt5XyC/8GEHZIuuiEjXw+oXNs?=
 =?us-ascii?Q?8TrN3Hd0dYRliIzQV67N5VYaZ4y1H0wRatPlkd5VMnC3/4NupZVzUw51KaDb?=
 =?us-ascii?Q?S7XEhawh61pT2dUkTkw+oPaNvb5PFtM8vVJsj7KIYzyN9w3SgMbyuejBLkgl?=
 =?us-ascii?Q?z3XHmtDAHWEdJ3Cwn0wOB1TTeVSzsaGO6Qy5pAZUUQjxaH/bexYxDpIOXQPx?=
 =?us-ascii?Q?jOoL2AWNVJZj34TcXJDFpLAV8o0AFJFQNYz7l0UckxnJx5Q9HtDYOkYhVhmx?=
 =?us-ascii?Q?UTxvubF+S1FMan9UQ4k5QxQfvwPjYmhWLOyiLk+LtryNvthc1DyIpq+t1pA7?=
 =?us-ascii?Q?tAb7jJlu8DHUPSYxM3EXbtwCfe/AdU93yhClN9hFOSwoUhxkEvCSX8/0oLBF?=
 =?us-ascii?Q?sSkqyj8ocGHZK+6jtKl/ZcPdnKfaTlVHhgKY/+jAW9hnMFmiDGSaGWYl3J+c?=
 =?us-ascii?Q?Q/H0j73z1/w4rr2w4+HYHCRYMI/Sp+utpZBBzGwOf6+fZoBmg5zjhfAAy/Mq?=
 =?us-ascii?Q?OGwaPsavlIuwA8ztu2voeil5WlSuWqcywjBPWDJafQjqCiR0TJMLUL8jsXpY?=
 =?us-ascii?Q?XnFaSjj5tMvZCe6+9b4/8C5iA6PLpsKRDr9GOqd7mSl4NaKjinpK6EPODml9?=
 =?us-ascii?Q?z+fB540UXp0lrCZbhizNjTwrCkVm3Oldrr0GWe4nlt1B8GpRWXhxnvjD6r5l?=
 =?us-ascii?Q?wsfU5YEyjg5Ryw/oFhQMyAT/iBXEMgFLFYPGse0i9ED77IyxDJHaBa/omNVg?=
 =?us-ascii?Q?SCmMaAuiWnr2DetHRmfYmSN3j7oLNiRnNwuZaOvcbVxIGDKuICOp3Vlm5zh5?=
 =?us-ascii?Q?AqnLKMU4T6/uV6prbdLrgHGHdMVKLkZh2lGUWepxdlNXTOa/04arf+aaGaVS?=
 =?us-ascii?Q?wCjQsQLwcxEBnpxbyGqmyE0EYI70Dss2hB0kBWjmXNFbf6YNmXXuFUVPuilF?=
 =?us-ascii?Q?zX9p3n8E4AyQaYwIPUW77lgrPr49g7Jba+3ychpdD0lw54WJodAWOupw7reV?=
 =?us-ascii?Q?GOer3WWoMISczw8OjxLGKKNH2Xl4VN1NDROh6n6LtqkH6EcU3OnBTsa9+IAU?=
 =?us-ascii?Q?+f5Fw=3D=3D?=
X-Microsoft-Antispam-Message-Info: mhZM1I2R6ie1E8UibLKkZhY77Hk+/qT3AxczPrCHYpGypMLofVLFEm12CimjXyTKFxru9Dht8m1uyrr4bMlUJZjsYYrfnLddKc/GGQK6cbutRMRdI3nRtCjry66XfMfn4Gp3kSXzrT8a8fNcFuzNHyMWxDjpp3I44uaYUx3TD7wiNkPiGk+twcMOGeEMJwJZlFFi5QeoCrT7qqUGnuV042fazT6tnLNy44wbr2mIDo//+sgyEA7RJLBjRuwm02ZXRJhEKC2snYZHsWXdAoty+mRX4X6m7fj8AQkEIvBrtlxe/zpII/50nEDocxhZgC3r1QlW6uNA6pj2ZB343ampEXYAq405hJLy5FSZSc3u/v8=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:aQU/sVa9ZMshcoKZMKSxZzdTCdlA9d5TsExVe5VZkd0nXEXaw6pnNdoGcfvoDIS8q/QmTMwlhNJEEj9O3cHNdrdap/tMBIUMygUtPCnSvwaYOtot6oJd3/7g/HW+D7XN6jcLiiIn44j8INhjYBxdAe2y7tnMbMH29AAIzDU3mhV9iRbazWMTxCSS2z1Vq3fNNIRmsWtHvkFUtAzooiX9tHUVi6G6hu47iIZUAzIIbVTP3fzjPhvEJ58ng+VfKK1bYrgPn9Od2a534S4x22/QloMN5vDMd0fuGNv0VhIxiBUhHvKQ/iL423gvjKFe/ZdRajonlurg1rvp3VUVaQ775drikTL/XFHdWAjMZSWft7TnS3kJCz9Wyr8cgPhN7r8FbkGUIMx+RaVN/ilJKAwrkdaTICt3bDDwKXDd+dULazEtGUUeZUl6HdYRSecdRA7GENSCtPyMydZmuo/dgOzF4Q==;5:z7PkWcw4ZryoOkyr4znH6pnqB5vLzo8cnxrmvhT+R1vVW2VdTKQaJqMaKrrQKexKqRDUxZEj+oCLvsI6o6uylx3EL0QxoDztXjnyux9YpWgQDErlCge5aaKCAea12nmPo7rFesGGVt6JJHeqeGfoEmBV/p+15NAXB6jsVCEHRBo=;7:j0nirb7l23fmwLgqu5bkzUP4xTaYCcRs6yDF0kx4AeSriaT7YK9IAe+nYMobQuSedua2N9dB+ZqrCQnRdXPhPLuBMd+zV1v5EhYI3sr3M5Fw3nHBgmbqNIGrTBcYyaaaRMpocEeiWxBMNnoBxF9YTZqzGIUreHSRLABD0HZJ9aTthXzVRagbC9+9GFHrGtes1ONpjaWrL4Ukv9Xp0qfKWf4jZP45WlukTCzbJn8vjPUDmoaWjbK77U15xn6/1KmJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 01:23:42.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c578d193-340b-4487-f7df-08d5f428c1f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

On systems where physical memory begins at a non-zero address, defining
PHYS_OFFSET (which influences ARCH_PFN_OFFSET) can save us time & memory
by avoiding book-keeping for pages from address zero to the start of
memory.

Some MIPS platforms already make use of this, but with the definition of
PHYS_OFFSET being compile-time constant it hasn't been possible to
enable this optimization for a kernel which may run on systems with
varying physical memory base addresses.

Introduce a new Kconfig option CONFIG_MIPS_AUTO_PFN_OFFSET which, when
enabled, makes ARCH_PFN_OFFSET a variable & detects it from the boot
memory map (which for example may have been populated from DT). The
relationship with PHYS_OFFSET is reversed, with PHYS_OFFSET now being
based on ARCH_PFN_OFFSET. This is because ARCH_PFN_OFFSET is used far
more often, so avoiding the need for runtime calculation gives us a
smaller impact on kernel text size (0.1% rather than 0.15% for
64r6el_defconfig).

Signed-off-by: Paul Burton <paul.burton@mips.com>
Suggested-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig                           |  3 +++
 arch/mips/include/asm/mach-generic/spaces.h | 10 +++++++---
 arch/mips/include/asm/page.h                |  7 ++++++-
 arch/mips/kernel/setup.c                    | 14 ++++++++++++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 10256056647c..fbf7f678e856 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2985,6 +2985,9 @@ config PGTABLE_LEVELS
 	default 3 if 64BIT && !PAGE_SIZE_64KB
 	default 2
 
+config MIPS_AUTO_PFN_OFFSET
+	bool
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 952b0fdfda0e..ee5ebe98f6cf 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -17,9 +17,13 @@
 /*
  * This gives the physical RAM offset.
  */
-#ifndef PHYS_OFFSET
-#define PHYS_OFFSET		_AC(0, UL)
-#endif
+#ifndef __ASSEMBLY__
+# if defined(CONFIG_MIPS_AUTO_PFN_OFFSET)
+#  define PHYS_OFFSET		((unsigned long)PFN_PHYS(ARCH_PFN_OFFSET))
+# elif !defined(PHYS_OFFSET)
+#  define PHYS_OFFSET		_AC(0, UL)
+# endif
+#endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_32BIT
 #ifdef CONFIG_KVM_GUEST
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index a051b82f8009..e8cc328fce2d 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -80,7 +80,12 @@ extern void build_copy_page(void);
  * used in our early mem init code for all memory models.
  * So always define it.
  */
-#define ARCH_PFN_OFFSET		PFN_UP(PHYS_OFFSET)
+#ifdef CONFIG_MIPS_AUTO_PFN_OFFSET
+extern unsigned long ARCH_PFN_OFFSET;
+# define ARCH_PFN_OFFSET	ARCH_PFN_OFFSET
+#else
+# define ARCH_PFN_OFFSET	PFN_UP(PHYS_OFFSET)
+#endif
 
 extern void clear_page(void * page);
 extern void copy_page(void * to, void * from);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 3d4524309b5c..c71d1eb7da59 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -85,6 +85,11 @@ static struct resource bss_resource = { .name = "Kernel bss", };
 
 static void *detect_magic __initdata = detect_memory_region;
 
+#ifdef CONFIG_MIPS_AUTO_PFN_OFFSET
+unsigned long ARCH_PFN_OFFSET;
+EXPORT_SYMBOL(ARCH_PFN_OFFSET);
+#endif
+
 void __init add_memory_region(phys_addr_t start, phys_addr_t size, long type)
 {
 	int x = boot_mem_map.nr_map;
@@ -442,6 +447,12 @@ static void __init bootmem_init(void)
 		mapstart = max(reserved_end, start);
 	}
 
+	if (min_low_pfn >= max_low_pfn)
+		panic("Incorrect memory mapping !!!");
+
+#ifdef CONFIG_MIPS_AUTO_PFN_OFFSET
+	ARCH_PFN_OFFSET = PFN_UP(ramstart);
+#else
 	/*
 	 * Reserve any memory between the start of RAM and PHYS_OFFSET
 	 */
@@ -449,8 +460,6 @@ static void __init bootmem_init(void)
 		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
 				  BOOT_MEM_RESERVED);
 
-	if (min_low_pfn >= max_low_pfn)
-		panic("Incorrect memory mapping !!!");
 	if (min_low_pfn > ARCH_PFN_OFFSET) {
 		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
 			(min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
@@ -460,6 +469,7 @@ static void __init bootmem_init(void)
 			ARCH_PFN_OFFSET - min_low_pfn);
 	}
 	min_low_pfn = ARCH_PFN_OFFSET;
+#endif
 
 	/*
 	 * Determine low and high memory ranges
-- 
2.18.0
