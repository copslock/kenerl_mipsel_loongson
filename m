Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 23:45:09 +0200 (CEST)
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:55342
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994604AbeGCVosraoq9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 23:44:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE7R5mGV9NfPm2nFJ0tvXuXRCxijQ8QwJKQQBiGHqzE=;
 b=kfQwFvmWXemNGqxT0nhiFyjRpRhTCBSADLqNZ6uxoQK6fJH0hvx8hM90pNZxLUBSzUWGFTHCvYylL7Z88VMj1xoN/+5CgUCqlk1u2HOv1UzoxQZSPk5lGNWB9rW8en3hS2wTb+VQosqHg3bGic7EzFbXDk2HBG5gPvzeB14oPM8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3960.namprd07.prod.outlook.com (2603:10b6:4:b2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:44:34 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH v7 3/6] MIPS: Octeon: Convert CIU types to use bitfields.
Date:   Tue,  3 Jul 2018 16:44:22 -0500
Message-Id: <1530654265-26949-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
References: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To DM5PR07MB3960.namprd07.prod.outlook.com
 (2603:10b6:4:b2::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f522ad1f-e129-4639-6a84-08d5e12e2b3d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3960;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;3:cKOyHZJVROP850MX9NPTXLs5xGfkE2hMcX0OHleO4MdN9GoAQEXK0RBjFEFyynO438eC6oiaPTUZZCXg5WgXHfGFv6ohvaxutsVuzMzYKHliEq8dMiIiZ3nfE+HoHQUUrD3O4csaprd+EGiLCT+rkiW/oL+whBfmExHoFEI+fCeN8w37eonPzhIPiHWT0rCBN1LnU8ahyN8/p3+fFBuq0KqTVPP5/Vj8tUbrTMZ1JXqfTltlidarSJS3N57zxjAK;25:Dgp9DAagsTmazBTzt/Htb9J5ZokOCQi08I2m7KPLV37vpQM60fAZMrEADJJ33qF12E5tU4stEvOxUEq85b7DXa9/Y2yzmpDr8JRnHl0y5bebcAWmUci6qrhs2OO6RCgZUnPwlrvHL1RXOAzwkpktkQd0arp8nL+CLwtqfOWMJfbfSKFh1tSZ2IRgCs6apYYwiJQAvZA7dV5SJbPmybNVI8ge+PIJg5r9Eo7nbXjsIwLNaPqNRr+mWfljZj7O7Mgst3cTG6du4/SHnhWb6dy7uWcW59/xc+ATNc1tBJtL5u4LnxscDJwmN26MwjSNST15N5JOkIsQzi+MHEL4D35pGw==;31:BIByw6gD3jK9bBeE1o7+Y0E8r6bjtUnYPgb00g2UxzfgKadJ/OY+tsPZZAl01Tw27J4A+5dZdJ1QpJzCjo8Is4Gk+uo/0Z4Jf9k8d9ReH+T7yfipEO3Ihio/NuORruY2Ut67kAykkcQ9JasQCcV8ZCPv0MFeeeFxjfR/GdFrT8it0oFnjG0/NjZnMku0OigSHD5F6OfqyDkUb9FQC703xEUyWAQTbUQQ2ti119GM4tk=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3960:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;20:K7jTBcG8CtDLPpPwW7AVT4lKIGkHCI5T/ynorUJd80f5BQjuiAOEWBkH9upMGrsCo5M416EBeIui9EvOk8zwYR9iYc2emWZ9jRvoKDlDYDLfeb83SmwxD21TNZPUzb1m2/WWtNQqIXDdImx3sG2NFMUtf0mCOQWt3szN8IIrLuHeI6b7gXPnFaodV4q6J0oCqSVPkzPkYJQYqz9SLNqvJ34azEedyfbTBHOz840hbFqOB7CF/3e8mNmSHV6aZQCdSqAsf6373sJhgc+kdaK6lyZzH72SPAOppW8ETuZ9Z+UcuvHkSQMkjTljyesLVKEAnNyOsl9IzCFpB+R7gLHkAzF+/wgCQdx5V8CW5qmLiBwbilBGlD/4/IlaYxup86TBfl0SWSNzPOL2znV1lKdBof0Xv7VtBiW6ajHyytoXBoOMkZkzD7Km0rTvBeW7ZwH8ORn3avMfwaocNufYWLYIkcLFNPILtcmae42SsgcDdacZcR0eTCuoq1sCZOXXmQxt;4:7WvHEIIaylkV7vEqTcebCYHGv8rp1tJKGQZbrAhOVXzRbNXFtfhOIBJE5VsgdMkvhBKrgXEhgkY9xuU3vBs9VZLI/6G8oGTU2ha3UEPJiM4JEpGoVNMH1omaktJdKSA8Xapx1IZSGGi2PRxbAScErHpodJeH8cetHdpcnYDe9TrrAZwycATpuCOiIDE50AjgpnKJWSKYp1UeyjxuWYagim0glRAEuMpzzuG5d/UapJvenJzNIPQ7/KpZSkpMAhVyGbrM8K2Tf4v4NJWpveLqYIY7FV/rtOfuN+V+KwY49K3up08wIHD5ot/s3A4kID7Sfge5IaQXTNiEBnONzj1azdKbGug8lBKDQJ6ZbLOTViY=
X-Microsoft-Antispam-PRVS: <DM5PR07MB39601BECEC1DFE628D65C87580420@DM5PR07MB3960.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3960;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3960;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(6116002)(5660300001)(3846002)(6916009)(72206003)(966005)(97736004)(6666003)(47776003)(66066001)(6486002)(53936002)(68736007)(14444005)(16586007)(107886003)(386003)(36756003)(6506007)(50466002)(2906002)(48376002)(186003)(26005)(8676002)(53416004)(486006)(2351001)(76176011)(2361001)(105586002)(106356001)(476003)(446003)(69596002)(11346002)(25786009)(50226002)(575784001)(51416003)(52116002)(956004)(4326008)(2616005)(16526019)(86362001)(478600001)(6512007)(6306002)(305945005)(81166006)(8936002)(81156014)(7736002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3960;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3960;23:wJOEU7szbamNOffdBPwYtJvnzF0KPid5ajvNWH1I7?=
 =?us-ascii?Q?kkoERoCX6yarCRmSujXXFalV2qGTwqqlyz9M0PomD4QMoDCuXSGw/DnxNdVq?=
 =?us-ascii?Q?jcIx7X4RDCz6L5TAlBePJGoPQXw+WQI1GjyPkH/hIxFUcc7iBSYJq4WZXiAI?=
 =?us-ascii?Q?yWetAIGBgOgZFjPZHPJRcgNgoM6ZMLr16U0CtjSkI5qBRgU4fGyXbnk3revu?=
 =?us-ascii?Q?aStG+wHKDGSAM65WyYS8jVRlllCoTWDYWfNJnVXH2ucbko1p4Vo+w2k7Ipe1?=
 =?us-ascii?Q?mZbfD+ARsIHsAHigXswrX1fWJ9MLUFKyhxVcJ1kZAxwIaKrwfLbSM7VXgQXY?=
 =?us-ascii?Q?dmbRgXkpNl4uqNu7J15M/irTtcfsS+hjoUdH6HJ7z9PpAglDnl/6nlZvtwgS?=
 =?us-ascii?Q?SuUdry0VyID6vAaQGsq6GQOWps7lr+nUehWexUixlhTEdP6s965JNF1haXZG?=
 =?us-ascii?Q?YMyqSauDU957L1HYGE8uZllw2qrrkti1JNSSj5pEA79SAR7MxgQ2hm2q46Ie?=
 =?us-ascii?Q?LlR9QZvIZRW3ZDU4WxNzKnpj9rYSKgDXvtrGJb/O+ua/cgLjqBhg7S+S2RWL?=
 =?us-ascii?Q?YbZ7Usal5sViURWIQ0KFsz6UmfZp/KvAFkGXBJ85xAcfsM/3jtmvSYY7g6xr?=
 =?us-ascii?Q?It2aagXyWyXcrqiRyN1MsCr9JWTHHIqcgXMePLg1UsDmzhf5vQj4aECZtTnE?=
 =?us-ascii?Q?QVryYIU/g+JkmVOrT22tMSECfVT/CNxptwfYqZw1PTvBAq5WYP8vVvxeiqn0?=
 =?us-ascii?Q?Aj6dKmQHSWpQMVdHTERhXsBKB1ch5mK71y+UWdTiTbIXOEDIHJ0We3je8HKI?=
 =?us-ascii?Q?54DfhAIm+q02WjzsL25QWSdJN1NDdNeg8Sp0xBPNYnGXO8XBuufYNRoSPcKI?=
 =?us-ascii?Q?G+/kHip0iBbC2r5Y3oOPDMTBiB8yZO9G2F5c8BVJPL7rc7Y0SNHFBMwlzjON?=
 =?us-ascii?Q?mLCzFlQgfMx/1T4/GkfRZQqmSjVIHTnbQoDJhreap4pJR6HhruXsZeRlmOZj?=
 =?us-ascii?Q?WeBoutz40FvnxmMzRk9By5x9WXQGSCHMzSqB51pdetiZLVmU9CIIOFYaq+Dw?=
 =?us-ascii?Q?KBI6yvihWUS66I1gfc0+NfJuX59uZjq3V1CT0gKi/UIiELc53OPIOhQ5Sb7M?=
 =?us-ascii?Q?cebU8PL/widJjXZVpmdLz7HU5zxMnku4vUyf5CvuGf5pSL0YUQ8ovhEnWvOb?=
 =?us-ascii?Q?jzddaT3fHcvOkH5sH5CAHev79lz/tsYDjNvjpgoZcPTaYBvhksovl5LXGTEd?=
 =?us-ascii?Q?NClgNJtll6ZtX41Gd3g+/PyGVHZaed1R03wGD4mmjJA9vKu3uBVc0ljOUcZt?=
 =?us-ascii?Q?jRtW6NYooFiXff4pYLGsZ5jG4lWiWfszcZiZW7gKe12IKpzgbhIDMW9zMkkB?=
 =?us-ascii?Q?uT6+Q99Weq+QMxN99bGpy+aB1s=3D?=
X-Microsoft-Antispam-Message-Info: tD5vjCDMI/7X65rRuqiX3noSrvxSeP5GC3Pe0h+eG0vb81/oPtEJxL+4CtxZ98nWZ8tdxFCVSw4Dn6t0jeAGOX0W8mIujWZ77gQlNopAF6w4jmoF2Czxhuxr1KWTO6WY56kVWbE39TlCi3e//72zx4L0JuuFCLWGW20kJHovH05qQKL/lQOzjXvMSYh0CU3+MGwb/PlThzf3Ywm7rKOH6i9dKWpV82jsSiN0VwVR9dG2rnBXqMEQEYGGb5KNx5jM+kdncfS3p5TiQITOfb3vD2+K6VShZHmEc9yGB3rzAHLvCHjfNpeZbwRb0sdAMYhRkTd/voM1vHsv0jbVInCArw1kPF25EeOIM2/GNkcffOA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;6:hBuDusS16N56JYZA1i7BVv5fNERItU4LlDNFCAabgKN99x4JSo4GGfmLhT9z29M+sZIW2JYoJ1l+dq8dbw7deyjL7PEyK8JNtL/Ei9ckWLxw/RyPhGoEOBXdFnnESuxJ/r1R27md0A00aTXC+Doz8ScYF7YSmimoDa9VH1bjHV4lo1gsG0Yh0y1S4Wor59RweWK0evs8ADEvX7+UWUTJVJ/7tCgcOmumLxmg8L5iC/47CzcrW400K0DLad0FuAvlx6hAsi8IPMiGOI2ONtyR9sgC2p4r/5MYGSzvMA/qL2tsTkNiGbwvY1jPzUobN3+xeFjH6qR4qBg72GwQXyzo32vxwZZ8Waltj/oxkbCWPdfeQcqTLLLkywxwsp2whJfnSEkXjqVJ21ok3D+KaFbd0zSFCx+kLpWOSruS9j2NVp40N7KEirqLrYE1nO55H5a1HQ7UYkgBdIR/zliE760SzQ==;5:byuipgfRAFY3q74Gv+sfeat4xnS7/e5O5si65UalsEMc+MFNe3AAcYzFxjiZqu9agqW67yCZU7OKtpvxnNZl76cLwzViP2go+F7g1UGLNw83xnHfBUG52y+CMxbDqActW6JGyalFiQ//iPU8EUfu4GAL6IrIA/eSsCkP43u1s4Q=;24:BnqBmKfWDbZgf0T/Cwz+BuWuwW4Z6YmTmkFm4Zo580MzdQQy186gKKHRV4VtUzCGVu8wFKlpnoa7hBbl2H3aJNx9g/VIdIlkMhkVfB6DqWg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;7:0Z8xNH1IGGj93iWojP6wJD7KUFGHI7yrnPK+r+MXHI0mYRt+QFarb4BFX/j3x3W1cYH6z9XvP98vYFMnoie8b/R5C/1xvPnkZZgvlfbib0U/U/3Yl4ypKOnYoazW4V/S8GqPrCyZkq0VRaUUEhVJ96HykGm3rb9Tp9LzwBz1EwU2UQndbzkOcdQNy3RxO3R+CREFV4tSpazrx8W00vcqsMv8DJd8W6jVlIOgCyaDRX4qVWn/53wm+FWmKK4QCFJx
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:44:34.9581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f522ad1f-e129-4639-6a84-08d5e12e2b3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3960
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64592
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

Convert remaining structures to use __BITFIELD_FIELD macro. Also
straighten up the description text and whitespace.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 184 ++++++++-------------------
 1 file changed, 56 insertions(+), 128 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index f8ca7b7..931e911 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -1,33 +1,14 @@
-/***********************license start***************
- * Author: Cavium Networks
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Octeon CIU definitions
  *
- * Contact: support@caviumnetworks.com
- * This file is part of the OCTEON SDK
- *
- * Copyright (c) 2003-2012 Cavium Networks
- *
- * This file is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, Version 2, as
- * published by the Free Software Foundation.
- *
- * This file is distributed in the hope that it will be useful, but
- * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
- * NONINFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this file; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
- * or visit http://www.gnu.org/licenses/.
- *
- * This file may also be available under a different license from Cavium.
- * Contact Cavium Networks for more information
- ***********************license end**************************************/
+ * Copyright (C) 2003-2018 Cavium, Inc.
+ */
 
 #ifndef __CVMX_CIU_DEFS_H__
 #define __CVMX_CIU_DEFS_H__
 
+#include <asm/bitfield.h>
+
 #define CVMX_CIU_BIST (CVMX_ADD_IO_SEG(0x0001070000000730ull))
 #define CVMX_CIU_BLOCK_INT (CVMX_ADD_IO_SEG(0x00010700000007C0ull))
 #define CVMX_CIU_DINT (CVMX_ADD_IO_SEG(0x0001070000000720ull))
@@ -209,142 +190,89 @@ static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
 
+
 union cvmx_ciu_qlm {
 	uint64_t u64;
 	struct cvmx_ciu_qlm_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t g2bypass:1;
-		uint64_t reserved_53_62:10;
-		uint64_t g2deemph:5;
-		uint64_t reserved_45_47:3;
-		uint64_t g2margin:5;
-		uint64_t reserved_32_39:8;
-		uint64_t txbypass:1;
-		uint64_t reserved_21_30:10;
-		uint64_t txdeemph:5;
-		uint64_t reserved_13_15:3;
-		uint64_t txmargin:5;
-		uint64_t reserved_4_7:4;
-		uint64_t lane_en:4;
-#else
-		uint64_t lane_en:4;
-		uint64_t reserved_4_7:4;
-		uint64_t txmargin:5;
-		uint64_t reserved_13_15:3;
-		uint64_t txdeemph:5;
-		uint64_t reserved_21_30:10;
-		uint64_t txbypass:1;
-		uint64_t reserved_32_39:8;
-		uint64_t g2margin:5;
-		uint64_t reserved_45_47:3;
-		uint64_t g2deemph:5;
-		uint64_t reserved_53_62:10;
-		uint64_t g2bypass:1;
-#endif
+		__BITFIELD_FIELD(uint64_t g2bypass:1,
+		__BITFIELD_FIELD(uint64_t reserved_53_62:10,
+		__BITFIELD_FIELD(uint64_t g2deemph:5,
+		__BITFIELD_FIELD(uint64_t reserved_45_47:3,
+		__BITFIELD_FIELD(uint64_t g2margin:5,
+		__BITFIELD_FIELD(uint64_t reserved_32_39:8,
+		__BITFIELD_FIELD(uint64_t txbypass:1,
+		__BITFIELD_FIELD(uint64_t reserved_21_30:10,
+		__BITFIELD_FIELD(uint64_t txdeemph:5,
+		__BITFIELD_FIELD(uint64_t reserved_13_15:3,
+		__BITFIELD_FIELD(uint64_t txmargin:5,
+		__BITFIELD_FIELD(uint64_t reserved_4_7:4,
+		__BITFIELD_FIELD(uint64_t lane_en:4,
+		;)))))))))))))
 	} s;
 };
 
 union cvmx_ciu_qlm_jtgc {
 	uint64_t u64;
 	struct cvmx_ciu_qlm_jtgc_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_17_63:47;
-		uint64_t bypass_ext:1;
-		uint64_t reserved_11_15:5;
-		uint64_t clk_div:3;
-		uint64_t reserved_7_7:1;
-		uint64_t mux_sel:3;
-		uint64_t bypass:4;
-#else
-		uint64_t bypass:4;
-		uint64_t mux_sel:3;
-		uint64_t reserved_7_7:1;
-		uint64_t clk_div:3;
-		uint64_t reserved_11_15:5;
-		uint64_t bypass_ext:1;
-		uint64_t reserved_17_63:47;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_17_63:47,
+		__BITFIELD_FIELD(uint64_t bypass_ext:1,
+		__BITFIELD_FIELD(uint64_t reserved_11_15:5,
+		__BITFIELD_FIELD(uint64_t clk_div:3,
+		__BITFIELD_FIELD(uint64_t reserved_7_7:1,
+		__BITFIELD_FIELD(uint64_t mux_sel:3,
+		__BITFIELD_FIELD(uint64_t bypass:4,
+		;)))))))
 	} s;
 };
 
 union cvmx_ciu_qlm_jtgd {
 	uint64_t u64;
 	struct cvmx_ciu_qlm_jtgd_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t capture:1;
-		uint64_t shift:1;
-		uint64_t update:1;
-		uint64_t reserved_45_60:16;
-		uint64_t select:5;
-		uint64_t reserved_37_39:3;
-		uint64_t shft_cnt:5;
-		uint64_t shft_reg:32;
-#else
-		uint64_t shft_reg:32;
-		uint64_t shft_cnt:5;
-		uint64_t reserved_37_39:3;
-		uint64_t select:5;
-		uint64_t reserved_45_60:16;
-		uint64_t update:1;
-		uint64_t shift:1;
-		uint64_t capture:1;
-#endif
+		__BITFIELD_FIELD(uint64_t capture:1,
+		__BITFIELD_FIELD(uint64_t shift:1,
+		__BITFIELD_FIELD(uint64_t update:1,
+		__BITFIELD_FIELD(uint64_t reserved_45_60:16,
+		__BITFIELD_FIELD(uint64_t select:5,
+		__BITFIELD_FIELD(uint64_t reserved_37_39:3,
+		__BITFIELD_FIELD(uint64_t shft_cnt:5,
+		__BITFIELD_FIELD(uint64_t shft_reg:32,
+		;))))))))
 	} s;
 };
 
 union cvmx_ciu_soft_prst {
 	uint64_t u64;
 	struct cvmx_ciu_soft_prst_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_3_63:61;
-		uint64_t host64:1;
-		uint64_t npi:1;
-		uint64_t soft_prst:1;
-#else
-		uint64_t soft_prst:1;
-		uint64_t npi:1;
-		uint64_t host64:1;
-		uint64_t reserved_3_63:61;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_3_63:61,
+		__BITFIELD_FIELD(uint64_t host64:1,
+		__BITFIELD_FIELD(uint64_t npi:1,
+		__BITFIELD_FIELD(uint64_t soft_prst:1,
+		;))))
 	} s;
 };
 
 union cvmx_ciu_timx {
 	uint64_t u64;
 	struct cvmx_ciu_timx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_37_63:27;
-		uint64_t one_shot:1;
-		uint64_t len:36;
-#else
-		uint64_t len:36;
-		uint64_t one_shot:1;
-		uint64_t reserved_37_63:27;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_37_63:27,
+		__BITFIELD_FIELD(uint64_t one_shot:1,
+		__BITFIELD_FIELD(uint64_t len:36,
+		;)))
 	} s;
 };
 
 union cvmx_ciu_wdogx {
 	uint64_t u64;
 	struct cvmx_ciu_wdogx_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint64_t reserved_46_63:18;
-		uint64_t gstopen:1;
-		uint64_t dstop:1;
-		uint64_t cnt:24;
-		uint64_t len:16;
-		uint64_t state:2;
-		uint64_t mode:2;
-#else
-		uint64_t mode:2;
-		uint64_t state:2;
-		uint64_t len:16;
-		uint64_t cnt:24;
-		uint64_t dstop:1;
-		uint64_t gstopen:1;
-		uint64_t reserved_46_63:18;
-#endif
+		__BITFIELD_FIELD(uint64_t reserved_46_63:18,
+		__BITFIELD_FIELD(uint64_t gstopen:1,
+		__BITFIELD_FIELD(uint64_t dstop:1,
+		__BITFIELD_FIELD(uint64_t cnt:24,
+		__BITFIELD_FIELD(uint64_t len:16,
+		__BITFIELD_FIELD(uint64_t state:2,
+		__BITFIELD_FIELD(uint64_t mode:2,
+		;)))))))
 	} s;
 };
 
-#endif
+#endif /* __CVMX_CIU_DEFS_H__ */
-- 
2.1.4
