Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 05:43:02 +0100 (CET)
Received: from mail-bl2nam02on0064.outbound.protection.outlook.com ([104.47.38.64]:25938
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992348AbdKNEjGqhM33 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 05:39:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=spgp1qju3c8iqgDTovyLxz4fVhdMx6UAsRYgVJjPNtM=;
 b=XknHE2DAAnv3w8ZoXexPWW55LToIygqpAIu/YEn4Jn/nsqRLxlOZzJveDhmveBn06p4g1drdYrga3iUwAwpnPRjimu2oS2FvTWnDxT4jOya86Q/l4srYUm2DqkSTaGL5jTY5hWAz7qcK04A8+RcIJc8knK7JHi/soNQna6FVhnc=
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3806.namprd07.prod.outlook.com (2603:10b6:803:4e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.218.12; Tue, 14
 Nov 2017 04:39:02 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, ralf@linux-mips.org,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 11/11] MIPS: Octeon: Add working hotplug CPU support.
Date:   Mon, 13 Nov 2017 22:30:27 -0600
Message-Id: <1510633827-23548-12-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0019.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::14) To SN4PR0701MB3806.namprd07.prod.outlook.com
 (2603:10b6:803:4e::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c9b875-8221-4670-2e99-08d52b19a240
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:SN4PR0701MB3806;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;3:M3qCU8ESLoaT2dqW4jaPi3IHWQvjcKhFNV7Dx5OOZWIHKaG9WugSokAkD5gr1x5dAcQ25MADIvNPjjurLcyNdHi/SxnQXs3WoHVEjHOSJk49MV4XBlnempPzGzBPFHeghxPJ6QINu8Hqo8y8EQFCjPQvWx5xOJAdfiZsmL6v+P4mMNS6mA0MF5VcmsILapciJuaX2RVrmyamP19C+xpfi3JDOrxhcVlD1013WdOGfoy3YXhXaUrk7p9xze5LAQM6;25:ZEkyXi7tGK1X6RsTo7JsRGhuYwJccZmZ731ERBDWrJ9zHbJLSHXZ8LdsQvWIfZq3EeSsM1jfdG5bLnUIzk9jhprQIFuavI9xDHywCS+6w5O43pJKTfYgGXWH2oA9XePgI4igT2NgSF84RPwuD8+9qjCtn4fkiwNV8ogl14Vdx6wT5wepZ27oHZP4e07d4E6hLAcI6MjJnbZUJqatmh8+sF/iW12p1sfL3KesTwbyQLKn/CCaN0gXStQioCfRsRZVmOkJPGTHs485jzPHcIi89qRMZ3a5vQZXnQkTkCm1Jj+bZLsDc2MnWF9MStJxZg3WkNoehXvWWf4apYf/ZZHG3g==;31:R3y/aQX3jI6bPDGHXPjH9TgrND1xi+ehSJjtY4CJNwTT/wu3IpJ/c7COt8KzEcB5CuwZp/0fjSp0Ws3z1z5C0gmM4IrqaEPZ9Yr+EI2tV2+O10SrgSoeaFHpn3jAOEb22OHyM0dXEdeh6gdPvVb5XRCKGp0eLQArwtLsf7BAIC2kmgCYhl7VjfqNsqkYSaaVVAJJ0IAOuWIF7XHYf1+37Lut+kVuDPfO6l8PVj7noSg=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3806:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;20:3izQkOmPpJ+MW+bbHG++IDFy0LR5+pa/RsFtXbkUg69sku6OomHY/EInXM3bGjBWxl2psMWzrn07oINbMCkVRzUkiJJN/bT7IXHwQcXMJtroN/EXbOL84dhHJ7QXkSuoYJs6zY5Q1CHe4gzVfJpI1Eyq1BD+vySyy7DP48tPk/kXAUOMUqmPIuYrgzlShUTzm0qasB2YJU3kdFsVsv50jhqwP9mX8drLUxQZSiCdjJCd+3I4MJuEyXn8ru+pmP6p2ju2tbHsW8rGwasOlUrDE6U5u/H3VP7EYe6O/QTsUCKsOVVfJmguthkC9CRTg8FGNLgDEeaAj0Y5xiIKgJld3M3cNdHAOlC/zy8Vt12N2U9l3zXxT02C4uV4CAsLV7gfcC26ETN6QIF0s+wy26TqheyvPhcKTs7ITWHtzaF1PuwnYM2F5ayYZUqmUQ59muwfEXu8vjiuyXGfrx8XkwysxgzIvQz+ND7d3Mve45tjj4xjQpO4QEijEYC5FvFMECDA;4:sG/NqnY8UCwSwLJTeVzFsHy0v3VXktDVPkENOmhqJ8ReSYSnrXMg3Qfct6otvCgVMwa++cwtLTtNpwULHBuTZDhP50wFvcu6sRkbfurkejyIXyIrdFsFXd8UidADMmoMK3GcBXGIr+8d3G6YjHB+TxdPHl6EPfvHC5SxQDGz+jHvKBIG75WppF95Gh5+D67OlFO0MbqqaSrMJu78KmAtc5ibcj5SrO3H4KQsUBv7Wwc1qAnx9aRiup7TybTtkcWC0nKzUqpJUfSsnd+kI8FC0Q==
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3806FD11D39E4F7604F9AB4180280@SN4PR0701MB3806.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3231022)(3002001)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3806;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3806;
X-Forefront-PRVS: 04916EA04C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(72206003)(76176999)(54906003)(53936002)(5660300001)(7736002)(50466002)(36756003)(478600001)(305945005)(69596002)(101416001)(16526018)(53416004)(6486002)(6506006)(50986999)(4326008)(48376002)(25786009)(5003940100001)(5890100001)(97736004)(316002)(47776003)(16586007)(8936002)(86362001)(189998001)(66066001)(3846002)(6116002)(50226002)(2361001)(2906002)(106356001)(68736007)(2950100002)(6916009)(6666003)(81156014)(81166006)(2351001)(6512007)(8676002)(33646002)(105586002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3806;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3806;23:iGlw5ZUWm2lfaKi2fwd1dk5zAvnWWKq+RDUq1s8?=
 =?us-ascii?Q?wQQf10sYUzsn4mzLC0AQMWTbmUA9k1hyhKnkRgwaVQS76C5QUO1w+/WyYD6a?=
 =?us-ascii?Q?s52/ZZ1gwApi49fn0se2+3EQO1EHWvUTHn6hOcxhFAOMBnUCuaWEYt6aKYS/?=
 =?us-ascii?Q?4UvXan4JyQhGawHX+tS90yct1vWcvn+BjH2qLduYY6014jKB8hTCEvZwsyvo?=
 =?us-ascii?Q?EevVzkqq1hMjl/7xf7nWHMM+foYdh5u/d0BpdhQHBl9YG9945mK7rZ0DkHkN?=
 =?us-ascii?Q?rVTKzfSODnvGJt4StwhO2nrbOKXCPXUffmXAnGAGjGPsb88xzpwR/yrZElFW?=
 =?us-ascii?Q?+a/tQogsQN23l7U004+sDkACNjXKxGP2iNZXMoSjZ0FY5VVuPfwjJ9Qw5Wk7?=
 =?us-ascii?Q?QFi6llgda4L0mG9z7I9Lt1GDez7cfzRK/uSTe4M1N0TGi5XKJXbk0BmNDPfR?=
 =?us-ascii?Q?3557ZdS7dWk2ba8wb6R224Ij8pbZb8Oe8Hsfxt6MTa9Fx00CWIew2uLBRu1w?=
 =?us-ascii?Q?5W0Cn6BX/20sVXAr7kn6IQxJZ15mS/J1pAjwkZhFkw64aBQoZm4Fi2lC30m4?=
 =?us-ascii?Q?j6DVtMwZiNZVOln/+VX0KRqfRlbkywY7ruALNkP8cazi732h0YzkonD9mUsp?=
 =?us-ascii?Q?kAElHaK7zS/CNIkY3vdppS34YMhjgl6yOJWxQWGlcjMMX9pF1CYFJHTiLuV9?=
 =?us-ascii?Q?HVjpFPBRtX8FstFxpub+OXu68QnDVctyIjJgPfi6bwBGYvWjymRmiyvkTaHZ?=
 =?us-ascii?Q?EVUzbcm3o7MaNScZBsQPxTITTdscN8LHoXOodiQuTFwq4rIU+K3c0QwZ1omA?=
 =?us-ascii?Q?5Gx7Xc5jUm+DupgXV6bX/b9ICSvdUxWe0zSERQjZnrAcjCwE7q+8/o+LAEfL?=
 =?us-ascii?Q?of4yNbIlOapz1G9TSYb2aOFEgFohFSLPVY3nGGWfO0ZQtpZdCDK7H+XHZivp?=
 =?us-ascii?Q?AUVASyyMDL8G2mPiEB7r6wKRgkjHxKuTQADzt3uR2icikIF1beg9U2PmxfaK?=
 =?us-ascii?Q?nuFv7obCCBTMCRyiYYubUs3CKqe+5hJnyuBSVHZ6qvYI28WoDFSXi1fiYyZY?=
 =?us-ascii?Q?kpQ3xBdERX9vF/RU9z5jCk5q1KAFy8XJLothJ2u3iLRTAFzQeZ2qmybqMf+5?=
 =?us-ascii?Q?sCzK6eBPyyUCBwgrkunX7MMMB37a/sj/8khPJuCZ89hp9MOIgqVBEQOyYUmn?=
 =?us-ascii?Q?2Rlc/NhCutrtnBwmKQs9vqnc+fCqDEwmXubpTD8azN4CvfVXWtQTNc9E6+A?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3806;6:AQ67G+pEKTKboQ4s89Qg8qPzb27alRQQYth0JRSTgtqDPxYTxdxS79bwUupUolnXZn7ZoiQlElcN1Aogojn4eZhVjZJgD1WPTK8ZbKhhsNcmxt1UsQtmWnkioyBi4x3cZDA07BZuB00ibrvwdkoBy0pQvBV9l9HXFqSUpg9TKiqrl2er51g039vMVr0SzomXJ8dmqV+U/MJsrDhdU9gAjoiXsv1OgKw0Cny2uWkCbJ8GVmr5HFPVS53n1A+ncO8AAuPDmNim6lRhCR8JMr1DrMx2GXnDOd4tJKnqEcebajWvhT1MrTu+iFNP7T2gGYVkfN7DdllIWoY67bfi4Xe8mrk9o1NIshzp2wtrrBImUPs=;5:5cqi6YGocfZ6Xs4yldUZijWG2H+lLCfIUyrucJePbbvvPGHfnVxUh4lAxyntrVYHFF815F1g1ZJR/XGt2Qh3atJ6CVDjo3MtWuSbCdYRSDlzkxmcGwFM6vblJ4zvQXmqpVsJ5okxLR/go64Kom/MnYBMwrO7Ci+hEqwGiUd/2No=;24:P9BW7Sdu//BuXJHGdSbdZO5addHyjZ3CNWvjEnm38RuCUHmyK166e8KuBl18rtS8Qilee0xxvEhFsL+1eL/j1X433zwJtjRmnZfEK8bD8MM=;7:i2xaFj32qzdFo7pDrU5/nLDf1S6srmCKPVONdXdg1pxQHOebqTZNLijUBf4yUBBh2m86rQokJrFBJ59PU74vQ4iiE5uwvM3PEMVR5OxWbeC1pbyGA/QdKPnZapcWc4rrh2khWTqsY0pDMo3PE3fRR/QZ2uhfUw+MasNFcK6OE59H3hfN+S5KnN8b1vScKyz0CjD0Yjrm3yVjJGqqrSMHAiDvrB8AT3eDl/WrJOhu1u3iOGUnicUCg+DqXKuBbFy8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2017 04:39:02.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c9b875-8221-4670-2e99-08d52b19a240
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3806
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/Kconfig                                  |   2 +-
 arch/mips/cavium-octeon/octeon_boot.h              |  95 ---------
 arch/mips/cavium-octeon/setup.c                    |   2 +-
 arch/mips/cavium-octeon/smp.c                      | 230 +++++++--------------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  60 +++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
 arch/mips/include/asm/octeon/cvmx.h                |  15 +-
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 9 files changed, 179 insertions(+), 254 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 475239d..6c85648 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -905,7 +905,7 @@ config CAVIUM_OCTEON_SOC
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
+	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
 	select HW_HAS_PCI
diff --git a/arch/mips/cavium-octeon/octeon_boot.h b/arch/mips/cavium-octeon/octeon_boot.h
deleted file mode 100644
index a6ce7c4..0000000
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- * (C) Copyright 2004, 2005 Cavium Networks
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-#ifndef __OCTEON_BOOT_H__
-#define __OCTEON_BOOT_H__
-
-#include <linux/types.h>
-
-struct boot_init_vector {
-	/* First stage address - in ram instead of flash */
-	uint64_t code_addr;
-	/* Setup code for application, NOT application entry point */
-	uint32_t app_start_func_addr;
-	/* k0 is used for global data - needs to be passed to other cores */
-	uint32_t k0_val;
-	/* Address of boot info block structure */
-	uint64_t boot_info_addr;
-	uint32_t flags;		/* flags */
-	uint32_t pad;
-};
-
-/* similar to bootloader's linux_app_boot_info but without global data */
-struct linux_app_boot_info {
-#ifdef __BIG_ENDIAN_BITFIELD
-	uint32_t labi_signature;
-	uint32_t start_core0_addr;
-	uint32_t avail_coremask;
-	uint32_t pci_console_active;
-	uint32_t icache_prefetch_disable;
-	uint32_t padding;
-	uint64_t InitTLBStart_addr;
-	uint32_t start_app_addr;
-	uint32_t cur_exception_base;
-	uint32_t no_mark_private_data;
-	uint32_t compact_flash_common_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-	uint32_t led_display_base_addr;
-#else
-	uint32_t start_core0_addr;
-	uint32_t labi_signature;
-
-	uint32_t pci_console_active;
-	uint32_t avail_coremask;
-
-	uint32_t padding;
-	uint32_t icache_prefetch_disable;
-
-	uint64_t InitTLBStart_addr;
-
-	uint32_t cur_exception_base;
-	uint32_t start_app_addr;
-
-	uint32_t compact_flash_common_base_addr;
-	uint32_t no_mark_private_data;
-
-	uint32_t led_display_base_addr;
-	uint32_t compact_flash_attribute_base_addr;
-#endif
-};
-
-/* If not to copy a lot of bootloader's structures
-   here is only offset of requested member */
-#define AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK	 0x765c
-
-/* hardcoded in bootloader */
-#define	 LABI_ADDR_IN_BOOTLOADER			 0x700
-
-#define LINUX_APP_BOOT_BLOCK_NAME "linux-app-boot"
-
-#define LABI_SIGNATURE 0xAABBCC01
-
-/*  from uboot-headers/octeon_mem_map.h */
-#define EXCEPTION_BASE_INCR	(4 * 1024)
-			       /* Increment size for exception base addresses (4k minimum) */
-#define EXCEPTION_BASE_BASE	0
-#define BOOTLOADER_PRIV_DATA_BASE	(EXCEPTION_BASE_BASE + 0x800)
-#define BOOTLOADER_BOOT_VECTOR		(BOOTLOADER_PRIV_DATA_BASE)
-
-#endif /* __OCTEON_BOOT_H__ */
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 2855d8d..068787d 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -756,7 +756,7 @@ void __init prom_init(void)
 	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
 	    OCTEON_IS_MODEL(OCTEON_CN31XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
-	else
+	else if (!OCTEON_IS_MODEL(OCTEON_CN78XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
 
 	/* Default to 64MB in the simulator to speed things up */
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index f08f175..8a3bfd3 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -3,41 +3,41 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
+ * Copyright (C) 2004-2017 Cavium, Inc.
  */
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
 #include <linux/sched.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/init.h>
 #include <linux/export.h>
 
-#include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/cvmx-boot-vector.h>
 
-#include "octeon_boot.h"
-
-volatile unsigned long octeon_processor_boot = 0xff;
-volatile unsigned long octeon_processor_sp;
-volatile unsigned long octeon_processor_gp;
+unsigned long octeon_processor_boot = 0xff;
+unsigned long octeon_processor_sp;
+unsigned long octeon_processor_gp;
 #ifdef CONFIG_RELOCATABLE
-volatile unsigned long octeon_processor_relocated_kernel_entry;
+unsigned long octeon_processor_relocated_kernel_entry;
 #endif /* CONFIG_RELOCATABLE */
 
 #ifdef CONFIG_HOTPLUG_CPU
-uint64_t octeon_bootloader_entry_addr;
-EXPORT_SYMBOL(octeon_bootloader_entry_addr);
+static struct cvmx_boot_vector_element *octeon_bootvector;
+static void *octeon_hotplug_entry_raw;
 #endif
 
-extern void kernel_entry(unsigned long arg1, ...);
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state);
 
 static void octeon_icache_flush(void)
 {
@@ -99,57 +99,32 @@ static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
 void octeon_send_ipi_single(int cpu, unsigned int action)
 {
 	int coreid = cpu_logical_map(cpu);
-	/*
-	pr_info("SMP: Mailbox send cpu=%d, coreid=%d, action=%u\n", cpu,
-	       coreid, action);
-	*/
+
 	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
 }
 
 static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 					unsigned int action)
 {
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		octeon_send_ipi_single(i, action);
-}
-
-/**
- * Detect available CPUs, populate cpu_possible_mask
- */
-static void octeon_smp_hotplug_setup(void)
-{
-#ifdef CONFIG_HOTPLUG_CPU
-	struct linux_app_boot_info *labi;
-
-	if (!setup_max_cpus)
-		return;
-
-	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-	if (labi->labi_signature != LABI_SIGNATURE) {
-		pr_info("The bootloader on this board does not support HOTPLUG_CPU.");
-		return;
-	}
+	int cpu;
 
-	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
-#endif
+	for_each_cpu(cpu, mask)
+		octeon_send_ipi_single(cpu, action);
 }
 
-static void __init octeon_smp_setup(void)
+static void octeon_smp_setup(void)
 {
 	const int coreid = cvmx_get_core_num();
 	int cpus;
 	int id;
-	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
-
 #ifdef CONFIG_HOTPLUG_CPU
-	int core_mask = octeon_get_boot_coremask();
 	unsigned int num_cores = cvmx_octeon_num_cores();
+	unsigned long t;
 #endif
+	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
 
 	/* The present CPUs are initially just the boot cpu (CPU 0). */
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < num_possible_cpus(); id++) {
 		set_cpu_possible(id, id == 0);
 		set_cpu_present(id, id == 0);
 	}
@@ -159,8 +134,9 @@ static void __init octeon_smp_setup(void)
 
 	/* The present CPUs get the lowest CPU numbers. */
 	cpus = 1;
-	for (id = 0; id < NR_CPUS; id++) {
-		if ((id != coreid) && cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
+	for (id = 0; id < CONFIG_MIPS_NR_CPU_NR_MAP; id++) {
+		if ((id != coreid) &&
+		    cvmx_coremask_is_core_set(&sysinfo->core_mask, id)) {
 			set_cpu_possible(cpus, true);
 			set_cpu_present(cpus, true);
 			__cpu_number_map[id] = cpus;
@@ -170,14 +146,21 @@ static void __init octeon_smp_setup(void)
 	}
 
 #ifdef CONFIG_HOTPLUG_CPU
+	octeon_bootvector = cvmx_boot_vector_get();
+	if (!octeon_bootvector) {
+		pr_err("Error: Cannot allocate boot vector.\n");
+		return;
+	}
+	t = __pa_symbol(octeon_hotplug_entry);
+	octeon_hotplug_entry_raw = phys_to_virt(t);
+
 	/*
 	 * The possible CPUs are all those present on the chip.	 We
 	 * will assign CPU numbers for possible cores as well.	Cores
 	 * are always consecutively numberd from 0.
 	 */
-	for (id = 0; setup_max_cpus && octeon_bootloader_entry_addr &&
-		     id < num_cores && id < NR_CPUS; id++) {
-		if (!(core_mask & (1 << id))) {
+	for (id = 0; id < num_cores && id < num_possible_cpus(); id++) {
+		if (!(cvmx_coremask_is_core_set(&sysinfo->core_mask, id))) {
 			set_cpu_possible(cpus, true);
 			__cpu_number_map[id] = cpus;
 			__cpu_logical_map[cpus] = id;
@@ -185,8 +168,6 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 #endif
-
-	octeon_smp_hotplug_setup();
 }
 
 
@@ -209,13 +190,33 @@ int plat_post_relocation(long offset)
 static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 {
 	int count;
+	int node;
+	int coreid = cpu_logical_map(cpu);
 
+	per_cpu(cpu_state, smp_processor_id()) = CPU_UP_PREPARE;
+#ifdef CONFIG_HOTPLUG_CPU
+	octeon_bootvector[coreid].target_ptr = (uint64_t)octeon_hotplug_entry_raw;
+#endif
+	mb();
+	/* Convert coreid to node,core spair and send NMI to target core */
+	node = cvmx_coremask_core_to_node(coreid);
+	coreid = cvmx_coremask_core_on_node(coreid);
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
+		cvmx_write_csr_node(node, CVMX_CIU3_NMI, (1ull << coreid));
+	else
+		cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid));
 	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
 		cpu_logical_map(cpu));
 
 	octeon_processor_sp = __KSTK_TOS(idle);
 	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
-	octeon_processor_boot = cpu_logical_map(cpu);
+	/* This barrier is needed to guarantee the following is done last */
+	mb();
+
+	/* Indicate which core is being brought up out of pan */
+	octeon_processor_boot = coreid;
+
+	/* Push the last update out before polling */
 	mb();
 
 	count = 10000;
@@ -223,12 +224,16 @@ static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 		/* Waiting for processor to get the SP and GP */
 		udelay(1);
 		count--;
+		mb();
 	}
 	if (count == 0) {
 		pr_err("Secondary boot timeout\n");
 		return -ETIMEDOUT;
 	}
 
+	octeon_processor_boot = ~0ul;
+	mb();
+
 	return 0;
 }
 
@@ -256,11 +261,24 @@ static void octeon_init_secondary(void)
  */
 static void __init octeon_prepare_cpus(unsigned int max_cpus)
 {
+	u64 mask;
+	u64 coreid;
+
 	/*
 	 * Only the low order mailbox bits are used for IPIs, leave
 	 * the other bits alone.
 	 */
-	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		mask = 0xff;
+	else
+		mask = 0xffff;
+
+	coreid = cvmx_get_core_num();
+
+	/* Clear pending mailbox interrupts */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), mask);
+
+	/* Attach mailbox interrupt handler */
 	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
 			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-IPI",
 			mailbox_interrupt)) {
@@ -275,6 +293,8 @@ static void __init octeon_prepare_cpus(unsigned int max_cpus)
 static void octeon_smp_finish(void)
 {
 	octeon_user_io_init();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
+	mb();
 
 	/* to generate the first CPU timer interrupt */
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
@@ -283,9 +303,6 @@ static void octeon_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* State of each CPU. */
-DEFINE_PER_CPU(int, cpu_state);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -293,9 +310,6 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	if (!octeon_bootloader_entry_addr)
-		return -ENOTSUPP;
-
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	octeon_fixup_irqs();
@@ -308,40 +322,8 @@ static int octeon_cpu_disable(void)
 
 static void octeon_cpu_die(unsigned int cpu)
 {
-	int coreid = cpu_logical_map(cpu);
-	uint32_t mask, new_mask;
-	const struct cvmx_bootmem_named_block_desc *block_desc;
-
 	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
 		cpu_relax();
-
-	/*
-	 * This is a bit complicated strategics of getting/settig available
-	 * cores mask, copied from bootloader
-	 */
-
-	mask = 1 << coreid;
-	/* LINUX_APP_BOOT_BLOCK is initialized in bootoct binary */
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		labi->avail_coremask |= mask;
-		new_mask = labi->avail_coremask;
-	} else {		       /* alternative, already initialized */
-		uint32_t *p = (uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
-							       AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-		*p |= mask;
-		new_mask = *p;
-	}
-
-	pr_info("Reset core %d. Available Coremask = 0x%x \n", coreid, new_mask);
-	mb();
-	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
 
 void play_dead(void)
@@ -349,71 +331,17 @@ void play_dead(void)
 	int cpu = cpu_number_map(cvmx_get_core_num());
 
 	idle_task_exit();
-	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
+	local_irq_disable();
 
-	mb();
-
-	while (1)	/* core will be reset here */
-		;
-}
-
-static void start_after_reset(void)
-{
-	kernel_entry(0, 0, 0);	/* set a2 = 0 for secondary core */
-}
-
-static int octeon_update_boot_vector(unsigned int cpu)
-{
-
-	int coreid = cpu_logical_map(cpu);
-	uint32_t avail_coremask;
-	const struct cvmx_bootmem_named_block_desc *block_desc;
-	struct boot_init_vector *boot_vect =
-		(struct boot_init_vector *)PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
-
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		avail_coremask = labi->avail_coremask;
-		labi->avail_coremask &= ~(1 << coreid);
-	} else {		       /* alternative, already initialized */
-		avail_coremask = *(uint32_t *)PHYS_TO_XKSEG_CACHED(
-			block_desc->base_addr + AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-	}
-
-	if (!(avail_coremask & (1 << coreid))) {
-		/* core not available, assume, that caught by simple-executive */
-		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
-	}
-
-	boot_vect[coreid].app_start_func_addr =
-		(uint32_t) (unsigned long) start_after_reset;
-	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
-
-	mb();
-
-	cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid) & avail_coremask);
-
-	return 0;
-}
-
-static int register_cavium_notifier(void)
-{
-	return cpuhp_setup_state_nocalls(CPUHP_MIPS_SOC_PREPARE,
-					 "mips/cavium:prepare",
-					 octeon_update_boot_vector, NULL);
+	/* core will be reset here */
+	while (1)
+		asm volatile ("	wait\n");
 }
-late_initcall(register_cavium_notifier);
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
-const struct plat_smp_ops octeon_smp_ops = {
+static struct plat_smp_ops octeon_smp_ops = {
 	.send_ipi_single	= octeon_send_ipi_single,
 	.send_ipi_mask		= octeon_send_ipi_mask,
 	.init_secondary		= octeon_init_secondary,
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38c..bef5092 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -3,11 +3,13 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2008 Cavium Networks, Inc
+ * Copyright (C) 2005-2017 Cavium, Inc
  */
 #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 
+#include <asm/octeon/cvmx-asm.h>
+
 #define CP0_CVMCTL_REG $9, 7
 #define CP0_CVMMEMCTL_REG $11,7
 #define CP0_PRID_REG $15, 0
@@ -26,6 +28,62 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+#ifdef CONFIG_HOTPLUG_CPU
+	b	7f
+FEXPORT(octeon_hotplug_entry)
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	move	a3, zero
+7:
+#endif	/* CONFIG_HOTPLUG_CPU */
+	mfc0	v0, CP0_STATUS
+	/* Force 64-bit addressing enabled */
+	ori	v0, v0, (ST0_UX | ST0_SX | ST0_KX)
+	/* Clear NMI and SR as they are sometimes restored and 0 -> 1
+	 * transitions are not allowed
+	 */
+	li	v1, ~(ST0_NMI | ST0_SR)
+	and	v0, v1
+	mtc0	v0, CP0_STATUS
+
+	# Clear the TLB.
+	mfc0	v0, CP0_CONFIG, 1
+	ext	v0, v0, MIPS_CONF1_TLBS_SHIFT, MIPS_CONF1_TLBS_SIZE
+	mfc0	v1, CP0_CONFIG, 3
+	bgez	v1, 1f
+	mfc0	v1, CP0_CONFIG, 4
+	andi	v1, v1, MIPS_CONF4_MMUSIZEEXT_SIZE
+	ins	v0, v1, MIPS_CONF1_TLBS_SIZE, MIPS_CONF4_MMUSIZEEXT_SIZE
+1:				# Number of TLBs in v0
+
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	dla	t0, 0xffffffff90000000
+10:
+	dmtc0	t0, $10, 0	# EntryHi
+	tlbp
+	mfc0	t1, $0, 0	# Index
+	bltz	t1, 1f
+	tlbr
+	dmtc0	zero, $2, 0	# EntryLo0
+	dmtc0	zero, $3, 0	# EntryLo1
+	dmtc0	zero, $5, 0	# PageMask
+	tlbwi			# Make it a 'normal' sized page
+	daddiu	t0, t0, 8192
+	b	10b
+1:
+	mtc0	v0, $0, 0	# Index
+	tlbwi
+	.set	noreorder
+	bne	v0, zero, 10b
+	 addiu	v0, v0, -1
+	.set	reorder
+
+	mtc0	zero, $0, 0	# Index
+	dmtc0	zero, $10, 0	# EntryHi
+
 	# Read the cavium mem control register
 	dmfc0	v0, CP0_CVMMEMCTL_REG
 	# Clear the lower 6 bits, the CVMSEG size
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a681092..3fa2352 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -633,6 +633,7 @@
 
 #define MIPS_CONF4_MMUSIZEEXT_SHIFT	(0)
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
+#define MIPS_CONF4_MMUSIZEEXT_SIZE	(8)
 #define MIPS_CONF4_FTLBSETS_SHIFT	(0)
 #define MIPS_CONF4_FTLBSETS	(_ULCAST_(15) << MIPS_CONF4_FTLBSETS_SHIFT)
 #define MIPS_CONF4_FTLBWAYS_SHIFT	(4)
diff --git a/arch/mips/include/asm/octeon/cvmx-coremask.h b/arch/mips/include/asm/octeon/cvmx-coremask.h
index 097dc09..625cf94 100644
--- a/arch/mips/include/asm/octeon/cvmx-coremask.h
+++ b/arch/mips/include/asm/octeon/cvmx-coremask.h
@@ -29,7 +29,6 @@
 #ifndef __CVMX_COREMASK_H__
 #define __CVMX_COREMASK_H__
 
-#define CVMX_MIPS_MAX_CORES 1024
 /* bits per holder */
 #define CVMX_COREMASK_ELTSZ 64
 
@@ -86,4 +85,29 @@ static inline void cvmx_coremask_clear_core(struct cvmx_coremask *pcm, int core)
 	pcm->coremask_bitmap[i] &= ~(1ull << n);
 }
 
+/**
+ * For multi-node systems, return the node a core belongs to.
+ *
+ * @param core - core number (0-1023)
+ *
+ * @return node number core belongs to
+ */
+static inline int cvmx_coremask_core_to_node(int core)
+{
+	return (core >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
+}
+
+/**
+ * Given a core number on a multi-node system, return the core number for a
+ * particular node.
+ *
+ * @param core - global core number
+ *
+ * @returns core number local to the node.
+ */
+static inline int cvmx_coremask_core_on_node(int core)
+{
+	return (core & GENMASK((CVMX_NODE_NO_SHIFT - 1), 0));
+}
+
 #endif /* __CVMX_COREMASK_H__ */
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 392556a..6d9851a 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -53,6 +53,17 @@ enum cvmx_mips_space {
 #define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
 #endif
 
+#define CVMX_MAX_CORES		(48)
+#define CVMX_MIPS_MAX_CORE_BITS	(10)    /** Maximum # of bits to define cores */
+#define CVMX_MIPS_MAX_CORES	(1 << CVMX_MIPS_MAX_CORE_BITS)
+#define CVMX_NODE_NO_SHIFT	(7)     /* Maximum # of bits to define core in node */
+#define CVMX_NODE_BITS		(2)     /* Number of bits to define a node */
+#define CVMX_NODE_MASK		(CVMX_MAX_NODES - 1)
+#define CVMX_MAX_NODES		(1 << CVMX_NODE_BITS)
+#define CVMX_NODE_IO_SHIFT	(36)
+#define CVMX_NODE_MEM_SHIFT	(40)
+#define CVMX_NODE_IO_MASK	((uint64_t)CVMX_NODE_MASK << CVMX_NODE_IO_SHIFT)
+
 #include <asm/octeon/cvmx-asm.h>
 #include <asm/octeon/octeon-model.h>
 
@@ -83,7 +94,6 @@ enum cvmx_mips_space {
 #define cvmx_dprintf(...)   {}
 #endif
 
-#define CVMX_MAX_CORES		(16)
 #define CVMX_CACHE_LINE_SIZE	(128)	/* In bytes */
 #define CVMX_CACHE_LINE_MASK	(CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
 #define CVMX_CACHE_LINE_ALIGNED __attribute__ ((aligned(CVMX_CACHE_LINE_SIZE)))
@@ -339,9 +349,6 @@ static inline unsigned int cvmx_get_core_num(void)
 	return core_num;
 }
 
-/* Maximum # of bits to define core in node */
-#define CVMX_NODE_NO_SHIFT	7
-#define CVMX_NODE_MASK		0x3
 static inline unsigned int cvmx_get_node_num(void)
 {
 	unsigned int core_num = cvmx_get_core_num();
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6..0980628 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -355,6 +355,8 @@ extern uint64_t octeon_bootloader_entry_addr;
 
 extern void (*octeon_irq_setup_secondary)(void);
 
+extern asmlinkage void octeon_hotplug_entry(void);
+
 typedef void (*octeon_irq_ip4_handler_t)(void);
 void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t);
 
-- 
2.1.4
