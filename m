Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:55 +0100 (CET)
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:44352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992926AbeKGXOKtUmUU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5WZu8bMcgLiYiag4JJ1YBe0+m1ni6136kBzZpclo7k=;
 b=iEKJJ0T1zQvRMFZTR0vJQg7Wa+4u9QSEb07zvTo111VUXCDpMcwrMbXPFkl7FnjD4FTH8sukE0vCLFOF1S4hlTipSFTHv4UGj2yZC5b2SauIFXAHnfGG1SCNcpaw4ZuouZqiH8zb5QyvcMIWwg0vKGlMIsCAWyIbnPkNGVWCIxA=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:08 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 15/20] MIPS: signal: Remove FP context support when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 15/20] MIPS: signal: Remove FP context support when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+Vg6YKa6xoZ0qoaKKUEcK+qg==
Date:   Wed, 7 Nov 2018 23:14:08 +0000
Message-ID: <20181107231341.4614-16-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:avGsSTBpLxRUSRGosK+vmaVg7hmeGnIJElh4Zh5gUNbm6ziOJkVNy+mhCgP+Qw2xJUe2SU3v7oubDkTGUNHCvSWAyJSjqLOYSV0CN3LopBTmDu2WMvUTlKI2/IsmiHILAvCqGfCYUhgSG6c7/Kb3D3wacljBOveLqUGH7m68ET9oEP6wooVja4dYhG7cvYQK+obo+W5k/VjY4Jfj8Bv7g9J8xfzLGwgxFH2mdwXEq9awM/zgCcqQflJ4gnUjAK5BrQhTG+Koz8hOJMJ/BS/gJaIl8Y789jStO2t6KaYxV/x+DgbiPhLnKcu1sbXqm0GasQM3gDKSak4tb5aosxdbFO39OD4+Q9Ql5vcCa3uQn6OeowTsSdD8MBMh++Jim/wlW1wpzISsYty+1TgUEVMuedHM08xDfyHJMINzAGI6jajwUvs88fW6JJV5Z0tmcgFimLK10vnzTxHZDFVGx7YjhA==;5:HRumGP+4xoamg79zNdhXWxEn3qwLRPKVp8Hwx2dhbOL+hpTx3XNfyVqDinO2yYiKvEVe6t16WrnAKreS6ig+KE00KtbH8VsQ5RX22PSuOPUMg168abWosCSH+144lh8HEDnkBlSJtotgJFtaa3qCPGmct4Dk8gLo3uGQ0nUkog0=;7:u+WIWFc/Lfwp8N4dOITX9iC30ccqnHPoXtpeDnxOdmP7gXmiHesDvqV7QfqcAzg8+LuXwyPvwXuu4kywTQP8JFbDu1ZNbuCrdZMNjEj60+0PUVeFNk9VxUlp5cA7QqVTPayMZntUbxw67zIxFv+8Gg==
x-ms-office365-filtering-correlation-id: 45d9adda-687e-43ab-910b-08d64506b81a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB15668EDFC594F7BBDCF38844C1C40@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(66066001)(2501003)(386003)(6512007)(53936002)(8936002)(6486002)(81156014)(81166006)(2906002)(3846002)(25786009)(6436002)(6116002)(71200400001)(102836004)(2900100001)(5640700003)(97736004)(1076002)(99286004)(476003)(4326008)(106356001)(186003)(42882007)(52116002)(105586002)(6916009)(71190400001)(2351001)(44832011)(36756003)(76176011)(6506007)(107886003)(508600001)(8676002)(68736007)(305945005)(316002)(5660300001)(11346002)(2616005)(14454004)(26005)(256004)(14444005)(486006)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IFZoZpRbDLZA3QDljFWN4vjGNERNN6WenQTDwdNTd2aDVp8295/dE4FW7lhyZJgJDNwwW52mQKoPZroONU4lKtJjSGcmfvMjcQ3R2nWmZrvlXNlWcAiOWR+J8kdyYek0JKEEYjrPnZi0wDqzVpRJqeR+EXzqp1EfB6y8I0jgxTXoP53oEHDyEzlRh1FpX0CTRrFGoCeNaFCCfr8jv1EbJrGdb5wZR2CaUZWrn5977VRExXM+skrD2Qetj7adz8AdfNKD9o08f6GlesslIRJOyQuzEDPyGPTBTjMvOn41JM9NTODfgJhBhGsRc0DV/OD3bTu22c16GSQO6cuBz7XW4KhsDbjqhusH4MoaAIoHlz4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d9adda-687e-43ab-910b-08d64506b81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:08.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67149
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so
there's no need to save & restore floating point context around signals.
This prepares us for the removal of FP context from struct task_struct
later.

Since MSA context is a superset of FP context support for it similarly
needs to be removed when MSA/FP support is disabled.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/signal.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 109ed163a6a6..d3a23758592c 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -62,6 +62,8 @@ struct rt_sigframe {
 	struct ucontext rs_uc;
 };
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 /*
  * Thread saved context copy to/from a signal context presumed to be on the
  * user stack, and therefore accessed with appropriate macros from uaccess.h.
@@ -104,6 +106,20 @@ static int copy_fp_from_sigcontext(void __user *sc)
 	return err;
 }
 
+#else /* !CONFIG_MIPS_FP_SUPPORT */
+
+static int copy_fp_to_sigcontext(void __user *sc)
+{
+	return 0;
+}
+
+static int copy_fp_from_sigcontext(void __user *sc)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_MIPS_FP_SUPPORT */
+
 /*
  * Wrappers for the assembly _{save,restore}_fp_context functions.
  */
@@ -142,6 +158,8 @@ static inline void __user *sc_to_extcontext(void __user *sc)
 	return &uc->uc_extcontext;
 }
 
+#ifdef CONFIG_CPU_HAS_MSA
+
 static int save_msa_extcontext(void __user *buf)
 {
 	struct msa_extcontext __user *msa = buf;
@@ -195,9 +213,6 @@ static int restore_msa_extcontext(void __user *buf, unsigned int size)
 	unsigned int csr;
 	int i, err;
 
-	if (!IS_ENABLED(CONFIG_CPU_HAS_MSA))
-		return SIGSYS;
-
 	if (size != sizeof(*msa))
 		return -EINVAL;
 
@@ -234,6 +249,20 @@ static int restore_msa_extcontext(void __user *buf, unsigned int size)
 	return err;
 }
 
+#else /* !CONFIG_CPU_HAS_MSA */
+
+static int save_msa_extcontext(void __user *buf)
+{
+	return 0;
+}
+
+static int restore_msa_extcontext(void __user *buf, unsigned int size)
+{
+	return SIGSYS;
+}
+
+#endif /* !CONFIG_CPU_HAS_MSA */
+
 static int save_extcontext(void __user *buf)
 {
 	int sz;
@@ -880,7 +909,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	user_enter();
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS_FP_SUPPORT)
 static int smp_save_fp_context(void __user *sc)
 {
 	return raw_cpu_has_fpu
@@ -908,7 +937,7 @@ static int signal_setup(void)
 		     (offsetof(struct rt_sigframe, rs_uc.uc_extcontext) -
 		      offsetof(struct rt_sigframe, rs_uc.uc_mcontext)));
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MIPS_FP_SUPPORT)
 	/* For now just do the cpu_has_fpu check when the functions are invoked */
 	save_fp_context = smp_save_fp_context;
 	restore_fp_context = smp_restore_fp_context;
-- 
2.19.1
