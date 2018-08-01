Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 22:13:14 +0200 (CEST)
Received: from mail-bl2nam02on0119.outbound.protection.outlook.com ([104.47.38.119]:57580
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993937AbeHAUNLIbGih (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 22:13:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3doy/JADrtyIUyXq5mLrP5GF8gE+3EadUF1yYlYdKW0=;
 b=bxz6P2Sj3e6D9wDeNyK/480iH3V6uZiR3F7Q7zq98Lnvd4amIXLuEAceOM2l2ANn3s0RcHiz8PGd+wmt/bKLeax9j982udKiNvbisWf7LaOcuWD6AzehUOGM8Own77t1wWMzYg1UhR3OH6dLpWdnM63Dz0pQMY53J5FtwifJijE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 1 Aug 2018 20:12:59 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Remove nabi_no_regargs
Date:   Wed,  1 Aug 2018 13:12:42 -0700
Message-Id: <20180801201242.21898-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To SN6PR08MB4943.namprd08.prod.outlook.com
 (2603:10b6:805:69::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce72cb2f-9b39-4a98-1958-08d5f7eb2e01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;3:CstsBYvAtOWM6Qr9WH4AmoGFoaogUfb9C6D1i8G1GC+8gmYXGvjSVgz+1M4MfU74w3ErXyags4Je8c84ljS6t3sgPu7DZhaFDIlqP08yGkLmY8KlL5XuCfq2N2ZDW+q/s+GyUV1mk8UjLVWjWh19WsFzNJrUcD0F6q6p0xwpWIURI2+FJ1rBXk0e4jZSyIZP3Hlf09l/74V2tYNZcONW7r+5e0/usmkuB91+J8FbVhSjuTjtmt3IC5y316kOXwa4;25:Q05rhck/6ctilH0MLxRh8PSpnvutRa4nWaEtAd9tXu3zjB3AJdHjPbnrbS27/MSs+UFwMwf5Ym2R4PqdIGaw5V7EkJq/9ZeegZ0CIy2iic/OkTCE2K+XH7t+DiPQbjZYzMxbQA6YFef9Fmi1lSZxi/t/lwwlqDWhXnauJ8pDshziX/TibtAR84TFNG0krgcneTQuGBh9/G/4ET2m0rkRiycsSJwUhNrrpxPmmxISrSt8iVOTxIsyKDqJwNkFL4jwNsUMpYEjSxuvmeTWKWBo+oUyCEH19asSqUmMptz4UNpDEO/ik6uRwKE5F2u59ToxtGLAlP3BLesdgpfK2IxLoQ==;31:IVPknA8XvNzDP+t3HzVso2Z3hsuKfIj8jDQTwTgOmXRrVE0O10rUa3nW4GD8wLX+fIhbM2IjHwltjRSUT8wpzzBTjb4w7UNzqZjAGu/0XshCeyIBAADk6p8aqI0mvQvb7BNur4wOME95LexaRBtjqCSsJOwBFRlKQA2kfVdnN7Pq0ARhIGbec54YKtyB0qbLI75ZQDU+vPME6XtFY2OXQcBtAyA9GRdomUA0UvtKrKc=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;20:qZyXTpNcjmTGNWHJB+EO1Py8snxdM69YhLJx250m0JKJF9zUGAJqRDKWu8IsY2xkpYw+WF5bCDCq+43is/EhssOG91ja3HqlKxGlCyfQ9UlBTUM2ehG43tsNR3vPygAyC1anQnwhZGwSnyNHwboVtOK8lyh30M6VRdrel7550mYltI3T4B5pLW4ws04ktZ+Z3f3IS0twNJywVHsKGIWSOFRG1wd0TyypiuMVdj15RkYK+NmDhW8iaJr8NGObvaED;4:s9kKmwIcybI6ZkEGCQzlQTtimOCSCIzVwPp9q+Yv2G9P+RSS2aYUQ2s//2WFll9Tsi71QE/lYaZBXIC/zCuPhg7+6tOQYNDAMBcqkFFr6SwB7TDuSKTBqTAxxdNa/VpgX6oiFQrSSeKpPBlNFeD5owqGFeaDL55LkiM+l6I1xua2AH5AXxj0h07zVXSocKOK4eX7crAUqNGCzE+jXxKlygGeeV9X6wZDfX8Eh1jMeLHPpVq9FkS5d3eJXai7fR9KrzAM+9HW750kKM2cXtSdyg==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4943163B6A56E18BE50168ECC12D0@SN6PR08MB4943.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4943;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(7736002)(8676002)(2361001)(106356001)(53936002)(105586002)(6512007)(4326008)(42882007)(48376002)(81156014)(66066001)(50466002)(16586007)(54906003)(305945005)(6486002)(81166006)(8936002)(53416004)(316002)(36756003)(2351001)(25786009)(97736004)(26005)(478600001)(47776003)(14444005)(476003)(3846002)(6666003)(956004)(2616005)(1857600001)(486006)(44832011)(6116002)(2906002)(1076002)(50226002)(68736007)(6916009)(52116002)(51416003)(5660300001)(186003)(16526019)(69596002)(6506007)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4943;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4943;23:3k77ZOyDD5/xmcJARWquso6AtxlJAqJdDOY1ntq8g?=
 =?us-ascii?Q?5QT7z7RmXrkV5+FLsy2VEoGqkkdkRbPjstdiJPi1Zkqw3hmnRDG2ORkfPjuR?=
 =?us-ascii?Q?C6Wl4+kfhAvmmtrFHz/9qu+WWFlcZW6JqRnsMyXcuWW0u0QhTJ6/ip/GWkHl?=
 =?us-ascii?Q?R7FTmXN9LZG2NXw5mnLYFHs7E4KJQO2eJHzWJNrZb7AwS0ovLVUZFm07DfvQ?=
 =?us-ascii?Q?/ChVGmooSzrEvilr2NKduuQahSS5tRYyU/hKMv+mEXocnRbQC9klIM7g7FlE?=
 =?us-ascii?Q?8Nl22g8jdSY1oUtU41iilpcjDfcb04/yYTeaGQ5EBDFJ2kv/PKBzxDBDwSIV?=
 =?us-ascii?Q?10iZ3gshrFSprY7s0r3KMmozbC+9UXr5R8hXmz2LL+ypjz2PtQYSQ1pHOZ4Z?=
 =?us-ascii?Q?jKXU+M6RacibXSwOT6L2i7qdCUJVjvxt0YQm5oPH2jJooCylzC8UqJ/W2LwJ?=
 =?us-ascii?Q?ge5r/FLO4gznmbsTD4O0Jk0Q3mAaJEi+rOhhFY7lJEXsjZsm9HL/00QzxNIf?=
 =?us-ascii?Q?pK85po9KaJu2gtlvXgz9hujG5Qnb3GwnGhWzin75BAoJuAbFoufhFBK3XNhG?=
 =?us-ascii?Q?OWj6SxhAOhbUeBmYkj3SXbYaKxPanMvp8TDP5PYdAVrMgRFWU7oMyDTY+Lmk?=
 =?us-ascii?Q?Nzl5GdZf2jNxHpmU8YDgw/pCiGiyaTPbiaJlXL3anEljDRmTROqH5mUz36C4?=
 =?us-ascii?Q?GZaPRyBt/haTRWXB644/dEn/R0Bze6wAPqzpDVqbEXijNWdthi7BpV0TlJSH?=
 =?us-ascii?Q?9Nd/7mc1aL8tCqJiD5tVQBEkU5ngFdxNKUkPM0RpuvNoNv/nzvEIin/nGtwh?=
 =?us-ascii?Q?ITKgza18nSeAfImgekvOm+4Vrn5srpxopNvBuBK4aCWjuLZPG+2+XT09yUzr?=
 =?us-ascii?Q?ew3boCtl7SD68YwS5ggfJk/+SJuXukTWZehG2S4CVo/HnlojvRUmGwoDf7Qv?=
 =?us-ascii?Q?8IsK3u3B1QPe8wF8DbzDOPYyABWoG4WJ20/4bmnOrMqBtCJLtGZ8a31ZW4AQ?=
 =?us-ascii?Q?ApmSfa+bTcuP9tKgA6W2jG1h9Im/2cOZxR8NrveusKpt6KJ7DrCeRxJSXGvx?=
 =?us-ascii?Q?DzXULH1kp0qZEbfIjMjJex2Ms9fy2UK5loVGhuIurLTcL57g3QOL7/sBenF3?=
 =?us-ascii?Q?EfJtvn1Ei94bpDgTUxb9JNJFVpsTY66/ABmQ7e0QduDC+92lZ0OxlW3Tja05?=
 =?us-ascii?Q?lIowZFA7/e+bVaYVQQUXqt46UH6ppr1rTZdmbyt2/PwSJnkKzZGE4uHaeJu1?=
 =?us-ascii?Q?2EgwAs2nQ56VlW/ZevfbNMaGL3XXED38dfUMik6O8zJdHdcGGUjSciEXrm/Q?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: d8TxE3AGrXrgc77QaC/8gTd0IwGrsgmKLQBP/dUH8to3dyjn18r+fpzOJ6n/U1XLnpsjTnTlpz2RKNPRM0/M+ksSrtKTVEKbTslsR6gyv471X7MkWHeDowkjjmTZyLcqJaRwWQARFwO42qLvPI82PKnjfTnQ4FZqt+5IMu7dQ1i11QZhjGZxsCDcUJh0N2tIf3AJYpoHs8IqMa44Zu0ezt618gL40oUjcI94RPa+ZHlFMik8k58F7WSEtRExDWq9okzvhbKPd0e6EmE8LgH0HwC0eqYRXxYWs7UMuIxJCYzA9iAVZCWFB2ByEJNf8NPnjbl3IwBHmIgPusMOk14+Zl5VtKtQvC67ouW8KsBJ46o=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;6:JQwz1IU7vhLlLJo1qE7hqBzMl6THbzncTMZ/7Rx4MTnEWspx0OIzfGb+MJwlFAm+39NGHIArma7nwdRKWszb4sqj2a2f89R5UICBvcuWdBQKREoeziGlrTd4TG9tUlC9XpYefmuWQqY634WHPQM2/gfqntrKGWxq1jnSEekYEkxPD8osgn9gU64PVlj5Vlruu5RUnaDj/ZW6P2Q+uc4N93VxRb3q64ZZc11Pho9M97GuQnANwnIapdQal6nOyem2TYwLe0fe8y9x1BH1PvrYR6WU55KDKwlhhV8Nm8vPKLU7v6zMdksVfUSA/J67g+4L0C/yHZfRLJa8zcAlx9xXybKXvwhuVoqXqmTPrX2k8OCMI+F5mlWEi6paw9+xsGhvl9y10FokhmI6I8zgXbIUTwHCu/9864ktrDfQTcgFdQLM2nOSuyZaSI1oZT8bulIKh0ESpLwhHVcxCP99xicT2g==;5:cZ/hgrNJ54j9s5c5e8Yq5gRhPPzYcjac1DjEQKZ/3MQwzQjDa0IMoZfSyW/i4PZBYotY9oVm0zPN7wiFP0LkoAtBD+PrJpgDkvv3jEm6WLPsDhy42aGp4GhGMu+8sKSsA4nRkZMMjA0PnGzWpO5OBm8Vh7ITW3mVE5OBYLXuFFg=;7:+CCmr2A50EJavLcCypDtbq2rGszgpXzIc0rOmtsvBJpDFcf+ThJ2kqOg9OgV5cIHCpyyij0DXbSZb5gto8PJesT1N5v9nI39fvoT9ulN/Vgu5uWI0rXGPUJcSGW1/RfVBVecjs2Tn+7cxai72iplBZjXONIehbedwfaOftve9EiYWlTuY2QLyYHy5orMPL2uXifcTQwKp+xIL1bW5GZfSIcMo2oWVW1YA+qnzC8gtzji/dEQdqc9kBHfNuHBJdhT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 20:12:59.9329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce72cb2f-9b39-4a98-1958-08d5f7eb2e01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65348
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

Our sigreturn functions make use of a macro named nabi_no_regargs to
declare 8 dummy arguments to a function, forcing the compiler to expect
a pt_regs structure on the stack rather than in argument registers. This
is an ugly hack which unnecessarily causes these sigreturn functions to
need to care about the calling convention of the ABI the kernel is built
for. Although this is abstracted via nabi_no_regargs, it's still ugly &
unnecessary.

Remove nabi_no_regargs & the struct pt_regs argument from sigreturn
functions, and instead use current_pt_regs() to find the struct pt_regs
on the stack, which works cleanly regardless of ABI.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/sim.h   | 12 ------------
 arch/mips/kernel/signal.c     | 20 ++++++++++++--------
 arch/mips/kernel/signal_n32.c | 10 ++++++----
 arch/mips/kernel/signal_o32.c | 20 ++++++++++++--------
 4 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/sim.h b/arch/mips/include/asm/sim.h
index 91831800c480..59f31a95facd 100644
--- a/arch/mips/include/asm/sim.h
+++ b/arch/mips/include/asm/sim.h
@@ -39,8 +39,6 @@ __asm__(								\
 	".end\t__" #symbol "\n\t"					\
 	".size\t__" #symbol",. - __" #symbol)
 
-#define nabi_no_regargs
-
 #endif /* CONFIG_32BIT */
 
 #ifdef CONFIG_64BIT
@@ -67,16 +65,6 @@ __asm__(								\
 	".end\t__" #symbol "\n\t"					\
 	".size\t__" #symbol",. - __" #symbol)
 
-#define nabi_no_regargs							\
-	unsigned long __dummy0,						\
-	unsigned long __dummy1,						\
-	unsigned long __dummy2,						\
-	unsigned long __dummy3,						\
-	unsigned long __dummy4,						\
-	unsigned long __dummy5,						\
-	unsigned long __dummy6,						\
-	unsigned long __dummy7,
-
 #endif /* CONFIG_64BIT */
 
 #endif /* _ASM_SIM_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 0a9cfe7a0372..19f778c33ab7 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -592,13 +592,15 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
 #endif
 
 #ifdef CONFIG_TRAD_SIGNALS
-asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys_sigreturn(void)
 {
 	struct sigframe __user *frame;
+	struct pt_regs *regs;
 	sigset_t blocked;
 	int sig;
 
-	frame = (struct sigframe __user *) regs.regs[29];
+	regs = current_pt_regs();
+	frame = (struct sigframe __user *)regs->regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&blocked, &frame->sf_mask, sizeof(blocked)))
@@ -606,7 +608,7 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	set_current_blocked(&blocked);
 
-	sig = restore_sigcontext(&regs, &frame->sf_sc);
+	sig = restore_sigcontext(regs, &frame->sf_sc);
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
@@ -619,7 +621,7 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"move\t$29, %0\n\t"
 		"j\tsyscall_exit"
 		:/* no outputs */
-		:"r" (&regs));
+		:"r" (regs));
 	/* Unreached */
 
 badframe:
@@ -627,13 +629,15 @@ asmlinkage void sys_sigreturn(nabi_no_regargs struct pt_regs regs)
 }
 #endif /* CONFIG_TRAD_SIGNALS */
 
-asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys_rt_sigreturn(void)
 {
 	struct rt_sigframe __user *frame;
+	struct pt_regs *regs;
 	sigset_t set;
 	int sig;
 
-	frame = (struct rt_sigframe __user *) regs.regs[29];
+	regs = current_pt_regs();
+	frame = (struct rt_sigframe __user *)regs->regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
@@ -641,7 +645,7 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	set_current_blocked(&set);
 
-	sig = restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext);
+	sig = restore_sigcontext(regs, &frame->rs_uc.uc_mcontext);
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
@@ -657,7 +661,7 @@ asmlinkage void sys_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"move\t$29, %0\n\t"
 		"j\tsyscall_exit"
 		:/* no outputs */
-		:"r" (&regs));
+		:"r" (regs));
 	/* Unreached */
 
 badframe:
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index b672cebb4a1a..0e3e5737c28f 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -64,13 +64,15 @@ struct rt_sigframe_n32 {
 	struct ucontextn32 rs_uc;
 };
 
-asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sysn32_rt_sigreturn(void)
 {
 	struct rt_sigframe_n32 __user *frame;
+	struct pt_regs *regs;
 	sigset_t set;
 	int sig;
 
-	frame = (struct rt_sigframe_n32 __user *) regs.regs[29];
+	regs = current_pt_regs();
+	frame = (struct rt_sigframe_n32 __user *)regs->regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_conv_sigset_from_user(&set, &frame->rs_uc.uc_sigmask))
@@ -78,7 +80,7 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	set_current_blocked(&set);
 
-	sig = restore_sigcontext(&regs, &frame->rs_uc.uc_mcontext);
+	sig = restore_sigcontext(regs, &frame->rs_uc.uc_mcontext);
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
@@ -94,7 +96,7 @@ asmlinkage void sysn32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"move\t$29, %0\n\t"
 		"j\tsyscall_exit"
 		:/* no outputs */
-		:"r" (&regs));
+		:"r" (regs));
 	/* Unreached */
 
 badframe:
diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_o32.c
index 2b3572fb5f1b..8409038e4848 100644
--- a/arch/mips/kernel/signal_o32.c
+++ b/arch/mips/kernel/signal_o32.c
@@ -151,13 +151,15 @@ static int setup_frame_32(void *sig_return, struct ksignal *ksig,
 	return 0;
 }
 
-asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys32_rt_sigreturn(void)
 {
 	struct rt_sigframe32 __user *frame;
+	struct pt_regs *regs;
 	sigset_t set;
 	int sig;
 
-	frame = (struct rt_sigframe32 __user *) regs.regs[29];
+	regs = current_pt_regs();
+	frame = (struct rt_sigframe32 __user *)regs->regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_conv_sigset_from_user(&set, &frame->rs_uc.uc_sigmask))
@@ -165,7 +167,7 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	set_current_blocked(&set);
 
-	sig = restore_sigcontext32(&regs, &frame->rs_uc.uc_mcontext);
+	sig = restore_sigcontext32(regs, &frame->rs_uc.uc_mcontext);
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
@@ -181,7 +183,7 @@ asmlinkage void sys32_rt_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"move\t$29, %0\n\t"
 		"j\tsyscall_exit"
 		:/* no outputs */
-		:"r" (&regs));
+		:"r" (regs));
 	/* Unreached */
 
 badframe:
@@ -251,13 +253,15 @@ struct mips_abi mips_abi_32 = {
 };
 
 
-asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
+asmlinkage void sys32_sigreturn(void)
 {
 	struct sigframe32 __user *frame;
+	struct pt_regs *regs;
 	sigset_t blocked;
 	int sig;
 
-	frame = (struct sigframe32 __user *) regs.regs[29];
+	regs = current_pt_regs();
+	frame = (struct sigframe32 __user *)regs->regs[29];
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
 		goto badframe;
 	if (__copy_conv_sigset_from_user(&blocked, &frame->sf_mask))
@@ -265,7 +269,7 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 
 	set_current_blocked(&blocked);
 
-	sig = restore_sigcontext32(&regs, &frame->sf_sc);
+	sig = restore_sigcontext32(regs, &frame->sf_sc);
 	if (sig < 0)
 		goto badframe;
 	else if (sig)
@@ -278,7 +282,7 @@ asmlinkage void sys32_sigreturn(nabi_no_regargs struct pt_regs regs)
 		"move\t$29, %0\n\t"
 		"j\tsyscall_exit"
 		:/* no outputs */
-		:"r" (&regs));
+		:"r" (regs));
 	/* Unreached */
 
 badframe:
-- 
2.18.0
