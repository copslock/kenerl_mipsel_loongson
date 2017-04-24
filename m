Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 20:45:45 +0200 (CEST)
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:64592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993914AbdDXSoaEDELm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Apr 2017 20:44:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bvog8U/rGasGGuAwHs8+D3fixhU+g+v7YfjQx8XijXw=;
 b=Y03KK6TWbaN7Xt6/KNpkxEdbn4JyCqAT7gD7sKazvMbDL4M50xjHZ3CfLDEyIDyiFD32cCE7wMoe9OwiFeqD5KsgENdkqGtfNIeL72ur3ICp9I80wlfHe5a7qddNycxw+VyHgKvKL6DHjFo/ZK856mI0O2kgiYMINvBQRCS4a3I=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (50.82.184.123) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Mon, 24 Apr 2017 18:44:18 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mmc: cavium: Add MMC support for Octeon SOCs.
Date:   Mon, 24 Apr 2017 13:41:57 -0500
Message-Id: <1493059318-767-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: BY2PR07CA044.namprd07.prod.outlook.com (10.141.251.19) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 683e2d51-7b03-4ca2-9962-08d48b41ea8c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:wHQGu0AjTOYWgKulcaG4NlcXGcbG8fk8HcN4EGjK31V1+wrjWkxzeD/qQ2XINPQ6XjEI12TB4fPjogWLnfsXM35NeF2IC6ondDsoX6f4i2spdhk8k/kbsR6sguuulALR25ctSqgb3hZfU+31PuTHHH5bXR2UBdYGchooSGxPAOz0MAXV1zYQny7w13gOD7SiNIf1PEMNkHei6ydJaaK3fxCziIQN9PjazD0Y3Mbs8Tn5oe6wTMdoDrOBVcj+2ahogO6IR7Vxg3PacN//iW8ljurUCwRz2oC8dA85SdDbJT13ZtJ8xI4ghvZq6uJnLbbJdNfjBIZKPE+JTRMkFhwB5A==;25:kMnGNXocMnXSka/rnjPCKEyEkZRLOkvdbrMvFSiNP7SpZoZ1rSnRIFikJZ6AFZtSmu3V+8VuCT3EulmXzj8VWjmKY7fTu5p0NEFYeziIA0Z4WUhQ7lcw1FkTW/PkuqkOH4H5NUfU+ZXDLYcukOa4kxncjJTN54vmsw+SEnx/PGOtAUYSSqMqV7PomD7nNnVkFbayBz9EAEHHykdDp+J6thJnCBEJ9Cac1a9vauJZIyAhZ06BhN3dv054/iq7SiCOBpCMsUqupwJb+Jt50pAzpwGDSH6FCY4n98U7ox3C2VGLzff/j6iA3scVdG3Al6sMT+jVAIreaGH4CXVib8pNX7hOnjG7DWHWnSHEQJd0c/0pcYN7W7HEtPqXT+eunBEcG66V1KOCYkkIdBR4agy/GCHzB3Tdhy3q1hoVJp7jtz+79uXc0KnrAvpIzjqkQmZqhgcgCoRaIZQLRgIQF8Fndw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:mQXnY7MiaaItDvqAGl8gss59bDMYcRTeYMrcu1afewd0TMq3V3xXjBYfFhEugDtR9f2hKiB0OXjzQdfZOKm82QVM2k+w7UHemWO6lka9Bw9UcKrfGeOQnptG+aZqTIH4bPDx3kpIeUT8/dMqWWvs/cWokbcQkwjgpwz4Qs+eTxi0EMVthCdPOlAJjkENu8kEBmWQqF1WBPWdpo2CyjxZNdBZ9FnLAGLmAqcWaFLv5SE=;20:c21lUr1BdTBaiR6xm1lpV8Cq31VI0DlnLGnBE4xYC3xPf5/IsK/xTGiaPvJADoSrR6M2nZS4Y7JYQBy3o1PbRO2X4eehMxreMdpCE7ypFVdip+6MssKNthV3S4fqT7Roz5Fdno5Ykab7sJPaWDQN/dYibuZc2/iWQvLMjyCQuglZP67InqNjUnIwBVlKqA7N5ptKgq/rCZ3HEajSo7P6ryDblQF8Rqh2Zq84NZLWHxNiCbqDiO/OJU4bGx00Lbw+Fj54KwUuzPYye0cSDSEcNUSqP1To4QygrTailNUdfLu7KsqI5PtJnVcT3qWmksSS2MM6ydF4JIULEkiKzCTl2BxwjK333pZAHp6TbVSMGJlxfyRTbdDe1ZIa5vgLfqIoayOCONAFotJYM1/FLD6y2n1xw06cGkAEL7WTLtAxepvvviYHCVHkCWuBhVX5o9ZuDMc+uL2PSOnovbE98iwhn7X9FRBr4gYvaibgtLoQo51ptWewxyrF9DT42Y0SZ/21
X-Microsoft-Antispam-PRVS: <CY4PR07MB32063D66CFA320CA110BCAED801F0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:AHBhzpI5Tbnik78b2Gk69twdxePmWSF0q4Hd7Yf5wJSQvNGuEUlg4/sq0QksKsHEZUL27URXwTS8Cm5YQ9hyTnsbvaE8wnZd32Nbk1LO8PUFNyZtmXCnUKQ7kDjK+Yze9ZYtJFAzAvgak90FC2ee638PVsUhiw+dDaQ03hrgwvmrlLNn9mk30YufmwUBPhcplhLqW+raACbLwz5QMxj/xsiALsEj+3QYIRuiF/aAPA+Ffj1CJ0gY+EMMagAYkgXzmeUPwpOiYRxpmuEG5RgFslJA0O4/ZzCqTrOmaZvWuJVl1MVhe0NfsZII8TLG8+Evy0NeuMrmjlr5Beh/unljnKnMKmIvRvbmCrXATgzVRLMuVArVGsMbwhvp1yz28sYK7jRzWo2+Iy7D/Apye2SBHlu78xXZv2y13TZY1Mi3RF1/IBKC+LWg54QmT4+Yh/ZrSB5Pm7XkFjOnjfBD5mifuuEOdeuTSAqFBa20ElqLznSvOUL8T3AMWQygb6slHO1XtQRK2m3Sq53QAH8VDo9Xdeo5Jocv+8W2KWvmWE/dsHj/hCsqbUmsgDBJ6TauFas5VSmM57mMh/38MLr4eIzr4sg2Z8DD4Mu1RP/Bty6j+zZrcqjNAZYuaLCvNQU/Gqw9PxaY6VGlYNG7pnvggZWI++yYm7PsmSXLzSsa4Lv6CsR23iTpUKTxce1pX+tVWy3H2GyjmfaPQEml5mCDBDcQv0HT/gUZ2JKplzLafNshq+c=
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39410400002)(39450400003)(39840400002)(39400400002)(4326008)(110136004)(6116002)(54906002)(2906002)(50986999)(3846002)(6486002)(6506006)(76176999)(189998001)(53416004)(50466002)(66066001)(47776003)(38730400002)(48376002)(42186005)(25786009)(305945005)(575784001)(5003940100001)(50226002)(7736002)(81166006)(8676002)(5660300001)(6916009)(86362001)(36756003)(53936002)(6512007)(6666003)(33646002)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:MYcZkXvjPLPMIOJPw9QlFiaITuRItIPHqhvXD7wJg?=
 =?us-ascii?Q?iWZ0HFzRIbxostRHqfe2PeEoer4Fdd77qg5lcWyZ+bLv0pK/tMBU986FZHzI?=
 =?us-ascii?Q?X4VooxN2xC2scbWgZAIzJTQFono5fmCvdemy30MOyKZhTqbB9TaVzqNMLhFk?=
 =?us-ascii?Q?jn+IVFwigZ85wNOBLrZh3peNTV+rB2g6CKu66/9YTuNp0aseMrI0CAXY7WMg?=
 =?us-ascii?Q?W7Ic5+Uwn9QUrSgmVPNjjfFewgNV7fQ8Vwbd99Pg9WrHOY30SB9XPRsTlwpZ?=
 =?us-ascii?Q?YAAJhvglByFjmZOzxhgfHIaArQPpyAQrD4TwdPF4eDA/7/7d02s572vsUOPK?=
 =?us-ascii?Q?W3huBqqKgeGwOBD2mMQXpNwsQ5oMqed/b6S1OAEWZ/XfodgnnJo1OEqNDQwj?=
 =?us-ascii?Q?o4DljqoCvWkH74nV2KgMTVfgb8wgrFqEkQwrLFOwTjEgKln3gUOzae9u6hVn?=
 =?us-ascii?Q?ngHjwAfGoeiPkHZ/BuIj0575a3S137xfdF1SXx1BFNi9XRvbOzdd1+S4oJho?=
 =?us-ascii?Q?779DONZQzWB6sEdQmd7DZkIaKXVwaeEWVtqZXwXaCB/ayCHTiLiSVK/bfYF8?=
 =?us-ascii?Q?cEopP6FzD0mstovRIaUKZTrxhJ1hgKEWVgNozf3Md71Zeaun1xYgcjBu90j7?=
 =?us-ascii?Q?DIvkI69dF+7iHnSUtyQoXasm+oQpyaHjysDJikkPzrE3jZJFZIdRX2pyGRIc?=
 =?us-ascii?Q?BuQWQt3MrX3xPKs+w0C3+sPsvZ3WJDUTzLxaufAv2SfdNL75RgvGs/PNGB+I?=
 =?us-ascii?Q?QiY1h8MmlXD4KybW6CfLBeLFjVNuuo910KLfzwxK/p5c4l1gofyWgnb4tT9b?=
 =?us-ascii?Q?LGSWIlBmZoBH282l+wXKH663FEedGgL3+SOi0AuG5GhsfbrGA9qJvb8chFtj?=
 =?us-ascii?Q?xV/MZXb1l6XTXsIjn8J8KxrhUnVfO/sha7N1WVXbTXumfUUv2gwDb+NvuBPc?=
 =?us-ascii?Q?sY3xb1ngg6QMhOXq3AEOcJwnsOSXqAnPlWRoetv+28lMhHeEzOPk/3uHRtbu?=
 =?us-ascii?Q?GOA22wNQQ0Xs+lPn8CNiqhBWOyz37Tvce6ekvFhhuDyDARyJfjlEAlNcexKZ?=
 =?us-ascii?Q?fOWEPnsB6/1+S1H3mseWVyhvc8N?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:ueaIxbeOitHdIuOdF9TRfsSdm6zO8GAHzFxX9fPmpgeG6H5LbXm+K/rTn6UBGH4zpq24Qkfq7QWQAJZACpYg5SyhkVsFSOkQWY39CkQLdYAWdD+s1/oMp6j/eX7rL49+qQz5j/aBMVQpolGU3KfsGzcUFyLUUZf5Q+4zIlyH+axX8hUivYDm8CfAqxZzSSVNlsSabgjuTr+z7K9ASPWUX+rgZ/BHANytse8X8Gh6oIevgfZUgeirFXcSrKiZaupg7OliyQ/J8N0ybSs5SoLPV3lhwvaWaMRgsB8lD7H9Hm+mpE8E1+c8dUXt7DWtPV4KegCZUTq9/FDBNwY62omBW9NMHDVpgjebGO6aEQdQLJQwxCzdylMEv3NjecNAk4fyhP/HvLQ4nu2UiUWTXOdRGHtNLYHP+dkRed0TfAAtn86a67T7hcRybDync23bRdgYLc2917IBvLkwaro0t8GIq5EkTLnRbtfXsFdkFO/Pj7v9wGAWi/P8DXkDAhOQwFkMMdjq2PEBPId0MUhOgGpi6Q==;5:2blTE0VWRKCOlntK0Cbv4ySv0u3ldXdQYKMm9sj6H1XpRE8RpKXimXU/xlAh1MkujqX98oI/caFTjhDHSooyI65cCOdg7LdepuUzQkb+VYUC2vp+3Kx1iNuGJIg+vE/B+vuLSI2z4SsBqouwzng1LwvZrXGrN3iAR2egEeGHurE=;24:y7OaIkHtzO9TL+DS738ocAHWeXajvKpVkikiFcvXWpaMHxurJLQaurJfUnmSt2pmX/yJ8uaKNGZM4xJa6RgSbfYhJWWICqs2bHv6z9glUVE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:OLJFPMwDmiWZO+XxyQd1JPQA/0Q/oCto/WBfLQksS/ZQsUu8KFOOaFJz7xqlmRUShaKoX0UFuznt6p3O3vr35tZ7XRhEXI/faAg0l70I3sJYzOPXe5uY0+xg1Lm09la4S57P//jdcIuDwKVnB95RkBVX9Euf0yC5ZHGmB15bl/qhxvQLMZN1yFlryHa+FtAbRS4neQYPvgUJZpkb2M3DzwxJybZZ45Ts2AjBorb/aHH/zHzP+cB8hkfvAaOWJY39d/AqOkaDthMpjk2M8/DbHtYcgxVKxkDwD9aL8b9lCWoI1E2DkNWtEJhrADa5wcrxtKCibtyuhUG8R9+7MYlbKA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2017 18:44:18.1443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57774
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Add platform driver for Octeon SOCs.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/mmc/host/Kconfig         |  10 ++
 drivers/mmc/host/Makefile        |   2 +
 drivers/mmc/host/cavium-octeon.c | 351 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/mmc/host/cavium-octeon.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c882795..8b9b454 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -622,6 +622,16 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
 	help
 	  If you say yes here SD-Cards may work on the EZkit.
 
+config MMC_CAVIUM_OCTEON
+	tristate "Cavium OCTEON SD/MMC Card Interface support"
+	depends on CAVIUM_OCTEON_SOC
+	help
+	  This selects Cavium OCTEON SD/MMC card Interface.
+	  If you have an OCTEON board with a Multimedia Card slot,
+	  say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_CAVIUM_THUNDERX
 	tristate "Cavium ThunderX SD/MMC Card Interface support"
 	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f40c6b3..7f1ee0b 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -42,6 +42,8 @@ obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
+octeon-mmc-objs := cavium.o cavium-octeon.o
+obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
 thunderx-mmc-objs := cavium.o cavium-thunderx.o
 obj-$(CONFIG_MMC_CAVIUM_THUNDERX) += thunderx-mmc.o
 obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
new file mode 100644
index 0000000..772d090
--- /dev/null
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -0,0 +1,351 @@
+/*
+ * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2017 Cavium Inc.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <asm/octeon/octeon.h>
+#include "cavium.h"
+
+#define CVMX_MIO_BOOT_CTL CVMX_ADD_IO_SEG(0x00011800000000D0ull)
+
+/*
+ * The l2c* functions below are used for the EMMC-17978 workaround.
+ *
+ * Due to a bug in the design of the MMC bus hardware, the 2nd to last
+ * cache block of a DMA read must be locked into the L2 Cache.
+ * Otherwise, data corruption may occur.
+ */
+static inline void *phys_to_ptr(u64 address)
+{
+	return (void *)(address | (1ull << 63)); /* XKPHYS */
+}
+
+/*
+ * Lock a single line into L2. The line is zeroed before locking
+ * to make sure no dram accesses are made.
+ */
+static void l2c_lock_line(u64 addr)
+{
+	char *addr_ptr = phys_to_ptr(addr);
+
+	asm volatile (
+		"cache 31, %[line]"	/* Unlock the line */
+		::[line] "m" (*addr_ptr));
+}
+
+/* Unlock a single line in the L2 cache. */
+static void l2c_unlock_line(u64 addr)
+{
+	char *addr_ptr = phys_to_ptr(addr);
+
+	asm volatile (
+		"cache 23, %[line]"	/* Unlock the line */
+		::[line] "m" (*addr_ptr));
+}
+
+/* Locks a memory region in the L2 cache. */
+static void l2c_lock_mem_region(u64 start, u64 len)
+{
+	u64 end;
+
+	/* Round start/end to cache line boundaries */
+	end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
+	start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
+
+	while (start <= end) {
+		l2c_lock_line(start);
+		start += CVMX_CACHE_LINE_SIZE;
+	}
+	asm volatile("sync");
+}
+
+/* Unlock a memory region in the L2 cache. */
+static void l2c_unlock_mem_region(u64 start, u64 len)
+{
+	u64 end;
+
+	/* Round start/end to cache line boundaries */
+	end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
+	start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
+
+	while (start <= end) {
+		l2c_unlock_line(start);
+		start += CVMX_CACHE_LINE_SIZE;
+	}
+}
+
+static void octeon_mmc_acquire_bus(struct cvm_mmc_host *host)
+{
+	if (!host->has_ciu3) {
+		down(&octeon_bootbus_sem);
+		/* For CN70XX, switch the MMC controller onto the bus. */
+		if (OCTEON_IS_MODEL(OCTEON_CN70XX))
+			writeq(0, (void __iomem *)CVMX_MIO_BOOT_CTL);
+	} else {
+		down(&host->mmc_serializer);
+	}
+}
+
+static void octeon_mmc_release_bus(struct cvm_mmc_host *host)
+{
+	if (!host->has_ciu3)
+		up(&octeon_bootbus_sem);
+	else
+		up(&host->mmc_serializer);
+}
+
+static void octeon_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
+{
+	writeq(val, host->base + MIO_EMM_INT(host));
+	if (!host->dma_active || (host->dma_active && !host->has_ciu3))
+		writeq(val, host->base + MIO_EMM_INT_EN(host));
+}
+
+static void octeon_mmc_set_shared_power(struct cvm_mmc_host *host, int dir)
+{
+	if (dir == 0)
+		if (!atomic_dec_return(&host->shared_power_users))
+			gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
+	if (dir == 1)
+		if (atomic_inc_return(&host->shared_power_users) == 1)
+			gpiod_set_value_cansleep(host->global_pwr_gpiod, 1);
+}
+
+static void octeon_mmc_dmar_fixup(struct cvm_mmc_host *host,
+				  struct mmc_command *cmd,
+				  struct mmc_data *data,
+				  u64 addr)
+{
+	if (cmd->opcode != MMC_WRITE_MULTIPLE_BLOCK)
+		return;
+	if (data->blksz * data->blocks <= 1024)
+		return;
+
+	host->n_minus_one = addr + (data->blksz * data->blocks) - 1024;
+	l2c_lock_mem_region(host->n_minus_one, 512);
+}
+
+static void octeon_mmc_dmar_fixup_done(struct cvm_mmc_host *host)
+{
+	if (!host->n_minus_one)
+		return;
+	l2c_unlock_mem_region(host->n_minus_one, 512);
+	host->n_minus_one = 0;
+}
+
+static int octeon_mmc_probe(struct platform_device *pdev)
+{
+	struct device_node *cn, *node = pdev->dev.of_node;
+	struct cvm_mmc_host *host;
+	struct resource	*res;
+	void __iomem *base;
+	int mmc_irq[9];
+	int i, ret = 0;
+	u64 val;
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
+
+	spin_lock_init(&host->irq_handler_lock);
+	sema_init(&host->mmc_serializer, 1);
+
+	host->dev = &pdev->dev;
+	host->acquire_bus = octeon_mmc_acquire_bus;
+	host->release_bus = octeon_mmc_release_bus;
+	host->int_enable = octeon_mmc_int_enable;
+	host->set_shared_power = octeon_mmc_set_shared_power;
+	if (OCTEON_IS_MODEL(OCTEON_CN6XXX) ||
+	    OCTEON_IS_MODEL(OCTEON_CNF7XXX)) {
+		host->dmar_fixup = octeon_mmc_dmar_fixup;
+		host->dmar_fixup_done = octeon_mmc_dmar_fixup_done;
+	}
+
+	host->sys_freq = octeon_get_io_clock_rate();
+
+	if (of_device_is_compatible(node, "cavium,octeon-7890-mmc")) {
+		host->big_dma_addr = true;
+		host->need_irq_handler_lock = true;
+		host->has_ciu3 = true;
+		host->use_sg = true;
+		/*
+		 * First seven are the EMM_INT bits 0..6, then two for
+		 * the EMM_DMA_INT bits
+		 */
+		for (i = 0; i < 9; i++) {
+			mmc_irq[i] = platform_get_irq(pdev, i);
+			if (mmc_irq[i] < 0)
+				return mmc_irq[i];
+
+			/* work around legacy u-boot device trees */
+			irq_set_irq_type(mmc_irq[i], IRQ_TYPE_EDGE_RISING);
+		}
+	} else {
+		host->big_dma_addr = false;
+		host->need_irq_handler_lock = false;
+		host->has_ciu3 = false;
+		/* First one is EMM second DMA */
+		for (i = 0; i < 2; i++) {
+			mmc_irq[i] = platform_get_irq(pdev, i);
+			if (mmc_irq[i] < 0)
+				return mmc_irq[i];
+		}
+	}
+
+	host->last_slot = -1;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
+		return -ENXIO;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	host->base = (void __iomem *)base;
+	host->reg_off = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[1] is missing\n");
+		return -EINVAL;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	host->dma_base = (void __iomem *)base;
+	/*
+	 * To keep the register addresses shared we intentionaly use
+	 * a negative offset here, first register used on Octeon therefore
+	 * starts at 0x20 (MIO_EMM_DMA_CFG).
+	 */
+	host->reg_off_dma = -0x20;
+
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear out any pending interrupts that may be left over from
+	 * bootloader.
+	 */
+	val = readq(host->base + MIO_EMM_INT(host));
+	writeq(val, host->base + MIO_EMM_INT(host));
+
+	if (host->has_ciu3) {
+		/* Only CMD_DONE, DMA_DONE, CMD_ERR, DMA_ERR */
+		for (i = 1; i <= 4; i++) {
+			ret = devm_request_irq(&pdev->dev, mmc_irq[i],
+					       cvm_mmc_interrupt,
+					       0, cvm_mmc_irq_names[i], host);
+			if (ret < 0) {
+				dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+					mmc_irq[i]);
+				return ret;
+			}
+		}
+	} else {
+		ret = devm_request_irq(&pdev->dev, mmc_irq[0],
+				       cvm_mmc_interrupt, 0, KBUILD_MODNAME,
+				       host);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Error: devm_request_irq %d\n",
+				mmc_irq[0]);
+			return ret;
+		}
+	}
+
+	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev,
+							 "power-gpios",
+							 GPIOD_OUT_HIGH);
+	if (IS_ERR(host->global_pwr_gpiod)) {
+		dev_err(&pdev->dev, "Invalid power GPIO\n");
+		return PTR_ERR(host->global_pwr_gpiod);
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	i = 0;
+	for_each_child_of_node(node, cn) {
+		host->slot_pdev[i] =
+			of_platform_device_create(cn, NULL, &pdev->dev);
+		if (!host->slot_pdev[i]) {
+			i++;
+			continue;
+		}
+		ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
+		if (ret) {
+			dev_err(&pdev->dev, "Error populating slots\n");
+			octeon_mmc_set_shared_power(host, 0);
+			return ret;
+		}
+		i++;
+	}
+	return 0;
+}
+
+static int octeon_mmc_remove(struct platform_device *pdev)
+{
+	struct cvm_mmc_host *host = platform_get_drvdata(pdev);
+	u64 dma_cfg;
+	int i;
+
+	for (i = 0; i < CAVIUM_MAX_MMC; i++)
+		if (host->slot[i])
+			cvm_mmc_of_slot_remove(host->slot[i]);
+
+	dma_cfg = readq(host->dma_base + MIO_EMM_DMA_CFG(host));
+	dma_cfg &= ~MIO_EMM_DMA_CFG_EN;
+	writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
+
+	octeon_mmc_set_shared_power(host, 0);
+	return 0;
+}
+
+static const struct of_device_id octeon_mmc_match[] = {
+	{
+		.compatible = "cavium,octeon-6130-mmc",
+	},
+	{
+		.compatible = "cavium,octeon-7890-mmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mmc_match);
+
+static struct platform_driver octeon_mmc_driver = {
+	.probe		= octeon_mmc_probe,
+	.remove		= octeon_mmc_remove,
+	.driver		= {
+		.name	= KBUILD_MODNAME,
+		.of_match_table = octeon_mmc_match,
+	},
+};
+
+static int __init octeon_mmc_init(void)
+{
+	return platform_driver_register(&octeon_mmc_driver);
+}
+
+static void __exit octeon_mmc_cleanup(void)
+{
+	platform_driver_unregister(&octeon_mmc_driver);
+}
+
+module_init(octeon_mmc_init);
+module_exit(octeon_mmc_cleanup);
+
+MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Low-level driver for Cavium OCTEON MMC/SSD card");
+MODULE_LICENSE("GPL");
-- 
2.1.4
