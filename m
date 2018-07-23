Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:49:09 +0200 (CEST)
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:55469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993937AbeGWOso0pFrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8TTpalJ4tymCsfPZmVyBsvFOGUSEbXiA///qHSHoDo=;
 b=HEOfyTWDSjGQaG1IGS0UTfJEPGLFbOb2JexEBkXTFFCXi1qw1cuPM4DtoEKjh3xl1b//jf68k2G7M+hFtlPuQgJdW15FnFyBro5/wAcmMAxqUNkMhXT2BWcSXBTfWGWebjg97EhMIgyWRW23g/h3ZmEUnw4wCBXTbRBubkZ5oLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:33 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 3/6] MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
Date:   Mon, 23 Jul 2018 07:48:16 -0700
Message-Id: <1532357299-8063-4-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2040a436-3927-4611-1f19-08d5f0ab5d47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:KN057RDj4Neu/c90VWHaC7rTYuohpI5qf/V7DhESrJJXoi/A+huFswLNwluAwu1UvQZRLY4zT70V6A1LvpgFkjd6Vp10a+Si1mky2viMpQVGXJu8i7Dso7+s/iTwpUYFSJYw48Vv6+BmsK6rPFx07vOGsGmCJ6G+ohFuL35msyrff1Rt/gcl544+ELD4rnoCHMQvihoYGzDIzAMbsOaQghC6t2Eqj29qqpqSrjjdUUheTJjXszUBxWo15XQAy4vR;25:JKBKpIfx+5R9Nr9AunO+5ABKi80wVZ8okEc9hadN0bG1+RKIOUqKDFwDq8IY9ENv6RGL+eoE6ZQ0jaFTpNDFhmiA/GBZm/HNaQX+Tg6EFICSpxAtzqXIYUIBIs2D1G77Q91CUVSn2Y2fW0RlzZi39m3FSY8szA/7HzscyOO9nb3cyKs7kpQAQzHh/OiNoQeXw1V4FyX//zJ6Q+62ot/F6seVg3LhBeMpn/AOcSaSBMMFS13VpP71lj5VY+Va4nZYEyns+gdHS7D9v7EHE30djZd/lvSVLuPdF75gUO6h4rJW+XyYB9I4/AVx+2+C7qWTVSVhAAanPmxStFRPDi4RkA==;31:THrLVqmht6MstQskyTmVO35r21IHG0XF6X2iawbPmAqW86mOtUU3nm0tySFd039fi1VnfUbnQEsdLYW7Uvq4Ty18x5YscfrgfvPqjNJfDLoC1U3m56g4OorPL32foWCYz27O/bcRXH02255cYYPGZZ5L+Y3YPP0Py/HBqW1o0rVRe0KA63Wxllf0TWXAkdZCFUKpwqONP60QzG/HwO3jaQguk1YUcuj+9byHHr3Sp4Y=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:tvOEvhT3QZZ+jk05PbQUqh+QTO2IOCsvJ261p3orIdE3o8/tPWYmawWHWwhXvQFvRu1JTa8Oh7xwVV17jkD8ue2OYPT/5HBtPVwgEI9579QxRCW5NHher6bEclMed2gKMIZPv+03EIUUIwPsSc70LAgt+zAcyZWLmTOAzuOlRZO2zFMGVwux0uKmU4xzq6cKv0a2pTi+CrFH1pkw/SdHZL7CarawbDVUWo03vElhn2eGtrBWKc20Ukc9dGiQlgpK;4:bbIYpFropXNNDIcYHZi2UhAhFoum3gMCigJTb3Ji2YoqdPY7DplrxPMTzzynuMfaM7mtTKHOHN4DEjFOUgcCtWAuWdeatrhJ9q2axpzYqMV3RfgOpBdRmXtTED+wB4BtVqcie89oh+Ng78EZUuJrsFj1X0HUojPx6uFjVTghvHSY6QeKaMTn64yyiqryQtCoVkFUEgrj0Nq1asj/Spv3fKd/IR/jB7LOBtnM/3doH/LZNqRHPlfMJNR7KHmFCU5gJBixvtM/NiDiFVF8PBoQU9Ygb4MvrVMXioLtFvSXGLFTOHMJmyvdqBmyaY9qtUAG
X-Microsoft-Antispam-PRVS: <CY1PR0801MB21555AE0F5A23D16097A87F7A2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(575784001)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(76176011)(107886003)(4326008)(446003)(11346002)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:CEpYusCi+rM9jfKoXy6Iv2997XmeXkYMOYSvGzw?=
 =?us-ascii?Q?F24jWUage/SwO+HQb9aCLb81/69OehEdjR8UMUJWFlUMpL7acKcxdRri4Yhl?=
 =?us-ascii?Q?zlRio5DiK/Rlt6iYU9PP/OXgxkX7yyaYC6K0ZUmJHrtERksVRYFjmPOTF1ND?=
 =?us-ascii?Q?ZA4hHbnVU3pmARbNsBf1eIPBWm6HXPlN3BGTEK1JArBy5HoZV0fRY6cLLDUM?=
 =?us-ascii?Q?OlJQy79GI+YV4qsvinja19TL3cfWyVfmZ/mivgN9GeUMcdKCNSdGUv+86KJy?=
 =?us-ascii?Q?+SXZqKuG1PBAnVl4Co8Txk0i+4gH4HvP9LR9wVnMGWqLwAycEYTALPYxIm+p?=
 =?us-ascii?Q?SrAme0i09NCBTIpON3FNkjDFMWcnwEw1uIkoDTfYyHK4mlg4OejD1FeUdC0k?=
 =?us-ascii?Q?2qWdjfXFwMl79zR9P32VBymq2dchcMWsh+1qX0p554lMMj+at6F+jUVn+EMO?=
 =?us-ascii?Q?GNRuhyqdzadrPj9roQyBC9UOio73a/PaLMyWCUEMxa05hELSWDbB1GPGo+2I?=
 =?us-ascii?Q?6zVv5/4jDBeLWVxVtkF6JHCs97PSvrvgKoOCb8mTZiGXRUMH4YbfJ8uykKjy?=
 =?us-ascii?Q?ZWyiMCw+zNdAtJ44fKdFvjBCYY/y6EmYmTyU/+238Y4j0/g7r6gqDGWY213y?=
 =?us-ascii?Q?0cUM4ufrx3Pun1H0iWj2imOGZhknxB9MHacNmaTYrDcb+GUUjAJRFmpIUoii?=
 =?us-ascii?Q?ek8rpo52L9Dx76K8lYZSRANmKUxDl1zYrHGIySkxRSSpKdu5lAlPNQYM+N3m?=
 =?us-ascii?Q?v97NGMAKdzs/4GVF3Dj/XovJfdwZ97Y6ET6XzBgy7J1GASZ1Jro1W4595YOm?=
 =?us-ascii?Q?c2JOHGHuwUXbM7K0aTczMg6YCaS/MvTb4yCL/YvCWSH4QEthiRNpOV/JhV6O?=
 =?us-ascii?Q?ncBpG4YcMYqWiGYllPItiiNnxb+HHIjFqBkOiTDwQpB0fXeC80oCXU90FRpj?=
 =?us-ascii?Q?hWAYQ0V0JCX9Z+8jNmoPgsebOKC0/j2QFlvkgsQ6Vc70pu2k/5PH2aawGcn7?=
 =?us-ascii?Q?E+QPHvqx4c9PkjQ4HlxWnkz6+TlBcaeHt/F9Ax+IEuu31/kvy/rUpfd0nCpu?=
 =?us-ascii?Q?wDemhmoXHFtrihJUtzWOaiD/1d8n4hgj2d2QouKNcNO3KwaXqZ1STmvHvm41?=
 =?us-ascii?Q?ZvChFAl4UcYhyh+JfHP+Sp7q8iiRywo3sVCVCV4mDtuFaVXXScFOg7d9fHvs?=
 =?us-ascii?Q?Ewlfi1akDhvyrXdll6/K+GPDZsc4qV/6jM5qK6aiaPxd28EiqfgyoGJE32ML?=
 =?us-ascii?Q?5msJSIVGoi810rmrnaAk=3D?=
X-Microsoft-Antispam-Message-Info: O3RBCPGgIkgieC4Pfe8uvgGtyQjZl64XKtcIi3K411ZqOGxOV4YIhDFOgblPi4grH0fOVKj53qhK39o0dSfnaLeGwzGCpv8XdSG9PCqbJJ8mF7EodagDK1Gj4lR9rTBxRivrvOeaN+zPA9NBEkmEFBSVo1aJOAVIE2VPHrQvZn9psF//hNG7cpQkNKJym8tbHZY0BJrOIZuPKxyotRdnmoFW96bPc22uYIJGATn5EP6jusa+5SaB1kK9Ki97Rw0cfg7O3MYB8yqgKsY+lZ2l06Mp/vDVVl/OPM5Gn9qOcUq26zd9A4ehxvOZPEyFT0C6oYLk52egKnbJBWkjkXdEjmoVRU3n7QgQT0nF2uEyTMQ=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:6PbVP3I8+Tu537l/KNq7wEVC5jCE5tpO0I3gZjq+HtoL5cow3LQKci54T9zFiexQCvqx/eWTxxZUF6w4YVZVat9N0d5AIEkJI5nYq2z5bkeNYkD33LT+QUedRQwOmPnXiuWk3TvfGQifB/48rUgBNoaLhW6U/UbuYtcgAaFoRBNg4HEOz6fFuGSyN872lNyk9tUV9EfSZDVwM8GKhaiAnwc07yYgIDn4fcA209f8adz4pCc7SonnpjieldgxGt5s+n/P2QxPP5R4enVqMt9ihGbjJSQDaxxj2I8bCQm6n2X99sGi473CyAdJ9jgCU9h2IR1aHGIZy1Z4odI1pcbu9QwxrHDV6NZzC5g8ssWAhYFnz6y4RZtYWW4lV2maUf8Gf5ntfS8IbiEq2+DFEf7U5kbmJPX9m0EOW0a8tl2mLJzQq3NxQ6c8ElJVT3KICJZQNP+g0aEHZ9xbZ1G3sVo5Yw==;5:0CY8wcze9BJ6NGUhKLG13Pl/kvWWkRfyecsP/aRwoPpVAiM2WUFBIYWeu24RhxpeVsbjUIfSYrnoTkX93lVyE2l6tzvxTylZ+4DDPuQMJVyJipvG3yx/gICj72EOD0c5Lxe7VAOkkBS9CUpLGCBdZW0pMtRenVz2bVddDZboomo=;7:PbVoXGF50pqyyU+AJTSG48FhmBmhFlcJTNOTkNKCJQ8EzNqL0cQvFdZQG5GU9eBRdp1z+7xkj/c/wl5mit2jPBZ04K+DWxhx/eSwM0xgpugfcTXbPKYH4jHXFfTYHoTuBF/NAV9jsNLvzi4FwhfjYgSVsFBoor7yhFoA+GVCCLs/GInidFUXj0pZ6TQBDVWRKxSueBsvaoAFYWMJcJaIW0MyBWmPTrgPDx07LaTCFiUIZ8dADp4Ns/4FSjBRnmqP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:33.5309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2040a436-3927-4611-1f19-08d5f0ab5d47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Since we've changed the SMP boot mechanism (by having the new kernel handle
all CPUs), now remove (relocated_)kexec_smp_wait.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/include/asm/kexec.h      |  2 --
 arch/mips/kernel/machine_kexec.c   |  5 -----
 arch/mips/kernel/relocate_kernel.S | 39 --------------------------------------
 3 files changed, 46 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index a8e0bfc..33f31a8 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -41,9 +41,7 @@ extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
 void default_machine_crash_shutdown(struct pt_regs *regs);
 #ifdef CONFIG_SMP
-extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
-extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
 void kexec_smp_reboot(void);
 extern void (*_crash_smp_send_stop)(void);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index b3674f7..1679408 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -27,7 +27,6 @@ int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 #ifdef CONFIG_SMP
-void (*relocated_kexec_smp_wait) (void *);
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
 
@@ -142,10 +141,6 @@ machine_kexec(struct kimage *image)
 	printk("Bye ...\n");
 	__flush_cache_all();
 #ifdef CONFIG_SMP
-	/* All secondary cpus now may jump to kexec_wait cycle */
-	relocated_kexec_smp_wait = reboot_code_buffer +
-		(void *)(kexec_smp_wait - relocate_new_kernel);
-	smp_wmb();
 	atomic_set(&kexec_ready_to_reboot, 1);
 
 	kexec_smp_reboot();
diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
index c6bbf21..14e0eaf 100644
--- a/arch/mips/kernel/relocate_kernel.S
+++ b/arch/mips/kernel/relocate_kernel.S
@@ -100,45 +100,6 @@ done:
 	j		s1
 	END(relocate_new_kernel)
 
-#ifdef CONFIG_SMP
-/*
- * Other CPUs should wait until code is relocated and
- * then start at entry (?) point.
- */
-LEAF(kexec_smp_wait)
-	PTR_L		a0, s_arg0
-	PTR_L		a1, s_arg1
-	PTR_L		a2, s_arg2
-	PTR_L		a3, s_arg3
-	PTR_L		s1, kexec_start_address
-
-	/* Non-relocated address works for args and kexec_start_address ( old
-	 * kernel is not overwritten). But we need relocated address of
-	 * kexec_flag.
-	 */
-
-	bal		1f
-1:	move		t1,ra;
-	PTR_LA		t2,1b
-	PTR_LA		t0,kexec_flag
-	PTR_SUB		t0,t0,t2;
-	PTR_ADD		t0,t1,t0;
-
-1:	LONG_L		s0, (t0)
-	bne		s0, zero,1b
-
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-	.set push
-	.set noreorder
-	synci		0($0)
-	.set pop
-#else
-	sync
-#endif
-	j		s1
-	END(kexec_smp_wait)
-#endif
-
 #ifdef __mips64
        /* all PTR's must be aligned to 8 byte in 64-bit mode */
        .align  3
-- 
2.7.4
