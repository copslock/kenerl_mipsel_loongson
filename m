Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 21:23:15 +0200 (CEST)
Received: from mail-eopbgr680122.outbound.protection.outlook.com ([40.107.68.122]:5440
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994606AbeGCTW1vOJ6f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 21:22:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwPuD5dnR/jaVS/JG4KUqU7OcZduWDS4Tirzzgu21sA=;
 b=BnP1D6isd6QPOj/HFnAckU5fOJnUQXVxKd7iK4vkUQfHuS4NUoGkYDwLWnMul+n24/wZUUkpbmrnWXNU5tk7RJFjw/3Il+3N/eXsWdbkRZsYnC2CnzJmhSJ/nvw8NWDpmecFTMAHAFYZVkTuoiJlQMFcP1FJ9bIkXCRTD3IGDlk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2154.namprd08.prod.outlook.com (2a01:111:e400:c611::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 19:22:09 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH 3/4] MIPS: kexec: Deprecate (relocated_)kexec_smp_wait
Date:   Tue,  3 Jul 2018 12:21:46 -0700
Message-Id: <1530645707-30259-4-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
References: <1530645707-30259-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0100.namprd06.prod.outlook.com
 (2603:10b6:4:3a::41) To CY1PR0801MB2154.namprd08.prod.outlook.com
 (2a01:111:e400:c611::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b00cbb70-3d5a-4663-ec80-08d5e11a460a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2154;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;3:adTHlfLbjeMuE6bvksGQUwU5NytMFl8a5/ZUcgQsd61bsujwOpJCPVJJQPZOZOirPs8npXaVZzbWnP14+yxy3mSxeyJC1IDJ6mdEXrCpbEKboLw3schgzDtvmDoSZlvcAtMBkgPRHZhm/q9bULRH9XDYxHR6kVZFsUfLoSLguQNDoex98L1GcfExO06fQdzpNCuVh6KB76LZmg1DKS7rpV6qDd5GD1rnpHydiN4euDdGFi/kkxuSAltyw0lmzI7Q;25:zqg+2SWbz8EtF/eqU5YpZsbefnf7Out6sNGxqskBSWJmXRHHKekKg+8OHzZeyKp7/7Zhsjv57BHQjW7/34CJJ4OiUE3/DvTzPinK7QXLNiWNTnTH5EI30hUJE/TcEURdW9sAOPsAXJaYBDnnkXJif5jKCVQPGeQYoaJ+MguUKL2hA69h/ZI7Lt7tJ2lQUWyM/8vV1QsvJ2D8k4BkKvnx9BjgvGPJJ70g0iYWdcogEdxfNvPrl8MsmXwl+BXKs4R64lbljhXQkwN15bqfKbDNdPfJ3jLwWUE6nSS598q+yhmZ29W+a+KqKYcowrC03vxKJolmpT9FtosAc7mBmDJADA==;31:2fg7rt1KIALUSjrvIySps1HTChMcZkAyKo7Q6BFbk4I72yY7rzNRFUCaVe0GJdLUU2nERhD3FGTBIrP+jM0N9fsJuzNUkC8yZ0yYsrrTtl2l6wZWlj7nU4WD1rmYN6wW4fCDLjMA9Qoj9vda9xAj9LCprgxdY1/xgaSTd50iSEVi1lVwc67nIUEEZCbfBQLTj86WT3skifMILQBXsFtuTYvXAFlO6H0CVjLm7wTAexs=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2154:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;20:UMewr1Ike+g085Q+G9PBq/6aZQOepw46uWbD0T/2+NgKtbYrzdqjx/X5Ht7AEo7+fJy828mJhpXDBc4gg07g4kDya3mWjp4vHTfxEBRNYy/7CNJnNoKLpEpYD19EphOLmWkUc1OxtcyKvakyH2xmDD5YCNpqtlkuW1Pkkl0tMtfVutNngzKCAvOyt499S4aYHado5MYDNtHcjDSzarGX4Kkg0Ij2FDca8I2kX87qWyOd+mzcr0zeO0hNCa6a7/JY;4:Rkj8ccLquptc21TuhQQdRlbr5AnwWw9Yq0BfK//rh7B201OEqJdmxgaBBQS5QE3tI66gH2oHv5uYmjU/YYueOSI/o1Lof5gM0xt57j9oTbfTpgcm4xJSrz9WBYbxsey0wysSXxWbksPPTEtBqFK75umSi+wroY3uX5vj5xbMrKMxNd9gbQ4YSkepxj0/9HAON2wDo9NRuOnXJLDjVnj2CtVbqV9RfKl//d/JrKhi3f4QanM1We2KMreVtla1zZmvykFzIje1xwwBDVuU70xI1w==
X-Microsoft-Antispam-PRVS: <CY1PR0801MB215423835EE76132C3CB3334A2420@CY1PR0801MB2154.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR0801MB2154;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2154;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(376002)(366004)(199004)(189003)(476003)(68736007)(478600001)(81156014)(81166006)(8676002)(97736004)(305945005)(486006)(11346002)(6116002)(3846002)(446003)(956004)(8936002)(69596002)(6512007)(2906002)(86362001)(2616005)(316002)(16586007)(575784001)(6486002)(25786009)(6506007)(66066001)(50226002)(4326008)(53936002)(47776003)(107886003)(450100002)(53416004)(5660300001)(51416003)(52116002)(105586002)(7736002)(37156001)(386003)(16526019)(26005)(36756003)(106356001)(50466002)(6666003)(76176011)(48376002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2154;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2154;23:7VFMtlJKZwirTzpM2QdplNzvEB2qJBsopcVHnND?=
 =?us-ascii?Q?PnUEzb5svqIGeGrKok+VrYiSoClltcsR0HdGF/w0CxBQL6pX0Lp05c99N5tm?=
 =?us-ascii?Q?AwVyi2YW/HQsqNA1xwVfifYPDFw53qETf8GAyUDvbHQKOcpTN/816swir79Z?=
 =?us-ascii?Q?05lgCfb1h3Wk5xij+oo0t5jXLRnQmLZ5x2HThRdXZCVBli9yp1BkaYKXMfgK?=
 =?us-ascii?Q?h74YWc/frnkyRd5m5A4ITK1aZQvS98GELqR7EAnkZ7tFq9b4By/Fowhh5g5v?=
 =?us-ascii?Q?OAswVNpH3+UvgVZkuggr03DRlS3WQTwlm+cse1RBCllpoypOwSFrZMlXibr8?=
 =?us-ascii?Q?dHLB70LkEWKGxt9Qw9rr1LFsG7Jqt0LMGAorpRPtB24MQGaU5qEjNzR+GxU5?=
 =?us-ascii?Q?XVQfo+BQT/JmzOs5z7652zYKBmbPhPoFhHh42b2s4nUhQ6AQCeo1V6tPyhRj?=
 =?us-ascii?Q?WHw3vtt0UJpejyPf1Vl1mBYmefU1NdWtZOLrjIeOvvlUBUisucWVIpPRKTkp?=
 =?us-ascii?Q?8DcrQcd7jAEguWyooFCN2E7hsxkd8a31jIddu+PLZaC8ozrwZdR4Dg5NKiTV?=
 =?us-ascii?Q?hD+XXW6vKUZecrhc4s6t3xr+7EYUIWEaF+BPyIFoPszfq7mDXpFfrb1TMiQA?=
 =?us-ascii?Q?twS6B1oyw4zLfCvNn3alF6LYGXQtFxSbSJ1hK+DlUneQLNSVTQFGQuy47hzX?=
 =?us-ascii?Q?iF62jNiipLT/h5Ls82MsO+1VolqnPErkt+T60pLCq4xvOA0Qd8dbB8pZ7QCL?=
 =?us-ascii?Q?vKu9wzr9Aw9J2dJQr6uNXXm78EJho2oPBTBi12I8BDU1xRx+Wfcxeb+XaJ79?=
 =?us-ascii?Q?qKHHc8B5YZz+srur67Eb6hnnEP4Y5g9+z/UoowLXAQSBiq6fiGdi6nDhM4mG?=
 =?us-ascii?Q?Q1oGBu8Wsa3zGoSNtjXAXoe7a6MTpXPsqD1uaGcVjRNdrvSz9DUReYinx6d0?=
 =?us-ascii?Q?ObDQK3pLKQ4VBaa7jCi3mBxW9/9tPgltCp42vTviVNLYetbUMe9MJmqr3S6V?=
 =?us-ascii?Q?y3ZQewR+4EKe79W8yCwK101nGR90diD7qXhuOOco7WzlhKhM+Vj3i2sap8ai?=
 =?us-ascii?Q?RIsTDYAdib8z7bxDxYgTGlMskfA04qJcbIDt1qRWUNqZwIYLYxS9ojBmxxgF?=
 =?us-ascii?Q?zEKodreCbLzBjB/IhNTfh7HxvA1MC/Gib6VWcEp813sPrV8FLUloSyeJLPxh?=
 =?us-ascii?Q?dve9ILXmWJC1rOLz3vBJIFdiNCGeQBFN9k6BRvB2ygzbCk9M84/ZcQFgxhde?=
 =?us-ascii?Q?1Uj2acyqb/zxDUkV0RkCR3LvDNUup/WVwGkZ70gWJ?=
X-Microsoft-Antispam-Message-Info: UoNM8JSY8A4EIWeGLH7G3O8m9qddHT09Eyv9PRO39s0UG2qNSF+sELMkKeC3Xe/s4J0hPM2EgKJL50ODjiyT0SaBodS8hbc5h/mQiE0iuv8p5UIC9vb+1q9dvRZaijYjnI25eI3EyGEsuSlr7IG5f5P1PQ9jogjmqTSBpEeijSoNnuVByOvIsgC3hjHBkJQGiNQLTy6GSp5R8yyVbK8K4NGfNw+6wXUdw4Vbr0KzPypLIgLeSFE43su25Cqj89Ytxm+5ucbt/f/0+DjJrfH8tFxjVoQxKb4JHfrDUi/y+H4ZUZZfrKSy9wJAlyJLx9nNy3uCDesQAQfI7Dq0UR9NDlNcoYus/DVA33vDTeylkrk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;6:PtpOEMMh27PBkrdryAp6WZFnKtnbjC1aWZgFHPXyccs6RMn+DJ6SPBXEEzkyqyoVKyY2guZo1XEgHqHDa56kMcSkUEXyGGcbnGvdQn4jX3x6rZlwBMQfmx20KFwNBe2NdRI/zSgXNe+XCCkvA4uhlnPrLpmSOZa0wqbldUt7ROm3Pf4zhctbveMfjPCzxzutH+U5ABvOtoqdQGuiqjNpgcEJ4Ef5TJFNt6y/erMXPMaq5HpS5UN0uOiLmOdR6ACFtE3twbc9FJOSBAOrMKn0fVLLqYaXL0cEmO7ZGpQhViAqVpXbAfV05hZjYUeHtcqxTy5jVX/QRnbfft4PMzeFqdrayBuPA2xzTa3hbbuZAvh7Bw64XV8cQVEGWtGMpIs7/XwfR0YavpLoEvbN+z03Z9gHqD8sVT392VL3tduQ7774R/qE8DoJ1Oj4IJYS24AtapuwL5lZxsPvg5h0R0Tz0g==;5:+c94M+AvAGi82U4OqQOx0NO4ggLeitiHozp0h4OEA7gnPl924htXO4kTS5J9WAD/DApM24gGzkwcxTr8Z8Vtm2Cn777Df+Nb34JfLbSZC3wuL2uaKXdu//11dTWLztZv137Mr71/10kIG0R97RgYgeJEjZMmbJTLugBl52TRoaE=;24:tcCjLy8KnHI3qXO/XmDsR3/tikCukXB80qDwBeFRdb5mv+TSaXNkiYqaQ+UcdSJIrt7A0xotA8deONy2/KpzVZEXFTRZpZcEw/x+MZcCeAw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2154;7:YRyac22tCKc8yKEFM1UR/GnzbYgRhZ9SgPLNOa1oyiEmDDYbukbpsZLTeFoLN1GLMVH4E7gh/nwlaJqYiUKNNq3fAL66rHJ5wi4MhPMvBrSwzcmivelLawI6py6IJDY3n0P/f6SRoRahVFCyiK0N8B0i0JJfwlyW4dlWZ9DFqTq8lzEUo/Zl9tScqGo6amwlQvnyEdy4MOKoodKRB8BlgY1qiYZ5mGTPn64CJsGi9/by2UJzjLbEoVygl/AX877Q
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:22:09.9630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00cbb70-3d5a-4663-ec80-08d5e11a460a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2154
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64587
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
index 02146ad..48c06c2 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -28,7 +28,6 @@ int (*_machine_kexec_prepare)(struct kimage *) = NULL;
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
