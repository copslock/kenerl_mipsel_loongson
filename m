Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:20:35 +0100 (CET)
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:52096
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990492AbdLAXS7z7pes (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:18:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ank6pxqWOwH6lj6U/9Pn2RgXc5L6Ko3miw4f8/4fGLw=;
 b=bI+IGYXNVJpR9YZ2Bns0yCW/1+ptF7YJb77azZ9Z2rriCEkI6YR6VZ6OY+G5v2TrowTghg6Uhz2AI17jLB4GIPP0d2BE1+a2NfzI88mvhAck5liUMJZFhkhY8iC/sr3rSqASIwzVgwbaWFJwulW7kBHlw3LETcQaO4pE0D+mHFc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:39 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5 net-next,mips 4/7] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
Date:   Fri,  1 Dec 2017 15:18:04 -0800
Message-Id: <20171201231807.25266-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 133b1ec9-d7f2-4b3c-708f-08d53911de86
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:4PilALgDAG376/hSVm9b3TNAYW6N7MASNh7xLIuyGbsJQIJjMcRVHoaMBl733k0zNGKrPa8M0ErPAlX3r1XSWlJEXKiQ+zdmRO80+we+R1h2fAdHXK8723Co8SyNTyhw0Bb9EqNRaaF466iCCeN6kNLQzKFLkESUmI/6iKaD/PgbKfuAQDekgy5p83mP76BZ/8CnzE3J98Gorw4uC9cQ/v7pMpJkV5ybaI/z7SL+xk515cGLaZfH3s6q0PnNxUrr;25:TDwVbolVlz+XAln7ePIBHC9oOXGtzkWr7et5rtX2UTOdoKNUeiVXroNjL8Ywfl1ID0ogxjlajVUiCg5qAjWPVXJ68OMvj51K8WoEkH/3AZymrWLAq+tyY0t7FzTAv0EBFAJVhWkrVPaVn5+VCqsV3x+EEFoe8fe3dNYHJtY4PHdqmvKPydR+S6bzW+SL48f/jzImyXkJkMhepN5yv2l6z9KJuX5fwiAEtMtsAsP3dTUnEgJ67rQGavirvLv065L5tpcxg4JBlGiNdpdhtkMEKDEtsw/fjW6tMDbE7oLxZuJQNq4kctEvDiu+Yk24Ff3BqxUT1ff3angfobD9OXQn9A==;31:qO1XD++DLT2gySY9d8zpnnmE2lPbR11A13uZLRQMmSCpxah6LqwTAt7i7+AwLqmqaF8M8diCi+dqaOfXkDk3FQHPSEZw92O93Rz2Lej65Rm6N7FTWR0wC4nALO1grKGLjTfu49uxMz+E+6v/FVo9iTSulcusgwgvtc+oJYv5FSeVz8s1P+NWIK6L8QP7/G236VbdFtyeWoRn76t2lIhkCYHhhuy8/SnmZwA/iUUGqdY=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:gRZTlV33Ur7tqmfNqlgP73n8R8J0cGPvZF4vKlQhepJhByHrOVEo1os1zQITTOMzv5qf482adk0FHgH7uzmBxDFYt24+U0P+Xv9J3+XKSnB7Ue933WTwRBxugUcw6P8hJ0KfTa6s5mCFmzNkQDRlPySnb+7D9ic6uz8jjG3ijnA7R+TZRurYKExJGT0jC6xQzveQZPYlR734iQTtregDOm+Tv2y4Z7BRq0sy+XfIGiYV6Bb2jPIRzpgwjkW/f0mesIK5Wgur0IIz/0Y05bmaH4IKHv2EW+5Op0zPRhKSlol6sDd4gubMZITGV9MC2K6bFE4eZ3My3P3Z3WXHUMIKaRSsg9uDAOccO+rO0fl+v0lqxNgrjgSUYm+JHa4o/QLkkdZzCbSEwal3zsH0rsl/Y4G4w9PTJnjRbA3T5OdoW3PgBk0KvOrU34O8PtxH3iB3gkVVGkLzSRAXR0FfHU2lqybRwl02vF4tylmxabZ2YP8gq46JFKNrryEVthXITw0Z;4:8Zh7FtIdziM+w5863OAAbOOahgbHJcOwmYWKV0r4gkBZ5eX21ge4ITDPipLwWQjb+OLgTM2aXgiHhR4+ZyBs7cEGSth6rmsXbbP+ojVO5Am3DS5DeI9qEtm4S/TPK4aNZMZzjYpUKKPVS1coc+6Vjka8MHgsviWCLs8odhWEpdvkTps73ozpmDOuDbmGkmJgZR64Ja5hcCDiD7fie2leMmdtnR2MZJZZEmQkka6T2t4YRekClzVsrz2BPEwL3o8JogYktXxM79u2dd+wN2KtYQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB34992B690A2BEA405A762FC297390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(50226002)(575784001)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:+Cv8OUpzUZI094hTUrDUjFrQD8Q3EnmBYs+0nmDII?=
 =?us-ascii?Q?uuU6lgCzc2kKxUDzeBXpCAxzG5dgglzNnVfVhuN/yPJG/45Hun+aLJxfgXJo?=
 =?us-ascii?Q?YMOl3h3Cm/IvJD1DKnrbztlX4Hmc9riXxZ/85OaLY0tD6JWvU8FpApbdB1Ir?=
 =?us-ascii?Q?JIbRJVzkVEUWOftDiXb+i+uJqvBesvAQNV1QNpBQyVkWCPBYbBsYhsmRKdxr?=
 =?us-ascii?Q?7HSpUO2x0A//mPzhbojW3TOQRrc+dFky77TVtQYdHkw+eIboCP9p7vmhBdkY?=
 =?us-ascii?Q?Qu1XtpeKiw4eVutWmsjjsBkXXA2UblO16eJJJgO2OSaMmDYeUJCfDJ2BKqVR?=
 =?us-ascii?Q?L4De2g5Qn9pPUBOE7PNGlLuuXajlmy62Ay7i+Ci+h55meeP9d/UE9SACupxg?=
 =?us-ascii?Q?y0NUOWTez6Cm7QBmn+Eumq7zh6KW70mTE4rRe/IgoJMRGYgMNWkOocOnuQIn?=
 =?us-ascii?Q?XRn7z1No6iytlRUzAkJeLrBd0evaXsdkv1LWphPjjgzy9WRgSA+pOCLkORwB?=
 =?us-ascii?Q?hxZR4UYAunVI5DyyqrHWY6ydVx9r0clQf/OvDofzjTlTZzM+4++TQ6RO4V7c?=
 =?us-ascii?Q?77yYo/iI/1qJ3LOVslIWypgYpthd7xw8OB402fHRoJJi8sNogQgmi7DeKgwH?=
 =?us-ascii?Q?CFxiY299jBIwqzp49Y/ksXsXEeENI10HpoPm9EFFd9VXiGkgQ7cM93TWjsL0?=
 =?us-ascii?Q?+OgIleTpbPFjutdfBuF5RNR62aG5xmEFHILnLJ6F5KvitMD+vHWWruEpbpx8?=
 =?us-ascii?Q?KinTqNfFewxDd4Elh5Nj7G30niZXEw/lVn+Bx79mEE3gr0+ZoVpPBt9NwOCx?=
 =?us-ascii?Q?y3nZga9244jnlFmOoRVqHOMA5l7YwZ9J/3d29J9w7Ufk4+KtEGA4GLCD0zJh?=
 =?us-ascii?Q?9NozMXrmk8DThrmnuejlxRqmL488UWezLqPPVZ5ha7AbmXt/Laqw7hDfbvJs?=
 =?us-ascii?Q?lx3HWh9hYaQqYRdjwyqy3oG8SbjATvAlfS/9SQRTJELh95crnrLP9t2pipZ9?=
 =?us-ascii?Q?DqASXZmCdrhGuR8D4RbMxZ6lKQq1MUslGnSRdbaXIZoqn5vKQb7cLPC9TSIh?=
 =?us-ascii?Q?j+37ujQsMAm3XWrtrwqvljczEDdN4fXI5Mr1U6q7CpnxnJfzXx3IyDwItNEh?=
 =?us-ascii?Q?YEPHFHaPzv1SsL/5T15HR9B13twqvN9KV9NbjvZdPhoOzOECpjJa9by0hX2l?=
 =?us-ascii?Q?ctvy2r/Lv98GysR5mEP3mNeX7uMXVd7FUJqUWKf4N3HrjeKk1lEUr0AH2hoj?=
 =?us-ascii?Q?L1e1UdmNabk8xV06329k/7q78GxZEIRS+98lEyuuFotwpNjQC13CO+20XKnS?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:r29HMLjMXiEmC9UXOEi0qSj+uaU3G5gI1WFfzBpxUB9mLm3dCPsuCbTSiqW7PNU1+Tarlx68HmcngvbpJfUYe+0NdIjUqlLx7pmE9fzMsWQVN3U904j1EviS9mTqfuGRM97/z2dl5wyo3/VjL3qRUtS5hcGF7LUVu2XZ7I6YgozItPWlqFWwhCgsBl6nPuT0kE8wYr9sswzi+/ly76aIDN74ersc5d/UQRFSldqAKxXLUxgtuGL9NkMIO8QBkFk0cjvRVkGwgzXekIXYr+Lndam9tXvjpPkLC1NknJ7laRA+/Z5Amwdlg9AIaW4rQXiTfDKQp4dDMWC3HE/CJEiq6ZGIyoTB9bMbUYTqy9RTHv8=;5:EPF9GrLfZhBOMg4SjtPiNgd+O26zGtuzlqhcRPEjn+R372uyXQnp2BejgHIlVD/APIEs1Gamm2E9dpVxlcPXexV+wmdPq/MWQhxvJcq4e0Fd609+geNOhevg8ptZGs2okKmkUWQ/vJc/fB4jF18TL51Hxjud5lyK/PNwfX0YIIw=;24:f84qxC3uR+hqhGP9yoM4/ZgPD9dosoaE0jg0z+nBNDL7gSGmZK5LY4bB9wtyogOzdMBsKPAUcFVcUIksR3+2wXpd7GYMTtY2T/PQoe8D2Ss=;7:KKznyuNNjOd5XrhzHUNbtnLn+YLtQjAxwjLcc+KhPDK4JPjdIrH5ZfB5ZYVYvfRtOxeRsI1BfV8nirCvGn4AApl75aEAejURJR66nBhwjO6WsgC5YM7r4b4NxR9nmKywFaF4YDu4q+GE8rAaRNFseOUnMmhfwRnaO4nppKhqEy36Se/hP7wXKFZXa32xM8mhbKcSTrcrWTCrXQuLd8ZVvoyQo8Jz5pG60f4bw1+Ob87ejbXe9lURaLSpMEd8zX9g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:39.1965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133b1ec9-d7f2-4b3c-708f-08d53911de86
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61273
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
 arch/mips/cavium-octeon/octeon-fpa3.c | 363 ++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/octeon.h |  13 ++
 4 files changed, 385 insertions(+)
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
index 28c0bb75d1a4..9d547c2cd77d 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
 obj-$(CONFIG_USB)		      += octeon-usb.o
+obj-$(CONFIG_OCTEON_FPA3)	      += octeon-fpa3.o
diff --git a/arch/mips/cavium-octeon/octeon-fpa3.c b/arch/mips/cavium-octeon/octeon-fpa3.c
new file mode 100644
index 000000000000..3f0c10e9d915
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-fpa3.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Octeon III Free Pool Unit (fpa).
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
+ * octeon_fpa3_init() - Initialize the fpa to default values.
+ * @node: Node of fpa to initialize.
+ *
+ * Return: 0 if successful.
+ *         < 0 for error codes.
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
+ * octeon_fpa3_pool_init() - Initialize a pool.
+ * @node: Node to initialize pool on.
+ * @pool_num: Requested pool number (-1 for don't care).
+ * @pool: Updated with the initialized pool number.
+ * @pool_stack: Updated with the base of the memory allocated for the pool
+ *		stack.
+ * @num_ptrs: Number of pointers to allocated on the stack.
+ *
+ * Return: 0 if successful.
+ *         < 0 for error codes.
+ */
+int octeon_fpa3_pool_init(int node, int pool_num, int *pool,
+			  void **pool_stack, int num_ptrs)
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
+ * octeon_fpa3_release_pool() - Release a pool.
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
+ * octeon_fpa3_aura_init() - Initialize an aura.
+ * @node: Node to initialize aura on.
+ * @pool: Pool the aura belongs to.
+ * @aura_num: Requested aura number (-1 for don't care).
+ * @aura: Updated with the initialized aura number.
+ * @num_bufs: Number of buffers in the aura.
+ * @limit: Limit for the aura.
+ *
+ * Return: 0 if successful.
+ *         < 0 for error codes.
+ */
+int octeon_fpa3_aura_init(int node, int pool, int aura_num,
+			  int *aura, int num_bufs, unsigned int limit)
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
+ * octeon_fpa3_release_aura() - Release an aura.
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
+ * octeon_fpa3_alloc() - Get a buffer from a aura's pool.
+ * @node: Node to free memory to.
+ * @aura: Aura to free memory to.
+ *
+ * Return: Allocated buffer pointer if successful, NULL on error.
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
+ * octeon_fpa3_free() - Add a buffer back to the aura's pool.
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
+	addr = BIT(63) | BIT(48) | (0x29ull << 40) | (node << 36);
+	addr |= (aura << 16);
+	*(u64 *)addr = buf_phys;
+}
+EXPORT_SYMBOL(octeon_fpa3_free);
+
+/**
+ * octeon_fpa3_mem_fill() - Add buffers to an aura.
+ * @node: Node to get memory from.
+ * @cache: Memory cache to allocate from.
+ * @aura: Aura to add buffers to.
+ * @num_bufs: Number of buffers to add to the aura.
+ *
+ * Return: 0 if successful.
+ *         < 0 for error codes.
+ */
+int octeon_fpa3_mem_fill(int node, struct kmem_cache *cache,
+			 int aura, int num_bufs)
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
index 0411efdb465c..f36263c46e60 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -10,6 +10,7 @@
 
 #include <asm/octeon/cvmx.h>
 #include <asm/bitfield.h>
+#include <linux/slab.h>
 
 extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
 						uint64_t alignment,
@@ -364,6 +365,18 @@ int res_mgr_alloc_range(struct global_resource_tag tag, int req_inst,
 			int req_cnt, bool use_last_avail, int *inst);
 int res_mgr_create_resource(struct global_resource_tag tag, int inst_cnt);
 
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
+
 /**
  * Read a 32bit value from the Octeon NPI register space
  *
-- 
2.14.3
