Return-Path: <SRS0=GeJD=PU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF9C43387
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 03:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3742086C
	for <linux-mips@archiver.kernel.org>; Sat, 12 Jan 2019 03:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfALDZ2 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:25:28 -0500
Received: from mail.loongson.cn ([114.242.206.163]:55892 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfALDZ2 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 11 Jan 2019 22:25:28 -0500
Received: from ambrosehua-ThinkPad-X201s (unknown [10.20.42.116])
        by mail (Coremail) with SMTP id QMiowPDx+b4eXjlc5attAA--.4008S2;
        Sat, 12 Jan 2019 11:25:19 +0800 (CST)
Date:   Sat, 12 Jan 2019 11:25:18 +0800
From:   huangpei <huangpei@loongson.cn>
To:     =?UTF-8?B?5b6Q5oiQ5Y2O?= <xuchenghua@loongson.cn>
Cc:     paul.burton@mips.com, ysu@wavecomp.com, pburton@wavecomp.com,
        linux-mips@vger.kernel.org, chenhc@lemote.com, zhangfx@lemote.com,
        wuzhangjin@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
Message-ID: <20190112112518.4cc0b1d7@ambrosehua-ThinkPad-X201s>
In-Reply-To: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
References: <37e1dca1.5987.1683cede2ff.Coremail.xuchenghua@loongson.cn>
Organization: Loongson
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_//bnUSBHJc++7d8CF.feLcdS"
X-CM-TRANSID: QMiowPDx+b4eXjlc5attAA--.4008S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW3Aw1kuw4UKry3KrWxJFb_yoW5GrW3pF
        WSvw1UAw4FyFnrJa1fuayxZF1Sgw45GFsFyw1Ik34vkas8Cr1vy34Iqw45u3ZxGrnFka4Y
        qr4qvr1DZayDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vE
        w4AK0wACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j
        6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUjtfHUUUUUU==
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

--MP_//bnUSBHJc++7d8CF.feLcdS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, this is the patch for ll/sc bug in Loongson3 based on Linux-4.20
(8fe28cb58bcb235034b64cbbb7550a8a43fd88be)

+. it cover all loongson3 CPU;

+. to fix the ll/sc bug *sufficiently and exactly*, this patch shows
how many places need to touch

+. it is built ok for on Loongson3 and Cavium/Octeon, old version is
tested in high pressure test


On Fri, 11 Jan 2019 20:40:49 +0800 (GMT+08:00)
=E5=BE=90=E6=88=90=E5=8D=8E <xuchenghua@loongson.cn> wrote:

> Hi Paul Burton,
>=20
> For Loongson 3A1000 and 3A3000, when a memory access instruction
> (load, store, or prefetch)'s executing occurs between the execution
> of LL and SC, the success or failure of SC is not predictable.
> Although programmer would not insert memory access instructions
> between LL and SC, the memory instructions before LL in
> program-order, may dynamically executed between the execution of
> LL/SC, so a memory fence(SYNC) is needed before LL/LLD to avoid this
> situation.
>=20
> Since 3A3000, we improved our hardware design to handle this case.
> But we later deduce a rarely circumstance that some speculatively
> executed memory instructions due to branch misprediction between
> LL/SC still fall into the above case, so a memory fence(SYNC) at
> branch-target(if its target is not between LL/SC) is needed for
> 3A1000 and 3A3000.
>=20
> Our processor is continually evolving and we aim to to remove all
> these workaround-SYNCs around LL/SC for new-come processor.=20
>=20
> =E5=8C=97=E4=BA=AC=E5=B8=82=E6=B5=B7=E6=B7=80=E5=8C=BA=E4=B8=AD=E5=85=B3=
=E6=9D=91=E7=8E=AF=E4=BF=9D=E7=A7=91=E6=8A=80=E7=A4=BA=E8=8C=83=E5=9B=AD=E9=
=BE=99=E8=8A=AF=E4=BA=A7=E4=B8=9A=E5=9B=AD2=E5=8F=B7=E6=A5=BC 100095=E7=94=
=B5=E8=AF=9D: +86 (10)
> 62546668=E4=BC=A0=E7=9C=9F: +86 (10)
> 62600826www.loongson.cn=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=
=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E9=BE=99=E8=8A=AF=E4=B8=AD=E7=A7=91=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E5=95=86=E4=B8=9A=
=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=
=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=
=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=
=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=
=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8
> =E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=
=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=
=99=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=
=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC=E9=82=AE=E4=BB=B6=E3=80=82=20
>=20
> This email and its attachments contain confidential information from
> Loongson Technology Corporation Limited, which is intended only for
> the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited
> to, total or partial disclosure, reproduction or dissemination) by
> persons other than the intended recipient(s) is prohibited. If you
> receive this email in error, please notify the sender by phone or
> email immediately and delete it.=20

--MP_//bnUSBHJc++7d8CF.feLcdS
Content-Type: text/x-patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=0001-loongson64-add-helper-for-ll-sc-bugfix-in-loongson3.patch

=46rom 510d8c6cce97c7fb62ee2bf81c1856438583c328 Mon Sep 17 00:00:00 2001
From: Huang Pei <huangpei@loongson.cn>
Date: Sat, 12 Jan 2019 09:37:18 +0800
Subject: [PATCH 1/3] loongson64: add helper for ll/sc bugfix in loongson3
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

there is a bug in ll/sc operation on loongson 3=EF=BC=8C that it causes
two concurrent ll/sc on same variable both succeed, which is
unacceptable clearly

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/barrier.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrie=
r.h
index a5eb1bb..fc21eb5 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -203,6 +203,16 @@
 #define __WEAK_LLSC_MB		"		\n"
 #endif
=20
+#if defined(CONFIG_CPU_LOONGSON3)
+#define __LS3A_WAR_LLSC		"	.set mips64r2\nsynci 0\n.set mips0\n"
+#define __ls3a_war_llsc()	__asm__ __volatile__("synci 0" : : :"memory")
+#define __LS_WAR_LLSC		"	.set mips3\nsync\n.set mips0\n"
+#else
+#define __LS3A_WAR_LLSC
+#define __ls3a_war_llsc()
+#define __LS_WAR_LLSC
+#endif
+
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
=20
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
--=20
2.7.4


--MP_//bnUSBHJc++7d8CF.feLcdS
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0002-loongson64-fix-ll-sc-bug-of-loongson3-in-inline-asm.patch

From ebb19370348b0b3f66baeec314b330abc879b91e Mon Sep 17 00:00:00 2001
From: Huang Pei <huangpei@loongson.cn>
Date: Sat, 12 Jan 2019 09:40:31 +0800
Subject: [PATCH 2/3] loongson64: fix ll/sc bug of loongson3 in inline asm

+. without __LS3A_WAR_LLSC before ll, and __LS_WAR_LLSC before
target from branch ins between ll and sc, two ll/sc operation on
same variable can success both, which is clearly wrong.

+. __LS3A_WAR_LLSC is needed for Loongson 3 CPU before 3A2000(NOT
including 3A2000)

+. __LS_WAR_LLSC is needed all Looongson 3 CPU

+. old patch fix cmpxchg.h, but now smp_mb__before_llsc and
smp_llsc_mb in cmpxchg.h is enought

+. change __WEAK_LLSC_MB in futex.h to support same function as
__LS_WAR_LLSC

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/atomic.h  | 6 ++++++
 arch/mips/include/asm/bitops.h  | 6 ++++++
 arch/mips/include/asm/edac.h    | 1 +
 arch/mips/include/asm/futex.h   | 4 +++-
 arch/mips/include/asm/local.h   | 2 ++
 arch/mips/include/asm/pgtable.h | 2 ++
 arch/mips/kernel/syscall.c      | 1 +
 7 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index d4ea7a5..ba48a50 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -59,6 +59,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			      \
 		int temp;						      \
 									      \
 		__asm__ __volatile__(					      \
+		__LS3A_WAR_LLSC						      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
 		"1:	ll	%0, %1		# atomic_" #op "	\n"   \
 		"	" #asm_op " %0, %2				\n"   \
@@ -86,6 +87,7 @@ static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
+		__LS3A_WAR_LLSC						      \
 		"1:	ll	%1, %2		# atomic_" #op "_return	\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
@@ -118,6 +120,7 @@ static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
+		__LS3A_WAR_LLSC						      \
 		"1:	ll	%1, %2		# atomic_fetch_" #op "	\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	sc	%0, %2					\n"   \
@@ -253,6 +256,7 @@ static __inline__ void atomic64_##op(long i, atomic64_t * v)		      \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
+		__LS3A_WAR_LLSC						      \
 		"1:	lld	%0, %1		# atomic64_" #op "	\n"   \
 		"	" #asm_op " %0, %2				\n"   \
 		"	scd	%0, %1					\n"   \
@@ -279,6 +283,7 @@ static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
+		__LS3A_WAR_LLSC						      \
 		"1:	lld	%1, %2		# atomic64_" #op "_return\n"  \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
@@ -311,6 +316,7 @@ static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 									      \
 		__asm__ __volatile__(					      \
 		"	.set	"MIPS_ISA_LEVEL"			\n"   \
+		__LS3A_WAR_LLSC						      \
 		"1:	lld	%1, %2		# atomic64_fetch_" #op "\n"   \
 		"	" #asm_op " %0, %1, %3				\n"   \
 		"	scd	%0, %2					\n"   \
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index da1b8718..ba50277 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -68,6 +68,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		: "ir" (1UL << bit), GCC_OFF_SMALL_ASM() (*m));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
+		__ls3a_war_llsc();
 		do {
 			__asm__ __volatile__(
 			"	" __LL "%0, %1		# set_bit	\n"
@@ -78,6 +79,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
+		__ls3a_war_llsc();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
@@ -120,6 +122,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		: "ir" (~(1UL << bit)));
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 	} else if (kernel_uses_llsc && __builtin_constant_p(bit)) {
+		__ls3a_war_llsc();
 		do {
 			__asm__ __volatile__(
 			"	" __LL "%0, %1		# clear_bit	\n"
@@ -130,6 +133,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *addr)
 		} while (unlikely(!temp));
 #endif /* CONFIG_CPU_MIPSR2 || CONFIG_CPU_MIPSR6 */
 	} else if (kernel_uses_llsc) {
+		__ls3a_war_llsc();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
@@ -188,6 +192,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		__ls3a_war_llsc();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
@@ -291,6 +296,7 @@ static inline int test_and_set_bit_lock(unsigned long nr,
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
 
+		__ls3a_war_llsc();
 		do {
 			__asm__ __volatile__(
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
diff --git a/arch/mips/include/asm/edac.h b/arch/mips/include/asm/edac.h
index fc46776..9141fa2 100644
--- a/arch/mips/include/asm/edac.h
+++ b/arch/mips/include/asm/edac.h
@@ -22,6 +22,7 @@ static inline void edac_atomic_scrub(void *va, u32 size)
 
 		__asm__ __volatile__ (
 		"	.set	mips2					\n"
+		__LS3A_WAR_LLSC
 		"1:	ll	%0, %1		# edac_atomic_scrub	\n"
 		"	addu	%0, $0					\n"
 		"	sc	%0, %1					\n"
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index a9e61ea..0706ac3 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -54,6 +54,7 @@
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
+		__LS3A_WAR_LLSC						\
 		"1:	"user_ll("%1", "%4")" # __futex_atomic_op\n"	\
 		"	.set	mips0				\n"	\
 		"	" insn	"				\n"	\
@@ -167,6 +168,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	.set	push					\n"
 		"	.set	noat					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		__LS3A_WAR_LLSC
 		"1:	"user_ll("%1", "%3")"				\n"
 		"	bne	%1, %z4, 3f				\n"
 		"	.set	mips0					\n"
@@ -174,8 +176,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"2:	"user_sc("$1", "%2")"				\n"
 		"	beqz	$1, 1b					\n"
-		__WEAK_LLSC_MB
 		"3:							\n"
+		__WEAK_LLSC_MB
 		"	.insn						\n"
 		"	.set	pop					\n"
 		"	.section .fixup,\"ax\"				\n"
diff --git a/arch/mips/include/asm/local.h b/arch/mips/include/asm/local.h
index ac8264e..afc64b2 100644
--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -50,6 +50,7 @@ static __inline__ long local_add_return(long i, local_t * l)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		__LS3A_WAR_LLSC
 		"1:"	__LL	"%1, %2		# local_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
@@ -95,6 +96,7 @@ static __inline__ long local_sub_return(long i, local_t * l)
 
 		__asm__ __volatile__(
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+		__LS3A_WAR_LLSC
 		"1:"	__LL	"%1, %2		# local_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 129e032..12a8217 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -233,6 +233,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
 			"	.set	push				\n"
 			"	.set	noreorder			\n"
+			__LS3A_WAR_LLSC
 			"1:"	__LL	"%[tmp], %[buddy]		\n"
 			"	bnez	%[tmp], 2f			\n"
 			"	 or	%[tmp], %[tmp], %[global]	\n"
@@ -240,6 +241,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 			"	beqz	%[tmp], 1b			\n"
 			"	nop					\n"
 			"2:						\n"
+			__LS_WAR_LLSC
 			"	.set	pop				\n"
 			"	.set	mips0				\n"
 			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 69c17b5..b1a0fd3 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -135,6 +135,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
 		"1:							\n"
+		__LS3A_WAR_LLSC
 		user_ll("%[old]", "(%[addr])")
 		"	move	%[tmp], %[new]				\n"
 		"2:							\n"
-- 
2.7.4


--MP_//bnUSBHJc++7d8CF.feLcdS
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0003-loongson64-fix-ll-sc-bug-of-Loongson-3-in-handle_tlb.patch

From 724bbfa3b00accf55d64b19172569fd87c959802 Mon Sep 17 00:00:00 2001
From: Huang Pei <huangpei@loongson.cn>
Date: Sat, 12 Jan 2019 11:01:55 +0800
Subject: [PATCH 3/3] loongson64: fix ll/sc bug of Loongson 3 in
 handle_tlb{m,s,l}

Signed-off-by: Huang Pei <huangpei@loongson.cn>
---
 arch/mips/include/asm/mach-cavium-octeon/war.h |  1 +
 arch/mips/include/asm/mach-generic/war.h       |  1 +
 arch/mips/include/asm/mach-loongson64/war.h    | 26 ++++++++++++++++++++++++++
 arch/mips/mm/tlbex.c                           | 13 +++++++++++++
 4 files changed, 41 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-loongson64/war.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
index 35c80be..1c43fb2 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/war.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/war.h
@@ -20,6 +20,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #define CAVIUM_OCTEON_DCACHE_PREFETCH_WAR	\
diff --git a/arch/mips/include/asm/mach-generic/war.h b/arch/mips/include/asm/mach-generic/war.h
index a1bc2e7..2dd9bf5 100644
--- a/arch/mips/include/asm/mach-generic/war.h
+++ b/arch/mips/include/asm/mach-generic/war.h
@@ -19,6 +19,7 @@
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #define ICACHE_REFILLS_WORKAROUND_WAR	0
 #define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		0
 #define MIPS34K_MISSED_ITLB_WAR		0
 
 #endif /* __ASM_MACH_GENERIC_WAR_H */
diff --git a/arch/mips/include/asm/mach-loongson64/war.h b/arch/mips/include/asm/mach-loongson64/war.h
new file mode 100644
index 0000000..9801760
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ *
+ * Copyright (C) 2019, by Huang Pei <huangpei@loongson.cn>
+ */
+#ifndef __ASM_LOONGSON64_MACH_WAR_H
+#define __ASM_LOONGSON64_MACH_WAR_H 
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define LOONGSON_LLSC_WAR		1
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_LOONGSON64_MACH_WAR_H */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0677142..51926ea 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -93,6 +93,11 @@ static inline int __maybe_unused r10000_llsc_war(void)
 	return R10000_LLSC_WAR;
 }
 
+static inline int __maybe_unused loongson_llsc_war(void)
+{
+	return LOONGSON_LLSC_WAR;
+}
+
 static int use_bbit_insns(void)
 {
 	switch (current_cpu_type()) {
@@ -1645,6 +1650,8 @@ static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
+	if (loongson_llsc_war())
+		uasm_i_sync(p, STYPE_SYNC);
 # ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if (cpu_has_64bits)
 		uasm_i_lld(p, pte, 0, ptr);
@@ -2258,6 +2265,8 @@ static void build_r4000_tlb_load_handler(void)
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	if (loongson_llsc_war())
+		uasm_i_sync(&p, STYPE_SYNC);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_0 & 1) {
@@ -2312,6 +2321,8 @@ static void build_r4000_tlb_store_handler(void)
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	if (loongson_llsc_war())
+		uasm_i_sync(&p, STYPE_SYNC);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
@@ -2367,6 +2378,8 @@ static void build_r4000_tlb_modify_handler(void)
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	if (loongson_llsc_war())
+		uasm_i_sync(&p, STYPE_SYNC);
 	build_restore_work_registers(&p);
 #ifdef CONFIG_CPU_MICROMIPS
 	if ((unsigned long)tlb_do_page_fault_1 & 1) {
-- 
2.7.4


--MP_//bnUSBHJc++7d8CF.feLcdS--

