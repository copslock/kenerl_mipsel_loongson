Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 08:02:49 +0100 (CET)
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:65460
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991111AbdAYHCl3SzRV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jan 2017 08:02:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y+ZPJUb7KVh5KnudkrM0iBW7bFnZ2EemigHXh6PfdeE=;
 b=CiB5pTtXMucpuKsXrAY9SjQME7sSbwWzCG+kk2Ix5Ybl2M/l/UGhMdP3D01uZ7k0xH9jQwuisEYOdcBRrxiJ0CQ2UzRYF+aKzI5Vg//dPjdj4N0aqC2eBQIlQ3mL3zVdFqQ0QzxGKRP/OtDBB4zDfNEnoJYxmcpslZN3Dx9YpN0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.13; Wed, 25 Jan 2017 07:02:33 +0000
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v2] MIPS: OCTEON: Platform support for OCTEON III USB
 controller.
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
Message-ID: <de5a465e-9218-5288-c643-d0df0792baf5@cavium.com>
Date:   Wed, 25 Jan 2017 01:02:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: YTOPR01CA0071.CANPRD01.PROD.OUTLOOK.COM (10.166.146.167) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-Office365-Filtering-Correlation-Id: 2317dab7-9cd3-489b-e0cd-08d444f02358
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:WX/vs/oNoVyuNSF1a6ni+njBdK5ErK1i+7t2RJPNt6iDWCzv6Y8VR674/mubf58um669yv52+upPCyqXn2VOjKo2AQau5YViBrfItDxj5B9MzsuvdL7HhWsjaVxl7jfCr1NXbxCWKSh8yYBa0j2ks8oQ3YuZkUQm8/R5OKCgR3sOlX8pTKK9GhtUbUdPCRrsL+XnsircrmuBVvkz4mC3DHXlCspR8F3vvc+bAyISM4MFoPuQ0gjdNzoz5q2/loK5xfdXXXRQuy+jXZIFUzWuDA==;25:cIUns8dOfOy8inK5p+iRlr2F+877zsMhEzdryfLw/lFpmPgG0CelAdYugGRN6x4K4csgsyDzf+3jBxabsmuOb4dKl28xkVzeezx1Im786zK1N7Pqy0IMZbkO/13q9F41hFLn/CWElVUiiI1uU6IM+DY7tERtYlBjpbM9S2BZbgTE/auz8BcG8zFXuAQID+Jd1QHFIA7iRHxnNjx+IITXqP9vrnFgfTeAYvQZ+3QZeK4jjHoA2VAH3yJCqcjM1R68gxMwkAfhD+tKT2FQr8yiAkpwxGUDONIB3uc4Kuvdk7qyBV/CLwKHWfg1hbo+Z5GPVgyJVDoARaCwKYxhiRSj+MrIXEZvNAAqIIV+aCFbt63jwWecuVsBL3+rx7gQ4PrYPdRSlmar8jwGB7AOxjqZaK5pUZhllA/8gZ96GyacuZdNo+7IqWkX7WpP/CMmmsPIQzG/SDM3oRva1iMXN/7dgQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:CHIPud1emvsyhLLMSCItvhAxQZ2B5RVUyAA13tLwiWmtdGmvjYpP5+Rx4D6AfBnrGigybO1jzLEPnOifI1FnyVhb7gIRyGs/RfrENmnNpZRgoALbUELjtyb9V+HDOUPiSmX4jy4BVEHC5x3mokLNjaedHMJ/rbJtgCuXfcxTorT+EugAn4eJ5xrU5G9G2n2WflqUELl8IM0bT3vFhxon1g2aph0AqcbXY9Ej/RFQIKTR7fg7ptlELkAEszgbdY9cC/+m1Eg3udRMTIICksOy0A==;20:4AceKAR67lNAjC3mD3xoLypJsNXuDddsa1dblAz3JsXGtDQctDn5NzWhDxSJz7uduh/2h34ksgOSLWaJjPe+w7psKB1G4N1ViBDckme7a6zTCJsKhYtCjogi1lhXonpD2NGn8sk0fqoaUW+2uh6DOh2/i6Mzb5mY+wBFBr71wBsmMGfNpRInJjQvqIG4vO8jIfKc/4kb8IO+c0mU5CyzxgzAAO3D0ptbgVCw8BQGxN6tcGMCgOgvFagaWmQkEOghla86QemYGTU83OrtqAukDV3fBzS3FqAeLNq+5lA1+S8e/9G7GxtqMZRABtE4ZNuTZIOJouLA2r6Rfixc582EVpiy+ky9B1dRLsxrWgDiHC6Umrxq6qHy7UrEwjeoMKa2e5YjvMSq8gR7ljxRfTHE9TYzQxm3LuEXRkab7NyMUwGgXt+inc17Vfqye/K0uMdBF01wDCQw7E4eTWJvAgyUzSFhoT4hvwOM1SzL7y+AMrEM9WUtjXwfQjxRgr+71+u7
X-Microsoft-Antispam-PRVS: <CY4PR07MB32066F778AC4F291C1F32DA480740@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123564025)(20161123555025)(20161123562025)(20161123560025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:35/ILjZySs+obdM6yOKtmJ+HAHxoZJI39Jm8k9mPo46cfS26FyesC4pc1mqEC5mDDrP2En9dVHpk0qozt8+9kvckmU08nOjJMqbLp3RzZehfqEYVlNl9D36EyMaUG488jebpqb0+Q0CNqFTMwtSAjmZXbl+FIgzB8mr2qMPdmh94/Z9lCJQb/o69Wc4CdkAlLYYOoy8tv343j5qdRPLPBVGtqeipSdnNquPNSqkj6oPRKhaBIT5AQThIayAMwF1+7Mj92UQKSQcY8KwlHRAlKoVMYccW3C+5oSbNDndgUQyRhb378T1EgP8jGHykc1kl63Pd+IlOywLMNPkIli4vpbuee5mJUteBCUTCrR7mxXZOJgx7d8Djclvj9igeKklvLVTENN+PLoKFJjCNky1e4DOzhXEUH/D+zWG++UC/h1tbQ3z7dbibE+Ft62oe2US0Fow2eyYR5c8wVl4g/SxqoCN6YdN+nqBMeMLm24N5QY2dUxorZuo4dzxpAis9giPRndSRNsR0oEzmxaKEJ+cMi07xvtajJJZHiCW5vi/P9z0shn/QGVTrgOG8lvcd4sPg3+DjOUvQ0Td5lkWbcAP1hw==
X-Forefront-PRVS: 01986AE76B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(39450400003)(189002)(199003)(288314003)(97736004)(92566002)(31696002)(4001350100001)(47776003)(65806001)(23676002)(65956001)(2906002)(81166006)(110136003)(6666003)(189998001)(6916009)(66066001)(81156014)(450100001)(105586002)(8676002)(5890100001)(2351001)(42186005)(68736007)(4326007)(106356001)(31686004)(230700001)(305945005)(36756003)(38730400001)(7736002)(77096006)(53936002)(3846002)(50986999)(5660300001)(54356999)(65826007)(6116002)(64126003)(101416001)(50466002)(86362001)(90366009)(6486002)(25786008)(33646002)(83506001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA2OzIzOnl3ZVcwSVk3MldBY0d2VXEwVGZZT1R5Rmxh?=
 =?utf-8?B?eGZtUnRqaVJaa1k4WWxJQjdzVWFZOGorSEpNTG1tcjYxSUhERUxsWDdBZDBN?=
 =?utf-8?B?YWxEcm51K0ltUE5tc3NiZml1VnN2WVE2ZUZESGx0MUhpeFcybHlhZmVLdmtE?=
 =?utf-8?B?TjJJbFZKU3NpZjBIM3ZNUjQ4bzVHSGFSREFRSkxORnhpY3dqYUY5RTJ0NGxh?=
 =?utf-8?B?V3pSbzZNai9jYVVweTJJQjdGSWdJcDRSUHR3VmpJUnhwTXBJMlFGMW0vRDNQ?=
 =?utf-8?B?cXJ1dVRnME5FRVlwbEtwbFREVlZ0eWlKd0Q3WUVuNnIzWFdqbUVNTmZDS0lx?=
 =?utf-8?B?ajA5bkE4cEV1c2lTV2YyaUFtOHdRVGsyQVZGVFRvcmtqaHJ0b00rT0hZWFo2?=
 =?utf-8?B?NHVicG5xVm9LS25US3Fsd1A0SXl2Q1JFeTFaQWE2TEJHa01KcEN0MU5tTTM0?=
 =?utf-8?B?bkpJTmdrNHJKRjB3QTFWc0E1bXppbmVNUnFVQ1czQm0vdnJOZEloMDEyT3Vo?=
 =?utf-8?B?eUlSaENrSitqbEhmR1VYZ0FKYnhvSEwvdzRTWnFMaldwZTg5NzB1cy9Yc1J6?=
 =?utf-8?B?YVpKckQwWG9xbEVEbFE0RU9Oc1FNZGpKYVlKQWVJS0tKZUJLY0U0QWVoTmFk?=
 =?utf-8?B?ZUp4d0JRTjQyN3VMbm50OXUvMHNrVTZOQVIyTkZ2MDB1WFQ0cVpaOHkybDA2?=
 =?utf-8?B?WWpuQUdoa21uZlpvVmdKb3g4Y2g4U3I0NDQ5OWVUektSYWU2c3k3d21jd2k1?=
 =?utf-8?B?RTdMczJ3WGg0dXRHZkZBbjZKZ2Z4ZkFyOHozN3RaeEJtOVMraEs5SmpJOXNH?=
 =?utf-8?B?ZitjZHpGY0xtbkhXcDdjR3N1QmlwNm1EenVoVnNIbFF1NzEwK3FNUjkzS29m?=
 =?utf-8?B?WHlqZ29Vanh0MU14TGYyZ0VDVEk3eVNtdFQrNVI2bE5IbnVJSUJXNjVhclZR?=
 =?utf-8?B?QUlqeW5XalVvM0tTUGxXekVnL1JUYTRHeEM2bUxyTSs4czVTSUlLWWJnWFJK?=
 =?utf-8?B?VWIxUGo4NTBuOUp5OE1tMnYzeVVSN2pZTHhpS1RNMmRydGhPOFVFb1hYWlJi?=
 =?utf-8?B?NWwyOTJrMUVaaEdRNldLQitrYXgrRHplb1UvRW4vMUJCaWorM3Zwa2JyZ3Rm?=
 =?utf-8?B?TjhJOGlBWlVjMStOQXR2ZHM2YmJ0bHVMNEJBWENqNjhlQTI2UU1WdmxWTjhy?=
 =?utf-8?B?OEZVRXR4WVhEZ28xWXJ5NXpRTXhYa2ZEQTljRlNjQm1kYTRUdTNrbk9aOHJi?=
 =?utf-8?B?MzkyTk0zWmlQUXE2dktZQk4rSGFWZHRBWnB2L0huNTBwcXF0NmNsdFN3WXNX?=
 =?utf-8?B?L1BReTRQbmViZHlEZW1nSTVHY2lPNmdiSUQybVJEaVYvQVZRbjRaZ1JrMkFR?=
 =?utf-8?B?YkJvK2d4dXpyanJzS2NWY0hwaTRyRTFQTEV4RklwRFJPTzFsS0pEM0FMMEVM?=
 =?utf-8?B?NndrdzZXSEgzUE9jZ0QyaFAwVVpnZmJ4cXVQbmdHTkM5TWZHN2lYY1A0ZGVh?=
 =?utf-8?B?WjJIVkdKTE02eFZhNFFmeTBpYUI4RnNuZ1gvN2RvTDRkRHRZeFdTZjlreTRa?=
 =?utf-8?B?dTFleE5OR0QrRDJvN05jWGtLT3VpWjJlWEpLakpCS2JNSUd2NUQ2a0xnSjZr?=
 =?utf-8?B?VzBGdEs4WWtFWVhXQlJkZk14VHVKV2Z3M1l6bHZjRHJIV0x4czhUcFE4ZXVC?=
 =?utf-8?B?NVlMNzRGNnNtT2ZIdzd0b1h1TkNud2UwSFl1QmQwalZORGdZa1hOT2JHZCtX?=
 =?utf-8?B?NHQybHErWUVPbUkwREN5QkFBSXFwbGxydlhDOXJIRWJMamNvL2crd3kwTGY0?=
 =?utf-8?B?eWhLd0d2OFRsa3VUa0FvSVhYb2JnNlZOQkJBbEZpc0pLZkE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:V2uMpNowmbPpZjBGISdXd2dHOvdIc7iqUI6hyhGwkxTpBNCAu5ItxVvss7xHSvr91uV/7O7ZnUw5p8flZrFMznpRu92Ez4ytTTdtF0ut8aU/xhnNzipr621QO733yJB6UC56WjCIUeAgPy6vuM7oBpPEq6J7/aEKxApMWn6KesfUQ60bgxZf7nvUjBDsP/WfxeXCpJgDOXKvrutj0Wq36Ihe9bWn/ioWhBNwaHnb0BxF7utCl1w61LJAtfC+gOHnxdn5QIaDMHRyYJmxNTikpg3diM16A4qpyUpVP5ClA/CmthKHoad2vluIsUIFns4UcLCtSx5dRQWR/snmxWHT7pdVcXDxO1lhpo8J5PCQTElfIzYPoV2KJMI8bDz0sIFdUf3jsNnCWFz0bRByhbnrqX17sCZPd4hXnNCl/FR096g=;5:PsAvzCb7R67Xuf56SkFPkD5Ig1ckMqkwBt5w+tMYWyBSR+8CN2nFLzQ2ciy6Cx7bL1vCYTwKjFp6RdiY3VDMyPBn9WVHCdu0At7BL1JRvQfiXtTDj5koQ+eL+oYI5ABUtiIhHYS/v48mNy6joCDMyA==;24:5P8y0DLFTjFtUnYokvLuZjKsZOoWMP02UI0FEX3cCF/FkPF7eSLBQcF/lTFYDB6dJkB/onQ4tUvxg4OBSi6nlpyyYWL4AOfrD0BcWbgMVxE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:61CMH8GaSEkitASN+Thpv1QXiNWv8T68RjL5HaW5K3OrrFLiu93czmWxqAEdZH33HoMW2KjuyP+L47Ksujwa5W3TQoKfUg8ACgwljkzd0srP9Jdc949Z8VVU5oG2epaMyuTECw1ISJsnR0agqvPQbUlXU+yG3mMrbKgnvwukRxbgXlpO4lTp1z1yxfgKXf86EK8aArFMfYgERxJMxpLrk8us5KsR5e2VXUBFydD+fOAmZdcRncKitJiYXMoJ4rxiRf9gh/10xiY1DocMA/QB0ObqmoXH4Hwx9+Hnw/I9EIZ8k3cp26efSQHlebzz9rfJBpuagE2bdhVsOV/lWnvWmS5V4IM3ae66WkLwlGjB7n7qEU326CB21vr/gB0Y6ibyIWhedAQWv65RQrjTbdYsYU6rghPnEiY7zMvL2ExywqnW/FDTWp/pRE2N86hNS9AUsJKLOOZ2myX20oWZM1Y9Uw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2017 07:02:33.8196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

Add all the necessary platform code to initialize the dwc3
USB host controller. This code initializes the clocks and
performs a reset on the USB core and PHYs. The driver code
in 'drivers/usb/dwc3' is where the real driver lives.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>

---
v2:
- Removed unused typedefs.
---
 arch/mips/cavium-octeon/Makefile              |   1 +
 arch/mips/cavium-octeon/octeon-platform.c     |   1 +
 arch/mips/cavium-octeon/octeon-usb.c          | 552 ++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h |   8 +-
 4 files changed, 560 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/octeon-usb.c

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 2a59265..a3d6ad8 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -18,3 +18,4 @@ obj-y += crypto/
 obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
+obj-$(CONFIG_USB)		+= octeon-usb.o
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 37a932d..16083cf 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -448,6 +448,7 @@ static int __init octeon_ohci_device_init(void)
 	{ .compatible = "cavium,octeon-3860-bootbus", },
 	{ .compatible = "cavium,mdio-mux", },
 	{ .compatible = "gpio-leds", },
+	{ .compatible = "cavium,octeon-7130-usb-uctl", },
 	{},
 };

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
new file mode 100644
index 0000000..542be1c
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -0,0 +1,552 @@
+/*
+ * XHCI HCD glue for Cavium Octeon III SOCs.
+ *
+ * Copyright (C) 2010-2017 Cavium Networks
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/of_platform.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-gpio-defs.h>
+
+/* USB Control Register */
+union cvm_usbdrd_uctl_ctl {
+	uint64_t u64;
+	struct cvm_usbdrd_uctl_ctl_s {
+	/* 1 = BIST and set all USB RAMs to 0x0, 0 = BIST */
+	__BITFIELD_FIELD(uint64_t clear_bist:1,
+	/* 1 = Start BIST and cleared by hardware */
+	__BITFIELD_FIELD(uint64_t start_bist:1,
+	/* Reference clock select for SuperSpeed and HighSpeed PLLs:
+	 *	0x0 = Both PLLs use DLMC_REF_CLK0 for reference clock
+	 *	0x1 = Both PLLs use DLMC_REF_CLK1 for reference clock
+	 *	0x2 = SuperSpeed PLL uses DLMC_REF_CLK0 for reference clock &
+	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
+	 *	0x3 = SuperSpeed PLL uses DLMC_REF_CLK1 for reference clock &
+	 *	      HighSpeed PLL uses PLL_REF_CLK for reference clck
+	 */
+	__BITFIELD_FIELD(uint64_t ref_clk_sel:2,
+	/* 1 = Spread-spectrum clock enable, 0 = SS clock disable */
+	__BITFIELD_FIELD(uint64_t ssc_en:1,
+	/* Spread-spectrum clock modulation range:
+	 *	0x0 = -4980 ppm downspread
+	 *	0x1 = -4492 ppm downspread
+	 *	0x2 = -4003 ppm downspread
+	 *	0x3 - 0x7 = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t ssc_range:3,
+	/* Enable non-standard oscillator frequencies:
+	 *	[55:53] = modules -1
+	 *	[52:47] = 2's complement push amount, 0 = Feature disabled
+	 */
+	__BITFIELD_FIELD(uint64_t ssc_ref_clk_sel:9,
+	/* Reference clock multiplier for non-standard frequencies:
+	 *	0x19 = 100MHz on DLMC_REF_CLK* if REF_CLK_SEL = 0x0 or 0x1
+	 *	0x28 = 125MHz on DLMC_REF_CLK* if REF_CLK_SEL = 0x0 or 0x1
+	 *	0x32 =  50MHz on DLMC_REF_CLK* if REF_CLK_SEL = 0x0 or 0x1
+	 *	Other Values = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t mpll_multiplier:7,
+	/* Enable reference clock to prescaler for SuperSpeed functionality.
+	 * Should always be set to "1"
+	 */
+	__BITFIELD_FIELD(uint64_t ref_ssp_en:1,
+	/* Divide the reference clock by 2 before entering the
+	 * REF_CLK_FSEL divider:
+	 *	If REF_CLK_SEL = 0x0 or 0x1, then only 0x0 is legal
+	 *	If REF_CLK_SEL = 0x2 or 0x3, then:
+	 *		0x1 = DLMC_REF_CLK* is 125MHz
+	 *		0x0 = DLMC_REF_CLK* is another supported frequency
+	 */
+	__BITFIELD_FIELD(uint64_t ref_clk_div2:1,
+	/* Select reference clock freqnuency for both PLL blocks:
+	 *	0x27 = REF_CLK_SEL is 0x0 or 0x1
+	 *	0x07 = REF_CLK_SEL is 0x2 or 0x3
+	 */
+	__BITFIELD_FIELD(uint64_t ref_clk_fsel:6,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_31_31:1,
+	/* Controller clock enable. */
+	__BITFIELD_FIELD(uint64_t h_clk_en:1,
+	/* Select bypass input to controller clock divider:
+	 *	0x0 = Use divided coprocessor clock from H_CLKDIV
+	 *	0x1 = Use clock from GPIO pins
+	 */
+	__BITFIELD_FIELD(uint64_t h_clk_byp_sel:1,
+	/* Reset controller clock divider. */
+	__BITFIELD_FIELD(uint64_t h_clkdiv_rst:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_27_27:1,
+	/* Clock divider select:
+	 *	0x0 = divide by 1
+	 *	0x1 = divide by 2
+	 *	0x2 = divide by 4
+	 *	0x3 = divide by 6
+	 *	0x4 = divide by 8
+	 *	0x5 = divide by 16
+	 *	0x6 = divide by 24
+	 *	0x7 = divide by 32
+	 */
+	__BITFIELD_FIELD(uint64_t h_clkdiv_sel:3,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_22_23:2,
+	/* USB3 port permanently attached: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb3_port_perm_attach:1,
+	/* USB2 port permanently attached: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb2_port_perm_attach:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_19_19:1,
+	/* Disable SuperSpeed PHY: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb3_port_disable:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_17_17:1,
+	/* Disable HighSpeed PHY: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t usb2_port_disable:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_15_15:1,
+	/* Enable PHY SuperSpeed block power: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t ss_power_en:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_13_13:1,
+	/* Enable PHY HighSpeed block power: 0x0 = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t hs_power_en:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_5_11:7,
+	/* Enable USB UCTL interface clock: 0xx = No, 0x1 = Yes */
+	__BITFIELD_FIELD(uint64_t csclk_en:1,
+	/* Controller mode: 0x0 = Host, 0x1 = Device */
+	__BITFIELD_FIELD(uint64_t drd_mode:1,
+	/* PHY reset */
+	__BITFIELD_FIELD(uint64_t uphy_rst:1,
+	/* Software reset UAHC */
+	__BITFIELD_FIELD(uint64_t uahc_rst:1,
+	/* Software resets UCTL */
+	__BITFIELD_FIELD(uint64_t uctl_rst:1,
+	;)))))))))))))))))))))))))))))))))
+	} s;
+};
+
+/* UAHC Configuration Register */
+union cvm_usbdrd_uctl_host_cfg {
+	uint64_t u64;
+	struct cvm_usbdrd_uctl_host_cfg_s {
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_60_63:4,
+	/* Indicates minimum value of all received BELT values */
+	__BITFIELD_FIELD(uint64_t host_current_belt:12,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_38_47:10,
+	/* HS jitter adjustment */
+	__BITFIELD_FIELD(uint64_t fla:6,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_29_31:3,
+	/* Bus-master enable: 0x0 = Disabled (stall DMAs), 0x1 = enabled */
+	__BITFIELD_FIELD(uint64_t bme:1,
+	/* Overcurrent protection enable: 0x0 = unavailable, 0x1 = available */
+	__BITFIELD_FIELD(uint64_t oci_en:1,
+	/* Overcurrent sene selection:
+	 *	0x0 = Overcurrent indication from off-chip is active-low
+	 *	0x1 = Overcurrent indication from off-chip is active-high
+	 */
+	__BITFIELD_FIELD(uint64_t oci_active_high_en:1,
+	/* Port power control enable: 0x0 = unavailable, 0x1 = available */
+	__BITFIELD_FIELD(uint64_t ppc_en:1,
+	/* Port power control sense selection:
+	 *	0x0 = Port power to off-chip is active-low
+	 *	0x1 = Port power to off-chip is active-high
+	 */
+	__BITFIELD_FIELD(uint64_t ppc_active_high_en:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_0_23:24,
+	;)))))))))))
+	} s;
+};
+
+/* UCTL Shim Features Register */
+union cvm_usbdrd_uctl_shim_cfg {
+	uint64_t u64;
+	struct cvm_usbdrd_uctl_shim_cfg_s {
+	/* Out-of-bound UAHC register access: 0 = read, 1 = write */
+	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_60_62:3,
+	/* SRCID error log for out-of-bound UAHC register access:
+	 *	[59:58] = chipID
+	 *	[57] = Request source: 0 = core, 1 = NCB-device
+	 *	[56:51] = Core/NCB-device number, [56] always 0 for NCB devices
+	 *	[50:48] = SubID
+	 */
+	__BITFIELD_FIELD(uint64_t xs_ncb_oob_osrc:12,
+	/* Error log for bad UAHC DMA access: 0 = Read log, 1 = Write log */
+	__BITFIELD_FIELD(uint64_t xm_bad_dma_wrn:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_44_46:3,
+	/* Encoded error type for bad UAHC DMA */
+	__BITFIELD_FIELD(uint64_t xm_bad_dma_type:4,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_13_39:27,
+	/* Select the IOI read command used by DMA accesses */
+	__BITFIELD_FIELD(uint64_t dma_read_cmd:1,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_10_11:2,
+	/* Select endian format for DMA accesses to the L2c:
+	 *	0x0 = Little endian
+	 *`	0x1 = Big endian
+	 *	0x2 = Reserved
+	 *	0x3 = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t dma_endian_mode:2,
+	/* Reserved */
+	__BITFIELD_FIELD(uint64_t reserved_2_7:6,
+	/* Select endian format for IOI CSR access to UAHC:
+	 *	0x0 = Little endian
+	 *`	0x1 = Big endian
+	 *	0x2 = Reserved
+	 *	0x3 = Reserved
+	 */
+	__BITFIELD_FIELD(uint64_t csr_endian_mode:2,
+	;))))))))))))
+	} s;
+};
+
+#define OCTEON_H_CLKDIV_SEL		8
+#define OCTEON_MIN_H_CLK_RATE		150000000
+#define OCTEON_MAX_H_CLK_RATE		300000000
+
+static DEFINE_MUTEX(dwc3_octeon_clocks_mutex);
+static uint8_t clk_div[OCTEON_H_CLKDIV_SEL] = {1, 2, 4, 6, 8, 16, 24, 32};
+
+
+static int dwc3_octeon_config_power(struct device *dev, u64 base)
+{
+#define UCTL_HOST_CFG	0xe0
+	union cvm_usbdrd_uctl_host_cfg uctl_host_cfg;
+	union cvmx_gpio_bit_cfgx gpio_bit;
+	uint32_t gpio_pwr[3];
+	int gpio, len, power_active_low;
+	struct device_node *node = dev->of_node;
+	int index = (base >> 24) & 1;
+
+	if (of_find_property(node, "power", &len) != NULL) {
+		if (len == 12) {
+			of_property_read_u32_array(node, "power", gpio_pwr, 3);
+			power_active_low = gpio_pwr[2] & 0x01;
+			gpio = gpio_pwr[1];
+		} else if (len == 8) {
+			of_property_read_u32_array(node, "power", gpio_pwr, 2);
+			power_active_low = 0;
+			gpio = gpio_pwr[1];
+		} else {
+			dev_err(dev, "dwc3 controller clock init failure.\n");
+			return -EINVAL;
+		}
+		if ((OCTEON_IS_MODEL(OCTEON_CN73XX) ||
+		    OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		    && gpio <= 31) {
+			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
+			gpio_bit.s.tx_oe = 1;
+			gpio_bit.cn73xx.output_sel = (index == 0 ? 0x14 : 0x15);
+			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
+		} else if (gpio <= 15) {
+			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_BIT_CFGX(gpio));
+			gpio_bit.s.tx_oe = 1;
+			gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
+			cvmx_write_csr(CVMX_GPIO_BIT_CFGX(gpio), gpio_bit.u64);
+		} else {
+			gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_XBIT_CFGX(gpio));
+			gpio_bit.s.tx_oe = 1;
+			gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
+			cvmx_write_csr(CVMX_GPIO_XBIT_CFGX(gpio), gpio_bit.u64);
+		}
+
+		/* Enable XHCI power control and set if active high or low. */
+		uctl_host_cfg.u64 = cvmx_read_csr(base + UCTL_HOST_CFG);
+		uctl_host_cfg.s.ppc_en = 1;
+		uctl_host_cfg.s.ppc_active_high_en = !power_active_low;
+		cvmx_write_csr(base + UCTL_HOST_CFG, uctl_host_cfg.u64);
+	} else {
+		/* Disable XHCI power control and set if active high. */
+		uctl_host_cfg.u64 = cvmx_read_csr(base + UCTL_HOST_CFG);
+		uctl_host_cfg.s.ppc_en = 0;
+		uctl_host_cfg.s.ppc_active_high_en = 0;
+		cvmx_write_csr(base + UCTL_HOST_CFG, uctl_host_cfg.u64);
+		dev_warn(dev, "dwc3 controller clock init failure.\n");
+	}
+	return 0;
+}
+
+static int dwc3_octeon_clocks_start(struct device *dev, u64 base)
+{
+	union cvm_usbdrd_uctl_ctl uctl_ctl;
+	int ref_clk_sel = 2;
+	u64 div;
+	u32 clock_rate;
+	int mpll_mul;
+	int i;
+	u64 h_clk_rate;
+	u64 uctl_ctl_reg = base;
+
+	if (dev->of_node) {
+		const char *ss_clock_type;
+		const char *hs_clock_type;
+
+		i = of_property_read_u32(dev->of_node,
+					 "refclk-frequency", &clock_rate);
+		if (i) {
+			pr_err("No UCTL \"refclk-frequency\"\n");
+			return -EINVAL;
+		}
+		i = of_property_read_string(dev->of_node,
+					    "refclk-type-ss", &ss_clock_type);
+		if (i) {
+			pr_err("No UCTL \"refclk-type-ss\"\n");
+			return -EINVAL;
+		}
+		i = of_property_read_string(dev->of_node,
+					    "refclk-type-hs", &hs_clock_type);
+		if (i) {
+			pr_err("No UCTL \"refclk-type-hs\"\n");
+			return -EINVAL;
+		}
+		if (strcmp("dlmc_ref_clk0", ss_clock_type) == 0) {
+			if (strcmp(hs_clock_type, "dlmc_ref_clk0") == 0)
+				ref_clk_sel = 0;
+			else if (strcmp(hs_clock_type, "pll_ref_clk") == 0)
+				ref_clk_sel = 2;
+			else
+				pr_err("Invalid HS clock type %s, using  pll_ref_clk instead\n",
+				       hs_clock_type);
+		} else if (strcmp(ss_clock_type, "dlmc_ref_clk1") == 0) {
+			if (strcmp(hs_clock_type, "dlmc_ref_clk1") == 0)
+				ref_clk_sel = 1;
+			else if (strcmp(hs_clock_type, "pll_ref_clk") == 0)
+				ref_clk_sel = 3;
+			else {
+				pr_err("Invalid HS clock type %s, using  pll_ref_clk instead\n",
+				       hs_clock_type);
+				ref_clk_sel = 3;
+			}
+		} else
+			pr_err("Invalid SS clock type %s, using  dlmc_ref_clk0 instead\n",
+			       ss_clock_type);
+
+		if ((ref_clk_sel == 0 || ref_clk_sel == 1) &&
+				  (clock_rate != 100000000))
+			pr_err("Invalid UCTL clock rate of %u, using 100000000 instead\n",
+			       clock_rate);
+
+	} else {
+		pr_err("No USB UCTL device node\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Step 1: Wait for all voltages to be stable...that surely
+	 *         happened before starting the kernel. SKIP
+	 */
+
+	/* Step 2: Select GPIO for overcurrent indication, if desired. SKIP */
+
+	/* Step 3: Assert all resets. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.uphy_rst = 1;
+	uctl_ctl.s.uahc_rst = 1;
+	uctl_ctl.s.uctl_rst = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 4a: Reset the clock dividers. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.h_clkdiv_rst = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 4b: Select controller clock frequency. */
+	for (div = 0; div < OCTEON_H_CLKDIV_SEL; div++) {
+		h_clk_rate = octeon_get_io_clock_rate() / clk_div[div];
+		if (h_clk_rate <= OCTEON_MAX_H_CLK_RATE &&
+				 h_clk_rate >= OCTEON_MIN_H_CLK_RATE)
+			break;
+	}
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.h_clkdiv_sel = div;
+	uctl_ctl.s.h_clk_en = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	if ((div != uctl_ctl.s.h_clkdiv_sel) || (!uctl_ctl.s.h_clk_en)) {
+		dev_err(dev, "dwc3 controller clock init failure.\n");
+			return -EINVAL;
+	}
+
+	/* Step 4c: Deassert the controller clock divider reset. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.h_clkdiv_rst = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 5a: Reference clock configuration. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.ref_clk_sel = ref_clk_sel;
+	uctl_ctl.s.ref_clk_fsel = 0x07;
+	uctl_ctl.s.ref_clk_div2 = 0;
+	switch (clock_rate) {
+	default:
+		dev_err(dev, "Invalid ref_clk %u, using 100000000 instead\n",
+			clock_rate);
+	case 100000000:
+		mpll_mul = 0x19;
+		if (ref_clk_sel < 2)
+			uctl_ctl.s.ref_clk_fsel = 0x27;
+		break;
+	case 50000000:
+		mpll_mul = 0x32;
+		break;
+	case 125000000:
+		mpll_mul = 0x28;
+		break;
+	}
+	uctl_ctl.s.mpll_multiplier = mpll_mul;
+
+	/* Step 5b: Configure and enable spread-spectrum for SuperSpeed. */
+	uctl_ctl.s.ssc_en = 1;
+
+	/* Step 5c: Enable SuperSpeed. */
+	uctl_ctl.s.ref_ssp_en = 1;
+
+	/* Step 5d: Cofngiure PHYs. SKIP */
+
+	/* Step 6a & 6b: Power up PHYs. */
+	uctl_ctl.s.hs_power_en = 1;
+	uctl_ctl.s.ss_power_en = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 7: Wait 10 controller-clock cycles to take effect. */
+	udelay(10);
+
+	/* Step 8a: Deassert UCTL reset signal. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.uctl_rst = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 8b: Wait 10 controller-clock cycles. */
+	udelay(10);
+
+	/* Steo 8c: Setup power-power control. */
+	if (dwc3_octeon_config_power(dev, base)) {
+		dev_err(dev, "Error configuring power.\n");
+		return -EINVAL;
+	}
+
+	/* Step 8d: Deassert UAHC reset signal. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.uahc_rst = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/* Step 8e: Wait 10 controller-clock cycles. */
+	udelay(10);
+
+	/* Step 9: Enable conditional coprocessor clock of UCTL. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.csclk_en = 1;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	/*Step 10: Set for host mode only. */
+	uctl_ctl.u64 = cvmx_read_csr(uctl_ctl_reg);
+	uctl_ctl.s.drd_mode = 0;
+	cvmx_write_csr(uctl_ctl_reg, uctl_ctl.u64);
+
+	return 0;
+}
+
+static void __init dwc3_octeon_set_endian_mode(u64 base)
+{
+#define UCTL_SHIM_CFG	0xe8
+	union cvm_usbdrd_uctl_shim_cfg shim_cfg;
+
+	shim_cfg.u64 = cvmx_read_csr(base + UCTL_SHIM_CFG);
+#ifdef __BIG_ENDIAN
+	shim_cfg.s.dma_endian_mode = 1;
+	shim_cfg.s.csr_endian_mode = 1;
+#else
+	shim_cfg.s.dma_endian_mode = 0;
+	shim_cfg.s.csr_endian_mode = 0;
+#endif
+	cvmx_write_csr(base + UCTL_SHIM_CFG, shim_cfg.u64);
+}
+
+#define CVMX_USBDRDX_UCTL_CTL(index)				\
+		(CVMX_ADD_IO_SEG(0x0001180068000000ull) +	\
+		((index & 1) * 0x1000000ull))
+static void __init dwc3_octeon_phy_reset(u64 base)
+{
+	union cvm_usbdrd_uctl_ctl uctl_ctl;
+	int index = (base >> 24) & 1;
+
+	uctl_ctl.u64 = cvmx_read_csr(CVMX_USBDRDX_UCTL_CTL(index));
+	uctl_ctl.s.uphy_rst = 0;
+	cvmx_write_csr(CVMX_USBDRDX_UCTL_CTL(index), uctl_ctl.u64);
+}
+
+static int __init dwc3_octeon_device_init(void)
+{
+	const char compat_node_name[] = "cavium,octeon-7130-usb-uctl";
+	struct platform_device *pdev;
+	struct device_node *node;
+	struct resource *res;
+	void __iomem *base;
+
+	/*
+	 * There should only be three universal controllers, "uctl"
+	 * in the device tree. Two USB and a SATA, which we ignore.
+	 */
+	node = NULL;
+	do {
+		node = of_find_node_by_name(node, "uctl");
+		if (!node)
+			return -ENODEV;
+
+		if (of_device_is_compatible(node, compat_node_name)) {
+			pdev = of_find_device_by_node(node);
+			if (!pdev)
+				return -ENODEV;
+
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+			if (res == NULL) {
+				dev_err(&pdev->dev, "No memory resources\n");
+				return -ENXIO;
+			}
+
+			/*
+			 * The code below maps in the registers necessary for
+			 * setting up the clocks and reseting PHYs. We must
+			 * release the resources so the dwc3 subsystem doesn't
+			 * know the difference.
+			 */
+			base = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(base))
+				return PTR_ERR(base);
+
+			mutex_lock(&dwc3_octeon_clocks_mutex);
+			dwc3_octeon_clocks_start(&pdev->dev, (u64)base);
+			dwc3_octeon_set_endian_mode((u64)base);
+			dwc3_octeon_phy_reset((u64)base);
+			dev_info(&pdev->dev, "clocks initialized.\n");
+			mutex_unlock(&dwc3_octeon_clocks_mutex);
+			devm_iounmap(&pdev->dev, base);
+			devm_release_mem_region(&pdev->dev, res->start,
+						resource_size(res));
+		}
+	} while (node != NULL);
+
+	return 0;
+}
+device_initcall(dwc3_octeon_device_init);
+
+MODULE_AUTHOR("David Daney <david.daney@cavium.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("USB driver for OCTEON III SoC");
diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
index 4719fcf..8123b82 100644
--- a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
@@ -46,7 +46,8 @@
 	uint64_t u64;
 	struct cvmx_gpio_bit_cfgx_s {
 #ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
+		uint64_t reserved_21_63:42;
+		uint64_t output_sel:5;
 		uint64_t synce_sel:2;
 		uint64_t clk_gen:1;
 		uint64_t clk_sel:2;
@@ -66,7 +67,8 @@
 		uint64_t clk_sel:2;
 		uint64_t clk_gen:1;
 		uint64_t synce_sel:2;
-		uint64_t reserved_17_63:47;
+		uint64_t output_sel:5;
+		uint64_t reserved_21_63:42;
 #endif
 	} s;
 	struct cvmx_gpio_bit_cfgx_cn30xx {
@@ -126,6 +128,8 @@
 	struct cvmx_gpio_bit_cfgx_s cn66xx;
 	struct cvmx_gpio_bit_cfgx_s cn68xx;
 	struct cvmx_gpio_bit_cfgx_s cn68xxp1;
+	struct cvmx_gpio_bit_cfgx_s cn70xx;
+	struct cvmx_gpio_bit_cfgx_s cn73xx;
 	struct cvmx_gpio_bit_cfgx_s cnf71xx;
 };

-- 
1.9.1
