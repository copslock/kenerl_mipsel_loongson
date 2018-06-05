Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2018 07:51:40 +0200 (CEST)
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:25310
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994702AbeFEFteXVekB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jun 2018 07:49:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO2cCOSxE01I/GDHesD9i2viJrvSms08HFO0MWpONbc=;
 b=J/2kfwIWRHDYNFlygCYK5C7icEu1gn+cXwL7UHcs22wgK3ZFxG4YSObeWvtfzmlqzB9w2Kzk/a0qlZjIkuovTBVybKQc5B0fFz74ddZKMnb17JDeOunLX/5P4U0cK2Tp/V1XEGydb7B0O1umshfz1hOeV3NQVYmW2vlWPcLDAwA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.caveonetworks.com (12.108.191.226) by
 SN1PR07MB3966.namprd07.prod.outlook.com (2603:10b6:802:26::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Tue, 5 Jun 2018 05:49:23 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v7 8/8] MIPS: Octeon: Add working hotplug CPU support.
Date:   Tue,  5 Jun 2018 00:24:57 -0500
Message-Id: <1528176297-21697-9-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
References: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [12.108.191.226]
X-ClientProxiedBy: SN1PR0701CA0012.namprd07.prod.outlook.com
 (2a01:111:e400:5173::22) To SN1PR07MB3966.namprd07.prod.outlook.com
 (2603:10b6:802:26::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR07MB3966;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;3:4eCjSLVfyWENhhV8alYT/qSdcAAc/TNLIvJTwNMvcIEueTo0xDDYlyJesPOQSynQGQqh+7BrfyIBBaqLYHTr8vwOmoM25cDXznYz9sBHUUBtzjRTEcu7AEutk2CnbJH5NJihgIVW7j8h0frsR45stdrUumWazsmIplF0lSqmnN3vJrrXXxqRozeGZe2IMrsXH0tcPoZK42kWgvnizhtTcczldsh3IXOU0dlCaQ5rAb5/6620cpAj/leAZ5Y7ZoJY;25:UfeXUmj0Zx8MLu9LI7CSHCL4cRzjIDjHcvHThXWxbtQvH5fEs4DXRtA+27NTJ7aar69un/C7+xzE5Yz6JJd5oE8Q4NAbQrMTYLkwtsQ1qRdFn8N3AGUQ5xFB/cy5rLSNGdyl+QgCy0FXm8yyq7isUhrsewk+gliqqA/Vu9Dk+pUr2SQhTNh9LRlDrTwbMH7CO0Xy3M4g+UINdNmTqeubboQ5E3j/EgPWWScAUl9Eqn2vx8jpMyv8GYMZ+TN68xemCaUz49OM20TVHMjgefex3dMWVBjPBlVN6jtl3jvR0NcvrJt3RdIJNP/r20RLcg20Rhm5CcqNEBiD+N4F4/ZCGQ==;31:byXpAQ+NwzD1Hu/iIinN29XIaOffZqnbcqZR5ECCg+lUlzYmHp0tWN7Nj9/8fsEnz73Z0/8/1kev4XOFr/kipp10LPKIHb9PdemT+RCxfVbZfgEgXEJrPfXlXHIcsVqZE2H6QpuajQw6BXBQfaVeMIJXsDzRhm6jYtOXwLh9kMn4heF8tu2SoMwz+SUBTZldeiyzjXzgGvhE6VsgxRxOFnVOWmqlUX/Op+455XxZNWM=
X-MS-TrafficTypeDiagnostic: SN1PR07MB3966:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;20:WLe2e/tSHbS/+WUGIqi79+n5g5k9xj9cf9ZEEoX30AMVUdsY+7K5BD4FZ3FHlPquyz9Jz2k7Eqsceux8xKfa1oM4OYdsgB/FkrWwCyRtY2bVqHzuPI5f4cPb6MKyDQl6xVJTdTE/EmFnj9OcoMvW21uyMhH6ZYvwF5fQnRY81GTyu9X0+9suOS2G6SwseDrqVhG+7K9/0fhzQjr6BXOtPMOfvfb8HVFfBtfFsA8tMUQOYVhgjxvany9IZpJnTdOBjfRaUkSVrUZYGyISh9gCkJtoi+lyEGN9K+5ow/mftGddYPrGhvKI6nWe2Q6zx1uTZkYXQnQrrekFQRckUMGlvi/l4q3atGUa2nBuHhxbE09p+LVwMOEGuPpU13i8NRmzwg6eU8+2mR8hiHxLWW0KDsiPiyHQnUe6OqhT3ScuGs+qmiK90v0aPLBZ1yIFthie+2NOfVLeQOoCK4Xx3P0sN5iWL1XCWeJ3yjE9X4hfaDvZMk57YDASKfe0f8wM/5Hn;4:L6osrGjVI9x01QOKbjQ7AY62gXH2033tEjFpbYyI2kIE4efAYVdSVULIWyN2Wz8lrMo9ji1Rd00Or2lWhKLbVNekuz4btav9M4M8XwZxK9iyNtCj2WBO90nyFBFjRIUinQnUcVe45fU4LT/VKEJPvf0ZsSCd1RoOc/dzUI68/G4irvUfoCiQ17v4+vK3cEZe1ex4cl2Gu5cU5UEM19eZ5YL10TiMV6AhWdedku3IL6PvIqXTAhX3n0VPlkQa9EIqe4TtggGv8TCebzN7fRJzug==
X-Microsoft-Antispam-PRVS: <SN1PR07MB396667DB74D8FBC09F08AC3680660@SN1PR07MB3966.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB3966;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB3966;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(316002)(11346002)(8936002)(956004)(16526019)(53936002)(478600001)(476003)(50226002)(2616005)(446003)(54906003)(53416004)(186003)(386003)(25786009)(72206003)(3846002)(6506007)(26005)(6116002)(5660300001)(66066001)(305945005)(48376002)(6916009)(7736002)(59450400001)(50466002)(486006)(6666003)(47776003)(97736004)(52116002)(5890100001)(2351001)(6512007)(105586002)(575784001)(86362001)(2906002)(8676002)(106356001)(69596002)(76176011)(81166006)(81156014)(2361001)(6486002)(36756003)(4326008)(51416003)(68736007)(16586007)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB3966;H:black.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB3966;23:eoYfRFuY/31OkBqlkyjbDy5aceOXEyVCJu8kypozT?=
 =?us-ascii?Q?uFWazUsnH1JwLqVXGLpew2+Y0pEKNfkb+D7wFiY6tM1KScNoQKkBJJztJuCO?=
 =?us-ascii?Q?sbpdH6/evBpqEEPHP0KiQcTxMP/0cdkFIhwGNha91pUTi9PI/xyWCYS85dz/?=
 =?us-ascii?Q?VzJWJhWKrN1znHwwysmydUgpZPabrhO8PS7ndnDv4Fe9TxxcO1cIMN7vXQTg?=
 =?us-ascii?Q?s5flOrKdalwr5mTrXlIpmmKszD6lWBtP4pjy3nAaE4NzNcPpgSI/8Y0xE78V?=
 =?us-ascii?Q?ou1ireIVb4ANu9fNdya+qR+/sETenMmdO0MTnI+Fe7fOk8SzlkCfWwde4pHw?=
 =?us-ascii?Q?vGXXeSS7n0VfrgAZS4d6WpqEsD1VoxxhFwWf6Fl3AeGC3Il/ocIIFcg/R9Ei?=
 =?us-ascii?Q?tWjvLER8TgeCzkDnV2nKTMhBHhRdc07FAc++gmXDRn8w93QQ4kBlluGai66O?=
 =?us-ascii?Q?5yjHDkn3nZAMW76G3nK2+GoiR6iMmgiAdCIHhsY9gCSRgYHa2vi1kcgQxcm/?=
 =?us-ascii?Q?eQ24+kjOhG4T/91ilB9aBOETcM4cDWvgh2W1J+TY2JXyAK0s5cjdI7N5tTfD?=
 =?us-ascii?Q?BRwpU/puVv09J/Zu0OwoQeoi+CgFzQe+v6jNA8YPgHclyilQdjeFfPTeRt1n?=
 =?us-ascii?Q?oMRNFTn3XSzO3SrDpI/8b7ti+BAEXYAv51SVzZR0I/nKCl8tQcZtHYwzj+h8?=
 =?us-ascii?Q?r1hg8BtsVwHCU8Dxefi8lxyojvOWxWqq75PWGZ+/8DAGOPuD/3jMzRyG7evR?=
 =?us-ascii?Q?yaopfq+FNzAAVXA0cT/PfQRtmNoZ6HI81gf1RuMIu57TkhiSDHnseRQEXFXe?=
 =?us-ascii?Q?belpJLzmF3bLQWr9DMkhLjZ5n5SKjG6u+94nvyE6TN0WN/OsDOqZHcbWEP2F?=
 =?us-ascii?Q?04rtOvy89eg0DkRDD+QrotyOA0FbJhGQh7dEpD+ZyfnsL5xhRtUnC57Y26ho?=
 =?us-ascii?Q?dlvfEw9K2i7GC5Z0h6gu1+sFeTuH66dBE05HV+u/I9eDmN3kQp/ohBHED6M/?=
 =?us-ascii?Q?+7UCDLWbTieenSvkFTE1tEB14JUUNclX8LI376xiiv0Hh1gkvkPwDKtvUW7T?=
 =?us-ascii?Q?u/gwRrXdNvjLrNlzStG65gpMNEWTkvtrCUTC/J3vctxLd/wZqf+riMPa2em1?=
 =?us-ascii?Q?7WI6fuFLE2JvNQpuCOwq+U+dPVJGes1LMW8N//RcQV8d40AI0l6nAXWcQjS2?=
 =?us-ascii?Q?NCjb7F7V0SL08X28Z5mDLchEke2yTfODw0d0qZR9h3+at1lwjzbkKQPz3k/4?=
 =?us-ascii?Q?ewQTG7awBmM7oDeWBP/dzv77Kavr06FEh4H0u8C1iQDC+M/54a7fXP1/GC4H?=
 =?us-ascii?Q?XXBy/LWDZ5oCOBDVGQtxhPnDQL4dF8MtSYIPwkqyPxqb6Pm56cfidwEbLd8x?=
 =?us-ascii?Q?xwR7OEIKpsuLjRZ3DquNNnu8dMzWCEtZRtvysHt1L8xqmhP?=
X-Microsoft-Antispam-Message-Info: xkue1xz4p91QKkU7S+fITLYb4fzrvXbHhYEZEMwrHfKV/Fxj+D8SFKj+EKUk1zPBd5X1iD9jFeAYdfhm17SL7jxdvIyULlLDbH1yufHzuqOLczcLQ/fW26fvjyOLUi8p3pURXvfyrAUNlGsbAVokewT80pEoT+79TS4gLsfJ+UMz7ufOk0cX+Anbi0dwaK4S
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;6:6GZFiO2QCHpJkjOwbhZ7/MK7h5xgtiVQPDu8dvub3hl/mDJEYK/+hqV/Qvt44BBz2xetJlP+jbzutdOqlYvtGEyKmJ4yCjZFzRgm3VJURy2rBj4UF/+p78DeVX6sdle98n2/oD5sK+BIx8k/dREEWDoT8j/hVbaNZh9KT7B5D2+OrwLRyy9sOn1cPJle9zvBFcSmJ2zYhZgydvGkGrvGdHr7NoRf3GAXNNbs8acc6kZCT5/2Xl41IG1ijLfG+2dZa47UlLiCSffknBS7uWpO52IU0biP6WWqL+2utpCplBxwD3d76T012uUqdEy8OvxHJ2aZaOo79jgSiHT0p245OiNw8mfPzg0JunkTgymlkKq/cRgDcscNlZeX7BjQGqa+0orzgNGb4833j9ge7hsAwe9O4jzJ6Eh1F4ohH2EWqLgIFS4VamS/EoSWVjG4H3MrbhjmmIkIZjC6ODsaJj/Kow==;5:FoQR2nOKus6yal0WubjTJtiBJ50VZ01klzJXX9lyJude6yBt/8uDyf4KRR6I9Tdm1v9V7oYfJiUj6wB7uO2hHJ2w6yWzemLU/hZik3VifrRNdIE8R39Fd99E06X6SJsEtlxpp6LF/myUwB6r4bDzYlf2em1nuxYJ3JFw0NhHjCE=;24:8mMOH+xo7bynAsGSG/XvUPJYpi8OXZ1XiI2gWi+eHbMPumkMYf4gORIoE8mt+l19atCJjmHSj+Cq8GqwkYb8h5MaO5h2aATFahDtXODYHeI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB3966;7:zNZdUY5xwNMuQAMjQCgYDOFgaZpME5FWZyo39TuNJEJMjxLnx/oNBDdgYPunmBapWusnvJzidGG3o9qoot37Di+vQG1Ycj1ru52fJhqQSMLz47mXNQI2acBuyCPDr6sTp943DSnc5iH+5mAR48t20dMRVIkvsHEkDfgja33f1CgJOUo2XYL356iEQt+Qx0xImJGaVZ6eNqO4b+a4UXa15gbXOBMV2HD7sbCLt+AnSjrfSVmcV6ON30lTYZ1Sagze
X-MS-Office365-Filtering-Correlation-Id: a5f09b83-f8fc-44be-44c2-08d5caa81815
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 05:49:23.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f09b83-f8fc-44be-44c2-08d5caa81815
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3966
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64188
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
 arch/mips/cavium-octeon/octeon_boot.h              |  97 ---------
 arch/mips/cavium-octeon/setup.c                    |   2 +-
 arch/mips/cavium-octeon/smp.c                      | 235 +++++++--------------
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  56 ++++-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/asm/octeon/cvmx-coremask.h       |  28 ++-
 arch/mips/include/asm/octeon/cvmx.h                |  59 +++---
 arch/mips/include/asm/octeon/octeon.h              |   2 +
 9 files changed, 193 insertions(+), 289 deletions(-)
 delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95d..5926dfa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -897,7 +897,7 @@ config CAVIUM_OCTEON_SOC
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
index 46ca705..0000000
--- a/arch/mips/cavium-octeon/octeon_boot.h
+++ /dev/null
@@ -1,97 +0,0 @@
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
-/*
- * If not to copy a lot of bootloader's structures
- * here is only offset of requested member.
- */
-#define AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK	 0x765c
-
-/* hardcoded in bootloader */
-#define	 LABI_ADDR_IN_BOOTLOADER			 0x700
-
-#define LINUX_APP_BOOT_BLOCK_NAME "linux-app-boot"
-
-#define LABI_SIGNATURE 0xAABBCC01
-
-/* from uboot-headers/octeon_mem_map.h */
-#define EXCEPTION_BASE_INCR	(4 * 1024)
-/* Increment size for exception base addresses (4k minimum) */
-#define EXCEPTION_BASE_BASE	0
-#define BOOTLOADER_PRIV_DATA_BASE	(EXCEPTION_BASE_BASE + 0x800)
-#define BOOTLOADER_BOOT_VECTOR		(BOOTLOADER_PRIV_DATA_BASE)
-
-#endif /* __OCTEON_BOOT_H__ */
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index eb9396b..18089b5 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -788,7 +788,7 @@ void __init prom_init(void)
 	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
 	    OCTEON_IS_MODEL(OCTEON_CN31XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
-	else
+	else if (!OCTEON_IS_MODEL(OCTEON_CN78XX))
 		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
 
 	/* Default to 64MB in the simulator to speed things up */
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 8e6c484..d0d5daf 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -3,41 +3,39 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008, 2009, 2010 Cavium Networks
+ * Copyright (C) 2004-2018 Cavium, Inc.
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
+unsigned long octeon_processor_boot = ~0ul;
+unsigned long octeon_processor_sp;
+unsigned long octeon_processor_gp;
 #ifdef CONFIG_RELOCATABLE
-volatile unsigned long octeon_processor_relocated_kernel_entry;
+unsigned long octeon_processor_relocated_kernel_entry;
 #endif /* CONFIG_RELOCATABLE */
 
-#ifdef CONFIG_HOTPLUG_CPU
-uint64_t octeon_bootloader_entry_addr;
-EXPORT_SYMBOL(octeon_bootloader_entry_addr);
-#endif
+static struct cvmx_boot_vector_element *octeon_bootvector;
+static void *octeon_hotplug_entry_raw;
 
-extern void kernel_entry(unsigned long arg1, ...);
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state);
 
 static void octeon_icache_flush(void)
 {
@@ -106,48 +104,25 @@ void octeon_send_ipi_single(int cpu, unsigned int action)
 static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 					unsigned int action)
 {
-	unsigned int i;
+	int cpu;
 
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
-	labi = (struct linux_app_boot_info *)
-			PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-	if (labi->labi_signature != LABI_SIGNATURE) {
-		pr_info("Bootloader does not support HOTPLUG_CPU.");
-		return;
-	}
-
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
+	unsigned long t;
 #ifdef CONFIG_HOTPLUG_CPU
-	int core_mask = octeon_get_boot_coremask();
 	unsigned int num_cores = cvmx_octeon_num_cores();
 #endif
+	struct cvmx_sysinfo *sysinfo = cvmx_sysinfo_get();
 
 	/* The present CPUs are initially just the boot cpu (CPU 0). */
-	for (id = 0; id < NR_CPUS; id++) {
+	for (id = 0; id < num_possible_cpus(); id++) {
 		set_cpu_possible(id, id == 0);
 		set_cpu_present(id, id == 0);
 	}
@@ -168,15 +143,22 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 
+	octeon_bootvector = cvmx_boot_vector_get();
+	if (!octeon_bootvector) {
+		pr_err("Error: Cannot allocate boot vector.\n");
+		return;
+	}
+	t = __pa_symbol(octeon_hotplug_entry);
+	octeon_hotplug_entry_raw = phys_to_virt(t);
+
 #ifdef CONFIG_HOTPLUG_CPU
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
@@ -184,8 +166,6 @@ static void __init octeon_smp_setup(void)
 		}
 	}
 #endif
-
-	octeon_smp_hotplug_setup();
 }
 
 
@@ -207,27 +187,35 @@ int plat_post_relocation(long offset)
  */
 static int octeon_boot_secondary(int cpu, struct task_struct *idle)
 {
-	int count;
+	int node;
+	int coreid = cpu_logical_map(cpu);
 
-	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
-		cpu_logical_map(cpu));
+	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu, coreid);
+
+	octeon_bootvector[coreid].target_ptr = (uint64_t)octeon_hotplug_entry_raw;
+	mb();
+	/* Convert coreid to node,core spair and send NMI to target core */
+	node = cvmx_coremask_core_to_node(coreid);
+	coreid = cvmx_coremask_core_on_node(coreid);
+	if (octeon_has_feature(OCTEON_FEATURE_CIU3))
+		cvmx_write_csr_node(node, CVMX_CIU3_NMI, (1ull << coreid));
+	else
+		cvmx_write_csr(CVMX_CIU_NMI, (1 << coreid));
 
 	octeon_processor_sp = __KSTK_TOS(idle);
 	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
-	octeon_processor_boot = cpu_logical_map(cpu);
-	mb();	/* */
 
-	count = 10000;
-	while (octeon_processor_sp && count) {
-		/* Waiting for processor to get the SP and GP */
+	/* This barrier is needed to guarantee the following is done last */
+	mb();
+
+	/* Indicate which core is being brought up out of pan */
+	octeon_processor_boot = coreid;
+
+	/* Waiting for processor to get the SP and GP */
+	while (octeon_processor_sp)
 		udelay(1);
-		count--;
-	}
-	if (count == 0) {
-		pr_err("Secondary boot timeout\n");
-		return -ETIMEDOUT;
-	}
 
+	octeon_processor_boot = ~0ul;
 	return 0;
 }
 
@@ -255,11 +243,24 @@ static void octeon_init_secondary(void)
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
@@ -274,6 +275,8 @@ static void __init octeon_prepare_cpus(unsigned int max_cpus)
 static void octeon_smp_finish(void)
 {
 	octeon_user_io_init();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
+	mb();
 
 	/* to generate the first CPU timer interrupt */
 	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
@@ -282,9 +285,6 @@ static void octeon_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* State of each CPU. */
-DEFINE_PER_CPU(int, cpu_state);
-
 static int octeon_cpu_disable(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -292,9 +292,6 @@ static int octeon_cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;
 
-	if (!octeon_bootloader_entry_addr)
-		return -ENOTSUPP;
-
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	octeon_fixup_irqs();
@@ -307,109 +304,21 @@ static int octeon_cpu_disable(void)
 
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
-		labi = (struct linux_app_boot_info *)
-			PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-
-		labi->avail_coremask |= mask;
-		new_mask = labi->avail_coremask;
-	} else {		       /* alternative, already initialized */
-		uint32_t *p =
-			(uint32_t *)PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
-			AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-		*p |= mask;
-		new_mask = *p;
-	}
-
-	pr_info("Reset core %d. Available Coremask = 0x%x\n", coreid, new_mask);
-	mb();	/* */
-	cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-	cvmx_write_csr(CVMX_CIU_PP_RST, 0);
 }
 
 void play_dead(void)
 {
-	int cpu = cpu_number_map(cvmx_get_core_num());
+	int cpu = smp_processor_id();
 
 	idle_task_exit();
-	octeon_processor_boot = 0xff;
 	per_cpu(cpu_state, cpu) = CPU_DEAD;
-	mb();	/* */
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
-	struct boot_init_vector *boot_vect = (struct boot_init_vector *)
-		PHYS_TO_XKSEG_CACHED(BOOTLOADER_BOOT_VECTOR);
-
-	block_desc = cvmx_bootmem_find_named_block(LINUX_APP_BOOT_BLOCK_NAME);
-
-	if (!block_desc) {
-		struct linux_app_boot_info *labi;
-
-		labi = (struct linux_app_boot_info *)
-			PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
-		avail_coremask = labi->avail_coremask;
-		labi->avail_coremask &= ~(1 << coreid);
-	} else {		       /* alternative, already initialized */
-		avail_coremask = *(uint32_t *)
-			PHYS_TO_XKSEG_CACHED(block_desc->base_addr +
-			AVAIL_COREMASK_OFFSET_IN_LINUX_APP_BOOT_BLOCK);
-	}
-
-	if (!(avail_coremask & (1 << coreid))) {
-		/* core not available, assume caught by simple-executive */
-		cvmx_write_csr(CVMX_CIU_PP_RST, 1 << coreid);
-		cvmx_write_csr(CVMX_CIU_PP_RST, 0);
-	}
-
-	boot_vect[coreid].app_start_func_addr =
-		(uint32_t) (unsigned long) start_after_reset;
-	boot_vect[coreid].code_addr = octeon_bootloader_entry_addr;
-
-	mb();	/* */
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
+	mb();
+	local_irq_disable();
+	while (1)
+		__asm__ __volatile__("wait\n");
 }
-late_initcall(register_cavium_notifier);
 
 #endif	/* CONFIG_HOTPLUG_CPU */
 
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
index c38b38c..0890d41 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2005-2008 Cavium Networks, Inc
+ * Copyright (C) 2005-2018 Cavium, Inc.
  */
 #ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
 #define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
@@ -26,6 +26,60 @@
 	# a3 = address of boot descriptor block
 	.set push
 	.set arch=octeon
+	b	7f
+FEXPORT(octeon_hotplug_entry)
+	move	a0, zero
+	move	a1, zero
+	move	a2, zero
+	move	a3, zero
+7:
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
index f658597..c87b72a 100644
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
index 097dc09..4b6ba58 100644
--- a/arch/mips/include/asm/octeon/cvmx-coremask.h
+++ b/arch/mips/include/asm/octeon/cvmx-coremask.h
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2016  Cavium Inc. (support@cavium.com).
+ * Copyright (C) 2016-2018 Cavium, Inc.
  *
  */
 
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
index 953860d..666b1b9 100644
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
 #include <asm/octeon/cvmx-packet.h>
 #include <asm/octeon/cvmx-sysinfo.h>
@@ -83,7 +94,6 @@ enum cvmx_mips_space {
 #define cvmx_dprintf(...)   {}
 #endif
 
-#define CVMX_MAX_CORES		(16)
 #define CVMX_CACHE_LINE_SIZE	(128)	/* In bytes */
 #define CVMX_CACHE_LINE_MASK	(CVMX_CACHE_LINE_SIZE - 1)	/* In bytes */
 #define CVMX_CACHE_LINE_ALIGNED __aligned(CVMX_CACHE_LINE_SIZE)
@@ -347,9 +357,6 @@ static inline unsigned int cvmx_get_core_num(void)
 	return core_num;
 }
 
-/* Maximum # of bits to define core in node */
-#define CVMX_NODE_NO_SHIFT	7
-#define CVMX_NODE_MASK		0x3
 static inline unsigned int cvmx_get_node_num(void)
 {
 	unsigned int core_num = cvmx_get_core_num();
@@ -459,30 +466,34 @@ static inline uint64_t cvmx_get_cycle_global(void)
  * 2) Check if ("type".s."field" "op" "value")
  * 3) If #2 isn't true loop to #1 unless too much time has passed.
  */
-#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec)  \
-({									      \
-	int result;							      \
-	do {								      \
-		uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec *   \
-			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	      \
-		type c;							      \
-		while (1) {						      \
-			c.u64 = cvmx_read_csr(address);			      \
-			if ((c.s.field) op(value)) {			      \
-				result = 0;				      \
-				break;					      \
-			} else if (cvmx_get_cycle() > done) {		      \
-				result = -1;				      \
-				break;					      \
-			} else						      \
-				__delay(100);				      \
-		}							      \
-	} while (0);							      \
-	result;								      \
+#define CVMX_WAIT_FOR_FIELD64_NODE(node, address, type, field, op, value, timeout_usec) \
+    (									\
+{									\
+	int result;							\
+	do {								\
+		uint64_t done = cvmx_get_cycle() + (uint64_t)timeout_usec * \
+			cvmx_sysinfo_get()->cpu_clock_hz / 1000000;	\
+		type c;							\
+		while (1) {						\
+			c.u64 = cvmx_read_csr_node(node, address);	\
+			if ((c.s.field) op(value)) {			\
+				result = 0;				\
+				break;					\
+			} else if (cvmx_get_cycle() > done) {		\
+				result = -1;				\
+				break;					\
+			} else						\
+				__delay(100);				\
+		}							\
+	} while (0);							\
+	result;								\
 })
 
 /***************************************************************************/
 
+#define CVMX_WAIT_FOR_FIELD64(address, type, field, op, value, timeout_usec) \
+	CVMX_WAIT_FOR_FIELD64_NODE(0, address, type, field, op, value, timeout_usec)
+
 /* Return the number of cores available in the chip */
 static inline uint32_t cvmx_octeon_num_cores(void)
 {
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index e9ed14b..5b10455 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -390,6 +390,8 @@ extern uint64_t octeon_bootloader_entry_addr;
 
 extern void (*octeon_irq_setup_secondary)(void);
 
+extern asmlinkage void octeon_hotplug_entry(void);
+
 typedef void (*octeon_irq_ip4_handler_t)(void);
 
 void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t h);
-- 
2.1.4
