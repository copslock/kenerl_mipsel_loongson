Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:54:27 +0200 (CEST)
Received: from mail-by2nam01on0093.outbound.protection.outlook.com ([104.47.34.93]:17536
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993920AbeH2VyXwSl7p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Aug 2018 23:54:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+vIdJyjDO8tpDSxpWQ7p7f4ChviniaDhNehsr81G9Q=;
 b=lFRf2mu+ThTei4KUPWeBI+mRcSdvrpJtysO96x4M846NZPKjrZDldf+iQyw86RmaCP5Qls9gk8olHqKOFNm2NAAd9NBCPTnnPAOakh231yoMO9EL+2Gbc8IA+N39JpSI7+BvgUkGWuXzUUCiAJsGZ5togkd1Hkj48Wh7TWTED3g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4937.namprd08.prod.outlook.com (2603:10b6:5:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 21:54:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>
Subject: [PATCH 1/2] MIPS: Use GENERIC_IOMAP
Date:   Wed, 29 Aug 2018 14:54:00 -0700
Message-Id: <20180829215401.874-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:3:37::30) To DM6PR08MB4937.namprd08.prod.outlook.com
 (2603:10b6:5:4b::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37824e46-d9c0-4e9c-44ef-08d60df9f532
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;3:CK1/W+8CB/BYFUhEvkoyFaf0vuHDt2BcmFDRJfP/fe2RMqP+d3MsErmmA5n7N0vNk3OB58ie/W+3w6OfUixrOCSLs0h8JAOlpEvW4Eij5dh3JJGR6FnFcOzTVGgWXWm9u0MOxt+SFP8PpdyitidvTNQS6fMJlLMNofGFajX7Bv6cFjhKBW3E8jvyQ4oPEfdZUiZEERwhEi0rm4VUSuvl9mahijd9g85KTlniuM0PZ6ccHjJ45hAgOwCgcBcP1yEH;25:NoqCum6/lQFixho9m0a5RQeIh1csTg/OmGDgCkb9ukjb3G5XdVvYLN01UgV41SbMRg9NOM/TDxGC2fTxrqO/gi3FwdUOTjgVHuxuE9isSl6xetwmKgOOhxM71NWi+MEaqKvROoNIEdFFAIf4GWnaD66f74pxtvfNlG4RQJ+DY1+dVxGEvckEWAS04tFOtUeTQB8CjejVvsKyiGy6dU4N4BjTZwKy9nIdv6dc/EC6UF4vJAwVzkIgihsNKzhA/mBBF4mgrpxX2YR3sZuVWCFce365fwNOv+eDFvMhriQXS8OCCRLD1R/wumTvcDw+FEE2MKPg3wSPmHNEnRmmnb7WdQ==;31:lP4/psJbNDMQLUjTVGxZSGoSZTeeG54/b1I6TAu0H4dZlGudgKbHMmmLGDhiJhSMF9fB/jJdaLTOnlb85uvLRbTUWNUdSiPpASU/Ud+CmSSysxmrUpRjDnoFZw2mSw+vvVIVqlom+zm8VpT6/AywU9+wcc/fwdki/sGAWbfjaRmyVXsw+FzCIuGL85wX7UUKA8doXaiH4BfsOg8Z2TXZkQ3KSL0/m5F661sHTmt1sy0=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;20:qOssKkPE7ikH8r8/mTFmEMhlUuW1qyPgJJMScKP5NcVmtp7H8T/Vtq8YGmUshLSDcJh65GNz/GOgl5Shia7BpTRJtYhaK4XqTYb7Lh/UY2riMZiqrzTmpA9oAzFw848dNCbpWmKVWN1WYfbTFcEtcSdQeC63DzYcO29TPOAfPQi/a3+BHEJ5YVpGrkifw4YC7KPE46SnP7BxdeMqE85kpQQgO2zk/Q5miZDm4QAa2TxkuXwFhysm63Vldk25NbpC;4:vfquWsRIxaNfWCj9BerMypYkoHXfFzOGUIK4O3EdLuSnlbHCIXRZ0o4wzzkrI+9/Cnlb3GH+jdj4wDiAENJpdoknmezRLK2Fa0FUp8QsfsgOBV/UStxGm9KB/XAwn/P/K7PRA+P4qCmJ5tImMeiesB9j8vzZN/aOuDM89XDKMUPCFcy6Sby4ErRnWIVCsNMz/cAIMbWkFMDPigkWwVK0Kwg7tfy2l5hwpOKVrwmRtz7fk7wfRnkB4xeEJeCyM3WhjJ/g8eH8VA0fjxY5B94Rsw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49375D244AA89F4B4BA8A834C1090@DM6PR08MB4937.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR08MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4937;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(52314003)(66066001)(186003)(575784001)(6506007)(386003)(2351001)(53936002)(6116002)(69596002)(50466002)(48376002)(50226002)(8936002)(3846002)(47776003)(1076002)(476003)(486006)(26005)(2616005)(956004)(16586007)(53416004)(316002)(478600001)(106356001)(105586002)(16526019)(4326008)(42882007)(52116002)(107886003)(25786009)(14444005)(5660300001)(305945005)(81156014)(6666003)(8676002)(81166006)(6916009)(51416003)(7736002)(2906002)(36756003)(2361001)(68736007)(6486002)(44832011)(97736004)(6512007)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4937;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4937;23:ckvVPCnv6/qRcuMcq7t15KxzXxXjMlF2nP8MLuN0P?=
 =?us-ascii?Q?eQx5r4JnyEKOFFSYDPkV+dgSh+wWyiQSYKksVjQ0R9VzjJT3iDBVYO1DEKNf?=
 =?us-ascii?Q?/5Z/dFkaN3eDAwca+E30wX9dsQc5/CtkwugwCw3849IzUb+wA3Wf9njTco21?=
 =?us-ascii?Q?jBAnLWAyoODaIRfkpPEceND7wUnKJ1xmD3txKttTHRsAHoBwx0FY5Zf/x2QV?=
 =?us-ascii?Q?vy7W5/foJUYFdM5VzSIsjAJuK8nvnSCD70va0PZBKPYGe++YF80QeypkRuJH?=
 =?us-ascii?Q?I/w9nxzRtcJ0Kgt/jmlvkCQEBKimlgA1hIOPRlwijLsvuDHlGR0B5hmdqCC7?=
 =?us-ascii?Q?6Hu/t4Mfhpa+3J43M0Wz9mMNuuCsGz8jJwCBPojTNi2YXiapADXzyg7VwzRo?=
 =?us-ascii?Q?lMXOLa8pResErCJMYH2eaX/bewa7CHXSSfKqonScmfWqRRj0EDEIr2bjRIjv?=
 =?us-ascii?Q?CFEKm3PK1xtDciGRQs2zxw6+Oo7lYuR6nJIwHGmDQ7NbCP3svSHivHlZtxsT?=
 =?us-ascii?Q?L3ybL1V3PP9nQvwFxiGHz9p74uEdL8YMf/oq/FkeOg3bSvEKTx1U0C9Hud60?=
 =?us-ascii?Q?v9BDQI2F+j7JDQJnUHrPaoUFFK+khP/FcjFEOHoqBiFld9U59SFtk5jg+r7k?=
 =?us-ascii?Q?KKI3EPdKQff85345GIGZHf8NuebzPylCWPpUN7nWkRGLRvDpn7hHp8W1haaI?=
 =?us-ascii?Q?PQyu1Cpz6WiMxv+ayw+8M2IjuOJe+OmpF5TeiyB1xZOg4JgcD7gW3OhpX/pU?=
 =?us-ascii?Q?UvE+g6FrUCFQjOyw0faMMaI+WH6mdT4mGVDiurn6426spkV0tL/A2N7Asbgt?=
 =?us-ascii?Q?kcuO+T5ywIUoMJwCan7KNlU81VY5ZHNYDe6n/KkEUaXXdRzgvP+7VvEV1vIf?=
 =?us-ascii?Q?5h/mhU8HWcqHeMmPklauYLGQa/iaUtV039qw2e//wMR2a+CP0JmF2L2uKVvA?=
 =?us-ascii?Q?2hYNvejiopiUrQPMNaC4v28xhxLtaSgl+DWiDIYQTYtzM9Q8HEdxHeS7JLmp?=
 =?us-ascii?Q?bJSx/MHdAQJlwlcTVXBCSFHaRopgKlxKutoA9hmlEAC5BLEOy7rVAIDft8Fu?=
 =?us-ascii?Q?zTw8Ml8kKusd2Z6hemj1Hygo+eO64PrjYuDNaAGR+6EnA4zBQ7WUBnEVkLbu?=
 =?us-ascii?Q?WB1U7CJ4MQu20APA4wt2ChygZgOWC3SbO6X9i83pEsv0vRMhv8DWpouIJA1c?=
 =?us-ascii?Q?5fHxS4OF3pLwJ4bZBDwM98H/YsC6o8KiKlyfDL/ndALO0BYZLzcBovMbbs+n?=
 =?us-ascii?Q?DdGobrVoqAcJKO8fJ6nz1Wbal2QNcIPd6olqumKODwCulzg9UPOneZpDeNUg?=
 =?us-ascii?Q?puazFmGuXfAD5RgvZkmqNlSLbBETbAOzmZf5szxKEhR?=
X-Microsoft-Antispam-Message-Info: J0/aGCd8c/n0Me37ckXHAHNzKUVXE8nIzG38gqGDhxsQDYk+CARyEQjWww2Qm/msLmjvvzz/6WadFbn0hztcX5R/elOz8jg23tja4v9vpSH8bYzPQ8i/H1UuZCpMspmSKYYsrsMd/BGwmrc9IB42sSqO2e1H25vwoca+Ge0rb5M4VijzDszOM6XIN/wgXlMm400O4u4tPUnuYcOK+CG7vlBjqQ+6WCpjIQXB+vFeWhHtSkTeobKFGZMfwuIQc+GfpMT4VsCR6QU949c4kbYzftAtmMyfM6ZbcEAIq6Ukyr0QytlVVz51AqKwHWtxps5PqugsrACaKuS79cF2SkhsB67qHq8ku4WeEQAsy4j8bzg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;6:M577WVujENVrWdkMRnDur00mLWcnlySy8GGTg7yJAx5wcVqVudqnnmgZxhaqyuFU43euwVar6HU+cqL06UfyTNtjADmNL7/MoI1/8+LPFmbLaZ/pVf0N94WjFjsz/KhZIwwqZpn2uGWLMrO1wgly6AgFNWUyzUXlwcEn7LItkAf5OCcRNQC7UfG8v8G9K+yWp0b4YF+/uZjLpC80YOmdy9TM7wQ4f0bN4+jsIrbvrF0ExNV0Y2WuFKdUTD4/NpcITDRvDbuucgNTzF+AuUnNwv+tRP4enSc33DiQzbBiSoIzpkZpaCnd81gtnCZgu4no8y9yz5Ssttflh9lO0Ot68VhLs3BCHMPfgWJv0QBheBd1VYvPl8M4L6DFlrk58jcM7+TyH4ZFV365JpqnNbBbEOEjS3oTHPrI9rsh8xMGOvvKLVKnBVfJaNzih6yMijqvu0rMMPEnhuAOJko1t6Cz0w==;5:3VibcLWpLz1D4JiFUw5CMZ3f1ESmzrxenmFSPPA7BFz9KgCjSOqHIFPm2e3YO4CRBVA8tXpD9zSpm3gyeM6ljbr/nXopaOGTzI7mwmxYqvqX5xBl7VD30pK1PrXvzrYE7vlo2E/eFZtkqinTqzRO0PaCgABM7ON1mx2mny1h7KE=;7:utIpWq/rzS0AG9SbPBAhbXNZ5lHt4dolEunFHDI0JNz0HiUM76tx2tujS5oeHRJMefRyXszpVCYzmLJeT8L8zat+CUB8rawqFwGukWOzXryvu0bbuvzDjP+lfaB9voeZ9rRv5Xoahme+L7wAU4aBtgzOC9/R4Axw8kFLIBj+8FyZZfQgSRTqsBYmm0PW2QZNNNcPP2La1wRI2gcnoJMCwYlcRPIRenDDn3GHSdLqQ+/r7JsEWHUqxzYvwGf5Y2go
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 21:54:12.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37824e46-d9c0-4e9c-44ef-08d60df9f532
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4937
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65798
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

MIPS has a copy of lib/iomap.c with minor alterations, none of which are
necessary given appropriate definitions of PIO_OFFSET, PIO_MASK &
PIO_RESERVED. Provide such definitions, select GENERIC_IOMAP & remove
arch/mips/lib/iomap.c to cut back on the needless duplication.

The one change this does make is to our mmio_{in,out}s[bwl] functions,
which began to deviate from their generic counterparts with commit
0845bb721ebb ("MIPS: iomap: Use __mem_{read,write}{b,w,l} for MMIO"). I
suspect that this commit was incorrect, and that the SEAD-3 platform
should have instead selected CONFIG_SWAP_IO_SPACE. Since the SEAD-3
platform code is now gone & the board is instead supported by the
generic platform (CONFIG_MIPS_GENERIC) which selects
CONFIG_SWAP_IO_SPACE anyway, this shouldn't be a problem any more.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Kconfig          |   2 +-
 arch/mips/include/asm/io.h |  15 ++-
 arch/mips/lib/Makefile     |   2 +-
 arch/mips/lib/iomap-pci.c  |   7 --
 arch/mips/lib/iomap.c      | 227 -------------------------------------
 5 files changed, 12 insertions(+), 241 deletions(-)
 delete mode 100644 arch/mips/lib/iomap.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..1a119fd7324d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -21,6 +21,7 @@ config MIPS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_LIB_ASHLDI3
@@ -28,7 +29,6 @@ config MIPS
 	select GENERIC_LIB_CMPDI2
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
-	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 54c730aed327..bbbeede9fea1 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -79,6 +79,16 @@ static inline void set_io_port_base(unsigned long base)
 	barrier();
 }
 
+/*
+ * Provide the necessary definitions for generic iomap. We make use of
+ * mips_io_port_base for iomap(), but we don't reserve any low addresses for
+ * use with I/O ports.
+ */
+#define HAVE_ARCH_PIO_SIZE
+#define PIO_OFFSET	mips_io_port_base
+#define PIO_MASK	IO_SPACE_LIMIT
+#define PIO_RESERVED	0x0UL
+
 /*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
@@ -172,11 +182,6 @@ static inline void *isa_bus_to_virt(unsigned long address)
 extern void __iomem * __ioremap(phys_addr_t offset, phys_addr_t size, unsigned long flags);
 extern void __iounmap(const volatile void __iomem *addr);
 
-#ifndef CONFIG_PCI
-struct pci_dev;
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {}
-#endif
-
 static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long size,
 	unsigned long flags)
 {
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 6537e022ef62..479f50559c83 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -7,7 +7,7 @@ lib-y	+= bitops.o csum_partial.o delay.o memcpy.o memset.o \
 	   mips-atomic.o strncpy_user.o \
 	   strnlen_user.o uncached.o
 
-obj-y			+= iomap.o iomap_copy.o
+obj-y			+= iomap_copy.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
 lib-$(CONFIG_GENERIC_CSUM)	:= $(filter-out csum_partial.o, $(lib-y))
 
diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
index 4850509c5534..210f5a95ecb1 100644
--- a/arch/mips/lib/iomap-pci.c
+++ b/arch/mips/lib/iomap-pci.c
@@ -44,10 +44,3 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
 }
 
 #endif /* CONFIG_PCI_DRIVERS_LEGACY */
-
-void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
-{
-	iounmap(addr);
-}
-
-EXPORT_SYMBOL(pci_iounmap);
diff --git a/arch/mips/lib/iomap.c b/arch/mips/lib/iomap.c
deleted file mode 100644
index 9b31653f318c..000000000000
--- a/arch/mips/lib/iomap.c
+++ /dev/null
@@ -1,227 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Implement the default iomap interfaces
- *
- * (C) Copyright 2004 Linus Torvalds
- * (C) Copyright 2006 Ralf Baechle <ralf@linux-mips.org>
- * (C) Copyright 2007 MIPS Technologies, Inc.
- *     written by Ralf Baechle <ralf@linux-mips.org>
- */
-#include <linux/export.h>
-#include <asm/io.h>
-
-/*
- * Read/write from/to an (offsettable) iomem cookie. It might be a PIO
- * access or a MMIO access, these functions don't care. The info is
- * encoded in the hardware mapping set up by the mapping functions
- * (or the cookie itself, depending on implementation and hw).
- *
- * The generic routines don't assume any hardware mappings, and just
- * encode the PIO/MMIO as part of the cookie. They coldly assume that
- * the MMIO IO mappings are not in the low address range.
- *
- * Architectures for which this is not true can't use this generic
- * implementation and should do their own copy.
- */
-
-#define PIO_MASK	0x0ffffUL
-
-unsigned int ioread8(void __iomem *addr)
-{
-	return readb(addr);
-}
-
-EXPORT_SYMBOL(ioread8);
-
-unsigned int ioread16(void __iomem *addr)
-{
-	return readw(addr);
-}
-
-EXPORT_SYMBOL(ioread16);
-
-unsigned int ioread16be(void __iomem *addr)
-{
-	return be16_to_cpu(__raw_readw(addr));
-}
-
-EXPORT_SYMBOL(ioread16be);
-
-unsigned int ioread32(void __iomem *addr)
-{
-	return readl(addr);
-}
-
-EXPORT_SYMBOL(ioread32);
-
-unsigned int ioread32be(void __iomem *addr)
-{
-	return be32_to_cpu(__raw_readl(addr));
-}
-
-EXPORT_SYMBOL(ioread32be);
-
-void iowrite8(u8 val, void __iomem *addr)
-{
-	writeb(val, addr);
-}
-
-EXPORT_SYMBOL(iowrite8);
-
-void iowrite16(u16 val, void __iomem *addr)
-{
-	writew(val, addr);
-}
-
-EXPORT_SYMBOL(iowrite16);
-
-void iowrite16be(u16 val, void __iomem *addr)
-{
-	__raw_writew(cpu_to_be16(val), addr);
-}
-
-EXPORT_SYMBOL(iowrite16be);
-
-void iowrite32(u32 val, void __iomem *addr)
-{
-	writel(val, addr);
-}
-
-EXPORT_SYMBOL(iowrite32);
-
-void iowrite32be(u32 val, void __iomem *addr)
-{
-	__raw_writel(cpu_to_be32(val), addr);
-}
-
-EXPORT_SYMBOL(iowrite32be);
-
-/*
- * These are the "repeat MMIO read/write" functions.
- * Note the "__mem" accesses, since we want to convert
- * to CPU byte order if the host bus happens to not match the
- * endianness of PCI/ISA (see mach-generic/mangle-port.h).
- */
-static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
-{
-	while (--count >= 0) {
-		u8 data = __mem_readb(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_insw(void __iomem *addr, u16 *dst, int count)
-{
-	while (--count >= 0) {
-		u16 data = __mem_readw(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_insl(void __iomem *addr, u32 *dst, int count)
-{
-	while (--count >= 0) {
-		u32 data = __mem_readl(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_outsb(void __iomem *addr, const u8 *src, int count)
-{
-	while (--count >= 0) {
-		__mem_writeb(*src, addr);
-		src++;
-	}
-}
-
-static inline void mmio_outsw(void __iomem *addr, const u16 *src, int count)
-{
-	while (--count >= 0) {
-		__mem_writew(*src, addr);
-		src++;
-	}
-}
-
-static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
-{
-	while (--count >= 0) {
-		__mem_writel(*src, addr);
-		src++;
-	}
-}
-
-void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
-{
-	mmio_insb(addr, dst, count);
-}
-
-EXPORT_SYMBOL(ioread8_rep);
-
-void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
-{
-	mmio_insw(addr, dst, count);
-}
-
-EXPORT_SYMBOL(ioread16_rep);
-
-void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
-{
-	mmio_insl(addr, dst, count);
-}
-
-EXPORT_SYMBOL(ioread32_rep);
-
-void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	mmio_outsb(addr, src, count);
-}
-
-EXPORT_SYMBOL(iowrite8_rep);
-
-void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	mmio_outsw(addr, src, count);
-}
-
-EXPORT_SYMBOL(iowrite16_rep);
-
-void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	mmio_outsl(addr, src, count);
-}
-
-EXPORT_SYMBOL(iowrite32_rep);
-
-/*
- * Create a virtual mapping cookie for an IO port range
- *
- * This uses the same mapping are as the in/out family which has to be setup
- * by the platform initialization code.
- *
- * Just to make matters somewhat more interesting on MIPS systems with
- * multiple host bridge each will have it's own ioport address space.
- */
-static void __iomem *ioport_map_legacy(unsigned long port, unsigned int nr)
-{
-	return (void __iomem *) (mips_io_port_base + port);
-}
-
-void __iomem *ioport_map(unsigned long port, unsigned int nr)
-{
-	if (port > PIO_MASK)
-		return NULL;
-
-	return ioport_map_legacy(port, nr);
-}
-
-EXPORT_SYMBOL(ioport_map);
-
-void ioport_unmap(void __iomem *addr)
-{
-	/* Nothing to do */
-}
-
-EXPORT_SYMBOL(ioport_unmap);
-- 
2.18.0
