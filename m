Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 22:41:11 +0200 (CEST)
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:7166
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994629AbeDMUknBLJH3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Apr 2018 22:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wuiTxa/CG4x0LHsN7zd6sDFP29SIxxEOSUBYmV5jyBY=;
 b=MIEgNLNSh0KfaiwMXdh/NvSXLq+88UwSuzKGpfspmL+63+u2UljyTgHyOai/vWJ9mvb4+3ccrug/bskkAkZzb/o3LdudY6u6IPcEsXwKEx6zT5S1i4tEveg9N0dMNA2SHE5WAKedV6aXoMVMQnMTsS+CwpZyqeJ0b1IMI/di23o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3612.namprd07.prod.outlook.com (2603:10b6:4:68::34) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.653.12; Fri, 13
 Apr 2018 20:40:30 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH 3/4] MIPS: Octeon: Properly use sysinfo header file.
Date:   Fri, 13 Apr 2018 15:20:19 -0500
Message-Id: <1523650820-18134-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
References: <1523650820-18134-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To DM5PR07MB3612.namprd07.prod.outlook.com
 (2603:10b6:4:68::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3612;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;3:mOtQ7d5AHB4XPXqqfbpfNAp+iIvFvJvfF0DXOkateuDE1oXE8pwiS9NgIRkACFqWy6Q8CbP4kkaIYKRBmG8WYLKaJMezNT3X9k+Ek1gwRuGgARgX6Z+w/S14pUvW3x4JIXj4M1qOVkfcfdV91YGkZfNHMdlWCNYVwHCK012fx/KSZ50xph1aVJsxG+5oCQyc2SqVSUDzoNdnvbrVAz0XWE7FHQHZqv2N0LrcEl3+3ZOkA0Qrq25fHIg5UykQTE1J;25:vgTW5Wzjtl6uI9BWVQx21cevp4UHAe7tct1yA0iFKZJN34cJ0vRO8L6l5cJr1/HQOVfj/sfkhEGiNUAzaie/FcwpSDWeGK15KKatQDK7ng4ieGsy4iIqFtofKTu6GrTB6i4towMMek5Oq/XZRaR4iuvpmJL6mbSFdQXvfSE3qTPSqeGaTLimlInUm4LJrcLfh2KtYu3xOLbF+2BMuWsTM6wnGCQ8vZjUDxVY6RtLARyWBOXJq+9taIZmIIhdn4aYHTyJ9RpJ2wQYlUebDWMQ92O+L7Y2E1kPa7dti4xJ1lC57WGUuv8Kjqvm3jvaT6ZdFy7RxjX271JlHWzwZ6DCrw==;31:obaFX5RmIkvvBd8YX1h68vvYjjv2NxmgOVVKaFAi0ZThxHNpR4QLi9XOnl7j2Amh0zTgleJbB5fawW0fACyMTNmIq+glj9SXOHCnXkoOAJGQg5HHWTnJ/PWyTDEhAiXm5xxxUD5XJcvFKniQBmX4heX40gTqjTx25bsDSd8BSNicxWHM0o+LmlCsStK9521/LETDk5UjVCft5uxO4UYFxYt2SrrOI3v+HGpAZerzfuM=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3612:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;20:Td43PDZHOncDz2b9xGKhcPDwHSrOdISEbvUR9ZuP4DCnNBN686w4pTFv4An9XRRDh71sPEWzH3Ud6fo1waKIhP6qhO4w1BR/bKIYWPY3tubeuZHDMatgTMPbx1VtqPQajUpOLSpEV7dRcHW9Wg84bWqoolmPXXA+UjXvnQpiW0mee0ewdnqk5xQaPZYlc+v5qikdi66C1KvhykJ0011VSqSeDtoi/xNM8oRHq+kghvN+EiTVBl1wYsfxisPfJYYcT2rxTYCdEL6K7I0RlyGtOninuBZ+gP8DIwkNEyzlE2o0PnVCbLnSxtAbQeK5nuiZBQlxn/Hm5FgFChyhetpT5dVGZ9bju0B+xJYR9x1uEi62vD8tcTjdX9QCWW5gyWqu3hQi6heaKXSKsEBcXyQ21os9ZaWT8DwAnh1oyg52tHi5FRMzEnQyHbC1x6Zxi2tnPv+M5+393Hl7P7aGkozEuOgUDHDQ3NWSQIOe29EfN9/b6SGaIoRBlu7ReGxVDVkC;4:Kon1tCVtavZH2DWBqr02afQ2noCFGxszI+Fp/AjMF0tCOo5hmX6JCbWrDEEE5Nu7sl0NlOeWnLveeR3MexS+fRPz8iROOaEYBUQWiubxtex+fx+POKJF8q+e0hexUm+YCwRNHgu/HI5y5pha3UHf253vlxzNncCwrdYKLYiTO+D184lX9H0oppWaCZ1BN1Kt0IK+lir/ZVaHuWSDZIjnOBU7vAEfOhKN9UCFVRJ260mMeHfDOx2GMKlZNFdzDEVNb/PFJ7/k6+/PDsG4F/NBkQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB361297D6536B38C8E98C2D7D80B30@DM5PR07MB3612.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3612;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(189003)(199004)(6486002)(486006)(446003)(69596002)(47776003)(16586007)(105586002)(25786009)(6916009)(66066001)(11346002)(956004)(68736007)(2616005)(478600001)(6506007)(59450400001)(48376002)(2906002)(476003)(86362001)(51416003)(2351001)(53416004)(2361001)(5660300001)(81156014)(76176011)(6666003)(386003)(305945005)(6512007)(36756003)(52116002)(8936002)(50226002)(26005)(6116002)(8676002)(72206003)(81166006)(3846002)(186003)(316002)(97736004)(7736002)(50466002)(53936002)(106356001)(16526019)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3612;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3612;23:DG6/Q8GpahI2ukQKgGfSKggbf9tjRtolKP++KQVru?=
 =?us-ascii?Q?Djz15sUOSxyMSfkP7wrcVxRZHr/xtxWyXuypaVH7ykgyWj8FMzZmUKQvePeR?=
 =?us-ascii?Q?UekR121bIEwMeBtbKYXQMjpNP9NKjVoHVUu3LTp/YmsPDmnLRRZLVzYhpeLj?=
 =?us-ascii?Q?HVwXCGCyh5HIMoNEsOYI2DzVhSAu9WKz5Jq6JRM1JS0gH286ufD8Wifs1MDR?=
 =?us-ascii?Q?RlGxytH2ediV+lB3S8V2mpwXtX5m4fdBV64+Ah+E6I4xxrxt2Icswc3BiNlb?=
 =?us-ascii?Q?XipCuB/2mp2mKnWnOM1zr6TmA4wfdn8rE0mvZkHxAYHueSW0CXPGUDoJ4pXC?=
 =?us-ascii?Q?rQKrZ41yLgcIKNyYut4M0NzqTrp7IMMJIw3RBeCid9AWXkOtHIzhD3LH82Ri?=
 =?us-ascii?Q?pDA7ySHvGTMMQPglZdeVd4Zee4jB4dIyQ5tAf/Cees+CBE9JemLneKMoe1aw?=
 =?us-ascii?Q?R2X7OnMkY9jdSixMJcU/C4gTjpRU40I+iZvaWr1zFMMrcG9kBkXjNXX3JEvY?=
 =?us-ascii?Q?sIb0zBBR516pJKK8eQNmKt4WI3hjZqDPMg3Z/Lwhj//82Q294m0EwHG5tr1Q?=
 =?us-ascii?Q?kDo05RG4VgRI/0pOU4HRaU4L9Noaf7OxEpHMnEdooHYzm1jZIhYhCnp7/5sX?=
 =?us-ascii?Q?G39z3aDIofMp7RYALBp8nf2QFIb7uKH6niknMaJoiMnlYMtnxi9iN1jh2Xxs?=
 =?us-ascii?Q?2Lq265VjwnHcqwJR7PakfStodDfEMb64w78KWTaVFiKb5CtH5x/PsjT4iAGF?=
 =?us-ascii?Q?T61LY6zJ2BLrrMvmnlwJX54mggYfcATIm/Dzj3Y3IsCD6+REcpCJ4W7a/Xff?=
 =?us-ascii?Q?zKHGlqeOlxGn1zEUGcQkLr7g/7aKZ+jxvNifNxmZM8Lu5kHSFQHh6CZBMW/K?=
 =?us-ascii?Q?/BJZkLYCg16toeuBWDOi7ZC/KHnPIZgp/4/QY26QCdFi2yTe5Vyq6EEG7FkD?=
 =?us-ascii?Q?YF0FAcS2fJAWfJ5H+a6cal2yIukYJPfGjSIHWGCl5s0bQ4QPyCJZr/SxhLoQ?=
 =?us-ascii?Q?7bab7cueT9+M+DhRbJhv+bz+vWqXWwLL6iJzOfTfxRLH68hm508rBTlIWfhp?=
 =?us-ascii?Q?YrqAnmXgLC+o52ReARDyR/i88n41SIzLoCmjDuKLl/4xE7g3BzLqruTUDHfk?=
 =?us-ascii?Q?7IqTA6EUYnInJd0ccwB2CBG1EF/5AwP08oQadhw/xRY2e8FNr2x6VITrbRL/?=
 =?us-ascii?Q?pOKKRYK60k0Ln0+Tq+TWIHhwAs+gh7E1LCgTP/LA9W5wFWCoR/YSkjfTxiPl?=
 =?us-ascii?Q?oNdLYcceyRD18OE2VYth6yLPNYCCjBAlQdWAADcDnFdqhQ9UEqeN7aQFK0y2?=
 =?us-ascii?Q?WqVLZurge6my6rnK0aSfF8=3D?=
X-Microsoft-Antispam-Message-Info: 3Jq23kDyloQZ/a4/rxDGmnfMmiKlfIW3ShkKD7KkHEeSV01SUQd2bYNUs6hqHvK3OxLa4ofzoz2RkkmjfGgWKRvwa0N9bJOLsp1QUs9cgfzKumHPgFP+qW7VzgptVi6iW9CUD8M+1DpnhNzWWlcZCvkf6QP5dxBWSnKqR7o3LGKMpn1tLvqO7U+4+ZE2SrEf
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;6:YMXaOr50T71AFOfBwMN+ODErkYKUKl+1OBi1YY2a2ImrfNMcOM5AXYLgHHftqkjTWnvnAqmvqz3Muyc5fFMcWmLzOlHU4ysSkHCOo9DKvtQEeHOHf9eG5ylOi2Dl2ICqIe7Nou7G2YZ5xAoTiZFkBmi+UBhqL4OPEssVqHlOYmZ+crJwh5DS938OOFBtJL5xdR1YqOaAhwr+trKEKZZSlkybzmoMoAlaGwrmybosKMd6fBuC+DTsrNkdVExxXkZLDiIfwFt/B+/ddPmVT3hpMzCH5yj/G5nBSnSP6N8ZXQH9hpJ63drHem9l2oxfh9cj12v/ylJnbABIlWHvt9vjh157yhYTXPT2rRGtjoRT4Ra/l1Hnm7QWqn62JSQ5Uxvo2bsEw7Xb0FtqWT0m/fjdfPvGqPoWC8/xTi/ozczs5L/9USnUgpa6DdzeWlpP+BR+9F/S4yjyehuyy7TUj58ckQ==;5:hL0q1U57VtBJd534/ty5jdJvcGZROeNkVDnYcDWmF2A452bY+1A3XUV4plSCPtPVgG37ydDzflKyu0QDRPsw1HgE3sB1Wc9qYh1Fyp38Rx23Gvj4mtzwuoGnkfZKcr3HeOnVWTmQYK49U8JNyYCx/pJdmVOybEBxKjAirq9retA=;24:T4YOkYzVgDoR98nUQOAp8hWn+YI1W14zTTLbxSI8WbRh3gZRiffqUpUZeKEDmxGgmkZNOvlSU3ZY2lTdEXydVzOqE0khdL7n4dnWeL+KzbI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3612;7:/dhmo4Ez/d5SG1cXP2TRPwMCIMmXJIJXnRU8kwibYjMELipHR19BivjpvJPwLVKtXZOVDB5Ed+Cue1s5qvwl/SgZJeqB3wSE7aVAH4ipsNeje95KrYA61/adjLS4Dn5RPC3zTLzNjKnAo4D4oTupp/KAZpIYuYH36s7ANZ15FZoKwF+5qvTN0FwrlEDbAA/Sp+eAkb+H5Icek9E95ZVhDES5fJrlv9vGeGYiSzkA1iU9hYEFcAQLlzDHlI5nTqtx
X-MS-Office365-Filtering-Correlation-Id: 7710db1c-4e61-48eb-2ca9-08d5a17eccfe
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 20:40:30.7453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7710db1c-4e61-48eb-2ca9-08d5a17eccfe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3612
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63529
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

Clean up usage of 'cvmx-sysinfo.h' header file. Also sort the
inclusing of header files and update copyrights.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c |  9 ++++-----
 arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c  |  3 ++-
 arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c |  8 ++++----
 arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c |  4 ++--
 arch/mips/cavium-octeon/executive/cvmx-helper-spi.c   |  7 ++++---
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  |  6 +++---
 arch/mips/cavium-octeon/executive/cvmx-helper.c       | 13 +++++++------
 arch/mips/cavium-octeon/executive/cvmx-pko.c          |  7 ++++---
 arch/mips/cavium-octeon/executive/cvmx-spi.c          |  6 +++---
 arch/mips/cavium-octeon/octeon-platform.c             |  3 ++-
 arch/mips/cavium-octeon/setup.c                       |  5 +++--
 arch/mips/cavium-octeon/smp.c                         |  1 +
 arch/mips/include/asm/octeon/cvmx-ipd.h               |  1 +
 arch/mips/include/asm/octeon/cvmx-sysinfo.h           |  4 ++--
 14 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ab8362e..b6281e0 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,16 +32,15 @@
  */
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-bootinfo.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-util.h>
 #include <asm/octeon/cvmx-helper-board.h>
+#include <asm/octeon/cvmx-helper-util.h>
 
-#include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
 
 /**
  * Return the MII PHY address associated with the given IPD
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
index 607b4e6..54237d4 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-jtag.c
@@ -5,7 +5,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -33,6 +33,7 @@
  */
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 #include <asm/octeon/cvmx-helper-jtag.h>
 
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index af180d8..3980570 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,17 +30,17 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-#include <asm/octeon/cvmx-npi-defs.h>
-#include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-dbg-defs.h>
+#include <asm/octeon/cvmx-gmxx-defs.h>
+#include <asm/octeon/cvmx-npi-defs.h>
 
 /**
  * Probe RGMII ports and determine the number present
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 3506024..aeca94e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -31,8 +31,8 @@
  */
 
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index b8e4efd..8e027e6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,10 +30,11 @@
  * and monitoring.
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-spi.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+
 #include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-spi.h>
 
 #include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-pko-defs.h>
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index d85371e..f694f75 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,15 +32,15 @@
  */
 
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-helper.h>
 
-#include <asm/octeon/cvmx-pko-defs.h>
 #include <asm/octeon/cvmx-gmxx-defs.h>
 #include <asm/octeon/cvmx-pcsx-defs.h>
 #include <asm/octeon/cvmx-pcsxx-defs.h>
+#include <asm/octeon/cvmx-pko-defs.h>
 
 int __cvmx_helper_xaui_enumerate(int interface)
 {
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 75108ec..35c99db 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -31,20 +31,21 @@
  *
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-board.h>
 
 #include <asm/octeon/cvmx-fpa.h>
+#include <asm/octeon/cvmx-ipd.h>
 #include <asm/octeon/cvmx-pip.h>
 #include <asm/octeon/cvmx-pko.h>
-#include <asm/octeon/cvmx-ipd.h>
 #include <asm/octeon/cvmx-spi.h>
-#include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-board.h>
 
+#include <asm/octeon/cvmx-asxx-defs.h>
 #include <asm/octeon/cvmx-pip-defs.h>
 #include <asm/octeon/cvmx-smix-defs.h>
-#include <asm/octeon/cvmx-asxx-defs.h>
 
 /**
  * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index 676fab5..2312f2c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,10 +30,11 @@
  */
 
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
-#include <asm/octeon/cvmx-pko.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+
 #include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-pko.h>
 
 /**
  * Internal state of packet output
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index f51957a..6582d34 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2008 Cavium Networks
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -30,15 +30,15 @@
  * Support library for the SPI
  */
 #include <asm/octeon/octeon.h>
-
 #include <asm/octeon/cvmx-config.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-pko.h>
 #include <asm/octeon/cvmx-spi.h>
 
 #include <asm/octeon/cvmx-spxx-defs.h>
-#include <asm/octeon/cvmx-stxx-defs.h>
 #include <asm/octeon/cvmx-srxx-defs.h>
+#include <asm/octeon/cvmx-stxx-defs.h>
 
 #define INVOKE_CB(function_p, args...)		\
 	do {					\
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 8505db4..1a52f23 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2017 Cavium, Inc.
+ * Copyright (C) 2004-2018 Cavium, Inc.
  * Copyright (C) 2008 Wind River Systems
  */
 
@@ -13,6 +13,7 @@
 #include <linux/libfdt.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
 #ifdef CONFIG_USB
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 3ef1d47..09696cf 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2007 Cavium Networks
+ * Copyright (C) 2004-2018 Cavium, Inc.
  * Copyright (C) 2008, 2009 Wind River Systems
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
@@ -39,8 +39,9 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/pci-octeon.h>
 #include <asm/octeon/cvmx-rst-defs.h>
+#include <asm/octeon/cvmx-sysinfo.h>
+#include <asm/octeon/pci-octeon.h>
 
 /*
  * TRUE for devices having registers with little-endian byte
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 75e7c86..f08f175 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -21,6 +21,7 @@
 #include <asm/setup.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-sysinfo.h>
 
 #include "octeon_boot.h"
 
diff --git a/arch/mips/include/asm/octeon/cvmx-ipd.h b/arch/mips/include/asm/octeon/cvmx-ipd.h
index cbdc14b..adab7b5 100644
--- a/arch/mips/include/asm/octeon/cvmx-ipd.h
+++ b/arch/mips/include/asm/octeon/cvmx-ipd.h
@@ -36,6 +36,7 @@
 #include <asm/octeon/octeon-feature.h>
 
 #include <asm/octeon/cvmx-ipd-defs.h>
+#include <asm/octeon/cvmx-pip-defs.h>
 
 enum cvmx_ipd_mode {
    CVMX_IPD_OPC_MODE_STT = 0LL,	  /* All blocks DRAM, not cached in L2 */
diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
index c6c3ee3..fd3a1bf 100644
--- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2016 Cavium, Inc.
+ * Copyright (c) 2003-2018 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -32,7 +32,7 @@
 #ifndef __CVMX_SYSINFO_H__
 #define __CVMX_SYSINFO_H__
 
-#include "cvmx-coremask.h"
+#include<asm/octeon/cvmx-bootinfo.h>
 
 #define OCTEON_SERIAL_LEN 20
 /**
-- 
2.1.4
