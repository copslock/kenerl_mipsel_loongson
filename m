Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 18:01:25 +0200 (CEST)
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:38103
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994641AbeIEQAKHVDIO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 18:00:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gUp+V6ruzOGOhR5dHDTuEzTKa7ZDS0VtQcph1jia/I=;
 b=nEiqazquaEdWkuX580kvOi8/oHaxl8zPBdc8qzEG1tcwmtIklMhUzvOWPUmeHAOm+JZaKFBMMkLHx9NnPTdpHGPfkI7TVnBx5mAiK3Z3mWxKx8YewnVdlPZCcMGEM0fnbOY0rgmmN4DB2q6EJkpRvHPw5WsSxVsm+Z8hmunHFDo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 16:00:01 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v4 3/6] MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
Date:   Wed,  5 Sep 2018 08:59:06 -0700
Message-Id: <20180905155909.30454-4-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905155909.30454-1-dzhu@wavecomp.com>
References: <20180905155909.30454-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:4:16::13) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 257d4525-3c50-43c4-dc95-08d61348a35b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:WAqRm/Yirvsob612EyUNixhiS1hOX9KVfT7mMH0fmiY/d6rYSsxJdJRgQbSsWdk6JiJlT8wy4V1Ozqd4ndt78EWGJGYVsxc7nUEBApVUACRizR9B1dMcqXJyuy/KIIs6GAvw2JPdVQHmIjfOvWAN1m51sPcuKsodOHWMBPQMdYSpjnIfQkYr6VyFv7yU8XFqQnFqkgiIo3rlew06knnwmfs91wZddnF8d2MELYPs9n6AeE0h4zl2xHrJ3pZ404at;25:vz6YAOyeLKWH5FqkpRYWb91OzERkrgDPVqEGsE4FzJrOd7O1E4LEH2SYzfaF0ZpDJoD9eSx1MwXjR4kypuTs/2BqCy4ZWducob64ZAm5lv4q0ub5qhJQ01aknrFw1GQWQJK8k8e+xEl8956EBua4ctliuh6ffO4poQeYv838+RDefuAm3wit3NnJW3jCvJxF9ecpj6IYTzX6E5alOv87lTtr6+gLatMaRKtBHH7O1IQl52GNYqoK1LvPUQA4HNscl19GUtB3Yi7aDKAvG6pEZG1t6PtwJ2KpG5DFTEsgi2TWbD6pOIKk0qlgtltIBAYf05k9hbUTbNrb+iJIjJc3+g==;31:zIUhf0xensN3+Uhe4/8YapFSVZdy2YACMcMTpdWqXDCaphBs9ox7YIaAtLepYKoz2b1pOksNV73qcfYVvgCqeloluwJaaFcopYhjxlOzZh00+VUO0NXTldOyK6cAg3VysH1CEilxY1L7LGoWobNAstlM5sRB+WH/2MkAVZeCw6P8ttiHVbpZRh/FJgpw80gdljp47MBSZc8k1j+gBXRAOarmX3kyp+zzZzFco5ZITQs=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:3b6niSbEbw1r4PFbkMecTdOtu1R7Re63uOfy8mqZi7QXyxeTSmvvUe28fsbsuYxtehwvJN0x6+5yYTjkRJAs2W4JtMaRnZmK9wyHRfI13cEgpN1Jem0W3YsnMay5gCL+kwp2Newf1kQKTPoTerM1ch6NrIYB8GhXU9JT4xdUZlGstSmsUQm/b1a2huZ6n4YjA+y4/kEEVVyhzez47sh/sNB5FtWiC6wf5GB9aVZn8RGYl5st5JI9gWeXJ0dYy+35;4:x9o+Y8Jzy+9T3QZUSsOZZx8URs7rH8lsVeT5OSQ7Z9GYR/nebny56K6auknmNWL8ClmQbts6LpA8oUBJ/gCde1Xe8BEOth2CyNOiV493KLIXwEljlzLxQdBCSabg654ga6v8Uv2ngN6t4uBKgl791V0Wq8nYsKehagTz6Dw3UDmaGmT1RhzMM3oqT8pDJCf6fiE8wdRNoqlCGm44FW4womq2vsSZEW3FYcaqPsAlPl+4LpAaYWbjOwXcCjHQtoDgeoaFlG4QIqP/mO87nCz0pokmXXxAViZLHDtsvDglz1rLGK9wop6iUHFZYuR5/39I
X-Microsoft-Antispam-PRVS: <BN3PR0801MB2145BDDD20A6D88DF0EB6F65A2020@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39840400004)(376002)(199004)(189003)(11346002)(956004)(476003)(446003)(486006)(16526019)(26005)(53936002)(6506007)(386003)(81156014)(81166006)(5660300001)(53416004)(8676002)(2906002)(8936002)(25786009)(48376002)(106356001)(4326008)(51416003)(105586002)(50226002)(66066001)(47776003)(68736007)(107886003)(76176011)(50466002)(305945005)(2616005)(52116002)(7736002)(316002)(37156001)(86362001)(575784001)(97736004)(69596002)(16586007)(1076002)(6512007)(6486002)(6116002)(36756003)(478600001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:/E4uqizwgwpMMfpH1w0JzMtWsKyc/3b32/qIa9n?=
 =?us-ascii?Q?5WbeSvNKbt5NUdl+fGSdXJy//avPQI+TGgTZyCyIYWZLrPVdYSKqITVJaevU?=
 =?us-ascii?Q?hrzJ9JLZkKo0QtLgdr5Frb10FzeaHes5cgH+m3JE+i++A+/8p+GPbHtQkZ8V?=
 =?us-ascii?Q?p026Z/c6tPK0BAViemk9KW6MGDJ8WMigyS13tSuxs0uS7O0lCbc9HzDHsz3y?=
 =?us-ascii?Q?widAl60C7sKe8ultoRtgrCZAoHMrykDAROAq997n+Vj30Odc+X8MS1mueCPB?=
 =?us-ascii?Q?3VhgCB86+KqG11TUpQMcNemiF3TrcllzXojJCQ4EliSbmFa7xZZxZhOLZS1e?=
 =?us-ascii?Q?QX7X1yx9EYA7s9MLGqyL1hsVmWKfujPKkENBUuZ+zOm+iWieWyYJxHROJ2jJ?=
 =?us-ascii?Q?Senr9jQax3PrRr1Btw/GgaZO5ujymNxksCw5L+kcN4IIDTxCuogBPv1SqgKv?=
 =?us-ascii?Q?vaI9rjpsTZOUvT+GjCgZTBkFVZLTyfbRDfNLJPIQbZNy/omij8j+QQSU+tLP?=
 =?us-ascii?Q?KAO2FPWnFS9S1kIS8kVHN3/PqCrdWwfkfkSlcA35b66z0GtABehpUtzTPpER?=
 =?us-ascii?Q?HmhofMSbz63ngvPPezDhlH9jPoysiSHrup0s7EePoYIjMCgFiJuP5xkoOWS2?=
 =?us-ascii?Q?OjZzCjSBXl9kIianbaAiJjGDsWLvJjNH5wEFr4ybNtpKjGuu6FvhYm1/mJCR?=
 =?us-ascii?Q?gEVzeIq1sGkx91l5LJw8y0sURdVxIqg7OMx3963YeFfkmgX3zxfgW3Zpm2/n?=
 =?us-ascii?Q?wlGShNvRfFSfw2hRiVb+gO5DLMU24Y7PQOHWvI0oyi8FV9k4OBUoeu5UIHWq?=
 =?us-ascii?Q?Y8ZLKZiZERsDDiEoEK+ARdBeWePjZPxA9+hUx0atCb8XUvEt/WZAwibyph3B?=
 =?us-ascii?Q?ZPEp4XKNn6eviYEFL5w3kq9qSlCqOmTtvP48M+7vshXEqOZsC4Ya5xYCLrxx?=
 =?us-ascii?Q?g/mG360zzIuzOOvCA9yZ9KRtzxiCkDigP6Y+kYlfXFt2o89oswhQApQyuQ+J?=
 =?us-ascii?Q?P8FK06aBzeZCNRIwaeOX1IC0/1V3qGHVlvVszt4Y8Bt+TaoftwSz/AtWAKeA?=
 =?us-ascii?Q?TSin8s5Rr3Q8iGTS/da8o5jDFyW2UhmHOcwa8aHZfIqm79x7Fff+8bF3ptcE?=
 =?us-ascii?Q?ctgQRQDhlnEiS+7IrGfsy99cfapSE5+eP/xA20d38SY+D8VknCSXgX4XVLB8?=
 =?us-ascii?Q?UVFjrIJbFfuEEkvnh2f0QN6YOlo7Lwv3Y7dEO3OwCfuZ1gbafogcHXsLHKJ1?=
 =?us-ascii?Q?gV1ydlCB5+JJHcClbA28=3D?=
X-Microsoft-Antispam-Message-Info: G0eOkmvFoQ4gX06A8E2omaKA0J4ClW7qKMpknmlcs4dCYdfIuJqUnEHv+7bLUkJOcnert5K1Kb0NssJ0lEnogz/o/XdaVwdVaf+u12CJAZu9pn5Q0Ckm7KaZUcTTuQPVqmSdw/UvFDEnFtwdmZ1LQ1YCVDp74mUpdR5+anCD981sa+xdgZl3ne5xkLlCFsnssuObOHdNbjX4u77E7e9SkTelxMfgUkq9IV0tveRbWNd48w5c9L9FL58Q0GeZ2VoXq9NgG0Bww7PlsHRwv3w1EZU0jwl827w/9shABqtz6/nHu2Gh78c0GDOZgLMEKyvDTPbvzfudDD6ythSjYjBWstzBVTpBzdrEtFksUQL2eEI=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:Ab20Y+4HvllGDjKsi5zQgm021lKBUMlxjuBDNFDGkXnfsKsIFhK3uctaQz0Gm8KZqBGp8GUQ9koVS0T5b7OwvqWi6L2stmmUs8XOhWji8/L89M1h5Z+JNbCZb+R7RtnsySjlZuOhoW3qls+/i7Lfu6SMDF8fW71Holv68uveifIt3gOZ2QHuTQCUFaUpWgFd9Jyqa32E15zRH6zICOiBXXfQ8KseUjGMjDCYaalpU9s3XMjiztTvjCNUqCzqx5yu1KEtfvGX/l5pCq6Bv0LKoD7puubJnBlyikx1TiS3/lfC8EBzdf8olhLb6pHV5yL8790f80M9QDY1a+v1zoj1TgjuPBv6q6UPYkVSxfaQ+zth4WlGoDZcu6Je/nXMoeSvROjZdM8OfCT+A0K4l0mP9/rRLGftXpB0rIN9JgVjpKFzYVDsEqQT4XX7pZMF4CEcfjEN16M9Ytgoa++YYW4saA==;5:6utADULTlnwBjZRlFo49ShvPqteBWmccfvrDDkJn1X9Sw2rxVyrzY3eWRs9xa+y45e2ShIJBXDTlyaayoinRVlv+QZEdJgO80xMTGCDEWW8iBgoMNdO2xRNFeyoq2Nprc4sXv3i14JXazlpaFUcqTVtMW9KnbkkitChcfQg8TB4=;7:f1dbCc60JyN60m8iFDXnq1aGa5w9vvwexe17AMzpEGvw+gE694wmTXezck51PTGbiYNzLJRQq2XufPwPqpF2kb8yB5g3qlyYwCZm4CLzOBkXn9ymSh5hpLAcQGb/m2Nn0i9y8aRzdGUPHsKUgITvgrLjL35m1f77Sq4DqNxTBzU5rvROWsHjIFnmAqTWv+RRv5DpmrQfWlWBfJ+fiBzqUnfNMd52Zi/CnsblvIdWZgl0NW3t41FlHcLwvs0/Ffpp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 16:00:01.3001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257d4525-3c50-43c4-dc95-08d61348a35b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65959
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
 arch/mips/kernel/machine_kexec.c   |  5 ----
 arch/mips/kernel/relocate_kernel.S | 39 ------------------------------
 3 files changed, 46 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index a8e0bfc0da19..33f31a8bd8d3 100644
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
index 900475ae256d..baffc7113204 100644
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
index c6bbf2165051..14e0eaf12306 100644
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
2.17.1
