Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 07:16:43 +0100 (CET)
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990590AbdK3GQLz6Lxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 07:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AF5YtXFdZiYRoDo8ZekL31nKCbC/Ftb+o7uEmnPGPQw=;
 b=HrxEVx6IZw2FTSEAkxbK5+PsL5p3OMX/oIU/dfSxp3tMwYoXR0QeEDSYmi93Hf/iJfCE4NxM+sjN3eAt3UW3AGJLRT+6D6by9QFMMby9ZOLnTpCpBBmzdOdQMheCxH+OSqTk5SCPIC/sup5kqkPrtc3KgZ1dpiO1YkWR2RqvfuA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.260.4; Thu, 30
 Nov 2017 06:16:02 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>, ralf@linux-mips.org
Subject: [PATCH v4 2/7] MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
Date:   Thu, 30 Nov 2017 00:06:16 -0600
Message-Id: <1512021981-15560-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (2603:10b6:100::42)
 To MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36621841-5568-4be4-97e9-08d537b9d511
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:O54oIizub6z41/srHeJsjGCVM4zc5fx/0f836Y1OiwNAyPXXPXxkgyNYipgyEyCR8Ay40SRWnCGbn2iANXbdiHcmptDyvdOLnT71d2VALdemo2QffyOQXlcCa4HR4P1M+mOJpcJRGzMGndchGJaA2LF/yCnE8PcWEckyGAw9aQREQe3G/kKokmX+JRtnyyIFLNgdw9FEZ6Q70FNpHu2QZWDu/eE/McsnDJm7LTfYj7dyMT+dgk/1QTyQIeDIeekO;25:FrsOY3kunfx5SiohboJoiuKTUXw+XiqB9cA6GcnkU/omfcuUCvm6JUjRu7VRA7T22QMdLRumpqdH6GZL8WPAMxUkKLzG0Ny9FJHGVbt0fgS26mABe5HZ1TnJ1NExYi4zfOyuRY1nq/smFhqJsdl5Y2X7wcDphcScKy/sJunuf+fwvsfZmQD/GJ97IIaoauIZ4gMEEWRp8bK4ZVvWgTuC/yaW3QPi226RaQM1scEo6C01A63HRuTHaiGC87TSJ1cyzVSUfegQf0mZbgKjNDR8Gd3CglHsEY2DB+3+wXWx5cBnqSEvzJDbe9wBp4+S+9Y+bwjyEmhwilk1VwlflMpcwQ==;31:CuzigHqj0adfvvf9SaHn1Lbpj/rELFUVIAekyS439FiVTzpd3cS+evvAfrBzvxi/pFQGvsiB3R0u62su3icbbagY408kagNmWm7YTmTxs74oEDOuGAvguujwZX53jUkdIakY+8Axk+xBtwHxfO6EemfF6CU0iGbn4Vt1qi0h/Uc2a9smgKEAUCeIbzbxutd/SxGaZvMysSvrPpgZSrS/6PXsw+ar0P+8oaMaHnUxRTg=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:aVfTX56UglD8TLaBn22WxsdJk2QiWUDmNAPmwZS5EMuYD5PXYJgzvmo06jweA2buHVQ5L1G4tgazBuqUC21hYYIWWCONn22rVZtNcVsx78VbkHuZPk4o9Ssra/oAMzkz02kNyLUE6KrJAUUE4LzigRn8eKVbS0cK6s62M/D9/cWZdMxWA82a+MwH05+yN08ZfpQVEGiaT58ubUHekegmr5Ql9Uz9LV7dHgu+/tG/4zR3j63L6CRlAXxOQS5p8CoXJincPYmsmrBKPOwvu1UqLoH9kC9wkAAYSUY1WbRI2n4fL8oEMz1F+dbtrmvsaW6uRZb/q0CzJw5Nrkxt7AGlEI7it848Lbuf4RNIhY6q0wd/unxdIPF0Yjokl/mLWSPNZMOota/cypc/BTKcWgXkvxgSTa+Fcclm5BzTbIX9XLaN0suXzW7ELaomZDyCTUsyaR3VHpQIPsVnY1Y867ickKCB/OltxGqqHUIxz72krkXnXSO+6Nh3u4U7drt/THRS;4:VrlvfWqJib99L+b9A++sXi0ry2c4MJ+SJI65mzOOPkNSnIb0uJVhlP1f9O+4Ap4nM2MAEpcS7dGbW9n8vMPJmCg1aolBwNf9COJKUKRdnndpmunJ84CgF3c51q8DyEZuPnRoC89KFieZ7WY0+Cg2fE6skYF6FJ5gHNiEt54YxgOon7RZ8e1/GlO8S4vewUdnnSC+dC2F6MijuZ3KR0Mu3yghCNkXPvSk+54awoPFWLKrNC4SAuNlE8bIm7WdbkgdaGciQVFrKlNnCAk4AXP3nA==
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803D6B5CC227738380E690080380@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 05079D8470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(366004)(199003)(189002)(101416001)(2361001)(53936002)(72206003)(189998001)(53416004)(51416003)(6512007)(33646002)(2906002)(47776003)(50986010)(36756003)(16586007)(76176010)(50226002)(316002)(6116002)(2950100002)(106356001)(68736007)(6666003)(81166006)(575784001)(3846002)(5660300001)(48376002)(8676002)(25786009)(86362001)(305945005)(450100002)(2351001)(7736002)(8936002)(50466002)(81156014)(105586002)(52116002)(69596002)(4326008)(6916009)(16526018)(6486002)(6506006)(66066001)(97736004)(478600001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:fiScdxEP+9afrA//e+GVxXgyqoifk7uqYT/p3a2?=
 =?us-ascii?Q?YMtBavXnKFyqIIVQylSlNEszZb+lDj5YJFVYChxxWstWZCb828snk28AJL1f?=
 =?us-ascii?Q?/Y5QDwklnTcBG+wrDduWISFkFbcQJzheXptyH9YvFSlZ6Z8smD3Bd/7HcbFH?=
 =?us-ascii?Q?lqGxodOP1ofV5s3jCQxFihGBvvPnKmGrGJ/BWUIv7hzx5TTPVHuhinfNgnDh?=
 =?us-ascii?Q?YnVy+oNBDL5SrZZPz4WOJnzjhmnudyXsoqgh8ZZeWGYKwA4WhGqi3Q2CPRfu?=
 =?us-ascii?Q?vdMUzeDA1wWO44sJIbukymrp1VRvEa6yvR/7/FggR5IK5DJhb3sYqFXwSeTd?=
 =?us-ascii?Q?biidEglqBsYJLsfT7DweYapBPwKOJiyliDuGypj37YBuUTCoPgig3bbzatGr?=
 =?us-ascii?Q?lVa9SbbvhgoBTB+c/hivU9WMLyMfxul0o46KUH926Vq5UANvGkKY4aDn6y9K?=
 =?us-ascii?Q?mvjJYUy4Ue0WoofMzblO2m3c0UKAssyaqAKlNh+Q52tJSf9bp36jaNXJOh+0?=
 =?us-ascii?Q?J97oJXOgerBgd0+PQcULxi/kSLRFKxJExmSLYTHKb6ad7uwEOgrTzAImNd2p?=
 =?us-ascii?Q?S9FD3oJk4Po5EkAH5a0TD3aCwQsSop++5XsVkB0qlD2edVJWdjKDMd7prblf?=
 =?us-ascii?Q?57+6nzllzaUMLvuUoFAyWjJ0Jlg0SCs4S1gUFlGpzRBuar9v69YHmNKegefL?=
 =?us-ascii?Q?BkDvFr10HaUmLVD5ROA7Zno98R94TCSzQ3hqdXbvZOCtoukHF3A0vId9H/nD?=
 =?us-ascii?Q?pVivXl5cE5Gv+7dZbm3pV9C1wEs4uMIslR7j81sMTjvC5Qh3JI61iS1kIW8/?=
 =?us-ascii?Q?ra5nhyC2hx85kG2Nsz3gvtNGdPVGUETVzmJfyMX9WJsuarv6R2tAFZYMhen4?=
 =?us-ascii?Q?mhilwkjbr0pkF6ci1nV0D2SDXwd/YMULfSs204VbkQfUGfCeqjpSez3dXHXc?=
 =?us-ascii?Q?7NYuAkHWPRjY4mlbnzJrFsYDY6TiUXc0dge9SP8j8eJt+i32NImxwia9OFyO?=
 =?us-ascii?Q?2yU+Y8z/RTOP4s9fmhJsxiIZUavMvE+tTVt3BbWYUQtzPp4s60ESOx65tBRf?=
 =?us-ascii?Q?q/2Uun5qnV29OjMraoZQFDe+58OhI6LPFLO9P899Eo8BbawxrM+TksKyApUb?=
 =?us-ascii?Q?p831d7Izjxlf/fZryAmWnm8kchp7hE4DAHNsgz+vLJhVRBUoJN+M9Dc2HItw?=
 =?us-ascii?Q?kjrPj2W32jwCVFWm/Dc6JmEl+frr4Rh/P7ls4tg+EsOmH8u8UXPpjmvFTNmh?=
 =?us-ascii?Q?XoykXfY2ipJGlFfBGFrc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:KxuIYoJEdRiQLo8H3L8J+Npz8R9EXSVm1T0h+Qq55XXmcL6ZS3vBxNp3TN6assI/WRq2skhpypJbge1RGk3rxV3hsOY8mjyuwi/UIWr8Y0fovjDO2symyNlUXfqzEO0N7VdhTJl7aRs0dOY1Lsi0CdOuHOuRHcPklJpomJmuNg1hVvq4Bh2qzUht77f+bSCZzmZXzvk9MPmmCMXInji7jbcZF+IlMHPpSp1PHe61NeWRACLmmy2NM6Bi2i1LYL+9V8Itw0Pc2rTbNNMfqlhcINzSvW3y4qSR4rmyo/65sCy7LTNNN2AaUeGfflMi6u7ennjKN41KOrQqhZhyk9XoZ/yjqj/VSScMlzUTyCY/sZM=;5:2LNK0rKQZJnDTle2ngoVLiIBcVnY3XXR2Mba283L0NiyNkB3dxk4K2bqJlMVkQw775LFWCdv19XKD1JV2hr9n1/qkEQk/Iw1RonfVZt5OSX4p47qzNAPixhVpMW1jdfk4K2vIIDV/XBB2ksq8Vni3neE0J/PXntLpg1Jl5GTlEQ=;24:zxrCJBHke7u5HmXw+197ll+2iAllqcumVon/4E0n2RekOy5xImZF5gU2alK3HleXJYG9pxHlkg/c3cKhnCPnSOuypIMpX9V7i22+cEGHD24=;7:PleWSngcFk0hw+zw1X6EQoP9qk8QjiDLivVanyC12tWSjpsLTK7V+LR6DMTK72ErxuCeKynJsnYqujNDMmHAZ8oHJk+snVKwGqpKo9eDRi+iIT64mLioLf5XQ7V/OMfLNS4K8/CwXRK5+xEgEKZ7N3yS5u2M/7Q/KQrE2wgSUE3U/iM6xLTYRR/APfP0XjBpblde6v0USGLfUV6vFBJXfMvlgfgEb3sqkbsVieP5TgnhKgbIhmBTVDimSrRyaPhx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2017 06:16:02.1908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36621841-5568-4be4-97e9-08d537b9d511
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61233
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

Values for CVMX_CIU_FUSE register was incorrect for some platforms.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index af9164b..2ac8168 100644
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
+	switch(cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {
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
-- 
2.1.4
