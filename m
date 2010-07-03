Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jul 2010 16:32:01 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491880Ab0GCOb4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jul 2010 16:31:56 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F8BB300C;
        Sat,  3 Jul 2010 10:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=M4j8fO2TEIhC
        z7/zlLDt/nVagVQ=; b=xH5wioCSigXDLpXLyQQiLvjfk00+xYHs/MkyAHRxIQ3H
        ctsJJ2IDbfTH8nZeuPSfDLRQSHuBMrGsx3+SRrXETfUJOh5Cn883uSm4bRfv0M9B
        qPzKxSV5xVtCEqE3SzGpOy4cVzbb+y2DnloO/izQp3DLfvcN4tyoA6/sbE3xx70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CWvq4I
        qUtg4uLLk7Z9Q1Q65Y5TLG1A4kl0PdjKm5xUMO8wM/3P23UXjFZ9b9fZ2SuYjrUs
        ocSNQq87Hi5p63xsisBTBqIJCB209QbZ/40aHWzDLpuTh6EZfIbgT793e8XJOaYY
        bM9ViJXeGhcrpOajirfL1cqhk95kLKIls851I=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80C57B300A;
        Sat,  3 Jul 2010 10:31:50 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96FE0B3008; Sat,  3 Jul
 2010 10:31:48 -0400 (EDT)
Message-ID: <4C2F49D0.60200@pobox.com>
Date:   Sat, 03 Jul 2010 23:31:44 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9)
 Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
 optimization is required
References: <4C2755A3.3080600@pobox.com>
 <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com>
 <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net>
In-Reply-To: <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: B7C5C62C-86AF-11DF-B030-DA91016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

On 07/03/2010 06:32 AM, David VomLehn wrote:
> Usually it's better to control things on a feature-by-feature basis rather
> than rely on things like CPU model. This allows you to easily handle case
> where, for example, you have a different CPU that normally doesn't have
> a feature but a particular variant does have it. IIRC, the MIPS family has
> examples of this. So, I think it's better to go with the:
> 	__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz
> used in fls().

Ok, now I've come to the same conclusion.  Revised patch will be like
this.  Malta is a development platform supporting various types of
MIPS32/MIPS64 cores, hence use cpu_has_clo_clz directly.  The same goes
to MIPSSim.  

Another concern is that, I'm not really sure whether cpu_has_clo_clz is
acceptable or not for Malta (and MIPSSim).  Hopefully Ralf will help us
make things in the right direction.

  Shinya

diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
index ef6a07c..8fa5c2f 100644
--- a/arch/mips/include/asm/irq_cpu.h
+++ b/arch/mips/include/asm/irq_cpu.h
@@ -13,6 +13,52 @@
 #ifndef _ASM_IRQ_CPU_H
 #define _ASM_IRQ_CPU_H
 
+/**
+ * irq_ffs - Version of ffs that only looks at bits 12..15
+ * @pending:	pending interrupt status
+ *
+ * @pending is expected to be 32-bit wide, where unwanted bits are
+ * filtered out using ST0_IM beforehand.
+ */
+static inline unsigned int irq_ffs(unsigned int pending)
+{
+	unsigned int a0 = 7;
+	unsigned int t0;
+
+	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
+		int x;
+		__asm__(
+		"	.set	push					\n"
+		"	.set	mips32					\n"
+		"	clz	%0, %1					\n"
+		"	.set	pop					\n"
+		: "=r" (x)
+		: "r" (pending));
+
+		return -x + 31 - CAUSEB_IP;
+	}
+
+	t0 = pending & 0xf000;
+	t0 = t0 < 1;
+	t0 = t0 << 2;
+	a0 = a0 - t0;
+	pending = pending << t0;
+
+	t0 = pending & 0xc000;
+	t0 = t0 < 1;
+	t0 = t0 << 1;
+	a0 = a0 - t0;
+	pending = pending << t0;
+
+	t0 = pending & 0x8000;
+	t0 = t0 < 1;
+	/* t0 = t0 << 2; */
+	a0 = a0 - t0;
+	/* pending = pending << t0; */
+
+	return a0;
+}
+
 extern void mips_cpu_irq_init(void);
 extern void rm7k_cpu_irq_init(void);
 extern void rm9k_cpu_irq_init(void);
diff --git a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
index 2848cea..37e3583 100644
--- a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
@@ -32,6 +32,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
@@ -58,6 +59,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
diff --git a/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h b/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h
index 779b022..27aaaa5 100644
--- a/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-mipssim/cpu-feature-overrides.h
@@ -31,6 +31,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
@@ -56,6 +57,7 @@
 /* #define cpu_has_vtag_icache	? */
 /* #define cpu_has_dc_aliases	? */
 /* #define cpu_has_ic_fills_f_dc ? */
+#define cpu_has_clo_clz		1
 #define cpu_has_nofpuex		0
 /* #define cpu_has_64bits	? */
 /* #define cpu_has_64bit_zero_reg ? */
diff --git a/arch/mips/mipssim/sim_int.c b/arch/mips/mipssim/sim_int.c
index 5c779be..5813e7e 100644
--- a/arch/mips/mipssim/sim_int.c
+++ b/arch/mips/mipssim/sim_int.c
@@ -22,52 +22,6 @@
 #include <asm/mips-boards/simint.h>
 #include <asm/irq_cpu.h>
 
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
-/*
- * Version of ffs that only looks at bits 12..15.
- */
-static inline unsigned int irq_ffs(unsigned int pending)
-{
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-	return -clz(pending) + 31 - CAUSEB_IP;
-#else
-	unsigned int a0 = 7;
-	unsigned int t0;
-
-	t0 = s0 & 0xf000;
-	t0 = t0 < 1;
-	t0 = t0 << 2;
-	a0 = a0 - t0;
-	s0 = s0 << t0;
-
-	t0 = s0 & 0xc000;
-	t0 = t0 < 1;
-	t0 = t0 << 1;
-	a0 = a0 - t0;
-	s0 = s0 << t0;
-
-	t0 = s0 & 0x8000;
-	t0 = t0 < 1;
-	/* t0 = t0 << 2; */
-	a0 = a0 - t0;
-	/* s0 = s0 << t0; */
-
-	return a0;
-#endif
-}
-
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 15949b0..656cecf 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -197,52 +197,6 @@ static void corehi_irqdispatch(void)
 	die("CoreHi interrupt", regs);
 }
 
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
-/*
- * Version of ffs that only looks at bits 12..15.
- */
-static inline unsigned int irq_ffs(unsigned int pending)
-{
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-	return -clz(pending) + 31 - CAUSEB_IP;
-#else
-	unsigned int a0 = 7;
-	unsigned int t0;
-
-	t0 = pending & 0xf000;
-	t0 = t0 < 1;
-	t0 = t0 << 2;
-	a0 = a0 - t0;
-	pending = pending << t0;
-
-	t0 = pending & 0xc000;
-	t0 = t0 < 1;
-	t0 = t0 << 1;
-	a0 = a0 - t0;
-	pending = pending << t0;
-
-	t0 = pending & 0x8000;
-	t0 = t0 < 1;
-	/* t0 = t0 << 2; */
-	a0 = a0 - t0;
-	/* pending = pending << t0; */
-
-	return a0;
-#endif
-}
-
 /*
  * IRQs on the Malta board look basically (barring software IRQs which we
  * don't use at all and all external interrupt sources are combined together
diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 529c44a..06602e7 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -68,27 +68,6 @@ static void asic_irqdispatch(void)
 	do_IRQ(irq);
 }
 
-static inline int clz(unsigned long x)
-{
-	__asm__(
-	"	.set	push					\n"
-	"	.set	mips32					\n"
-	"	clz	%0, %1					\n"
-	"	.set	pop					\n"
-	: "=r" (x)
-	: "r" (x));
-
-	return x;
-}
-
-/*
- * Version of ffs that only looks at bits 12..15.
- */
-static inline unsigned int irq_ffs(unsigned int pending)
-{
-	return fls(pending) - 1 + CAUSEB_IP;
-}
-
 /*
  * TODO: check how it works under EIC mode.
  */
