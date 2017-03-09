Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2017 15:31:58 +0100 (CET)
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:13952
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991976AbdCIObrX-X8f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Mar 2017 15:31:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mjxnVIQMOstU0BrKR7kyRLfLic+p12prQlh6wahskOg=;
 b=j/XehlXEo61CFCK+WppFVV84G6yMHKkqu/wYpVI/BAe0dXTp5+QzjXO4w7JrvqjoZ3jnIpD3c432zdqt/sdHadNDOcAHOvOYoZh5PHHbpYroVGTp4VlH8BiwGcoSeweyTJH5wwvwUjGJMQKSN/TVGFdSJHQox5/RUWWnlo021hY=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from white.inter.net (173.22.239.243) by
 BN6PR07MB3203.namprd07.prod.outlook.com (10.172.105.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Thu, 9 Mar 2017 14:31:36 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Octeon: Remove unused PCIERCX types and macros.
Date:   Thu,  9 Mar 2017 08:31:30 -0600
Message-Id: <1489069890-14569-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CO2PR07CA0025.namprd07.prod.outlook.com (10.141.194.163) To
 BN6PR07MB3203.namprd07.prod.outlook.com (10.172.105.149)
X-MS-Office365-Filtering-Correlation-Id: a8d3deb5-3c1f-46bb-c60b-08d466f8fe99
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3203;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;3:smJV0HuXNJ3h02QD6eFCl9o7A1wR8fxU48xxsUp2PiGt+/jTNrjvcgJYSLXcGjVhQFMJ5WPxTAzAPV6vlcQi6C+SQ5RxriZ+7qEBhyylwE1dIdBQUPyomUYeirP+irycs7vLUYbKVqltuVbtoW6b0AS0UUjbcx82FAAvqKWSk/RO+nH0UYA0Q0SY7tBbGLb1uciMVRmAuhErnc7z5gdo3Rc8cy9bwbxg1dLgrgtwttZ9Y79GPMjJPBjtBD6bu4YM7PO891V6unlN49NItpclOg==;25:rPfEUEoft8jIQ5De1Dq1DtO8u8KydK67P4GUKNPdUcvEsdmoDUGGiU1Nz0ljKa6Ia7OTMjP1nN9qGi4dYEYogwjJ/94ucwW1pCPeKL42tspDfQ26zlaOtccK5LXrDlNQX2En4RXiniMwjvIUJBvU/ZZwvo8Cwe3BGTMftJqrUv47Nan+ysESW/ZhRy58od4Vetm+mbRA7nQhAIHMdvbMejmMIFSJsi20yd3Vm9BTPRqZrOniRWyRDTQeEu6SU8GEuPARIryfqNlkye9H/DTjxIIFPT78asrScf5IHj2AA0TQrvOXU9DtIckBZ0OUrfCaC+eJBiauajhAZDy74yJFb8zf18hEYViLa3ZVMe9mwG6Ix8MpijZipBhkoETrqy+W7kbsMabHmHHXvOncmJhFt2OaVvgdRdMPBj0S6bgerVLRjxHY/SONOft7pFPRMAlqEth4pPRLETfVLxSsR4HXZw==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;31:UE0BTzpw/APsJtiu2xT+FliuOasDTwnBdhsnOm7A9Jm5Lb6ziff2OwvryZR2GAXiXf2d90ZzQJlde5k45+4yiOFWvOWMc/lLRKpCtBItDev85DZiGgnziE97erjPSO/tRejf2Egn5Q+UlYEpGi1JGY9V/qyVRyUfJaGTztNUj+qDK0tk8HlJ6BIdBXm33mmu+U66wpqe3a4Wmpc1P0oyilBzG1iIJ/CiKGDcp8wBWcsJ76NdKYyo/jKq1UhT2WRwhPxBL/y8bcwlZ/ImGBjZwpZ3JO3rrFJE01m89pCHKr4=;20:PJCHahpc0KpQQW8ZGsXxRmQCWKMy4FFBBacaMh1P2zL2ezgLHt56jj5gZZbj2MosGiriuVc2l3yWuxQWjeYkAluwpupaN34Mc5pis5o+66JbPhPC7GhOsuppCQCgpjo9TxREQLxx5zijMhTdhxW7mdg/qnXz8PoCm6pApOCop8zExBI1hQXzAQYKepCeZvV8g6UqhTmCIpeewEcKKP18svdczU/CDCEiK5JjSVNPVGyXum+mzfebmFpobum+AEDGuwMLP95vegM3rYPoccTX4IdfwZGPH2Cl3vWAuLc7ioZKYrnHEJXVuC9rEvhfHx5ueN3p9dUqcl1+Sj5R5FdOIbRPgABoZSSzP4gdfkd7LD5wNdXcXavZs9I5jF/3cLGG2ftvjrvD9/3yNuCxgpMVNQVr2Vr2mxcRlULBLPHPEiES4I0tCUiM21OHnOB4nHx01eGAREh79RP7xb9Zn7ihB6FPzfrffr76AvLJTg13EGmAVrXLhgWFkOZU9FW3ZzTq
X-Microsoft-Antispam-PRVS: <BN6PR07MB32037201FC090F3E6ADFBEC080210@BN6PR07MB3203.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123558025)(20161123555025)(20161123564025)(20161123562025)(20161123560025)(6072148);SRVR:BN6PR07MB3203;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3203;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;4:72R44L52rWuktRJPIXAT1B3McGP85ecOp04NAfaVFTZRxGBHnvq9y9IZonLGVD7tC6NluC/2jRzjbWHtr5BsTlFa/2wLVElc8X5vaAPmT9t0Di7VAFfJviSjEXXYsp+aOD2oeF2Dl3zoPT+ctvjSNNebKHPWnTJ+USPzkf0AvLF9vv7slTpLEyk7bMigK+Q9+rKqtgJH6ntnBPTviggKTxj5gkYcgnmrJuGE79zoKnIQSgxNLdbTlZI3LpBlYzxF7103dnQnm/hwNR6MnQM6b9g9EC13crbMlJ2/FU58E/jbMRD5CRcRiu3jTVq3iRv53/6kRGlM9sF87TJQ7HJRPUUKOEG029Eiz7hs+tCh4oBjnsWyMXJJFMaWxqimKtjAuI9svmxaOPoNVAdijhGAMHUP5NMghDCyKF3v0MY4sQJetVUeID9MaILzFFfVmsCPICDij5iFVAMSUTa9cXg3ykob6qZu7x1pcMpxs1BmFSoFLac5Oms8lmShYp4Tgs7hVJQu5kgo5WOCTlAWo9VjGpnBX/8Tob0eZuIm3cnuV4ZQaK83VKfKktVSmxsvl6EnuYyY/xO2xPwpB2ZwvyW2lxK0OCKH2mVvOAqYJH7tIEM=
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39830400002)(39410400002)(39450400003)(6486002)(53946003)(38730400002)(42186005)(305945005)(53416004)(81166006)(6666003)(86362001)(450100002)(25786008)(6512007)(110136004)(6506006)(8676002)(5003940100001)(5660300001)(53936002)(50986999)(50226002)(4326008)(2906002)(6916009)(50466002)(33646002)(47776003)(48376002)(7736002)(575784001)(3846002)(6116002)(2351001)(2361001)(36756003)(66066001)(189998001)(2004002)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3203;H:white.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB3203;23:RYXQiWs4y7PEKZVD0IXN8G/DfqmYpYuDqvGZfh9Ep?=
 =?us-ascii?Q?v/3yB3vVe/ZqQjJulSJhXCypc8ybmug/hjgsmUBnpCefDxex9zo+uP9MSCx9?=
 =?us-ascii?Q?eiiqzd9ghGWtaWCXjehHAdVygc2ndri4Zv7RvLpppkhF2gf3aQIXvqoWCtSR?=
 =?us-ascii?Q?DKWHBQNhx6sI7hrLGLPlUR2qQA+RPUyzpMk9LaeqrU9ryc7fkx0ly6LTl7I0?=
 =?us-ascii?Q?j1hxiI7m9Uop4SvY/50vG7MriZRB9NW6oCTvZt0RrrNkP/yztQGttHgc6YEB?=
 =?us-ascii?Q?3y5cJXMb3vDa4CjA5jjd9w3viyABQjqN0AKQtnWXfN9W3sgJliCCnNn2IohE?=
 =?us-ascii?Q?yG1kCGYBiu/FU4XvUjH88iuBAvV/maEFvGtymcjqX/96B/MgleYfte7Y8DFk?=
 =?us-ascii?Q?FQD2dpTSuFDbuco2Qc5YDklN3WMCqXyLYtYx4wgV0Bp1HhQRX4YEDadfHy6w?=
 =?us-ascii?Q?mJ/uoEc9yrDYReVJ9OfTUjfDFH9Fnn0rsg1wCOFQqRtuBJvhdg7NfcEYBXPa?=
 =?us-ascii?Q?TWOMjvd73SMZebeK9PuUP3rqXZs2iCa4PnAA6ObVRiGk+Pg41NiOmKcdR2Dn?=
 =?us-ascii?Q?Va+5f8nyvT+vSO1Lgu18tHJVQCaZ2WE7QMVJCEiNoXYq2Nwr7dmGoiAs6Qn0?=
 =?us-ascii?Q?/p3OEskJNzXnMa0nBUfjW5M3+T+FV1Wp35NKPE1z3MV/aOya3I19977vnEfA?=
 =?us-ascii?Q?bVdfagsI1wPMxkToY84q37WT9+gf3CoJHUc1IHH2Xg6aW9hd4IBzj2zInyQy?=
 =?us-ascii?Q?+xbWf/wPAr13DlIBRe0WctnhwSL1w0GPRCvWRdqr6l16uRWq3q+rrVgJul2X?=
 =?us-ascii?Q?K/u3hfpMlqQ2Y4zsR1j5mMzGvZ+nXl7K6N1Ihy32hlWgqNI2p2iQyDX3F14O?=
 =?us-ascii?Q?Ch4ysfwXvm99L7GC6qqcPBl3KLqGzYXkApAmJ3A2L+ffk598XTyl2V0lEFMx?=
 =?us-ascii?Q?HAQHxXx9lxohCiPtt7rKSl5Fh9COf+EOy3N7g9qts9yeBQeLZrmbCfv79UHv?=
 =?us-ascii?Q?ZvD6e+fdNFt4X3MHz1Q5AS5QYc2FJS+VgFVLKNAyc/fOHd4Zg3soS7Tn/dCr?=
 =?us-ascii?Q?SoG3SoYaq79EEo5ZR+wTwDLMuoy?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;6:4L7nimz68WFhHLwrofyNvQZwZ3od/8PVUR1VCI6AykIqsSpqCbgQwvt2mCXOkHIYOCsFfS2zrqdeDfZz15NjdkDv20Oc4T4N6/s0i9pGEfQmbaaKTyOTI/hKEJAMiwtJwPek2ODbC0clypkIncJZfvQcYEbWRajgLTS/jS7DgFhVGx9E4q8SwZq4M1ocAcdhRWvo0Col91i4ffVfzFnywnYTKjy+3ry3qMYzqa84nZ3JgBLcL1NoOwpkOXq5CwMqTFeuVlhJsVnG34MuuoUIfwLfHV1UCHrVst1QqNzFdmCSXjs9rMthi7ty0HoVeysbppvP455rUZXXa3/xq395MoeNBONRrEN7pgroGZw9teQ1jqwhvUmvrnVGPF1VSil2VmGHb49tZvA82ecQiVHknw==;5:4piiFA8/HZoQg0ngkBD4gEGYwCT4ySpSh31er3m6fJY0/kuLbVPbffGRhT/G6Q/WADs2a/NI5Zd3LPyYGaVsGgjd23yzlS7G6yTAKtD8kflDONhgJDeHBnPt20VNh16KUtOov6G/V29LN+zmPugugw==;24:nLYZtCJx0Giv0cY/CRPqz8eSE5VnWCa3zj3f4WXSWl9aV53K+pZXnMr759pnTVNXPVEm5xHVTSpcYTKI4T/l2UO2u/9B3TXOqP2wEN5gBWs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3203;7:iteZHl45HkPJozGUvk2aDCrLwXAKXD16OhNh3TkOjlfkYxcIadtNeXUmuFZ36eF9oqh4U4COZK0qClpilLbMCh37xE63L9stHeKhsl9MQBF64Fz/ftJO4n5cCEskTCIVq+0RkpPztR/d3Qwir9dm3kCbRdCfRGm4VoEKDTe8FRw+Kg2r2qoSokf/xFBfvkAEqS4ORS2dSDa3AKFhA2GFPbFittgfJCWUjSjBaTGa8W0EaDLbo4FfGIeZv/T2DVUApM/2GL+9iMBNTKP1opTImYgEpr62doB+IRE+xIUrpWLiWD8f3M9T7/DflYaxjxyKM0fQu3tKjJu2ri3YNWTV6g==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2017 14:31:36.7739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3203
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57098
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
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h | 3223 ++--------------------
 1 file changed, 207 insertions(+), 3016 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
index 4bce393..01a774f 100644
--- a/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pciercx-defs.h
@@ -4,7 +4,7 @@
  * Contact: support@caviumnetworks.com
  * This file is part of the OCTEON SDK
  *
- * Copyright (c) 2003-2012 Cavium Networks
+ * Copyright (c) 2003-2017 Cavium, Inc.
  *
  * This file is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, Version 2, as
@@ -28,3148 +28,339 @@
 #ifndef __CVMX_PCIERCX_DEFS_H__
 #define __CVMX_PCIERCX_DEFS_H__
 
-#define CVMX_PCIERCX_CFG000(block_id) (0x0000000000000000ull)
 #define CVMX_PCIERCX_CFG001(block_id) (0x0000000000000004ull)
-#define CVMX_PCIERCX_CFG002(block_id) (0x0000000000000008ull)
-#define CVMX_PCIERCX_CFG003(block_id) (0x000000000000000Cull)
-#define CVMX_PCIERCX_CFG004(block_id) (0x0000000000000010ull)
-#define CVMX_PCIERCX_CFG005(block_id) (0x0000000000000014ull)
 #define CVMX_PCIERCX_CFG006(block_id) (0x0000000000000018ull)
-#define CVMX_PCIERCX_CFG007(block_id) (0x000000000000001Cull)
 #define CVMX_PCIERCX_CFG008(block_id) (0x0000000000000020ull)
 #define CVMX_PCIERCX_CFG009(block_id) (0x0000000000000024ull)
 #define CVMX_PCIERCX_CFG010(block_id) (0x0000000000000028ull)
 #define CVMX_PCIERCX_CFG011(block_id) (0x000000000000002Cull)
-#define CVMX_PCIERCX_CFG012(block_id) (0x0000000000000030ull)
-#define CVMX_PCIERCX_CFG013(block_id) (0x0000000000000034ull)
-#define CVMX_PCIERCX_CFG014(block_id) (0x0000000000000038ull)
-#define CVMX_PCIERCX_CFG015(block_id) (0x000000000000003Cull)
-#define CVMX_PCIERCX_CFG016(block_id) (0x0000000000000040ull)
-#define CVMX_PCIERCX_CFG017(block_id) (0x0000000000000044ull)
-#define CVMX_PCIERCX_CFG020(block_id) (0x0000000000000050ull)
-#define CVMX_PCIERCX_CFG021(block_id) (0x0000000000000054ull)
-#define CVMX_PCIERCX_CFG022(block_id) (0x0000000000000058ull)
-#define CVMX_PCIERCX_CFG023(block_id) (0x000000000000005Cull)
-#define CVMX_PCIERCX_CFG028(block_id) (0x0000000000000070ull)
-#define CVMX_PCIERCX_CFG029(block_id) (0x0000000000000074ull)
 #define CVMX_PCIERCX_CFG030(block_id) (0x0000000000000078ull)
 #define CVMX_PCIERCX_CFG031(block_id) (0x000000000000007Cull)
 #define CVMX_PCIERCX_CFG032(block_id) (0x0000000000000080ull)
-#define CVMX_PCIERCX_CFG033(block_id) (0x0000000000000084ull)
 #define CVMX_PCIERCX_CFG034(block_id) (0x0000000000000088ull)
 #define CVMX_PCIERCX_CFG035(block_id) (0x000000000000008Cull)
-#define CVMX_PCIERCX_CFG036(block_id) (0x0000000000000090ull)
-#define CVMX_PCIERCX_CFG037(block_id) (0x0000000000000094ull)
-#define CVMX_PCIERCX_CFG038(block_id) (0x0000000000000098ull)
-#define CVMX_PCIERCX_CFG039(block_id) (0x000000000000009Cull)
 #define CVMX_PCIERCX_CFG040(block_id) (0x00000000000000A0ull)
-#define CVMX_PCIERCX_CFG041(block_id) (0x00000000000000A4ull)
-#define CVMX_PCIERCX_CFG042(block_id) (0x00000000000000A8ull)
-#define CVMX_PCIERCX_CFG064(block_id) (0x0000000000000100ull)
-#define CVMX_PCIERCX_CFG065(block_id) (0x0000000000000104ull)
 #define CVMX_PCIERCX_CFG066(block_id) (0x0000000000000108ull)
-#define CVMX_PCIERCX_CFG067(block_id) (0x000000000000010Cull)
-#define CVMX_PCIERCX_CFG068(block_id) (0x0000000000000110ull)
 #define CVMX_PCIERCX_CFG069(block_id) (0x0000000000000114ull)
 #define CVMX_PCIERCX_CFG070(block_id) (0x0000000000000118ull)
-#define CVMX_PCIERCX_CFG071(block_id) (0x000000000000011Cull)
-#define CVMX_PCIERCX_CFG072(block_id) (0x0000000000000120ull)
-#define CVMX_PCIERCX_CFG073(block_id) (0x0000000000000124ull)
-#define CVMX_PCIERCX_CFG074(block_id) (0x0000000000000128ull)
 #define CVMX_PCIERCX_CFG075(block_id) (0x000000000000012Cull)
-#define CVMX_PCIERCX_CFG076(block_id) (0x0000000000000130ull)
-#define CVMX_PCIERCX_CFG077(block_id) (0x0000000000000134ull)
 #define CVMX_PCIERCX_CFG448(block_id) (0x0000000000000700ull)
-#define CVMX_PCIERCX_CFG449(block_id) (0x0000000000000704ull)
-#define CVMX_PCIERCX_CFG450(block_id) (0x0000000000000708ull)
-#define CVMX_PCIERCX_CFG451(block_id) (0x000000000000070Cull)
 #define CVMX_PCIERCX_CFG452(block_id) (0x0000000000000710ull)
-#define CVMX_PCIERCX_CFG453(block_id) (0x0000000000000714ull)
-#define CVMX_PCIERCX_CFG454(block_id) (0x0000000000000718ull)
 #define CVMX_PCIERCX_CFG455(block_id) (0x000000000000071Cull)
-#define CVMX_PCIERCX_CFG456(block_id) (0x0000000000000720ull)
-#define CVMX_PCIERCX_CFG458(block_id) (0x0000000000000728ull)
-#define CVMX_PCIERCX_CFG459(block_id) (0x000000000000072Cull)
-#define CVMX_PCIERCX_CFG460(block_id) (0x0000000000000730ull)
-#define CVMX_PCIERCX_CFG461(block_id) (0x0000000000000734ull)
-#define CVMX_PCIERCX_CFG462(block_id) (0x0000000000000738ull)
-#define CVMX_PCIERCX_CFG463(block_id) (0x000000000000073Cull)
-#define CVMX_PCIERCX_CFG464(block_id) (0x0000000000000740ull)
-#define CVMX_PCIERCX_CFG465(block_id) (0x0000000000000744ull)
-#define CVMX_PCIERCX_CFG466(block_id) (0x0000000000000748ull)
-#define CVMX_PCIERCX_CFG467(block_id) (0x000000000000074Cull)
-#define CVMX_PCIERCX_CFG468(block_id) (0x0000000000000750ull)
-#define CVMX_PCIERCX_CFG490(block_id) (0x00000000000007A8ull)
-#define CVMX_PCIERCX_CFG491(block_id) (0x00000000000007ACull)
-#define CVMX_PCIERCX_CFG492(block_id) (0x00000000000007B0ull)
 #define CVMX_PCIERCX_CFG515(block_id) (0x000000000000080Cull)
-#define CVMX_PCIERCX_CFG516(block_id) (0x0000000000000810ull)
-#define CVMX_PCIERCX_CFG517(block_id) (0x0000000000000814ull)
-
-union cvmx_pciercx_cfg000 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg000_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t devid:16;
-		uint32_t vendid:16;
-#else
-		uint32_t vendid:16;
-		uint32_t devid:16;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg000_s cn52xx;
-	struct cvmx_pciercx_cfg000_s cn52xxp1;
-	struct cvmx_pciercx_cfg000_s cn56xx;
-	struct cvmx_pciercx_cfg000_s cn56xxp1;
-	struct cvmx_pciercx_cfg000_s cn61xx;
-	struct cvmx_pciercx_cfg000_s cn63xx;
-	struct cvmx_pciercx_cfg000_s cn63xxp1;
-	struct cvmx_pciercx_cfg000_s cn66xx;
-	struct cvmx_pciercx_cfg000_s cn68xx;
-	struct cvmx_pciercx_cfg000_s cn68xxp1;
-	struct cvmx_pciercx_cfg000_s cnf71xx;
-};
 
 union cvmx_pciercx_cfg001 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg001_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dpe:1;
-		uint32_t sse:1;
-		uint32_t rma:1;
-		uint32_t rta:1;
-		uint32_t sta:1;
-		uint32_t devt:2;
-		uint32_t mdpe:1;
-		uint32_t fbb:1;
-		uint32_t reserved_22_22:1;
-		uint32_t m66:1;
-		uint32_t cl:1;
-		uint32_t i_stat:1;
-		uint32_t reserved_11_18:8;
-		uint32_t i_dis:1;
-		uint32_t fbbe:1;
-		uint32_t see:1;
-		uint32_t ids_wcc:1;
-		uint32_t per:1;
-		uint32_t vps:1;
-		uint32_t mwice:1;
-		uint32_t scse:1;
-		uint32_t me:1;
-		uint32_t msae:1;
-		uint32_t isae:1;
-#else
-		uint32_t isae:1;
-		uint32_t msae:1;
-		uint32_t me:1;
-		uint32_t scse:1;
-		uint32_t mwice:1;
-		uint32_t vps:1;
-		uint32_t per:1;
-		uint32_t ids_wcc:1;
-		uint32_t see:1;
-		uint32_t fbbe:1;
-		uint32_t i_dis:1;
-		uint32_t reserved_11_18:8;
-		uint32_t i_stat:1;
-		uint32_t cl:1;
-		uint32_t m66:1;
-		uint32_t reserved_22_22:1;
-		uint32_t fbb:1;
-		uint32_t mdpe:1;
-		uint32_t devt:2;
-		uint32_t sta:1;
-		uint32_t rta:1;
-		uint32_t rma:1;
-		uint32_t sse:1;
-		uint32_t dpe:1;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg001_s cn52xx;
-	struct cvmx_pciercx_cfg001_s cn52xxp1;
-	struct cvmx_pciercx_cfg001_s cn56xx;
-	struct cvmx_pciercx_cfg001_s cn56xxp1;
-	struct cvmx_pciercx_cfg001_s cn61xx;
-	struct cvmx_pciercx_cfg001_s cn63xx;
-	struct cvmx_pciercx_cfg001_s cn63xxp1;
-	struct cvmx_pciercx_cfg001_s cn66xx;
-	struct cvmx_pciercx_cfg001_s cn68xx;
-	struct cvmx_pciercx_cfg001_s cn68xxp1;
-	struct cvmx_pciercx_cfg001_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg002 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg002_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t bcc:8;
-		uint32_t sc:8;
-		uint32_t pi:8;
-		uint32_t rid:8;
-#else
-		uint32_t rid:8;
-		uint32_t pi:8;
-		uint32_t sc:8;
-		uint32_t bcc:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg002_s cn52xx;
-	struct cvmx_pciercx_cfg002_s cn52xxp1;
-	struct cvmx_pciercx_cfg002_s cn56xx;
-	struct cvmx_pciercx_cfg002_s cn56xxp1;
-	struct cvmx_pciercx_cfg002_s cn61xx;
-	struct cvmx_pciercx_cfg002_s cn63xx;
-	struct cvmx_pciercx_cfg002_s cn63xxp1;
-	struct cvmx_pciercx_cfg002_s cn66xx;
-	struct cvmx_pciercx_cfg002_s cn68xx;
-	struct cvmx_pciercx_cfg002_s cn68xxp1;
-	struct cvmx_pciercx_cfg002_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg003 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg003_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t bist:8;
-		uint32_t mfd:1;
-		uint32_t chf:7;
-		uint32_t lt:8;
-		uint32_t cls:8;
-#else
-		uint32_t cls:8;
-		uint32_t lt:8;
-		uint32_t chf:7;
-		uint32_t mfd:1;
-		uint32_t bist:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg003_s cn52xx;
-	struct cvmx_pciercx_cfg003_s cn52xxp1;
-	struct cvmx_pciercx_cfg003_s cn56xx;
-	struct cvmx_pciercx_cfg003_s cn56xxp1;
-	struct cvmx_pciercx_cfg003_s cn61xx;
-	struct cvmx_pciercx_cfg003_s cn63xx;
-	struct cvmx_pciercx_cfg003_s cn63xxp1;
-	struct cvmx_pciercx_cfg003_s cn66xx;
-	struct cvmx_pciercx_cfg003_s cn68xx;
-	struct cvmx_pciercx_cfg003_s cn68xxp1;
-	struct cvmx_pciercx_cfg003_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg004 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg004_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
+		__BITFIELD_FIELD(uint32_t dpe:1,
+		__BITFIELD_FIELD(uint32_t sse:1,
+		__BITFIELD_FIELD(uint32_t rma:1,
+		__BITFIELD_FIELD(uint32_t rta:1,
+		__BITFIELD_FIELD(uint32_t sta:1,
+		__BITFIELD_FIELD(uint32_t devt:2,
+		__BITFIELD_FIELD(uint32_t mdpe:1,
+		__BITFIELD_FIELD(uint32_t fbb:1,
+		__BITFIELD_FIELD(uint32_t reserved_22_22:1,
+		__BITFIELD_FIELD(uint32_t m66:1,
+		__BITFIELD_FIELD(uint32_t cl:1,
+		__BITFIELD_FIELD(uint32_t i_stat:1,
+		__BITFIELD_FIELD(uint32_t reserved_11_18:8,
+		__BITFIELD_FIELD(uint32_t i_dis:1,
+		__BITFIELD_FIELD(uint32_t fbbe:1,
+		__BITFIELD_FIELD(uint32_t see:1,
+		__BITFIELD_FIELD(uint32_t ids_wcc:1,
+		__BITFIELD_FIELD(uint32_t per:1,
+		__BITFIELD_FIELD(uint32_t vps:1,
+		__BITFIELD_FIELD(uint32_t mwice:1,
+		__BITFIELD_FIELD(uint32_t scse:1,
+		__BITFIELD_FIELD(uint32_t me:1,
+		__BITFIELD_FIELD(uint32_t msae:1,
+		__BITFIELD_FIELD(uint32_t isae:1,
+		;))))))))))))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg004_s cn52xx;
-	struct cvmx_pciercx_cfg004_s cn52xxp1;
-	struct cvmx_pciercx_cfg004_s cn56xx;
-	struct cvmx_pciercx_cfg004_s cn56xxp1;
-	struct cvmx_pciercx_cfg004_s cn61xx;
-	struct cvmx_pciercx_cfg004_s cn63xx;
-	struct cvmx_pciercx_cfg004_s cn63xxp1;
-	struct cvmx_pciercx_cfg004_s cn66xx;
-	struct cvmx_pciercx_cfg004_s cn68xx;
-	struct cvmx_pciercx_cfg004_s cn68xxp1;
-	struct cvmx_pciercx_cfg004_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg005 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg005_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg005_s cn52xx;
-	struct cvmx_pciercx_cfg005_s cn52xxp1;
-	struct cvmx_pciercx_cfg005_s cn56xx;
-	struct cvmx_pciercx_cfg005_s cn56xxp1;
-	struct cvmx_pciercx_cfg005_s cn61xx;
-	struct cvmx_pciercx_cfg005_s cn63xx;
-	struct cvmx_pciercx_cfg005_s cn63xxp1;
-	struct cvmx_pciercx_cfg005_s cn66xx;
-	struct cvmx_pciercx_cfg005_s cn68xx;
-	struct cvmx_pciercx_cfg005_s cn68xxp1;
-	struct cvmx_pciercx_cfg005_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg006 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg006_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t slt:8;
-		uint32_t subbnum:8;
-		uint32_t sbnum:8;
-		uint32_t pbnum:8;
-#else
-		uint32_t pbnum:8;
-		uint32_t sbnum:8;
-		uint32_t subbnum:8;
-		uint32_t slt:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg006_s cn52xx;
-	struct cvmx_pciercx_cfg006_s cn52xxp1;
-	struct cvmx_pciercx_cfg006_s cn56xx;
-	struct cvmx_pciercx_cfg006_s cn56xxp1;
-	struct cvmx_pciercx_cfg006_s cn61xx;
-	struct cvmx_pciercx_cfg006_s cn63xx;
-	struct cvmx_pciercx_cfg006_s cn63xxp1;
-	struct cvmx_pciercx_cfg006_s cn66xx;
-	struct cvmx_pciercx_cfg006_s cn68xx;
-	struct cvmx_pciercx_cfg006_s cn68xxp1;
-	struct cvmx_pciercx_cfg006_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg007 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg007_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dpe:1;
-		uint32_t sse:1;
-		uint32_t rma:1;
-		uint32_t rta:1;
-		uint32_t sta:1;
-		uint32_t devt:2;
-		uint32_t mdpe:1;
-		uint32_t fbb:1;
-		uint32_t reserved_22_22:1;
-		uint32_t m66:1;
-		uint32_t reserved_16_20:5;
-		uint32_t lio_limi:4;
-		uint32_t reserved_9_11:3;
-		uint32_t io32b:1;
-		uint32_t lio_base:4;
-		uint32_t reserved_1_3:3;
-		uint32_t io32a:1;
-#else
-		uint32_t io32a:1;
-		uint32_t reserved_1_3:3;
-		uint32_t lio_base:4;
-		uint32_t io32b:1;
-		uint32_t reserved_9_11:3;
-		uint32_t lio_limi:4;
-		uint32_t reserved_16_20:5;
-		uint32_t m66:1;
-		uint32_t reserved_22_22:1;
-		uint32_t fbb:1;
-		uint32_t mdpe:1;
-		uint32_t devt:2;
-		uint32_t sta:1;
-		uint32_t rta:1;
-		uint32_t rma:1;
-		uint32_t sse:1;
-		uint32_t dpe:1;
-#endif
+		__BITFIELD_FIELD(uint32_t slt:8,
+		__BITFIELD_FIELD(uint32_t subbnum:8,
+		__BITFIELD_FIELD(uint32_t sbnum:8,
+		__BITFIELD_FIELD(uint32_t pbnum:8,
+		;))))
 	} s;
-	struct cvmx_pciercx_cfg007_s cn52xx;
-	struct cvmx_pciercx_cfg007_s cn52xxp1;
-	struct cvmx_pciercx_cfg007_s cn56xx;
-	struct cvmx_pciercx_cfg007_s cn56xxp1;
-	struct cvmx_pciercx_cfg007_s cn61xx;
-	struct cvmx_pciercx_cfg007_s cn63xx;
-	struct cvmx_pciercx_cfg007_s cn63xxp1;
-	struct cvmx_pciercx_cfg007_s cn66xx;
-	struct cvmx_pciercx_cfg007_s cn68xx;
-	struct cvmx_pciercx_cfg007_s cn68xxp1;
-	struct cvmx_pciercx_cfg007_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg008 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg008_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t ml_addr:12;
-		uint32_t reserved_16_19:4;
-		uint32_t mb_addr:12;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t mb_addr:12;
-		uint32_t reserved_16_19:4;
-		uint32_t ml_addr:12;
-#endif
+		__BITFIELD_FIELD(uint32_t ml_addr:12,
+		__BITFIELD_FIELD(uint32_t reserved_16_19:4,
+		__BITFIELD_FIELD(uint32_t mb_addr:12,
+		__BITFIELD_FIELD(uint32_t reserved_0_3:4,
+		;))))
 	} s;
-	struct cvmx_pciercx_cfg008_s cn52xx;
-	struct cvmx_pciercx_cfg008_s cn52xxp1;
-	struct cvmx_pciercx_cfg008_s cn56xx;
-	struct cvmx_pciercx_cfg008_s cn56xxp1;
-	struct cvmx_pciercx_cfg008_s cn61xx;
-	struct cvmx_pciercx_cfg008_s cn63xx;
-	struct cvmx_pciercx_cfg008_s cn63xxp1;
-	struct cvmx_pciercx_cfg008_s cn66xx;
-	struct cvmx_pciercx_cfg008_s cn68xx;
-	struct cvmx_pciercx_cfg008_s cn68xxp1;
-	struct cvmx_pciercx_cfg008_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg009 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg009_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t lmem_limit:12;
-		uint32_t reserved_17_19:3;
-		uint32_t mem64b:1;
-		uint32_t lmem_base:12;
-		uint32_t reserved_1_3:3;
-		uint32_t mem64a:1;
-#else
-		uint32_t mem64a:1;
-		uint32_t reserved_1_3:3;
-		uint32_t lmem_base:12;
-		uint32_t mem64b:1;
-		uint32_t reserved_17_19:3;
-		uint32_t lmem_limit:12;
-#endif
+		__BITFIELD_FIELD(uint32_t lmem_limit:12,
+		__BITFIELD_FIELD(uint32_t reserved_17_19:3,
+		__BITFIELD_FIELD(uint32_t mem64b:1,
+		__BITFIELD_FIELD(uint32_t lmem_base:12,
+		__BITFIELD_FIELD(uint32_t reserved_1_3:3,
+		__BITFIELD_FIELD(uint32_t mem64a:1,
+		;))))))
 	} s;
-	struct cvmx_pciercx_cfg009_s cn52xx;
-	struct cvmx_pciercx_cfg009_s cn52xxp1;
-	struct cvmx_pciercx_cfg009_s cn56xx;
-	struct cvmx_pciercx_cfg009_s cn56xxp1;
-	struct cvmx_pciercx_cfg009_s cn61xx;
-	struct cvmx_pciercx_cfg009_s cn63xx;
-	struct cvmx_pciercx_cfg009_s cn63xxp1;
-	struct cvmx_pciercx_cfg009_s cn66xx;
-	struct cvmx_pciercx_cfg009_s cn68xx;
-	struct cvmx_pciercx_cfg009_s cn68xxp1;
-	struct cvmx_pciercx_cfg009_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg010 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg010_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t umem_base:32;
-#else
-		uint32_t umem_base:32;
-#endif
+		uint32_t umem_base;
 	} s;
-	struct cvmx_pciercx_cfg010_s cn52xx;
-	struct cvmx_pciercx_cfg010_s cn52xxp1;
-	struct cvmx_pciercx_cfg010_s cn56xx;
-	struct cvmx_pciercx_cfg010_s cn56xxp1;
-	struct cvmx_pciercx_cfg010_s cn61xx;
-	struct cvmx_pciercx_cfg010_s cn63xx;
-	struct cvmx_pciercx_cfg010_s cn63xxp1;
-	struct cvmx_pciercx_cfg010_s cn66xx;
-	struct cvmx_pciercx_cfg010_s cn68xx;
-	struct cvmx_pciercx_cfg010_s cn68xxp1;
-	struct cvmx_pciercx_cfg010_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg011 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg011_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t umem_limit:32;
-#else
-		uint32_t umem_limit:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg011_s cn52xx;
-	struct cvmx_pciercx_cfg011_s cn52xxp1;
-	struct cvmx_pciercx_cfg011_s cn56xx;
-	struct cvmx_pciercx_cfg011_s cn56xxp1;
-	struct cvmx_pciercx_cfg011_s cn61xx;
-	struct cvmx_pciercx_cfg011_s cn63xx;
-	struct cvmx_pciercx_cfg011_s cn63xxp1;
-	struct cvmx_pciercx_cfg011_s cn66xx;
-	struct cvmx_pciercx_cfg011_s cn68xx;
-	struct cvmx_pciercx_cfg011_s cn68xxp1;
-	struct cvmx_pciercx_cfg011_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg012 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg012_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t uio_limit:16;
-		uint32_t uio_base:16;
-#else
-		uint32_t uio_base:16;
-		uint32_t uio_limit:16;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg012_s cn52xx;
-	struct cvmx_pciercx_cfg012_s cn52xxp1;
-	struct cvmx_pciercx_cfg012_s cn56xx;
-	struct cvmx_pciercx_cfg012_s cn56xxp1;
-	struct cvmx_pciercx_cfg012_s cn61xx;
-	struct cvmx_pciercx_cfg012_s cn63xx;
-	struct cvmx_pciercx_cfg012_s cn63xxp1;
-	struct cvmx_pciercx_cfg012_s cn66xx;
-	struct cvmx_pciercx_cfg012_s cn68xx;
-	struct cvmx_pciercx_cfg012_s cn68xxp1;
-	struct cvmx_pciercx_cfg012_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg013 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg013_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_8_31:24;
-		uint32_t cp:8;
-#else
-		uint32_t cp:8;
-		uint32_t reserved_8_31:24;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg013_s cn52xx;
-	struct cvmx_pciercx_cfg013_s cn52xxp1;
-	struct cvmx_pciercx_cfg013_s cn56xx;
-	struct cvmx_pciercx_cfg013_s cn56xxp1;
-	struct cvmx_pciercx_cfg013_s cn61xx;
-	struct cvmx_pciercx_cfg013_s cn63xx;
-	struct cvmx_pciercx_cfg013_s cn63xxp1;
-	struct cvmx_pciercx_cfg013_s cn66xx;
-	struct cvmx_pciercx_cfg013_s cn68xx;
-	struct cvmx_pciercx_cfg013_s cn68xxp1;
-	struct cvmx_pciercx_cfg013_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg014 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg014_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg014_s cn52xx;
-	struct cvmx_pciercx_cfg014_s cn52xxp1;
-	struct cvmx_pciercx_cfg014_s cn56xx;
-	struct cvmx_pciercx_cfg014_s cn56xxp1;
-	struct cvmx_pciercx_cfg014_s cn61xx;
-	struct cvmx_pciercx_cfg014_s cn63xx;
-	struct cvmx_pciercx_cfg014_s cn63xxp1;
-	struct cvmx_pciercx_cfg014_s cn66xx;
-	struct cvmx_pciercx_cfg014_s cn68xx;
-	struct cvmx_pciercx_cfg014_s cn68xxp1;
-	struct cvmx_pciercx_cfg014_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg015 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg015_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_28_31:4;
-		uint32_t dtsees:1;
-		uint32_t dts:1;
-		uint32_t sdt:1;
-		uint32_t pdt:1;
-		uint32_t fbbe:1;
-		uint32_t sbrst:1;
-		uint32_t mam:1;
-		uint32_t vga16d:1;
-		uint32_t vgae:1;
-		uint32_t isae:1;
-		uint32_t see:1;
-		uint32_t pere:1;
-		uint32_t inta:8;
-		uint32_t il:8;
-#else
-		uint32_t il:8;
-		uint32_t inta:8;
-		uint32_t pere:1;
-		uint32_t see:1;
-		uint32_t isae:1;
-		uint32_t vgae:1;
-		uint32_t vga16d:1;
-		uint32_t mam:1;
-		uint32_t sbrst:1;
-		uint32_t fbbe:1;
-		uint32_t pdt:1;
-		uint32_t sdt:1;
-		uint32_t dts:1;
-		uint32_t dtsees:1;
-		uint32_t reserved_28_31:4;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg015_s cn52xx;
-	struct cvmx_pciercx_cfg015_s cn52xxp1;
-	struct cvmx_pciercx_cfg015_s cn56xx;
-	struct cvmx_pciercx_cfg015_s cn56xxp1;
-	struct cvmx_pciercx_cfg015_s cn61xx;
-	struct cvmx_pciercx_cfg015_s cn63xx;
-	struct cvmx_pciercx_cfg015_s cn63xxp1;
-	struct cvmx_pciercx_cfg015_s cn66xx;
-	struct cvmx_pciercx_cfg015_s cn68xx;
-	struct cvmx_pciercx_cfg015_s cn68xxp1;
-	struct cvmx_pciercx_cfg015_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg016 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg016_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t pmes:5;
-		uint32_t d2s:1;
-		uint32_t d1s:1;
-		uint32_t auxc:3;
-		uint32_t dsi:1;
-		uint32_t reserved_20_20:1;
-		uint32_t pme_clock:1;
-		uint32_t pmsv:3;
-		uint32_t ncp:8;
-		uint32_t pmcid:8;
-#else
-		uint32_t pmcid:8;
-		uint32_t ncp:8;
-		uint32_t pmsv:3;
-		uint32_t pme_clock:1;
-		uint32_t reserved_20_20:1;
-		uint32_t dsi:1;
-		uint32_t auxc:3;
-		uint32_t d1s:1;
-		uint32_t d2s:1;
-		uint32_t pmes:5;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg016_s cn52xx;
-	struct cvmx_pciercx_cfg016_s cn52xxp1;
-	struct cvmx_pciercx_cfg016_s cn56xx;
-	struct cvmx_pciercx_cfg016_s cn56xxp1;
-	struct cvmx_pciercx_cfg016_s cn61xx;
-	struct cvmx_pciercx_cfg016_s cn63xx;
-	struct cvmx_pciercx_cfg016_s cn63xxp1;
-	struct cvmx_pciercx_cfg016_s cn66xx;
-	struct cvmx_pciercx_cfg016_s cn68xx;
-	struct cvmx_pciercx_cfg016_s cn68xxp1;
-	struct cvmx_pciercx_cfg016_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg017 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg017_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t pmdia:8;
-		uint32_t bpccee:1;
-		uint32_t bd3h:1;
-		uint32_t reserved_16_21:6;
-		uint32_t pmess:1;
-		uint32_t pmedsia:2;
-		uint32_t pmds:4;
-		uint32_t pmeens:1;
-		uint32_t reserved_4_7:4;
-		uint32_t nsr:1;
-		uint32_t reserved_2_2:1;
-		uint32_t ps:2;
-#else
-		uint32_t ps:2;
-		uint32_t reserved_2_2:1;
-		uint32_t nsr:1;
-		uint32_t reserved_4_7:4;
-		uint32_t pmeens:1;
-		uint32_t pmds:4;
-		uint32_t pmedsia:2;
-		uint32_t pmess:1;
-		uint32_t reserved_16_21:6;
-		uint32_t bd3h:1;
-		uint32_t bpccee:1;
-		uint32_t pmdia:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg017_s cn52xx;
-	struct cvmx_pciercx_cfg017_s cn52xxp1;
-	struct cvmx_pciercx_cfg017_s cn56xx;
-	struct cvmx_pciercx_cfg017_s cn56xxp1;
-	struct cvmx_pciercx_cfg017_s cn61xx;
-	struct cvmx_pciercx_cfg017_s cn63xx;
-	struct cvmx_pciercx_cfg017_s cn63xxp1;
-	struct cvmx_pciercx_cfg017_s cn66xx;
-	struct cvmx_pciercx_cfg017_s cn68xx;
-	struct cvmx_pciercx_cfg017_s cn68xxp1;
-	struct cvmx_pciercx_cfg017_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg020 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg020_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t pvm:1;
-		uint32_t m64:1;
-		uint32_t mme:3;
-		uint32_t mmc:3;
-		uint32_t msien:1;
-		uint32_t ncp:8;
-		uint32_t msicid:8;
-#else
-		uint32_t msicid:8;
-		uint32_t ncp:8;
-		uint32_t msien:1;
-		uint32_t mmc:3;
-		uint32_t mme:3;
-		uint32_t m64:1;
-		uint32_t pvm:1;
-		uint32_t reserved_25_31:7;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg020_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_24_31:8;
-		uint32_t m64:1;
-		uint32_t mme:3;
-		uint32_t mmc:3;
-		uint32_t msien:1;
-		uint32_t ncp:8;
-		uint32_t msicid:8;
-#else
-		uint32_t msicid:8;
-		uint32_t ncp:8;
-		uint32_t msien:1;
-		uint32_t mmc:3;
-		uint32_t mme:3;
-		uint32_t m64:1;
-		uint32_t reserved_24_31:8;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg020_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg020_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg020_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg020_s cn61xx;
-	struct cvmx_pciercx_cfg020_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg020_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg020_cn52xx cn66xx;
-	struct cvmx_pciercx_cfg020_cn52xx cn68xx;
-	struct cvmx_pciercx_cfg020_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg020_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg021 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg021_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t lmsi:30;
-		uint32_t reserved_0_1:2;
-#else
-		uint32_t reserved_0_1:2;
-		uint32_t lmsi:30;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg021_s cn52xx;
-	struct cvmx_pciercx_cfg021_s cn52xxp1;
-	struct cvmx_pciercx_cfg021_s cn56xx;
-	struct cvmx_pciercx_cfg021_s cn56xxp1;
-	struct cvmx_pciercx_cfg021_s cn61xx;
-	struct cvmx_pciercx_cfg021_s cn63xx;
-	struct cvmx_pciercx_cfg021_s cn63xxp1;
-	struct cvmx_pciercx_cfg021_s cn66xx;
-	struct cvmx_pciercx_cfg021_s cn68xx;
-	struct cvmx_pciercx_cfg021_s cn68xxp1;
-	struct cvmx_pciercx_cfg021_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg022 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg022_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t umsi:32;
-#else
-		uint32_t umsi:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg022_s cn52xx;
-	struct cvmx_pciercx_cfg022_s cn52xxp1;
-	struct cvmx_pciercx_cfg022_s cn56xx;
-	struct cvmx_pciercx_cfg022_s cn56xxp1;
-	struct cvmx_pciercx_cfg022_s cn61xx;
-	struct cvmx_pciercx_cfg022_s cn63xx;
-	struct cvmx_pciercx_cfg022_s cn63xxp1;
-	struct cvmx_pciercx_cfg022_s cn66xx;
-	struct cvmx_pciercx_cfg022_s cn68xx;
-	struct cvmx_pciercx_cfg022_s cn68xxp1;
-	struct cvmx_pciercx_cfg022_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg023 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg023_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_16_31:16;
-		uint32_t msimd:16;
-#else
-		uint32_t msimd:16;
-		uint32_t reserved_16_31:16;
-#endif
+		uint32_t umem_limit;
 	} s;
-	struct cvmx_pciercx_cfg023_s cn52xx;
-	struct cvmx_pciercx_cfg023_s cn52xxp1;
-	struct cvmx_pciercx_cfg023_s cn56xx;
-	struct cvmx_pciercx_cfg023_s cn56xxp1;
-	struct cvmx_pciercx_cfg023_s cn61xx;
-	struct cvmx_pciercx_cfg023_s cn63xx;
-	struct cvmx_pciercx_cfg023_s cn63xxp1;
-	struct cvmx_pciercx_cfg023_s cn66xx;
-	struct cvmx_pciercx_cfg023_s cn68xx;
-	struct cvmx_pciercx_cfg023_s cn68xxp1;
-	struct cvmx_pciercx_cfg023_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg028 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg028_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_30_31:2;
-		uint32_t imn:5;
-		uint32_t si:1;
-		uint32_t dpt:4;
-		uint32_t pciecv:4;
-		uint32_t ncp:8;
-		uint32_t pcieid:8;
-#else
-		uint32_t pcieid:8;
-		uint32_t ncp:8;
-		uint32_t pciecv:4;
-		uint32_t dpt:4;
-		uint32_t si:1;
-		uint32_t imn:5;
-		uint32_t reserved_30_31:2;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg028_s cn52xx;
-	struct cvmx_pciercx_cfg028_s cn52xxp1;
-	struct cvmx_pciercx_cfg028_s cn56xx;
-	struct cvmx_pciercx_cfg028_s cn56xxp1;
-	struct cvmx_pciercx_cfg028_s cn61xx;
-	struct cvmx_pciercx_cfg028_s cn63xx;
-	struct cvmx_pciercx_cfg028_s cn63xxp1;
-	struct cvmx_pciercx_cfg028_s cn66xx;
-	struct cvmx_pciercx_cfg028_s cn68xx;
-	struct cvmx_pciercx_cfg028_s cn68xxp1;
-	struct cvmx_pciercx_cfg028_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg029 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg029_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_28_31:4;
-		uint32_t cspls:2;
-		uint32_t csplv:8;
-		uint32_t reserved_16_17:2;
-		uint32_t rber:1;
-		uint32_t reserved_12_14:3;
-		uint32_t el1al:3;
-		uint32_t el0al:3;
-		uint32_t etfs:1;
-		uint32_t pfs:2;
-		uint32_t mpss:3;
-#else
-		uint32_t mpss:3;
-		uint32_t pfs:2;
-		uint32_t etfs:1;
-		uint32_t el0al:3;
-		uint32_t el1al:3;
-		uint32_t reserved_12_14:3;
-		uint32_t rber:1;
-		uint32_t reserved_16_17:2;
-		uint32_t csplv:8;
-		uint32_t cspls:2;
-		uint32_t reserved_28_31:4;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg029_s cn52xx;
-	struct cvmx_pciercx_cfg029_s cn52xxp1;
-	struct cvmx_pciercx_cfg029_s cn56xx;
-	struct cvmx_pciercx_cfg029_s cn56xxp1;
-	struct cvmx_pciercx_cfg029_s cn61xx;
-	struct cvmx_pciercx_cfg029_s cn63xx;
-	struct cvmx_pciercx_cfg029_s cn63xxp1;
-	struct cvmx_pciercx_cfg029_s cn66xx;
-	struct cvmx_pciercx_cfg029_s cn68xx;
-	struct cvmx_pciercx_cfg029_s cn68xxp1;
-	struct cvmx_pciercx_cfg029_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg030 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg030_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_22_31:10;
-		uint32_t tp:1;
-		uint32_t ap_d:1;
-		uint32_t ur_d:1;
-		uint32_t fe_d:1;
-		uint32_t nfe_d:1;
-		uint32_t ce_d:1;
-		uint32_t reserved_15_15:1;
-		uint32_t mrrs:3;
-		uint32_t ns_en:1;
-		uint32_t ap_en:1;
-		uint32_t pf_en:1;
-		uint32_t etf_en:1;
-		uint32_t mps:3;
-		uint32_t ro_en:1;
-		uint32_t ur_en:1;
-		uint32_t fe_en:1;
-		uint32_t nfe_en:1;
-		uint32_t ce_en:1;
-#else
-		uint32_t ce_en:1;
-		uint32_t nfe_en:1;
-		uint32_t fe_en:1;
-		uint32_t ur_en:1;
-		uint32_t ro_en:1;
-		uint32_t mps:3;
-		uint32_t etf_en:1;
-		uint32_t pf_en:1;
-		uint32_t ap_en:1;
-		uint32_t ns_en:1;
-		uint32_t mrrs:3;
-		uint32_t reserved_15_15:1;
-		uint32_t ce_d:1;
-		uint32_t nfe_d:1;
-		uint32_t fe_d:1;
-		uint32_t ur_d:1;
-		uint32_t ap_d:1;
-		uint32_t tp:1;
-		uint32_t reserved_22_31:10;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_22_31:10,
+		__BITFIELD_FIELD(uint32_t tp:1,
+		__BITFIELD_FIELD(uint32_t ap_d:1,
+		__BITFIELD_FIELD(uint32_t ur_d:1,
+		__BITFIELD_FIELD(uint32_t fe_d:1,
+		__BITFIELD_FIELD(uint32_t nfe_d:1,
+		__BITFIELD_FIELD(uint32_t ce_d:1,
+		__BITFIELD_FIELD(uint32_t reserved_15_15:1,
+		__BITFIELD_FIELD(uint32_t mrrs:3,
+		__BITFIELD_FIELD(uint32_t ns_en:1,
+		__BITFIELD_FIELD(uint32_t ap_en:1,
+		__BITFIELD_FIELD(uint32_t pf_en:1,
+		__BITFIELD_FIELD(uint32_t etf_en:1,
+		__BITFIELD_FIELD(uint32_t mps:3,
+		__BITFIELD_FIELD(uint32_t ro_en:1,
+		__BITFIELD_FIELD(uint32_t ur_en:1,
+		__BITFIELD_FIELD(uint32_t fe_en:1,
+		__BITFIELD_FIELD(uint32_t nfe_en:1,
+		__BITFIELD_FIELD(uint32_t ce_en:1,
+		;)))))))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg030_s cn52xx;
-	struct cvmx_pciercx_cfg030_s cn52xxp1;
-	struct cvmx_pciercx_cfg030_s cn56xx;
-	struct cvmx_pciercx_cfg030_s cn56xxp1;
-	struct cvmx_pciercx_cfg030_s cn61xx;
-	struct cvmx_pciercx_cfg030_s cn63xx;
-	struct cvmx_pciercx_cfg030_s cn63xxp1;
-	struct cvmx_pciercx_cfg030_s cn66xx;
-	struct cvmx_pciercx_cfg030_s cn68xx;
-	struct cvmx_pciercx_cfg030_s cn68xxp1;
-	struct cvmx_pciercx_cfg030_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg031 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg031_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t pnum:8;
-		uint32_t reserved_23_23:1;
-		uint32_t aspm:1;
-		uint32_t lbnc:1;
-		uint32_t dllarc:1;
-		uint32_t sderc:1;
-		uint32_t cpm:1;
-		uint32_t l1el:3;
-		uint32_t l0el:3;
-		uint32_t aslpms:2;
-		uint32_t mlw:6;
-		uint32_t mls:4;
-#else
-		uint32_t mls:4;
-		uint32_t mlw:6;
-		uint32_t aslpms:2;
-		uint32_t l0el:3;
-		uint32_t l1el:3;
-		uint32_t cpm:1;
-		uint32_t sderc:1;
-		uint32_t dllarc:1;
-		uint32_t lbnc:1;
-		uint32_t aspm:1;
-		uint32_t reserved_23_23:1;
-		uint32_t pnum:8;
-#endif
+		__BITFIELD_FIELD(uint32_t pnum:8,
+		__BITFIELD_FIELD(uint32_t reserved_23_23:1,
+		__BITFIELD_FIELD(uint32_t aspm:1,
+		__BITFIELD_FIELD(uint32_t lbnc:1,
+		__BITFIELD_FIELD(uint32_t dllarc:1,
+		__BITFIELD_FIELD(uint32_t sderc:1,
+		__BITFIELD_FIELD(uint32_t cpm:1,
+		__BITFIELD_FIELD(uint32_t l1el:3,
+		__BITFIELD_FIELD(uint32_t l0el:3,
+		__BITFIELD_FIELD(uint32_t aslpms:2,
+		__BITFIELD_FIELD(uint32_t mlw:6,
+		__BITFIELD_FIELD(uint32_t mls:4,
+		;))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg031_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t pnum:8;
-		uint32_t reserved_22_23:2;
-		uint32_t lbnc:1;
-		uint32_t dllarc:1;
-		uint32_t sderc:1;
-		uint32_t cpm:1;
-		uint32_t l1el:3;
-		uint32_t l0el:3;
-		uint32_t aslpms:2;
-		uint32_t mlw:6;
-		uint32_t mls:4;
-#else
-		uint32_t mls:4;
-		uint32_t mlw:6;
-		uint32_t aslpms:2;
-		uint32_t l0el:3;
-		uint32_t l1el:3;
-		uint32_t cpm:1;
-		uint32_t sderc:1;
-		uint32_t dllarc:1;
-		uint32_t lbnc:1;
-		uint32_t reserved_22_23:2;
-		uint32_t pnum:8;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg031_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg031_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg031_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg031_s cn61xx;
-	struct cvmx_pciercx_cfg031_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg031_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg031_s cn66xx;
-	struct cvmx_pciercx_cfg031_s cn68xx;
-	struct cvmx_pciercx_cfg031_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg031_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg032 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg032_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t lab:1;
-		uint32_t lbm:1;
-		uint32_t dlla:1;
-		uint32_t scc:1;
-		uint32_t lt:1;
-		uint32_t reserved_26_26:1;
-		uint32_t nlw:6;
-		uint32_t ls:4;
-		uint32_t reserved_12_15:4;
-		uint32_t lab_int_enb:1;
-		uint32_t lbm_int_enb:1;
-		uint32_t hawd:1;
-		uint32_t ecpm:1;
-		uint32_t es:1;
-		uint32_t ccc:1;
-		uint32_t rl:1;
-		uint32_t ld:1;
-		uint32_t rcb:1;
-		uint32_t reserved_2_2:1;
-		uint32_t aslpc:2;
-#else
-		uint32_t aslpc:2;
-		uint32_t reserved_2_2:1;
-		uint32_t rcb:1;
-		uint32_t ld:1;
-		uint32_t rl:1;
-		uint32_t ccc:1;
-		uint32_t es:1;
-		uint32_t ecpm:1;
-		uint32_t hawd:1;
-		uint32_t lbm_int_enb:1;
-		uint32_t lab_int_enb:1;
-		uint32_t reserved_12_15:4;
-		uint32_t ls:4;
-		uint32_t nlw:6;
-		uint32_t reserved_26_26:1;
-		uint32_t lt:1;
-		uint32_t scc:1;
-		uint32_t dlla:1;
-		uint32_t lbm:1;
-		uint32_t lab:1;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg032_s cn52xx;
-	struct cvmx_pciercx_cfg032_s cn52xxp1;
-	struct cvmx_pciercx_cfg032_s cn56xx;
-	struct cvmx_pciercx_cfg032_s cn56xxp1;
-	struct cvmx_pciercx_cfg032_s cn61xx;
-	struct cvmx_pciercx_cfg032_s cn63xx;
-	struct cvmx_pciercx_cfg032_s cn63xxp1;
-	struct cvmx_pciercx_cfg032_s cn66xx;
-	struct cvmx_pciercx_cfg032_s cn68xx;
-	struct cvmx_pciercx_cfg032_s cn68xxp1;
-	struct cvmx_pciercx_cfg032_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg033 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg033_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t ps_num:13;
-		uint32_t nccs:1;
-		uint32_t emip:1;
-		uint32_t sp_ls:2;
-		uint32_t sp_lv:8;
-		uint32_t hp_c:1;
-		uint32_t hp_s:1;
-		uint32_t pip:1;
-		uint32_t aip:1;
-		uint32_t mrlsp:1;
-		uint32_t pcp:1;
-		uint32_t abp:1;
-#else
-		uint32_t abp:1;
-		uint32_t pcp:1;
-		uint32_t mrlsp:1;
-		uint32_t aip:1;
-		uint32_t pip:1;
-		uint32_t hp_s:1;
-		uint32_t hp_c:1;
-		uint32_t sp_lv:8;
-		uint32_t sp_ls:2;
-		uint32_t emip:1;
-		uint32_t nccs:1;
-		uint32_t ps_num:13;
-#endif
+		__BITFIELD_FIELD(uint32_t lab:1,
+		__BITFIELD_FIELD(uint32_t lbm:1,
+		__BITFIELD_FIELD(uint32_t dlla:1,
+		__BITFIELD_FIELD(uint32_t scc:1,
+		__BITFIELD_FIELD(uint32_t lt:1,
+		__BITFIELD_FIELD(uint32_t reserved_26_26:1,
+		__BITFIELD_FIELD(uint32_t nlw:6,
+		__BITFIELD_FIELD(uint32_t ls:4,
+		__BITFIELD_FIELD(uint32_t reserved_12_15:4,
+		__BITFIELD_FIELD(uint32_t lab_int_enb:1,
+		__BITFIELD_FIELD(uint32_t lbm_int_enb:1,
+		__BITFIELD_FIELD(uint32_t hawd:1,
+		__BITFIELD_FIELD(uint32_t ecpm:1,
+		__BITFIELD_FIELD(uint32_t es:1,
+		__BITFIELD_FIELD(uint32_t ccc:1,
+		__BITFIELD_FIELD(uint32_t rl:1,
+		__BITFIELD_FIELD(uint32_t ld:1,
+		__BITFIELD_FIELD(uint32_t rcb:1,
+		__BITFIELD_FIELD(uint32_t reserved_2_2:1,
+		__BITFIELD_FIELD(uint32_t aslpc:2,
+		;))))))))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg033_s cn52xx;
-	struct cvmx_pciercx_cfg033_s cn52xxp1;
-	struct cvmx_pciercx_cfg033_s cn56xx;
-	struct cvmx_pciercx_cfg033_s cn56xxp1;
-	struct cvmx_pciercx_cfg033_s cn61xx;
-	struct cvmx_pciercx_cfg033_s cn63xx;
-	struct cvmx_pciercx_cfg033_s cn63xxp1;
-	struct cvmx_pciercx_cfg033_s cn66xx;
-	struct cvmx_pciercx_cfg033_s cn68xx;
-	struct cvmx_pciercx_cfg033_s cn68xxp1;
-	struct cvmx_pciercx_cfg033_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg034 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg034_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t dlls_c:1;
-		uint32_t emis:1;
-		uint32_t pds:1;
-		uint32_t mrlss:1;
-		uint32_t ccint_d:1;
-		uint32_t pd_c:1;
-		uint32_t mrls_c:1;
-		uint32_t pf_d:1;
-		uint32_t abp_d:1;
-		uint32_t reserved_13_15:3;
-		uint32_t dlls_en:1;
-		uint32_t emic:1;
-		uint32_t pcc:1;
-		uint32_t pic:2;
-		uint32_t aic:2;
-		uint32_t hpint_en:1;
-		uint32_t ccint_en:1;
-		uint32_t pd_en:1;
-		uint32_t mrls_en:1;
-		uint32_t pf_en:1;
-		uint32_t abp_en:1;
-#else
-		uint32_t abp_en:1;
-		uint32_t pf_en:1;
-		uint32_t mrls_en:1;
-		uint32_t pd_en:1;
-		uint32_t ccint_en:1;
-		uint32_t hpint_en:1;
-		uint32_t aic:2;
-		uint32_t pic:2;
-		uint32_t pcc:1;
-		uint32_t emic:1;
-		uint32_t dlls_en:1;
-		uint32_t reserved_13_15:3;
-		uint32_t abp_d:1;
-		uint32_t pf_d:1;
-		uint32_t mrls_c:1;
-		uint32_t pd_c:1;
-		uint32_t ccint_d:1;
-		uint32_t mrlss:1;
-		uint32_t pds:1;
-		uint32_t emis:1;
-		uint32_t dlls_c:1;
-		uint32_t reserved_25_31:7;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_25_31:7,
+		__BITFIELD_FIELD(uint32_t dlls_c:1,
+		__BITFIELD_FIELD(uint32_t emis:1,
+		__BITFIELD_FIELD(uint32_t pds:1,
+		__BITFIELD_FIELD(uint32_t mrlss:1,
+		__BITFIELD_FIELD(uint32_t ccint_d:1,
+		__BITFIELD_FIELD(uint32_t pd_c:1,
+		__BITFIELD_FIELD(uint32_t mrls_c:1,
+		__BITFIELD_FIELD(uint32_t pf_d:1,
+		__BITFIELD_FIELD(uint32_t abp_d:1,
+		__BITFIELD_FIELD(uint32_t reserved_13_15:3,
+		__BITFIELD_FIELD(uint32_t dlls_en:1,
+		__BITFIELD_FIELD(uint32_t emic:1,
+		__BITFIELD_FIELD(uint32_t pcc:1,
+		__BITFIELD_FIELD(uint32_t pic:1,
+		__BITFIELD_FIELD(uint32_t aic:1,
+		__BITFIELD_FIELD(uint32_t hpint_en:1,
+		__BITFIELD_FIELD(uint32_t ccint_en:1,
+		__BITFIELD_FIELD(uint32_t pd_en:1,
+		__BITFIELD_FIELD(uint32_t mrls_en:1,
+		__BITFIELD_FIELD(uint32_t pf_en:1,
+		__BITFIELD_FIELD(uint32_t abp_en:1,
+		;))))))))))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg034_s cn52xx;
-	struct cvmx_pciercx_cfg034_s cn52xxp1;
-	struct cvmx_pciercx_cfg034_s cn56xx;
-	struct cvmx_pciercx_cfg034_s cn56xxp1;
-	struct cvmx_pciercx_cfg034_s cn61xx;
-	struct cvmx_pciercx_cfg034_s cn63xx;
-	struct cvmx_pciercx_cfg034_s cn63xxp1;
-	struct cvmx_pciercx_cfg034_s cn66xx;
-	struct cvmx_pciercx_cfg034_s cn68xx;
-	struct cvmx_pciercx_cfg034_s cn68xxp1;
-	struct cvmx_pciercx_cfg034_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg035 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg035_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_17_31:15;
-		uint32_t crssv:1;
-		uint32_t reserved_5_15:11;
-		uint32_t crssve:1;
-		uint32_t pmeie:1;
-		uint32_t sefee:1;
-		uint32_t senfee:1;
-		uint32_t secee:1;
-#else
-		uint32_t secee:1;
-		uint32_t senfee:1;
-		uint32_t sefee:1;
-		uint32_t pmeie:1;
-		uint32_t crssve:1;
-		uint32_t reserved_5_15:11;
-		uint32_t crssv:1;
-		uint32_t reserved_17_31:15;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg035_s cn52xx;
-	struct cvmx_pciercx_cfg035_s cn52xxp1;
-	struct cvmx_pciercx_cfg035_s cn56xx;
-	struct cvmx_pciercx_cfg035_s cn56xxp1;
-	struct cvmx_pciercx_cfg035_s cn61xx;
-	struct cvmx_pciercx_cfg035_s cn63xx;
-	struct cvmx_pciercx_cfg035_s cn63xxp1;
-	struct cvmx_pciercx_cfg035_s cn66xx;
-	struct cvmx_pciercx_cfg035_s cn68xx;
-	struct cvmx_pciercx_cfg035_s cn68xxp1;
-	struct cvmx_pciercx_cfg035_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg036 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg036_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_18_31:14;
-		uint32_t pme_pend:1;
-		uint32_t pme_stat:1;
-		uint32_t pme_rid:16;
-#else
-		uint32_t pme_rid:16;
-		uint32_t pme_stat:1;
-		uint32_t pme_pend:1;
-		uint32_t reserved_18_31:14;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg036_s cn52xx;
-	struct cvmx_pciercx_cfg036_s cn52xxp1;
-	struct cvmx_pciercx_cfg036_s cn56xx;
-	struct cvmx_pciercx_cfg036_s cn56xxp1;
-	struct cvmx_pciercx_cfg036_s cn61xx;
-	struct cvmx_pciercx_cfg036_s cn63xx;
-	struct cvmx_pciercx_cfg036_s cn63xxp1;
-	struct cvmx_pciercx_cfg036_s cn66xx;
-	struct cvmx_pciercx_cfg036_s cn68xx;
-	struct cvmx_pciercx_cfg036_s cn68xxp1;
-	struct cvmx_pciercx_cfg036_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg037 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg037_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_20_31:12;
-		uint32_t obffs:2;
-		uint32_t reserved_12_17:6;
-		uint32_t ltrs:1;
-		uint32_t noroprpr:1;
-		uint32_t atom128s:1;
-		uint32_t atom64s:1;
-		uint32_t atom32s:1;
-		uint32_t atom_ops:1;
-		uint32_t reserved_5_5:1;
-		uint32_t ctds:1;
-		uint32_t ctrs:4;
-#else
-		uint32_t ctrs:4;
-		uint32_t ctds:1;
-		uint32_t reserved_5_5:1;
-		uint32_t atom_ops:1;
-		uint32_t atom32s:1;
-		uint32_t atom64s:1;
-		uint32_t atom128s:1;
-		uint32_t noroprpr:1;
-		uint32_t ltrs:1;
-		uint32_t reserved_12_17:6;
-		uint32_t obffs:2;
-		uint32_t reserved_20_31:12;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg037_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_5_31:27;
-		uint32_t ctds:1;
-		uint32_t ctrs:4;
-#else
-		uint32_t ctrs:4;
-		uint32_t ctds:1;
-		uint32_t reserved_5_31:27;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg037_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg037_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg037_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg037_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_14_31:18;
-		uint32_t tph:2;
-		uint32_t reserved_11_11:1;
-		uint32_t noroprpr:1;
-		uint32_t atom128s:1;
-		uint32_t atom64s:1;
-		uint32_t atom32s:1;
-		uint32_t atom_ops:1;
-		uint32_t ari_fw:1;
-		uint32_t ctds:1;
-		uint32_t ctrs:4;
-#else
-		uint32_t ctrs:4;
-		uint32_t ctds:1;
-		uint32_t ari_fw:1;
-		uint32_t atom_ops:1;
-		uint32_t atom32s:1;
-		uint32_t atom64s:1;
-		uint32_t atom128s:1;
-		uint32_t noroprpr:1;
-		uint32_t reserved_11_11:1;
-		uint32_t tph:2;
-		uint32_t reserved_14_31:18;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg037_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg037_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg037_cn66xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_14_31:18;
-		uint32_t tph:2;
-		uint32_t reserved_11_11:1;
-		uint32_t noroprpr:1;
-		uint32_t atom128s:1;
-		uint32_t atom64s:1;
-		uint32_t atom32s:1;
-		uint32_t atom_ops:1;
-		uint32_t ari:1;
-		uint32_t ctds:1;
-		uint32_t ctrs:4;
-#else
-		uint32_t ctrs:4;
-		uint32_t ctds:1;
-		uint32_t ari:1;
-		uint32_t atom_ops:1;
-		uint32_t atom32s:1;
-		uint32_t atom64s:1;
-		uint32_t atom128s:1;
-		uint32_t noroprpr:1;
-		uint32_t reserved_11_11:1;
-		uint32_t tph:2;
-		uint32_t reserved_14_31:18;
-#endif
-	} cn66xx;
-	struct cvmx_pciercx_cfg037_cn66xx cn68xx;
-	struct cvmx_pciercx_cfg037_cn66xx cn68xxp1;
-	struct cvmx_pciercx_cfg037_cnf71xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_20_31:12;
-		uint32_t obffs:2;
-		uint32_t reserved_14_17:4;
-		uint32_t tphs:2;
-		uint32_t ltrs:1;
-		uint32_t noroprpr:1;
-		uint32_t atom128s:1;
-		uint32_t atom64s:1;
-		uint32_t atom32s:1;
-		uint32_t atom_ops:1;
-		uint32_t ari_fw:1;
-		uint32_t ctds:1;
-		uint32_t ctrs:4;
-#else
-		uint32_t ctrs:4;
-		uint32_t ctds:1;
-		uint32_t ari_fw:1;
-		uint32_t atom_ops:1;
-		uint32_t atom32s:1;
-		uint32_t atom64s:1;
-		uint32_t atom128s:1;
-		uint32_t noroprpr:1;
-		uint32_t ltrs:1;
-		uint32_t tphs:2;
-		uint32_t reserved_14_17:4;
-		uint32_t obffs:2;
-		uint32_t reserved_20_31:12;
-#endif
-	} cnf71xx;
-};
-
-union cvmx_pciercx_cfg038 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg038_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_15_31:17;
-		uint32_t obffe:2;
-		uint32_t reserved_11_12:2;
-		uint32_t ltre:1;
-		uint32_t id0_cp:1;
-		uint32_t id0_rq:1;
-		uint32_t atom_op_eb:1;
-		uint32_t atom_op:1;
-		uint32_t ari:1;
-		uint32_t ctd:1;
-		uint32_t ctv:4;
-#else
-		uint32_t ctv:4;
-		uint32_t ctd:1;
-		uint32_t ari:1;
-		uint32_t atom_op:1;
-		uint32_t atom_op_eb:1;
-		uint32_t id0_rq:1;
-		uint32_t id0_cp:1;
-		uint32_t ltre:1;
-		uint32_t reserved_11_12:2;
-		uint32_t obffe:2;
-		uint32_t reserved_15_31:17;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_17_31:15,
+		__BITFIELD_FIELD(uint32_t crssv:1,
+		__BITFIELD_FIELD(uint32_t reserved_5_15:11,
+		__BITFIELD_FIELD(uint32_t crssve:1,
+		__BITFIELD_FIELD(uint32_t pmeie:1,
+		__BITFIELD_FIELD(uint32_t sefee:1,
+		__BITFIELD_FIELD(uint32_t senfee:1,
+		__BITFIELD_FIELD(uint32_t secee:1,
+		;))))))))
 	} s;
-	struct cvmx_pciercx_cfg038_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_5_31:27;
-		uint32_t ctd:1;
-		uint32_t ctv:4;
-#else
-		uint32_t ctv:4;
-		uint32_t ctd:1;
-		uint32_t reserved_5_31:27;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg038_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg038_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg038_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg038_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_10_31:22;
-		uint32_t id0_cp:1;
-		uint32_t id0_rq:1;
-		uint32_t atom_op_eb:1;
-		uint32_t atom_op:1;
-		uint32_t ari:1;
-		uint32_t ctd:1;
-		uint32_t ctv:4;
-#else
-		uint32_t ctv:4;
-		uint32_t ctd:1;
-		uint32_t ari:1;
-		uint32_t atom_op:1;
-		uint32_t atom_op_eb:1;
-		uint32_t id0_rq:1;
-		uint32_t id0_cp:1;
-		uint32_t reserved_10_31:22;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg038_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg038_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg038_cn61xx cn66xx;
-	struct cvmx_pciercx_cfg038_cn61xx cn68xx;
-	struct cvmx_pciercx_cfg038_cn61xx cn68xxp1;
-	struct cvmx_pciercx_cfg038_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg039 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg039_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_9_31:23;
-		uint32_t cls:1;
-		uint32_t slsv:7;
-		uint32_t reserved_0_0:1;
-#else
-		uint32_t reserved_0_0:1;
-		uint32_t slsv:7;
-		uint32_t cls:1;
-		uint32_t reserved_9_31:23;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg039_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg039_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg039_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg039_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg039_s cn61xx;
-	struct cvmx_pciercx_cfg039_s cn63xx;
-	struct cvmx_pciercx_cfg039_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg039_s cn66xx;
-	struct cvmx_pciercx_cfg039_s cn68xx;
-	struct cvmx_pciercx_cfg039_s cn68xxp1;
-	struct cvmx_pciercx_cfg039_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg040 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg040_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_17_31:15;
-		uint32_t cdl:1;
-		uint32_t reserved_13_15:3;
-		uint32_t cde:1;
-		uint32_t csos:1;
-		uint32_t emc:1;
-		uint32_t tm:3;
-		uint32_t sde:1;
-		uint32_t hasd:1;
-		uint32_t ec:1;
-		uint32_t tls:4;
-#else
-		uint32_t tls:4;
-		uint32_t ec:1;
-		uint32_t hasd:1;
-		uint32_t sde:1;
-		uint32_t tm:3;
-		uint32_t emc:1;
-		uint32_t csos:1;
-		uint32_t cde:1;
-		uint32_t reserved_13_15:3;
-		uint32_t cdl:1;
-		uint32_t reserved_17_31:15;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg040_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg040_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg040_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg040_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg040_s cn61xx;
-	struct cvmx_pciercx_cfg040_s cn63xx;
-	struct cvmx_pciercx_cfg040_s cn63xxp1;
-	struct cvmx_pciercx_cfg040_s cn66xx;
-	struct cvmx_pciercx_cfg040_s cn68xx;
-	struct cvmx_pciercx_cfg040_s cn68xxp1;
-	struct cvmx_pciercx_cfg040_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg041 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg041_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg041_s cn52xx;
-	struct cvmx_pciercx_cfg041_s cn52xxp1;
-	struct cvmx_pciercx_cfg041_s cn56xx;
-	struct cvmx_pciercx_cfg041_s cn56xxp1;
-	struct cvmx_pciercx_cfg041_s cn61xx;
-	struct cvmx_pciercx_cfg041_s cn63xx;
-	struct cvmx_pciercx_cfg041_s cn63xxp1;
-	struct cvmx_pciercx_cfg041_s cn66xx;
-	struct cvmx_pciercx_cfg041_s cn68xx;
-	struct cvmx_pciercx_cfg041_s cn68xxp1;
-	struct cvmx_pciercx_cfg041_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg042 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg042_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_0_31:32;
-#else
-		uint32_t reserved_0_31:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg042_s cn52xx;
-	struct cvmx_pciercx_cfg042_s cn52xxp1;
-	struct cvmx_pciercx_cfg042_s cn56xx;
-	struct cvmx_pciercx_cfg042_s cn56xxp1;
-	struct cvmx_pciercx_cfg042_s cn61xx;
-	struct cvmx_pciercx_cfg042_s cn63xx;
-	struct cvmx_pciercx_cfg042_s cn63xxp1;
-	struct cvmx_pciercx_cfg042_s cn66xx;
-	struct cvmx_pciercx_cfg042_s cn68xx;
-	struct cvmx_pciercx_cfg042_s cn68xxp1;
-	struct cvmx_pciercx_cfg042_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg064 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg064_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t nco:12;
-		uint32_t cv:4;
-		uint32_t pcieec:16;
-#else
-		uint32_t pcieec:16;
-		uint32_t cv:4;
-		uint32_t nco:12;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg064_s cn52xx;
-	struct cvmx_pciercx_cfg064_s cn52xxp1;
-	struct cvmx_pciercx_cfg064_s cn56xx;
-	struct cvmx_pciercx_cfg064_s cn56xxp1;
-	struct cvmx_pciercx_cfg064_s cn61xx;
-	struct cvmx_pciercx_cfg064_s cn63xx;
-	struct cvmx_pciercx_cfg064_s cn63xxp1;
-	struct cvmx_pciercx_cfg064_s cn66xx;
-	struct cvmx_pciercx_cfg064_s cn68xx;
-	struct cvmx_pciercx_cfg064_s cn68xxp1;
-	struct cvmx_pciercx_cfg064_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg065 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg065_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t uatombs:1;
-		uint32_t reserved_23_23:1;
-		uint32_t ucies:1;
-		uint32_t reserved_21_21:1;
-		uint32_t ures:1;
-		uint32_t ecrces:1;
-		uint32_t mtlps:1;
-		uint32_t ros:1;
-		uint32_t ucs:1;
-		uint32_t cas:1;
-		uint32_t cts:1;
-		uint32_t fcpes:1;
-		uint32_t ptlps:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdes:1;
-		uint32_t dlpes:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpes:1;
-		uint32_t sdes:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlps:1;
-		uint32_t fcpes:1;
-		uint32_t cts:1;
-		uint32_t cas:1;
-		uint32_t ucs:1;
-		uint32_t ros:1;
-		uint32_t mtlps:1;
-		uint32_t ecrces:1;
-		uint32_t ures:1;
-		uint32_t reserved_21_21:1;
-		uint32_t ucies:1;
-		uint32_t reserved_23_23:1;
-		uint32_t uatombs:1;
-		uint32_t reserved_25_31:7;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg065_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_21_31:11;
-		uint32_t ures:1;
-		uint32_t ecrces:1;
-		uint32_t mtlps:1;
-		uint32_t ros:1;
-		uint32_t ucs:1;
-		uint32_t cas:1;
-		uint32_t cts:1;
-		uint32_t fcpes:1;
-		uint32_t ptlps:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdes:1;
-		uint32_t dlpes:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpes:1;
-		uint32_t sdes:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlps:1;
-		uint32_t fcpes:1;
-		uint32_t cts:1;
-		uint32_t cas:1;
-		uint32_t ucs:1;
-		uint32_t ros:1;
-		uint32_t mtlps:1;
-		uint32_t ecrces:1;
-		uint32_t ures:1;
-		uint32_t reserved_21_31:11;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg065_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg065_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg065_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg065_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t uatombs:1;
-		uint32_t reserved_21_23:3;
-		uint32_t ures:1;
-		uint32_t ecrces:1;
-		uint32_t mtlps:1;
-		uint32_t ros:1;
-		uint32_t ucs:1;
-		uint32_t cas:1;
-		uint32_t cts:1;
-		uint32_t fcpes:1;
-		uint32_t ptlps:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdes:1;
-		uint32_t dlpes:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpes:1;
-		uint32_t sdes:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlps:1;
-		uint32_t fcpes:1;
-		uint32_t cts:1;
-		uint32_t cas:1;
-		uint32_t ucs:1;
-		uint32_t ros:1;
-		uint32_t mtlps:1;
-		uint32_t ecrces:1;
-		uint32_t ures:1;
-		uint32_t reserved_21_23:3;
-		uint32_t uatombs:1;
-		uint32_t reserved_25_31:7;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg065_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg065_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg065_cn61xx cn66xx;
-	struct cvmx_pciercx_cfg065_cn61xx cn68xx;
-	struct cvmx_pciercx_cfg065_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg065_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg066 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg066_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t uatombm:1;
-		uint32_t reserved_23_23:1;
-		uint32_t uciem:1;
-		uint32_t reserved_21_21:1;
-		uint32_t urem:1;
-		uint32_t ecrcem:1;
-		uint32_t mtlpm:1;
-		uint32_t rom:1;
-		uint32_t ucm:1;
-		uint32_t cam:1;
-		uint32_t ctm:1;
-		uint32_t fcpem:1;
-		uint32_t ptlpm:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdem:1;
-		uint32_t dlpem:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpem:1;
-		uint32_t sdem:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlpm:1;
-		uint32_t fcpem:1;
-		uint32_t ctm:1;
-		uint32_t cam:1;
-		uint32_t ucm:1;
-		uint32_t rom:1;
-		uint32_t mtlpm:1;
-		uint32_t ecrcem:1;
-		uint32_t urem:1;
-		uint32_t reserved_21_21:1;
-		uint32_t uciem:1;
-		uint32_t reserved_23_23:1;
-		uint32_t uatombm:1;
-		uint32_t reserved_25_31:7;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg066_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_21_31:11;
-		uint32_t urem:1;
-		uint32_t ecrcem:1;
-		uint32_t mtlpm:1;
-		uint32_t rom:1;
-		uint32_t ucm:1;
-		uint32_t cam:1;
-		uint32_t ctm:1;
-		uint32_t fcpem:1;
-		uint32_t ptlpm:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdem:1;
-		uint32_t dlpem:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpem:1;
-		uint32_t sdem:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlpm:1;
-		uint32_t fcpem:1;
-		uint32_t ctm:1;
-		uint32_t cam:1;
-		uint32_t ucm:1;
-		uint32_t rom:1;
-		uint32_t mtlpm:1;
-		uint32_t ecrcem:1;
-		uint32_t urem:1;
-		uint32_t reserved_21_31:11;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg066_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg066_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg066_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg066_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t uatombm:1;
-		uint32_t reserved_21_23:3;
-		uint32_t urem:1;
-		uint32_t ecrcem:1;
-		uint32_t mtlpm:1;
-		uint32_t rom:1;
-		uint32_t ucm:1;
-		uint32_t cam:1;
-		uint32_t ctm:1;
-		uint32_t fcpem:1;
-		uint32_t ptlpm:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdem:1;
-		uint32_t dlpem:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpem:1;
-		uint32_t sdem:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlpm:1;
-		uint32_t fcpem:1;
-		uint32_t ctm:1;
-		uint32_t cam:1;
-		uint32_t ucm:1;
-		uint32_t rom:1;
-		uint32_t mtlpm:1;
-		uint32_t ecrcem:1;
-		uint32_t urem:1;
-		uint32_t reserved_21_23:3;
-		uint32_t uatombm:1;
-		uint32_t reserved_25_31:7;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg066_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg066_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg066_cn61xx cn66xx;
-	struct cvmx_pciercx_cfg066_cn61xx cn68xx;
-	struct cvmx_pciercx_cfg066_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg066_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg067 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg067_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t uatombs:1;
-		uint32_t reserved_23_23:1;
-		uint32_t ucies:1;
-		uint32_t reserved_21_21:1;
-		uint32_t ures:1;
-		uint32_t ecrces:1;
-		uint32_t mtlps:1;
-		uint32_t ros:1;
-		uint32_t ucs:1;
-		uint32_t cas:1;
-		uint32_t cts:1;
-		uint32_t fcpes:1;
-		uint32_t ptlps:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdes:1;
-		uint32_t dlpes:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpes:1;
-		uint32_t sdes:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlps:1;
-		uint32_t fcpes:1;
-		uint32_t cts:1;
-		uint32_t cas:1;
-		uint32_t ucs:1;
-		uint32_t ros:1;
-		uint32_t mtlps:1;
-		uint32_t ecrces:1;
-		uint32_t ures:1;
-		uint32_t reserved_21_21:1;
-		uint32_t ucies:1;
-		uint32_t reserved_23_23:1;
-		uint32_t uatombs:1;
-		uint32_t reserved_25_31:7;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_22_31:10,
+		__BITFIELD_FIELD(uint32_t ler:1,
+		__BITFIELD_FIELD(uint32_t ep3s:1,
+		__BITFIELD_FIELD(uint32_t ep2s:1,
+		__BITFIELD_FIELD(uint32_t ep1s:1,
+		__BITFIELD_FIELD(uint32_t eqc:1,
+		__BITFIELD_FIELD(uint32_t cdl:1,
+		__BITFIELD_FIELD(uint32_t cde:4,
+		__BITFIELD_FIELD(uint32_t csos:1,
+		__BITFIELD_FIELD(uint32_t emc:1,
+		__BITFIELD_FIELD(uint32_t tm:3,
+		__BITFIELD_FIELD(uint32_t sde:1,
+		__BITFIELD_FIELD(uint32_t hasd:1,
+		__BITFIELD_FIELD(uint32_t ec:1,
+		__BITFIELD_FIELD(uint32_t tls:4,
+		;)))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg067_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_21_31:11;
-		uint32_t ures:1;
-		uint32_t ecrces:1;
-		uint32_t mtlps:1;
-		uint32_t ros:1;
-		uint32_t ucs:1;
-		uint32_t cas:1;
-		uint32_t cts:1;
-		uint32_t fcpes:1;
-		uint32_t ptlps:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdes:1;
-		uint32_t dlpes:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpes:1;
-		uint32_t sdes:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlps:1;
-		uint32_t fcpes:1;
-		uint32_t cts:1;
-		uint32_t cas:1;
-		uint32_t ucs:1;
-		uint32_t ros:1;
-		uint32_t mtlps:1;
-		uint32_t ecrces:1;
-		uint32_t ures:1;
-		uint32_t reserved_21_31:11;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg067_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg067_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg067_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg067_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_25_31:7;
-		uint32_t uatombs:1;
-		uint32_t reserved_21_23:3;
-		uint32_t ures:1;
-		uint32_t ecrces:1;
-		uint32_t mtlps:1;
-		uint32_t ros:1;
-		uint32_t ucs:1;
-		uint32_t cas:1;
-		uint32_t cts:1;
-		uint32_t fcpes:1;
-		uint32_t ptlps:1;
-		uint32_t reserved_6_11:6;
-		uint32_t sdes:1;
-		uint32_t dlpes:1;
-		uint32_t reserved_0_3:4;
-#else
-		uint32_t reserved_0_3:4;
-		uint32_t dlpes:1;
-		uint32_t sdes:1;
-		uint32_t reserved_6_11:6;
-		uint32_t ptlps:1;
-		uint32_t fcpes:1;
-		uint32_t cts:1;
-		uint32_t cas:1;
-		uint32_t ucs:1;
-		uint32_t ros:1;
-		uint32_t mtlps:1;
-		uint32_t ecrces:1;
-		uint32_t ures:1;
-		uint32_t reserved_21_23:3;
-		uint32_t uatombs:1;
-		uint32_t reserved_25_31:7;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg067_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg067_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg067_cn61xx cn66xx;
-	struct cvmx_pciercx_cfg067_cn61xx cn68xx;
-	struct cvmx_pciercx_cfg067_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg067_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg068 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg068_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_15_31:17;
-		uint32_t cies:1;
-		uint32_t anfes:1;
-		uint32_t rtts:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rnrs:1;
-		uint32_t bdllps:1;
-		uint32_t btlps:1;
-		uint32_t reserved_1_5:5;
-		uint32_t res:1;
-#else
-		uint32_t res:1;
-		uint32_t reserved_1_5:5;
-		uint32_t btlps:1;
-		uint32_t bdllps:1;
-		uint32_t rnrs:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rtts:1;
-		uint32_t anfes:1;
-		uint32_t cies:1;
-		uint32_t reserved_15_31:17;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg068_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_14_31:18;
-		uint32_t anfes:1;
-		uint32_t rtts:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rnrs:1;
-		uint32_t bdllps:1;
-		uint32_t btlps:1;
-		uint32_t reserved_1_5:5;
-		uint32_t res:1;
-#else
-		uint32_t res:1;
-		uint32_t reserved_1_5:5;
-		uint32_t btlps:1;
-		uint32_t bdllps:1;
-		uint32_t rnrs:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rtts:1;
-		uint32_t anfes:1;
-		uint32_t reserved_14_31:18;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg068_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg068_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg068_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg068_cn52xx cn61xx;
-	struct cvmx_pciercx_cfg068_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg068_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg068_cn52xx cn66xx;
-	struct cvmx_pciercx_cfg068_cn52xx cn68xx;
-	struct cvmx_pciercx_cfg068_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg068_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg069 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg069_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_15_31:17;
-		uint32_t ciem:1;
-		uint32_t anfem:1;
-		uint32_t rttm:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rnrm:1;
-		uint32_t bdllpm:1;
-		uint32_t btlpm:1;
-		uint32_t reserved_1_5:5;
-		uint32_t rem:1;
-#else
-		uint32_t rem:1;
-		uint32_t reserved_1_5:5;
-		uint32_t btlpm:1;
-		uint32_t bdllpm:1;
-		uint32_t rnrm:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rttm:1;
-		uint32_t anfem:1;
-		uint32_t ciem:1;
-		uint32_t reserved_15_31:17;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg069_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_14_31:18;
-		uint32_t anfem:1;
-		uint32_t rttm:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rnrm:1;
-		uint32_t bdllpm:1;
-		uint32_t btlpm:1;
-		uint32_t reserved_1_5:5;
-		uint32_t rem:1;
-#else
-		uint32_t rem:1;
-		uint32_t reserved_1_5:5;
-		uint32_t btlpm:1;
-		uint32_t bdllpm:1;
-		uint32_t rnrm:1;
-		uint32_t reserved_9_11:3;
-		uint32_t rttm:1;
-		uint32_t anfem:1;
-		uint32_t reserved_14_31:18;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg069_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg069_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg069_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg069_cn52xx cn61xx;
-	struct cvmx_pciercx_cfg069_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg069_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg069_cn52xx cn66xx;
-	struct cvmx_pciercx_cfg069_cn52xx cn68xx;
-	struct cvmx_pciercx_cfg069_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg069_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg070 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg070_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_9_31:23;
-		uint32_t ce:1;
-		uint32_t cc:1;
-		uint32_t ge:1;
-		uint32_t gc:1;
-		uint32_t fep:5;
-#else
-		uint32_t fep:5;
-		uint32_t gc:1;
-		uint32_t ge:1;
-		uint32_t cc:1;
-		uint32_t ce:1;
-		uint32_t reserved_9_31:23;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg070_s cn52xx;
-	struct cvmx_pciercx_cfg070_s cn52xxp1;
-	struct cvmx_pciercx_cfg070_s cn56xx;
-	struct cvmx_pciercx_cfg070_s cn56xxp1;
-	struct cvmx_pciercx_cfg070_s cn61xx;
-	struct cvmx_pciercx_cfg070_s cn63xx;
-	struct cvmx_pciercx_cfg070_s cn63xxp1;
-	struct cvmx_pciercx_cfg070_s cn66xx;
-	struct cvmx_pciercx_cfg070_s cn68xx;
-	struct cvmx_pciercx_cfg070_s cn68xxp1;
-	struct cvmx_pciercx_cfg070_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg071 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg071_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dword1:32;
-#else
-		uint32_t dword1:32;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_12_31:20,
+		__BITFIELD_FIELD(uint32_t tplp:1,
+		__BITFIELD_FIELD(uint32_t reserved_9_10:2,
+		__BITFIELD_FIELD(uint32_t ce:1,
+		__BITFIELD_FIELD(uint32_t cc:1,
+		__BITFIELD_FIELD(uint32_t ge:1,
+		__BITFIELD_FIELD(uint32_t gc:1,
+		__BITFIELD_FIELD(uint32_t fep:5,
+		;))))))))
 	} s;
-	struct cvmx_pciercx_cfg071_s cn52xx;
-	struct cvmx_pciercx_cfg071_s cn52xxp1;
-	struct cvmx_pciercx_cfg071_s cn56xx;
-	struct cvmx_pciercx_cfg071_s cn56xxp1;
-	struct cvmx_pciercx_cfg071_s cn61xx;
-	struct cvmx_pciercx_cfg071_s cn63xx;
-	struct cvmx_pciercx_cfg071_s cn63xxp1;
-	struct cvmx_pciercx_cfg071_s cn66xx;
-	struct cvmx_pciercx_cfg071_s cn68xx;
-	struct cvmx_pciercx_cfg071_s cn68xxp1;
-	struct cvmx_pciercx_cfg071_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg072 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg072_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dword2:32;
-#else
-		uint32_t dword2:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg072_s cn52xx;
-	struct cvmx_pciercx_cfg072_s cn52xxp1;
-	struct cvmx_pciercx_cfg072_s cn56xx;
-	struct cvmx_pciercx_cfg072_s cn56xxp1;
-	struct cvmx_pciercx_cfg072_s cn61xx;
-	struct cvmx_pciercx_cfg072_s cn63xx;
-	struct cvmx_pciercx_cfg072_s cn63xxp1;
-	struct cvmx_pciercx_cfg072_s cn66xx;
-	struct cvmx_pciercx_cfg072_s cn68xx;
-	struct cvmx_pciercx_cfg072_s cn68xxp1;
-	struct cvmx_pciercx_cfg072_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg073 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg073_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dword3:32;
-#else
-		uint32_t dword3:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg073_s cn52xx;
-	struct cvmx_pciercx_cfg073_s cn52xxp1;
-	struct cvmx_pciercx_cfg073_s cn56xx;
-	struct cvmx_pciercx_cfg073_s cn56xxp1;
-	struct cvmx_pciercx_cfg073_s cn61xx;
-	struct cvmx_pciercx_cfg073_s cn63xx;
-	struct cvmx_pciercx_cfg073_s cn63xxp1;
-	struct cvmx_pciercx_cfg073_s cn66xx;
-	struct cvmx_pciercx_cfg073_s cn68xx;
-	struct cvmx_pciercx_cfg073_s cn68xxp1;
-	struct cvmx_pciercx_cfg073_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg074 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg074_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dword4:32;
-#else
-		uint32_t dword4:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg074_s cn52xx;
-	struct cvmx_pciercx_cfg074_s cn52xxp1;
-	struct cvmx_pciercx_cfg074_s cn56xx;
-	struct cvmx_pciercx_cfg074_s cn56xxp1;
-	struct cvmx_pciercx_cfg074_s cn61xx;
-	struct cvmx_pciercx_cfg074_s cn63xx;
-	struct cvmx_pciercx_cfg074_s cn63xxp1;
-	struct cvmx_pciercx_cfg074_s cn66xx;
-	struct cvmx_pciercx_cfg074_s cn68xx;
-	struct cvmx_pciercx_cfg074_s cn68xxp1;
-	struct cvmx_pciercx_cfg074_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg075 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg075_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_3_31:29;
-		uint32_t fere:1;
-		uint32_t nfere:1;
-		uint32_t cere:1;
-#else
-		uint32_t cere:1;
-		uint32_t nfere:1;
-		uint32_t fere:1;
-		uint32_t reserved_3_31:29;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg075_s cn52xx;
-	struct cvmx_pciercx_cfg075_s cn52xxp1;
-	struct cvmx_pciercx_cfg075_s cn56xx;
-	struct cvmx_pciercx_cfg075_s cn56xxp1;
-	struct cvmx_pciercx_cfg075_s cn61xx;
-	struct cvmx_pciercx_cfg075_s cn63xx;
-	struct cvmx_pciercx_cfg075_s cn63xxp1;
-	struct cvmx_pciercx_cfg075_s cn66xx;
-	struct cvmx_pciercx_cfg075_s cn68xx;
-	struct cvmx_pciercx_cfg075_s cn68xxp1;
-	struct cvmx_pciercx_cfg075_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg076 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg076_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t aeimn:5;
-		uint32_t reserved_7_26:20;
-		uint32_t femr:1;
-		uint32_t nfemr:1;
-		uint32_t fuf:1;
-		uint32_t multi_efnfr:1;
-		uint32_t efnfr:1;
-		uint32_t multi_ecr:1;
-		uint32_t ecr:1;
-#else
-		uint32_t ecr:1;
-		uint32_t multi_ecr:1;
-		uint32_t efnfr:1;
-		uint32_t multi_efnfr:1;
-		uint32_t fuf:1;
-		uint32_t nfemr:1;
-		uint32_t femr:1;
-		uint32_t reserved_7_26:20;
-		uint32_t aeimn:5;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_3_31:29,
+		__BITFIELD_FIELD(uint32_t fere:1,
+		__BITFIELD_FIELD(uint32_t nfere:1,
+		__BITFIELD_FIELD(uint32_t cere:1,
+		;))))
 	} s;
-	struct cvmx_pciercx_cfg076_s cn52xx;
-	struct cvmx_pciercx_cfg076_s cn52xxp1;
-	struct cvmx_pciercx_cfg076_s cn56xx;
-	struct cvmx_pciercx_cfg076_s cn56xxp1;
-	struct cvmx_pciercx_cfg076_s cn61xx;
-	struct cvmx_pciercx_cfg076_s cn63xx;
-	struct cvmx_pciercx_cfg076_s cn63xxp1;
-	struct cvmx_pciercx_cfg076_s cn66xx;
-	struct cvmx_pciercx_cfg076_s cn68xx;
-	struct cvmx_pciercx_cfg076_s cn68xxp1;
-	struct cvmx_pciercx_cfg076_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg077 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg077_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t efnfsi:16;
-		uint32_t ecsi:16;
-#else
-		uint32_t ecsi:16;
-		uint32_t efnfsi:16;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg077_s cn52xx;
-	struct cvmx_pciercx_cfg077_s cn52xxp1;
-	struct cvmx_pciercx_cfg077_s cn56xx;
-	struct cvmx_pciercx_cfg077_s cn56xxp1;
-	struct cvmx_pciercx_cfg077_s cn61xx;
-	struct cvmx_pciercx_cfg077_s cn63xx;
-	struct cvmx_pciercx_cfg077_s cn63xxp1;
-	struct cvmx_pciercx_cfg077_s cn66xx;
-	struct cvmx_pciercx_cfg077_s cn68xx;
-	struct cvmx_pciercx_cfg077_s cn68xxp1;
-	struct cvmx_pciercx_cfg077_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg448 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg448_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t rtl:16;
-		uint32_t rtltl:16;
-#else
-		uint32_t rtltl:16;
-		uint32_t rtl:16;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg448_s cn52xx;
-	struct cvmx_pciercx_cfg448_s cn52xxp1;
-	struct cvmx_pciercx_cfg448_s cn56xx;
-	struct cvmx_pciercx_cfg448_s cn56xxp1;
-	struct cvmx_pciercx_cfg448_s cn61xx;
-	struct cvmx_pciercx_cfg448_s cn63xx;
-	struct cvmx_pciercx_cfg448_s cn63xxp1;
-	struct cvmx_pciercx_cfg448_s cn66xx;
-	struct cvmx_pciercx_cfg448_s cn68xx;
-	struct cvmx_pciercx_cfg448_s cn68xxp1;
-	struct cvmx_pciercx_cfg448_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg449 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg449_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t omr:32;
-#else
-		uint32_t omr:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg449_s cn52xx;
-	struct cvmx_pciercx_cfg449_s cn52xxp1;
-	struct cvmx_pciercx_cfg449_s cn56xx;
-	struct cvmx_pciercx_cfg449_s cn56xxp1;
-	struct cvmx_pciercx_cfg449_s cn61xx;
-	struct cvmx_pciercx_cfg449_s cn63xx;
-	struct cvmx_pciercx_cfg449_s cn63xxp1;
-	struct cvmx_pciercx_cfg449_s cn66xx;
-	struct cvmx_pciercx_cfg449_s cn68xx;
-	struct cvmx_pciercx_cfg449_s cn68xxp1;
-	struct cvmx_pciercx_cfg449_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg450 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg450_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t lpec:8;
-		uint32_t reserved_22_23:2;
-		uint32_t link_state:6;
-		uint32_t force_link:1;
-		uint32_t reserved_8_14:7;
-		uint32_t link_num:8;
-#else
-		uint32_t link_num:8;
-		uint32_t reserved_8_14:7;
-		uint32_t force_link:1;
-		uint32_t link_state:6;
-		uint32_t reserved_22_23:2;
-		uint32_t lpec:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg450_s cn52xx;
-	struct cvmx_pciercx_cfg450_s cn52xxp1;
-	struct cvmx_pciercx_cfg450_s cn56xx;
-	struct cvmx_pciercx_cfg450_s cn56xxp1;
-	struct cvmx_pciercx_cfg450_s cn61xx;
-	struct cvmx_pciercx_cfg450_s cn63xx;
-	struct cvmx_pciercx_cfg450_s cn63xxp1;
-	struct cvmx_pciercx_cfg450_s cn66xx;
-	struct cvmx_pciercx_cfg450_s cn68xx;
-	struct cvmx_pciercx_cfg450_s cn68xxp1;
-	struct cvmx_pciercx_cfg450_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg451 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg451_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_31_31:1;
-		uint32_t easpml1:1;
-		uint32_t l1el:3;
-		uint32_t l0el:3;
-		uint32_t n_fts_cc:8;
-		uint32_t n_fts:8;
-		uint32_t ack_freq:8;
-#else
-		uint32_t ack_freq:8;
-		uint32_t n_fts:8;
-		uint32_t n_fts_cc:8;
-		uint32_t l0el:3;
-		uint32_t l1el:3;
-		uint32_t easpml1:1;
-		uint32_t reserved_31_31:1;
-#endif
+		__BITFIELD_FIELD(uint32_t rtl:16,
+		__BITFIELD_FIELD(uint32_t rtltl:16,
+		;))
 	} s;
-	struct cvmx_pciercx_cfg451_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_30_31:2;
-		uint32_t l1el:3;
-		uint32_t l0el:3;
-		uint32_t n_fts_cc:8;
-		uint32_t n_fts:8;
-		uint32_t ack_freq:8;
-#else
-		uint32_t ack_freq:8;
-		uint32_t n_fts:8;
-		uint32_t n_fts_cc:8;
-		uint32_t l0el:3;
-		uint32_t l1el:3;
-		uint32_t reserved_30_31:2;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg451_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg451_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg451_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg451_s cn61xx;
-	struct cvmx_pciercx_cfg451_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg451_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg451_s cn66xx;
-	struct cvmx_pciercx_cfg451_s cn68xx;
-	struct cvmx_pciercx_cfg451_s cn68xxp1;
-	struct cvmx_pciercx_cfg451_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg452 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg452_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_26_31:6;
-		uint32_t eccrc:1;
-		uint32_t reserved_22_24:3;
-		uint32_t lme:6;
-		uint32_t reserved_8_15:8;
-		uint32_t flm:1;
-		uint32_t reserved_6_6:1;
-		uint32_t dllle:1;
-		uint32_t reserved_4_4:1;
-		uint32_t ra:1;
-		uint32_t le:1;
-		uint32_t sd:1;
-		uint32_t omr:1;
-#else
-		uint32_t omr:1;
-		uint32_t sd:1;
-		uint32_t le:1;
-		uint32_t ra:1;
-		uint32_t reserved_4_4:1;
-		uint32_t dllle:1;
-		uint32_t reserved_6_6:1;
-		uint32_t flm:1;
-		uint32_t reserved_8_15:8;
-		uint32_t lme:6;
-		uint32_t reserved_22_24:3;
-		uint32_t eccrc:1;
-		uint32_t reserved_26_31:6;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_26_31:6,
+		__BITFIELD_FIELD(uint32_t eccrc:1,
+		__BITFIELD_FIELD(uint32_t reserved_22_24:3,
+		__BITFIELD_FIELD(uint32_t lme:6,
+		__BITFIELD_FIELD(uint32_t reserved_12_15:4,
+		__BITFIELD_FIELD(uint32_t link_rate:4,
+		__BITFIELD_FIELD(uint32_t flm:1,
+		__BITFIELD_FIELD(uint32_t reserved_6_6:1,
+		__BITFIELD_FIELD(uint32_t dllle:1,
+		__BITFIELD_FIELD(uint32_t reserved_4_4:1,
+		__BITFIELD_FIELD(uint32_t ra:1,
+		__BITFIELD_FIELD(uint32_t le:1,
+		__BITFIELD_FIELD(uint32_t sd:1,
+		__BITFIELD_FIELD(uint32_t omr:1,
+		;))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg452_s cn52xx;
-	struct cvmx_pciercx_cfg452_s cn52xxp1;
-	struct cvmx_pciercx_cfg452_s cn56xx;
-	struct cvmx_pciercx_cfg452_s cn56xxp1;
-	struct cvmx_pciercx_cfg452_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_22_31:10;
-		uint32_t lme:6;
-		uint32_t reserved_8_15:8;
-		uint32_t flm:1;
-		uint32_t reserved_6_6:1;
-		uint32_t dllle:1;
-		uint32_t reserved_4_4:1;
-		uint32_t ra:1;
-		uint32_t le:1;
-		uint32_t sd:1;
-		uint32_t omr:1;
-#else
-		uint32_t omr:1;
-		uint32_t sd:1;
-		uint32_t le:1;
-		uint32_t ra:1;
-		uint32_t reserved_4_4:1;
-		uint32_t dllle:1;
-		uint32_t reserved_6_6:1;
-		uint32_t flm:1;
-		uint32_t reserved_8_15:8;
-		uint32_t lme:6;
-		uint32_t reserved_22_31:10;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg452_s cn63xx;
-	struct cvmx_pciercx_cfg452_s cn63xxp1;
-	struct cvmx_pciercx_cfg452_cn61xx cn66xx;
-	struct cvmx_pciercx_cfg452_cn61xx cn68xx;
-	struct cvmx_pciercx_cfg452_cn61xx cn68xxp1;
-	struct cvmx_pciercx_cfg452_cn61xx cnf71xx;
-};
-
-union cvmx_pciercx_cfg453 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg453_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dlld:1;
-		uint32_t reserved_26_30:5;
-		uint32_t ack_nak:1;
-		uint32_t fcd:1;
-		uint32_t ilst:24;
-#else
-		uint32_t ilst:24;
-		uint32_t fcd:1;
-		uint32_t ack_nak:1;
-		uint32_t reserved_26_30:5;
-		uint32_t dlld:1;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg453_s cn52xx;
-	struct cvmx_pciercx_cfg453_s cn52xxp1;
-	struct cvmx_pciercx_cfg453_s cn56xx;
-	struct cvmx_pciercx_cfg453_s cn56xxp1;
-	struct cvmx_pciercx_cfg453_s cn61xx;
-	struct cvmx_pciercx_cfg453_s cn63xx;
-	struct cvmx_pciercx_cfg453_s cn63xxp1;
-	struct cvmx_pciercx_cfg453_s cn66xx;
-	struct cvmx_pciercx_cfg453_s cn68xx;
-	struct cvmx_pciercx_cfg453_s cn68xxp1;
-	struct cvmx_pciercx_cfg453_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg454 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg454_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t cx_nfunc:3;
-		uint32_t tmfcwt:5;
-		uint32_t tmanlt:5;
-		uint32_t tmrt:5;
-		uint32_t reserved_11_13:3;
-		uint32_t nskps:3;
-		uint32_t reserved_0_7:8;
-#else
-		uint32_t reserved_0_7:8;
-		uint32_t nskps:3;
-		uint32_t reserved_11_13:3;
-		uint32_t tmrt:5;
-		uint32_t tmanlt:5;
-		uint32_t tmfcwt:5;
-		uint32_t cx_nfunc:3;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg454_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_29_31:3;
-		uint32_t tmfcwt:5;
-		uint32_t tmanlt:5;
-		uint32_t tmrt:5;
-		uint32_t reserved_11_13:3;
-		uint32_t nskps:3;
-		uint32_t reserved_4_7:4;
-		uint32_t ntss:4;
-#else
-		uint32_t ntss:4;
-		uint32_t reserved_4_7:4;
-		uint32_t nskps:3;
-		uint32_t reserved_11_13:3;
-		uint32_t tmrt:5;
-		uint32_t tmanlt:5;
-		uint32_t tmfcwt:5;
-		uint32_t reserved_29_31:3;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg454_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg454_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg454_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg454_cn61xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t cx_nfunc:3;
-		uint32_t tmfcwt:5;
-		uint32_t tmanlt:5;
-		uint32_t tmrt:5;
-		uint32_t reserved_8_13:6;
-		uint32_t mfuncn:8;
-#else
-		uint32_t mfuncn:8;
-		uint32_t reserved_8_13:6;
-		uint32_t tmrt:5;
-		uint32_t tmanlt:5;
-		uint32_t tmfcwt:5;
-		uint32_t cx_nfunc:3;
-#endif
-	} cn61xx;
-	struct cvmx_pciercx_cfg454_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg454_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg454_cn61xx cn66xx;
-	struct cvmx_pciercx_cfg454_cn61xx cn68xx;
-	struct cvmx_pciercx_cfg454_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg454_cn61xx cnf71xx;
 };
 
 union cvmx_pciercx_cfg455 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg455_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t m_cfg0_filt:1;
-		uint32_t m_io_filt:1;
-		uint32_t msg_ctrl:1;
-		uint32_t m_cpl_ecrc_filt:1;
-		uint32_t m_ecrc_filt:1;
-		uint32_t m_cpl_len_err:1;
-		uint32_t m_cpl_attr_err:1;
-		uint32_t m_cpl_tc_err:1;
-		uint32_t m_cpl_fun_err:1;
-		uint32_t m_cpl_rid_err:1;
-		uint32_t m_cpl_tag_err:1;
-		uint32_t m_lk_filt:1;
-		uint32_t m_cfg1_filt:1;
-		uint32_t m_bar_match:1;
-		uint32_t m_pois_filt:1;
-		uint32_t m_fun:1;
-		uint32_t dfcwt:1;
-		uint32_t reserved_11_14:4;
-		uint32_t skpiv:11;
-#else
-		uint32_t skpiv:11;
-		uint32_t reserved_11_14:4;
-		uint32_t dfcwt:1;
-		uint32_t m_fun:1;
-		uint32_t m_pois_filt:1;
-		uint32_t m_bar_match:1;
-		uint32_t m_cfg1_filt:1;
-		uint32_t m_lk_filt:1;
-		uint32_t m_cpl_tag_err:1;
-		uint32_t m_cpl_rid_err:1;
-		uint32_t m_cpl_fun_err:1;
-		uint32_t m_cpl_tc_err:1;
-		uint32_t m_cpl_attr_err:1;
-		uint32_t m_cpl_len_err:1;
-		uint32_t m_ecrc_filt:1;
-		uint32_t m_cpl_ecrc_filt:1;
-		uint32_t msg_ctrl:1;
-		uint32_t m_io_filt:1;
-		uint32_t m_cfg0_filt:1;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg455_s cn52xx;
-	struct cvmx_pciercx_cfg455_s cn52xxp1;
-	struct cvmx_pciercx_cfg455_s cn56xx;
-	struct cvmx_pciercx_cfg455_s cn56xxp1;
-	struct cvmx_pciercx_cfg455_s cn61xx;
-	struct cvmx_pciercx_cfg455_s cn63xx;
-	struct cvmx_pciercx_cfg455_s cn63xxp1;
-	struct cvmx_pciercx_cfg455_s cn66xx;
-	struct cvmx_pciercx_cfg455_s cn68xx;
-	struct cvmx_pciercx_cfg455_s cn68xxp1;
-	struct cvmx_pciercx_cfg455_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg456 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg456_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_4_31:28;
-		uint32_t m_handle_flush:1;
-		uint32_t m_dabort_4ucpl:1;
-		uint32_t m_vend1_drp:1;
-		uint32_t m_vend0_drp:1;
-#else
-		uint32_t m_vend0_drp:1;
-		uint32_t m_vend1_drp:1;
-		uint32_t m_dabort_4ucpl:1;
-		uint32_t m_handle_flush:1;
-		uint32_t reserved_4_31:28;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg456_cn52xx {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_2_31:30;
-		uint32_t m_vend1_drp:1;
-		uint32_t m_vend0_drp:1;
-#else
-		uint32_t m_vend0_drp:1;
-		uint32_t m_vend1_drp:1;
-		uint32_t reserved_2_31:30;
-#endif
-	} cn52xx;
-	struct cvmx_pciercx_cfg456_cn52xx cn52xxp1;
-	struct cvmx_pciercx_cfg456_cn52xx cn56xx;
-	struct cvmx_pciercx_cfg456_cn52xx cn56xxp1;
-	struct cvmx_pciercx_cfg456_s cn61xx;
-	struct cvmx_pciercx_cfg456_cn52xx cn63xx;
-	struct cvmx_pciercx_cfg456_cn52xx cn63xxp1;
-	struct cvmx_pciercx_cfg456_s cn66xx;
-	struct cvmx_pciercx_cfg456_s cn68xx;
-	struct cvmx_pciercx_cfg456_cn52xx cn68xxp1;
-	struct cvmx_pciercx_cfg456_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg458 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg458_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dbg_info_l32:32;
-#else
-		uint32_t dbg_info_l32:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg458_s cn52xx;
-	struct cvmx_pciercx_cfg458_s cn52xxp1;
-	struct cvmx_pciercx_cfg458_s cn56xx;
-	struct cvmx_pciercx_cfg458_s cn56xxp1;
-	struct cvmx_pciercx_cfg458_s cn61xx;
-	struct cvmx_pciercx_cfg458_s cn63xx;
-	struct cvmx_pciercx_cfg458_s cn63xxp1;
-	struct cvmx_pciercx_cfg458_s cn66xx;
-	struct cvmx_pciercx_cfg458_s cn68xx;
-	struct cvmx_pciercx_cfg458_s cn68xxp1;
-	struct cvmx_pciercx_cfg458_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg459 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg459_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t dbg_info_u32:32;
-#else
-		uint32_t dbg_info_u32:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg459_s cn52xx;
-	struct cvmx_pciercx_cfg459_s cn52xxp1;
-	struct cvmx_pciercx_cfg459_s cn56xx;
-	struct cvmx_pciercx_cfg459_s cn56xxp1;
-	struct cvmx_pciercx_cfg459_s cn61xx;
-	struct cvmx_pciercx_cfg459_s cn63xx;
-	struct cvmx_pciercx_cfg459_s cn63xxp1;
-	struct cvmx_pciercx_cfg459_s cn66xx;
-	struct cvmx_pciercx_cfg459_s cn68xx;
-	struct cvmx_pciercx_cfg459_s cn68xxp1;
-	struct cvmx_pciercx_cfg459_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg460 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg460_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_20_31:12;
-		uint32_t tphfcc:8;
-		uint32_t tpdfcc:12;
-#else
-		uint32_t tpdfcc:12;
-		uint32_t tphfcc:8;
-		uint32_t reserved_20_31:12;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg460_s cn52xx;
-	struct cvmx_pciercx_cfg460_s cn52xxp1;
-	struct cvmx_pciercx_cfg460_s cn56xx;
-	struct cvmx_pciercx_cfg460_s cn56xxp1;
-	struct cvmx_pciercx_cfg460_s cn61xx;
-	struct cvmx_pciercx_cfg460_s cn63xx;
-	struct cvmx_pciercx_cfg460_s cn63xxp1;
-	struct cvmx_pciercx_cfg460_s cn66xx;
-	struct cvmx_pciercx_cfg460_s cn68xx;
-	struct cvmx_pciercx_cfg460_s cn68xxp1;
-	struct cvmx_pciercx_cfg460_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg461 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg461_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_20_31:12;
-		uint32_t tchfcc:8;
-		uint32_t tcdfcc:12;
-#else
-		uint32_t tcdfcc:12;
-		uint32_t tchfcc:8;
-		uint32_t reserved_20_31:12;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg461_s cn52xx;
-	struct cvmx_pciercx_cfg461_s cn52xxp1;
-	struct cvmx_pciercx_cfg461_s cn56xx;
-	struct cvmx_pciercx_cfg461_s cn56xxp1;
-	struct cvmx_pciercx_cfg461_s cn61xx;
-	struct cvmx_pciercx_cfg461_s cn63xx;
-	struct cvmx_pciercx_cfg461_s cn63xxp1;
-	struct cvmx_pciercx_cfg461_s cn66xx;
-	struct cvmx_pciercx_cfg461_s cn68xx;
-	struct cvmx_pciercx_cfg461_s cn68xxp1;
-	struct cvmx_pciercx_cfg461_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg462 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg462_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_20_31:12;
-		uint32_t tchfcc:8;
-		uint32_t tcdfcc:12;
-#else
-		uint32_t tcdfcc:12;
-		uint32_t tchfcc:8;
-		uint32_t reserved_20_31:12;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg462_s cn52xx;
-	struct cvmx_pciercx_cfg462_s cn52xxp1;
-	struct cvmx_pciercx_cfg462_s cn56xx;
-	struct cvmx_pciercx_cfg462_s cn56xxp1;
-	struct cvmx_pciercx_cfg462_s cn61xx;
-	struct cvmx_pciercx_cfg462_s cn63xx;
-	struct cvmx_pciercx_cfg462_s cn63xxp1;
-	struct cvmx_pciercx_cfg462_s cn66xx;
-	struct cvmx_pciercx_cfg462_s cn68xx;
-	struct cvmx_pciercx_cfg462_s cn68xxp1;
-	struct cvmx_pciercx_cfg462_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg463 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg463_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_3_31:29;
-		uint32_t rqne:1;
-		uint32_t trbne:1;
-		uint32_t rtlpfccnr:1;
-#else
-		uint32_t rtlpfccnr:1;
-		uint32_t trbne:1;
-		uint32_t rqne:1;
-		uint32_t reserved_3_31:29;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg463_s cn52xx;
-	struct cvmx_pciercx_cfg463_s cn52xxp1;
-	struct cvmx_pciercx_cfg463_s cn56xx;
-	struct cvmx_pciercx_cfg463_s cn56xxp1;
-	struct cvmx_pciercx_cfg463_s cn61xx;
-	struct cvmx_pciercx_cfg463_s cn63xx;
-	struct cvmx_pciercx_cfg463_s cn63xxp1;
-	struct cvmx_pciercx_cfg463_s cn66xx;
-	struct cvmx_pciercx_cfg463_s cn68xx;
-	struct cvmx_pciercx_cfg463_s cn68xxp1;
-	struct cvmx_pciercx_cfg463_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg464 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg464_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t wrr_vc3:8;
-		uint32_t wrr_vc2:8;
-		uint32_t wrr_vc1:8;
-		uint32_t wrr_vc0:8;
-#else
-		uint32_t wrr_vc0:8;
-		uint32_t wrr_vc1:8;
-		uint32_t wrr_vc2:8;
-		uint32_t wrr_vc3:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg464_s cn52xx;
-	struct cvmx_pciercx_cfg464_s cn52xxp1;
-	struct cvmx_pciercx_cfg464_s cn56xx;
-	struct cvmx_pciercx_cfg464_s cn56xxp1;
-	struct cvmx_pciercx_cfg464_s cn61xx;
-	struct cvmx_pciercx_cfg464_s cn63xx;
-	struct cvmx_pciercx_cfg464_s cn63xxp1;
-	struct cvmx_pciercx_cfg464_s cn66xx;
-	struct cvmx_pciercx_cfg464_s cn68xx;
-	struct cvmx_pciercx_cfg464_s cn68xxp1;
-	struct cvmx_pciercx_cfg464_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg465 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg465_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t wrr_vc7:8;
-		uint32_t wrr_vc6:8;
-		uint32_t wrr_vc5:8;
-		uint32_t wrr_vc4:8;
-#else
-		uint32_t wrr_vc4:8;
-		uint32_t wrr_vc5:8;
-		uint32_t wrr_vc6:8;
-		uint32_t wrr_vc7:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg465_s cn52xx;
-	struct cvmx_pciercx_cfg465_s cn52xxp1;
-	struct cvmx_pciercx_cfg465_s cn56xx;
-	struct cvmx_pciercx_cfg465_s cn56xxp1;
-	struct cvmx_pciercx_cfg465_s cn61xx;
-	struct cvmx_pciercx_cfg465_s cn63xx;
-	struct cvmx_pciercx_cfg465_s cn63xxp1;
-	struct cvmx_pciercx_cfg465_s cn66xx;
-	struct cvmx_pciercx_cfg465_s cn68xx;
-	struct cvmx_pciercx_cfg465_s cn68xxp1;
-	struct cvmx_pciercx_cfg465_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg466 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg466_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t rx_queue_order:1;
-		uint32_t type_ordering:1;
-		uint32_t reserved_24_29:6;
-		uint32_t queue_mode:3;
-		uint32_t reserved_20_20:1;
-		uint32_t header_credits:8;
-		uint32_t data_credits:12;
-#else
-		uint32_t data_credits:12;
-		uint32_t header_credits:8;
-		uint32_t reserved_20_20:1;
-		uint32_t queue_mode:3;
-		uint32_t reserved_24_29:6;
-		uint32_t type_ordering:1;
-		uint32_t rx_queue_order:1;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg466_s cn52xx;
-	struct cvmx_pciercx_cfg466_s cn52xxp1;
-	struct cvmx_pciercx_cfg466_s cn56xx;
-	struct cvmx_pciercx_cfg466_s cn56xxp1;
-	struct cvmx_pciercx_cfg466_s cn61xx;
-	struct cvmx_pciercx_cfg466_s cn63xx;
-	struct cvmx_pciercx_cfg466_s cn63xxp1;
-	struct cvmx_pciercx_cfg466_s cn66xx;
-	struct cvmx_pciercx_cfg466_s cn68xx;
-	struct cvmx_pciercx_cfg466_s cn68xxp1;
-	struct cvmx_pciercx_cfg466_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg467 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg467_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_24_31:8;
-		uint32_t queue_mode:3;
-		uint32_t reserved_20_20:1;
-		uint32_t header_credits:8;
-		uint32_t data_credits:12;
-#else
-		uint32_t data_credits:12;
-		uint32_t header_credits:8;
-		uint32_t reserved_20_20:1;
-		uint32_t queue_mode:3;
-		uint32_t reserved_24_31:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg467_s cn52xx;
-	struct cvmx_pciercx_cfg467_s cn52xxp1;
-	struct cvmx_pciercx_cfg467_s cn56xx;
-	struct cvmx_pciercx_cfg467_s cn56xxp1;
-	struct cvmx_pciercx_cfg467_s cn61xx;
-	struct cvmx_pciercx_cfg467_s cn63xx;
-	struct cvmx_pciercx_cfg467_s cn63xxp1;
-	struct cvmx_pciercx_cfg467_s cn66xx;
-	struct cvmx_pciercx_cfg467_s cn68xx;
-	struct cvmx_pciercx_cfg467_s cn68xxp1;
-	struct cvmx_pciercx_cfg467_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg468 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg468_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_24_31:8;
-		uint32_t queue_mode:3;
-		uint32_t reserved_20_20:1;
-		uint32_t header_credits:8;
-		uint32_t data_credits:12;
-#else
-		uint32_t data_credits:12;
-		uint32_t header_credits:8;
-		uint32_t reserved_20_20:1;
-		uint32_t queue_mode:3;
-		uint32_t reserved_24_31:8;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg468_s cn52xx;
-	struct cvmx_pciercx_cfg468_s cn52xxp1;
-	struct cvmx_pciercx_cfg468_s cn56xx;
-	struct cvmx_pciercx_cfg468_s cn56xxp1;
-	struct cvmx_pciercx_cfg468_s cn61xx;
-	struct cvmx_pciercx_cfg468_s cn63xx;
-	struct cvmx_pciercx_cfg468_s cn63xxp1;
-	struct cvmx_pciercx_cfg468_s cn66xx;
-	struct cvmx_pciercx_cfg468_s cn68xx;
-	struct cvmx_pciercx_cfg468_s cn68xxp1;
-	struct cvmx_pciercx_cfg468_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg490 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg490_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_26_31:6;
-		uint32_t header_depth:10;
-		uint32_t reserved_14_15:2;
-		uint32_t data_depth:14;
-#else
-		uint32_t data_depth:14;
-		uint32_t reserved_14_15:2;
-		uint32_t header_depth:10;
-		uint32_t reserved_26_31:6;
-#endif
+		__BITFIELD_FIELD(uint32_t m_cfg0_filt:1,
+		__BITFIELD_FIELD(uint32_t m_io_filt:1,
+		__BITFIELD_FIELD(uint32_t msg_ctrl:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_ecrc_filt:1,
+		__BITFIELD_FIELD(uint32_t m_ecrc_filt:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_len_err:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_attr_err:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_tc_err:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_fun_err:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_rid_err:1,
+		__BITFIELD_FIELD(uint32_t m_cpl_tag_err:1,
+		__BITFIELD_FIELD(uint32_t m_lk_filt:1,
+		__BITFIELD_FIELD(uint32_t m_cfg1_filt:1,
+		__BITFIELD_FIELD(uint32_t m_bar_match:1,
+		__BITFIELD_FIELD(uint32_t m_pois_filt:1,
+		__BITFIELD_FIELD(uint32_t m_fun:1,
+		__BITFIELD_FIELD(uint32_t dfcwt:1,
+		__BITFIELD_FIELD(uint32_t reserved_11_14:4,
+		__BITFIELD_FIELD(uint32_t skpiv:11,
+		;)))))))))))))))))))
 	} s;
-	struct cvmx_pciercx_cfg490_s cn52xx;
-	struct cvmx_pciercx_cfg490_s cn52xxp1;
-	struct cvmx_pciercx_cfg490_s cn56xx;
-	struct cvmx_pciercx_cfg490_s cn56xxp1;
-	struct cvmx_pciercx_cfg490_s cn61xx;
-	struct cvmx_pciercx_cfg490_s cn63xx;
-	struct cvmx_pciercx_cfg490_s cn63xxp1;
-	struct cvmx_pciercx_cfg490_s cn66xx;
-	struct cvmx_pciercx_cfg490_s cn68xx;
-	struct cvmx_pciercx_cfg490_s cn68xxp1;
-	struct cvmx_pciercx_cfg490_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg491 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg491_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_26_31:6;
-		uint32_t header_depth:10;
-		uint32_t reserved_14_15:2;
-		uint32_t data_depth:14;
-#else
-		uint32_t data_depth:14;
-		uint32_t reserved_14_15:2;
-		uint32_t header_depth:10;
-		uint32_t reserved_26_31:6;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg491_s cn52xx;
-	struct cvmx_pciercx_cfg491_s cn52xxp1;
-	struct cvmx_pciercx_cfg491_s cn56xx;
-	struct cvmx_pciercx_cfg491_s cn56xxp1;
-	struct cvmx_pciercx_cfg491_s cn61xx;
-	struct cvmx_pciercx_cfg491_s cn63xx;
-	struct cvmx_pciercx_cfg491_s cn63xxp1;
-	struct cvmx_pciercx_cfg491_s cn66xx;
-	struct cvmx_pciercx_cfg491_s cn68xx;
-	struct cvmx_pciercx_cfg491_s cn68xxp1;
-	struct cvmx_pciercx_cfg491_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg492 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg492_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_26_31:6;
-		uint32_t header_depth:10;
-		uint32_t reserved_14_15:2;
-		uint32_t data_depth:14;
-#else
-		uint32_t data_depth:14;
-		uint32_t reserved_14_15:2;
-		uint32_t header_depth:10;
-		uint32_t reserved_26_31:6;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg492_s cn52xx;
-	struct cvmx_pciercx_cfg492_s cn52xxp1;
-	struct cvmx_pciercx_cfg492_s cn56xx;
-	struct cvmx_pciercx_cfg492_s cn56xxp1;
-	struct cvmx_pciercx_cfg492_s cn61xx;
-	struct cvmx_pciercx_cfg492_s cn63xx;
-	struct cvmx_pciercx_cfg492_s cn63xxp1;
-	struct cvmx_pciercx_cfg492_s cn66xx;
-	struct cvmx_pciercx_cfg492_s cn68xx;
-	struct cvmx_pciercx_cfg492_s cn68xxp1;
-	struct cvmx_pciercx_cfg492_s cnf71xx;
 };
 
 union cvmx_pciercx_cfg515 {
 	uint32_t u32;
 	struct cvmx_pciercx_cfg515_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t reserved_21_31:11;
-		uint32_t s_d_e:1;
-		uint32_t ctcrb:1;
-		uint32_t cpyts:1;
-		uint32_t dsc:1;
-		uint32_t le:9;
-		uint32_t n_fts:8;
-#else
-		uint32_t n_fts:8;
-		uint32_t le:9;
-		uint32_t dsc:1;
-		uint32_t cpyts:1;
-		uint32_t ctcrb:1;
-		uint32_t s_d_e:1;
-		uint32_t reserved_21_31:11;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg515_s cn61xx;
-	struct cvmx_pciercx_cfg515_s cn63xx;
-	struct cvmx_pciercx_cfg515_s cn63xxp1;
-	struct cvmx_pciercx_cfg515_s cn66xx;
-	struct cvmx_pciercx_cfg515_s cn68xx;
-	struct cvmx_pciercx_cfg515_s cn68xxp1;
-	struct cvmx_pciercx_cfg515_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg516 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg516_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t phy_stat:32;
-#else
-		uint32_t phy_stat:32;
-#endif
-	} s;
-	struct cvmx_pciercx_cfg516_s cn52xx;
-	struct cvmx_pciercx_cfg516_s cn52xxp1;
-	struct cvmx_pciercx_cfg516_s cn56xx;
-	struct cvmx_pciercx_cfg516_s cn56xxp1;
-	struct cvmx_pciercx_cfg516_s cn61xx;
-	struct cvmx_pciercx_cfg516_s cn63xx;
-	struct cvmx_pciercx_cfg516_s cn63xxp1;
-	struct cvmx_pciercx_cfg516_s cn66xx;
-	struct cvmx_pciercx_cfg516_s cn68xx;
-	struct cvmx_pciercx_cfg516_s cn68xxp1;
-	struct cvmx_pciercx_cfg516_s cnf71xx;
-};
-
-union cvmx_pciercx_cfg517 {
-	uint32_t u32;
-	struct cvmx_pciercx_cfg517_s {
-#ifdef __BIG_ENDIAN_BITFIELD
-		uint32_t phy_ctrl:32;
-#else
-		uint32_t phy_ctrl:32;
-#endif
+		__BITFIELD_FIELD(uint32_t reserved_21_31:11,
+		__BITFIELD_FIELD(uint32_t s_d_e:1,
+		__BITFIELD_FIELD(uint32_t ctcrb:1,
+		__BITFIELD_FIELD(uint32_t cpyts:1,
+		__BITFIELD_FIELD(uint32_t dsc:1,
+		__BITFIELD_FIELD(uint32_t le:9,
+		__BITFIELD_FIELD(uint32_t n_fts:8,
+		;)))))))
 	} s;
-	struct cvmx_pciercx_cfg517_s cn52xx;
-	struct cvmx_pciercx_cfg517_s cn52xxp1;
-	struct cvmx_pciercx_cfg517_s cn56xx;
-	struct cvmx_pciercx_cfg517_s cn56xxp1;
-	struct cvmx_pciercx_cfg517_s cn61xx;
-	struct cvmx_pciercx_cfg517_s cn63xx;
-	struct cvmx_pciercx_cfg517_s cn63xxp1;
-	struct cvmx_pciercx_cfg517_s cn66xx;
-	struct cvmx_pciercx_cfg517_s cn68xx;
-	struct cvmx_pciercx_cfg517_s cn68xxp1;
-	struct cvmx_pciercx_cfg517_s cnf71xx;
 };
 
 #endif
-- 
1.9.1
