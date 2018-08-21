Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 21:13:33 +0200 (CEST)
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:65145
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992289AbeHUTN2WhK3S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Aug 2018 21:13:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOHfSxuqQ5OvNIbwoX7D9/z13WKGCcTNzTMyWsMesN8=;
 b=CqIsNsb4lTTf2ECAIAIJKPLItQDskcMaJLx6y0TsuIION3YpT8Gswep5l3EETZsz0Y/Chs+/u9Bk2yoMDbJi2lnH9eSMJ9GAJERb0Sk/916HkBcbVvMvqKglbfDK7mY9f0qPLDnsUkAL8N8IWC9DjkA0MD9UGI4WUY9+AHf1PFY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4937.namprd08.prod.outlook.com (2603:10b6:5:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Tue, 21 Aug 2018 19:13:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, stable@vger.kernel.org
Subject: [PATCH] MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7
Date:   Tue, 21 Aug 2018 12:12:59 -0700
Message-Id: <20180821191259.18156-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:3:c0::14) To DM6PR08MB4937.namprd08.prod.outlook.com
 (2603:10b6:5:4b::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5f3c86a-95b5-4cd9-115d-08d6079a26c2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;3:GphyDCYwXGOtroUjOQgyTwC+oBi1IMvCD64LozV3XRAEmVOZbOctdiafX3B8G2Eh3nLK7ufvirXzLQot1Igs2Q/kH/o9VBMkQWnTBD2xGOdvTd6XGYi2OuIE2fq0yKPc6Hxr6DGgLAcdm1qsvtgA024LL5gdNiDoFezrsoPpcovLPYukSQgKr+9eThjc952EmBY5Tf85owwwNthGOj0GIZk6BmZ4nRwqv0zr4qj7gJMQ/HKI9N4Aoh6QvTax4ow0;25:hMyKaqa+oxvQoIO7WT+0ZpsXHTGhH4zbbehWiMUHYZZM1tNnX0XyehM32ikJINYwEZ/j+tLnMHyuDjvkHKLYdR+lo2yP4AbSFppqJEC7ewFpUbQ3Xgv9Ctv5gAylvyo1QA8tkxuqy+yZTOnaOlqbvAh6e8720Zhgd+yYMmxg33CEuctcQXe3RcNU+uC4O4WMG/QXqngQrrbdzVDm6C9lN8APFXGjVEsfaLoe8QF6+Bi4XXRS89DCrc4LeADj0RWGwSYzb/R1ep1GE0KfpKM107l95aQAYhQsSm0TJ659B48kroRDuTxO9pq4Z9/5XAA1ubT01jPrZRtOzU9AsaBMDg==;31:LC16/3YnI+1MQmTkGSvmZ1mJRyt9S8ZWIhGOzO/AKyU9pXF2SUV3AUaAj4oA8eLji3Pu+65DOPXF0vzc9DiokieC5Goui0RQHJk/egoGsmkJ4y6IpmAedUn9Xy7Tw7AiWnEfRawLG9VK2ZYp3BXSMn3J+lR2GXKnlZjUUWDdBMHKfIOJ6M4MiBK+RteKRaH6QA7GGJpyx6MqAbZOmDI1a/8lTEzsynneTFzIGd+Qjds=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;20:rqgyenYkt4KppC95nC7WRg7V0S21tpfqXETfCO2YcFEsCPzXz3RU4eNQ557NRA/ZLC6IA1zoxEgVdLavThxTbvKT80KvvvJFBLEMjWqXF8UIDUmE7vg5rNDLy5jvGDkeZ/4X28UC85SMCNveV4QHKoaz/IbGzMZkt2USEbfJ/1k+UhEV7oKG2DO0MyvAMycHVgx1XkOAK4GSvggM/dh+jcNufydAipiQ+QQblxjebAgnC0XromOa9PyOoMnhZqQL;4:4k53vqaa1drZby6CFKs6kPuUmeQfoj6JaRHfOmdETiCjwR++uRWpmMBulMXabkRxH8pvbkaPezR4gYpl/fRQnkUFQTVDe1q5q17dFMMUwv+APteoHzNCcseiJuP/lvO6qpAGRU0EOQHn4ZS0fNDv10jI9XZV5+GQ/yqNeaf/7wxL2vLMx45NdYD2mxIm/Iy2oZGPXDbOSIYmqyr2SNFS4oK3RVoxFUUxFlYdmUvXr1WvR8nNcL8QsjkAwx6jj8wKkVvb3ShjOXuAshFZuYZe6VW5vgKkkwPYu1q9+SEZFAkO7M34r06Qh46iWXuv1m2i5qReSh/+kxf+ytz6liohv2WIY5mdt9gl+4FN/LB8nVw9L4NiAZI8ArCrN77zRU6OtxMMunIVY1GLBjlo6AGL1P4pX8jaRBP/qOdan4k+t1o=
X-Microsoft-Antispam-PRVS: <DM6PR08MB4937470744611C9DACEE4C7BC1310@DM6PR08MB4937.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(9452136761055)(183786458502308)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DM6PR08MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4937;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(346002)(366004)(136003)(396003)(199004)(189003)(26005)(3846002)(186003)(16526019)(4326008)(6512007)(53936002)(956004)(1857600001)(8936002)(68736007)(6306002)(53416004)(6916009)(1076002)(6116002)(25786009)(97736004)(2616005)(476003)(54906003)(6666003)(486006)(42882007)(316002)(6506007)(478600001)(2361001)(386003)(16586007)(48376002)(50226002)(2906002)(966005)(66066001)(575784001)(52116002)(50466002)(69596002)(8676002)(81156014)(51416003)(6486002)(81166006)(47776003)(105586002)(44832011)(2351001)(36756003)(305945005)(7736002)(5660300001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4937;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4937;23:F7pD96KOBB4hTOY1WbOHGOj5RawRBsw7GLzoATJzv?=
 =?us-ascii?Q?gb6IdDRVT1k34Vav8/JWfGEBaPlWQKOMkIJNbShlaOnVFQWIigq6xPwQgAlx?=
 =?us-ascii?Q?Nh2F7RF6jcv5pEFjxO0utigip13WIFLNJbUW0r2e6VG8HTv1+fHhQKIOZ5RV?=
 =?us-ascii?Q?b3NfYw9aoaLTPT/E9TKI5OBNZOP73NQdZ3BgrdzJEZjPovY9rwnNfbSaJDq/?=
 =?us-ascii?Q?HqxXxvniEaseTNRVIuooKL1F0l7hn2zo1KiNPEu/Ay8IcblIkmK5RCyNPiTS?=
 =?us-ascii?Q?SMxy60eL6wIYnjaXzEZY/ezZAy18/y3ba47Tf8/6tqB6pdfJPJCe00j9t03O?=
 =?us-ascii?Q?LrbJGu+8dzI36Hvoprk5Uril/ixRozai7ntEvVBky5jR6lXmNEbVHiXq35T2?=
 =?us-ascii?Q?I7OQPS21GM90yl65nf99e1ykcmYos27FqhgvQKbioJKpDa6o+6lq8g+uJZdH?=
 =?us-ascii?Q?QbJU+iQQ+ZlO1xsb7z9lUCOWSZ6475B9HegsVgP1hI2hwiJ+7vI/HJVmY5SN?=
 =?us-ascii?Q?0Ytuag66H3Ppmw1A0L6zDTy+gy6ZMc6CvItlYzCwyIlD11xPQrkUvqB1Lzp1?=
 =?us-ascii?Q?Bc7hALxTt4Ttu6h+51qPhj0it4kZvyh7WYQzq5BkJBo3r43fhd1UeTOwqDQA?=
 =?us-ascii?Q?f1GFUqg7ybrBzTpO0cCkbsdZ56M6ebFJ1rOk0CIskdVvnqH+1t8/37PuGJ3H?=
 =?us-ascii?Q?pKWIPcwhboYHbthwe/igHphtfK9acJyv0IXQDMTitWXVRNPGJ3uT4M6YiFMy?=
 =?us-ascii?Q?3Y1ZsH6YTWBvfMQ/48BRWs1q+/UVzWxLa4iN4YPUIcTEDql/CTxyYvTxJNu2?=
 =?us-ascii?Q?/EEeuenymqHAKMdvgtR00sytE38V/lb4HrgSII/d8MMaXkstTgL+uKWml40g?=
 =?us-ascii?Q?gZEq8YcbqL7z3Yr9CJPpKsI7iQ+G9D28r+vdUmqxdTuhvowwNKs9TlkMGYh+?=
 =?us-ascii?Q?Fsl/YYKOHAGuWJa6oP+A27iI+xlKSnIYsjioIes8u+aovcd9fR0uJRW95/Yf?=
 =?us-ascii?Q?7QCdy/cVA7yDm5V4WLfi0Il0Io6GXfrzf5eYWIyk9S7H9ICnjZDYd+yLuTmP?=
 =?us-ascii?Q?1T957nSc7SvfGz9vF8pWM2dXo9F+l4+sq32aRxEiUI61yvty7N1d7WSyVERA?=
 =?us-ascii?Q?6Es2Cpdu9ffuxvBZhVB63uO+NlbUVai9DPQ2LcYgFUMtzdT1u54nA4UdSLa9?=
 =?us-ascii?Q?zJLVSwdotOPxbVDnXIfEDe6Ktic4E68lWKRiXwQsAJi4T/HO0OkpXdXRmkXg?=
 =?us-ascii?Q?ivncy0zQRO5KTSAAUey/DCBijLt9sSIhbPpDWhPNigDN8hCZ2k5/lIH0VcQ2?=
 =?us-ascii?Q?yzG7J+aGNf0zc89+Qchzxgp+XyhLOvpXElaGqJp8xmZ?=
X-Microsoft-Antispam-Message-Info: kh4OngCEHdcnFK5TvCrWONAIVdN2moV6xQhzPTnwi6DMlsxYvpwmkRjGzBebZ2rCIM76nZZQ2gVAeGKKGUrz4vCs3vUXvNC/t+bicR0oMulddUl/iJh0lXt2b5qFaddQF/n+MQ6UVTjsoN7O+4zpxYuP4dPWK/aA9mNONiBftSHgdOOD1TSSGyORomba91ppaiyI0PUhx9AUK+u72BgiEREFzgb+Zus26rEoHoGnWXwW0XInn2vqeSa34I7V9OHXuE2lMd2Yk8OBbR5MoOouo2CrhpXdG1lu4IvAMZaCWRFR/KSXDunS8llGqaNdCCUX8vJd+fFQIS51/1cD9YO7dvX4EJQPbwFA8rat+YSABMc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;6:X4N9ipquyOxKUQLCyHSkPxMXAtlqOHtM3tVk8ggbifUxgGn9xNTGuiPjCZgOpy0EmpRlEdmV6XUKwJF+53/kctrZ6FzqhJv95kJNhZcw/4NVYzzek4Ua2Bn55ahWBVLwNJ2T5HS+h7mOdWPrrVWkhE2Mq3HwPXorzAQLegPt0jSF1YgSdPdoWhpO49/GS9XVwQacn8iQQGs/YvhjoK3j1CtH/LJ8pIWo91hR9v+eYSMGRmNwAEfXKA7VpIR9KPFHkVSYNGq7RjVKUcYV24n2gHpQ06Gzo9+qmGmPFboygSQAdS4Q5oYqls1svOFcz15ip9MwjJUlmuoKVjzeeBz3Iwqj2yknTTeU1MYl9hf8E9te+oHYeBH5qsPer1dzK011S3rOg1BTWHC4zFfrsLBC4Pzn4bzGH0RpuJ4aTjPSRNf0yYl/nMDMJpUlcN3cQBKHorB1Pl9eY3uSg130ImRkTg==;5:BBQFYcIICKngy++ZUSlSCq/Oy8XBz0gNa4DzKXhY38yQG8xxODLIvY5dsn8gxTnSsJhED1rqcDBXXRgljiiC3JzCL7SFs3uy41/LiveEzoHlHjj1TUheMwoGCaMme/LPI7KlAPMLubO7ozJ5xc7bVACfnz8Y/XD9EUG2q6W6sFo=;7:ZG9DYfRiu/qIFKYkyJKVW3L8o1LfntqgVyFupBIRMOtu199L29Ga0kfRb2aXvXtKIrVeyHjP6qonmxiuMbU3hNn1aI41Y3jGrvL6mZkkyaCesMh73JN4IMSDYwQRGXg9pPCzGcTlsRPin7AgW3PVep9uR1HDtah2hBAGWtw9fjrH7uDlkTOTI0NeIqwkM3d3Qn75Z6EajCnMLaa9Mn7hklICEyp18emHS3HyTwVDgz9tUe+dtMxSA/1f9awEVNGq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 19:13:17.2676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f3c86a-95b5-4cd9-115d-08d6079a26c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4937
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Some versions of GCC suboptimally generate calls to the __multi3()
intrinsic for MIPS64r6 builds, resulting in link failures due to the
missing function:

    LD      vmlinux.o
    MODPOST vmlinux.o
  kernel/bpf/verifier.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  fs/select.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  ...

We already have a workaround for this in which we provide the
instrinsic, but we do so selectively for GCC 7 only. Unfortunately the
issue occurs with older GCC versions too - it has been observed with
both GCC 5.4.0 & GCC 6.4.0.

MIPSr6 support was introduced in GCC 5, so all major GCC versions prior
to GCC 8 are affected and we extend our workaround accordingly to all
MIPS64r6 builds using GCC versions older than GCC 8.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Fixes: ebabcf17bcd7 ("MIPS: Implement __multi3 for GCC7 MIPS64r6 builds")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.15+
---

 arch/mips/lib/multi3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lib/multi3.c b/arch/mips/lib/multi3.c
index 111ad475aa0c..4c2483f410c2 100644
--- a/arch/mips/lib/multi3.c
+++ b/arch/mips/lib/multi3.c
@@ -4,12 +4,12 @@
 #include "libgcc.h"
 
 /*
- * GCC 7 suboptimally generates __multi3 calls for mips64r6, so for that
- * specific case only we'll implement it here.
+ * GCC 7 & older can suboptimally generate __multi3 calls for mips64r6, so for
+ * that specific case only we implement that intrinsic here.
  *
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
  */
-#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ == 7)
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ < 8)
 
 /* multiply 64-bit values, low 64-bits returned */
 static inline long long notrace dmulu(long long a, long long b)
-- 
2.18.0
