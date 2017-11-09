Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:31:29 +0100 (CET)
Received: from mail-sn1nam01on0067.outbound.protection.outlook.com ([104.47.32.67]:13737
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992198AbdKITaAOrIZL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:30:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YaqHtT18DaOUPHmDbYJkdLXt897gnJHyHoXgzXbu2C8=;
 b=Mge8p4yKus0GPiZQUYUE3t7VCLkxVIHST3xbVGTT5m7IrfIWRqK/RUE2xNRm9dLuY/IdpBUgEx/OPgUr/hkLndTOQrGkMEzxStNh8bIBz5erAP2jayKaGAue5pBrwwkhWernX6apVZoCjLIVTtD+QKQeVNEN2aP6QZrZXnCDmxA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:44 +0000
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
Subject: [PATCH v3 4/8] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
Date:   Thu,  9 Nov 2017 11:29:11 -0800
Message-Id: <20171109192915.11912-5-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f96beeb-91a1-4ad8-667a-08d527a83ed7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:9lK/e9auypPnUNkSLAIA10UgNmBxbBCFy3RCMXgCCnjzFw6rtbpVvFpw39A5IVOg9EHF09m8hPKn3c0+krZ209BOS3y6ar29XR5UJmVGfshiyevp+PgoTNMAorK65dHYOUmrDJzuTkY1Dgo7No4XUMmg0BER58C1jhmGBnEqzvdCyHPHYT0+9zKLJQWEsm7an9NZnUrbWr6ugj+1eNGks7l3IYtddXmED7Q2fNNU54A7VGqYDKwKnmFXlUMNlYpx;25:zvEvrdC78EUf78L8Usi+GYE9iji2+h4uL04khiXsAe/wxrtYqHcwQ4ycCA68fGgukyV1a8L4btzY7PafVb+ErwzA53V3hXk3/Uuwg6uS6SZY2/RnrUMD+Z2rKPi/hUyu1XBxH0x0GVjFwp+fq/MlVG6ssvbuKl6K8Jd7J6yelrbjCkCiznjKb6JVO6WVyOZZacFlCDiiVmREKc5J8PN0zuRanbI9yTI92MJhO0dkjXtPJLptdY103cCfqOYwlRHI4MXaNBfA+ozcuSr60klhO6yat8IzW4eHc7vTQEUpzxsCiVDBLNWYROnpSFhkoWCLCuNqheJiEjwdH/4/eYwkLw==;31:R2BSVO3D1CRAq5X8VoyfFy1hlHWxgNxiFq8jymXmNaP2uD3k3geSeDSsuoV1o8pL56hOJUN7WjvrYfuNeYoQ1cPhyw6JOTcHJjJN0ar0OXzrvYlwFt+GHeZSz8qYA2RtceMNigfpdrZe1kYrkta2BH+v4PhRqGXxpiXxxnSzlgCBkyKvxi139GGJRwayqgumcIYdJQpKHCWSLXk5Q87R8oegkltCrQKGfEz0aZROhZo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:1IZ/epZq4Mbym8hQZGXEbLgKVWxRHCFQa1BCn1z1KiE883kQwWqkJV/1Bx8X94WhuN0uA0kKwApdmjSmP8mu+jSAhw9gOktwYo04ljYAFvC2mGny8LlcbA7ub2faPjztDdIEE8DzxU1XPgvLEQyxoG8RUZsoaXKPLvnOAU5K7CEY9eWtaLOOGwQZbl9QEyWIMKKllAkoaeCOJ/7SWLdyHtRgU0xLBugnFepQatrA/lYIydVLSOCvUXnx1rxCRAliWBOP353R5EgDSTDOorMI5HW93xuMyYU42hlrIzI8F3rJByd9+Cm6zuOATYzhflPJnGdP4ylJISyJ8ZYe8xEW3pWfiT4woYO2wDnTmGmYMV+tCcfBub2GFYdWTtlU3DZSQMdcKOUykuN0wHPZy2Jgw7aFhtwX3GeJtaIRvvIWsMI0KtOFU5jdxWvvtIqRSg4ChxhVyykIzp0YGJ8Dkweo/XssQUMYHopXQNTV+rCpIN0bWcBuTGdGFoRuyPVysKDg;4:5ywRlrGUkOsoiaEOEjfcTuhRuY4PbbCvcdHeDC36cRIltNMJ0vE/O9euvHF4HKAlpFjmzyvbhfKHxvQiLixzXtBb/PKxL7cJ0IivLFqyAHN+9LmrIB4qN9V/qklZhmE5QFKmfbL+6J4Wri60Zu8sfnLefxrLuc78U/ZPH5/mCgqA01+fbSEbB0YGks1Xphm8tovF40rbM4u8qJCJ619ynUjFjTtTkEbqiQnFqHCWBKE/RgIyOoGUuhf+h1OBTT0UPChXFvqWFgByR4uwyDr+4A==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496675A8E8CA0896402B52597570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(575784001)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:Rwhh+MlIWeBIDY/qMfL0vWIlMhE9MR9/yPsJNgA1j?=
 =?us-ascii?Q?jE5KpFJbr1zkJyLHNoAQBHr0G0iJN5da4a1oB0Ge+vCzMYgyLP8l978z7FFC?=
 =?us-ascii?Q?yIaTHQqlxhAlyp+2F/tOUpFrguGO/JzGrY/0ABq/bJFYXgZrdJERKY/ArMSl?=
 =?us-ascii?Q?g/uU4lqLcIwdqxCy99cz0Ut2XhkgcizMNvjFuy4PmJz7/STUOeHXLgikW0Vy?=
 =?us-ascii?Q?CR+sjbwmm5h7YJoKkOy17ADLloavueFLbBn+5+UuTAvMh+yCnJgX8WV0/Gir?=
 =?us-ascii?Q?4l8uJ0Da7epIvuYyJEDRx2+aPONyQEESkFSNG8icNb7b4Cy9rgbe6ZaoxKX0?=
 =?us-ascii?Q?8weLh6MdC2vaFNA06oC8LH/4P8geeci/7pyM77rZHOv6gDeRbLuTHdDdDXQs?=
 =?us-ascii?Q?o1EnEDRk/6B4RmM1ctrTg3atxmQvGpiyb2idqz3276swX8b5+wurS84RwIel?=
 =?us-ascii?Q?3dBwDzJ48nTyN3v41g8tDoFeWQNBqfCJGiIKXGNGtKubFUpjrmjrXILY7AE4?=
 =?us-ascii?Q?ppKHE2J01UPqI4iNkgM69oGKAaUMFIeUMX0JvHVdXbnNNCHEwsjXHqIKLVYh?=
 =?us-ascii?Q?jMJkTEdDjn2KeAB6vq3PkC/7uQTmBbU7JP3N10UHbRWxxyH8LPlIwTeP62A9?=
 =?us-ascii?Q?N8IhqNnzoxM6xRpP3D+Z8E4tQn0lPVETWPyY1dRnJTJ5LLZSfCdEq450mykP?=
 =?us-ascii?Q?8xJG5I1+BGaSYE5Kr+t0Fy66QUR01SBq5+NYu4b/Q3w+7P0aU+1RVrbz+LN9?=
 =?us-ascii?Q?wO/dNrW6whkyiJy7mPuSu7NxzElHE9GvshUej6y2pZjnlURobj/4I6CCudN+?=
 =?us-ascii?Q?X7gPeoUPf6kxKaUg0d7W9ZfkMwTroAceGZ9RP3ks7thrKTMKF7D4lYLagYtn?=
 =?us-ascii?Q?XmNRBX919rF8v3IUzwI4MyI2hHjmdZ7+dMM3+hZd1fS+JoYOp9EH1Bu4thna?=
 =?us-ascii?Q?mAzGReyml3i9gsN024XJgsmsXj4VbH1Xg3mOBcBAjQ9oD9M8d7XlTO+N8Kgu?=
 =?us-ascii?Q?2CXQQsY+GRJeKMRUS3p3PJjkKU70I0e7HIExn4reBfhxDPOKVxjvcXu5Vx2I?=
 =?us-ascii?Q?tPXLZrBGrF54Z56s+M77lNheWPBnHZi5sWe5839a1uzjpv1WMxpq/RS+m3AW?=
 =?us-ascii?Q?MLLvjq4zglMV43SFJGkVHJV91hKX37d697IshX2uX1DjIPYxwXaoIJeHllnW?=
 =?us-ascii?Q?kaWSXTI1qXTo8XDUFuDAyGPnk/8rTy+aVe07Lkbb4yZw2j6UXNBFFweBNgeD?=
 =?us-ascii?Q?M33sBSr0MWZM403NXyrKolFz+YuUnyeIeNLAhOV?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:jyOWz8Qv/nHS/2WUekR9uSEYykmNA5h5NDlYRkcsQ2iLwIKO0Cj+YOO0iGv/bw8fLMoORapV9xkUGdIy6IF4nOiqEtC686aqn0GRY7rAd0yYydUTOCNfFm3C8Z+k5SJwD7sgls+9AvA1c/iRwU0fKIE6Giuqi9YlzQ8GKKuGxg0y7JKMajrjsFH+SWbrEjo0MBHewzVR+DLRerfEmXKDTI3mNqQIsyHlTyPSCnWQAzfwdkuZrT9upuA7CpTXhbq8roD9yHaZJXHOqZ/2Tm6jh8HWk0PwimpHk1uUjWAN3tYs8GItR/mmLvcbeeNUIpzM8mZy25H14h5kk5uczxhq40haUk7myEOqjynQPbLf62M=;5:Kto0tykvqKnHAKtAtM2RgBpHDxnjjFjS9swPGocAflUnG2NivL5c57Y5Ifnn5z8hud9eixsEn7IyMnIWxxJ4PVU/yRi31PI8BPUT+tiTv5kWWGyQvSzg04h3SFj67zgdob3ynIzpK7DWZpxn2OvIoy+tf3Jggttkyfn/paA3Owc=;24:VvHqn6v2CbaPO8yTOP4PxBAkXAGaqxysL3DBOQHCA4TrZMu3YKBzvIYay7RxpME53dbAfDq/dLWgFm2Ahbr6Zl+o1O71wHsGtCRMSzp8Z54=;7:lHEwitxI8BhqtxU8b6k/1w9FXIyUf++eA1yMacH4RZ7uclYscyOzAp6/Y9xW+Kzbyxs09FqICs5GQXLLittAPYLkmvfVzhrjI/k/3jEivAI6TJWYfSsWXnKycHpjCJftMVX+KH5zkTxLiSKFGzOan8DK2Y33zjnXDxmfNo6DAA17HGbRZBg3ROZ2nFVXwoHvL8r57OxcAUJ7JnLOg95idPRO6bbRZLG7yDxUkexyqN2QZycet4vCxEicciHq2nhe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:44.6023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f96beeb-91a1-4ad8-667a-08d527a83ed7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60819
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
