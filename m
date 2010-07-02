Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jul 2010 16:14:15 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49300 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491944Ab0GBOOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jul 2010 16:14:12 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CDC1B3298;
        Fri,  2 Jul 2010 10:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=iz44Jx1OG25/
        lpXNOpM7Ei8dQac=; b=laNVTGCA5ZQNeg90Jj27u4Ini1AvT4sZ4R6pRsTlKQ5Z
        Y9yXWohlGpDN/ZcQTT1XnCSSnw3n7XPYEpjZMnlJRDkipXKcPv/havtCEFo349QF
        BuWqyUwy3W3m4GSy+/GIhxpmzKhJ8V+YbsWaGCGGFs+DbYfl2rL1drOicdtPvtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NPfLFN
        jykAbuRs6KIh5Gz7ey8kJdLIrhn7uJk6RT8MrX417ia7T4ma2vDJyBeD6PFWOGjy
        Ym0MgKnxXLDs+7nxaHv2MSYKcnIs4TJZLnZSwd7RZyHGzDy2IlZ7Wj40+5679rOl
        WvtORwT2X3cgPfZbiGd7uVvBOzEghdwhQ84Lk=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EC44B3297;
        Fri,  2 Jul 2010 10:14:06 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06B77B3296; Fri,  2 Jul
 2010 10:14:03 -0400 (EDT)
Message-ID: <4C2DF427.7080508@pobox.com>
Date:   Fri, 02 Jul 2010 23:13:59 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9)
 Gecko/20100423 Thunderbird/3.0.4
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
 optimization is required
References: <4C2755A3.3080600@pobox.com>
 <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net>
In-Reply-To: <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: 12E32E5E-85E4-11DF-A64F-DA91016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

Hi,

On 07/01/2010 07:01 AM, David VomLehn wrote:
> Thanks!  You are correct in your analysis and make a good point that
> clz should be used in interrupt handling. I think, though, that it's
> better to go ahead and supply a full-blown cpu-features-override.h 
> rather than focusing on this one case. This way fls() will be optimized
> to use clz everywhere and any other optimizations that depend on constant
> cpu_has_* values will also be used.

Your choice, either one will be fine :-)

By the way, Malta's clz() and irq_ffs() are very nice, and there are
two followers; MIPSSim and PowerTV.  And now I'm going to make use of
them for emma2rh, too.

I've prepared a consolidation patch like this, but have two concerns:

1) irq_ffs() is used to dispatch IRQs, so we'd like to give preference
   to CONFIG_CPU_xxx over cpu_has_clo_clz, to optimize with CLZ.  It's
   somewhat different for usual fls() and ffs() cases.  Or, 

2) would it be better to check __builtin_constant_p(cpu_has_clo_clz)?

Or, any other good alternatives?


diff --git a/arch/mips/include/asm/irq_cpu.h b/arch/mips/include/asm/irq_cpu.h
index ef6a07c..ad6b416 100644
--- a/arch/mips/include/asm/irq_cpu.h
+++ b/arch/mips/include/asm/irq_cpu.h
@@ -17,4 +17,47 @@ extern void mips_cpu_irq_init(void);
 extern void rm7k_cpu_irq_init(void);
 extern void rm9k_cpu_irq_init(void);
 
+/*
+ * Version of ffs that only looks at bits 12..15.
+ */
+static inline unsigned int irq_ffs(unsigned int pending)
+{
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+	int x;
+
+	__asm__(
+	"	.set	push					\n"
+	"	.set	mips32					\n"
+	"	clz	%0, %1					\n"
+	"	.set	pop					\n"
+	: "=r" (x)
+	: "r" (pending));
+
+	return -x + 31 - CAUSEB_IP;
+#else
+	unsigned int a0 = 7;
+	unsigned int t0;
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
+#endif
+}
+
 #endif /* _ASM_IRQ_CPU_H */
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
index e3c08a2..06602e7 100644
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
-	return -clz(pending) + 31 - CAUSEB_IP;
-}
-
 /*
  * TODO: check how it works under EIC mode.
  */
