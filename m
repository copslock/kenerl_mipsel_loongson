Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Apr 2017 22:52:21 +0200 (CEST)
Received: from mail-cys01nam02on0072.outbound.protection.outlook.com ([104.47.37.72]:39184
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993417AbdDMUwJTm8BP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Apr 2017 22:52:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pVUH0dCRWnIIY8To6QeiyFxH6k0xIs6GFNaKJdc/qG4=;
 b=hmiaTtUKvvOuQynPCidadAWa0NPsH6eirRdq9ZfYp1F7fBn9gj4e75xChNW533RdDu1T7Lnb4y4rLa2aokS+gp+vASH6J6hFfb+MBMeHSfw8N88fgOg1L6znSk+U6LD2jR6gyoRTgcvbrKBrBhcpUGpQv41L1ygA+ZwodovYziA=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from [10.0.0.4] (50.82.184.123) by
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1019.17; Thu, 13 Apr 2017 20:52:01 +0000
Subject: [PATCH v2] MIPS: Octeon: Remove unused GPIO types and macros.
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <a0cb0ce4-e80c-f970-a359-f388796efeae@cavium.com>
Date:   Thu, 13 Apr 2017 15:51:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: BN6PR06CA0010.namprd06.prod.outlook.com (10.175.123.148) To
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147)
X-MS-Office365-Filtering-Correlation-Id: 16424cdb-b8f1-44d5-9628-08d482aeef4e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;3:+8mWBro17EcAaTF7RGyuHu+feolreORauUVRTPsaRqKxC6nFxBqsc0OjIg3c8kOp9p+ZB9EUhTjStYy/NMZyQTZC3Sql0BcipNQ2gb74CDMrN2EPMRpzSEbSU66chh93/qeAdieTM9f27nLuUH5iU9NdFa5HKf9jO65LSyiFNHdFu0zLWruVTkOhgTn3xdRO15GvihKhkJpmQ8fIF48A+0H5emiEqgzxolVKXfvp/bOr5uwteT6Mh3o6c11hcfGlRfPC87g0l1FdangeOkYNlAZFtfFSOeJ0FbIaRwYBD1HWgVC/D9JHucWUtUHcVdBB4UtuU+ojH4kC9bsmAQJ2bw==;25:OdJ5ODYqVow++IqQFUcrCob5hPRCn19/pyiiyHPzh7STYgTg5lBdMt5AxRgyfVG5YCA+O3Z9zEQedScPJI6V/d8vXoiVnfpyS7HE3trKzE4Zt5y4hONAN+zvM6As+VlrMDOzUhAM2mGvDRzxowoIVuEgJdObYJ/BonVuikjm/ZUHyNQqZTwzR1D/X5vJpNCh+/zWPng7BXFGHBdbfcekA04vlBUbdY9rNbjxlwdTce5tixJ94vPNhxIZuTS0v7rXad2I3/T0RX3C/PM9XfUhOWeqhz4T61KS2Lj3JDKYIY03AenjUNRUwDZEZc5oGC834WQTxNG0pcYfDwkTVeRxOmxPhEMIxaqNJV1w/NDdaK7ldVEzAUyOcxFVBvOY/orTKHRE486DI/t1pVPYizm+2KY00E5M0/2266ykVCcZ18pxS2ZtsWSrB7T1dITa0chC52oN534BmIzLele4rWDbag==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;31:etTzuKMCJFDgsTkDwkuAETXmzbOH9143GnmbIe/+K+OBjMWzBKBcIDhr+mT2aGa9FtwGIHM1VXlp4z7XP8SCsUgPAXhxpx8bwZaTyQxXmxYAZM+eOuIB0IUK8WKQFuyo6SilNbDZFQz9jp7FGoP9q95P+seCsTUnBqrkbrmr+kOBjKLinUyOwYpNkBEONRtoKTUsKCpLaFRG2MuTrRCg+tJWm+9PVfyC/Eel0H2J9YSwOczNf6uSGzRteDh1k+I74UizZxCBaBQKPxpJM52PyA==;20:TgJ0aDjXPteFpUBKCvz/L86tXeXx5I3a+nZsl9hz+8kLGsgVeh3aFTxGvqflAEBQq2khzo+QgE0iY1JOrLYk9eqUMC+Xzv5y3btcgyYA3dG665BLfqJ7BCmLmOezoXB01fxMCDWJMJcNC/M6Bf7QH8a0302x89dm9mNP6DGzRSAW1VFhIH45SGSfy91n2vQZq/HiZ1zv57rLoOY344ZuGkJdRx3jvwuOInEhb5EdBuSSe2qOaCyPhJetOzBRzMPlN2A25WV0lgTn0Vadt4tZj3D/VS0Nb4Ji0SJ5TRt6IW8iB+nWMCwemmOYE6oPxjS+EukkVsO9AVTdUHv5H9X3kO5NtoQVfx9vc6l0YsRYNRoECRzLeyGmsZl4h6dv9Vzezm0VZs4v8gvp/I+I9doGdtQeRnyoIacXxIIf27PcRdyVZd6Hc3tofK79pcnCfMVi4UlP1xLIqwLQs/IbUMv/FCbVY/DYWa+GB3jOxBHzKd37diJ0b7/3Kpwj8W1CquuU
X-Microsoft-Antispam-PRVS: <MWHPR07MB32138B813FEB10234122CC4A80020@MWHPR07MB3213.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(6041248)(20161123564025)(20161123560025)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(6072148);SRVR:MWHPR07MB3213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;4:LH4eJZ06Xk17N/WzmQq0pFENnGgJdcp0/reLo+dGpdMJJHU8L1fvml4EzRG8QebPmEjA4C/vIYcV7fZHMZDkoATbMmpZsXrUKoHfnK9l+VRxcPeKgnj9m3V+Qk/HWQRohsIXBdFEDL/ORV/tuASEPMPhp+vbKFgyechsg6FVaFeaeHdrqX1odHORW2esLex01A07nTcTcWwkrxa7PWL6IHPjkCnlCw9xFf63+PuRVam0wBsJo74tgt6+mJfnF/WaWKsIWrf5haxrTEgv6DSBvIdacb6m41Or7c7Im7uBtW1KDlL38zg2ulbKbRnzeVREBhDJr6uB7tmS79j0KeAjJOVCgi10xyRCIM4xVUV2Acc7dgXej78/f/7ehaOskjgTQ2uA30Up9t0diLEE3REFfOsvHakHEPAgLkJP4/0MRyLjOhaLeiYSGeOw6gpop7mgF22j92YJ+/gIqzy4jc9uyK7tf+U6idxKLeBiipObpSWEMFqaNtJFL7gObVJip9Or/4J6V1DDdgQpmdUNDpuZ+8urHTep0WSJGNbfC48yfln1Ow8zEYBmknhwAGR6J1jc5eXpOapb2JBYe6oTt8BSJS5ibkYIHIgLJw1Xq5wLSPq5K8SqmOo4wg31ezFMkYT7pZCkCk/YxP71c1iNfIPOJH09UXQC0ge87yh7NXFw33I6NVx3ONwIGU15f/1jLPZlUVjGEM8QKcXRDFOwfVsXVA==
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(39400400002)(39840400002)(39450400003)(39410400002)(39850400002)(305945005)(65806001)(65956001)(7736002)(66066001)(31686004)(64126003)(42186005)(189998001)(54356999)(6666003)(47776003)(6916009)(65826007)(5660300001)(2906002)(110136004)(77096006)(6486002)(36756003)(230700001)(38730400002)(575784001)(33646002)(450100002)(86362001)(23676002)(4326008)(31696002)(8676002)(6116002)(50986999)(81166006)(53936002)(90366009)(25786009)(3846002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3213;H:[10.0.0.4];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzMjEzOzIzOlUwckJWVmJIRWlFSDBub05rSmhBajQyOWhP?=
 =?utf-8?B?N3lpYUhWOTYvSHB1dHlGM21YdnJCbHRraG1EYVdsOFc2VkRQOGdvUG9FdjlR?=
 =?utf-8?B?LzAreElBeSsrdGsxYjFBNTVwd3VtVksvQzhaMzhXb2ZhMThlQnpmZnVPeW10?=
 =?utf-8?B?bjg0Smd0QUltK2ZJOG12OWdhSVJOLzliOXZ0S3FkR2FBcEo5bTR2S0RsbjF1?=
 =?utf-8?B?Zjlaby9OR2kza2hSNGkxVGE4K2dPNEhubTJVU0dmVGpaQ1NGVzJUdmlpL2dx?=
 =?utf-8?B?YWRJYklkNUN3YlByZW1lQlMraXR6a1haazdrZkhmZlBUb3dvVWNmaFVVZTBO?=
 =?utf-8?B?S0xpNE5jTU9QNS83MjY5d1J2WkluaFJaeElydnlwT1pPeDBHSHpnRDhvVG84?=
 =?utf-8?B?MlJPOGJmZGxMbTI4Y2M4ME9valpQUUlOeVYzUFVVZFFkdHludFJyRXpVUllr?=
 =?utf-8?B?aTd1eWpnV3J1N0laanpJaU00NUZIazQ0L3VGWlRNRldmcXJybXBFZGl3NHRV?=
 =?utf-8?B?Mmhtd2VvNHd5ejk0WkZSUkU1eVc0NlRDVy9OS0FNMUp4THl2aVdjMUNpbm1t?=
 =?utf-8?B?eXd1Q01La2Z1c1k0NG9FMDRmblc0c0tDL0FzUTZ1R3VYQnhVTnlCRGRYMDFY?=
 =?utf-8?B?ak9mZUhzUmVvdG9XQTZMc0RjZStGMHlwSnVibnFJdE85cXlHaFhVT09qSXJG?=
 =?utf-8?B?L2NMR1FLQStpQWd1SW1od0tLY09PVmFIRFFSRHZJSmhJb2pFc3dxTDB5ZzdS?=
 =?utf-8?B?eHhKdDNwbmtoSUVIRHNxQWJyWXJnYmwxcjkyVnI1UlBTa0tPY3pLNFFUOXZB?=
 =?utf-8?B?TjkxY3h2MnhOTitrRTZGamtoMXN1Z1RyL1NGQzRpNzB1djV3WWEvakFwVnVi?=
 =?utf-8?B?SUNud3ZOZGFBUElNaDFET3BFNHN5RlJETzQ5RmluR0xrYU92c3c1ZEMwb05r?=
 =?utf-8?B?c0dQampaaHQyTTJ0TkhPV0tTWFNqMGJpYjRaV28wK3EvVGliRkZoNVYydFJo?=
 =?utf-8?B?K0VFUXJ5Z3J1VXlvVEwxZWdpUTgrbkVmSkFxdjFUSGMxMEQ5VkJNeEI1dTJJ?=
 =?utf-8?B?Qi9kYzQxSThOdmVsRWNSNUtHeTVraXZUeG4rRFZ2LzRJdEZOVlBBWjQzcjY5?=
 =?utf-8?B?ZmVHZUxPRlJvTnNLbUVabnl6dHRZSW85LzlUOFo4VlB2RjVFSVcySWdaUWJw?=
 =?utf-8?B?QTMwWGRDeVdJQlpXRVNhZ0xCeDZyLytsYjNIb2FyYUdJcmNVRUNzcHQ2Y0pH?=
 =?utf-8?B?VEVnUUpUZEw0YUd5U1MwK2Y4QW9TTXFCM1I5T0tlbE82bEk0S2VGYkIzQnJL?=
 =?utf-8?B?TFBpbkhpZzlOd2hUTnNvZm1GTjZPaXQ4cnAzZTZRcmIybklKc1hOYmEwT0Zl?=
 =?utf-8?B?cXFpenkyOHZkN3JoZEk1cktCbTV6eFhZNkZML0NTSWxsZUZTMmx1Zy9XY1Rm?=
 =?utf-8?B?TVp6M2kvK0FsLzJNNk1MZ0x6dVhhYlU5aVo2clNMZk8zYU5kaHVOZ2VGbEVR?=
 =?utf-8?Q?xhUhwsAF7SRqQV9wg5kT2jbFDlPdK1OcomKcB4/2f6vlFI?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;6:sw6gMUqg9xxZDxoTSUtQhP/qs0uQ0rl6k3BePlXyBDGnzgQC05Wd8FFe20J9NnxIOcTxquxhb6/K+AsMe9cG3r24+wrZqDRXl4SHpdRrm7zcRmf/UckjQQvL0lYcEw+0r8zC4CKv2PtOEnquOSXZtf1HkdlNE2xstTmeGowxd3KpVSW4VxmRZ9DqjEI3wRYxcX+XiGCqiqv/lv+ZgXS0YMXZ4DJDL4aGbhpvQtwET7M0SOwScqOx/YBlsrR8ALBeAbaRdqszm0Xrlma9EMx3fwWqXsTucyjM9lWHUpUGr47wEnEOeV57k+PwXOMrXxAQA07lW9ZfeYqI8qoyvs8caXjtuqBeVKOSfiltcGp1rsRhIKJ5H2mxas4b/NryLavkfQ7ik4TWaVnNsSzISKK30i8y1iyhQ7JKInSpb2Jwi6mgDFgOYDO+2VsOReSm+HVKEaif/AkbxTp2pS7QvojjwA==;5:F6WYHQVEEdHpsJy9HdcPP5PLYDfM8yMByNhMp6sR5GRsKAc/YZL3X1/ssuORco+hvvLZYiR6U31T+DqOWTXBtzcyCzNlhJtAI13mO9Kt4a42amxKDiE+BWP1xFhuPXYlEEc0/s17rEwdxy/qikCHag==;24:XIBxdDKKX002Tun6ITykPeL3Nke0NQpGW29XjFTfPsBJSo0nHOMla5AzNpq4NHTBijnLvGX2RmAqH8rewe15n/D9scSXsvhM7y4lIUN6yvk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;7:CA/Ki7qU+3PptlhwFbQP44FjViozy/p1uLpt5ldZBB/nyKVNtTT03y0qU5vP4T0ex6TAqb7bq6ITcJjVNDhG3pssolxdaD+lYsX4xuNQcAj0tmDgGKu7QdXxkpJMndCE/B2zAppEAJavpfb4nLmZlH0fkexSHpCya9YbIj9wPQX5gxZOTrl7rVSdDVqx7rnLHMxZlSFn8kehh7Eo2caogllRZdXopNdxUC1OmTVr1qj692g0HoXKleGXzrmqwmr+jrtlUWHTcJ99Z6MZ4v7WhoOuMCMDqPge88k/r7+yIsIfu17HgjI9oHFfrpUvLcNwfC1Sk1i+gCyrtUPt1a1zvg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2017 20:52:01.0712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3213
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57684
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

Remove all unused bitfields and macros. Convert the remaining
bitfields to use __BITFIELD_FIELD instead of #ifdef.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h | 515 ++------------------------
 1 file changed, 37 insertions(+), 478 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
index 8123b82..eb80089 100644
--- a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,488 +28,47 @@
 #ifndef __CVMX_GPIO_DEFS_H__
 #define __CVMX_GPIO_DEFS_H__

-#define CVMX_GPIO_BIT_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001070000000800ull) + ((offset) & 15) * 8)
-#define CVMX_GPIO_BOOT_ENA (CVMX_ADD_IO_SEG(0x00010700000008A8ull))
-#define CVMX_GPIO_CLK_GENX(offset) (CVMX_ADD_IO_SEG(0x00010700000008C0ull) + ((offset) & 3) * 8)
-#define CVMX_GPIO_CLK_QLMX(offset) (CVMX_ADD_IO_SEG(0x00010700000008E0ull) + ((offset) & 1) * 8)
-#define CVMX_GPIO_DBG_ENA (CVMX_ADD_IO_SEG(0x00010700000008A0ull))
-#define CVMX_GPIO_INT_CLR (CVMX_ADD_IO_SEG(0x0001070000000898ull))
-#define CVMX_GPIO_MULTI_CAST (CVMX_ADD_IO_SEG(0x00010700000008B0ull))
-#define CVMX_GPIO_PIN_ENA (CVMX_ADD_IO_SEG(0x00010700000008B8ull))
-#define CVMX_GPIO_RX_DAT (CVMX_ADD_IO_SEG(0x0001070000000880ull))
-#define CVMX_GPIO_TIM_CTL (CVMX_ADD_IO_SEG(0x00010700000008A0ull))
-#define CVMX_GPIO_TX_CLR (CVMX_ADD_IO_SEG(0x0001070000000890ull))
-#define CVMX_GPIO_TX_SET (CVMX_ADD_IO_SEG(0x0001070000000888ull))
-#define CVMX_GPIO_XBIT_CFGX(offset) (CVMX_ADD_IO_SEG(0x0001070000000900ull) + ((offset) & 31) * 8 - 8*16)
+#define CVMX_GPIO_INT_CLR	(CVMX_ADD_IO_SEG(0x0001070000000898ull))
+#define CVMX_GPIO_TX_SET	(CVMX_ADD_IO_SEG(0x0001070000000888ull))
+
+static inline uint64_t CVMX_GPIO_BIT_CFGX(unsigned long offset)
+{
+	switch (cvmx_get_octeon_family()) {
+	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001070000000800ull) + (offset * 8);
+	default:
+		return CVMX_ADD_IO_SEG(0x0001070000000900ull) + (offset * 8);
+	};
+}
+

 union cvmx_gpio_bit_cfgx {
 	uint64_t u64;
 	struct cvmx_gpio_bit_cfgx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_21_63:42;
-		uint64_t output_sel:5;
-		uint64_t synce_sel:2;
-		uint64_t clk_gen:1;
-		uint64_t clk_sel:2;
-		uint64_t fil_sel:4;
-		uint64_t fil_cnt:4;
-		uint64_t int_type:1;
-		uint64_t int_en:1;
-		uint64_t rx_xor:1;
-		uint64_t tx_oe:1;
-#else
-		uint64_t tx_oe:1;
-		uint64_t rx_xor:1;
-		uint64_t int_en:1;
-		uint64_t int_type:1;
-		uint64_t fil_cnt:4;
-		uint64_t fil_sel:4;
-		uint64_t clk_sel:2;
-		uint64_t clk_gen:1;
-		uint64_t synce_sel:2;
-		uint64_t output_sel:5;
-		uint64_t reserved_21_63:42;
-#endif
-	} s;
-	struct cvmx_gpio_bit_cfgx_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_12_63:52;
-		uint64_t fil_sel:4;
-		uint64_t fil_cnt:4;
-		uint64_t int_type:1;
-		uint64_t int_en:1;
-		uint64_t rx_xor:1;
-		uint64_t tx_oe:1;
-#else
-		uint64_t tx_oe:1;
-		uint64_t rx_xor:1;
-		uint64_t int_en:1;
-		uint64_t int_type:1;
-		uint64_t fil_cnt:4;
-		uint64_t fil_sel:4;
-		uint64_t reserved_12_63:52;
-#endif
-	} cn30xx;
-	struct cvmx_gpio_bit_cfgx_cn30xx cn31xx;
-	struct cvmx_gpio_bit_cfgx_cn30xx cn38xx;
-	struct cvmx_gpio_bit_cfgx_cn30xx cn38xxp2;
-	struct cvmx_gpio_bit_cfgx_cn30xx cn50xx;
-	struct cvmx_gpio_bit_cfgx_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_15_63:49;
-		uint64_t clk_gen:1;
-		uint64_t clk_sel:2;
-		uint64_t fil_sel:4;
-		uint64_t fil_cnt:4;
-		uint64_t int_type:1;
-		uint64_t int_en:1;
-		uint64_t rx_xor:1;
-		uint64_t tx_oe:1;
-#else
-		uint64_t tx_oe:1;
-		uint64_t rx_xor:1;
-		uint64_t int_en:1;
-		uint64_t int_type:1;
-		uint64_t fil_cnt:4;
-		uint64_t fil_sel:4;
-		uint64_t clk_sel:2;
-		uint64_t clk_gen:1;
-		uint64_t reserved_15_63:49;
-#endif
-	} cn52xx;
-	struct cvmx_gpio_bit_cfgx_cn52xx cn52xxp1;
-	struct cvmx_gpio_bit_cfgx_cn52xx cn56xx;
-	struct cvmx_gpio_bit_cfgx_cn52xx cn56xxp1;
-	struct cvmx_gpio_bit_cfgx_cn30xx cn58xx;
-	struct cvmx_gpio_bit_cfgx_cn30xx cn58xxp1;
-	struct cvmx_gpio_bit_cfgx_s cn61xx;
-	struct cvmx_gpio_bit_cfgx_s cn63xx;
-	struct cvmx_gpio_bit_cfgx_s cn63xxp1;
-	struct cvmx_gpio_bit_cfgx_s cn66xx;
-	struct cvmx_gpio_bit_cfgx_s cn68xx;
-	struct cvmx_gpio_bit_cfgx_s cn68xxp1;
-	struct cvmx_gpio_bit_cfgx_s cn70xx;
-	struct cvmx_gpio_bit_cfgx_s cn73xx;
-	struct cvmx_gpio_bit_cfgx_s cnf71xx;
-};
-
-union cvmx_gpio_boot_ena {
-	uint64_t u64;
-	struct cvmx_gpio_boot_ena_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_12_63:52;
-		uint64_t boot_ena:4;
-		uint64_t reserved_0_7:8;
-#else
-		uint64_t reserved_0_7:8;
-		uint64_t boot_ena:4;
-		uint64_t reserved_12_63:52;
-#endif
-	} s;
-	struct cvmx_gpio_boot_ena_s cn30xx;
-	struct cvmx_gpio_boot_ena_s cn31xx;
-	struct cvmx_gpio_boot_ena_s cn50xx;
-};
-
-union cvmx_gpio_clk_genx {
-	uint64_t u64;
-	struct cvmx_gpio_clk_genx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_32_63:32;
-		uint64_t n:32;
-#else
-		uint64_t n:32;
-		uint64_t reserved_32_63:32;
-#endif
-	} s;
-	struct cvmx_gpio_clk_genx_s cn52xx;
-	struct cvmx_gpio_clk_genx_s cn52xxp1;
-	struct cvmx_gpio_clk_genx_s cn56xx;
-	struct cvmx_gpio_clk_genx_s cn56xxp1;
-	struct cvmx_gpio_clk_genx_s cn61xx;
-	struct cvmx_gpio_clk_genx_s cn63xx;
-	struct cvmx_gpio_clk_genx_s cn63xxp1;
-	struct cvmx_gpio_clk_genx_s cn66xx;
-	struct cvmx_gpio_clk_genx_s cn68xx;
-	struct cvmx_gpio_clk_genx_s cn68xxp1;
-	struct cvmx_gpio_clk_genx_s cnf71xx;
-};
-
-union cvmx_gpio_clk_qlmx {
-	uint64_t u64;
-	struct cvmx_gpio_clk_qlmx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_11_63:53;
-		uint64_t qlm_sel:3;
-		uint64_t reserved_3_7:5;
-		uint64_t div:1;
-		uint64_t lane_sel:2;
-#else
-		uint64_t lane_sel:2;
-		uint64_t div:1;
-		uint64_t reserved_3_7:5;
-		uint64_t qlm_sel:3;
-		uint64_t reserved_11_63:53;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_17_63:47,
+		__BITFIELD_FIELD(uint64_t synce_sel:2,
+		__BITFIELD_FIELD(uint64_t clk_gen:1,
+		__BITFIELD_FIELD(uint64_t clk_sel:2,
+		__BITFIELD_FIELD(uint64_t fil_sel:4,
+		__BITFIELD_FIELD(uint64_t fil_cnt:4,
+		__BITFIELD_FIELD(uint64_t int_type:1,
+		__BITFIELD_FIELD(uint64_t int_en:1,
+		__BITFIELD_FIELD(uint64_t rx_xor:1,
+		__BITFIELD_FIELD(uint64_t tx_oe:1,
+		;))))))))))
 	} s;
-	struct cvmx_gpio_clk_qlmx_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_10_63:54;
-		uint64_t qlm_sel:2;
-		uint64_t reserved_3_7:5;
-		uint64_t div:1;
-		uint64_t lane_sel:2;
-#else
-		uint64_t lane_sel:2;
-		uint64_t div:1;
-		uint64_t reserved_3_7:5;
-		uint64_t qlm_sel:2;
-		uint64_t reserved_10_63:54;
-#endif
-	} cn61xx;
-	struct cvmx_gpio_clk_qlmx_cn63xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_3_63:61;
-		uint64_t div:1;
-		uint64_t lane_sel:2;
-#else
-		uint64_t lane_sel:2;
-		uint64_t div:1;
-		uint64_t reserved_3_63:61;
-#endif
-	} cn63xx;
-	struct cvmx_gpio_clk_qlmx_cn63xx cn63xxp1;
-	struct cvmx_gpio_clk_qlmx_cn61xx cn66xx;
-	struct cvmx_gpio_clk_qlmx_s cn68xx;
-	struct cvmx_gpio_clk_qlmx_s cn68xxp1;
-	struct cvmx_gpio_clk_qlmx_cn61xx cnf71xx;
-};
-
-union cvmx_gpio_dbg_ena {
-	uint64_t u64;
-	struct cvmx_gpio_dbg_ena_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_21_63:43;
-		uint64_t dbg_ena:21;
-#else
-		uint64_t dbg_ena:21;
-		uint64_t reserved_21_63:43;
-#endif
-	} s;
-	struct cvmx_gpio_dbg_ena_s cn30xx;
-	struct cvmx_gpio_dbg_ena_s cn31xx;
-	struct cvmx_gpio_dbg_ena_s cn50xx;
-};
-
-union cvmx_gpio_int_clr {
-	uint64_t u64;
-	struct cvmx_gpio_int_clr_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t type:16;
-#else
-		uint64_t type:16;
-		uint64_t reserved_16_63:48;
-#endif
-	} s;
-	struct cvmx_gpio_int_clr_s cn30xx;
-	struct cvmx_gpio_int_clr_s cn31xx;
-	struct cvmx_gpio_int_clr_s cn38xx;
-	struct cvmx_gpio_int_clr_s cn38xxp2;
-	struct cvmx_gpio_int_clr_s cn50xx;
-	struct cvmx_gpio_int_clr_s cn52xx;
-	struct cvmx_gpio_int_clr_s cn52xxp1;
-	struct cvmx_gpio_int_clr_s cn56xx;
-	struct cvmx_gpio_int_clr_s cn56xxp1;
-	struct cvmx_gpio_int_clr_s cn58xx;
-	struct cvmx_gpio_int_clr_s cn58xxp1;
-	struct cvmx_gpio_int_clr_s cn61xx;
-	struct cvmx_gpio_int_clr_s cn63xx;
-	struct cvmx_gpio_int_clr_s cn63xxp1;
-	struct cvmx_gpio_int_clr_s cn66xx;
-	struct cvmx_gpio_int_clr_s cn68xx;
-	struct cvmx_gpio_int_clr_s cn68xxp1;
-	struct cvmx_gpio_int_clr_s cnf71xx;
-};
-
-union cvmx_gpio_multi_cast {
-	uint64_t u64;
-	struct cvmx_gpio_multi_cast_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_1_63:63;
-		uint64_t en:1;
-#else
-		uint64_t en:1;
-		uint64_t reserved_1_63:63;
-#endif
-	} s;
-	struct cvmx_gpio_multi_cast_s cn61xx;
-	struct cvmx_gpio_multi_cast_s cnf71xx;
-};
-
-union cvmx_gpio_pin_ena {
-	uint64_t u64;
-	struct cvmx_gpio_pin_ena_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t ena19:1;
-		uint64_t ena18:1;
-		uint64_t reserved_0_17:18;
-#else
-		uint64_t reserved_0_17:18;
-		uint64_t ena18:1;
-		uint64_t ena19:1;
-		uint64_t reserved_20_63:44;
-#endif
-	} s;
-	struct cvmx_gpio_pin_ena_s cn66xx;
-};
-
-union cvmx_gpio_rx_dat {
-	uint64_t u64;
-	struct cvmx_gpio_rx_dat_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t dat:24;
-#else
-		uint64_t dat:24;
-		uint64_t reserved_24_63:40;
-#endif
-	} s;
-	struct cvmx_gpio_rx_dat_s cn30xx;
-	struct cvmx_gpio_rx_dat_s cn31xx;
-	struct cvmx_gpio_rx_dat_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t dat:16;
-#else
-		uint64_t dat:16;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn38xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn38xxp2;
-	struct cvmx_gpio_rx_dat_s cn50xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn52xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn52xxp1;
-	struct cvmx_gpio_rx_dat_cn38xx cn56xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn56xxp1;
-	struct cvmx_gpio_rx_dat_cn38xx cn58xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn58xxp1;
-	struct cvmx_gpio_rx_dat_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t dat:20;
-#else
-		uint64_t dat:20;
-		uint64_t reserved_20_63:44;
-#endif
-	} cn61xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn63xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn63xxp1;
-	struct cvmx_gpio_rx_dat_cn61xx cn66xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn68xx;
-	struct cvmx_gpio_rx_dat_cn38xx cn68xxp1;
-	struct cvmx_gpio_rx_dat_cn61xx cnf71xx;
-};
-
-union cvmx_gpio_tim_ctl {
-	uint64_t u64;
-	struct cvmx_gpio_tim_ctl_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_4_63:60;
-		uint64_t sel:4;
-#else
-		uint64_t sel:4;
-		uint64_t reserved_4_63:60;
-#endif
-	} s;
-	struct cvmx_gpio_tim_ctl_s cn68xx;
-	struct cvmx_gpio_tim_ctl_s cn68xxp1;
-};
-
-union cvmx_gpio_tx_clr {
-	uint64_t u64;
-	struct cvmx_gpio_tx_clr_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t clr:24;
-#else
-		uint64_t clr:24;
-		uint64_t reserved_24_63:40;
-#endif
-	} s;
-	struct cvmx_gpio_tx_clr_s cn30xx;
-	struct cvmx_gpio_tx_clr_s cn31xx;
-	struct cvmx_gpio_tx_clr_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t clr:16;
-#else
-		uint64_t clr:16;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn38xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn38xxp2;
-	struct cvmx_gpio_tx_clr_s cn50xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn52xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn52xxp1;
-	struct cvmx_gpio_tx_clr_cn38xx cn56xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn56xxp1;
-	struct cvmx_gpio_tx_clr_cn38xx cn58xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn58xxp1;
-	struct cvmx_gpio_tx_clr_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t clr:20;
-#else
-		uint64_t clr:20;
-		uint64_t reserved_20_63:44;
-#endif
-	} cn61xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn63xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn63xxp1;
-	struct cvmx_gpio_tx_clr_cn61xx cn66xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn68xx;
-	struct cvmx_gpio_tx_clr_cn38xx cn68xxp1;
-	struct cvmx_gpio_tx_clr_cn61xx cnf71xx;
-};
-
-union cvmx_gpio_tx_set {
-	uint64_t u64;
-	struct cvmx_gpio_tx_set_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_24_63:40;
-		uint64_t set:24;
-#else
-		uint64_t set:24;
-		uint64_t reserved_24_63:40;
-#endif
-	} s;
-	struct cvmx_gpio_tx_set_s cn30xx;
-	struct cvmx_gpio_tx_set_s cn31xx;
-	struct cvmx_gpio_tx_set_cn38xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_16_63:48;
-		uint64_t set:16;
-#else
-		uint64_t set:16;
-		uint64_t reserved_16_63:48;
-#endif
-	} cn38xx;
-	struct cvmx_gpio_tx_set_cn38xx cn38xxp2;
-	struct cvmx_gpio_tx_set_s cn50xx;
-	struct cvmx_gpio_tx_set_cn38xx cn52xx;
-	struct cvmx_gpio_tx_set_cn38xx cn52xxp1;
-	struct cvmx_gpio_tx_set_cn38xx cn56xx;
-	struct cvmx_gpio_tx_set_cn38xx cn56xxp1;
-	struct cvmx_gpio_tx_set_cn38xx cn58xx;
-	struct cvmx_gpio_tx_set_cn38xx cn58xxp1;
-	struct cvmx_gpio_tx_set_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_20_63:44;
-		uint64_t set:20;
-#else
-		uint64_t set:20;
-		uint64_t reserved_20_63:44;
-#endif
-	} cn61xx;
-	struct cvmx_gpio_tx_set_cn38xx cn63xx;
-	struct cvmx_gpio_tx_set_cn38xx cn63xxp1;
-	struct cvmx_gpio_tx_set_cn61xx cn66xx;
-	struct cvmx_gpio_tx_set_cn38xx cn68xx;
-	struct cvmx_gpio_tx_set_cn38xx cn68xxp1;
-	struct cvmx_gpio_tx_set_cn61xx cnf71xx;
-};
-
-union cvmx_gpio_xbit_cfgx {
-	uint64_t u64;
-	struct cvmx_gpio_xbit_cfgx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
-		uint64_t synce_sel:2;
-		uint64_t clk_gen:1;
-		uint64_t clk_sel:2;
-		uint64_t fil_sel:4;
-		uint64_t fil_cnt:4;
-		uint64_t int_type:1;
-		uint64_t int_en:1;
-		uint64_t rx_xor:1;
-		uint64_t tx_oe:1;
-#else
-		uint64_t tx_oe:1;
-		uint64_t rx_xor:1;
-		uint64_t int_en:1;
-		uint64_t int_type:1;
-		uint64_t fil_cnt:4;
-		uint64_t fil_sel:4;
-		uint64_t clk_sel:2;
-		uint64_t clk_gen:1;
-		uint64_t synce_sel:2;
-		uint64_t reserved_17_63:47;
-#endif
-	} s;
-	struct cvmx_gpio_xbit_cfgx_cn30xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_12_63:52;
-		uint64_t fil_sel:4;
-		uint64_t fil_cnt:4;
-		uint64_t reserved_2_3:2;
-		uint64_t rx_xor:1;
-		uint64_t tx_oe:1;
-#else
-		uint64_t tx_oe:1;
-		uint64_t rx_xor:1;
-		uint64_t reserved_2_3:2;
-		uint64_t fil_cnt:4;
-		uint64_t fil_sel:4;
-		uint64_t reserved_12_63:52;
-#endif
-	} cn30xx;
-	struct cvmx_gpio_xbit_cfgx_cn30xx cn31xx;
-	struct cvmx_gpio_xbit_cfgx_cn30xx cn50xx;
-	struct cvmx_gpio_xbit_cfgx_s cn61xx;
-	struct cvmx_gpio_xbit_cfgx_s cn66xx;
-	struct cvmx_gpio_xbit_cfgx_s cnf71xx;
 };

 #endif
-- 
2.1.4
