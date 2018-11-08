Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 21:14:46 +0100 (CET)
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:60240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990429AbeKHUOlxcKLI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 21:14:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnG2Qb4lCBK9d/l0A1L8p7nFnkEtNIWfAfjhJtd7sNM=;
 b=MOesgzw5D2xchFFmBXOKW5QBTfaQUuS66GUY/RbT3yG/UujcWZjVaPyvvtpyulhUjevjDa0LY3JbfCwvJNfkYkAH5HmogTp+tC5/uSpVXT7kx2PHjtOWKUXcHJIDBlx6T/CkzNl4KrzPrsw0LtozPFgCeit9WpKxMxbTB9isy6Q=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1422.namprd22.prod.outlook.com (10.172.63.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.22; Thu, 8 Nov 2018 20:14:38 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 20:14:38 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Avoid using .set mips0 to restore ISA
Thread-Topic: [PATCH] MIPS: Avoid using .set mips0 to restore ISA
Thread-Index: AQHUd5+smDXaSHv3s0a8JFdkhOmXFw==
Date:   Thu, 8 Nov 2018 20:14:38 +0000
Message-ID: <20181108201426.18512-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1422;6:cpGCIo8CJvHLb4jpabMZU7AByHag27HNdGVzWyl6xLIBB//OFCVVgD8gUVRvr6LuDej8H/RwTa3jtvpCa2qY8jUPFgqlrd3Eltdz/MFMoYm8RJM/a2pGfVhyUR47iT3BSpR63WbwDl8zpRoNODXQP9Mcc/UuPSBk0v3CYfiI23N7gsjAbEL3WH4AR9+dDNcj1I+fMnZEoca6WeFMn5+vxbfef5qmXCy97Egw1TeUCos6hGHGXUGSlI1j3QZxt5naSd5QDGRvQElHJ/piUhKtEVnKULhWb5cA84UvXnyMkdKxXlqol1yTqwTTqMqSW14K2Lhx1Y0oYOzy2A38LIKLCkXZ10nxgG/C5t8KTariUfQ5lQjVRbWoJoOJiWUTcjtK2MVFL5rEVErskUqJMe9BB8yZe/ighMqz11KZdz0AMGvkJlBqVaBjo8dcEjPUKNCus+GcgmGKbIopMU6yIEVOgA==;5:ptKFWwxBXgM9BTT5+h11q23+xNjeirLz3OvTD1SZ7rqWrJAWin/LU236Utkdfj1xolhs/HwKGgM3w8xsWCUfNFwjZpTsvs/jPD1xfsSdYu0wRkRwzuiEloaY0n5mAZEzg0XaugMqPK91jrJOvzh1Tqt1GC8ADCkAaOiMmo6FT0I=;7:fUwqE2KGWGNOuM0oSdtbESlsn+byT3F5kysR50buXo++HFJR8ti9JZVGSiBJ63VSzJWxPgNEkVXG7j0n9osiWcUX/BAUBVc6Xr8JyEdaG3ewA6c63Ugti8pUskHT/ML1JmByzT2D1cWpBjD87rgYrg==
x-ms-office365-filtering-correlation-id: c765bbf7-a3a1-4652-276b-08d645b6cf0c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1422;
x-ms-traffictypediagnostic: MWHPR2201MB1422:
x-microsoft-antispam-prvs: <MWHPR2201MB14229582DCAF4301D88B98EDC1C50@MWHPR2201MB1422.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1422;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1422;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(52314003)(2351001)(53936002)(5640700003)(53946003)(107886003)(6512007)(14454004)(386003)(52116002)(106356001)(99286004)(105586002)(6436002)(36756003)(3846002)(1076002)(508600001)(2900100001)(97736004)(6506007)(6916009)(2906002)(6486002)(6116002)(2616005)(25786009)(575784001)(8936002)(5660300001)(2501003)(42882007)(26005)(305945005)(81156014)(81166006)(7736002)(186003)(1857600001)(486006)(4744004)(256004)(102836004)(71200400001)(8676002)(14444005)(4326008)(66066001)(68736007)(71190400001)(316002)(476003)(44832011)(142923001)(559001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1422;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +2QSO9K7i//C0a8WJqIEROW+eSHipMX2fo3BZabqChzUIYGfaiMi/Fw3Jb3HaLxU6sFy+6qst2lfHCNZOzJ3zfQImd8tv9wDjG7TMsI6w7CgypDlrGRGEw5i751TuLIMB54KbBb+w7glZHepaRHC/buvEsQug8n89POPhhpjPKlOgru9y/DnUmaVYE7h7mo7cmtVUysYwgS68auyo/ksxJ79dUTq0fRFap3EiNYzkyX39OawA5r135UgA2knuVteCVP7gc7wygsKXLVAuFBAHiFQiofeFKZvGC/GAB3EzoD55plunRyMm/+C8mqXUzJVH5+urMqg9lAFdmJEAEzXkiHiUT1pAELrtRfXKOp0/3I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c765bbf7-a3a1-4652-276b-08d645b6cf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 20:14:38.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1422
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67179
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

We currently have 2 commonly used methods for switching ISA within
assembly code, then restoring the original ISA.

  1) Using a pair of .set push & .set pop directives. For example:

     .set	push
     .set	mips32r2
     <some_insn>
     .set	pop

  2) Using .set mips0 to restore the ISA originally specified on the
     command line. For example:

     .set	mips32r2
     <some_insn>
     .set	mips0

Unfortunately method 2 does not work with nanoMIPS toolchains, where the
assembler rejects the .set mips0 directive like so:

     Error: cannot change ISA from nanoMIPS to mips0

In preparation for supporting nanoMIPS builds, switch all instances of
method 2 in generic non-platform-specific code to use push & pop as in
method 1 instead. The .set push & .set pop is arguably cleaner anyway,
and if nothing else it's good to consistently use one method.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/atomic.h     | 27 ++++++++++++-------
 arch/mips/include/asm/bitops.h     | 42 ++++++++++++++++++++----------
 arch/mips/include/asm/cmpxchg.h    |  6 +++--
 arch/mips/include/asm/edac.h       |  3 ++-
 arch/mips/include/asm/futex.h      | 14 +++++-----
 arch/mips/include/asm/hazards.h    |  6 +++--
 arch/mips/include/asm/io.h         | 10 ++++---
 arch/mips/include/asm/kvm_host.h   |  9 ++++---
 arch/mips/include/asm/local.h      | 12 ++++++---
 arch/mips/include/asm/mipsmtregs.h |  7 ++---
 arch/mips/include/asm/mipsregs.h   | 30 ++++++++++++++-------
 arch/mips/include/asm/pgtable.h    |  6 ++---
 arch/mips/include/asm/stackframe.h |  3 ++-
 arch/mips/kernel/genex.S           |  3 ++-
 arch/mips/kernel/idle.c            |  5 ++--
 arch/mips/kernel/syscall.c         |  6 +++--
 16 files changed, 121 insertions(+), 68 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index d4ea7a5b60cf..e8fbfd419151 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -59,12 +59,13 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		"	.set	push					\n"   \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%0, %1		# atomic_" #op "	\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	sc	%0, %1					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
-		"	.set	mips0					\n"   \
+		"	.set	pop					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
 	} else {							      \
@@ -85,13 +86,14 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		"	.set	push					\n"   \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%1, %2		# atomic_" #op "_return	\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
-		"	.set	mips0					\n"   \
+		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
@@ -117,12 +119,13 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		"	.set	push					\n"   \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%1, %2		# atomic_fetch_" #op "	\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
-		"	.set	mips0					\n"   \
+		"	.set	pop					\n"   \
 		"	move	%0, %1					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
@@ -188,17 +191,19 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		int temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		"	subu	%0, %1, %3				\n"
 		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"	sc	%1, %2					\n"
 		"\t" __scbeqz "	%1, 1b					\n"
 		"1:							\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i));
@@ -252,12 +257,13 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		"	.set	push					\n"   \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	lld	%0, %1		# atomic64_" #op "	\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	scd	%0, %1					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
-		"	.set	mips0					\n"   \
+		"	.set	pop					\n"   \
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)	      \
 		: "Ir" (i));						      \
 	} else {							      \
@@ -278,13 +284,14 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		"	.set	push					\n"   \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	lld	%1, %2		# atomic64_" #op "_return\n"  \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
-		"	.set	mips0					\n"   \
+		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
@@ -310,13 +317,14 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 		long temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		"	.set	push					\n"   \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	lld	%1, %2		# atomic64_fetch_" #op "\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
 		"\t" __scbeqz "	%0, 1b					\n"   \
 		"	move	%0, %1					\n"   \
-		"	.set	mips0					\n"   \
+		"	.set	pop					\n"   \
 		: "=&r" (result), "=&r" (temp),				      \
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)			      \
 		: "Ir" (i));						      \
@@ -382,6 +390,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
@@ -390,7 +399,7 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		"	scd	%1, %2					\n"
 		"\t" __scbeqz "	%1, 1b					\n"
 		"1:							\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "Ir" (i));
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index da1b8718861e..f2a840fb6a9a 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -58,12 +58,13 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	" __LL "%0, %1			# set_bit	\n"
 		"	or	%0, %2					\n"
 		"	" __SC	"%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*m)
 		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
@@ -80,11 +81,12 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 	} else if (kernel_uses_llsc) {
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL "%0, %1		# set_bit	\n"
 			"	or	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
@@ -110,12 +112,13 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	" __LL "%0, %1			# clear_bit	\n"
 		"	and	%0, %2					\n"
 		"	" __SC "%0, %1					\n"
 		"	beqzl	%0, 1b					\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 		: "ir" (~(1UL << bit)));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
@@ -132,11 +135,12 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 	} else if (kernel_uses_llsc) {
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL "%0, %1		# clear_bit	\n"
 			"	and	%0, %2				\n"
 			"	" __SC "%0, %1				\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (~(1UL << bit)));
 		} while (unlikely(!temp));
@@ -176,12 +180,13 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push				\n"
 		"	.set	arch=r4000			\n"
 		"1:	" __LL "%0, %1		# change_bit	\n"
 		"	xor	%0, %2				\n"
 		"	" __SC	"%0, %1				\n"
 		"	beqzl	%0, 1b				\n"
-		"	.set	mips0				\n"
+		"	.set	pop				\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 		: "ir" (1UL << bit));
 	} else if (kernel_uses_llsc) {
@@ -190,11 +195,12 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL "%0, %1		# change_bit	\n"
 			"	xor	%0, %2				\n"
 			"	" __SC	"%0, %1				\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m)
 			: "ir" (1UL << bit));
 		} while (unlikely(!temp));
@@ -223,13 +229,14 @@ static inline int test_and_set_bit(unsigned long nr,
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
@@ -239,11 +246,12 @@ static inline int test_and_set_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL "%0, %1	# test_and_set_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
@@ -277,13 +285,14 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
 		"	or	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "+m" (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
@@ -293,11 +302,12 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL "%0, %1	# test_and_set_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	" __SC	"%2, %1				\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
@@ -332,6 +342,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
 		"	or	%2, %0, %3				\n"
@@ -339,7 +350,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
@@ -365,12 +376,13 @@ static inline int test_and_clear_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL	"%0, %1 # test_and_clear_bit	\n"
 			"	or	%2, %0, %3			\n"
 			"	xor	%2, %3				\n"
 			"	" __SC	"%2, %1				\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
@@ -406,13 +418,14 @@ static inline int test_and_change_bit(unsigned long nr,
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
 		"	xor	%2, %0, %3				\n"
 		"	" __SC	"%2, %1					\n"
 		"	beqzl	%2, 1b					\n"
 		"	and	%2, %0, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 		: "r" (1UL << bit)
 		: "memory");
@@ -422,11 +435,12 @@ static inline int test_and_change_bit(unsigned long nr,
 
 		do {
 			__asm__ __volatile__(
+			"	.set	push				\n"
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	" __LL	"%0, %1 # test_and_change_bit	\n"
 			"	xor	%2, %0, %3			\n"
 			"	" __SC	"\t%2, %1			\n"
-			"	.set	mips0				\n"
+			"	.set	pop				\n"
 			: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (*m), "=&r" (res)
 			: "r" (1UL << bit)
 			: "memory");
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7976fe..638de0c25249 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -47,9 +47,10 @@ extern unsigned long __xchg_called_with_bad_pointer(void)
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
+		"	.set	push				\n"	\
 		"	.set	" MIPS_ISA_ARCH_LEVEL "		\n"	\
 		"1:	" ld "	%0, %2		# __xchg_asm	\n"	\
-		"	.set	mips0				\n"	\
+		"	.set	pop				\n"	\
 		"	move	$1, %z3				\n"	\
 		"	.set	" MIPS_ISA_ARCH_LEVEL "		\n"	\
 		"	" st "	$1, %1				\n"	\
@@ -117,10 +118,11 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
+		"	.set	push				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
 		"	bne	%0, %z3, 2f			\n"	\
-		"	.set	mips0				\n"	\
+		"	.set	pop				\n"	\
 		"	move	$1, %z4				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"	" st "	$1, %1				\n"	\
diff --git a/arch/mips/include/asm/edac.h b/arch/mips/include/asm/edac.h
index fc467767329b..c5d147744423 100644
--- a/arch/mips/include/asm/edac.h
+++ b/arch/mips/include/asm/edac.h
@@ -21,12 +21,13 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 		 */
 
 		__asm__ __volatile__ (
+		"	.set	push					\n"
 		"	.set	mips2					\n"
 		"1:	ll	%0, %1		# edac_atomic_scrub	\n"
 		"	addu	%0, $0					\n"
 		"	sc	%0, %1					\n"
 		"	beqz	%0, 1b					\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*virt_addr)
 		: GCC_OFF_SMALL_ASM() (*virt_addr));
 
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index a9e61ea54ca9..8eff134b3a43 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -24,9 +24,10 @@
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
+		"	.set	push				\n"	\
 		"	.set	arch=r4000			\n"	\
 		"1:	ll	%1, %4	# __futex_atomic_op	\n"	\
-		"	.set	mips0				\n"	\
+		"	.set	pop				\n"	\
 		"	" insn	"				\n"	\
 		"	.set	arch=r4000			\n"	\
 		"2:	sc	$1, %2				\n"	\
@@ -35,7 +36,6 @@
 		"3:						\n"	\
 		"	.insn					\n"	\
 		"	.set	pop				\n"	\
-		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
 		"4:	li	%0, %6				\n"	\
 		"	j	3b				\n"	\
@@ -53,9 +53,10 @@
 		__asm__ __volatile__(					\
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
+		"	.set	push				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"1:	"user_ll("%1", "%4")" # __futex_atomic_op\n"	\
-		"	.set	mips0				\n"	\
+		"	.set	pop				\n"	\
 		"	" insn	"				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"2:	"user_sc("$1", "%2")"			\n"	\
@@ -64,7 +65,6 @@
 		"3:						\n"	\
 		"	.insn					\n"	\
 		"	.set	pop				\n"	\
-		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
 		"4:	li	%0, %6				\n"	\
 		"	j	3b				\n"	\
@@ -137,10 +137,11 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"# futex_atomic_cmpxchg_inatomic			\n"
 		"	.set	push					\n"
 		"	.set	noat					\n"
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:	ll	%1, %3					\n"
 		"	bne	%1, %z4, 3f				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		"	move	$1, %z5					\n"
 		"	.set	arch=r4000				\n"
 		"2:	sc	$1, %2					\n"
@@ -166,10 +167,11 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"# futex_atomic_cmpxchg_inatomic			\n"
 		"	.set	push					\n"
 		"	.set	noat					\n"
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"1:	"user_ll("%1", "%3")"				\n"
 		"	bne	%1, %z4, 3f				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		"	move	$1, %z5					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"2:	"user_sc("$1", "%2")"				\n"
diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index e0fecf206f2c..0fa27446869a 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -66,10 +66,11 @@ do {									\
 	unsigned long tmp;						\
 									\
 	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
 	"	.set "MIPS_ISA_LEVEL"				\n"	\
 	"	dla	%0, 1f					\n"	\
 	"	jr.hb	%0					\n"	\
-	"	.set	mips0					\n"	\
+	"	.set	pop					\n"	\
 	"1:							\n"	\
 	: "=r" (tmp));							\
 } while (0)
@@ -141,10 +142,11 @@ do {									\
 	unsigned long tmp;						\
 									\
 	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
 	"	.set	mips64r2				\n"	\
 	"	dla	%0, 1f					\n"	\
 	"	jr.hb	%0					\n"	\
-	"	.set	mips0					\n"	\
+	"	.set	pop					\n"	\
 	"1:							\n"	\
 	: "=r" (tmp));							\
 } while (0)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index b5322f7386bf..845fbbc7a2e3 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -354,13 +354,14 @@ static inline void pfx##write##bwlq(type val,				\
 		if (irq)						\
 			local_irq_save(__flags);			\
 		__asm__ __volatile__(					\
-			".set	arch=r4000"	"\t\t# __writeq""\n\t"	\
+			".set	push"		"\t\t# __writeq""\n\t"	\
+			".set	arch=r4000"			"\n\t"	\
 			"dsll32 %L0, %L0, 0"			"\n\t"	\
 			"dsrl32 %L0, %L0, 0"			"\n\t"	\
 			"dsll32 %M0, %M0, 0"			"\n\t"	\
 			"or	%L0, %L0, %M0"			"\n\t"	\
 			"sd	%L0, %2"			"\n\t"	\
-			".set	mips0"				"\n"	\
+			".set	pop"				"\n"	\
 			: "=r" (__tmp)					\
 			: "0" (__val), "m" (*__mem));			\
 		if (irq)						\
@@ -387,11 +388,12 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 		if (irq)						\
 			local_irq_save(__flags);			\
 		__asm__ __volatile__(					\
-			".set	arch=r4000"	"\t\t# __readq" "\n\t"	\
+			".set	push"		"\t\t# __readq" "\n\t"	\
+			".set	arch=r4000"			"\n\t"	\
 			"ld	%L0, %1"			"\n\t"	\
 			"dsra32 %M0, %L0, 0"			"\n\t"	\
 			"sll	%L0, %L0, 0"			"\n\t"	\
-			".set	mips0"				"\n"	\
+			".set	pop"				"\n"	\
 			: "=r" (__val)					\
 			: "m" (*__mem));				\
 		if (irq)						\
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2c1c53d12179..e445026858bc 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -411,11 +411,12 @@ static inline void _kvm_atomic_set_c0_guest_reg(unsigned long *reg,
 	unsigned long temp;
 	do {
 		__asm__ __volatile__(
+		"	.set	push				\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 		"	" __LL "%0, %1				\n"
 		"	or	%0, %2				\n"
 		"	" __SC	"%0, %1				\n"
-		"	.set	mips0				\n"
+		"	.set	pop				\n"
 		: "=&r" (temp), "+m" (*reg)
 		: "r" (val));
 	} while (unlikely(!temp));
@@ -427,11 +428,12 @@ static inline void _kvm_atomic_clear_c0_guest_reg(unsigned long *reg,
 	unsigned long temp;
 	do {
 		__asm__ __volatile__(
+		"	.set	push				\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 		"	" __LL "%0, %1				\n"
 		"	and	%0, %2				\n"
 		"	" __SC	"%0, %1				\n"
-		"	.set	mips0				\n"
+		"	.set	pop				\n"
 		: "=&r" (temp), "+m" (*reg)
 		: "r" (~val));
 	} while (unlikely(!temp));
@@ -444,12 +446,13 @@ static inline void _kvm_atomic_change_c0_guest_reg(unsigned long *reg,
 	unsigned long temp;
 	do {
 		__asm__ __volatile__(
+		"	.set	push				\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 		"	" __LL "%0, %1				\n"
 		"	and	%0, %2				\n"
 		"	or	%0, %3				\n"
 		"	" __SC	"%0, %1				\n"
-		"	.set	mips0				\n"
+		"	.set	pop				\n"
 		: "=&r" (temp), "+m" (*reg)
 		: "r" (~change), "r" (val & change));
 	} while (unlikely(!temp));
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index ac8264eca1e9..02783e141c32 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -35,13 +35,14 @@ static __inline__ long local_add_return(long i, local_t * l)
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:"	__LL	"%1, %2		# local_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
@@ -49,13 +50,14 @@ static __inline__ long local_add_return(long i, local_t * l)
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"1:"	__LL	"%1, %2		# local_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
 		"	beqz	%0, 1b					\n"
 		"	addu	%0, %1, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
@@ -80,13 +82,14 @@ static __inline__ long local_sub_return(long i, local_t * l)
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"1:"	__LL	"%1, %2		# local_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
 		"	beqzl	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
@@ -94,13 +97,14 @@ static __inline__ long local_sub_return(long i, local_t * l)
 		unsigned long temp;
 
 		__asm__ __volatile__(
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"1:"	__LL	"%1, %2		# local_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
 		"	beqz	%0, 1b					\n"
 		"	subu	%0, %1, %3				\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: "=&r" (result), "=&r" (temp), "=m" (l->a.counter)
 		: "Ir" (i), "m" (l->a.counter)
 		: "memory");
diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index 212336b7c0f4..be4cf9d477be 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -255,12 +255,12 @@ static inline unsigned int dmt(void)
 static inline void __raw_emt(void)
 {
 	__asm__ __volatile__(
+	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	mips32r2					\n"
 	"	.word	0x41600be1			# emt		\n"
 	"	ehb							\n"
-	"	.set	mips0						\n"
-	"	.set	reorder");
+	"	.set	pop");
 }
 
 /* enable multi-threaded execution if previous suggested it should be.
@@ -277,9 +277,10 @@ static inline void emt(int previous)
 static inline void ehb(void)
 {
 	__asm__ __volatile__(
+	"	.set	push					\n"
 	"	.set	mips32r2				\n"
 	"	ehb						\n"
-	"	.set	mips0					\n");
+	"	.set	pop					\n");
 }
 
 #define mftc0(rt,sel)							\
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 341a02c92985..402b80af91aa 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1345,9 +1345,10 @@ do {								\
 			: "=r" (__res));				\
 	else								\
 		__asm__ vol(						\
+			".set\tpush\n\t"				\
 			".set\tmips32\n\t"				\
 			"mfc0\t%0, " #source ", " #sel "\n\t"		\
-			".set\tmips0\n\t"				\
+			".set\tpop\n\t"					\
 			: "=r" (__res));				\
 	__res;								\
 })
@@ -1358,15 +1359,17 @@ do {								\
 		__res = __read_64bit_c0_split(source, sel, vol);	\
 	else if (sel == 0)						\
 		__asm__ vol(						\
+			".set\tpush\n\t"				\
 			".set\tmips3\n\t"				\
 			"dmfc0\t%0, " #source "\n\t"			\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: "=r" (__res));				\
 	else								\
 		__asm__ vol(						\
+			".set\tpush\n\t"				\
 			".set\tmips64\n\t"				\
 			"dmfc0\t%0, " #source ", " #sel "\n\t"		\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: "=r" (__res));				\
 	__res;								\
 })
@@ -1391,9 +1394,10 @@ do {									\
 			: : "Jr" ((unsigned int)(value)));		\
 	else								\
 		__asm__ __volatile__(					\
+			".set\tpush\n\t"				\
 			".set\tmips32\n\t"				\
 			"mtc0\t%z0, " #register ", " #sel "\n\t"	\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: : "Jr" ((unsigned int)(value)));		\
 } while (0)
 
@@ -1403,15 +1407,17 @@ do {									\
 		__write_64bit_c0_split(register, sel, value);		\
 	else if (sel == 0)						\
 		__asm__ __volatile__(					\
+			".set\tpush\n\t"				\
 			".set\tmips3\n\t"				\
 			"dmtc0\t%z0, " #register "\n\t"			\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: : "Jr" (value));				\
 	else								\
 		__asm__ __volatile__(					\
+			".set\tpush\n\t"				\
 			".set\tmips64\n\t"				\
 			"dmtc0\t%z0, " #register ", " #sel "\n\t"	\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: : "Jr" (value));				\
 } while (0)
 
@@ -1463,19 +1469,21 @@ do {									\
 	local_irq_save(__flags);					\
 	if (sel == 0)							\
 		__asm__ vol(						\
+			".set\tpush\n\t"				\
 			".set\tmips64\n\t"				\
 			"dmfc0\t%L0, " #source "\n\t"			\
 			"dsra\t%M0, %L0, 32\n\t"			\
 			"sll\t%L0, %L0, 0\n\t"				\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: "=r" (__val));				\
 	else								\
 		__asm__ vol(						\
+			".set\tpush\n\t"				\
 			".set\tmips64\n\t"				\
 			"dmfc0\t%L0, " #source ", " #sel "\n\t"		\
 			"dsra\t%M0, %L0, 32\n\t"			\
 			"sll\t%L0, %L0, 0\n\t"				\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: "=r" (__val));				\
 	local_irq_restore(__flags);					\
 									\
@@ -1498,23 +1506,25 @@ do {									\
 			: "+r" (__tmp));				\
 	else if (sel == 0)						\
 		__asm__ __volatile__(					\
+			".set\tpush\n\t"				\
 			".set\tmips64\n\t"				\
 			"dsll\t%L0, %L0, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
 			"dsll\t%M0, %M0, 32\n\t"			\
 			"or\t%L0, %L0, %M0\n\t"				\
 			"dmtc0\t%L0, " #source "\n\t"			\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: "+r" (__tmp));				\
 	else								\
 		__asm__ __volatile__(					\
+			".set\tpush\n\t"				\
 			".set\tmips64\n\t"				\
 			"dsll\t%L0, %L0, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
 			"dsll\t%M0, %M0, 32\n\t"			\
 			"or\t%L0, %L0, %M0\n\t"				\
 			"dmtc0\t%L0, " #source ", " #sel "\n\t"		\
-			".set\tmips0"					\
+			".set\tpop"					\
 			: "+r" (__tmp));				\
 	local_irq_restore(__flags);					\
 } while (0)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 129e0328367f..57933fc8fd98 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -214,8 +214,8 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 
 		if (kernel_uses_llsc && R10000_LLSC_WAR) {
 			__asm__ __volatile__ (
-			"	.set	arch=r4000			\n"
 			"	.set	push				\n"
+			"	.set	arch=r4000			\n"
 			"	.set	noreorder			\n"
 			"1:"	__LL	"%[tmp], %[buddy]		\n"
 			"	bnez	%[tmp], 2f			\n"
@@ -225,13 +225,12 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	nop					\n"
 			"2:						\n"
 			"	.set	pop				\n"
-			"	.set	mips0				\n"
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
 		} else if (kernel_uses_llsc) {
 			__asm__ __volatile__ (
-			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	.set	push				\n"
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	.set	noreorder			\n"
 			"1:"	__LL	"%[tmp], %[buddy]		\n"
 			"	bnez	%[tmp], 2f			\n"
@@ -241,7 +240,6 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	nop					\n"
 			"2:						\n"
 			"	.set	pop				\n"
-			"	.set	mips0				\n"
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
 		}
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 2161357cc68f..4d6ad907ae54 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -427,9 +427,10 @@
 #ifdef CONFIG_CPU_MIPSR6
 		eretnc
 #else
+		.set	push
 		.set	arch=r4000
 		eret
-		.set	mips0
+		.set	pop
 #endif
 		.endm
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 6c0c0d0c30bd..398b905b027d 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -652,9 +652,10 @@ isrdhwr:
 	ori	k1, _THREAD_MASK
 	xori	k1, _THREAD_MASK
 	LONG_L	v1, TI_TP_VALUE(k1)
+	.set	push
 	.set	arch=r4000
 	eret
-	.set	mips0
+	.set	pop
 #endif
 	.set	pop
 	END(handle_ri_rdhwr)
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 046846999efd..4d335b15826e 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -101,7 +101,8 @@ static void __cpuidle au1k_wait(void)
 	unsigned long c0status = read_c0_status() | 1;	/* irqs on */
 
 	__asm__(
-	"	.set	arch=r4000			\n"
+	"	.set	push			\n"
+	"	.set	arch=r4000		\n"
 	"	cache	0x14, 0(%0)		\n"
 	"	cache	0x14, 32(%0)		\n"
 	"	sync				\n"
@@ -111,7 +112,7 @@ static void __cpuidle au1k_wait(void)
 	"	nop				\n"
 	"	nop				\n"
 	"	nop				\n"
-	"	.set	mips0			\n"
+	"	.set	pop			\n"
 	: : "r" (au1k_wait), "r" (c0status));
 }
 
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 69c17b549fd3..41a0db08cd37 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -106,6 +106,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		__asm__ __volatile__ (
+		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
 		"	li	%[err], 0				\n"
 		"1:	ll	%[old], (%[addr])			\n"
@@ -122,7 +123,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"	"STR(PTR)"	1b, 4b				\n"
 		"	"STR(PTR)"	2b, 4b				\n"
 		"	.previous					\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: [old] "=&r" (old),
 		  [err] "=&r" (err),
 		  [tmp] "=&r" (tmp)
@@ -132,6 +133,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		: "memory");
 	} else if (cpu_has_llsc) {
 		__asm__ __volatile__ (
+		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
 		"1:							\n"
@@ -150,7 +152,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"	"STR(PTR)"	1b, 5b				\n"
 		"	"STR(PTR)"	2b, 5b				\n"
 		"	.previous					\n"
-		"	.set	mips0					\n"
+		"	.set	pop					\n"
 		: [old] "=&r" (old),
 		  [err] "=&r" (err),
 		  [tmp] "=&r" (tmp)
-- 
2.19.1
