Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 03:28:56 +0200 (CEST)
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:48896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993891AbeGLB2WhYntt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 03:28:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUX1hDdHtvc+kU3hE5NCo6eO+EP9sn9yiz/poY9xBfw=;
 b=Nq4f6M0CjaltmmhQAhSclqs6YzYoJAbvPZ980Y5Bsah3amryQLOHE5L+n7EyJR4JFVtobRNgVnzrKGAVU1gFqtQ2pSfIPGtkA5i3Cc6gJtSL331v5I7X45tuskVrlczVpoBr8S7K/9GOdgVonvpAiUOEoguH7grQ60oE+fYcV0I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from localhost.localdomain (73.162.151.67) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 01:28:12 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v2 3/6] MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
Date:   Wed, 11 Jul 2018 18:27:45 -0700
Message-Id: <1531358868-10101-4-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
References: <1531358868-10101-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [73.162.151.67]
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7107fd35-22c0-49ed-c845-08d5e796bbe3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:og50nOh5Oqc+XL3nZQVrG+4kNcXLfsKo6tR7N/tYaRnbekP/qCwvyfpP16gIxsC/QGnuvrl3GAvej/T7tnAM2AUkOyOM2giGf0flU2IlIOHR0Amj3nBhpEORC1caB/JwBMZ4mDCxXOHbdKlW0vLwaBCn/DPuGNV988ICbHlZId/MLH2IXwYFFGe8iJfVw6oJT2is/jXclqcegA9CU/mvZ7oRDYvqTxLtPPjmcycm6U89+kydAxMtIv+UnIf3B9B+;25:TGDEHladFHA2c72u76KuGg3SJUzRUmlJume+jaQkAoBN47Ec0MQvG8tVHQna9o4+t2EJFCSFAOyQt94VM5p5aW//qI77CrTJ/jxyauHir6DMIJ8G2h98k2H6a56NExKXZXlnkcXjhaNzj6V/9TzBBJhhwwTC6eEa684JjtNOMCxTAzsXtWXatzxzMc3BqRzHJ9D9pRy4OJSgHuMBBsITEUifU5/how3m84EwIA3w/Wgw/mAnzd7cARh4DMs9GXWDtZFbgKVD+2+ZLFHL5wGB7BIfYli6zQSUp9bMY/vMXrRByNN3VMjS696fFWUUVVKEz7OHjcsFJbGMRXUUq6p6AA==;31:HZcvawxGaHYeMed92GkNtOgqIx4ymEtHrhmq+oB4zxM7CoahbXnCz3JZW8aAC5n7dphSD1fApjN2ntfDZiEZ8sNGOZqf5kn+0cx1MXfta1v7PDRAb4GnMjKpryCKHkGNwu8WlJQRfNUGywQi223h9s5Pc9h7MejvUP1+pARQfNPb0h0VwlZcjfXUuB6uKTTEuEiS/4r9DuI9koOSTPLTOZinzFVtg5qlfQQEKzb4rLk=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:8MIJVbaM9oAAoDvQQtDauyHaSJVNuyk3nNgKDZOaash1uvUAW+dN3df5Lcj/FdSsRUmMgygeUEtmsxJjOqli6lvf8aZlCu0z2KnDnTJCyPUWPl4OZysINpj4EPvAG7r+AUCxZL3swx2bN7cR2Wn4cv4njSLT1whfO1KX4naBwHLggzehsQWyJqjammthB+IYYc9E4InyNiLkwLfphw/CZiMArr7LUIHenWcVfJqnY4jkCijt1ZhfPaoNm9O8lcAm;4:Fkc5w0iJusm52vFHuoOxcHzvRxTTv3whA3mEF4xeSLet2cqTqtooLbBAXeDB1DUDfJ1RitJY+T287QYBQEDB6mBkL2e4TtFFwoVnHkG6p8TJH9+4VAITFb4vPoTI9KEAry0fvJZ4flZduu7aprkcuN0emL5vIoM9Er/zNeswwmRaFIUkKm2v1pmeYwJMtWOr6ZEZ26ANRqg0X0iEkpqNE7jqV95CX5g4WUsxVoH0L1wasOwkGqRszhE9TfTJ5T514kyKiKUBx2V4JbBRADii3A==
X-Microsoft-Antispam-PRVS: <CO2PR0801MB21517A005488F49456742E3DA2590@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(386003)(6506007)(26005)(16526019)(86362001)(575784001)(446003)(486006)(11346002)(476003)(2616005)(956004)(36756003)(106356001)(6666003)(2906002)(6116002)(3846002)(305945005)(5660300001)(68736007)(7736002)(478600001)(6512007)(97736004)(50466002)(8936002)(8676002)(25786009)(4326008)(6486002)(107886003)(450100002)(81166006)(48376002)(81156014)(16586007)(105586002)(76176011)(51416003)(52116002)(66066001)(316002)(50226002)(53936002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0801MB2151;23:KY+3k/P/+PfB+fRHI5DJIWHmcgQgHKxkTKo1wQV?=
 =?us-ascii?Q?hKbr2P12IqFDQ10TKSDUxLkV8Lbgu+AZykOCUesBPtrgoDLuYdtRDhKW1cYM?=
 =?us-ascii?Q?/Qgt0iSG2TsxGsTgrkGWAP3Aylrfq8tOCpjn4Apn9MQ+TeEjT283VUSFkOrW?=
 =?us-ascii?Q?EqRcr0vZeHRmGaJSenNJpOp9WN7nUPb/u9SIav2h+X811r1+DUsfp2+5KfSw?=
 =?us-ascii?Q?+H8/Oz34hEjsGCXEo3NdnKwY5ZEVczPdw44z60pIeJ+JzcamWfRp0nNdcdQz?=
 =?us-ascii?Q?CajGpKZkfj2NRVTjVgGFp+noRAd7/fh3/kS9SAm1Pl83Nn6JOakErTJr2dWT?=
 =?us-ascii?Q?NBOx6TvU8i3lyKHGbJZr/EtdYTrTIOyVeP+7AkgJusEcFhBRePN28GLdYkhb?=
 =?us-ascii?Q?7cFCT3ZtVNpUyjCVx3vtLRwDueWkvcQP4y57XMX1bsMVIsklJSSKFkzXnzR6?=
 =?us-ascii?Q?vp7lzD4354k5kf+OdMcEMfjIpDwWhxwzwXVCJ1WSQdVBGKNssykm7VStnBSW?=
 =?us-ascii?Q?LmShLumZSLxkspZOaIdO3F2FrfXFZy+OCyaqj9yZIUUyYLj9hTpf+pzvuvbx?=
 =?us-ascii?Q?n0s7sswpfnVJjImxONAlW7xepEut8JbbU21nnRGQhsxEuVFJ6stDNzP4bNQX?=
 =?us-ascii?Q?SuhwuP2F1dEnnb0Ot0iD4pBvZ2HPhcoJ3EuRLjFM6X0NruhR8LYZl4Bgh8a7?=
 =?us-ascii?Q?9o9d2ilsy7HBguE0HYxgAHs0HMFo5Zk0LOl8X/DfLuFImHhr+Q8i1pjOWkTr?=
 =?us-ascii?Q?DJJoV8zlX+SCS/ifQ+w399XO4+1tcebOgQMD99DkTLiuaVVi5qtXMMDtTj2E?=
 =?us-ascii?Q?EAv7bn3Xm1bZByT7twi3B4RzW5XfMs+P9EHMqBfpmyEtMRgHwBjYijH7en/V?=
 =?us-ascii?Q?xnmZNTp+IX0Udplmlshz+RWnYdNjCf8447Mt/gDe2zKGZR5DOz+8IgOQ0XbH?=
 =?us-ascii?Q?LiVxYvcqB+IcJzLH+86ImahdOwpK4I3omjLh4AuXSDzPYbwVDB4j4i7PZocd?=
 =?us-ascii?Q?2CKNLQVBfFCsJ/s1C5Xa2ZkfxoZ2On9jgnEO3lvqubuxNwxdkclSdfkKTgtS?=
 =?us-ascii?Q?nWcifZMTYXUjuKf5+LAbNuwdEc7P1KZ+kJc80+S+2DcjmL5C1SHlEAKVpQEn?=
 =?us-ascii?Q?oB61Xt6jSigGsZWpbwr6P1bFAWKIQwC97ryeFjQQ5grpjXQpBOksisc9vYxx?=
 =?us-ascii?Q?lRkaHR0GU349y56zCtbbHSo0XtIxuCLzkSPwhlrFz2ZU0UW4Rbvqjg4uWqg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: SyEqTHCoK7ShJNUQV56Zr5VU6ycIRwwItyJfZ6QY56I9qgiDD/9CUVssFYxtmJFY6jKAopmcqAvc2h9Yx4DdgepS+mFGTX0BHKaucqSO3sh01SxX7ZKaGcEmW1bmZcDt0QAMpiwV/pD5wAsahQ05dyKU9GomCSP9sovVpUVKzn+ZfAdCGReJTt7/K5tr6Lss9PY3taD4mYLUSeB65WI9u5Poyq5MAemN0Vks2lQfhUC3BHginwho+kgc2/jz4CVjH0zWl4/PJ+gOABd2jgcXuAtCDiVrcFQEnn1ZEXjFFvasIme45mrK2Wb1c6LhuzA0Udcyfe5CSJptdO6sGN5JU3Bp8ZYw+tvZlhka/GQxIiE=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:k+Lyk+F/7nOuPYb8cSyd5wsH7hN2wO7ppOr3yMwwkPX9C8oEqPjAPl9xOfpmGMrCQGD0yWfO7E9vZyPouXOOJG1mw8nU2GhdV0dnS/cWxVM7xhxTNUicZI1C8dBnzi60Us0g9IBLwJl4JQ/RyW3FdV/QNY3A1oJCjzsNfu0Lb/8tjvbzvmKYI//KgeFeFvg+cjSnOY9b1pAOYEFmd49YYKyc14vYj2fDPa+Ikie/PpPs99Hf5y6TudCizDosmi931Z1y1Id/1OpoLgurUNR+gEmWfV0PEcvau4H0g4EVy022I80lWnoqilpZYQJc6qTr5Dpu7wnkTUkc/UokQ55FoXxgqhGjkRR/G68IBtM5cY0h97M/ju8JutjOWBVNFdoCxCsrL/THueLaUZDQqSpetY/j+uZQF0tssHGhIuM/LEx+xQKZmNxuFE6WhhG0ADjxzG/12cGRAzFXt9ZAwy64+Q==;5:MarpN6vcyCYMXGgQ9+Se0vDCzn0MbjthfljyOQsgS8MyLR4O1kPAUkr8hJ9xRCgHJctMxc6JkcCn0tpd3L1zYlprCZ3LgFe067RfqcswE2pH88H/22pMx61+6rkcJiX9B/d8KxDS9gM15dxZoVunAkimuincISPTBQfB7FMJdWo=;24:qs+GUWxWNNt9QgSc+uCdSegmTYr0VhjPS3yVKEdOE+clLXz/OsVrSUpHEEZS8TT5jc11zEXLrgMBvbeuKKmN3w046M+Smi4jW5Fs/ndsCwc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;7:/B3pfcFlhgE5E81kBR6HJYIdBTM+0gpYapbSioAeUfVL42I9OzykK2QycyOiniBW5gD3xLcqAHEzbQAk+7Y5sRhMzwKqbpAQiBoWSEpHuOa59w1Gm3J4hce/vPIwWXwyYDl5PdbvumPVRLLYKe8iUBN0rA75Sn4IA5av02ABz9VGiN2OhjCKmsrDeYtbflLNzmA9qIAI9tBxqoHGepeJxNsvevyV0IeARs445MdDatNFRgW0HDFYxCzFKbJni69s
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:28:12.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7107fd35-22c0-49ed-c845-08d5e796bbe3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64811
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

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/include/asm/kexec.h      |  2 --
 arch/mips/kernel/machine_kexec.c   |  5 -----
 arch/mips/kernel/relocate_kernel.S | 39 --------------------------------------
 3 files changed, 46 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 8f1d0ef..9618e2e 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -41,9 +41,7 @@ extern void (*_machine_kexec_shutdown)(void);
 extern void (*_machine_crash_shutdown)(struct pt_regs *regs);
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 #ifdef CONFIG_SMP
-extern const unsigned char kexec_smp_wait[];
 extern unsigned long secondary_kexec_args[4];
-extern void (*relocated_kexec_smp_wait) (void *);
 extern atomic_t kexec_ready_to_reboot;
 extern void kexec_smp_reboot(void);
 extern void (*_crash_smp_send_stop)(void);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 7111fa8..31da6f2 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -27,7 +27,6 @@ int (*_machine_kexec_prepare)(struct kimage *) = NULL;
 void (*_machine_kexec_shutdown)(void) = NULL;
 void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
 #ifdef CONFIG_SMP
-void (*relocated_kexec_smp_wait) (void *);
 atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
 void (*_crash_smp_send_stop)(void) = NULL;
 
@@ -141,10 +140,6 @@ machine_kexec(struct kimage *image)
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
