Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:58:52 +0100 (CET)
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:6176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990490AbdK2A5i0R20i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kMJHq47tao7+34JhyLNbR90ACDXgbKhwBC2bmwTUwpQ=;
 b=g4Afg+07Nwmqv7BCSRi0HXy6jcEdU0BkZ4Vw2ynvCMQ9BRKOgCrY66aYa9jrYtM22odma7wb/bG7VQqPBXcqDABRw46LPqzGQfSPMXtuLFPZSlWCrEQbZF5h5GD35i7SgKesjdoqfy5jhmNZc3kNrkz9g62vrltVZp1N4ZAWr7Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:18 +0000
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
Subject: [PATCH v4 4/8] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
Date:   Tue, 28 Nov 2017 16:55:36 -0800
Message-Id: <20171129005540.28829-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71844620-5e68-466c-bc40-08d536c42713
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:6nIFaEf86EE2/MuYaEA8pgBoy222bDn6PTDKTE7dfwJ9M8C7YUWRE7ST+yOy+NKbUgZgLK/IsGqBhIqLqUU0i+/+3SUgoPCdKYMAXSn2ifvhZqtvc5cvNNU8ikkNkweaP82DX2bsfLR8mTvbE9ESqDnfdquUeluq5TO74UGiCb6cs5rtVbzUC9UA8JxFE6+DA12lhzp1psETE1OsH30xBuOkCZjNiTJ9E1IM+7FY+HsPW4207AiwJDsLlwRO3Gaz;25:dyPztlBmsB0Y+N51p7fEuYHnJYkYBCyVH45fecu3VWLg2GX5isUDv1aSRyEbZuExbEkb2ba6bY6rNJ/X3XxIrPvs6TWBSSHLjm8/hcwRmd97Ots6hJJET9FAf+U31O24fzKWkIucOvhDstMleRDw6zAsMHTcmrUafJ++iENJED+hHGGv5xYJofh6k6ztjMACpcefGyjZYq0bIc7nb+iZxivX+KxxNPQWvYCLtpmlDBymEHxcl5JmCXfdOw3pe9dVPkmK16HaQnuvY9iEf3o6I1vhBS/o3uw0fuLIMFcehW0hM8E0FjC5yHuZECCi18YJbw62WAYefWh6y/LQymqZLQ==;31:lfIXvtcUJUZI4Br5eBvjcBBVTW2X6OeOQX2Kl0ObzrKQFmcJL62vuXzY2/yQ/nKHpiT1nuBmOPom+XhkdbFwkBhstYunQdiFmdC7KSiVhYq/tSBMWkN/qOdPKigTElmQUVAUJkb4GxnRdow2AbnntyBe2NMbo0Cgkq91V8CqYqEbXh70M2MmfY5yCD8QTlrevQlgcQV6NlGSY12ctRAMLYZBePiMjuxSbw0m2NvH60c=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:C1/c7ga2V9POoCXcp294+vogD3xy9HlfwKIrB3SxtcLgdkt9LEgc2jwkSEiY0pt6oCuCECuF1iYyQ33Kin74g47EP3JZ2VMpa58tcwRdvO5tu4BQlxG2ArPm8WrVnhP3d5RPAorqIsWcBgp012zEwOhRNkPSMJHxPBzM3uzivIyYLoWISX7YyN1m9mCDSUlFof4kilw4OwcszDNAyQ364/gf9Dm2zRs/WU1TFtsUFN6hGMtl5EoNNl3KkWrSybtOfJNrYeRDkETVKEKIXtaxCgyGI2xNwFcLI7lcqL8R3jnJQL11UKdrpClbONdylY/0cktwce38QTXGtPX/Ts0DM+Zv8ZPrd3cSUkrhtM+6AZEzlic33/vh1bG/OzD1KVfPpS1E6Gu8UufBUjAu0ex351bTBTWeH0OEuXR+xvtf1m5wGPsEAgIG1Ur6y02yJxGHtE/IlEHyZqosV6Z4/dntnSBnmoiwnNfinj5aSz0bL6i2rTWdvRvllq3GBIsu2f+L;4:dCYeYmW1KGDaboJpyOAPBazmswxven1vVulvYkYKOpKDCqrvfVcOsm56+MaDU9xpkto7+4Eo8g2zJoQFI3blQfYcADI5jDjnNmqmLiE/JPdc3u2/XSxYiw1jtRIlIJeWMletabRAnkEnUZAsdvkuZvm6ZM0mExVAgjo52Di5IljKb/TabOPW3/KLJBpLVVHzHKS2uJOnF5H+1e9LfK/W+nl6fLok1Puco1q7nK+onucUhgYEKwhp2vYoHKg3HklOZHwCBpAN8+MgNcpXV6oJ9A==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34952E8A623D894C7E57D025973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:1XlV8xIU3cmloM6a2OMzKgTN7pJfk2lCTo8pkUJ4K?=
 =?us-ascii?Q?jgA6tMu0aQxSyN+nCtFG1jxFLgbAH0t2ANsGSHcPFQuEKgJogw1ftRIqv36n?=
 =?us-ascii?Q?4xCswcrSgEr6pVKAiA82Dc8BOPeRVFK5SOkorIvOkdsFsPQHNUjmBQ5Pmzu8?=
 =?us-ascii?Q?TA1pHpEv4kR21AK+Tj4vu492U5fQzDkpiT5PM0gss1YprCRhBGpsmJKvx5Tu?=
 =?us-ascii?Q?yFoPE4IJD0mnpUaYplsbhzSJAX/+g+bnvuc+2YH+musgeBUO4SAN9fg5CnQ1?=
 =?us-ascii?Q?2VYrug5MRgt+QcZ828MwmVJWEM8PqwjJ7NDhnzYzvGtG7FgpZsOgwtW30ZLZ?=
 =?us-ascii?Q?qDYwPTVVW+ySRyzRld2fsSw7apK4oo4xfLwfy3ChB4xZwn2ogPwB8PTrfmI4?=
 =?us-ascii?Q?PCrLirUJQw2k8WeKWUbONpP8PXtovbldKB/t7jvlnNbEwzENeocyZGJVxiqn?=
 =?us-ascii?Q?qoO76stw+G43DiYIX65GUnCM2s7lNjVADRDCZWhN12USO371JyZ1kCtXAUns?=
 =?us-ascii?Q?+HuY/Ppons/NOkaj3jiMdmRX0kOw9m1ZpxatTo3ifFF7McgSg6TaboTltlXI?=
 =?us-ascii?Q?j1dWWn/Z3FzSCFuuEOlLlGYTpeNznoyMNtKlRlbeW4IYwIGlqCae6Kg7kwGQ?=
 =?us-ascii?Q?FjH8GX/bSPoGr2kZwlarSIBwP8FI2ORLulRWH3HOz2RF5OpcydS1yB6Wip2b?=
 =?us-ascii?Q?0mOxPxuTaYLzHu8uAU5euJQIlZGv3aiDXv7iyRWHzj5GikVHMdoPSmSFEtiP?=
 =?us-ascii?Q?mSGCEwOtTbV1THUBYs1shSBX6n4FW0icXX2wZRGwGcUlRmho8EYzqOIOR/Wt?=
 =?us-ascii?Q?+0yTcuAdHN3E8dMqg5zJkiuleh259CUWR041/EhiWsdehnXIttbMVP3Y01qm?=
 =?us-ascii?Q?mINcK7/lEGHySfFcJEiGTTX29gsg0/ZNfVhBimzukz/6kqQsRw4eBmEMN8G5?=
 =?us-ascii?Q?GloU7IxG4kHB24Ez7jcF/WMLSpH9LWRgZ8gSzyhfB0nA9gToXf99wHQtBJwd?=
 =?us-ascii?Q?6mFcLq5GJUyteeCbhE0pTABXKlr0ufKyzUMyLv8UZbp2FlP6jTrsjW5wCvMu?=
 =?us-ascii?Q?aE6eQo+3fhy49BTH3oPYw8HNP5vd1xC6s5thPg3TB9N0v7AMYbXNR8lyu3Ih?=
 =?us-ascii?Q?XRsaJRlWNRLwXYpb6EmCUbbhZwX1cJDbb1LULFqoDFwnXoXiiXIQfWGXuKX6?=
 =?us-ascii?Q?nMEo7Dv2b9+G70JPaOeT+XKFQgMVafVuk0LxS4HAJYMYkZCHy36QA0vIqFh3?=
 =?us-ascii?Q?cr9JHfhzoOYiQjK1fnRHD/A5byDmb/aCRAYD4RvXbnNnxfA9SsBpiU1KvE87?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:LhccVmRMPw3A9d0MH83+QEA6uzD2abUjcJnMdyyVE26vh/J4Ut+f526HJFDjF3CQuhHtMiKqJES3pUX4EaF3lcOlpsgd/8lyuLm0t/rSdKK5JL6aZYRUfuqb3nDZlYIA1wm5AX3IFT9veq3ZC723BjgYWQCpBNMZ7EPH5yUKRJ1du4sc/nNCtX7Ifj2FeWta/imaMy6fGoRlGFu2Wa3TCrf2dyXgfBCFPtRUmzj1fAwH4D5ZTKIJBz9w/8i/rws1+S/hAXK9cGS0TJWYufPrvwXUSOo5d1v6du4vciZF9b8amHr0eGsm5dQR5RXVB29Hqnpb9S38gP2ybb649Pbg8Y8UegJ5qu4DOl/k5vkgNOc=;5:ZBRatQd8cBQ6+Pn+hZUMn8xy3Xe+3SKOd6ayP0W7JqklRZXQWa0NswMyWBkilr8G9X7rn/GDIDpbdaDIoYw5UGzT7aXFNwW3uoT/Yxdx0xy+L5TfgB70Xzo7tHdiHjkZ83FirBhMv11hFAHnOob6RHU4u9QIDjkSz+fijxJ/2GM=;24:Q6FW5kSA8VAwEI7Pk0tGUYT6ZnFEjkOsAi2xzSYGZOQprRsnRzYOp6xxMqbcAOaExPVKnn1cUm0vuLi/h64RRcIXTWgJgObIbtXkLQjhDvw=;7:9aqKz7j56VSo6JIsaXJnhmEtQe1wF08HBJ5o9isKQI8dmUBfc43y2WnfC4UlrlU5CRSmiQZ9zGmLBFSk/k2KIm0YD3B8JQVvPwfoYsREK19aEYQQVZyCCgfUrHbK0Kvnwrtwblr3p2R+xtJC7S3e+vrnmsQd1E/si8NmrL25T/r5UlLqvKGWsTKVawR34xh5NEdBVgHpWpqK5Tsww6zFDSSAYZbqYRLsiDT34JQ1C15fG9pnddMzdtvBtYBuS/bo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:18.3578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71844620-5e68-466c-bc40-08d536c42713
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61174
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
index 204a1670fd9b..ce469f982134 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -87,4 +87,12 @@ config OCTEON_ILM
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
2.14.3
