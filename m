Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 15:14:10 +0100 (CET)
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:46818
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991976AbdCIOOCEj-KT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Mar 2017 15:14:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GmelXMew1lLwmbsQJ5o/ulbfjVncNv/6mzjaxtBpfGM=;
 b=o3yRxzmKjE/oAMgYg8iai89tDVEcxoW9ba+zIxRjIjgJtFMRVQIIMUgPuuZngTNEmoqTCaI5mkltbthqJCim7h9taV+qs+0gbQDiNOL+CwQPcO/PIT6jRjKipxRzbxFiiIEcPzvtNRaFr2JjcJNo/kIBKOKBU/2NE3dgpNd9V0o=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from white.inter.net (173.22.239.243) by
 CY4PR07MB3207.namprd07.prod.outlook.com (10.172.115.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Thu, 9 Mar 2017 14:13:53 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Remove unused GPIO types and macros.
Date:   Thu,  9 Mar 2017 08:13:48 -0600
Message-Id: <1489068828-9629-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BN1PR07CA0074.namprd07.prod.outlook.com (10.255.193.49) To
 CY4PR07MB3207.namprd07.prod.outlook.com (10.172.115.149)
X-MS-Office365-Filtering-Correlation-Id: 4aaa2c1d-20d6-4256-c56f-08d466f684f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY4PR07MB3207;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;3:R/rdEvGT2q+AgwbxOgef/ge94zRLPdoIgZtQXMxnnIncHdd77ssZa0W3tCLKbHxz2Sn9KKFj81IUpIC/1DWVPhhrTy/FyeM38lILhsJECuGPfR46eodv4cJbvECLSIN1eSWYE32qEMRlFnnOZ0MXuqow6YtMjOPqRt4eyyY0S3Va/5XAGtw29sypr1lAhXg9SzJJR747I17aGHt4Ig4rlMtNONa5u/jtDPDgy5hxyYlqwbY7m1GEMu5FLtQ+t45uGpkvESQu5bd2k6k1aeMPuw==;25:q9TgZvzvNHbjWKZFRABUCJsq5cdErHuxy1HWFFAYwGoWp0fXdPs0gTNQJs9XyR3txsSBTAHCu8N1ShnO6r4aCVMJZkyjPkUkytrNpNoC3YHCGtuOzste2M2eloZLPiyF+E7bZMzrwwPv1MZ5tqu1dBNi1m4T3lpbuITOQsSrnTiBZjGw7QG2oYPDQ0KbwLk2ysu46OKS8T9V2N+vZ1521Ljr4vn7pABxFGPE8jzLBcCWFdEvV8GxG603hpTDT/3VydLu0+CmVjOIH7iDVcaGBLul4w2AZPhpnFDjGQbEQwBhHAHcmCAeW3rP668Dee4l5asJydo3n7vUC0cqgSZV1VWzO7svGnTcV5C6vjbnkVAKIInbmRHfUIJ0OKhuKV2tC+A1pWEUS7YXTKF9LMXsdDr9Y/pqffsvVxmUwBofnzkZ4ImCpGLvzlVZNZHV+Q5dey20fVL6iWjaK0Nz2PNcOw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;31:e7PgB7T6Da1DrOw7j0cTFK1mhJUKFGxtZbqL/q0+o+0zffCvfucklfkWBCAug0SmqltXCLJFeeKqCVNpCtiiAHKK6pg37InqitBjI4Iew1AB/uiR3TLX8J1Q8qn7zvokn37VIX6WKzn/y7A4j5g70gRlDivW1tjCh4xjtw+VvM67ntu3kRM3oDJFM1osv2fETQ02XAcfNlo8oyeQ7yuLI/HU46mC1pedQdFrJHKKuZv7ErSF/KK/5H3iNC2916A0NDxPmT4k1AZg9yBQO8JR/0njN8abFCmnuBG/nnrUArc=;20:JMGIvLdOm9k7B0A1W3PvBmlQbqGRCtF6GD7eNxbjbpd4NmkM5VgI+Kro1muhEVkMPFuEpWBksuXKNHjoKKlSTHdUakC2c1MVUSBpe3oGGcaVannTMnZV5oI7PUbwjNpvf3gU0tXm1vtZpzImyQjghshPRme+IJb+NQ1DP1uq41O25ZrB0x9hTNH5Efnr5+HPi3yUr3Yq54fjlAj9xRAwPvxPExXD1nZ3ZBP6DiB2JI+umYLfbPHAm09fpf9FMXMRv1pm5FCLK2ElxhTF6oWnNlsp32BDQMhAGo4bYXXAgiHSNU1gXod3icf/X7Dgsw5KWvCrbZq+prI46MdEOP9NS2o0Bvcih3SHYtbgcb1+l0VLPicQMkQFusnayofvppwlj2lrQdu94ZtTZtkCsDoCyViA5J9thU6qyVDCvQnk6jOwRw090kre4U6Lzvb7Mxvo8eZlzRJRMH5MWJO8aCizsrQUqHSGV5odmk+tIOEJ7EbOZrlmK1bZ0KU66p1dMmgk
X-Microsoft-Antispam-PRVS: <CY4PR07MB32076E82B7AA78D6506354E180210@CY4PR07MB3207.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123560025)(20161123564025)(20161123555025)(20161123562025)(20161123558025)(6072148);SRVR:CY4PR07MB3207;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3207;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;4:xs7Duc+96NJbXhbvpQBTCyPh4225aelz2/sXysAs0iG+jxVTRvVMFNCFeoDB7a+DkehdnP0P7WW741THj+WWfEHxRy2Gl8hBkTf0gpbRHcKhfYtmgCSFRb2MPw1lX30FkwoW7cQtmjow4vF8FG48LwjRFizRd8SmFI4he0c0d/jG7QwlzpMu6Iig5uhdnMHvRkHsiDsvHTj9y5rfcWTGbAbuZfH8d7qMUBFZE2LO3mJdpXWOJR9fjm/2mVO9iLe2EqM481fi1X2cCp3urErbX9a7wjYZ9fepysNar3Y0gnsX5ouDCu06p6VLjVTXD/UJU3tPSdYpM8+s/wNuwFZ81gBq8A1ONMX0R8Rrtg30MFtn/KW07g1lAcOu6/ariM1jbfrnnOgW8pMTTrylV2ZXIJhylj3uz3qO+CSpLl6cBhJMaibqF1G0Hh5yxyni1B9jj4ieMZQiT0W3blXYasODFhg/xQ7rbbtlYtwiwt8eqijGMt3I4r5lcsBuBnONkPtJlP4nyxmO2dkHtAdieZW1X1ioLfsJZT+dpvKgJ65pK2f4v6nONVYkqNaeF2Tk6qe0jnqYGviM6Bi4V84o5Rie1/X4M+5YDfuCRybeiNELCGY=
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(305945005)(110136004)(50466002)(38730400002)(2906002)(42186005)(7736002)(53936002)(36756003)(6916009)(8676002)(81166006)(47776003)(66066001)(33646002)(53416004)(5003940100001)(48376002)(4326008)(50986999)(3846002)(2361001)(6116002)(189998001)(2351001)(6512007)(6486002)(86362001)(575784001)(25786008)(6506006)(5660300001)(450100002)(6666003)(50226002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3207;H:white.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3207;23:pGL8lsPF9Yecq38qOulD4DF63Ua7LKSCGmGxrhaGf?=
 =?us-ascii?Q?EqjsGe5D2Tc3rIlaV6UFU4g9mBHIO3WXUX6whnropm2P8o/hm5bHvJijO5qm?=
 =?us-ascii?Q?L8Q409/Zxs2sIPqLDUNSjfQhfxg05rlpGvKBCrS1owGALBYDC99eLmlj/Bcv?=
 =?us-ascii?Q?KrevaHZNaIqD5plXbfu1OnFUkFydezFoUVRtFAPNEt5iEgdWWcK9SeonME4m?=
 =?us-ascii?Q?Z4K8wKlZlsMKS2ix8xDNtUwx8HEt370xQs3Phm5fqdJiMA9uYzcpIUDaZEfQ?=
 =?us-ascii?Q?evQkx8Xb50J5mvZ+b+xrOP/bmm8rZzUUsLTLVi44FsocLRikFjSswHLj/JJ4?=
 =?us-ascii?Q?n8mX0QwazA4D7hkTKwFCh6/4klA1rehFGkwe+gUaVIq81HegrCobqOJ8VWYN?=
 =?us-ascii?Q?koycdC/rBCwrI/cGvCGzGRzvfyfC0IQTuIj6BdqwyKkI9CWJDl3E8GttfcKM?=
 =?us-ascii?Q?5Okvem7uwOM+tLsuuo3rKtSR1O/stGlo4ZCVGR2pUR4iZ/hVBmg4E1i2kOav?=
 =?us-ascii?Q?jXMMOmEXttd94HKwh5WQN/m6H4WtwkkCo84UcZ+DueePMNwf2u1idjQSN70X?=
 =?us-ascii?Q?14ZTJY2oF+WUBduV8idpAddabUdDBmPlrVfmsf9JPqIKXAdap9B+sAFOGP5H?=
 =?us-ascii?Q?Uo5FxgUbMKZMzANX5g14y4fEItYu6TlCfG3XHoREns2lBj7Ny2GFtheT4iU4?=
 =?us-ascii?Q?xHLrUN5LCL9pdP3abL6VbqQ/RfJgqefokQ7XFPqIBa5UJXHuwESxihCc7j3m?=
 =?us-ascii?Q?krOdCSqqNqSxwxCU6NnN/M51RzvKFcpErDzHwnGW9Z7/CyCgWHcEGiWwlaur?=
 =?us-ascii?Q?K7eMn5voOojf46ArllS43+X1pYrkUeiVSuaWO33LbE87EdQSOU19yJNWIadh?=
 =?us-ascii?Q?zGAWyxClNyMrj6q1RMI3z8a8gXxEc5fU71ard5aMJbD4+WpEgPZx2Jt61R+5?=
 =?us-ascii?Q?0NQ/oKZ67ERc05BdHLP8AaTHLpV2992+IYKay7C4A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;6:njOpwlIP2doRyWmZzzdGZH8DmyGJnjjcsdYgnAxhxYTCu4CkiEPf/hymlX1vUwrQ5p0e/ervyNZFq5Gt5bTMaHGQVAh0UDjpZrD+jxIt/Y4kLKzIlwvSfdbpvRHeJY0pMZBoP+wGK5kHTXcerXrf49BvlZBebJRg9NMSPWKHH4TqhyhMjnPL6Utn2dstRruBOoOXxONSBSDIntgWwC6hfSM9FdC6rjZ3O9GuPi10kbtjvvvFYLMpnKONSI/ROL1DXyH89FR7ZDu2eRHoBCtQFOCKC/wklfePY0KieyyUILMUk3xpPurCNvDUBDsdO5DNh6mNolJUdC+EH38G4/srqaROGoCcYiwAkzBdSa87mvzowPzIe540FQbG/JuMm53kpUaearRkk7G1cJSW9+EuNw==;5:vxXDVFFZO1FONOhRmw/tR2DWHCKW2LLO3I5/c5tf4PjpxuYHlpxZyIqhY5Nx0PhpGDIJ67d9fAIFpLFNMtolTVymLWEHffDEKSCr6T0Mk0+uLfSuhDNio+thpChg97je0y+Gch/lFpWpnTcE+feEVw==;24:hmK9JuevHSXU4ia42CBGtmwc4c4wCgiPEHID4G/zOBfTvdGaA0hfFay5NyqgIt9e5qg7uKURHk30GkBRgNC0aSENtE8AQbq0taHwsTCZU4o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;7:+t8YLBpRySqezMSBuWwJrNoBqC45E9oq4wbrWcoMzesFnilXma4BcvRi28aBoomZsn5HBTxzELcrtRcErNbRXnGo9bKdU84ugyJ50RBNlqb1g7vx4wlDgnvTipJM+L84sQXUmu01FWciYailBTIwtP0ePWqM2/r8TLd/eyTKhze+h3klPYwxH+E3cedjyZZnNZE2+YBHoPlbhSB+Oh0C5hcUextGA2y99xg8c80aLs5fKQPWLwROgM70+02mWm7WxueGR7bTF4SMdBFJ0itTfz9RQE8qkPJ10rPtJ4qkGbiwAhDJJH9+4HXorm+kpQfG87nMeLkp0bSQU3wPusWATA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2017 14:13:53.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3207
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57092
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

Remove all unused bitfields and macros. Convert the remaining
bitfields to use __BITFIELD_FIELD instead of #ifdef.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h | 511 ++------------------------
 1 file changed, 37 insertions(+), 474 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-gpio-defs.h b/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
index 4719fcf..eb80089 100644
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
@@ -28,484 +28,47 @@
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
1.9.1
