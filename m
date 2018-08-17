Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2018 00:59:35 +0200 (CEST)
Received: from mail-eopbgr730139.outbound.protection.outlook.com ([40.107.73.139]:42568
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994655AbeHQW7bja4Ze (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 Aug 2018 00:59:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej7dIklm6ZEHptZzOc48MJPY+ksj2o+eo7Lg2umQIVY=;
 b=mtz88XvKyluu/Ox584vdbbOE+TFLpKVLwY1R6gbs7jaKqTkQ7nIQLFQzNzmAulSIcOZTVmRpPp06oIH5h1bquwbAUZtF/vbhJV//5Ec8Z/yYp1/g55fvwIgrk1zz+uCuk718B6mwzkcPDdkuuGpaxGm2wEl78eTKN0VQAZbb5Ac=
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Fri, 17 Aug 2018 22:59:19 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Avoid move psuedo-instruction whilst using MIPS_ISA_LEVEL
Date:   Fri, 17 Aug 2018 15:59:04 -0700
Message-Id: <20180817225904.28197-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BL0PR02CA0105.namprd02.prod.outlook.com
 (2603:10b6:208:51::46) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 946c3523-1c91-4b09-35f5-08d604951180
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:G5JRDbwILs3nQ9skdraqoOOFBy3BAy18tLjF/Dck2Tu25yCQfFfJbhKTgYA5iS4UK4C/96X2NPm1yNdtg05UK14+I/ZdGdrhnUv7LAzINhrKS4Of9yZ5uqqU/BWg0fl4Cnv+LEEngGfef6LdVMiKSehMPU0UIVb8uZHqwGgBcn0LM59oih4q39XrdAyZK0q8a7VoxQ5WyN8cxD3tHFo0r11fal8Qd/QbHzWZD2OxjbSSEGdiUIxmAcn7gEE3flZf;25:tl6kEYlQkhOCtCgNJUGD80exgqRGlljV2jXUcFOcSczI3IgZDPZrdrWCxM44XtoDzo0zs1k6tQzeDlk6BenzshG2BhUdGagjxmTDE3bKLkTAvpH7K15SwiQwLyyZJjo0ZsXmE2QM8BFRYEyMbBB3EXNKSTDX+0cJthRJPE+osbx8TyOqIVsSZnmzG8QKoBJ/cguextorOM8BRVM6k4Vn7wXrJAYWAxsSD3TM6xleT95vnhMincElLnRov0/ICkggtPElhEWnxzYc4pbmynUsWRSmH2EMAMTjwbyr7Wf4hYfzrC83Y4t9pfjcQAnt48kL6qo81vhR9KzUgyzvU8jBGg==;31:pCmaHWjMiy6tscOBhz0bq72XREGDLGvvbf9b34BDTirodUAz6hUbJzHHdvIxTY2ec/uZ3OWmRrTtzRmbWdt1sMthvov+madTOMSTf4n10CkLakLklfQ5jpp/HY8SsoslmFY6BCXDwOXTQ2T3I2FqxrZIP2UqbKGEbzHufGME3ECvovxlMXW13MB8IvKz1agRklZ3HGt0bt4yBTpmPDgciROo5XOuN7jdloc3P/KsZ0E=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:yRZ4mSxTTW9ncK9VVwzGIfdJlVRtpVJSlVYdyEa0XlxgxneLfCDfthwYYEhsXQR53CMhvTDxugKnw4mYYXnEIUaQujTdpOMaFDSvjam5jNbpzJyVuDGdl3tDwaXNogerE0d95o/supa8DefdKszAj1NtHbuHLOz1B/qp/V1Ej45oXuqVLcxs8ebNIxYSQYrQIThCUWTVU2S730APGShFz1df8GdIMUTs+9yWT7fC596qjudrETKptUPnY3nS1oU7;4:NPnlOFus5nWrn6IuYxq6BqO66EupMGHUmb1VjofYWqkBDMTw5V/MPuRkJ8jp6+GOysJsH/YCvD+O+6SiNv8MzoFQP3Qty9+Aspymz/k1s7dPhX7NsbhvTMgNvfdmKadaoi7LLgjsHspuFsIcI+iCw6tH/9wIUsxnjo5y8Bjq6nn/epMdI6jNzv4WMHGw+RCWCClCEG1nTBqgXqlEt9GqgaBhMrKoi2rwtClUMoLWq/3DrKwhJRk8uAogmB3e98anTwTxWpzMtf462H1F9wZ/Ag==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933D45C579F4B7AB6D25C82C13D0@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301068)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(476003)(6512007)(54906003)(8936002)(6116002)(1076002)(3846002)(50466002)(69596002)(50226002)(16586007)(51416003)(48376002)(53936002)(52116002)(66066001)(478600001)(47776003)(7736002)(305945005)(4326008)(16526019)(2361001)(14444005)(6486002)(25786009)(97736004)(26005)(186003)(6506007)(386003)(316002)(2906002)(53416004)(81166006)(81156014)(105586002)(44832011)(106356001)(2351001)(8676002)(5660300001)(42882007)(68736007)(575784001)(956004)(6666003)(486006)(1857600001)(6916009)(36756003)(6346003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:TvyW7ZlJKbEMKt6tNabp4mPFcIZAMFoXINJcIBSW2?=
 =?us-ascii?Q?VwtfFwF/b3g8vbQOJ1MIqSCIwcgvuC83qKWGXtWPA9LgC//+hJTue2qBpcay?=
 =?us-ascii?Q?6kfiMiapODWxlfdU1FjRsCMmREeETLAPQ8al4AWOev+NJY57EGes4xo+ldvx?=
 =?us-ascii?Q?wwUQcRQzVlsveHN4v7kUb8jbhuvhoOqL3BeceeRKquQz9v9Vu14JicQvEBpq?=
 =?us-ascii?Q?fmMuB9DY7qW+aLpgdhlnJppsBPgH8RVMvo567YK4E4O8YkeTPoawu1aQEhme?=
 =?us-ascii?Q?KfnzhXzMioxHIJUt21JLMPn3GEMnmuduYo66BkVow0rQCTemqabGVpwPRTph?=
 =?us-ascii?Q?WwUoxhmZdWrnJg9St70tDQ0SkchvFQrc/kjtJKAYonXrTgtL17rO8oUHZPtv?=
 =?us-ascii?Q?TiDQiU9SvfZg50ctL4vG+VqpJ3MK3bsbWFYFR6Wfpz2CGOtAIvTSXD8TMTkL?=
 =?us-ascii?Q?IN5k5QLu6Nm+W/CEQ+EN1y1paHPdGxl4d8iIhiba9BlVggEsviVijzbLoL6G?=
 =?us-ascii?Q?H3CFIOiV0PZFnNcmuW/1PmscITdRjI4I+mrH1wH54a4UkGTJYxWat1q2+0X+?=
 =?us-ascii?Q?jc2C1vIUjSSYnqUwwWQCs9IggtcrIoTETTc63/w+inkn5ytgx8HzzPb1UuQt?=
 =?us-ascii?Q?V6zzLc8Vr4FSe2cgSOOQLVcR9BPvr6iH9sCExvoDc5PsstGxqxtAChVKUvxp?=
 =?us-ascii?Q?XtKpoSwVms15FohFvsfJnByVepMpvrmMoFp8B6QeLVTZ6x8+UFQxpK9IO8bt?=
 =?us-ascii?Q?t7QJl5HvqdRflP3wy5ych0ShlCSVtDDsKh2gVTEhTqsk96qSzeLcApI+DR/W?=
 =?us-ascii?Q?0MLkbpnhUygXJFwCh4ou020UV6ckgXIigy5W0QPL3Vpc1IgIShznPPS3bCgu?=
 =?us-ascii?Q?Uwc3BujdpHKkJ62JG7AN2Lpbzpx8JcV2Pl2wd/U331Uu2+u0/fsY5J8sG8Sx?=
 =?us-ascii?Q?kiG6K4/YsIf1ovKyuI6wh1RHT1dlvLjHicX85biLH/qWhJ/3tP7AZNeyOLBw?=
 =?us-ascii?Q?FBnYBQKbYT97pw/mAKoEaFnVSIm6Cek0qNh46MKosUum4tqjW5WhkFkjo3Qf?=
 =?us-ascii?Q?A9+wWEgUP5cH4sX0E1YToGHhcd4J2hjYdEKt11WiruWu2z8uCYEj5Jcl834R?=
 =?us-ascii?Q?hvuXivOJUuyV29PmDrRmbtEBWyeohui5CKeWr3W3M11SDGAR0Bc9FvL3Awgf?=
 =?us-ascii?Q?qjztx+2gS0UZ9bXc6OG+Jr6toVKSMBA2G/LAX8msXFeiin0FDSahxYUqKI/t?=
 =?us-ascii?Q?wI2Xc9AhM5YLX1U4BmMSh7wObGWO78rQZcDZvQBIxXW4vWnHUQZP2Z21zZ//?=
 =?us-ascii?Q?Gl5IxTnwZCUiCf7/6Ak5CKYOq8gkEeVKrs5yViZDlpH?=
X-Microsoft-Antispam-Message-Info: aKW0ivRkbuu6x1vAOSuHVOv6KadpPUggicXwUw18QZupkLCpjOoxyU9euvvr1EgZ7rTLE/fdAWv15uIbt4mHyd5kC/RwNCzAdm2FwMJOfQJghgedT5a628XvffoH+mckC2ZdUCTtITv+vgy9f0jFG74HD+/t4Fxex8JDWCOy9Y5tqGORHYqNntC5UCmjFVCskVdRXpEIEkdrlPyEriz/bEd+9cay89fA1vHo+VCcg7YMG+mNSh1N4ZWuQtfDaiAPXa/Lsrf+bIVCrt+4MKZZ9Ce18Jz9Lhh7BfDBIIJj2KJaZXX813LXVPtqzNQ7TTU6mig14WUAEM3xaI1FHOjEzqVy0H2DGnL2c+jY9b4rdBU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:GCqgaPhlkFHdx9rqxph8zegPELh5FNuPoOAQIziwXcxB3b7ArQCAzCGXvYPX7S80QgKXzkDAxXT6dewfEnTdF8+AAijgPG9UlSQGHJ33hDGmQfrghyVTjG9JFNTS/1oE3b6Wd0VE1F6uJM5RYZPSKmaVlG2FxT9bTJn9zsRARVjyJqSfGFi9APDdKIucHiG07nv+L0ounyaAVDJ55gSBg7DCf7VaQ1aPvXHX2exOQBKH7WYd+F8m50uAaHXMGsMrcyPCaqb/OVTjo616JGAwbyYBNY34BDPOhuK5JWsbqkHQR9jpIHtkYEUBCOVz5Inve2/IhU3oEGTBWRe0JCgqGO4lHoK4PkogJ3KO5dTSCG084WShOMNE44JvIIIWxnzY2KXZwTTpSAiH1ud1KBsmmsmDmu0F8zalVGh3vyBxUyYi87Utk0Y4C0xen+Luw6ZLLJ0wUEWikalFU0h9LZOiIg==;5:q6CWjf4jVDtmpXXq9MNDSPUVsliWg48626+wa8C3e9TkiGn6m9y/Y+QI9mknCvetIZg+j8Q3fWbl6GqDxjX+z09ct84kKTX6Ux+ehQDRG0PPnnLB2peIuh9w6wscKm5s8fi/OWyYz4MwPyfRAsAgBchnyG/WahiA2afYQkz2u10=;7:hKMV9bQcjcWq3tctZiLPRUp7JjGTOHv0rrFma5aLgKWn4Z49um6lAM0LF+eN/nbOiKv9QXxhJe4y8k635p3tqxMgUJQhQ4OjwWkAG6fFnCwfiAJpAHWNyTFuDkGF+IQXjjP4IgsPx3VC+dm23olCGVOtwIFB/4WgqwIJy8apeTc5Z1pKjp1Tc6id2iG3aV51/VYveqPUlElF8R/79UjxThL/sColGYOX1c+xQvtFPGGNX/UEEF0yBQ9ov8V6INim
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 22:59:19.9489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946c3523-1c91-4b09-35f5-08d604951180
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65632
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

MIPS_ISA_LEVEL is always defined as the 64 bit ISA that is a compatible
superset of the ISA that the kernel build is targeting, and is used to
allow us to emit instructions that we may detect support for at runtime.

When we use a .set MIPS_ISA_LEVEL directive & are building a 32-bit
kernel, we therefore are temporarily allowing the assembler to generate
MIPS64 instructions. Using the move pseudo-instruction whilst this is
the case is problematic because the assembler is likely to emit a daddu
instruction which will generate a reserved instruction exception when
executed on a MIPS32 machine.

Unfortunately the combination of commit a0a5ac3ce8fe ("MIPS: Fix delay
slot bug in `atomic*_sub_if_positive' for R10000_LLSC_WAR") and commit
4936084c2ee2 ("MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h") causes
us to do exactly this in atomic_sub_if_positive(), and the result is
MIPS64 daddu instructions in 32-bit kernels.

Fix this by using .set mips0 to restore the default ISA after the ll
instruction, and use .set MIPS_ISA_LEVEL again prior to the sc. This
ensures everything but the ll & sc are assembled using the default ISA
for the kernel build & the move pseudo-instruction is emitted as a
MIPS32 addu instruction.

We appear to have another pre-existing instance of the same issue in our
atomic_fetch_*_relaxed() functions, and fix that up too by moving our
.set move0 such that it occurs prior to use of the move
pseudo-instruction.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: a0a5ac3ce8fe ("MIPS: Fix delay slot bug in `atomic*_sub_if_positive' for R10000_LLSC_WAR")
Fixes: 4936084c2ee2 ("MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h")
Cc: James Hogan <jhogan@kernel.org>
Cc: Joshua Kinard <kumba@gentoo.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/atomic.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 3ccea238be2d..f8793f1f2670 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -122,8 +122,8 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
-		"	move	%0, %1					\n"   \
 		"	.set	mips0					\n"   \
+		"	move	%0, %1					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
@@ -190,9 +190,11 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
+		"	.set	mips0					\n"
 		"	subu	%0, %1, %3				\n"
 		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
+		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"	sc	%1, %2					\n"
 		"\t" __scbeqz "	%1, 1b					\n"
 		"1:							\n"
-- 
2.18.0
