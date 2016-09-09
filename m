Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2016 18:27:57 +0200 (CEST)
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:11588
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992993AbcIIQ1uKCevZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Sep 2016 18:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QB8VagjZ+3rphZOMMeCLUbrTjWf3S95YA0Tgenp0CYg=;
 b=jQlOFG4WDQOTOfvI3f3v4m7I9jgouU9Zg3ZNUsaMWT/+6HsTUR4rpZsBiAYSnui/tnPUtyhvzVSM9XvW7R7QlvIl/tgy9STLbcgkoyQQuQM32b/inslm1bDdudKJLAuHtmImw+xi/V+JLexceja1y1WqZHZPafNS/vVUIHdlRNY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.587.13; Fri, 9 Sep 2016 16:27:41 +0000
Subject: [PATCH v2] usb: dwc3: OCTEON: add support for device tree
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <57D2E2F4.8030707@cavium.com>
Date:   Fri, 9 Sep 2016 11:27:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CY1PR10CA0013.namprd10.prod.outlook.com (10.162.208.23) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-Office365-Filtering-Correlation-Id: 2e5a697b-7ed5-4465-1a53-08d3d8ce391a
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;2:efP7l9oqhGTmlOX/hqt7eEDG71dz2+N/yVSGLmC2H63C5pM/z9zeNvfuu7+M9yvz4vyFiyjtVxt0KN1jQww/r4GxqqvmE94mj1GCfCCPxEsmYbu5DtIUslHJllrcS2J2wvgfdKjBmJASFAvy3doeEYwBs6ka0aeYbp0Uc4oWCIXzyOyE0eZ/st710AB3hEJ8;3:ZT2SMdTh4R5lht5jQ7Gh7IpFQjmtAcZ27IG2Fh41ecByZySPSpmq7tXRtDCVcqL4gfO2LJKKe6Z85D2XRIVdmN1F84gpCo9gQQW5xBwF9QvoAR3fdzArKOY31yiXvHSF
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;25:S2PTBBRLvXCCEh2Tev4OlUNXduZMMUIshScjgVcCRtjLTBv5NS0rVD+I+P9TfA5Wt5XcBor5JTHs45U2KcAIvfVo4oKENpgH+VVBJMyaQB3WIl92KJoPTRwbr/eegpiIdVtxbggxGGpukFo84ykdM8Wvw96mWH67k4xAK5dN4MZ8qxaymZQTvQH92/tt7tr917gp8roVwkbRG4+go2euRPi48mXKzZaB1f35aquktvgq2VeS0XTNmiV9FOZhFip3t3juRj1cpIR7otZaVwAmMyM23e0DPZ1mhxj/Zm4hqdvyC1ND/cUZ3WLizkpzK9MvswoQSw8GxROfge70BiRSUDXPIG17JllY6DPyxm5nlAYpoVbET4om/J8iaZhfEPYlajs1r+bvU6KaFQ+Ae6KS1pUpbkiWtHKyZGEsZ+XzUYhrCqc/YwO26tR+IXwyfmrlgQRz/Sid1D3dJ66sxMqqWbzc30SBLjW76pIJ/OmceYBrQm1q/1MKuyCox1v560555alTTCIG5zBFIOg/mvzS25aggYx86+KToCiMyY68NCNLjFIqcg94pYbR+ab8/uYqA7av5I4RNIHzcArTrmuybn7/HTnQyyNeZfmc4dE5ou3zowsnxC0v1rPf9xCCOugV+gLvhG1eyRqUqt+/QZ5qEw5jU4JUEshHg49MPmfvMDWdpjRqmHRSs00CjFF/2nbR07e0a0V/XKYEm2toHR80aQ==;31:yMUI5dUF8L8+J7iUlPp33o18nxBiNi6BVnX60aDnQ6s0wjCBQuPzl+i1ss0xi/Y7P1l9fvotgLHdMlc1FqU3o0C1vEzZMTsrc1HOwZOGpSVzMQFOqFwbUynQx9SvQKmRviVorjSYB/NM5Uqjd250FNt2Sn+s42QywUtq3m+8n1yYF0GB65XOwdpmYAYTtVozNgy6qFtEpzGFbqm0XZDLobOHdSvf8LpqYA45+2DnbvA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;20:TW0iSZPpApMWw3HlxnBR9absJ2Iwif1A+LkTq7V5EjjaB2KiEQjooRFmCEg7aVyWqnY35Xzqjjmk8wtxqUFMUPeqZGd+Hs/Y1VNYDPjzL67jGjWB+4vfFAwp/plxv7FMT6PdGEL46vBSJKdmWvy2LvvGmyP/4jOwWQbxdC4vsmseVUzXBI7bEjensO1VkoLdvEAfoiUC1eEXGcePHvnOnz6JecEymkphvkanJJ4boSRa/fOkpELwDzY83CUTnnD8fwRDIN6JOeLyo29KY/W9QVO+vtdksm4xQoT1t3pJz4ZkYvV25v/nctBqjU7MIGXHjyUNCPF+TPUyBpszY2STptKSj0Pi2vG2T1r+UagRPjlEDD6j4AFSL/JaV3p5ZQJo6Wr3PAUqSX/AH8g7ChRh6ML7SXluiw3XHRU4x5ogyNLrhyI7VCI/ah3Ukp+O1+TngvrS69bqqtT7wNvjmy85vpE5tAwizFymTG0mTHG2RoaO9L6yIHb4LIRYLpX5mroM;4:QA1/n2cAMUNkc8vaX7i9zaD7mOutfrQnwROeZeBA3J2ETXGQnGHdZ4TqvT3S4KlQPVchtPt7BNO4PdEIp0ZFy+lqgxE7eubt5nO1N5T5y9UbI347eAV6zpMcl7wo7Zk/iItHdcwqP0xf0X6k6hSlQhtnQGzv9Sg3GzLvVEAA+QQ2bi0and4aDwxTB3CQkQceaPse1ibYA/GfjFavAPaMBgvBwq2fQGDh0PxJPIxKi1tpU04C+vaQl1XTzCpWmF6v2IvAbC2Btsw5PP2+HJDHgSmsDPAGjl1YgnL2TgbKTbERxTlDSP6Kjn1nKIV4MQwVwCa7k/OaMt2tJoxueTTo/YE1t3qMifa3H3xw9FyVEDHyCYMzLBRy07xps0vgcq/mB787hdTWz455Ya/NDRiW68nInvnMoCmKZzHVVf6IV4D4MlF254yInlpbc4aeMWuJ
X-Microsoft-Antispam-PRVS: <CY4PR07MB32068D79BCF318470BDF7EB080FA0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Forefront-PRVS: 00603B7EEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(52084003)(199003)(189002)(586003)(54356999)(87266999)(77096005)(305945005)(92566002)(6116002)(7736002)(230700001)(19580395003)(50986999)(50466002)(86362001)(68736007)(64126003)(59896002)(4001430100002)(65816999)(7846002)(36756003)(4001350100001)(101416001)(66066001)(8676002)(106356001)(65806001)(229853001)(65956001)(110136002)(107886002)(81156014)(5660300001)(97736004)(3846002)(81166006)(42186005)(23676002)(189998001)(83506001)(105586002)(2351001)(33656002)(2906002)(4326007)(80316001)(19580405001)(47776003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMjA2OzIzOjdOMGlhcUI4SHMrSE0zWGZwbTlpQ2RyYU9x?=
 =?utf-8?B?cnNHYWVmelFYMlJhVkg4SU9sNXREalNZMmxuZHNObkRKWjFSS1puMlg2TDgz?=
 =?utf-8?B?bGY4d2RGTlp5eHZoZzNrNkJtMzBIVjdBWFAyTjZjZUREU3VOcEdjdDVleFYz?=
 =?utf-8?B?dUFueVBsdXNZRTdjYWVPTWY0YzJHeTNXSWhITnVVNEtERUs2NU5DVHZiN1hK?=
 =?utf-8?B?ZmdvQnBNUkIxbEt3ZFFTblVHYzkyL1hWUWprbGRIdU1ZdTR0alc1Z2ZQNFZG?=
 =?utf-8?B?U3E4VGZmOXR1VFlWZFpxZElaZkE0RmQyUG9hSEZiU21BL3REL0VaVldPM3ZE?=
 =?utf-8?B?aHhVa0xMbFBoYWRUMVlvbUwzZDdNQjNxTEdLZGJHWTAycU45TkVqbzRNNXdi?=
 =?utf-8?B?RnBNb01zMzZpdnVrS1NlWEpxS1VyRS9tTTFsa0dKRlQwMzRQMVNhYVVLOXZx?=
 =?utf-8?B?T2lVV2M4M2pBYXRMTTM4SjBpdWNyc0dJRC9iTTg1NU1RZm55dDk4ODJvNWpM?=
 =?utf-8?B?aGJYOFBuRHV1aGZ0dmVCRXlub1lZOEJyYVhJb1hZbzNhMEJlbXdhWXRRUmVG?=
 =?utf-8?B?MDJITURIcmRVM1RJWWV2R2FPTmtEM2trMjFIYXlMY2g4eFNJK3R0clpUTE14?=
 =?utf-8?B?QkRNT3JrOE5rQ2dLQ2k4U3hmeVhFR096a3Byd1UzWldHbm1xMGJTWW9RWVJM?=
 =?utf-8?B?elA3R2k2cXJLU0RKMDUwTEdEVDFSNzVyQzZxWmVBZXpsU1ZHbUtMdlBGRHNQ?=
 =?utf-8?B?SE5GSHBNWlIwbXcxYThrSkFPclhuS0tuSlBqak9QVWdGYlJUMit0MjRoNFR1?=
 =?utf-8?B?eVN1bzBickpPOURYTDRUTjVGZmh6TjB3VzVmYldMMUZFNlBPSlc5a3ZxMVVr?=
 =?utf-8?B?UW4xRWNSN0N0VDNQRERqM0NmcjZiWVpsOWE3ZFk5QW4xZjZwQ2MzQkpqZU1m?=
 =?utf-8?B?NkNGbXUxcC9pYms1WS9iQnZPM2VweUpLL2RCSElaSFpYVDlRaVRYS1gzTnlq?=
 =?utf-8?B?b2Y5SXRtYkJVRFN2QmVkL1NSRDd4b3NwZ0RmS0Y2ajQzYXhoSWZDU0U0Wm54?=
 =?utf-8?B?V1Z5b0tvMmRNQVNXSzV6Qkt3clFaekltejhjWjFGSTV5N1AybEZJNUtIQUhR?=
 =?utf-8?B?S3FLM3VsTzYwZEdiU1JNdlR0TFBkUzBMQTg2WWV0bTlGRHNrb0o2Y0ZFeHBO?=
 =?utf-8?B?UW1xejZOVmlXN1ZzV0FJanpicHAwT2VhVDBRQUNvOXk0eFc3NlVUR3NMbHA2?=
 =?utf-8?B?RVFWbzdPeHUyNlVTWkt4UXQxWkFOTTdab056RW5LZldVU0V1amIwTndkdkZj?=
 =?utf-8?B?U3UzN3NlZDdGQk8zV3I1MGp5d2V4R2M4OXRER1VMMXM4cG8rTXNiTEV4MDN3?=
 =?utf-8?B?dzEyTE81d0k3NkJyeTBzOVNVRmhoc1NyUEt3a0xVOWxRZGhhOEcySkZJMEtt?=
 =?utf-8?B?QW9uRExHQkdlQVo1M2ZKeVc2ekh1WW1kZWRqU01TWmM3RGZKN25VaG4zOUVS?=
 =?utf-8?B?MURHS2Q4YWxINzV0L1hWK2tUQk9weE9XQzMzNWRsT0tLMkUzNVRoRm14UHd3?=
 =?utf-8?B?OE41VVhRWXJOSTJqb0YrZCtneURGZkxBQ3pldWVHWHJyQUVid0VHV2VGVFN3?=
 =?utf-8?B?YmlTM2czODZMN0xONm9pU0UrVHBPak1TRXZ3WjhXc2FJdGJRSEd2THhFUDU3?=
 =?utf-8?B?eDk1TFJaTm5PSlZDNjNjbm14Q1RlT3RLQWQ5ZGF2NWY0d2NHeGU3MnNKaGRh?=
 =?utf-8?B?d0w5eFZuSzRDQzBwKzJzQmRrZWZyMXZsZDFEVFpkem43REM3NmdaVnA1VlVC?=
 =?utf-8?B?dTNEMGEwdkQzU1J3aUYzTG1JbllORGdkTFlmaE1CSk01K2c9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:8GQ3HN5PzmKY5XpNnMj+2v1rTMHYkuNIxob4MMGP0twOcI8SIeRvaehzwlAcz7sABSqJKcD8F4CDvJ2KFP6g+VukJWaxKbQ9JlTDPWrjOYfSoY6C2jH0/u3+CMGPPnPOLKDHqLywmwdzlrwhUzM4anQ31O/38vBgrcIwLDWlGs4GoQtAalpLhGF03cIPka+iTKFrYoQBPsoaUR0ctU0YM9vvn6QDJeq4iwc3AQTJ3eFcNVnY1m3Mjy0M3UmZwWmOMwrDScYdn6t7GCrGGzeSlssFMiDaGmTPxt0f0/4tauc=;5:dGE+CDvLzYJ0slG1j2vtl0QEgVvkAmQxxK37glvjZvZgt6DIpMF8Wh5e8PTHZCuklo/MH+4YqsmJiTjfWePJH2vXGznf/6VmpT1oyXpP94MC48EgxcY2/+vgugKnBBCs5XMCY1eq9XPnHjgEn+1uEA==;24:JaEYY9Qj14IC2JcKKbphP0ml+YK+Nsd+ilxFK+V1+FqQBRkpt15SRjtqboZM7HN2FHNAPppV/lpCeofj8HRalu1pDx+mA4gPnIV1PCb2yXo=;7:kwjVRYdLQr+xR/3qoi0CdX0sWH/zt1oDVNGsjtZymt+12mppar0CEU8+rQu+wNlZpE2I4XQkIw53lA3xj18pvFAgiOpdB3P+eYAJBBg9LhD5tdPVVRfNnIWINs1kiTUD1L0MdoVd+WxavK1cAFJqejkaO1rFgqZDsJL+7ud1OZ4/W8ynJk7XGAiKtNppeiZyViZCQVQRZXuJtAC7j7IV0VPBIPWDgNXCT7i6MhmdH2u4umv9b+7jwn45wluJA7iy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2016 16:27:41.8340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55083
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

This patch adds support to parse the data for
the dwc3-octeon driver using device tree. The
DWC3 IP core is found on OCTEON III processors.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>

Changes in v2:
- Changed comment block to acurately describe why the DMA
  properties are being set.
- Deleted 'dwc3_octeon_remove()' function as it serves
  no purpose. Also changed driver from tristate to a
  boolen as we have no plans to make it modular.
- Changed driver dependency from CAVIUM_OCTEON_SOC to
  CPU_CAVIUM_OCTEON || COMPILE_TEST per Balbi's request.

---
 drivers/usb/dwc3/Kconfig       | 10 +++++
 drivers/usb/dwc3/Makefile      |  1 +
 drivers/usb/dwc3/dwc3-octeon.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
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
index 0000000..de46939
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-octeon.c
@@ -0,0 +1,85 @@
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
+struct dwc3_octeon {
+	struct device		*dev;
+	void __iomem		*usbctl;
+	int			index;
+};
+
+static int dwc3_octeon_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	struct resource		*res;
+	struct dwc3_octeon	*octeon;
+	int			ret;
+
+	octeon = devm_kzalloc(dev, sizeof(*octeon), GFP_KERNEL);
+	if (!octeon)
+		return - ENOMEM;
+
+	/*
+	 * Right now device-tree probed devices do not provide
+	 * "dma-ranges" or "dma-coherent" properties.
+	 */
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, octeon);
+	octeon->dev = dev;
+
+	/* Resources for lower level OCTEON USB control. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	octeon->usbctl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(octeon->usbctl))
+		return PTR_ERR(octeon->usbctl);
+
+	/* Controller index. */
+	octeon->index = ((u64)octeon->usbctl >> 24) & 1;
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
