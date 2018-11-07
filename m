Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:27 +0100 (CET)
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:31840
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992852AbeKGXOGAc1JU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KDG3vQDk1FWlu1+aVP7mCb+pyr/pprqS/wJS4ighaQ=;
 b=cj5wYtQ4gKbzXeWJ3vnE+mWjSq2Mnu332UaDO1JEvA1T711QSEHPqivQdNE2u9ao1nHFiMCjbhQHBulSlBdg9pPknkvwLb+TypGzdvYNZGP8YrKjag0+L/kKzN10IgUrjUIQQBzXF4AQjPSR6xdhvHql2NIJZNreyGo0W5hIit0=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:14:05 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 09/20] MIPS: Stub asm/fpu.h functions
Thread-Topic: [PATCH 09/20] MIPS: Stub asm/fpu.h functions
Thread-Index: AQHUdu+TMldmzu1slUuxcGXNORUk6g==
Date:   Wed, 7 Nov 2018 23:14:04 +0000
Message-ID: <20181107231341.4614-10-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:q83xc9StDqkb8prMCyAS4UKjw6iKXMn1fSTU5p6Oj2C4qtyQMf98w4SvcEN393mhiqSsVrsP0by8k4qDhBfA1uPJTDwu8DJA4OwQERl0Sm4NR5hMWGK99yWIYkeYj+jP74/5w9JH/XcBPl/ae9ohotOGURAz6sZkBG8JDP4+B8MlBkkmPiiprv8ha5IeF5NAfkPXgaqN3OG+Do7xQpfbNofC3cmR/yDiljFYBxBsyBQ80bwfaJIjb8hVrKl8sFvm33aflwc76uwyUMWeqXLkAlc7sIpFNgfIO8Hz8m7YgF/ZLL91HxLfuaWk2r3drWQ63WozqQ1fJSY5ooIcYZHYBpqHUE51uaalV93+n1F21uRT/VhbNWHCuz3SFfVsGbgSB1xZEc336injlxV/j9oN1Y6wz4iZJVH0Bx5SkdrWM3bDM2whi5tyusQsG3l9nc9hlkK2HlMs/gWJ4LlRtOiDIQ==;5:Om+lfa4cS79IkRUa/zPE7038yOHYUHuKRT+/54G1RiRayvcaPXF4QWTENXga3yKULBi99UZC1VZQUvCwq/k/khZi5lv+5LQtTxBdLw24uAY+DMPzwRTNYus+BU+dtFDSEu2KLKV1BvkKy/a9D/Ic+/aIQNgC3E/X4d4p7F2O1Ao=;7:lOVOFLqSGpdZaKZWufk5xJHEqql21ox0Hi+2Z3Lfh7zn1pTnKK/bcVWirMmuWDT1X9w5kOk4l2L6AunViKGqqD9o0zt+FgeVSbl+KP2h9EIsXWMsVnMNCRtDjR6zTRw1+sE52JBYlBpCNJJqbhYs8w==
x-ms-office365-filtering-correlation-id: 8773350e-dee0-4485-daba-08d64506b5d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472EAC8FF3E86065A49A111C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(14444005)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(575784001)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lUohXFsvP3Eflf/YG8syfw5ZR+hQEcN6Gqk4NCrvXtpiqgdjZ6eWiOVStC0lC/LvLdpNoiAEgx2XrAO6eCVQC0tjlMfWN7xESeo/6GHtmVoGhZHzfCYW/1Oy/Fwo5W35BXJ/hPGbXGGrbSMDsBs3q8rFUh2jliK+BvtM4CRYdrhS8DW44ov9QBTMTOSdSDxF5GQ3C29oX7F+/tYRjQVcFGyNFAm2iS/Q1ydf7BugJyleMi3G/hmDpUkjJap+TkPAuzVbUuNUBtVKMnusWHEmc+4x5P4mUgwtlrP8Jlvky3t9pv23PHoxGc65Eu4lRciaSvFByFIZi6fZeY5kX7UBhn/CXIACXD04wmJmFjdTCLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8773350e-dee0-4485-daba-08d64506b5d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:04.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67145
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

Provide stub versions of functions in asm/fpu.h when
CONFIG_MIPS_FP_SUPPORT=n. Two approaches are taken to the functions
provided:

  - Functions which can safely be called when FP is not enabled provide
    stubs which return an error where appropriate or are simple no-ops.

  - Functions which should only ever be called in cases where
    cpu_has_fpu is true or the FPU was successfully enabled are declared
    extern & annotated with __compiletime_error() to detect cases in
    which they are called incorrectly.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/fpu.h | 85 +++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 2a631adb1fa8..42bc2bbbd3d7 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -30,9 +30,6 @@
 #include <asm/mips_mt.h>
 #endif
 
-extern void _save_fp(struct task_struct *);
-extern void _restore_fp(struct task_struct *);
-
 /*
  * This enum specifies a mode in which we want the FPU to operate, for cores
  * which implement the Status.FR bit. Note that the bottom bit of the value
@@ -47,6 +44,11 @@ enum fpu_mode {
 #define FPU_FR_MASK		0x1
 };
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
+extern void _save_fp(struct task_struct *);
+extern void _restore_fp(struct task_struct *);
+
 #define __disable_fpu()							\
 do {									\
 	clear_c0_status(ST0_CU1);					\
@@ -250,4 +252,81 @@ static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
 	return tsk->thread.fpu.fpr;
 }
 
+#else /* !CONFIG_MIPS_FP_SUPPORT */
+
+/*
+ * When FP support is disabled we provide only a minimal set of stub functions
+ * to avoid callers needing to care too much about CONFIG_MIPS_FP_SUPPORT.
+ */
+
+static inline int __enable_fpu(enum fpu_mode mode)
+{
+	return SIGILL;
+}
+
+static inline void __disable_fpu(void)
+{
+	/* no-op */
+}
+
+
+static inline int is_fpu_owner(void)
+{
+	return 0;
+}
+
+static inline void clear_fpu_owner(void)
+{
+	/* no-op */
+}
+
+static inline int own_fpu_inatomic(int restore)
+{
+	return SIGILL;
+}
+
+static inline int own_fpu(int restore)
+{
+	return SIGILL;
+}
+
+static inline void lose_fpu_inatomic(int save, struct task_struct *tsk)
+{
+	/* no-op */
+}
+
+static inline void lose_fpu(int save)
+{
+	/* no-op */
+}
+
+static inline bool init_fp_ctx(struct task_struct *target)
+{
+	return false;
+}
+
+/*
+ * The following functions should only be called in paths where we know that FP
+ * support is enabled, typically a path where own_fpu() or __enable_fpu() have
+ * returned successfully. When CONFIG_MIPS_FP_SUPPORT=n it is known at compile
+ * time that this should never happen, so calls to these functions should be
+ * optimized away & never actually be emitted.
+ */
+
+extern void save_fp(struct task_struct *tsk)
+	__compiletime_error("save_fp() should not be called when CONFIG_MIPS_FP_SUPPORT=n");
+
+extern void _save_fp(struct task_struct *)
+	__compiletime_error("_save_fp() should not be called when CONFIG_MIPS_FP_SUPPORT=n");
+
+extern void restore_fp(struct task_struct *tsk)
+	__compiletime_error("restore_fp() should not be called when CONFIG_MIPS_FP_SUPPORT=n");
+
+extern void _restore_fp(struct task_struct *)
+	__compiletime_error("_restore_fp() should not be called when CONFIG_MIPS_FP_SUPPORT=n");
+
+extern union fpureg *get_fpu_regs(struct task_struct *tsk)
+	__compiletime_error("get_fpu_regs() should not be called when CONFIG_MIPS_FP_SUPPORT=n");
+
+#endif /* !CONFIG_MIPS_FP_SUPPORT */
 #endif /* _ASM_FPU_H */
-- 
2.19.1
