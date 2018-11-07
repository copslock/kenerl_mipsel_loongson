Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:36 +0100 (CET)
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:44352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992872AbeKGXOIM9oeU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBWuyVh6w6IsWRBX44yuA7sYvGorAKrSUsRbXbtR/2w=;
 b=kimr02wnwnarlCQrd9MKT9VazFLIPHUbDF9zXap2N2jHdTlpwhbQVzq4MlhiUnFfMoKUwhklInqHvV4HTgDgTkdetIVtvI8MZzT/xDrFsBOaja+q/YWufUAqZxmnljteSboFFAfEyEC9eL1eXjXhJleMuPRmfxT43XUSx7VpizM=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:06 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 11/20] MIPS: traps: Never enable FPU when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 11/20] MIPS: traps: Never enable FPU when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+UKmAvy2fZLkSCBrqCQNT4MA==
Date:   Wed, 7 Nov 2018 23:14:05 +0000
Message-ID: <20181107231341.4614-12-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:7oZ5OoF1Zakzi8i8rRNp/1FGcz24oNb9z70br5ol7jSzSeRT6nweM08WrYg1EYqUWiNLVYIFlMCosYg/HGo79Ukoxp1I3REbX2w/PdqUNuSnuFB4lFWDnest8jyItvLsqSuzNgkvekCqLT6+/h8qj3AYxpVHuqfIakJyhtuOnLZjhkBZI5qXd4mdmQ+GxQWNcPOy4N05tZFLI2pnQ95RYwK9q5mfOkME2iB1Mm95EL1oJbh+FbzjdRZ4EW3rfzVI7uGZRghO1DVfB2YSxehFg+W7TQolsfj3fdR9niizfyP32liwpXyyfEZaaHPgM/IrCcJY9vXNT31cFnbUO/NvNYX0ARxCgke4bUb2mngrNFUz5OYeFRZjWJhHxmpwsqPXFW6S4t3UxwS71zYfCvZCZM6Upsrwdgaq85haOn/Wdw4IlDfmcQARXZD7c5egrmSv2BQp7uw+FMugLYWfzMknFg==;5:jIyUkwP7KqYLLkBSUA0+YcgJx8/RDhk8NXo+txZ3X8b4sb0XXgS6jvEr0nwXMkmgdzUTP8dEJJ3DEeHamV+2mef2i5pk1DLHaObYMkQ346TyixvCYwTFyl0ZcVWOr5hGe5KPVM+FujUFxSmFFkSrZ8CCCOTCp+kMVahu4WwCyBk=;7:FJ2OT1LoIDtyHbFf6y7v1b1aeAWqaoYPlomsaKUi9lFajQCxtVChqTV0lB1opW5FPlkC2xpZWXd55hoQei3yVRrsOfTOjflqEWIRONk/kOvcF6396NtaXU+sHqTgb9UNIVe/c9oq6PzN7eueu2cIwg==
x-ms-office365-filtering-correlation-id: c66ccdc8-d41c-43e5-954d-08d64506b6ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB15665A86FEC5AFB3BF828DB2C1C40@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(66066001)(2501003)(386003)(6512007)(53936002)(8936002)(6486002)(81156014)(81166006)(2906002)(3846002)(25786009)(6436002)(6116002)(71200400001)(102836004)(2900100001)(5640700003)(97736004)(1076002)(99286004)(575784001)(476003)(4326008)(106356001)(186003)(42882007)(52116002)(105586002)(6916009)(71190400001)(2351001)(44832011)(36756003)(76176011)(6506007)(107886003)(508600001)(8676002)(68736007)(305945005)(316002)(5660300001)(11346002)(2616005)(14454004)(26005)(256004)(14444005)(486006)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NPxjvZVbfxhuqbuUvKQGUSABp5ykEN+zl+GnPYYC1ASA6h0vb+eAi5hOJjM1qJKSuWwaiaW8VCVCCE85LGJ2XdJhYU36GI5VW0KhwRwj9elQPU/mKEphvPuWYGQkBvcUjhKfkq+9qn+RfEwcmIAFh/Y9Xkyb/PPMFpgLljFWpkyjuzsVb2eGeenT+jqsp6ljT7ZazV0v4ZHOaMlH+ff3Y8cAh9gD81Asm/MHHmGCKg9l80iJU1tPur5+CB6AXODgd37GJLq7lprjFiQNNtq5/VPFvkyIFQDySeOuEH4M1jakp1m7U7IFUpPrEp6/bZu7eUSOrw1x4Yrlsk5skLbpvn2h5gIlJl4V7XERQ5bQZeg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66ccdc8-d41c-43e5-954d-08d64506b6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:05.9175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67146
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so we'll
never need to enable the FPU. Avoid doing so on a Co-Processor Unusable
exception (do_cpu), and remove the Floating Point Exception handler
(do_fpe) which should never be executed when the FPU is disabled.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/genex.S |   2 +
 arch/mips/kernel/traps.c | 100 ++++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 6c257b52f57f..6c0c0d0c30bd 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -553,7 +553,9 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
 	BUILD_HANDLER msa_fpe msa_fpe msa_fpe silent	/* #14 */
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
+#endif
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
 	BUILD_HANDLER msa msa sti silent		/* #21 */
 	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index db52d30eacec..6eb89fd95533 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -706,6 +706,8 @@ asmlinkage void do_ov(struct pt_regs *regs)
 	exception_exit(prev_state);
 }
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 /*
  * Send SIGFPE according to FCSR Cause bits, which must have already
  * been masked against Enable bits.  This is impotant as Inexact can
@@ -871,6 +873,45 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 	exception_exit(prev_state);
 }
 
+/*
+ * MIPS MT processors may have fewer FPU contexts than CPU threads. If we've
+ * emulated more than some threshold number of instructions, force migration to
+ * a "CPU" that has FP support.
+ */
+static void mt_ase_fp_affinity(void)
+{
+#ifdef CONFIG_MIPS_MT_FPAFF
+	if (mt_fpemul_threshold > 0 &&
+	     ((current->thread.emulated_fp++ > mt_fpemul_threshold))) {
+		/*
+		 * If there's no FPU present, or if the application has already
+		 * restricted the allowed set to exclude any CPUs with FPUs,
+		 * we'll skip the procedure.
+		 */
+		if (cpumask_intersects(&current->cpus_allowed, &mt_fpu_cpumask)) {
+			cpumask_t tmask;
+
+			current->thread.user_cpus_allowed
+				= current->cpus_allowed;
+			cpumask_and(&tmask, &current->cpus_allowed,
+				    &mt_fpu_cpumask);
+			set_cpus_allowed_ptr(current, &tmask);
+			set_thread_flag(TIF_FPUBOUND);
+		}
+	}
+#endif /* CONFIG_MIPS_MT_FPAFF */
+}
+
+#else /* !CONFIG_MIPS_FP_SUPPORT */
+
+static int simulate_fp(struct pt_regs *regs, unsigned int opcode,
+		       unsigned long old_epc, unsigned long old_ra)
+{
+	return -1;
+}
+
+#endif /* !CONFIG_MIPS_FP_SUPPORT */
+
 void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	const char *str)
 {
@@ -1154,35 +1195,6 @@ asmlinkage void do_ri(struct pt_regs *regs)
 	exception_exit(prev_state);
 }
 
-/*
- * MIPS MT processors may have fewer FPU contexts than CPU threads. If we've
- * emulated more than some threshold number of instructions, force migration to
- * a "CPU" that has FP support.
- */
-static void mt_ase_fp_affinity(void)
-{
-#ifdef CONFIG_MIPS_MT_FPAFF
-	if (mt_fpemul_threshold > 0 &&
-	     ((current->thread.emulated_fp++ > mt_fpemul_threshold))) {
-		/*
-		 * If there's no FPU present, or if the application has already
-		 * restricted the allowed set to exclude any CPUs with FPUs,
-		 * we'll skip the procedure.
-		 */
-		if (cpumask_intersects(&current->cpus_allowed, &mt_fpu_cpumask)) {
-			cpumask_t tmask;
-
-			current->thread.user_cpus_allowed
-				= current->cpus_allowed;
-			cpumask_and(&tmask, &current->cpus_allowed,
-				    &mt_fpu_cpumask);
-			set_cpus_allowed_ptr(current, &tmask);
-			set_thread_flag(TIF_FPUBOUND);
-		}
-	}
-#endif /* CONFIG_MIPS_MT_FPAFF */
-}
-
 /*
  * No lock; only written during early bootup by CPU 0.
  */
@@ -1210,6 +1222,8 @@ static int default_cu2_call(struct notifier_block *nfb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 static int enable_restore_fp_context(int msa)
 {
 	int err, was_fpu_owner, prior_msa;
@@ -1317,17 +1331,23 @@ static int enable_restore_fp_context(int msa)
 	return 0;
 }
 
+#else /* !CONFIG_MIPS_FP_SUPPORT */
+
+static int enable_restore_fp_context(int msa)
+{
+	return SIGILL;
+}
+
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+
 asmlinkage void do_cpu(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
 	unsigned int __user *epc;
 	unsigned long old_epc, old31;
-	void __user *fault_addr;
 	unsigned int opcode;
-	unsigned long fcr31;
 	unsigned int cpid;
-	int status, err;
-	int sig;
+	int status;
 
 	prev_state = exception_enter();
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
@@ -1365,6 +1385,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 		break;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	case 3:
 		/*
 		 * The COP3 opcode space and consequently the CP0.Status.CU3
@@ -1384,7 +1405,11 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 		}
 		/* Fall through.  */
 
-	case 1:
+	case 1: {
+		void __user *fault_addr;
+		unsigned long fcr31;
+		int err, sig;
+
 		err = enable_restore_fp_context(0);
 
 		if (raw_cpu_has_fpu && !err)
@@ -1405,6 +1430,13 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 			mt_ase_fp_affinity();
 
 		break;
+	}
+#else /* CONFIG_MIPS_FP_SUPPORT */
+	case 1:
+	case 3:
+		force_sig(SIGILL, current);
+		break;
+#endif /* CONFIG_MIPS_FP_SUPPORT */
 
 	case 2:
 		raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
-- 
2.19.1
