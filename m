Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 21:41:11 +0100 (CET)
Received: from mail-eopbgr700121.outbound.protection.outlook.com ([40.107.70.121]:9187
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993828AbeKTUlIf0v3i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 21:41:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nttaj5jyJkXr22kPLq8RL6HiWKWNXKePzTAct46icw=;
 b=H7NxPkHQlBr722L/LbfGTgvuzKnUKsfaqJEF3fFXwIdK41YpBIVQA+m92XTC6kpOGxWFMQZmwlDgMr3q7hVYLvaI1QEpUxFykZOcvf9gEqAQ0A4GsqytnfuXA+MKRIGYvRLob7aUZ+8fMvaKAAA0RkdzU6doPekz5Vt1k1WsgUA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1647.namprd22.prod.outlook.com (10.174.167.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 20:41:05 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 20:41:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: ptrace: introduce NT_MIPS_MSA regset
Thread-Topic: [PATCH] MIPS: ptrace: introduce NT_MIPS_MSA regset
Thread-Index: AQHUgRFbxR/ChQn56EC3U5mxWwKQEw==
Date:   Tue, 20 Nov 2018 20:41:05 +0000
Message-ID: <20181120204049.19153-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:102:2::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1647;6:cUv4rFdNoavxt0cWZ/6au96oZkjVeKVvjKI8SuCzPwguE6GTypgjZvEv3ROhXkLSZULML3INrBZ89CdUs8nfdkOwN9xo34ZM6jh5ZZRXwMaOMggRjXtutxRrENmRdv4BQYq9kyGffoLonG5KwH348z86i5N7XT66zl4KGo1V7R/+L32NG0H1SY24i8ObAtXBnM6Ck3N8GSakXrEr5N0gHMEy8qSemA7l97o4IR3YbKgAnnDh+6IR/Xhrrqk25RGNZ/RYuDb9s7jVqyLiSm8lqVLyZCgHDYnzN84xOqfoox+DbLfah1wz5TcL0yA4ai2G8t4KDbwO257skvvQaDIwaT4feRYdkGV/kCs9EhAkXtwnxP0ier+8viZVdsz5cz+CqBkAviPfPCdLBo7k7Jg3XU+fIQLXv+/VJqk6cVUKVu6MI4DNFXIdcP1nMo31+ei2Igz6zz51ujo0BDhQ/YjfPQ==;5:Laoq2YwW5m5vg7qJg6lDqBe8wCBc/Xb/VH/B4TQg3lNwMvlFIQ5b3F2Ee04rUlj/qU82rBu34cj3rxl2/yBKSKa8dMaIzu4eawBEf/NFRPygg4XSCes1ZUw6YGLckzKxHfcKmvzEn4U6Oy7dNcuiXZO/QidyEm4KV6PUp/6ObJo=;7:B/RFgittNbgVIqZscY5WVN7Om3+cOtJ5vxTvHvTcGB8KG7LDLdksMmLib2wr6pcqyLLRevgmvlPQFbFPhJHsf1fVZo10xtv9AyFIncZN8n/WUlnZhskz2yGA1ZtEkqNrDYKTqmRp9VKcj8uSBLhs1g==
x-ms-office365-filtering-correlation-id: 90ac6a30-614e-463c-37c8-08d64f287d80
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1647;
x-ms-traffictypediagnostic: MWHPR2201MB1647:
x-microsoft-antispam-prvs: <MWHPR2201MB16475D779F4BDC1794571677C1D90@MWHPR2201MB1647.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1647;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1647;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39840400004)(199004)(189003)(5640700003)(106356001)(6916009)(6436002)(105586002)(575784001)(68736007)(6512007)(4326008)(42882007)(14454004)(5660300001)(2351001)(53936002)(107886003)(305945005)(508600001)(6486002)(71200400001)(44832011)(476003)(2616005)(36756003)(486006)(7736002)(52116002)(8936002)(81156014)(8676002)(25786009)(81166006)(386003)(316002)(97736004)(2906002)(6506007)(99286004)(186003)(1857600001)(256004)(102836004)(26005)(71190400001)(2900100001)(66066001)(2501003)(1076002)(3846002)(6116002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1647;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X9EedrLkcOpTS9fzGuqrWmdNE3WTzbSinNmqsBz71oXTqUGeX0DOWt27uL11QNAZzeO6dfqAg6tZuJbIGOXVc+Kc17zeQC+ncOPY66Pr1IsjtL5BjjmOvcNoCvekgi8515mn76XngXn94Aoa/e5XCt9GGcisPL1APbAIBWOL/lc+RLrQCyg0EiE632+iDJWWt0E/a0yc2lTtGjfLtgxWJn4WKEJdsERSp+hH9/RktfWl8NgIkr91FZM22ZC4wTeyKxHwQJYdcZo8EqCsm0ZT6hUVKEO3hloSbCVT3LcI/69mpY59i42m5vrdaq4t6GGxze7b3BNr6uUjva7GhzCoFaUT7mU3VCI+rIwbrJDUYHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ac6a30-614e-463c-37c8-08d64f287d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 20:41:05.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1647
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67406
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

The current methods for obtaining FP context via ptrace only provide
either 32 or 64 bits per data register. With MSA, where vector registers
are aliased with scalar FP data registers, those registers are 128 bits
wide. Thus a new mechanism is required for userland to access those
registers via ptrace. This patch introduces an NT_MIPS_MSA regset which
provides, in this order:

  - The full 128 bits value of each vector register, in native
    endianness saved as though elements are doubles. That is, the format
    of each vector register is as would be obtained by saving it to
    memory using an st.d instruction.

  - The 32 bit scalar FP implementation register (FIR).

  - The 32 bit scalar FP control & status register (FCSR).

  - The 32 bit MSA implementation register (MSAIR).

  - The 32 bit MSA control & status register (MSACSR).

The provision of the FIR & FCSR registers in addition to the MSA
equivalents allows scalar FP context to be retrieved as a subset of
the context available via this regset. Along with the MSA equivalents
they also nicely form the final 128 bit "register" of the regset.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/ptrace.c | 147 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h  |   1 +
 2 files changed, 148 insertions(+)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index d7d032f2b656..ea54575255ea 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -622,6 +622,130 @@ static int fp_mode_set(struct task_struct *target,
 
 #endif /* CONFIG_MIPS_FP_SUPPORT */
 
+#ifdef CONFIG_CPU_HAS_MSA
+
+struct msa_control_regs {
+	unsigned int fir;
+	unsigned int fcsr;
+	unsigned int msair;
+	unsigned int msacsr;
+};
+
+static int copy_pad_fprs(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int *ppos, unsigned int *pcount,
+			 void **pkbuf, void __user **pubuf,
+			 unsigned int live_sz)
+{
+	int i, j, start, start_pad, err;
+	unsigned long long fill = ~0ull;
+	unsigned int cp_sz, pad_sz;
+
+	cp_sz = min(regset->size, live_sz);
+	pad_sz = regset->size - cp_sz;
+	WARN_ON(pad_sz % sizeof(fill));
+
+	i = start = err = 0;
+	for (; i < NUM_FPU_REGS; i++, start += regset->size) {
+		err |= user_regset_copyout(ppos, pcount, pkbuf, pubuf,
+					   &target->thread.fpu.fpr[i],
+					   start, start + cp_sz);
+
+		start_pad = start + cp_sz;
+		for (j = 0; j < (pad_sz / sizeof(fill)); j++) {
+			err |= user_regset_copyout(ppos, pcount, pkbuf, pubuf,
+						   &fill, start_pad,
+						   start_pad + sizeof(fill));
+			start_pad += sizeof(fill);
+		}
+	}
+
+	return err;
+}
+
+static int msa_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
+	const struct msa_control_regs ctrl_regs = {
+		.fir = boot_cpu_data.fpu_id,
+		.fcsr = target->thread.fpu.fcr31,
+		.msair = boot_cpu_data.msa_id,
+		.msacsr = target->thread.fpu.msacsr,
+	};
+	int err;
+
+	if (!tsk_used_math(target)) {
+		/* The task hasn't used FP or MSA, fill with 0xff */
+		err = copy_pad_fprs(target, regset, &pos, &count,
+				    &kbuf, &ubuf, 0);
+	} else if (!test_tsk_thread_flag(target, TIF_MSA_CTX_LIVE)) {
+		/* Copy scalar FP context, fill the rest with 0xff */
+		err = copy_pad_fprs(target, regset, &pos, &count,
+				    &kbuf, &ubuf, 8);
+	} else if (sizeof(target->thread.fpu.fpr[0]) == regset->size) {
+		/* Trivially copy the vector registers */
+		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.fpu.fpr,
+					  0, wr_size);
+	} else {
+		/* Copy as much context as possible, fill the rest with 0xff */
+		err = copy_pad_fprs(target, regset, &pos, &count,
+				    &kbuf, &ubuf,
+				    sizeof(target->thread.fpu.fpr[0]));
+	}
+
+	err |= user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &ctrl_regs, wr_size,
+				   wr_size + sizeof(ctrl_regs));
+	return err;
+}
+
+static int msa_set(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
+	struct msa_control_regs ctrl_regs;
+	unsigned int cp_sz;
+	int i, err, start;
+
+	init_fp_ctx(target);
+
+	if (sizeof(target->thread.fpu.fpr[0]) == regset->size) {
+		/* Trivially copy the vector registers */
+		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &target->thread.fpu.fpr,
+					 0, wr_size);
+	} else {
+		/* Copy as much context as possible */
+		cp_sz = min_t(unsigned int, regset->size,
+			      sizeof(target->thread.fpu.fpr[0]));
+
+		i = start = err = 0;
+		for (; i < NUM_FPU_REGS; i++, start += regset->size) {
+			err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						  &target->thread.fpu.fpr[i],
+						  start, start + cp_sz);
+		}
+	}
+
+	if (!err)
+		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl_regs,
+					 wr_size, wr_size + sizeof(ctrl_regs));
+	if (!err) {
+		target->thread.fpu.fcr31 = ctrl_regs.fcsr & ~FPU_CSR_ALL_X;
+		target->thread.fpu.msacsr = ctrl_regs.msacsr & ~MSA_CSR_CAUSEF;
+	}
+
+	return err;
+}
+
+#endif /* CONFIG_CPU_HAS_MSA */
+
 #if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
 
 /*
@@ -798,6 +922,9 @@ enum mips_regset {
 	REGSET_FPR,
 	REGSET_FP_MODE,
 #endif
+#ifdef CONFIG_CPU_HAS_MSA
+	REGSET_MSA,
+#endif
 };
 
 struct pt_regs_offset {
@@ -922,6 +1049,16 @@ static const struct user_regset mips_regsets[] = {
 		.set		= fp_mode_set,
 	},
 #endif
+#ifdef CONFIG_CPU_HAS_MSA
+	[REGSET_MSA] = {
+		.core_note_type	= NT_MIPS_MSA,
+		.n		= NUM_FPU_REGS + 1,
+		.size		= 16,
+		.align		= 16,
+		.get		= msa_get,
+		.set		= msa_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_mips_view = {
@@ -972,6 +1109,16 @@ static const struct user_regset mips64_regsets[] = {
 		.set		= fpr_set,
 	},
 #endif
+#ifdef CONFIG_CPU_HAS_MSA
+	[REGSET_MSA] = {
+		.core_note_type	= NT_MIPS_MSA,
+		.n		= NUM_FPU_REGS + 1,
+		.size		= 16,
+		.align		= 16,
+		.get		= msa_get,
+		.set		= msa_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_mips64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c5358e0ae7c5..d1b093f931e3 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -424,6 +424,7 @@ typedef struct elf64_shdr {
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
+#define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
 
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
-- 
2.19.1
