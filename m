Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Sep 2016 22:55:03 +0200 (CEST)
Received: from mail-bn3nam01on0049.outbound.protection.outlook.com ([104.47.33.49]:41312
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991998AbcIJUy4NT4bH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Sep 2016 22:54:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3wOUAYIEO9PWfLIN6JS6GMfP6pArzRy7vcB/UsKAgZs=;
 b=FX3LVE/ciSyAce2DliuNCdiUQ2SYw7TF812ttfuk7uO5zr2g3gE/7Y/Dkq7d39PsA4LhuvgBxsl7qE6UaR0q8DE5ldO7DdvDW2hdDMKkyxzHQRP/NnV4R6vhyu05HH7X+gQSjmLdtEVcDLNMyi5BWJ32j2Clwl2DShuWg72/OM0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BN6PR07MB3204.namprd07.prod.outlook.com (10.172.105.150) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.587.13; Sat, 10 Sep 2016 20:54:47 +0000
Subject: [PATCH v3] usb: dwc3: OCTEON: add support for device tree
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <57D47313.7040109@cavium.com>
Date:   Sat, 10 Sep 2016 15:54:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: DM3PR10CA0031.namprd10.prod.outlook.com (10.164.12.41) To
 BN6PR07MB3204.namprd07.prod.outlook.com (10.172.105.150)
X-MS-Office365-Filtering-Correlation-Id: 950aad12-d869-42f4-59c2-08d3d9bcb395
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;2:AZfaNgeiGvvXvYsqi50sPaO42JE+iRoyASzOR0cb+B9wYh1OmFYpHuDEX27tPDdC+fmXKOK94vX9s3SRdbAgz+KsEiP74Kvf5WhTPxb0sVF1W0z0Xe026XsXkayvVRVmIIuGtBDJ/WRNsU51z44qONiXdfX73ydwuCrv6ZHjEEb9yIHmlBzfs4/XPwK/EgBB;3:iOtRH2bU6+Regzc7P+Fyr4aQI5VOGCzsjM4+saHjSGSO62YAOJeF3v7skfzLygqEFwBlafFhNIMCQoP+JKHPg8MtoMDjZxpuhuneTzTGHq+jLzG7rEK8+aDo1vvtRPV8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3204;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;25:6b9SIG5i9Khk+Jm+KTLM8xKCH37Ao/HEBRfPmDg1p+KfbP1p998L9VNJDb8hJa+HFxPujjuSe53XFLIpVVhYBt+Y/bk83IrC6t99IAf4hIN+4xvBrhyPNOUwpmLUJeosAFEKfyFPFMmYA/XElJKRy+gtRkSW07ybIBTl5Z69n/VMKozG10BndT46cftsCEjllW9UGpVX6mChpaXcmKUk/XPXxmkuR7Dxv9LBxAhlGNosb2mNj8yeIG41SHKXYP2ht7wqFWroE9ge/IrsAHW/Pt2cPzOw2GM8SoN+F3zv1Y2Tcy6igSfwuTl0O1tdyHOGJI0m5/4iGkRPgvgYJvMomNwXT4e8lQ0PjW7kPCy1njmnzrnbyxJogkbsLD60ZdRkcOZxLCmXSiTmibxwKYg08zL6dMkbp7TQVqQREY5PZR7Lux9ImUrbl2rnWFStjmE+ZnBSwjKE+uKnl0Cr1Ps9u/WliSFDVgpDE/NufM+3Beb8ehV9YDbJbpoZaRdAg/AVh0r/tKva/WPf74S3Hx57TCJW299lTdM1HLNndQxhutZzKl1WFgUaK4fkn0owJPq72NImaqRv3cksBynQt26SEBaX3H+9pHpL36KndXv3lHQGdsT6pwCoQiL2YtOirtcDLQDyu61nIonvYTIYTd08Rf/UiCN5n+nly3xYJ/AP3q27O7iyINc2PhDziIVJ80TMNg1aVw1tYpZXMmjRAThA+g==;31:P4I5qB64pblGYBFJQkCFoTjungEBmyNCb//+ALvzqPDMr8pmEWk5QQCoEZ385Jk0AyHH8nBxanshHcHDZimK1reHf6ini3CZkzVvt/10E3IVvAPYnZN1VmxaX2e9m/H/PCLCVYwOJp0VmopyA2zjPCu9z68o8UUZnoUmldvnyW3HfCDU3E36/Jcnxtpncxg3DCLBZfC6OVj6IY4N0WIGRuyldrcOvSy0HOfAF3XuUq4=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;20:5R/D0MxYFj+9lnmMYC6tV8R3myOsSxnS4TcPfUukPcek69qjrEIIuk+5Nk6NhNomla98yxR28bJUjhVLIkLSgHECa3UVUC7NOhPuw8Mgcw2Dpz54rZHrjGLr7Sd4sPgB3F8qZEiPw8B7IZh8uNJcEJI8tWxPGWbs0LuhDIYImXlyIoXlOjJYY1ILIuw45gUz55AqT7YSU465QyTdghh/qns9TmJyZsYeLboXnFzLbDbVeOf50HjZihO2TJOVflairl4EG/2Um0l0uJnb2pHNBMW97UG6/Xh8wbnlQ+JTprmlaOIa6P7mRPM/h4yhomeRxz3MrhU4KMA+eqdnCYM5Cp2jG/LzMHOddo+REvh6ct3+Ievjh+fC1dVm3Hgrt9JmJ4d9ZoYa3uYcTiB+vipHGa98GoRXqqwXb9FBUKguUy8lFIzZnTjBs61KyItkzBLmIXVO5yj8Ro4UvYgBoSaAGDHFUslfIaVcsmYIjX1mEJR4JcJr73H5TW8KJjSFVnEf;4:3Duu4LMk/BHYazAd7yWbQfktV4PZL49I1Vn+hq+RqQeOa5Pg435rGi2lyXjuWAH//u8m15rj/cxwGnv22UOV5XkztYP68iGp3n5vGcfQU6fkZZwptauEbha0/1CsckwUPCQOjLzl54xNLmcGieLkrSH0DSpqJGMWGBLQnsebW0au8/40sMdYBlcnWCL4nf9ZnQFFuGROWC50sTBqWVIQt6KTD8gfs7Xdz3hSACK9xklHVIEMb2w2TVCLlNlb++kZXSzPpX3td2IXBxhyGDjwIf1o/M1keBEuo+WjNL5FctFRdULbEaRHRj6TUAmzV/aMFpYo01jk3qXVeg2JdJtStti7quNdV9LUh8omxhXQO5yZyFgRjuygyDjpxFxstdo6kxC8xRiZAHOP3sUIpxJy32v5+2jNgyntSNuTZbw9o7cKgimQ/rH6JWurqHOAjveN
X-Microsoft-Antispam-PRVS: <BN6PR07MB3204B1118A44E8EEF47430B180FD0@BN6PR07MB3204.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:BN6PR07MB3204;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3204;
X-Forefront-PRVS: 0061C35778
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(189002)(199003)(52084003)(229853001)(2906002)(23676002)(586003)(4326007)(105586002)(33656002)(189998001)(3846002)(4001350100001)(83506001)(42186005)(92566002)(4001430100002)(59896002)(80316001)(19580395003)(19580405001)(6116002)(230700001)(101416001)(81166006)(36756003)(2351001)(77096005)(97736004)(50466002)(47776003)(65956001)(66066001)(54356999)(68736007)(8676002)(65816999)(81156014)(50986999)(106356001)(7736002)(305945005)(107886002)(5660300001)(64126003)(110136002)(87266999)(86362001)(7846002)(65806001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3204;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMjA0OzIzOjlYNTFuYjV3N0lyTkJrY283RThwTE5RNnA1?=
 =?utf-8?B?akcrOGZSM0FxT1V6a0c2eUtTejJXM2tFNTRuSDFzVDdqSkIxQjlEcUZ6K0to?=
 =?utf-8?B?MytpY1g0ajlZaVJvTkZ0cVRBOThVbzZJdmorczRhcExUSHl2Y0t0QzBpayt6?=
 =?utf-8?B?Sk9NY1N6SmpGMVZXV1J5dFh3bktYYlFiK05STFZhL1dSUStqQjNsdEdDYXNB?=
 =?utf-8?B?VXBPUHFGY3I2VFNGbzlpSGpXbmVEVnUxUFBvamV5V21USGJ4T014bFVJNHN3?=
 =?utf-8?B?YWtUYTB5UThJbXd5NVhnbDAzc1dwbFBLOUpPaWo2Nmh6S09XZjV6VXVhaHkw?=
 =?utf-8?B?NklTK082Y2xUSHJMM0MxbFdnRURuZnkyUlZqdnQzeFJOMG9iNWhRR251NGdM?=
 =?utf-8?B?NnlSVm5XZ1ZiM1k1VURUWkowTmJtbGw3QXhiaDVFY2JtaG45aThyMmVDYjY3?=
 =?utf-8?B?VjZCTWV5VGx1Y0pnRFFlS1Q3M1Z3ZktEa1Z5cXJtTDU5WGIrbXJReGF3K0Zj?=
 =?utf-8?B?ZFNVTVZ0RGxESno2aWRweUlGeWd5NElkeUdsMUY1UFFQRXVNNURwaGFhN2ow?=
 =?utf-8?B?LzduNFVVUklmd2dDQTN3N1ROc3M2YzR4eFQwVjZsT0pMTFdiQmFQMlRYNEZQ?=
 =?utf-8?B?Ui9rSmNOLytnVkVWRGY4TG5TRFNMTnNHRnhWaG5FS2FzMmZsTEtKaEp5K1NU?=
 =?utf-8?B?R0ZEQlpIYWxOd2NMbXlRZmVEQVB6RWMvMVFoMTB6bnJxUHZhWlpFRWhRSUZV?=
 =?utf-8?B?N0RwRVJRSjIwdUJ0WDRXZ0J4TUUrZVFQRUxQb2xLZDV4eEUyQVdtTG1ZZmhm?=
 =?utf-8?B?VGdRSU4vR2wvYVpSQlgxdWxySjNnTjhGWnBZeTI5NDZKbDU2ZTNqVlBzUk1V?=
 =?utf-8?B?dVEwVjFHTzdtZEVLUEVKVUhZS0R6UmcvTU1EMWFJc0Jrd0t6WHhMQzZiSWRO?=
 =?utf-8?B?bHI5WDlJZHl3aDlRbjJ3T250b0w3dHppcGloRjN4OXRqYlJlSTBKRU1qdFIx?=
 =?utf-8?B?a29PaWkvRTNWUW1NQkF6Wk5tUW9QdFUxcFZnU0RUMHRwKzVONC80bk9GZG05?=
 =?utf-8?B?TlhIWHNWcjFHM1JBNTRDbjU2SmlXc0MwVkxnVXhham1GQU02UURrRXRBT3kx?=
 =?utf-8?B?OVYybFhxbGh5TnR2bk1IZEpWS0k2V2NaWmlwR3p1Z3FmdW9mbFNMa1Y4V1pu?=
 =?utf-8?B?ZU85UmkzVUlndXRiKzRyNkRhbUJNWjhTcDJud2ZuQlB4Z2tWV0I2Um9lVEcv?=
 =?utf-8?B?NWF3VXRoNVlPUHFoSXdqRzN4cTJSckZFb1BwTHozRldLUlI0Sm5hNkZ0UFpt?=
 =?utf-8?B?QWRic1Q0V0REdzFUUGdOSU5tS05nZWxHb3NmTG1zbVNvV2ZpQWZyNUNlTFZG?=
 =?utf-8?B?amhrRXpGSmVxa2prbkhVdVBmbW9IZ3ZwYzduVVZaMkhZUnhuOGJLK3h4T0lV?=
 =?utf-8?B?b25FMG51VnRSdGVWeWp6OGtBbFZjWWYrM3FwcTVmK3lMcXFCeXNoTEJxL0lt?=
 =?utf-8?B?NkFxc05VVjB3Qmd1UnIzQVdWazhERE14VFp2My9FalIvWG9yOUpXWUlQd0Fl?=
 =?utf-8?B?UTZ0RnFhcGtnblJTS285VWNGZDlxcnFLMHhpSTluWVQvNUdpak1IWmRURFRu?=
 =?utf-8?B?ZWhUamdEMC93alovaWNuSFpyc283YlJrYStBN0pGOVNKUXhLU0NKVGozZEsy?=
 =?utf-8?B?alRmU2hpM3NjWXhCS04zYlNzclV5MGxNRkNmRWovYUlXNFVSVlRuUWNXV0s4?=
 =?utf-8?B?czJabFRVSktERysvay9zeVhZd1hieURBeFNxMXlVaXpaS3BybXo3Y0U2YzZj?=
 =?utf-8?B?M0tGS2xiOWk2blZiVndUZ2E4YThjS1M3amFGTVc5YW1TNUE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;6:nJyLQiV4/LUz/wHyGBTLwwUsqE9YJC9s2YrKVq4Uz4Y2NU5yAcZGTEOd6gq1xLCbTgEPjzbF2SrozsY6WiTsPH3wHqfv5VpqfPA0FXvGmVlZj/WG78hHDX6wSJEdG7EcsWI1yL9kRPflqpHyP7AjMDeRKIEdcyOi/J9D3YDXdU2oan8pa5rZk8TK6zA1lm/d8/T+xvN1jSO3dUtoxjOs0UGNelhsHGlKjldKSuK/k7CBLL25eTNtXclAZFxGcEt1kHSlGbOLbgD4i5PIC5zN4KbMkqcvICB5/4+HZE9otnA=;5:hgU6B3L8Dvy7YylhEjgum6pBRZHqOmdoJuOGiEEQBFrhgHCYhZvvXiOXgbnQIgZ+GOR/EKM3WEBBhmBe3EEaJ8XiepAIsqVV49b2zdr+QTB2RKI/HtGI13wcCdQj6fNBL6NNI4l9IsBJ5GjN0b6Hcg==;24:fqsnZjWJAEgGdOuQ5H6LWQidM3MZkln9m10d/0pRydJOM/QZ2l+Kx+T73NN2tNzxs3Nn415UbhBkt5BU4P9gH4Jj0aLe0FJCXrV0aYdwvZM=;7:uxG+6r587N5mslPZ/6zC9twxbFTNaRqHZQi3n5nnn8R18kRuVUp6xrs7gFXEw9bh91UFSFYcGULC4g+GpcVO/Pjap+Fb/i29+4RzzfXwQ5SaE/xonR+L2lKlv1Q6C8NlttA6cw/HnDylALoXojwJkyG/96uo0aVi8WzGYIjZU25MuDvEZyDzTpfzyaHH5iYHJWmFEV9aGyDNZZKwhQYY0iS/bOdP6XtkYTq0pBEtJAWYA5/OmhqgfeNWMtYmbQl3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2016 20:54:47.4516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3204
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55086
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

This patch adds support to parse probe data for
the dwc3-octeon driver using device tree. The
DWC3 IP core is found on OCTEON III processors.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>

Changes in v3:
- Massive simplification of glue logic. Almost all the
  work is done in the SoC platform code.
Changes in v2:
- Changed comment block to acurately describe why the DMA
  properties are being set.
- Deleted 'dwc3_octeon_remove()' function as it serves
  no purpose. Also changed driver from tristate to a
  boolen as we have no plans to make it modular.
- Changed driver dependency from CAVIUM_OCTEON_SOC to
  CPU_CAVIUM_OCTEON || COMPILE_TEST per Balbi's request.

---
 drivers/usb/dwc3/Kconfig       | 10 +++++++
 drivers/usb/dwc3/Makefile      |  1 +
 drivers/usb/dwc3/dwc3-octeon.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-octeon.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index a64ce1c..f2cb24b 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -105,4 +105,14 @@ config USB_DWC3_ST
 	  inside (i.e. STiH407).
 	  Say 'Y' or 'M' if you have one such device.

+config USB_DWC3_OCTEON
+	bool "Cavium OCTEON III Platforms"
+	depends on CPU_CAVIUM_OCTEON || COMPILE_TEST
+	depends on OF
+	default USB_DWC3
+	help
+	  Cavium OCTEON III SoCs with one DesignWare Core USB3 IP
+	  inside (i.e. cn71xx and cn78xx).
+	  Say 'Y' or 'M' if you have one such device.
+
 endif
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 22420e1..f1a7a3e 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
 obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
 obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
 obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
+obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
diff --git a/drivers/usb/dwc3/dwc3-octeon.c b/drivers/usb/dwc3/dwc3-octeon.c
new file mode 100644
index 0000000..ae84a01
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-octeon.c
@@ -0,0 +1,61 @@
+/**
+ * dwc3-octeon.c - Cavium OCTEON III DWC3 Specific Glue Layer
+ *
+ * Copyright (C) 2016 Cavium Networks
+ *
+ * Author: Steven J. Hill <steven.hill@cavium.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Inspired by dwc3-exynos.c and dwc3-st.c files.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/dma-mapping.h>
+
+static int dwc3_octeon_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	int			ret;
+
+	/*
+	 * Right now device-tree probed devices do not provide
+	 * "dma-ranges" or "dma-coherent" properties.
+	 */
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id octeon_dwc3_match[] = {
+	{ .compatible = "cavium,octeon-7130-usb-uctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_dwc3_match);
+
+static struct platform_driver dwc3_octeon_driver = {
+	.probe		= dwc3_octeon_probe,
+	.driver		= {
+		.name	= "octeon-dwc3",
+		.of_match_table = octeon_dwc3_match,
+		.pm	= NULL,
+	},
+};
+module_platform_driver(dwc3_octeon_driver);
+
+MODULE_ALIAS("platform:octeon-dwc3");
+MODULE_AUTHOR("Steven J. Hill <steven.hill@cavium.com");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 OCTEON Glue Layer");
-- 
1.9.1
