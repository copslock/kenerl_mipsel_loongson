Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:15:15 +0100 (CET)
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:33683
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992960AbeKGXOneASLU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx6f05tDFwtNMbasAcICPFAnRjayYXGrRCu/WxTSxbM=;
 b=H/bMsievl/eiz7docu5zK61hrt4eGVG2DrhjTar5eTPTjQCrIyZEYuamkT4Nk+M6Ato1CuGPXjnGCAt4hUz+hWRsfexuQqUdZYMOjw8Toav0S8CxEQTWDlaV9WrCFJuP42o+yAk5njybm3Q6RGqaIhOhr41aKL5jhbTMeH46S/Y=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:10 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:10 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 18/20] MIPS: Don't compile math-emu when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 18/20] MIPS: Don't compile math-emu when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+WwFlPq1ErTkiCwoDho8R4rQ==
Date:   Wed, 7 Nov 2018 23:14:10 +0000
Message-ID: <20181107231341.4614-19-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1581;6:vpMx8X3Zfrmw5cDFqniGAlR8Y63LvJuaJHN8RKr6Qk8qcv37XziQ5zV7hF53GMzEzYpg3ZNM6pJiMBHH5j6GB10yHk4RsWxK96UrB7kK5BM1UlJSIUTPKLyZWm5XirF+g5VI7D/qWpSViFkTrt6pv/1X03zRZ03tLQqLupCR0c+817F3cYA3fWYl9ER/tT5z9hAFkEhoJa052H+uAzETlR29ayDSTobJmtCLPFQ0W9UvhLFG4G4i7dV/0hdAVNOjVHbQE3hivzKP79erpLgGk+bvgZ5ROdT/xm0/qCNmDwMc9R4uz6w18g8RIGjwpWkRB+BRnT35t5B9w0DpZeeoTtdqnxOzjcAa3zJYHuixd4qlfHqz7uhqwZ2VJww6VqIqooF/yhVVrL9tVMaS+Re9L3Pc9iKRrA6fzuWTzqHj2V+xeoV+avGp/0SkznNHpGsewBIvA/WyyWAP/E7cyxEOog==;5:eV62+GXEEgVBCjTdGenJEt3GDZ2V+yV0KOa2jem6/I1yTvhxi6Gnf+7AnXzwyj8jvPnY2C6f5gjwXEqOt2HC+Xrw/mpt2sX1mBkwdxRjwhA9uXlIpaOSKAwr6Xt9xsGigsv5O7c4qQ7QwZ+a9Ul0qRX/yJQEVVCWgebhuWGaZr0=;7:nzDF8CBYdTlHHFJJ1GihYNyM/uOVkJCrf2BaFW6zF2k4UMIfxHiBrES4l7ZfmmpdEwYvb+LbupKTnpS/uBqSw7ZQxmi9JjZWq9cImcoomltYDDDG064dUebqMy1Tqu5anWRj65L5X2+OZpeSdHrBug==
x-ms-office365-filtering-correlation-id: 106b8d71-1510-4edb-aa9d-08d64506b939
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB1581310C5CD2A17EB560EE30C1C40@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1581;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1581;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(14454004)(99286004)(6486002)(97736004)(36756003)(66066001)(68736007)(486006)(446003)(105586002)(11346002)(2906002)(2616005)(476003)(6116002)(44832011)(1076002)(3846002)(2351001)(106356001)(53936002)(6512007)(6436002)(5640700003)(256004)(14444005)(7736002)(25786009)(71200400001)(26005)(305945005)(386003)(186003)(6916009)(42882007)(6506007)(2501003)(76176011)(71190400001)(52116002)(5660300001)(8936002)(8676002)(316002)(4326008)(81166006)(508600001)(2900100001)(107886003)(102836004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9ppIhwo77jV+PUbRm+b4U0qE6ErXt7OjUoTIYnCmupz6mIOTxoPJyQo/tEsRXNyoASuzCa7/Co2k/X/RAIXm/oHrtGg0zJcFCW4yJd7EJAVSW0TeNL00Oa1nW04zlCIp5sx3HFh4ZH5mIyRK+LAES2LUWGK5xQ/CC7lgmHazjpTTfHTQN7DipJq06p7qCUSImjWnbM3eemq6rvoI19G1nwvLA0ZzSaYpkhuTrp+xbN/5+WVY/IEWz9jmVBWh6RFQXHu37WloaNieE1clE95g8m+w3rlr6OKVA4jcoT99Grf10xTT1/0AlSNVVwgO9Hxz2lOu4mp2DY2xO+C4uAyHQx5QZLNlVnDWc/VhQqWF5/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106b8d71-1510-4edb-aa9d-08d64506b939
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:10.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67152
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
there's no point compiling in our FPU emulator. Avoid doing so,
providing stub versions of dsemul cleanup functions that are called from
signal & task handling code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Makefile             |  2 +-
 arch/mips/include/asm/dsemul.h | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 68410490e12f..b6303e48d479 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -319,7 +319,7 @@ OBJCOPYFLAGS		+= --remove-section=.reginfo
 head-y := arch/mips/kernel/head.o
 
 libs-y			+= arch/mips/lib/
-libs-y			+= arch/mips/math-emu/
+libs-$(CONFIG_MIPS_FP_SUPPORT) += arch/mips/math-emu/
 
 # See arch/mips/Kbuild for content of core part of the kernel
 core-y += arch/mips/
diff --git a/arch/mips/include/asm/dsemul.h b/arch/mips/include/asm/dsemul.h
index b47a97527673..6d5b781ad518 100644
--- a/arch/mips/include/asm/dsemul.h
+++ b/arch/mips/include/asm/dsemul.h
@@ -52,7 +52,14 @@ extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
  *
  * Return: True if an emulation frame was returned from, else false.
  */
+#ifdef CONFIG_MIPS_FP_SUPPORT
 extern bool do_dsemulret(struct pt_regs *xcp);
+#else
+static inline bool do_dsemulret(struct pt_regs *xcp)
+{
+	return false;
+}
+#endif
 
 /**
  * dsemul_thread_cleanup() - Cleanup thread 'emulation' frame
@@ -63,8 +70,14 @@ extern bool do_dsemulret(struct pt_regs *xcp);
  *
  * Return: True if a frame was freed, else false.
  */
+#ifdef CONFIG_MIPS_FP_SUPPORT
 extern bool dsemul_thread_cleanup(struct task_struct *tsk);
-
+#else
+static inline bool dsemul_thread_cleanup(struct task_struct *tsk)
+{
+	return false;
+}
+#endif
 /**
  * dsemul_thread_rollback() - Rollback from an 'emulation' frame
  * @regs:	User thread register context.
@@ -77,7 +90,14 @@ extern bool dsemul_thread_cleanup(struct task_struct *tsk);
  *
  * Return: True if a frame was exited, else false.
  */
+#ifdef CONFIG_MIPS_FP_SUPPORT
 extern bool dsemul_thread_rollback(struct pt_regs *regs);
+#else
+static inline bool dsemul_thread_rollback(struct pt_regs *regs)
+{
+	return false;
+}
+#endif
 
 /**
  * dsemul_mm_cleanup() - Cleanup per-mm delay slot 'emulation' state
@@ -87,6 +107,13 @@ extern bool dsemul_thread_rollback(struct pt_regs *regs);
  * for delay slot 'emulation' book-keeping is freed. This is to be called
  * before @mm is freed in order to avoid memory leaks.
  */
+#ifdef CONFIG_MIPS_FP_SUPPORT
 extern void dsemul_mm_cleanup(struct mm_struct *mm);
+#else
+static inline void dsemul_mm_cleanup(struct mm_struct *mm)
+{
+	/* no-op */
+}
+#endif
 
 #endif /* __MIPS_ASM_DSEMUL_H__ */
-- 
2.19.1
