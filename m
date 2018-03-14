Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 23:42:28 +0100 (CET)
Received: from mail-bl2nam02on0058.outbound.protection.outlook.com ([104.47.38.58]:61227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992243AbeCNWmHNTq7J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2018 23:42:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AF5YtXFdZiYRoDo8ZekL31nKCbC/Ftb+o7uEmnPGPQw=;
 b=Amecwo7g+W0zLJnjtemeg7PaTB1seJV1hLjdCrnViBUGH5vRkA1xqwJM1WwBPA9vTJ1WeqFOEhK5OC744ZSuvlPjgr7dkTncEHYYPfc1d4/TwUOojirSLAAs9xHJj07FsumQdTfET/eJoQ6EvXrysQidQFJGaowBAF7cN1zmihQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.83.62.27) by
 DM5PR07MB3610.namprd07.prod.outlook.com (2603:10b6:4:68::32) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Wed, 14
 Mar 2018 22:41:58 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: [PATCH v5 2/7] MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
Date:   Wed, 14 Mar 2018 17:24:13 -0500
Message-Id: <1521066258-11376-3-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
References: <1521066258-11376-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:4:ad::47) To DM5PR07MB3610.namprd07.prod.outlook.com
 (2603:10b6:4:68::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daebcd4b-58d7-4734-0235-08d589fccbe0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3610;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;3:pLKlbjcoBHsoPFqcaX3gsrDzXj3TvufQW7fDJ5u1F8tTXIKj6yap6qb11gzlpGOlQVB/YqVLh2i+Nhx4I5IET9Q3xohBZQsPwoNMjoQAnB7oBXaYHbekrhYybFnP76GSIqddupxbCNDqLxO3M/cynAK47JipiC5wgVY/IOlhXHD5hDpyFJ2SPdKQXw7nKj4+o0MikIJLngNvSMOJwSyTOhZ0EW69ufh1f+ED9ADz2AjyNmX4VWTpfWMNbvsNCUBG;25:w8szCA2t/tWZ52xgelTCq7YKUiTJYPLgm+HCcvntr+2FPsgVYH9jNTFDp8M17P6FC/5HhqwYKA1cRY8fzvJtwdJwMq7DPhn7JzzQLx5lteM/1NNQaJKzAGtAb/sCglTQ69dSIQavpMrF3wtTuGnA9PC61L5vXziWOpNDswkVF145QZINnMJtNlterkMSOwb8Bj4wU26trLtBOV/WZEjKV3miw3wMn2l56N7UKWCIsP4023u4kqIMiA3R7ntwach6YgBZQloE37QZGOsGyHkZm+ynFuhroX/S3sXl2PhQ0JRLRCXO2GsbTqMe/S7JnglquRpezZPOt2jd+vslg/jzHw==;31:Z0buAveEmEqVQ8mfm5XY/70A2vVz5A0cupQY7jEVyEKiziM3l62/AnRFCG0TzMKdSpEPD2QMqdXwfBPH/C/YuCvgNSPYNCOILmk+KotFV96PHdaoyhY8nVVhXt7H6UfRbDt3PiI0/ibJaQRoMy5tDCzW7yd1MOLV7BATucYamUx8K8GitYmToJkCtyEXb39PxvuVUKxJ2mVP+GR+E5vHFgOVZALjPbW7go3DIbnaovE=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3610:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;20:4Aexlue6oMsFD8eTU0LZkrrZN39pgH3Qb5RfUC3W8VeSXaVPM5YeR6JtoU7aalZ2FWydnYOrfDEHF1ldZxrjorvU9uTxeixqr0Dp0Sp0SlErio784ezDIr5T7NoqpB1MToF7ZMNGZecXOrFIVqyZ/C1k6W5odxVZ6AzFtTR4/wlaXgUVoygHS8pcSQ60XK1Sxunja2U4FSysFzlpUbZ1jkXZT7oqySSyf0ICnHjXbELqQEBLj+Tlpdt6gAtpH4yM4N2uVTkR7iwR565c9Owcokr6bfo4DIuDwFXAvNRIqMNGvqTfah92T7+RnvCAaWg2nH16PlVTKsfsTVp+OfRc8eEBYcjQ4myP7xMrGhH1H6ElSNidl4YJbsLda02KV7sMzqtL4/O/yObldzXiq8Mpt/scPLyaa0DkeO0R+lfEQ5OK2IqbncKm6qf2uV0bIIEvyKGaeXSBu2ac5rqcfvoSq8mYYi449o18TItpKT0hpf7kZwqPFrBQEsw/5LuGSXgs;4:LeU4Fb2iR8D2blqM3sIAj1fvbiNG8ybM2dfpk5Iy9mXGEu/thzybS640641SVEfNkbDaRENkFcVZY5e87zf+JSj/55i7wl9LSBNfpy7VUWcHcneG8qwkSgMVEP/ROgTOxDZY8eiraM7Sjm97yWeryAmXH99xFxcwPon8UNcul9rUQijKcycaUdpYqSG5cMjzI63lz6SSsZMU3tEvWXUHX8nj7DyIvZXxVjzQBlvBA4WGot12P4fSOBoZFZJjdX9xIwZsLuJuitLlMCQdiN4vbQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3610EF705404D03A639AEA1D80D10@DM5PR07MB3610.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR07MB3610;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3610;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(396003)(376002)(199004)(189003)(8936002)(305945005)(5660300001)(53936002)(69596002)(53416004)(51416003)(52116002)(50466002)(26005)(7736002)(81166006)(16526019)(186003)(86362001)(8676002)(81156014)(386003)(76176011)(316002)(575784001)(68736007)(50226002)(48376002)(16586007)(105586002)(6506007)(72206003)(2950100002)(36756003)(3846002)(6916009)(97736004)(478600001)(66066001)(2906002)(107886003)(4326008)(6486002)(47776003)(106356001)(2361001)(2351001)(25786009)(6666003)(6116002)(6512007)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3610;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3610;23:dzQjJi/ksZNR9we5tJKFJyUZLyNp0rAQxLEQ8LDwz?=
 =?us-ascii?Q?H/rQqpoQxnJ4EJIhphyjRWIKCHzGeIlt7mfjL5UqZDZAe5ii2GaPVRhiA9GC?=
 =?us-ascii?Q?aEFRjtl4tjfjxJU/O2BNLecLEaTES0saCRiCTFE+e4HTFJVUYe9Kw0v93ZIl?=
 =?us-ascii?Q?T7maQVbn4KWBIGdzVPDEjsYVPVa/LGPcyFNVQeJ6PPtCjIo3wANuHxq/QUGJ?=
 =?us-ascii?Q?ExmTz6zMkmTztXMVgVgfBu27Z5op3KF6Zrr6PIGWp1sL85T5DneyDTE9YU+R?=
 =?us-ascii?Q?EoOIi8fNE8R8QYFFVk3wY3GDy+XXWrM3q2oyh3owtsmFfwbXv2J4KeorLwUu?=
 =?us-ascii?Q?UZWZVYbxQ8F7NSA54otmSkZ3nTwBFbv79+86u2W9ivL+Nh8/J95JN4pUe+eL?=
 =?us-ascii?Q?rfpQmveoju2UpfiugyAoX5Mz8EbRV/1fJXGHXT0WkrRL2tpd8MsUu2Nr8cdH?=
 =?us-ascii?Q?tHKX7F0LeHOWeyunk+IWdCbNi4mGEcey0o/8eH5oiB5Jhn6bMzpRQnVDIDie?=
 =?us-ascii?Q?2pFBLiu1NF0cYDH9eBvvpJTkwilnKXQLOS4bQ6HuXBQPlJXpKQlOsL+r95CY?=
 =?us-ascii?Q?6nupD1s9jLTuU4kTvp7erqWOqrkrs+DsCKgmNaraSEWmam8ns6BezdVhjl+O?=
 =?us-ascii?Q?QSfwPalrKzawcpod5yFaU8UEMljX7nkUoe1wQHpkFCI/xL4eSVePhksZVNie?=
 =?us-ascii?Q?nBSPvTAetfbXJzG1dgDqbBOz3IL0Rw6FaecSpFFv9dlvpg+o33cWS0K9dGi+?=
 =?us-ascii?Q?t+nCgsN4TCRodwWrI4h3+ff4zwBhgXPu3DHbVUACb1weJBMBeux81kG7tgaC?=
 =?us-ascii?Q?A0gizPVVG/L/8FGZIi6yKh0JcfQoAdxwanqYLKd73zs1yG6QQHxfan1+uqOX?=
 =?us-ascii?Q?Du9IwSSyA3Sq2vpds3yeJOzfb1PijTufSDJqjgqqvxkQ7cd7LduloyrakTSd?=
 =?us-ascii?Q?tL7uZ029V0r0PcaVTsPONjQYCruLeEWWRnyIVBytgwV8C25J3m76YdSMq5LD?=
 =?us-ascii?Q?OIF7m+l7NUPXUyqrVbFvxwRX5gh/VPIHaQg8bPhR1taWS+7R1AUSTRiNQk/D?=
 =?us-ascii?Q?qXMYhVhC2VbsCXAzFjj+lLfAOFgJgGQisf49MOZonDt8dXZ6kswHeGel6ho0?=
 =?us-ascii?Q?s3EvVqUcnZMZrclksLpEsaT0EB7oKFHHfWUDRA5vgwoznNjTkzU6gbJ8S2XV?=
 =?us-ascii?Q?z2sgoFZk/YhK4tqmhkYxAPu5tzc5IAmThc/A8my7B0bJ3h5isxQrxnvsh6vA?=
 =?us-ascii?Q?oJh0yBeOJR+eDTX7os6quC2naHHJCrKgpNwYuNI?=
X-Microsoft-Antispam-Message-Info: iAH6RyDxR1ZZSxLLOK+uFL8lqakzuP8jAZsKk8wcAfRKLC0xIO3CJ6tBP/oqKhnOULRuxzNaWRwLpRiuVNWpwGr+KM20eHRwkTLuTjZRJt1WbcstySmvmh6BpLoNVbKfKgUKwmT/UBDBwjUCYoN0BesXsw+1HL7yKZc/O7rM7Y7ofTQb1uXVPSfSsVuKoZgI
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3610;6:ffn9NG3M90A9Ge+7KJkbunHTIxuUbSGgRiPR2kEeBH/jB2RPAYwO/7eNaHkHJ3Fq0oHoQPNOJHh9LYY8wz+VOwAsfKGH4JIgdmjTDlTlXrF21hsNZMrbtgiIJMHzEkkSyHJqCgtl/xWOf1NsLYhCir45gvy49YmxdVhf1H6aUhI3tvekYzJ/YssMsEHI9O8jm5DMKh2lPGDS0KJcrjOvanWB/AcAHuoYvePna07DSa+iny1JyzbwBmIZx2uHQqSaalzCQjS1DdO9/uTV/ZPgCIUuYWoqsfvaWNoQrnE3xKkk0lYMJyd3ASFQ8zrtS3oMIFvjeR8iPZ/Wtq8slzQF+21MBDkriqg/G/hRwU4LLV4=;5:LE+8yNofjM+2wFARrmm5/Zrw1IBIGBDb2NuyAA7paxaVqAxzlkpKV930LEyTuGfrY+Ear7MY9z96nKlCV0+3/XA2wGV0wSSAIzhfmc9emyoaVRqyAomjf23TSDjaUbc8+81PnlmX/UMKrTq3tTEejpmCCSRgBMrH5h2MGR5SOuI=;24:0fPeo/HsuoIe45/60fTeke5CG1A3m9zlRE7KW2yRwZ5DpZy5Ve6/ZlHZBhJfkzZzhk+JUcX4fTQ9xauFAf8d5LXN8QzEL9b0tByrOJyWxuY=;7:BVLqAVmkWLI9ng+HxMXvNq042z3Toa/scS1E6TdFowjG5aySe4UVe7hQapvIVshxE0Wk64jLhoRxrMAuMJZOy5yekZ2QIqc+TEKpR7I+KkJoOqb/v03B1eAJutM4CNff9gTmA+AAKrCoE+9PqWJmuVAPhMdKmygZWj+CetGPHtF6QL2XEoxUm2zi6jyVkl+jmk3Fxr96AIyK8ZU2VX/TIFejZsB3P8EDNcUfo9j5NPLtU2Ghm382yH0p19XlbQjG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 22:41:58.5512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daebcd4b-58d7-4734-0235-08d589fccbe0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3610
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62980
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
