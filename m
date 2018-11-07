Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:11 +0100 (CET)
Received: from mail-eopbgr680094.outbound.protection.outlook.com ([40.107.68.94]:46351
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992893AbeKGXOCDyDBU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+T8jVHv4zuty+1+fXrvzFy+AI3CD1kv1DLFEAU1XdI=;
 b=SHeVfBhiokXu69gl0TdjN1Qza7z8Bxdx8VsuU7BPmQpJk9f64QOAxgAAgAK1Rh1moghGvudChJX14uiR7yIbRSIUVnWGcgez+oBj280ji9TLy7E7TT0GboIsWllxFs88xQ8heC6l+bypbzpB5ptHk8jo0ixBeL0vb69YFVJgO+A=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:13:59 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:13:59 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 03/20] MIPS: Simplify FP context initialization
Thread-Topic: [PATCH 03/20] MIPS: Simplify FP context initialization
Thread-Index: AQHUdu+Q+y18LWV790ecF/fC6y2liQ==
Date:   Wed, 7 Nov 2018 23:13:59 +0000
Message-ID: <20181107231341.4614-4-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:VETXYTEwt11FskgwMzymNB+Tc3gKYILeKeN/iTdmJjeSqES/cgqFexxZ/ECLdkLa6uClwQNoe+ejTvMN2FYDce5StJpljsFqzlsiSJLly0Mn7yUjtW4uGISpAeCjmMaO6HlRRY3ziYzhJeXhfdMK0fMUCQpHh4axS0BioFR5abrmCtG59Qn2tHQ0S8WpYVprofPl0VWVCKItGflkbP8bUNbv5cCyMDeHY1tsz/LV/nJfev4zmQ9YagXxbioSR5aa9ueRM6ZvST6twiZV3SFYAZc8o3chpzZPY2mIeYv7REfdrEKWDQIWHJkp7D+dsnyxjtoSar92QcYO/F8sAy6ZGD9ZoM4op8ksGBp95kRffQ4YUNFyEaxgFNag8vpCqe4aH+Nf/NTPTl3YFUGN3hU0EX9H3b0/Un2jtWfDHXoTkNnkTbNYYrHdG5SWH4PI7xEHkgsIef7kAh9/mW96tVT86A==;5:B1RI/ibPgBfq/un5AUYPJFfdC8PGtK+NmuxNwKC/uIkfSx6Kf3SyMm7bIZxpDcDXIYC/GoWab/13lI4qPrhzlgCygycowooVXPUUfHsfZMu/apOFUSWS8Lo3Aj3IEC0nAJrOt4A1tHKthJVDdEJX+T+qkZ7g7CFx44oVVNXEKgw=;7:HkC5dYPAR+T5ocw7IOpocLUFlpfiyyNAsrfUNaEmUZRMy6OwZ19C7hIkQ961GlE96AgyYjaQS5Zo/HXt/CLh7Vb3kzpmDl1rEZgEDyPAPDy6YIZtNebshQh/J2uX3PoSgtDDBblkk1BtS2bAUNWy2Q==
x-ms-office365-filtering-correlation-id: 13fce310-469e-4aec-be94-08d64506b2e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472EF6D31BE718596B02EC0C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(4744004)(14444005)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(575784001)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sVm0zm5ianLTMqPT/RnLUNJPU4R8Rba9LGg0eEOevibcVPO3eFFbCEwWDtPv0aX8h7xlOcMlvqSHR0PYw60EX7/fDxdxvhjl9tHfKOMpKIf4W6olIww1RpfBJEq7ivd2ajDRZk+WBFLthLvRI+oocqx1GEqTVVzhpC3rUtR70F1fPxh2mo5FEwStPGQCElOFrLHW1MMjeSQ2osNuiWD14zZVzeHuBuayxG0LUkfVIy4blcpOiaoZ6DdEC4DB8WK2HjsfQgpbb0MxIhA+4qb/7dMi353zH2JfKLP4sUsIdFT2O2vh9CRLnc8yogNjzi/efVOhdLVMnbe9oM+5WP+PexJK5lGTDcwmHWF6HHY3pUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fce310-469e-4aec-be94-08d64506b2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:13:59.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67139
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

MIPS has up until now had 3 different ways for a task's floating point
context to be initialized:

  - If the task's first use of FP involves it gaining ownership of an
    FPU then _init_fpu() is used to initialize the FPU's registers such
    that they all contain ~0, and the FPU registers will be stored to
    struct thread_info later (eg. when context switching).

  - If the task first uses FP on a CPU without an associated FPU then
    fpu_emulator_init_fpu() initializes the task's floating point
    register state in struct thread_info such that all floating point
    register contain the bit pattern 0x7ff800007ff80000, different to
    the _init_fpu() behaviour.

  - If a task's floating point context is first accessed via ptrace then
    init_fp_ctx() initializes the floating point register state in
    struct thread_info to ~0, giving equivalent state to _init_fpu().

The _init_fpu() path has 2 separate implementations - one for r2k/r3k
style systems & one for r4k style systems. The _init_fpu() path also
requires that we be careful to clear & restore the value of the
Config5.FRE bit on modern systems in order to avoid inadvertently
triggering floating point exceptions.

None of this code is in a performance critical hot path - it runs only
the first time a task uses floating point. As such it doesn't seem to
warrant the complications of maintaining the _init_fpu() path.

Remove _init_fpu() & fpu_emulator_init_fpu(), instead using
init_fp_ctx() consistently to initialize floating point register state
in struct thread_info. Upon a task's first use of floating point this
will typically mean that we initialize state in memory & then load it
into FPU registers using _restore_fp() just as we would on a context
switch. For other paths such as __compute_return_epc_for_insn() or
mipsr2_decoder() this results in a significant simplification of the
work to be done.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/fpu.h           |  57 +++++-----
 arch/mips/include/asm/fpu_emulator.h  |  11 --
 arch/mips/kernel/branch.c             |  12 +--
 arch/mips/kernel/mips-r2-to-r6-emul.c |  10 +-
 arch/mips/kernel/ptrace.c             |  19 ----
 arch/mips/kernel/r2300_fpu.S          |  58 -----------
 arch/mips/kernel/r4k_fpu.S            | 144 --------------------------
 arch/mips/kernel/traps.c              |  12 +--
 8 files changed, 36 insertions(+), 287 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index a2813fe381cf..84de64606ccf 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -33,7 +33,6 @@
 struct sigcontext;
 struct sigcontext32;
 
-extern void _init_fpu(unsigned int);
 extern void _save_fp(struct task_struct *);
 extern void _restore_fp(struct task_struct *);
 
@@ -198,42 +197,36 @@ static inline void lose_fpu(int save)
 	preempt_enable();
 }
 
-static inline int init_fpu(void)
+/**
+ * init_fp_ctx() - Initialize task FP context
+ * @target: The task whose FP context should be initialized.
+ *
+ * Initializes the FP context of the target task to sane default values if that
+ * target task does not already have valid FP context. Once the context has
+ * been initialized, the task will be marked as having used FP & thus having
+ * valid FP context.
+ *
+ * Returns: true if context is initialized, else false.
+ */
+static inline bool init_fp_ctx(struct task_struct *target)
 {
-	unsigned int fcr31 = current->thread.fpu.fcr31;
-	int ret = 0;
-
-	if (cpu_has_fpu) {
-		unsigned int config5;
-
-		ret = __own_fpu();
-		if (ret)
-			return ret;
+	/* If FP has been used then the target already has context */
+	if (tsk_used_math(target))
+		return false;
 
-		if (!cpu_has_fre) {
-			_init_fpu(fcr31);
+	/* Begin with data registers set to all 1s... */
+	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
 
-			return 0;
-		}
-
-		/*
-		 * Ensure FRE is clear whilst running _init_fpu, since
-		 * single precision FP instructions are used. If FRE
-		 * was set then we'll just end up initialising all 32
-		 * 64b registers.
-		 */
-		config5 = clear_c0_config5(MIPS_CONF5_FRE);
-		enable_fpu_hazard();
+	/* FCSR has been preset by `mips_set_personality_nan'.  */
 
-		_init_fpu(fcr31);
+	/*
+	 * Record that the target has "used" math, such that the context
+	 * just initialised, and any modifications made by the caller,
+	 * aren't discarded.
+	 */
+	set_stopped_child_used_math(target);
 
-		/* Restore FRE */
-		write_c0_config5(config5);
-		enable_fpu_hazard();
-	} else
-		fpu_emulator_init_fpu();
-
-	return ret;
+	return true;
 }
 
 static inline void save_fp(struct task_struct *tsk)
diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index b36097d3cbf4..7e233055f7b4 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -188,17 +188,6 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		     unsigned long *contpc);
 
-#define SIGNALLING_NAN 0x7ff800007ff80000LL
-
-static inline void fpu_emulator_init_fpu(void)
-{
-	struct task_struct *t = current;
-	int i;
-
-	for (i = 0; i < 32; i++)
-		set_fpr64(&t->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
-}
-
 /*
  * Mask the FCSR Cause bits according to the Enable bits, observing
  * that Unimplemented is always enabled.
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index e48f6c0a9e4a..74f12a91bfb4 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -674,16 +674,8 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		if (cpu_has_mips_r6 &&
 		    ((insn.i_format.rs == bc1eqz_op) ||
 		     (insn.i_format.rs == bc1nez_op))) {
-			if (!used_math()) { /* First time FPU user */
-				ret = init_fpu();
-				if (ret && NO_R6EMU) {
-					ret = -ret;
-					break;
-				}
-				ret = 0;
-				set_used_math();
-			}
-			lose_fpu(1);    /* Save FPU state for the emulator. */
+			if (!init_fp_ctx(current))
+				lose_fpu(1);
 			reg = insn.i_format.rt;
 			bit = get_fpr32(&current->thread.fpu.fpr[reg], 0) & 0x1;
 			if (insn.i_format.rs == bc1eqz_op)
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index eb18b186e858..9c1690235896 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1174,13 +1174,9 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 fpu_emul:
 		regs->regs[31] = r31;
 		regs->cp0_epc = epc;
-		if (!used_math()) {     /* First time FPU user.  */
-			preempt_disable();
-			err = init_fpu();
-			preempt_enable();
-			set_used_math();
-		}
-		lose_fpu(1);    /* Save FPU state for the emulator. */
+
+		if (!init_fp_ctx(current))
+			lose_fpu(1);
 
 		err = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index e5ba56c01ee0..04db951b0f8c 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -50,25 +50,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-static void init_fp_ctx(struct task_struct *target)
-{
-	/* If FP has been used then the target already has context */
-	if (tsk_used_math(target))
-		return;
-
-	/* Begin with data registers set to all 1s... */
-	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
-
-	/* FCSR has been preset by `mips_set_personality_nan'.  */
-
-	/*
-	 * Record that the target has "used" math, such that the context
-	 * just initialised, and any modifications made by the caller,
-	 * aren't discarded.
-	 */
-	set_stopped_child_used_math(target);
-}
-
 /*
  * Called by kernel/ptrace.c when detaching..
  *
diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 3062ba66c563..12e58053544f 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -52,64 +52,6 @@ LEAF(_restore_fp)
 	jr	ra
 	END(_restore_fp)
 
-/*
- * Load the FPU with signalling NANS.  This bit pattern we're using has
- * the property that no matter whether considered as single or as double
- * precision represents signaling NANS.
- *
- * The value to initialize fcr31 to comes in $a0.
- */
-
-	.set push
-	SET_HARDFLOAT
-
-LEAF(_init_fpu)
-	mfc0	t0, CP0_STATUS
-	li	t1, ST0_CU1
-	or	t0, t1
-	mtc0	t0, CP0_STATUS
-
-	ctc1	a0, fcr31
-
-	li	t0, -1
-
-	mtc1	t0, $f0
-	mtc1	t0, $f1
-	mtc1	t0, $f2
-	mtc1	t0, $f3
-	mtc1	t0, $f4
-	mtc1	t0, $f5
-	mtc1	t0, $f6
-	mtc1	t0, $f7
-	mtc1	t0, $f8
-	mtc1	t0, $f9
-	mtc1	t0, $f10
-	mtc1	t0, $f11
-	mtc1	t0, $f12
-	mtc1	t0, $f13
-	mtc1	t0, $f14
-	mtc1	t0, $f15
-	mtc1	t0, $f16
-	mtc1	t0, $f17
-	mtc1	t0, $f18
-	mtc1	t0, $f19
-	mtc1	t0, $f20
-	mtc1	t0, $f21
-	mtc1	t0, $f22
-	mtc1	t0, $f23
-	mtc1	t0, $f24
-	mtc1	t0, $f25
-	mtc1	t0, $f26
-	mtc1	t0, $f27
-	mtc1	t0, $f28
-	mtc1	t0, $f29
-	mtc1	t0, $f30
-	mtc1	t0, $f31
-	jr	ra
-	END(_init_fpu)
-
-	.set pop
-
 	.set	noreorder
 
 /**
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 8e3a6020c613..59be5c812aa2 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -86,150 +86,6 @@ LEAF(_init_msa_upper)
 
 #endif
 
-/*
- * Load the FPU with signalling NANS.  This bit pattern we're using has
- * the property that no matter whether considered as single or as double
- * precision represents signaling NANS.
- *
- * The value to initialize fcr31 to comes in $a0.
- */
-
-	.set push
-	SET_HARDFLOAT
-
-LEAF(_init_fpu)
-	mfc0	t0, CP0_STATUS
-	li	t1, ST0_CU1
-	or	t0, t1
-	mtc0	t0, CP0_STATUS
-	enable_fpu_hazard
-
-	ctc1	a0, fcr31
-
-	li	t1, -1				# SNaN
-
-#ifdef CONFIG_64BIT
-	sll	t0, t0, 5
-	bgez	t0, 1f				# 16 / 32 register mode?
-
-	dmtc1	t1, $f1
-	dmtc1	t1, $f3
-	dmtc1	t1, $f5
-	dmtc1	t1, $f7
-	dmtc1	t1, $f9
-	dmtc1	t1, $f11
-	dmtc1	t1, $f13
-	dmtc1	t1, $f15
-	dmtc1	t1, $f17
-	dmtc1	t1, $f19
-	dmtc1	t1, $f21
-	dmtc1	t1, $f23
-	dmtc1	t1, $f25
-	dmtc1	t1, $f27
-	dmtc1	t1, $f29
-	dmtc1	t1, $f31
-1:
-#endif
-
-#ifdef CONFIG_CPU_MIPS32
-	mtc1	t1, $f0
-	mtc1	t1, $f1
-	mtc1	t1, $f2
-	mtc1	t1, $f3
-	mtc1	t1, $f4
-	mtc1	t1, $f5
-	mtc1	t1, $f6
-	mtc1	t1, $f7
-	mtc1	t1, $f8
-	mtc1	t1, $f9
-	mtc1	t1, $f10
-	mtc1	t1, $f11
-	mtc1	t1, $f12
-	mtc1	t1, $f13
-	mtc1	t1, $f14
-	mtc1	t1, $f15
-	mtc1	t1, $f16
-	mtc1	t1, $f17
-	mtc1	t1, $f18
-	mtc1	t1, $f19
-	mtc1	t1, $f20
-	mtc1	t1, $f21
-	mtc1	t1, $f22
-	mtc1	t1, $f23
-	mtc1	t1, $f24
-	mtc1	t1, $f25
-	mtc1	t1, $f26
-	mtc1	t1, $f27
-	mtc1	t1, $f28
-	mtc1	t1, $f29
-	mtc1	t1, $f30
-	mtc1	t1, $f31
-
-#if defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6)
-	.set    push
-	.set    MIPS_ISA_LEVEL_RAW
-	.set	fp=64
-	sll     t0, t0, 5			# is Status.FR set?
-	bgez    t0, 1f				# no: skip setting upper 32b
-
-	mthc1   t1, $f0
-	mthc1   t1, $f1
-	mthc1   t1, $f2
-	mthc1   t1, $f3
-	mthc1   t1, $f4
-	mthc1   t1, $f5
-	mthc1   t1, $f6
-	mthc1   t1, $f7
-	mthc1   t1, $f8
-	mthc1   t1, $f9
-	mthc1   t1, $f10
-	mthc1   t1, $f11
-	mthc1   t1, $f12
-	mthc1   t1, $f13
-	mthc1   t1, $f14
-	mthc1   t1, $f15
-	mthc1   t1, $f16
-	mthc1   t1, $f17
-	mthc1   t1, $f18
-	mthc1   t1, $f19
-	mthc1   t1, $f20
-	mthc1   t1, $f21
-	mthc1   t1, $f22
-	mthc1   t1, $f23
-	mthc1   t1, $f24
-	mthc1   t1, $f25
-	mthc1   t1, $f26
-	mthc1   t1, $f27
-	mthc1   t1, $f28
-	mthc1   t1, $f29
-	mthc1   t1, $f30
-	mthc1   t1, $f31
-1:	.set    pop
-#endif /* CONFIG_CPU_MIPS32_R2 || CONFIG_CPU_MIPS32_R6 */
-#else
-	.set	MIPS_ISA_ARCH_LEVEL_RAW
-	dmtc1	t1, $f0
-	dmtc1	t1, $f2
-	dmtc1	t1, $f4
-	dmtc1	t1, $f6
-	dmtc1	t1, $f8
-	dmtc1	t1, $f10
-	dmtc1	t1, $f12
-	dmtc1	t1, $f14
-	dmtc1	t1, $f16
-	dmtc1	t1, $f18
-	dmtc1	t1, $f20
-	dmtc1	t1, $f22
-	dmtc1	t1, $f24
-	dmtc1	t1, $f26
-	dmtc1	t1, $f28
-	dmtc1	t1, $f30
-#endif
-	jr	ra
-	END(_init_fpu)
-
-	.set pop	/* SET_HARDFLOAT */
-
 	.set	noreorder
 
 /**
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0f852e1b5891..650b9dd05b8e 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1218,20 +1218,20 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 static int enable_restore_fp_context(int msa)
 {
 	int err, was_fpu_owner, prior_msa;
+	bool first_fp;
 
-	if (!used_math()) {
-		/* First time FP context user. */
+	/* Initialize context if it hasn't been used already */
+	first_fp = init_fp_ctx(current);
+
+	if (first_fp) {
 		preempt_disable();
-		err = init_fpu();
+		err = own_fpu_inatomic(1);
 		if (msa && !err) {
 			enable_msa();
-			init_msa_upper();
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
 		preempt_enable();
-		if (!err)
-			set_used_math();
 		return err;
 	}
 
-- 
2.19.1
