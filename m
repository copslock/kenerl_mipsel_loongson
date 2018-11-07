Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:16:15 +0100 (CET)
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:44352
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992889AbeKGXOJwAUlU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd94cd9kfTSMhjmPmPiT7RDjkqEn3vt6T9ENocmW/wE=;
 b=OGJyO4wD0IT80Ac5YrdO+2JK3uCLQmCfM3dqA5lzwd+1YxsBwdDlx/JUGWIVwyjxrFyl5OBNOO1vztWq/ANy3Mmi1eedy73UodZg1tc7JPdaidU70hz9IE88vb33nfPNOXqTeGiZlxeqQujaYpjnfcGwkB8yH1IMqtLZctecr+k=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:07 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 13/20] MIPS: unaligned: Remove FP & MSA code when unsupported
Thread-Topic: [PATCH 13/20] MIPS: unaligned: Remove FP & MSA code when
 unsupported
Thread-Index: AQHUdu+VbzCVVs3Lr0alNvX64NMkSg==
Date:   Wed, 7 Nov 2018 23:14:07 +0000
Message-ID: <20181107231341.4614-14-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1566;6:XvZzS5myqsMxVuPd1FlSk3rQXc41tTY66DQzPS6hcrP+/BU55Z680EMnue0QgiCmPK6nMO7MRpQNWEEldFEDzNJe+OY7WnlHnKiLZz5l6fS2anbUJSqlIp21iQwrTPg0aRauoTUxNUfayH3Ly43E4JCMSYFh5SZajsweukKRGjUXQtlAMIWEXr0f0SYS0KsFpygAStAypZf9V0k+FCdmIa78JTFEqds7axNsFi+3bVKwTO05htlqnZJ6ODJXUjIo2VskCiywCZI52B0DTqBqzxzKnyWyvSG5YrFsYZ/N4q126Vkjw/ewtxNjYuKqZGrmYNe0rtaY/BocrFzBcAo8kJwRcAfDyc2i+4+O1J49YtLZmAl6ZTWTIr5Dq50EDGMMQoFIZtKnDpBemVQnQApFQoh4WNmiRbgRcGy+8MDsBgjBOxuiAaKDMUcGZCDWKxOMeUUli1v/KCtcRNbPGoJjIw==;5:92dtyoPaj7AA9Ekk/3eGOeAGqhchoCeVHl8EqfZOt8w57kRfvud3tZx5Ni6AjpjJ4Xae7rxsu5dczl+9kn9icmJsD0iD6fAzRAVtbb9oQ1xwS4bgIyh9I4RzbGFXNNo/1oCe2vp3tg1ekONv+5lBquvNTH+9NeHdsYA6flae2qc=;7:51Z4BrlIyGeCV8gLv9I+Nb/wN0mt5JfYjvgsftluKfYqltwJJz/xCVDBBxOr3JlnAnIatxFzEIrY7aAuzV9TP7u/QQP2R3UbG54n+cQiC79ATRdK6jPkIHnMyKj+MrNuFowQOQ3qGedYwYgefBS6pQ==
x-ms-office365-filtering-correlation-id: 61c1517a-98e6-4427-1ab7-08d64506b760
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-antispam-prvs: <MWHPR2201MB156635738E216D5E28869D8EC1C40@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1566;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1566;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(199004)(189003)(66066001)(2501003)(386003)(6512007)(53936002)(8936002)(6486002)(81156014)(81166006)(2906002)(3846002)(25786009)(6436002)(6116002)(71200400001)(102836004)(2900100001)(5640700003)(97736004)(1076002)(99286004)(476003)(4326008)(106356001)(186003)(42882007)(52116002)(105586002)(6916009)(71190400001)(2351001)(44832011)(36756003)(76176011)(6506007)(107886003)(508600001)(8676002)(68736007)(305945005)(316002)(5660300001)(11346002)(2616005)(14454004)(26005)(256004)(14444005)(486006)(446003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kZAdfWwgi7Oi86P+WX7el2C+1n3mm6UkVDzGDFOytZ/XQhkth92y2Z2b6A+br4SbSnxvXT5e8zNnhg7G+2oldYybMYrQpk6rXho6JrJbi/izuuzYo1473Yc3/Ir7Cm8lZ9P1vDa6VhG9oYo4ofm+RNBZHLFSKgdWkzEixGghTF7uKqyv1vEkYLsrnSEpyOWOrNA6oPz53Vke2qigBqRRbRkKTnGYguXF0dcyicUjNC/b8lbpn211qYhbrhGa77AMIO/iUMblOwTp7T2dufzKD1NHRjuxFXzGP92HTXHt/47/svYGAQaOPOVV4ANyWxccYCbNOGyleU1TsglMT67q4KArOEgdG8Pu+DXxd2968dI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c1517a-98e6-4427-1ab7-08d64506b760
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:07.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67156
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
support for floating point instructions from emulate_load_store_insn() &
emulate_load_store_microMIPS(). This code should not be needed & relies
upon access to FPU state in struct task_struct which will later be
removed.

Similarly & for the same reasons, when CONFIG_CPU_HAS_MSA=n remove
support for MSA instructions. Since MSA support depends upon FP support
this is implied when CONFIG_MIPS_FP_SUPPORT=n.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/unaligned.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 4c7de9f6373d..3850c563e588 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -882,18 +882,12 @@ do {                                                        \
 static void emulate_load_store_insn(struct pt_regs *regs,
 	void __user *addr, unsigned int __user *pc)
 {
+	unsigned long origpc, orig31, value;
 	union mips_instruction insn;
-	unsigned long value;
-	unsigned int res, preempted;
-	unsigned long origpc;
-	unsigned long orig31;
-	void __user *fault_addr = NULL;
+	unsigned int res;
 #ifdef	CONFIG_EVA
 	mm_segment_t seg;
 #endif
-	union fpureg *fpr;
-	enum msa_2b_fmt df;
-	unsigned int wd;
 	origpc = (unsigned long)pc;
 	orig31 = regs->regs[31];
 
@@ -1212,11 +1206,15 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		/* Cannot handle 64-bit instructions in 32-bit kernel */
 		goto sigill;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
+
 	case lwc1_op:
 	case ldc1_op:
 	case swc1_op:
 	case sdc1_op:
-	case cop1x_op:
+	case cop1x_op: {
+		void __user *fault_addr = NULL;
+
 		die_if_kernel("Unaligned FP access in kernel code", regs);
 		BUG_ON(!used_math());
 
@@ -1230,8 +1228,16 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (res == 0)
 			break;
 		return;
+	}
+#endif /* CONFIG_MIPS_FP_SUPPORT */
+
+#ifdef CONFIG_CPU_HAS_MSA
+
+	case msa_op: {
+		unsigned int wd, preempted;
+		enum msa_2b_fmt df;
+		union fpureg *fpr;
 
-	case msa_op:
 		if (!cpu_has_msa)
 			goto sigill;
 
@@ -1308,6 +1314,8 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 
 		compute_return_epc(regs);
 		break;
+	}
+#endif /* CONFIG_CPU_HAS_MSA */
 
 #ifndef CONFIG_CPU_MIPSR6
 	/*
@@ -1392,7 +1400,6 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
 	unsigned long origpc, contpc;
 	union mips_instruction insn;
 	struct mm_decoded_insn mminsn;
-	void __user *fault_addr = NULL;
 
 	origpc = regs->cp0_epc;
 	orig31 = regs->regs[31];
@@ -1708,6 +1715,7 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
 		/*  LL,SC,LLD,SCD are not serviced */
 		goto sigbus;
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	case mm_pool32f_op:
 		switch (insn.mm_x_format.func) {
 		case mm_lwxc1_func:
@@ -1722,7 +1730,9 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
 	case mm_ldc132_op:
 	case mm_sdc132_op:
 	case mm_lwc132_op:
-	case mm_swc132_op:
+	case mm_swc132_op: {
+		void __user *fault_addr = NULL;
+
 fpu_emul:
 		/* roll back jump/branch */
 		regs->cp0_epc = origpc;
@@ -1742,6 +1752,8 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
 		if (res == 0)
 			goto success;
 		return;
+	}
+#endif /* CONFIG_MIPS_FP_SUPPORT */
 
 	case mm_lh32_op:
 		reg = insn.mm_i_format.rt;
-- 
2.19.1
