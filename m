Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:41:18 +0200 (CEST)
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:33276
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992361AbdI1RjI3crJF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kFc7RypIqi+Tf8KKrP3HjVV+9hg/bYjR03lu2poGV4o=;
 b=IOYFci9Yz0mCevbadec9NqwimzV/554UkmvJql81hxKHefLhU98cmmJ/gVmFqQpk1mKxKoKO5xWYEFq9/CN4HLPwHlB0eFSJ0ZSZHi97TY/jjP2PunBltr0B+FrsvPD7br9vQHrpz1cNUcTDaj6p31U9HutZ+6NIf932TXLdyog=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:39:00 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 06/12] MIPS: Octeon: Update CIU_FUSE registers.
Date:   Thu, 28 Sep 2017 12:34:07 -0500
Message-Id: <1506620053-2557-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c93955af-13db-46ca-4b9b-08d50697ce3b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:B1VbTA6H1m3/i43o5pGTT8ZkoH+Lp18wIdZDZeeJ6w0UghQyq60hAXju4tWw8VxhvVGRsz63VrTeBPwqqjMM7ONHCoM14+6v6RjWdxXLFPnL58ixa9p5mEpqRoS9JahU/Zu4RhTI+5l0P8Sh+YbI+pPFxJdaYV9Nyq6wDWMw2M9DlDLhIkmsugQ8qXAynDYaxVYJXcVEXfxSwPE7Mxlqw5zeGiZG1lKbI/1fNkxOyKiZ5RkEPlf3UCNDeOvUmHr+;25:9FCXCDPlhds/+CM/goKXbJF1MGFGB/QRmRHjbEhcoukFWoLWze3wqDZdE6fDxGBx9bhOBlo39i7kIH0EDYORCOWNbaZAP1qbRBzUtFyT3ewunMsQ2rY/JobaofRyT2tc5ykQBeM5DYA5QboKBUqf3bi7xcYvh/HjBDYVKdnmw8fqj4jHtgG6++dhzt48RS/PyE0kS73pyX9gdyswrvNs8JuADcbBcxP51wtWTi2XFUaMME97ggTbazV7xvnZxuhXgRswiimEDBq3FgHpW0oQ4FHLeQLuyhJjU4LHrPPU2Tzeu1bNrkRtXfLVPrIXtms1lmA0yD6DU87LOWIF7iAq3A==;31:D8W1A9Fgrtd7VInozri8DF0y1ycO4V+OPuSW1xzGSjsaKyCZENZ2S3zsqOgkOeDNXk10p5DiP6KcAvxZlfxVCGGG/Oovr1Dq2STOHtmQnd4BP5VIQXmPIM/H5nOb4XEJPNfMTlbRsSS/PrxJk/A/qRftIuf6UNRYdoOa2we6c9+QmMZmJbe3dK3EZLRccHhPhscsqhRGaVgRc+7w0DTq8jY8IWgUgrJ9+ohtIw8KGN4=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:+PkvQw1JWadpYbdnPP/R+pPM99RUgPZkWW4wy/VzcBWQEuwxBTL9tzGCLO1OXdbhtKRXRfAoaKWfC9djcTKOzc13V5rBMSirfNyf8Y+O4fPZfs5W4EParDbDEwo9yTcnJ0empEeJYIfIydk60XFcMrZJ1TYuQsp5Xwm5ywVb+Sz4YTnWtAqGH0yBwpQqiaYpsL19koNk+R8C5v7HvUGCDCJIKlsDTLpkfA8bA4Pmy2uFFRC7URsv8tDepz7oquWeEHi7Fgz0t+iMcLkJFs9DRXvGHQ/e0MeU6LgHtLUG8OrDSu69/rVxmYh22KQPPnW2zIz2OOuGOFsFANpiB3gkfcPsg9YGQcTRIkNq5EbKX0UYf393SPjjA3z7Xu5smIwjJxHJTxmFIEU0LCtD1m1EAMUDyLfho4Um5vKrZmd8jew3QN/z+73SBOl/7FcxiXnNqi4r/lTU4xsY9cvlHfLiwt8QVJ2b2AtutTEXCm8FwuQ15ehoMiOoHxD/2x0jKg/V;4:oje2gPssySZX4TbJwbHKEiUruhCWAc67khYQPQQsDXYx+nA4ViN+YV+qeJqQOxj8u8aec6/tlNdNSA+krkrln5wwAOhpPrF7DYJq/uBBOGMmlJgfw68Fv3tkQcmmZu29sP+qo8zlhND4vphrXjd8pN9BABz8C5PzvHKP817n6yVIltgEG/rumAFzta+NCpS73ilW1sHvpsJ/S20g6SZI3yT3xD8m2szIXf+WMBiq1GWS/KnIhsm+K6clGa6kNgAZ
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807F49164667A0E22D7A8B480790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(575784001)(3846002)(15650500001)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:7BiKNCgXVGj8nw0AuppOEnBEcrrBMYBHcAa5u1n?=
 =?us-ascii?Q?ssurWEUDDzwPU4GElzNlBvMdHElxTZgOUAlTgagmBbYlMagYiBdldwkC/4Ey?=
 =?us-ascii?Q?MGLvJtfAqf28+I3Y1grJtGNyXPJYmdw0bUAm/XOQjPnqT8cUf4CZCfj4VbnR?=
 =?us-ascii?Q?3DDvdkFz21EOtgObMPSuNuzZyEpPlqU6teiFMpuDx9TpnJvMguI9Nqz5MSUp?=
 =?us-ascii?Q?b7hm7kO0g2RdCQlmCwk+PSJswBtMzCxVxunCMNvIGmnnNt21POji7Laouhdz?=
 =?us-ascii?Q?QngxfynKRNOc/NZauPwDm8k7DXQu2EscLWmpGM0OuzLwUwjXnYkI+1lrpOe/?=
 =?us-ascii?Q?qmWUmFYa+nokzRb2DIpZH5tB9yLLpFKhIiQS780lRTSLCs7tNl2EGcembXas?=
 =?us-ascii?Q?3hSUqwaIPbuVatU2BKryYgqHWEDxHcGtVOoLExDKSXkFXHUNIR9ydqEN+TCX?=
 =?us-ascii?Q?7qVwsw9Nd0NycGPRiD1byOwzeTaMpCI3V/VHMt6su5v5OJoXUDb5ek3eDLbC?=
 =?us-ascii?Q?uBOxDqb94mH/UQP0D67pcvOaNrYjFSKe0lWBqREcX0S5/NcANMC1m92z1Pss?=
 =?us-ascii?Q?KQQl0aEpHjQDBqXL0oSGT2+nLCbA7aMVXFniVdBiYEN4m2mVxiF1I92LRFWS?=
 =?us-ascii?Q?eAF8bgNmKTn8Q8ErRalliQh3rBvxTB2XyncO7I/nu1mrfLjo+2zLsruEJdN3?=
 =?us-ascii?Q?g5qn6HTIwOiuj9PTzL08lH6/I8avXoTnwzZrlF3seCbJcSI+kkusBYK61s41?=
 =?us-ascii?Q?4U1D0g+sbUxwumbmfkZ0OACT7UmaA10T/n9shroTim2o9dsFfE/efO2QCFLF?=
 =?us-ascii?Q?nNMAbXk5GTyxXVdmxav2eImE1HvK70FxR3hOXMxMCW3T6+/tCJkYISB2dgho?=
 =?us-ascii?Q?XP/JU9Tq7/v4jCP1p7H+olWSFgx7zaMETORPgNU2BELclOAPmvRjtQTvGPuK?=
 =?us-ascii?Q?lIY/XWrsOy2se4nSwbn67PbpYaWQH0sKLZz4nQxFAqhexsfkNNF+TgSJa4uL?=
 =?us-ascii?Q?5GVLrThygmoIuht2yb1vM56icbPU7Vf8rNiFfw/H+o8qI6y/WsEslz30xk67?=
 =?us-ascii?Q?x9nlJPI0TGy6ikCfCIte/Z1YqW/lejnzuuYybRdaVDZY/LerLg7yZADotQYk?=
 =?us-ascii?Q?mHHzQMa0BBdjtjryRruNS1/kwXaENo3xcTdQDWWxRsJQxEL2k9z4l681nADU?=
 =?us-ascii?Q?inWstkemBry7P6MqgCVjotj+AQnWRsupLI3peGZbxUWg3i1NKQgGSEM6/zoe?=
 =?us-ascii?Q?qJxeYZLZtcxPZIMwDuGs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:CHWuBv/Pbsn2DcKQWUDk0NmlRzPf8aOXFAPW7/Hs7Ho/xygzIVXBkDw8Uzm3Z3+1pwUoImNABZZ1G5JiLDkvzpqWns5+m3HlVoAviCCHjRCTjUFoCmiE678EbYkpGRLidk+7P+u2C9lIv9KIbpCxrACK8RPdwNGfTocb4AQO/Pbwnz85Qwwu+gSTICiyJ30Iqng2DR5SchcNAdIXDFcB6FtZFyvtpjM38pcGGXpwWyLJnM9pU+pdXYzRgeoeumtkee0E7iZ8Xx7jR9a5N3Q4m0GfeScEJQn+pmfWPO7xDsFzv3w1hzlbBzKwhD11PqK7WETXozCwx8k0GkzW9acqww==;5:IwGD3PpDA3oeoI7tpHGt5QpAVFaWYuvoc3YJk6BixOsDVGGMHACi+s8spgMHTGujitD16s/dTJIolkHtiln7GDzGqidLBZRCuiqAyPyQ1QHMXdoLgDKUgBn05ESGQPYAWynkWSRoY4kfzw9t9LMuyg==;24:swywdehXM2HZLq6xiJYMgtoXmB2X1D75dz5u7UD+YYtQptFnO/o9kMjCJBa+uGMK0yYzplTF5rjuu/bKU9yo8qshNx3b5NC9z4Liy801Fcc=;7:kJVOIUmfm5HdyLTPZeketLccn3bk32Q0VrAzhTrGXmeYEZuZHwWi3BVoJ0m63TdCzzW+sgh0k4q0ww2rkkjpk6JzaApnxxTmSfprqXg6xtNUiLLM3zpQ+2Kq55iZHwacLxg3SMh+ibwX6uVeQsKMUjhRZRvDjEeFsNuDtcLpUW60yWJZIa08p48krmtM6sQ3Mgb5kjIAFN8SnHvafv/ooQj0miux1dBXmsagdOFaD2M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:39:00.9020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60190
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

Update CIU_FUSE register to support newer platforms. Also, simplify
the other register functions. Only values for CIU_FUSE changed, the
others remain the same.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 166 +++++++++++----------------
 1 file changed, 69 insertions(+), 97 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 6e61792..4d3d36f 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -43,7 +43,31 @@
 #define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
 #define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
+#define CVMX_CIU_FUSE CVMX_CIU_FUSE_FUNC()
+static inline uint64_t CVMX_CIU_FUSE_FUNC(void)
+{
+	switch (cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN68XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
+	default:
+		return CVMX_ADD_IO_SEG(0x0001070000000728ull);
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
+		return CVMX_ADD_IO_SEG(0x00010100000001A0ull);
+	}
+}
 #define CVMX_CIU_GSTOP (CVMX_ADD_IO_SEG(0x0001070000000710ull))
 #define CVMX_CIU_INT33_SUM0 (CVMX_ADD_IO_SEG(0x0001070000000110ull))
 #define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
@@ -64,94 +88,47 @@
 #define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
 static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if (cvmx_get_octeon_family() == (OCTEON_CN68XX & OCTEON_FAMILY_MASK))
 		return CVMX_ADD_IO_SEG(0x0001070100100600ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000680ull) + (offset) * 8;
 }
-
 static inline uint64_t CVMX_CIU_MBOX_SETX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	if (cvmx_get_octeon_family() == (OCTEON_CN68XX & OCTEON_FAMILY_MASK))
 		return CVMX_ADD_IO_SEG(0x0001070100100400ull) + (offset) * 8;
-	}
-	return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
+	else
+		return CVMX_ADD_IO_SEG(0x0001070000000600ull) + (offset) * 8;
 }
-
 #define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
 #define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
 #define CVMX_CIU_PP_BIST_STAT (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
 #define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
 static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
+	switch (cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
+	default:
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN68XX:
 		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
-	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
 		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
-
 #define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
 #define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
 #define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
@@ -179,36 +156,31 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 #define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
 static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 {
-	switch (cvmx_get_octeon_family()) {
-	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
+	switch (cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
+	case OCTEON_CN30XX:
+	case OCTEON_CN31XX:
+	case OCTEON_CN38XX:
+	case OCTEON_CN50XX:
+	case OCTEON_CN52XX:
+	case OCTEON_CN56XX:
+	case OCTEON_CN58XX:
+	case OCTEON_CN61XX:
+	case OCTEON_CN63XX:
+	case OCTEON_CN66XX:
+	case OCTEON_CN70XX:
+	case OCTEON_CNF71XX:
+	default:
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
-		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
-	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN68XX:
 		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
-	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
-	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX:
+	case OCTEON_CN78XX:
+	case OCTEON_CNF75XX:
 		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
 	}
-	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
 
+
 union cvmx_ciu_bist {
 	uint64_t u64;
 	struct cvmx_ciu_bist_s {
-- 
2.1.4
