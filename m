Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47BC282DB
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AA220857
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 01:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="K6QyC02X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfBBBnx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:43:53 -0500
Received: from mail-eopbgr810108.outbound.protection.outlook.com ([40.107.81.108]:62863
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbfBBBnx (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 20:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKRrooD68HPno71kQzZ1FXVOkRYCYGZtlmuu0Gf1CRE=;
 b=K6QyC02XqyuJk2iK8viqqb/vS+KNYWqin2PHS4/yReBb+QjyIAYaFP1jW783YseATIEsEfI95tNKSpc/FDuhcZ2tKZXjNEsyD8Kuj1wjF98MxTcc57iPRM4G92ERGwTPyXIakFsuMOIJgNmxRmNA8KBT659RblCdMM9NbR7egYc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1439.namprd22.prod.outlook.com (10.174.169.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Sat, 2 Feb 2019 01:43:27 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 01:43:27 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 13/14] MIPS: Add GINVT instruction helpers
Thread-Topic: [PATCH 13/14] MIPS: Add GINVT instruction helpers
Thread-Index: AQHUupix8N/Nkd9j/k2/ZLfps71AkQ==
Date:   Sat, 2 Feb 2019 01:43:27 +0000
Message-ID: <20190202014242.30680-14-paul.burton@mips.com>
References: <20190202014242.30680-1-paul.burton@mips.com>
In-Reply-To: <20190202014242.30680-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1439;6:4pTp9x9jEmR61bpD33i2P/mGbsnMEPlH4W8bzVMVAnb87ds0CN93e3FOOVHOFoffG4C9JzgsPo1zqF464aAkkqbV6JiulWBrx7Vk6pXa4XdX2NLiFQJ9qQzixN8lwzIlUq0/RlYwiPcxCnWSQO4BicbC2LOKE2C5pJeJL4/BH/ZLKTSz49yGVbyWtNWpuGfsQRyKi856GlgHjqXNNUsFrSlOyduZ3btUfVdHFTyOIqbi/j/HpYLcoH4oSQviNX4LfoFVXQiJXO3Lsd5Lln0+VoeFhbkAABWzkRFrvvdp6kJkET8PHiwqHBosRW+6Pl2gnrf/ep1POtHlitsiwWjDcLwdEa7mOwqEuzRE4NCPMgVOsJEXjS7oHn2r5Ana7butM8YBXzRbbKAy9FCXQ1y2iNrHlL1o9tKVQh9c1l/jbATzpHLZXidaovY3AOQvA+cgJLDxmxCRt/0Ia4AykAjuYw==;5:Zw1ZfW26LcAgEVW0GFdh+MFGQucfvB2frj3qZrE06yhg1No8aMv6cq8pvdE9qPAxevvMJIGEuOHO7AjKN9vjWpJfT2Q5Jzh9Ylgd5ca0nN1tdFIkYROFKsVr9ECnh0efnULboAcqVrBOjScH3DvWS4tr0/tnwAunaY6vxPqf4J8xXfvyUWf4IDI5ckao9IGKuguDbkv+fn2YJ/bNjzj9mg==;7:zFrbTuyYcKgQua3EjsxBumm5OTZtfvzcAlKOtY8AFIsGgWRlXEOjLpbAbbbpD6RRVdMepLQiC/J3nwstkka3m6c0A/ZGeBIWteHMj1WW1letPkm+t9QD1wbLLH+oXNDPAvwKqv4/t+cUPh0vds7Pyg==
x-ms-office365-filtering-correlation-id: b88619f9-47fd-4e63-630a-08d688afd36a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1439;
x-ms-traffictypediagnostic: MWHPR2201MB1439:
x-microsoft-antispam-prvs: <MWHPR2201MB1439FF235A8F91C94E7BD681C1930@MWHPR2201MB1439.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(2616005)(6436002)(446003)(42882007)(106356001)(1076003)(386003)(2501003)(6506007)(305945005)(476003)(107886003)(316002)(25786009)(97736004)(105586002)(11346002)(7736002)(26005)(186003)(36756003)(3846002)(102836004)(6116002)(44832011)(50226002)(486006)(5640700003)(6916009)(68736007)(99286004)(4326008)(2906002)(8936002)(6486002)(76176011)(8676002)(71190400001)(256004)(14454004)(2351001)(71200400001)(66066001)(52116002)(6512007)(478600001)(81156014)(81166006)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1439;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PSyZ9GYJ/0QVqaGwoXYhUes3U5TksbBvBc9wvxwp8DVGcBxXbs/uEH3EE+KG2CkNQR+9O8GPy4+wwbIsltj9rOqAs40gtndAUiOxHBf123Gi19lDm45KMeN2FszTvesdNYiFAgDuBKl0Uwa8ol1LDDzcr1KAU9AAdlM9to3MkCVFn6BUZwsnpD20b3EMxSex8S0EGbiWLcGXUsVHkFRiQBeXBQ7291/jyjz7S1qn1OaLXTXa52+QodH+uaYWMYxRHbfLs/rUEQUw5N3AtNyiXw/WBxTxT8nO5dkK/t6bAhe8DXXRQVETk7K+vi2h7BksVvb1WVV7d2teyltes6d1JlxnrYPbe31TZoDsat+DjVE3wgfv8LygB2/dTDs+atKoOSxKkctmqhkMnLcNpqxKWFqdgSAlfXdBwXZFzeCpbg0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88619f9-47fd-4e63-630a-08d688afd36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 01:43:26.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1439
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add a family of ginvt_* functions making it easy to emit a GINVT
instruction to globally invalidate TLB entries. We make use of the
_ASM_MACRO infrastructure to support emitting the instructions even if
the assembler isn't new enough to support them natively.

An associated STYPE_GINV definition & sync_ginv() function are added to
emit a sync instruction of type 0x14, which operates as a completion
barrier for these new GINVT (and GINVI) instructions.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Makefile               |  2 ++
 arch/mips/include/asm/barrier.h  | 19 +++++++++++
 arch/mips/include/asm/ginvt.h    | 56 ++++++++++++++++++++++++++++++++
 arch/mips/include/asm/mipsregs.h |  7 ++++
 4 files changed, 84 insertions(+)
 create mode 100644 arch/mips/include/asm/ginvt.h

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5b174c3d0de3..8f4486c4415b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -233,6 +233,8 @@ toolchain-crc				:=3D $(call cc-option-yn,$(mips-cflags=
) -Wa$(comma)-mcrc)
 cflags-$(toolchain-crc)			+=3D -DTOOLCHAIN_SUPPORTS_CRC
 toolchain-dsp				:=3D $(call cc-option-yn,$(mips-cflags) -Wa$(comma)-mdsp)
 cflags-$(toolchain-dsp)			+=3D -DTOOLCHAIN_SUPPORTS_DSP
+toolchain-ginv				:=3D $(call cc-option-yn,$(mips-cflags) -Wa$(comma)-mgin=
v)
+cflags-$(toolchain-ginv)		+=3D -DTOOLCHAIN_SUPPORTS_GINV
=20
 #
 # Firmware support
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrie=
r.h
index a5eb1bb199a7..b48ee2caf78d 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -105,6 +105,20 @@
  */
 #define STYPE_SYNC_MB 0x10
=20
+/*
+ * stype 0x14 - A completion barrier specific to global invalidations
+ *
+ * When a sync instruction of this type completes any preceding GINVI or G=
INVT
+ * operation has been globalized & completed on all coherent CPUs. Anythin=
g
+ * that the GINV* instruction should invalidate will have been invalidated=
 on
+ * all coherent CPUs when this instruction completes. It is implementation
+ * specific whether the GINV* instructions themselves will ensure completi=
on,
+ * or this sync type will.
+ *
+ * In systems implementing global invalidates (ie. with Config5.GI =3D=3D =
2 or 3)
+ * this sync type also requires that previous SYNCI operations have comple=
ted.
+ */
+#define STYPE_GINV	0x14
=20
 #ifdef CONFIG_CPU_HAS_SYNC
 #define __sync()				\
@@ -222,6 +236,11 @@
 #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
 #define __smp_mb__after_atomic()	smp_llsc_mb()
=20
+static inline void sync_ginv(void)
+{
+	asm volatile("sync\t%0" :: "i"(STYPE_GINV));
+}
+
 #include <asm-generic/barrier.h>
=20
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/mips/include/asm/ginvt.h b/arch/mips/include/asm/ginvt.h
new file mode 100644
index 000000000000..49c6dbe37338
--- /dev/null
+++ b/arch/mips/include/asm/ginvt.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __MIPS_ASM_GINVT_H__
+#define __MIPS_ASM_GINVT_H__
+
+#include <asm/mipsregs.h>
+
+enum ginvt_type {
+	GINVT_FULL,
+	GINVT_VA,
+	GINVT_MMID,
+};
+
+#ifdef TOOLCHAIN_SUPPORTS_GINV
+# define _ASM_SET_GINV	".set	ginv\n"
+#else
+_ASM_MACRO_1R1I(ginvt, rs, type,
+		_ASM_INSN_IF_MIPS(0x7c0000bd | (__rs << 21) | (\\type << 8))
+		_ASM_INSN32_IF_MM(0x0000717c | (__rs << 16) | (\\type << 9)));
+# define _ASM_SET_GINV
+#endif
+
+static inline void ginvt(unsigned long addr, enum ginvt_type type)
+{
+	asm volatile(
+		".set	push\n"
+		_ASM_SET_GINV
+		"	ginvt	%0, %1\n"
+		".set	pop"
+		: /* no outputs */
+		: "r"(addr), "i"(type)
+		: "memory");
+}
+
+static inline void ginvt_full(void)
+{
+	ginvt(0, GINVT_FULL);
+}
+
+static inline void ginvt_va(unsigned long addr)
+{
+	addr &=3D PAGE_MASK << 1;
+	ginvt(addr, GINVT_VA);
+}
+
+static inline void ginvt_mmid(void)
+{
+	ginvt(0, GINVT_MMID);
+}
+
+static inline void ginvt_va_mmid(unsigned long addr)
+{
+	addr &=3D PAGE_MASK << 1;
+	ginvt(addr, GINVT_VA | GINVT_MMID);
+}
+
+#endif /* __MIPS_ASM_GINVT_H__ */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsr=
egs.h
index 402b80af91aa..900a47581dd1 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1247,6 +1247,13 @@ __asm__(".macro	parse_r var r\n\t"
 		ENC							\
 		".endm")
=20
+/* Instructions with 1 register operand & 1 immediate operand */
+#define _ASM_MACRO_1R1I(OP, R1, I2, ENC)				\
+	__asm__(".macro	" #OP " " #R1 ", " #I2 "\n\t"			\
+		"parse_r __" #R1 ", \\" #R1 "\n\t"			\
+		ENC							\
+		".endm")
+
 /* Instructions with 2 register operands */
 #define _ASM_MACRO_2R(OP, R1, R2, ENC)					\
 	__asm__(".macro	" #OP " " #R1 ", " #R2 "\n\t"			\
--=20
2.20.1

