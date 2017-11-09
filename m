Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:53:37 +0100 (CET)
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:17152
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990411AbdKIAwRHeWjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:52:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YaqHtT18DaOUPHmDbYJkdLXt897gnJHyHoXgzXbu2C8=;
 b=mhNsXn0TyANrc1vBqealLqLPoJTUoHIfCX66PpCymSLRHNt4Ut9bJ9nqIil3fMznOQ/r5T6MFnT85xQ8YWi3J+0zREVif7q0XXvhcULJnNpyx6YHWxI4Dc3JeumZw0k7EjvfDuz73q17Ppo3SKgbVvAf8r6ZVFvIj1y4VpehT1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:51:59 +0000
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
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/8] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
Date:   Wed,  8 Nov 2017 16:51:22 -0800
Message-Id: <20171109005126.21341-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f1f553a-f33a-4b6d-5c31-08d5270c18dd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:S7d9+5y7SeykVGCuf+dE9GQegV2vlQJiE5il6MRef7M9FHvQ3hauKRzm1aMqm8edk7nzFOSsKXngbbyoogOTF/Q1WqKKgD8JWoAIkPPM73NUR1KIArJ9Qp4u8yEl9+mBhoR5u0WVbmtmLKM4QWjf8eBu9cPlTknly5ZYJSdY2Vd+wNnh5wwFnZAG70oG2tIm4OQ3w099xyKfQKAtkGh2XSZLt6lDyImR8TER1yXnBjDnokJgUY3H6ARUXG2QpjOQ;25:FhXkwYCieBoOC+mRDKxXFnDqSQS0IdPkgsoDG0aGPYI7hQybt5xhd1PglVgPzJF7ONixeY57bz29tkcC1eKMUi8amp/5V7MTCxKgl0IOgiuBduhzl6zGdxLPELqX83qbT/++zs3c7F3LdNl2ajFu55a0AKuyVgxm0c+diewLVd6qpW4oSTHNAphjjZcL3QfkZ1kPrt58e9JLWdlpUb2PDtQXsmH2EjSK4p7N1rI7H2CDr7WZZGBqbUwKREomA/FGeuoGClvu99J4lMONStMNGbJgG9ZFrno567ptvz3lJ4EDR4XJIDPyG8OOzESE5owz4cKnIHFapU4PzMf1JYrVtw==;31:yhLJ+ihkHKdxsjyjzIJasDBtAAU/mkdo/cwIIgZY11MLSK2gbhIQROolsxExaUlt5jvAHODQwDW/56Yr1mnnyRnd1kK46vFj6qEZnFwB8TIQJaBS1PoDj90ePHiQ+5G/0d6A7LKZC3jlL/95sAFGrSZBQL665vv6FsNIk/+c5uGNZi4h8aAxW1k6w0TbTyJbBZV6fv7xgPWn07Yba6WV7e97GNFwkjoAXOTW9XTxjDI=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:BwWBYltTi8sinNZcmOk5OT/mQuHHZZVA5AiQSFf3mHZZW5w+97D5y2IQ66fod9Oec7vosykgIKnELR/M9jeRLPyLuU4qeu30GgTD0qTK2ZZCNdvNhhdbAGAT3ctF8sUr+duMj2LLdCCID6Qe3i0B0XUl4Arlj+5rYQSdkJatsur0CJy5xcZM4eVTu3/t/be93awMxdGBqIeV297wvBM8Ll4THgpgpUcMSKfw4XTBXMmQCoMe9A2yfw0la7T5F+k/U8PFB/pP5mzivY0SiB0KYv5vl1Qwv8lwhAsMpN5+Y7/JzV1c3IoKJgk2ZindbdYyPJl2g7uEhtj+l9WLAne0nhdpNo2h8HX79WwlbQGfVeJmvwbsVSe3v2V0ucDfe9JM02w8qvZKAsgC2zmwoXWdU9r8ZAt+Xk+Hc56uE4KRHH5MkREwlaMkgq8Wb1+NqfE7fOMix5pttx2uvsUlW/iyWi0gvoM5uxOCF62M/Fb4pdgkCPU91xkeJvKEP90btnFe;4:4sus2G3CBZfwUvxNb/2ec8dXXmugYdc8lFi0Gc2+EPbFUOLwcpKkRKqJS7YGOoMwzQUh2T88liO46svBmeGQhKPO4NKdBqewGS9wJ3I+Se6oBubHRrCDrCEGfEuvBqkLjPqIIP4WE3dlDOYJsHBD5MnT1ImDEg/eKoQak3LjOWAv7+NYGkVfoG8CS1gpQXiyMh9nwKiudQhYU4ZXnSqhzdlCg0kgvvI4/EQ/bor6zv4+77HSdFxsv55AeLy1h0LkNEkgpl3KF975RrqLV3FEUQ==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495F7B53B19DB57AA76923997570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:ExHoTBLow6Cxbaq5Bh42d8KQRU/ivHyTzVlBPoyGE?=
 =?us-ascii?Q?8o+15qAg0zoRR8k9ol5RKpLur7CJgE3pgg/59gyIYprt3PNssF8jGsHR/mvF?=
 =?us-ascii?Q?o+ZUm1IaTB+GHU7cS6XJa8BJZrnKS6QorodXBjB+JkZh7uW1MmJgqhM7Vm8D?=
 =?us-ascii?Q?4CT3upI4e7h5L9le2Zm0Hpu9LS7VNAc7DXJ2XGOciF44M7Xxy2hx2T6/JJ8T?=
 =?us-ascii?Q?6OVzq7o2p72kgFTvAm6jDxuh8FHWpQAZrV+0kYDQvGM4ibej3Wzgi1RhcWb0?=
 =?us-ascii?Q?0gFFYq1dxHIHnpsJ/pzdVIYDc/TObwXd2rQ4qgJu3401yX2liLYCr4wbY0ei?=
 =?us-ascii?Q?8NZ06lHYDCtNw+Pd1UJPCq9Pn3rkwCL/kUPuknRqWdCaLt6281bTPInVjpS4?=
 =?us-ascii?Q?/8Em/N+lN/qZNf0M9n8M8EQPeIMIAriaWMx4rC6CfhskhKcLnrDxxHx/6HYJ?=
 =?us-ascii?Q?280bJJ6N4Xv4YpG/IgJfLjWTOex9qSraiJPjkHUtmqWniXHL3Snu+3x6uv6b?=
 =?us-ascii?Q?jsBj0dWl/kH9KnweHMKtft8k/3eEmNP/2bFrSDxCIa/DbdgOTzXxZRT4nhLx?=
 =?us-ascii?Q?KP6KV5czeTNOZatbtqsmIE+MyxMmrRxEz2JTN7PU93LxhxACRP8MbvGEDrqj?=
 =?us-ascii?Q?A1IEF+uCPctpZOIRWZ3lDWHCMpqnxuSxGGvaMzGh8G73TkBvHJXYI+NWyXCH?=
 =?us-ascii?Q?Rqq7rNkUcisGM20oNemPhopTljU8zc2JNUzQ6zedX9o2hP7QcyznxG9Z+zxz?=
 =?us-ascii?Q?xURsHHd43wPdpU6jUwfFQyh0uTII1bYZ6OX7QUzzN4mVnQKszacGEGkqtFAa?=
 =?us-ascii?Q?h8i8mFtjWJ91vsl/7VlHZu3XXHJAisxIrUa6MXKfXcOHe0u4CZYMkHH17ChZ?=
 =?us-ascii?Q?iAjpGgM8pkCpCcZZhctPovsnr9BtvYeBjjdBQ/JLIDCiCVBbflcyajbqMTu8?=
 =?us-ascii?Q?tLVuBH6iA1boqptYH+WBsYF71HYMOH283nnxLjt4GnsaEHNYbVPR5xoafRL6?=
 =?us-ascii?Q?0YBib0wGnlNzVDszR91ZcGMxsb7G7Xrxs++SOmN/YbQJc11YpVcLsLknszP3?=
 =?us-ascii?Q?/FlwzqKOtRkMRq9g0dhnzlKgW7vNvPqvIPmRMdsgVqiFCJxUMHZ4dEgWVn52?=
 =?us-ascii?Q?dcbJ5t1iS6L3fIIRwszddNNyhmWcq9ORzpL2RwSwGCQ9kdJwSACasszbBSo4?=
 =?us-ascii?Q?LLydpPhpvHBjpxIH/yqJQIY/MftAtANaXQBCF+a4C0LRl5u/RNNWYbCuCuwO?=
 =?us-ascii?Q?yDocCwL4QdR1I2CxdG/CZzdK+TA6VisrObl9aYS?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:HQWJ8W6cXo7VHZujkIlsXawGNd4WdwkaoqcfX1uF2R56Ce3Jjzz7HW/y8Ud+uYkzlqBQHLbcYhOWk4tLDxykPAVmA3qzMS97KM2i7iwesm70tiOlarY1YtOstQvjmUXY1lUzxhSH9TVyIgXSABsAKxyBtWasmTSaC2hhv3bw7TELw7TfiEIIVld8WBRpLy4Rl2ECu8iGES9caEE9rfR5qEnb69j9w/7RXcxQys9mnOBzdg0CQa/uHxdWMAeWw9CoC+REhSsgOc5iteqCkd13ByLrDx8njF9nTChraYpC/QCO3epFchMcFbcP6b3XLinqocjWZ5vM++XRRuoA8SfXGYfEGHKRQjkFesDoJoNtpNo=;5:NgOsGyGxqrtyCu97gon7FpKT1h0M8QXfKJpsNfPT9XCVJZMP9pZtC87YlncaOOJ8MzqzjWkSDXxnE/nmlC59ZuYIu5TISULZIqzsO2RU21l32rLh9abHH1LgzdRWy4WMFxX1Tpt+cznttpemKupF+iwK1hA9Jh6Wq0Plog2LmUs=;24:i1I6I09+8qeZAYnUVuCZcq2b9J+fF8KHXm1F3qbeVj9gUUvgZOP576zMKcnXCcQA5JB9pSGcJO9ftVQStvxX6GR/hrVCzRCMPcOEF+YrshI=;7:n75uLW1SRm2F7Uh9zEHKE/h7oDeQUSPK9wDt8E/HjB0L0kViNypKIwz7eZDoqe3/zUEuVdOzLps867TLgf66SoZVdtQDmJGqItk8AVJZGvEocEhSMQ4C18BUHVhGQf/cw9h2hr4fgxoEf3JQWjcZuUcxMQmRn1mRnJ5biqf+KhHyxWJ8/JSQOJlkOjeLMgqWAz93E/PHMsUO88QiEDoqtAIj9tXGbyz2+hh4qiQZNm3/g6MpTR2VS4+pYj0DVM/7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:51:59.0360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1f553a-f33a-4b6d-5c31-08d5270c18dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60787
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

From: Carlos Munoz <cmunoz@cavium.com>

From the hardware user manual: "The FPA is a unit that maintains
pools of pointers to free L2/DRAM memory. To provide QoS, the pools
are referenced indirectly through 1024 auras. Both core software
and hardware units allocate and free pointers."

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Kconfig       |   8 +
 arch/mips/cavium-octeon/Makefile      |   1 +
 arch/mips/cavium-octeon/octeon-fpa3.c | 364 ++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h |  15 ++
 4 files changed, 388 insertions(+)
 create mode 100644 arch/mips/cavium-octeon/octeon-fpa3.c

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 5c0b56203bae..4dffe78fe6b9 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -86,4 +86,12 @@ config OCTEON_ILM
 	  To compile this driver as a module, choose M here.  The module
 	  will be called octeon-ilm
 
+config OCTEON_FPA3
+	tristate "Octeon III fpa driver"
+	help
+	  This option enables a Octeon III driver for the Free Pool Unit (FPA).
+	  The FPA is a hardware unit that manages pools of pointers to free
+	  L2/DRAM memory. This driver provides an interface to reserve,
+	  initialize, and fill fpa pools.
+
 endif # CAVIUM_OCTEON_SOC
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 0a299ab8719f..0ef967399702 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
 obj-$(CONFIG_USB)		      += octeon-usb.o
+obj-$(CONFIG_OCTEON_FPA3)	      += octeon-fpa3.o
diff --git a/arch/mips/cavium-octeon/octeon-fpa3.c b/arch/mips/cavium-octeon/octeon-fpa3.c
new file mode 100644
index 000000000000..a7c7decdbc9a
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-fpa3.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Octeon III Free Pool Unit (fpa).
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015-2017 Cavium, Inc.
+ */
+
+#include <linux/module.h>
+
+#include <asm/octeon/octeon.h>
+
+
+/* Registers are accessed via xkphys */
+#define SET_XKPHYS			(1ull << 63)
+#define NODE_OFFSET			0x1000000000ull
+#define SET_NODE(node)			((node) * NODE_OFFSET)
+
+#define FPA_BASE			0x1280000000000ull
+#define SET_FPA_BASE(node)		(SET_XKPHYS + SET_NODE(node) + FPA_BASE)
+
+#define FPA_GEN_CFG(n)			(SET_FPA_BASE(n)           + 0x00000050)
+
+#define FPA_POOLX_CFG(n, p)		(SET_FPA_BASE(n) + (p<<3)  + 0x10000000)
+#define FPA_POOLX_START_ADDR(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10500000)
+#define FPA_POOLX_END_ADDR(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10600000)
+#define FPA_POOLX_STACK_BASE(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10700000)
+#define FPA_POOLX_STACK_END(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10800000)
+#define FPA_POOLX_STACK_ADDR(n, p)	(SET_FPA_BASE(n) + (p<<3)  + 0x10900000)
+
+#define FPA_AURAX_POOL(n, a)		(SET_FPA_BASE(n) + (a<<3)  + 0x20000000)
+#define FPA_AURAX_CFG(n, a)		(SET_FPA_BASE(n) + (a<<3)  + 0x20100000)
+#define FPA_AURAX_CNT(n, a)		(SET_FPA_BASE(n) + (a<<3)  + 0x20200000)
+#define FPA_AURAX_CNT_LIMIT(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20400000)
+#define FPA_AURAX_CNT_THRESHOLD(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20500000)
+#define FPA_AURAX_POOL_LEVELS(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20700000)
+#define FPA_AURAX_CNT_LEVELS(n, a)	(SET_FPA_BASE(n) + (a<<3)  + 0x20800000)
+
+static inline u64 oct_csr_read(u64 addr)
+{
+	return __raw_readq((void __iomem *)addr);
+}
+
+static inline void oct_csr_write(u64 data, u64 addr)
+{
+	__raw_writeq(data, (void __iomem *)addr);
+}
+
+static DEFINE_MUTEX(octeon_fpa3_lock);
+
+static int get_num_pools(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		return 64;
+	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) || OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return 32;
+	return 0;
+}
+
+static int get_num_auras(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		return 1024;
+	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) || OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return 512;
+	return 0;
+}
+
+/**
+ * octeon_fpa3_init - Initialize the fpa to default values.
+ * @node: Node of fpa to initialize.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_init(int node)
+{
+	static bool init_done[2];
+	u64 data;
+	int aura_cnt, i;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	if (init_done[node])
+		goto done;
+
+	aura_cnt = get_num_auras();
+	for (i = 0; i < aura_cnt; i++) {
+		oct_csr_write(0x100000000ull, FPA_AURAX_CNT(node, i));
+		oct_csr_write(0xfffffffffull, FPA_AURAX_CNT_LIMIT(node, i));
+		oct_csr_write(0xffffffffeull, FPA_AURAX_CNT_THRESHOLD(node, i));
+	}
+
+	data = oct_csr_read(FPA_GEN_CFG(node));
+	data &= ~GENMASK_ULL(9, 4);
+	data |= 3 << 4;
+	oct_csr_write(data, FPA_GEN_CFG(node));
+
+	init_done[node] = 1;
+ done:
+	mutex_unlock(&octeon_fpa3_lock);
+	return 0;
+}
+EXPORT_SYMBOL(octeon_fpa3_init);
+
+/**
+ * octeon_fpa3_pool_init - Initialize a pool.
+ * @node: Node to initialize pool on.
+ * @pool_num: Requested pool number (-1 for don't care).
+ * @pool: Updated with the initialized pool number.
+ * @pool_stack: Updated with the base of the memory allocated for the pool
+ *		stack.
+ * @num_ptrs: Number of pointers to allocated on the stack.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_pool_init(int node, int pool_num, int *pool, void **pool_stack, int num_ptrs)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	u64 pool_stack_start, pool_stack_end, data;
+	int stack_size, rc = 0;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_pool", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, get_num_pools());
+	*pool = res_mgr_alloc(tag, pool_num, true);
+	if (*pool < 0) {
+		rc = -ENODEV;
+		goto error;
+	}
+
+	oct_csr_write(0, FPA_POOLX_CFG(node, *pool));
+	oct_csr_write(128, FPA_POOLX_START_ADDR(node, *pool));
+	oct_csr_write(GENMASK_ULL(41, 7), FPA_POOLX_END_ADDR(node, *pool));
+
+	stack_size = (DIV_ROUND_UP(num_ptrs, 29) + 1) * 128;
+	*pool_stack = kmalloc_node(stack_size, GFP_KERNEL, node);
+	if (!*pool_stack) {
+		pr_err("Failed to allocate pool stack memory pool=%d\n",
+		       pool_num);
+		rc = -ENOMEM;
+		goto error_stack;
+	}
+
+	pool_stack_start = virt_to_phys(*pool_stack);
+	pool_stack_end = round_down(pool_stack_start + stack_size, 128);
+	pool_stack_start = round_up(pool_stack_start, 128);
+	oct_csr_write(pool_stack_start, FPA_POOLX_STACK_BASE(node, *pool));
+	oct_csr_write(pool_stack_start, FPA_POOLX_STACK_ADDR(node, *pool));
+	oct_csr_write(pool_stack_end, FPA_POOLX_STACK_END(node, *pool));
+
+	data = (2 << 3) | BIT(0);
+	oct_csr_write(data, FPA_POOLX_CFG(node, *pool));
+
+	mutex_unlock(&octeon_fpa3_lock);
+	return 0;
+
+error_stack:
+	res_mgr_free(tag, *pool);
+error:
+	mutex_unlock(&octeon_fpa3_lock);
+	return rc;
+}
+EXPORT_SYMBOL(octeon_fpa3_pool_init);
+
+/**
+ * octeon_fpa3_release_pool - Release a pool.
+ * @node: Node pool is on.
+ * @pool: Pool to release.
+ */
+void octeon_fpa3_release_pool(int node, int pool)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_pool", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_free(tag, pool);
+
+	mutex_unlock(&octeon_fpa3_lock);
+}
+EXPORT_SYMBOL(octeon_fpa3_release_pool);
+
+/**
+ * octeon_fpa3_aura_init - Initialize an aura.
+ * @node: Node to initialize aura on.
+ * @pool: Pool the aura belongs to.
+ * @aura_num: Requested aura number (-1 for don't care).
+ * @aura: Updated with the initialized aura number.
+ * @num_bufs: Number of buffers in the aura.
+ * @limit: Limit for the aura.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_aura_init(int node, int pool, int aura_num, int *aura, int num_bufs, unsigned int limit)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	u64 data, shift;
+	unsigned int drop, pass;
+	int rc = 0;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_aura", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, get_num_auras());
+	*aura = res_mgr_alloc(tag, aura_num, true);
+	if (*aura < 0) {
+		rc = -ENODEV;
+		goto error;
+	}
+
+	oct_csr_write(0, FPA_AURAX_CFG(node, *aura));
+
+	/* Allow twice the limit before saturation at zero */
+	limit *= 2;
+	data = limit;
+	oct_csr_write(data, FPA_AURAX_CNT_LIMIT(node, *aura));
+	oct_csr_write(data, FPA_AURAX_CNT(node, *aura));
+
+	oct_csr_write(pool, FPA_AURAX_POOL(node, *aura));
+
+	/* No per-pool RED/Drop */
+	oct_csr_write(0, FPA_AURAX_POOL_LEVELS(node, *aura));
+
+	shift = 0;
+	while ((limit >> shift) > 255)
+		shift++;
+
+	drop = (limit - num_bufs / 20) >> shift;	/* 95% */
+	pass = (limit - (num_bufs * 3) / 20) >> shift;	/* 85% */
+
+	/* Enable per aura RED/drop */
+	data = BIT(38) | (shift << 32) | (drop << 16) | (pass << 8);
+	oct_csr_write(data, FPA_AURAX_CNT_LEVELS(node, *aura));
+
+error:
+	mutex_unlock(&octeon_fpa3_lock);
+	return rc;
+}
+EXPORT_SYMBOL(octeon_fpa3_aura_init);
+
+/**
+ * octeon_fpa3_release_aura - Release an aura.
+ * @node: Node to aura is on.
+ * @aura: Aura to release.
+ */
+void octeon_fpa3_release_aura(int node, int aura)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	strncpy((char *)&tag.lo, "cvm_aura", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_free(tag, aura);
+
+	mutex_unlock(&octeon_fpa3_lock);
+}
+EXPORT_SYMBOL(octeon_fpa3_release_aura);
+
+/**
+ * octeon_fpa3_alloc - Get a buffer from a aura's pool.
+ * @node: Node to free memory to.
+ * @aura: Aura to free memory to.
+ *
+ * Returns allocated buffer pointer if successful
+ * Returns NULL on error.
+ */
+void *octeon_fpa3_alloc(u64 node, int aura)
+{
+	u64 buf_phys, addr;
+	void *buf = NULL;
+
+	/* Buffer pointers are obtained using load operations */
+	addr = BIT(63) | BIT(48) | (0x29ull << 40) | (node << 36) |
+		(aura << 16);
+	buf_phys = *(u64 *)addr;
+
+	if (buf_phys)
+		buf = phys_to_virt(buf_phys);
+
+	return buf;
+}
+EXPORT_SYMBOL(octeon_fpa3_alloc);
+
+/**
+ * octeon_fpa3_free - Add a buffer back to the aura's pool.
+ * @node: Node to free memory to.
+ * @aura: Aura to free memory to.
+ * @buf: Address of buffer to free to the aura's pool.
+ */
+void octeon_fpa3_free(u64 node, int aura, const void *buf)
+{
+	u64 buf_phys, addr;
+
+	buf_phys = virt_to_phys(buf);
+
+	/* Make sure that any previous writes to memory go out before we free
+	 * this buffer. This also serves as a barrier to prevent GCC from
+	 * reordering operations to after the free.
+	 */
+	wmb();
+
+	/* Buffers are added to fpa pools using store operations */
+	addr = BIT(63) | BIT(48) | (0x29ull << 40) | (node << 36) | (aura << 16);
+	*(u64 *)addr = buf_phys;
+}
+EXPORT_SYMBOL(octeon_fpa3_free);
+
+/**
+ * octeon_fpa3_mem_fill - Add buffers to an aura.
+ * @node: Node to get memory from.
+ * @cache: Memory cache to allocate from.
+ * @aura: Aura to add buffers to.
+ * @num_bufs: Number of buffers to add to the aura.
+ *
+ * Returns 0 if successful.
+ * Returns <0 for error codes.
+ */
+int octeon_fpa3_mem_fill(int node, struct kmem_cache *cache, int aura, int num_bufs)
+{
+	void *mem;
+	int i, rc = 0;
+
+	mutex_lock(&octeon_fpa3_lock);
+
+	for (i = 0; i < num_bufs; i++) {
+		mem = kmem_cache_alloc_node(cache, GFP_KERNEL, node);
+		if (!mem) {
+			pr_err("Failed to allocate memory for aura=%d\n", aura);
+			rc = -ENOMEM;
+			break;
+		}
+		octeon_fpa3_free(node, aura, mem);
+	}
+
+	mutex_unlock(&octeon_fpa3_lock);
+	return rc;
+}
+EXPORT_SYMBOL(octeon_fpa3_mem_fill);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cavium, Inc. Octeon III FPA manager.");
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index 0411efdb465c..d184592e6515 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -10,6 +10,7 @@
 
 #include <asm/octeon/cvmx.h>
 #include <asm/bitfield.h>
+#include <linux/slab.h>
 
 extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
 						uint64_t alignment,
@@ -364,6 +365,20 @@ int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
 			int req_cnt, bool use_last_avail, int *inst);
 int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt);
 
+#if IS_ENABLED(CONFIG_OCTEON_FPA3)
+int octeon_fpa3_init(int node);
+int octeon_fpa3_pool_init(int node, int pool_num, int *pool, void **pool_stack,
+			  int num_ptrs);
+int octeon_fpa3_aura_init(int node, int pool, int aura_num, int *aura,
+			  int num_bufs, unsigned int limit);
+int octeon_fpa3_mem_fill(int node, struct kmem_cache *cache, int aura,
+			 int num_bufs);
+void octeon_fpa3_free(u64 node, int aura, const void *buf);
+void *octeon_fpa3_alloc(u64 node, int aura);
+void octeon_fpa3_release_pool(int node, int pool);
+void octeon_fpa3_release_aura(int node, int aura);
+#endif
+
 /**
  * Read a 32bit value from the Octeon NPI register space
  *
-- 
2.13.6
