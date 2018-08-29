Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 23:54:37 +0200 (CEST)
Received: from mail-by2nam01on0093.outbound.protection.outlook.com ([104.47.34.93]:17536
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993945AbeH2VyYetIhp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Aug 2018 23:54:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awE9/bk3TWNCEIunk7zRHAOcf7g5ebYLDWu37XNxl7I=;
 b=Seb1FXIsJQbdbMGX1JaHApUrfz/8LLrtPmXquI6mpqqQIOG/LX/lURfTKtYQciO4Yxc0l+Ww8csdkyNvC+i8YnHl0uImj8p+1zjMLD8ZhY6pADlkHa/FVTGU+d65fwwCrwIIOR9HdeHCv2OAT67u2Trs+IRMCSqZucRI34DQctA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4937.namprd08.prod.outlook.com (2603:10b6:5:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 21:54:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>
Subject: [PATCH 2/2] MIPS: Remove SLOW_DOWN_IO
Date:   Wed, 29 Aug 2018 14:54:01 -0700
Message-Id: <20180829215401.874-2-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829215401.874-1-paul.burton@mips.com>
References: <20180829215401.874-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:3:37::30) To DM6PR08MB4937.namprd08.prod.outlook.com
 (2603:10b6:5:4b::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98de5a83-4706-46d6-fe4f-08d60df9f5a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;3:cBOhl17wfUV/vPGhprYrTQUSq1Db3O4N+AxF+9UsGoihe/X3ma1os4LC9J/ANN7Znyvagdw8s23zo14CY/k/PZf2ILOHQHBVKBFJwgPoU85AiLCJ8/c62M+kH3Z2aVd/85XgNzK+6gjdmVESMLGctZprt4e5vetVxnvAz4NKeLqIU28GAo9FmEVtMyxklwPU7oTCEHU0IJTdC9sC06A51378NwptKvZ4BlKhD8P6idgepH66JBWvTbbVlBDuJLUk;25:t8lbJdJERfGdRORHsF1P+JDVIDLRsWzhxB7D/0V7GutxCmG0/0mdn0nCmSgS+PcMBxGxsmTg4YjNFNkIpqkLhO+uGCKSNIphnVYcc0qfOtVBDAVJLNxcWpRNaIMcIvfcyMKPw8RJHndK8j2aX7Cb2wd6hj0S2CDmAW7WJiL0MzkYDViboX2uHUITuydoqz4QQZPlqaixmvCSVH+GRvz2Qr7EZO+Tyfnlbw+IlGf3Qq+TJShtKzdRmcCXplWASkVM9SAvhptIdnGNZ5IJeNE+HqDOobWlUzixS3dWoujrUPuZCAJdYElFX2xIS4pStN7xO54nYjw/hxnJmuQun4b6Ng==;31:ZASc2yveIC6Atp2NN3xq2us06bRZ0ylRWNsYzmBjs3MACX6pgTN/Ve8rmfYJpne14slsjVEn1q3tFShKxh0AAVlXFUlJuJ4pP7PLi6IkUEwkvShinfy/nWs5J9pASHzj7UCH0O3VvLXUC2TnBjT2M30J739LXxGijQrZLIt1owcJGcndf2fkYOUnKD9aAoH3qWzjEO6gJc0SlBadgg8lbWUYecxU1eyP3BZsEykQxy0=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;20:kjYEGEebZZFjf5nr8AgdQVeqqiqX0svLhAnYKG5rD23G6KndnNpxuMQwU+6/6PaWYg8qfkjFgbqH/PmuHxUhTHwkjIPIovP2A4uW5K+0tV8g+LDNxYAzIxyDN+ibIjfCw076O0f2EyE0gJPBGCAIZV3U5OYq8bNV/jVXnsjwAxl/vT+1xon4q6PFs8ZeaUyWKevHfHlPwlB6Wgjg2Cn281n80w6ixHG01quAFJ836YUX/wCPFWBsFVOfBjNyLWoJ;4:e5BU6jEYoDnIrYtVwRR5OfO7+uQePMoseIejIdxgkeuErYQ6dCroFV8XPRthMWcAGLTHuqRfOu1U2UmkO24476A0OmU6MxFLlP2SampjUOzRUEE1//XCPSIZTfBD3JxWGNY+vwcNdk3aXzpfHFNr8xyRehCSCG4ij7t9ETGvJVtgnvwb/WHZmXwGuZBINLC2dNyqajmltXmUMt6HeJCT6cWVywDMSzLYUJGR4tHMyahTPsZZj1+6lPYT9ezq9jersNHToqHTUTIP+c0OcxDB8A==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4937703FE8512E366E72DC35C1090@DM6PR08MB4937.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR08MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4937;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39850400004)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(66066001)(186003)(575784001)(6506007)(386003)(2351001)(53936002)(6116002)(69596002)(50466002)(48376002)(50226002)(8936002)(3846002)(47776003)(1076002)(476003)(486006)(26005)(2616005)(956004)(16586007)(53416004)(316002)(76176011)(11346002)(446003)(478600001)(106356001)(105586002)(16526019)(4326008)(42882007)(52116002)(107886003)(25786009)(14444005)(5660300001)(305945005)(81156014)(6666003)(8676002)(81166006)(6916009)(51416003)(7736002)(2906002)(36756003)(2361001)(68736007)(6486002)(44832011)(97736004)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4937;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4937;23:f6OmNnNUpCThL3vzKRzHnaaRCBcSsAeVYdiQhM7Ot?=
 =?us-ascii?Q?GTVz181HYuvxKz003w6gnHLPPRysXvaF5V6pAOz83yVIrMDGRoa5J38AdEdQ?=
 =?us-ascii?Q?X8dnl6KDJ/viGEK6K1xNSRLo12zCsLANj6RULpDK2LlP3EjCZ8uvGG60FAEA?=
 =?us-ascii?Q?k7Zgk60nQb4RNLHbzXVmTs8bpYi3A0scmSgfDR1KxJczHXGZLn7iOjh5clMy?=
 =?us-ascii?Q?m6EueKp39oGAfkDzj/o9NM/Su7/GeenJkw0QlDzZrkLn+bKPV50Wd1Sv/L0I?=
 =?us-ascii?Q?TK7vmgBG+tMt9MwSkQ60PHqq9kBECCRFlvVeaEq+TXu+FUa5GpJeKHAC8ldM?=
 =?us-ascii?Q?FTNBMiRyNHJ/61i9ws2uxc+xBdjXbKH5542YO+e34UxLwFIUGlawJXVY9KJq?=
 =?us-ascii?Q?YoHuSG+dDPkBQxYY/Zv/yG6ieNMlTaUZqsVxQ0ECcFa/dhAKUr2cN0pF56w7?=
 =?us-ascii?Q?Ipi49TvycTokJBg/np+nIJmisIE/GZEbsfMOqGZXChlxozuu4jDjJgaCzXMk?=
 =?us-ascii?Q?An8qgtAX4CjP1yfo6pKHJqyY2W4kBENbkge4UOpV18OVafjaKKH3xZMRN916?=
 =?us-ascii?Q?fX0ftMeUMQD36yzkiCzFJxRJvthpTYbBoEJnDAHlxsCwcxxglmgx5uki+PBP?=
 =?us-ascii?Q?544J7eOgJKu7tGGxbrgcFRZd3Pjj0YZmVy7GEZitFM20ovViKy4xXMIMnzxD?=
 =?us-ascii?Q?BZijU/LfEmX1XzjO8v/eyakGkjsT2Rz7Ymfzc/x0dNFggLv2wnaiOunWxeaK?=
 =?us-ascii?Q?KOV+2oineXXlGGYs9zgWqb438R7mHOqTyGtvwdM/IvPYwdUWH7IltWlO9vnf?=
 =?us-ascii?Q?gSer97y/CbJrRyNDG0YtZx5rhaPM/e+a1JPIFMb4G2TZZhGaTHZPLhDL2z1f?=
 =?us-ascii?Q?u4/JzoXKWMgD4zEwljZgEKK0gcaqyBGB/g3eCjWy0/FE+F84HLzAm6YEG51U?=
 =?us-ascii?Q?bTsQYxFjDo6dIzxevmrjpKDYntiLsw6o7bpOP0ZsGtH4deOETCtqbHgQ4L5g?=
 =?us-ascii?Q?P1+I2IjW1qCrwRQW/QN5JMHXJPOaDYdZJnWUd+LDRFySqHETVCD1upISFHW9?=
 =?us-ascii?Q?Xof64Y1XACmVeIcOA45e2ksOCvKKndj7Xq02Mrs6dYsncvUQxOn5xRUeI9yz?=
 =?us-ascii?Q?iwuYbVLqg1XDYbJse4/LXwWsl6sos14/6EEqWjVprKgU0ym+CHO+nSPiWvJv?=
 =?us-ascii?Q?CBCiv3gF5+TY6KblxZVX+GhmVDlC3XUygu6vkvEXZISJzT5BYTY0RFZhI//u?=
 =?us-ascii?Q?YDOFHgTlQ+PxgABP6Vzx+qz1mvPHCzvvtZLcGOY06kHPmkXnqUWo62bysr95?=
 =?us-ascii?Q?PLvMxRqGy7HJ2tWY0A73G2x8fDgwIp7+FfaC9rardaT1/1cD/qgLZZSzYNlA?=
 =?us-ascii?Q?G5f7cvDcQ5afeeBlyZ99Jcuov/i9CriVCOkTwfKmGyh4LlDBVRGATmbfydeD?=
 =?us-ascii?Q?NxEVq/gRVawMK2jO0O/0Cug6q64qD4=3D?=
X-Microsoft-Antispam-Message-Info: RKfeZz7MkNkpypg8xXVg3qAhq7TxHd8bbACskgRSFjUd8+udJ/YEI8p44MfEiOAd7D5Kr+XC+2tf1CT5yde3k7UG484+8cOpchNvz2tnFSnDRob38H955u86B4WatNYSxo68M5oc5DCfnmd6KjgrZqLwkR2hDYom6CmKSPzaISNfl+8sdoLeMjQGVyQzclvNlmPUZIkCjjbUiCM0VLs6q9ofWt+CC7gsFN6A86cqaPVWravujPWVOaSNsQHSr/Ts6tRseRi3NOGh7SJBPgkjZKa1YvYtH7fsHLAaaIDQX2VMaLPGMx2cWj4OvJKUZ9bCs+1QDrFsAGZp9dvtZIR1V47m4K0pEylD2fwAiOGK7Ro=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;6:CIXq/sSwa1oC60xHJt50mh7tfzXbSij4zrpB8B4jGkjGiYT1xEH8VZePF1+c6Ja9zzVoAI2u1T/ZovJF56eoRY5WdzpxRxwa7tIm/OetMZUWsHNJZI0i3IJezA96sVSvTTKrQFmLVyFE0rT+dzxuMmh0G5i0AAZnpoD7Ng8PjRbN7KIL4W6quhczQQ3pK9ssxmLOikNb0+w+f4/SbuePDLrCkVeA7iI6Ew+7g3RUtBuBTSBkBLLuirB1vfLjH5HRKg87cG1+yglNMz4AyQ9CuTWR36j3oQe7uNwTvwyjrHs/NQunaeyB6zEyoUqO+SdSS+YvEW5eNn843Oc1w+khFihBa1tcT+njWMqaJXrw1Mkn3r9K15UP5Lem+beqEf7HLaA9uQw8/tlghiQpAebYUuad+PYuBBhhGoDeBjCbiPwUInGHBwAJo4w4ooQREF3qU5VDlRjMbIwnKu8kaf4DlQ==;5:RyKo8bjjxBYYp0lDwLJ4qtQRetei2yLgF3eBala90l/jGq9NVF9ZnUsHc1uBpflYrsfJPJVBcoTBoMDJBrqY97+0zGR9MlTB64/KUz8RFtELwRlHze37iY864e0946JRIuPToewGBYCRPl4n8sfiyvHMa9wDw0bqmpWXc6qqJ64=;7:Hz2KVohm00CkWD0qwterflXVsuY75r3H9zV0BnIf0bbyXrLEkBQSnUcCwLDrt7P3DNLycrwiabbl/snK3tw/+PcPlAeu5o/Y74FVEt1B6kpO+TLoxd9m09F2TnayKWiFYa+qEAyT5lhVoTuHz+I+PXes8t7najmggagD1pH8zgl6t9u9Sg7BQj86GArFJXGrEJO99l3QMwi6mn9VduWeIUMppLghGvK4OP0vKU+k201VSmsc009B62sm9WrVoWmm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 21:54:13.6967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98de5a83-4706-46d6-fe4f-08d60df9f5a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4937
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65799
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

arch/mips appears to have inherited SLOW_DOWN_IO from arch/x86 in
antiquity, but we never define CONF_SLOWDOWN_IO so this is unused code.

Perhaps it was once useful to keep the MIPS header close to the x86
version to ease comparisons or porting changes, but they've diverged
significantly at this point & x86 does this differently now anyway.

Delete the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/io.h | 40 +++-----------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index bbbeede9fea1..44f766b6b5af 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -33,11 +33,6 @@
 #include <ioremap.h>
 #include <mangle-port.h>
 
-/*
- * Slowdown I/O port space accesses for antique hardware.
- */
-#undef CONF_SLOWDOWN_IO
-
 /*
  * Raw operations are never swapped in software.  OTOH values that raw
  * operations are working on may or may not have been swapped by the bus
@@ -89,33 +84,6 @@ static inline void set_io_port_base(unsigned long base)
 #define PIO_MASK	IO_SPACE_LIMIT
 #define PIO_RESERVED	0x0UL
 
-/*
- * Thanks to James van Artsdalen for a better timing-fix than
- * the two short jumps: using outb's to a nonexistent port seems
- * to guarantee better timings even on fast machines.
- *
- * On the other hand, I'd like to be sure of a non-existent port:
- * I feel a bit unsafe about using 0x80 (should be safe, though)
- *
- *		Linus
- *
- */
-
-#define __SLOW_DOWN_IO \
-	__asm__ __volatile__( \
-		"sb\t$0,0x80(%0)" \
-		: : "r" (mips_io_port_base));
-
-#ifdef CONF_SLOWDOWN_IO
-#ifdef REALLY_SLOW_IO
-#define SLOW_DOWN_IO { __SLOW_DOWN_IO; __SLOW_DOWN_IO; __SLOW_DOWN_IO; __SLOW_DOWN_IO; }
-#else
-#define SLOW_DOWN_IO __SLOW_DOWN_IO
-#endif
-#else
-#define SLOW_DOWN_IO
-#endif
-
 /*
  *     virt_to_phys    -       map virtual addresses to physical
  *     @address: address to remap
@@ -399,7 +367,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p, slow)			\
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p)			\
 									\
 static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 {									\
@@ -416,7 +384,6 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
 									\
 	*__addr = __val;						\
-	slow;								\
 }									\
 									\
 static inline type pfx##in##bwlq##p(unsigned long port)			\
@@ -429,7 +396,6 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
 	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
 									\
 	__val = *__addr;						\
-	slow;								\
 									\
 	/* prevent prefetching of coherent DMA data prematurely */	\
 	rmb();								\
@@ -452,8 +418,8 @@ BUILDIO_MEM(l, u32)
 BUILDIO_MEM(q, u64)
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, ,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p, SLOW_DOWN_IO)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type,)				\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
 	__BUILD_IOPORT_PFX(, bwlq, type)				\
-- 
2.18.0
