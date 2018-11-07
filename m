Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:51 +0100 (CET)
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:44352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992925AbeKGXOKR6UNU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vsNK52848jjrCOwcfMdqX+yX4/rK/zbS/pPu9bWHe0=;
 b=CHrd0Soxbd082b+FMDKJ637QHrQaMZTVNlSmDBV9APbePh2QN1M3C4q66qgH3ukTyApM6Hia3w1A8dWjkXmvQK3dtUMuo5HKVEalzw9NBHpfjmy5pGQKvS2bwgkLmm9ABJjLJyT/LN/4Q7wJLv88h9XG1Rb4uisY1ZZqjTNWkYo=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:08 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 14/20] MIPS: ptrace: Remove FP support when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 14/20] MIPS: ptrace: Remove FP support when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+VxA2g3JeF6U2B+uOcArsJcg==
Date:   Wed, 7 Nov 2018 23:14:07 +0000
Message-ID: <20181107231341.4614-15-paul.burton@mips.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:+hoar3In7l1AnOQpwgsM4DgTxd/pE1CDyp1vjQF1TpE16ptgf9VeYkT8wqfT4Cb+hG0scQPbwZmIGF3hbI/234RR3FO0c+2mCl2iKvUeVEjJxrmhNx2KveMHz+d7+VmZnpncvMZm2wvu0e3iY05CDjRI8hnu9DcOnly1ET+qhW/6eNP56kLBeRlvyAeaqYyaAH8XpzDHxIihlT1cuClf6d3dvPUXEiuBsaGIvbUQZZngxDy8LR+s+gNrSS6H5KhBtzb3ZMuk2MljXX19JhlKENwq5JOry7OcV+UDVlazZapTeGs7ZOGJPIbxeZQiESs3IjS6X0MdWeQcuWd6hA+o/c41tuACZGqRMn8gJ0D8SVOAOLg/HZ6MfSdrp2Xw/8v2zKNPfke5OsdjHqW+aRiffizrQiWgPS2hcDKmb0HoOfL0zgQPmC99Qtngu/gNPL4RLfoHS5PtgCm3WhiQiOOi1A==;5:CzjMcKL9N8gB8Htr32BOOGpahHPJoJ0jeZGx2hIcG8pfZ5Zl7i0bNP+ERVdzbFchSAYRen3cu6p3nrc0QkWt+eAEsRi5ljbl5JKuxBDEa7BSpycPAUt129px0uHzSPCd1vCE2VSjtFErqVr0oFBwZoWDUI1ZbZ4SNY3Lzg/drcE=;7:zEmjiMSMA4XctPbAbn0mEiYBhjvFQtX/obBW1RUKMt9gjeI3dZcMXpzGBTqJajHbYO0leUL+FakivGIsu+E1DGikREWpGYN2/LnK0wEnbdnKFdZ9CTn2DXb9oj2FBuafzOjAMzyBNb/8xyJPKDRs0A==
x-ms-office365-filtering-correlation-id: bb2f63da-5934-42a4-35a4-08d64506b7af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB1566795576B4602FBE78AA12C1C40@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(66066001)(2501003)(386003)(6512007)(53936002)(8936002)(6486002)(53946003)(81156014)(81166006)(2906002)(3846002)(25786009)(6436002)(6116002)(71200400001)(102836004)(4744004)(2900100001)(5640700003)(97736004)(1076002)(99286004)(575784001)(476003)(4326008)(106356001)(186003)(42882007)(52116002)(105586002)(6916009)(71190400001)(2351001)(44832011)(36756003)(76176011)(6506007)(107886003)(508600001)(8676002)(68736007)(305945005)(316002)(5660300001)(11346002)(2616005)(14454004)(26005)(256004)(14444005)(486006)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: snaLd/hG4n5p/pz3uKwdx4IaZADFB7qZd+tVemtIP560OHsP14rLq9GQIO1d5mnvaDcW19H5DBB+UXejQKM4qhV0bzbiGtSHUy4+cpWzLsYkz+4pnS5a9c/bNrD9TKN4BefXcWRRFcYSsXr0+K8M1RM9HJHs/gMx/H/2aabaGZiV3XWS4IOhKNhQVMtb56+GIJENmoGMoihC9mvzcg/u1iQvZjT+gwsZQmpZN4fpV8qXJQW7lBM+YoDH3G9fr7D+LoLJRFJgYARpPPdxSdokAg6CjEsY6Fu79/GbrklyhbEfg5Hvq3ctWCCBUd9D2BC9nMrExtlvt6OZuy+9KgAPXfIIfkndVASZQFUfzQ42dBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f63da-5934-42a4-35a4-08d64506b7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:07.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67148
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so remove
the related ptrace support. Besides removing code which should not be
needed, this prepares us for the removal of FPU state in struct
task_struct which this code requires.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/ptrace.c   | 300 +++++++++++++++++++-----------------
 arch/mips/kernel/ptrace32.c |  33 ++--
 2 files changed, 179 insertions(+), 154 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 04db951b0f8c..d7d032f2b656 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -61,21 +61,6 @@ void ptrace_disable(struct task_struct *child)
 	clear_tsk_thread_flag(child, TIF_LOAD_WATCH);
 }
 
-/*
- * Poke at FCSR according to its mask.  Set the Cause bits even
- * if a corresponding Enable bit is set.  This will be noticed at
- * the time the thread is switched to and SIGFPE thrown accordingly.
- */
-static void ptrace_setfcr31(struct task_struct *child, u32 value)
-{
-	u32 fcr31;
-	u32 mask;
-
-	fcr31 = child->thread.fpu.fcr31;
-	mask = boot_cpu_data.fpu_msk31;
-	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
-}
-
 /*
  * Read a general register set.	 We always use the 64-bit format, even
  * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
@@ -132,55 +117,6 @@ int ptrace_setregs(struct task_struct *child, struct user_pt_regs __user *data)
 	return 0;
 }
 
-int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
-{
-	int i;
-
-	if (!access_ok(VERIFY_WRITE, data, 33 * 8))
-		return -EIO;
-
-	if (tsk_used_math(child)) {
-		union fpureg *fregs = get_fpu_regs(child);
-		for (i = 0; i < 32; i++)
-			__put_user(get_fpr64(&fregs[i], 0),
-				   i + (__u64 __user *)data);
-	} else {
-		for (i = 0; i < 32; i++)
-			__put_user((__u64) -1, i + (__u64 __user *) data);
-	}
-
-	__put_user(child->thread.fpu.fcr31, data + 64);
-	__put_user(boot_cpu_data.fpu_id, data + 65);
-
-	return 0;
-}
-
-int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
-{
-	union fpureg *fregs;
-	u64 fpr_val;
-	u32 value;
-	int i;
-
-	if (!access_ok(VERIFY_READ, data, 33 * 8))
-		return -EIO;
-
-	init_fp_ctx(child);
-	fregs = get_fpu_regs(child);
-
-	for (i = 0; i < 32; i++) {
-		__get_user(fpr_val, i + (__u64 __user *)data);
-		set_fpr64(&fregs[i], 0, fpr_val);
-	}
-
-	__get_user(value, data + 64);
-	ptrace_setfcr31(child, value);
-
-	/* FIR may not be written.  */
-
-	return 0;
-}
-
 int ptrace_get_watch_regs(struct task_struct *child,
 			  struct pt_watch_regs __user *addr)
 {
@@ -401,6 +337,73 @@ static int gpr64_set(struct task_struct *target,
 
 #endif /* CONFIG_64BIT */
 
+
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
+/*
+ * Poke at FCSR according to its mask.  Set the Cause bits even
+ * if a corresponding Enable bit is set.  This will be noticed at
+ * the time the thread is switched to and SIGFPE thrown accordingly.
+ */
+static void ptrace_setfcr31(struct task_struct *child, u32 value)
+{
+	u32 fcr31;
+	u32 mask;
+
+	fcr31 = child->thread.fpu.fcr31;
+	mask = boot_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+}
+
+int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
+{
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, data, 33 * 8))
+		return -EIO;
+
+	if (tsk_used_math(child)) {
+		union fpureg *fregs = get_fpu_regs(child);
+		for (i = 0; i < 32; i++)
+			__put_user(get_fpr64(&fregs[i], 0),
+				   i + (__u64 __user *)data);
+	} else {
+		for (i = 0; i < 32; i++)
+			__put_user((__u64) -1, i + (__u64 __user *) data);
+	}
+
+	__put_user(child->thread.fpu.fcr31, data + 64);
+	__put_user(boot_cpu_data.fpu_id, data + 65);
+
+	return 0;
+}
+
+int ptrace_setfpregs(struct task_struct *child, __u32 __user *data)
+{
+	union fpureg *fregs;
+	u64 fpr_val;
+	u32 value;
+	int i;
+
+	if (!access_ok(VERIFY_READ, data, 33 * 8))
+		return -EIO;
+
+	init_fp_ctx(child);
+	fregs = get_fpu_regs(child);
+
+	for (i = 0; i < 32; i++) {
+		__get_user(fpr_val, i + (__u64 __user *)data);
+		set_fpr64(&fregs[i], 0, fpr_val);
+	}
+
+	__get_user(value, data + 64);
+	ptrace_setfcr31(child, value);
+
+	/* FIR may not be written.  */
+
+	return 0;
+}
+
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer,
  * !CONFIG_CPU_HAS_MSA variant.  FP context's general register slots
@@ -571,6 +574,54 @@ static int fpr_set(struct task_struct *target,
 	return err;
 }
 
+/* Copy the FP mode setting to the supplied NT_MIPS_FP_MODE buffer.  */
+static int fp_mode_get(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       void *kbuf, void __user *ubuf)
+{
+	int fp_mode;
+
+	fp_mode = mips_get_process_fp_mode(target);
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
+				   sizeof(fp_mode));
+}
+
+/*
+ * Copy the supplied NT_MIPS_FP_MODE buffer to the FP mode setting.
+ *
+ * We optimize for the case where `count % sizeof(int) == 0', which
+ * is supposed to have been guaranteed by the kernel before calling
+ * us, e.g. in `ptrace_regset'.  We enforce that requirement, so
+ * that we can safely avoid preinitializing temporaries for partial
+ * mode writes.
+ */
+static int fp_mode_set(struct task_struct *target,
+		       const struct user_regset *regset,
+		       unsigned int pos, unsigned int count,
+		       const void *kbuf, const void __user *ubuf)
+{
+	int fp_mode;
+	int err;
+
+	BUG_ON(count % sizeof(int));
+
+	if (pos + count > sizeof(fp_mode))
+		return -EIO;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
+				 sizeof(fp_mode));
+	if (err)
+		return err;
+
+	if (count > 0)
+		err = mips_set_process_fp_mode(target, fp_mode);
+
+	return err;
+}
+
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+
 #if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
 
 /*
@@ -740,57 +791,13 @@ static int dsp_active(struct task_struct *target,
 	return cpu_has_dsp ? NUM_DSP_REGS + 1 : -ENODEV;
 }
 
-/* Copy the FP mode setting to the supplied NT_MIPS_FP_MODE buffer.  */
-static int fp_mode_get(struct task_struct *target,
-		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       void *kbuf, void __user *ubuf)
-{
-	int fp_mode;
-
-	fp_mode = mips_get_process_fp_mode(target);
-	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
-				   sizeof(fp_mode));
-}
-
-/*
- * Copy the supplied NT_MIPS_FP_MODE buffer to the FP mode setting.
- *
- * We optimize for the case where `count % sizeof(int) == 0', which
- * is supposed to have been guaranteed by the kernel before calling
- * us, e.g. in `ptrace_regset'.  We enforce that requirement, so
- * that we can safely avoid preinitializing temporaries for partial
- * mode writes.
- */
-static int fp_mode_set(struct task_struct *target,
-		       const struct user_regset *regset,
-		       unsigned int pos, unsigned int count,
-		       const void *kbuf, const void __user *ubuf)
-{
-	int fp_mode;
-	int err;
-
-	BUG_ON(count % sizeof(int));
-
-	if (pos + count > sizeof(fp_mode))
-		return -EIO;
-
-	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fp_mode, 0,
-				 sizeof(fp_mode));
-	if (err)
-		return err;
-
-	if (count > 0)
-		err = mips_set_process_fp_mode(target, fp_mode);
-
-	return err;
-}
-
 enum mips_regset {
 	REGSET_GPR,
-	REGSET_FPR,
 	REGSET_DSP,
+#ifdef CONFIG_MIPS_FP_SUPPORT
+	REGSET_FPR,
 	REGSET_FP_MODE,
+#endif
 };
 
 struct pt_regs_offset {
@@ -888,14 +895,6 @@ static const struct user_regset mips_regsets[] = {
 		.get		= gpr32_get,
 		.set		= gpr32_set,
 	},
-	[REGSET_FPR] = {
-		.core_note_type	= NT_PRFPREG,
-		.n		= ELF_NFPREG,
-		.size		= sizeof(elf_fpreg_t),
-		.align		= sizeof(elf_fpreg_t),
-		.get		= fpr_get,
-		.set		= fpr_set,
-	},
 	[REGSET_DSP] = {
 		.core_note_type	= NT_MIPS_DSP,
 		.n		= NUM_DSP_REGS + 1,
@@ -905,6 +904,15 @@ static const struct user_regset mips_regsets[] = {
 		.set		= dsp32_set,
 		.active		= dsp_active,
 	},
+#ifdef CONFIG_MIPS_FP_SUPPORT
+	[REGSET_FPR] = {
+		.core_note_type	= NT_PRFPREG,
+		.n		= ELF_NFPREG,
+		.size		= sizeof(elf_fpreg_t),
+		.align		= sizeof(elf_fpreg_t),
+		.get		= fpr_get,
+		.set		= fpr_set,
+	},
 	[REGSET_FP_MODE] = {
 		.core_note_type	= NT_MIPS_FP_MODE,
 		.n		= 1,
@@ -913,6 +921,7 @@ static const struct user_regset mips_regsets[] = {
 		.get		= fp_mode_get,
 		.set		= fp_mode_set,
 	},
+#endif
 };
 
 static const struct user_regset_view user_mips_view = {
@@ -936,14 +945,6 @@ static const struct user_regset mips64_regsets[] = {
 		.get		= gpr64_get,
 		.set		= gpr64_set,
 	},
-	[REGSET_FPR] = {
-		.core_note_type	= NT_PRFPREG,
-		.n		= ELF_NFPREG,
-		.size		= sizeof(elf_fpreg_t),
-		.align		= sizeof(elf_fpreg_t),
-		.get		= fpr_get,
-		.set		= fpr_set,
-	},
 	[REGSET_DSP] = {
 		.core_note_type	= NT_MIPS_DSP,
 		.n		= NUM_DSP_REGS + 1,
@@ -953,6 +954,7 @@ static const struct user_regset mips64_regsets[] = {
 		.set		= dsp64_set,
 		.active		= dsp_active,
 	},
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	[REGSET_FP_MODE] = {
 		.core_note_type	= NT_MIPS_FP_MODE,
 		.n		= 1,
@@ -961,6 +963,15 @@ static const struct user_regset mips64_regsets[] = {
 		.get		= fp_mode_get,
 		.set		= fp_mode_set,
 	},
+	[REGSET_FPR] = {
+		.core_note_type	= NT_PRFPREG,
+		.n		= ELF_NFPREG,
+		.size		= sizeof(elf_fpreg_t),
+		.align		= sizeof(elf_fpreg_t),
+		.get		= fpr_get,
+		.set		= fpr_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_mips64_view = {
@@ -1021,7 +1032,6 @@ long arch_ptrace(struct task_struct *child, long request,
 	/* Read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
 		struct pt_regs *regs;
-		union fpureg *fregs;
 		unsigned long tmp = 0;
 
 		regs = task_pt_regs(child);
@@ -1031,7 +1041,10 @@ long arch_ptrace(struct task_struct *child, long request,
 		case 0 ... 31:
 			tmp = regs->regs[addr];
 			break;
-		case FPR_BASE ... FPR_BASE + 31:
+#ifdef CONFIG_MIPS_FP_SUPPORT
+		case FPR_BASE ... FPR_BASE + 31: {
+			union fpureg *fregs;
+
 			if (!tsk_used_math(child)) {
 				/* FP not yet used */
 				tmp = -1;
@@ -1053,6 +1066,15 @@ long arch_ptrace(struct task_struct *child, long request,
 #endif
 			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
+		}
+		case FPC_CSR:
+			tmp = child->thread.fpu.fcr31;
+			break;
+		case FPC_EIR:
+			/* implementation / version register */
+			tmp = boot_cpu_data.fpu_id;
+			break;
+#endif
 		case PC:
 			tmp = regs->cp0_epc;
 			break;
@@ -1073,13 +1095,6 @@ long arch_ptrace(struct task_struct *child, long request,
 			tmp = regs->acx;
 			break;
 #endif
-		case FPC_CSR:
-			tmp = child->thread.fpu.fcr31;
-			break;
-		case FPC_EIR:
-			/* implementation / version register */
-			tmp = boot_cpu_data.fpu_id;
-			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
 
@@ -1130,6 +1145,7 @@ long arch_ptrace(struct task_struct *child, long request,
 				 mips_syscall_is_indirect(child, regs))
 				mips_syscall_update_nr(child, regs);
 			break;
+#ifdef CONFIG_MIPS_FP_SUPPORT
 		case FPR_BASE ... FPR_BASE + 31: {
 			union fpureg *fregs = get_fpu_regs(child);
 
@@ -1149,6 +1165,11 @@ long arch_ptrace(struct task_struct *child, long request,
 			set_fpr64(&fregs[addr - FPR_BASE], 0, data);
 			break;
 		}
+		case FPC_CSR:
+			init_fp_ctx(child);
+			ptrace_setfcr31(child, data);
+			break;
+#endif
 		case PC:
 			regs->cp0_epc = data;
 			break;
@@ -1163,10 +1184,6 @@ long arch_ptrace(struct task_struct *child, long request,
 			regs->acx = data;
 			break;
 #endif
-		case FPC_CSR:
-			init_fp_ctx(child);
-			ptrace_setfcr31(child, data);
-			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
 
@@ -1202,6 +1219,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		ret = ptrace_setregs(child, datavp);
 		break;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	case PTRACE_GETFPREGS:
 		ret = ptrace_getfpregs(child, datavp);
 		break;
@@ -1209,7 +1227,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	case PTRACE_SETFPREGS:
 		ret = ptrace_setfpregs(child, datavp);
 		break;
-
+#endif
 	case PTRACE_GET_THREAD_AREA:
 		ret = put_user(task_thread_info(child)->tp_value, datalp);
 		break;
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index bc348d44d151..2525eca9c962 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -82,7 +82,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	/* Read the word at location addr in the USER area. */
 	case PTRACE_PEEKUSR: {
 		struct pt_regs *regs;
-		union fpureg *fregs;
 		unsigned int tmp;
 
 		regs = task_pt_regs(child);
@@ -92,7 +91,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		case 0 ... 31:
 			tmp = regs->regs[addr];
 			break;
-		case FPR_BASE ... FPR_BASE + 31:
+#ifdef CONFIG_MIPS_FP_SUPPORT
+		case FPR_BASE ... FPR_BASE + 31: {
+			union fpureg *fregs;
+
 			if (!tsk_used_math(child)) {
 				/* FP not yet used */
 				tmp = -1;
@@ -111,6 +113,15 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			}
 			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
+		}
+		case FPC_CSR:
+			tmp = child->thread.fpu.fcr31;
+			break;
+		case FPC_EIR:
+			/* implementation / version register */
+			tmp = boot_cpu_data.fpu_id;
+			break;
+#endif /* CONFIG_MIPS_FP_SUPPORT */
 		case PC:
 			tmp = regs->cp0_epc;
 			break;
@@ -126,13 +137,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		case MMLO:
 			tmp = regs->lo;
 			break;
-		case FPC_CSR:
-			tmp = child->thread.fpu.fcr31;
-			break;
-		case FPC_EIR:
-			/* implementation / version register */
-			tmp = boot_cpu_data.fpu_id;
-			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
 
@@ -203,6 +207,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 				 mips_syscall_is_indirect(child, regs))
 				mips_syscall_update_nr(child, regs);
 			break;
+#ifdef CONFIG_MIPS_FP_SUPPORT
 		case FPR_BASE ... FPR_BASE + 31: {
 			union fpureg *fregs = get_fpu_regs(child);
 
@@ -225,6 +230,10 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			set_fpr64(&fregs[addr - FPR_BASE], 0, data);
 			break;
 		}
+		case FPC_CSR:
+			child->thread.fpu.fcr31 = data;
+			break;
+#endif /* CONFIG_MIPS_FP_SUPPORT */
 		case PC:
 			regs->cp0_epc = data;
 			break;
@@ -234,9 +243,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		case MMLO:
 			regs->lo = data;
 			break;
-		case FPC_CSR:
-			child->thread.fpu.fcr31 = data;
-			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
 
@@ -274,6 +280,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 				(struct user_pt_regs __user *) (__u64) data);
 		break;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	case PTRACE_GETFPREGS:
 		ret = ptrace_getfpregs(child, (__u32 __user *) (__u64) data);
 		break;
@@ -281,7 +288,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	case PTRACE_SETFPREGS:
 		ret = ptrace_setfpregs(child, (__u32 __user *) (__u64) data);
 		break;
-
+#endif
 	case PTRACE_GET_THREAD_AREA:
 		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned int __user *) (unsigned long) data);
-- 
2.19.1
