Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:15:23 +0100 (CET)
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:33683
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992872AbeKGXOoNJI9U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bK+DfFkW1x2eevVd4BpD9oI/HmkvOMk5wGgmudOVDKk=;
 b=EXcIMmgunyk+6qD645TtqY2fN0fDjMLqIFK4mSzoEEQb2jhUlwmSY2efWy0eNJ+6eEphwQ0I+SXrB2sKrMa3V+WImNhahMnsGWyeqa9Ay6xh2rIL4ZAFtEOn3Qs7b5E9keIK338ZHWwfgv+o4+IXZdB4z0YUA/WtSWDKbz7u7Aw=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:11 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 19/20] MIPS: Remove struct task_struct fpu state when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 19/20] MIPS: Remove struct task_struct fpu state when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+X1V+1sUVkQkWSTCPFREVn2g==
Date:   Wed, 7 Nov 2018 23:14:10 +0000
Message-ID: <20181107231341.4614-20-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1581;6:4TM6sw9ksi55UjIcVxlZvzD76gTftBMzi7Qc7JaiVTLmPEth7yROQpax+3cOUEwV4a/P+m3TMI+NdWlB0Ma5MsHRaeJcU9H7DtCieSiVWcoLK7fcN00O905w5YzSizQ4xT44WwIqh0EQ9IlQ76zGN2/BHNNIDWajDFmL35qHCSyUZ+JrTyhGjDEEprZzAJKl5MWKFhA8RRyPl7Hujz9uGQ/9W0F41qEeHy0Aw4MReN/B1iTPnT1RhvjFBN7vrfjRVlUTTZLYvhvTzV1VXRKf6zg8WnJUIyIitCs/WrAEkWX3Qe4ZLYAdVSEctjwToB4dYtzKtJC2YUWTVDI0iq412HV9K5L31rykXaZlaFRqOWMzMTampDhw5b5PRiP+ZrWnR3FJqo4MXP9HBN2uUoQLK4GV2/pOK68Tl4XrBJjM3LjIvqli2sfRMK44GQcGJ3vCrzbGA5+QZoJq64k9KvF6vA==;5:hZt2/7+u83v2pOTtVxdZmMe9Ucf8/WfWvR18U37Z/E+qcrxZECnfAMYFrA29XlEF0YfpDTE9+ina7un0FjmLNdIc0L8F45cd8g16A5KMiXUVZH8VL8UJI7E9N3mwiJPK2DoJvEego/GgyXDCnuEiT30o5XIhOihSQJ4fESRidkg=;7:d+5T0wWWDT6fe6d78RxevVhQLb+AqzDu+NGPKR0V6rz7q9Cc/jPQQfbSFiARzSbzg1EtOPXbJwfGVBB2IdntxX5AaLn+8lKcpK4Wje/gYtlfJtTy8fIk5I3Gb0+gpkgFxl7bF4THZo2w8hxvhEhLPA==
x-ms-office365-filtering-correlation-id: 36ad043d-f3f1-48d2-908f-08d64506b985
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB15815ECE3644B258BD9E9352C1C40@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1581;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1581;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(14454004)(99286004)(6486002)(97736004)(36756003)(66066001)(68736007)(486006)(446003)(105586002)(11346002)(2906002)(2616005)(476003)(6116002)(44832011)(1076002)(3846002)(2351001)(106356001)(53936002)(6512007)(6436002)(5640700003)(256004)(7736002)(25786009)(71200400001)(26005)(305945005)(386003)(186003)(6916009)(42882007)(6506007)(2501003)(76176011)(71190400001)(52116002)(5660300001)(8936002)(8676002)(316002)(4326008)(81166006)(508600001)(2900100001)(107886003)(102836004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b/b18883ivsEKpgJ4krC+OCMadIYWbwW8K0KFVKYhHbsM1HPh2vIf0o0jO/P9eELdkxrMy5IfgsgOC0BXNGkg7ECALcruJDtQZ0TR3kxPkDpDDqgZ7SN18mAWAxnZJ7JbwDTXciyw6V2k2jhOfzQjslCuk5IV40E8a6re4J+wGAP8wSP7GmKvncRVtFsQ0cokHFtlVgRtHgLah/ztDyslRqvnE3ye4UfykGtXhogxynltUqOAygMuMvy0yuFwzPgvxAkAjuPaEBn2fQujQnP2hKOBWE8vYftElas6rEcHWZoM0/CRb4OKRLT3CsGMxdtlEZYwh5QRuvXXBzN4Le95XCpYnrNiT9Mx7vtHBjMJ3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ad043d-f3f1-48d2-908f-08d64506b985
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:10.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67153
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point & so don't
need to preserve floating point context for tasks. Remove that context
from struct task_struct.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/processor.h | 19 ++++++++++++++-----
 arch/mips/kernel/asm-offsets.c    |  7 ++++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index ce3ed4d17813..aca909bd7841 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -255,8 +255,10 @@ struct thread_struct {
 	/* Saved cp0 stuff. */
 	unsigned long cp0_status;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	/* Saved fpu/fpu emulator stuff. */
 	struct mips_fpu_struct fpu FPU_ALIGN;
+#endif
 	/* Assigned branch delay slot 'emulation' frame */
 	atomic_t bd_emu_frame;
 	/* PC of the branch from a branch delay slot 'emulation' */
@@ -299,6 +301,17 @@ struct thread_struct {
 #define FPAFF_INIT
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+# define FPU_INIT						\
+	.fpu			= {				\
+		.fpr		= {{{0,},},},			\
+		.fcr31		= 0,				\
+		.msacsr		= 0,				\
+	},
+#else
+# define FPU_INIT
+#endif
+
 #define INIT_THREAD  {						\
 	/*							\
 	 * Saved main processor registers			\
@@ -321,11 +334,7 @@ struct thread_struct {
 	/*							\
 	 * Saved FPU/FPU emulator stuff				\
 	 */							\
-	.fpu			= {				\
-		.fpr		= {{{0,},},},			\
-		.fcr31		= 0,				\
-		.msacsr		= 0,				\
-	},							\
+	FPU_INIT						\
 	/*							\
 	 * FPU affinity state (null if not FPAFF)		\
 	 */							\
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index cbe4742d2fff..aebfda81120a 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -123,7 +123,6 @@ void output_thread_defines(void)
 	OFFSET(THREAD_REG31, task_struct, thread.reg31);
 	OFFSET(THREAD_STATUS, task_struct,
 	       thread.cp0_status);
-	OFFSET(THREAD_FPU, task_struct, thread.fpu);
 
 	OFFSET(THREAD_BVADDR, task_struct, \
 	       thread.cp0_badvaddr);
@@ -135,8 +134,11 @@ void output_thread_defines(void)
 	BLANK();
 }
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 void output_thread_fpu_defines(void)
 {
+	OFFSET(THREAD_FPU, task_struct, thread.fpu);
+
 	OFFSET(THREAD_FPR0, task_struct, thread.fpu.fpr[0]);
 	OFFSET(THREAD_FPR1, task_struct, thread.fpu.fpr[1]);
 	OFFSET(THREAD_FPR2, task_struct, thread.fpu.fpr[2]);
@@ -174,6 +176,7 @@ void output_thread_fpu_defines(void)
 	OFFSET(THREAD_MSA_CSR, task_struct, thread.fpu.msacsr);
 	BLANK();
 }
+#endif
 
 void output_mm_defines(void)
 {
@@ -341,6 +344,7 @@ void output_pm_defines(void)
 }
 #endif
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specific offsets. ");
@@ -382,6 +386,7 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_MSA_CSR, kvm_vcpu_arch, fpu.msacsr);
 	BLANK();
 }
+#endif
 
 #ifdef CONFIG_MIPS_CPS
 void output_cps_defines(void)
-- 
2.19.1
