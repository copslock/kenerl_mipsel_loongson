Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jul 2010 16:02:14 +0200 (CEST)
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36309 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491873Ab0GKOCK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jul 2010 16:02:10 +0200
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4336EB46AB;
        Sun, 11 Jul 2010 10:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
        :date:from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=DsTEP7bFLMqN
        HzbGZfTHIg9PNfE=; b=Jn6sc9TDl0RYWUebPcDOBk6iC4TtbTj6m+5UGADr3Z7r
        6hK2q791uovKDcqFT33ZqwfGsS5UWY6F0VYOIjirP+jU6GVJyd75hhmKMeTdi1NM
        gnxN96UAQ+lrZM/Wl/Pu/400kCBGWgQPi6fbwDFYR7m9k0D1aFzteeEBxZmDN84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
        :from:mime-version:to:cc:subject:references:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pl7YBY
        niL+L63JCnz7hFEYS3BmJPhh6mkrI6BvmYrnWmwWrSp9fXnan9pUIFj0fe87QqcE
        QFb4wr+zb/0O3VCcUagvf0G1U/VOH9Hdn/5Vpwgt/btOBhRgWwUbM9Ob1yXs+ekn
        ZWdsSdfR26OsfoYt0yXDSzB+0BVMsb+QRWuXo=
Received: from b-pb-sasl-quonix. (unknown [127.0.0.1])
        by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295BEB46AA;
        Sun, 11 Jul 2010 10:01:57 -0400 (EDT)
Received: from [192.168.11.3] (unknown [114.162.174.29]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B3BEB46A9; Sun, 11 Jul
 2010 10:01:54 -0400 (EDT)
Message-ID: <4C39CED0.40503@pobox.com>
Date:   Sun, 11 Jul 2010 23:01:52 +0900
From:   Shinya Kuribayashi <skuribay@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10)
 Gecko/20100527 Thunderbird/3.0.5
MIME-Version: 1.0
To:     David VomLehn <dvomlehn@cisco.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static
 optimization is required
References: <4C2755A3.3080600@pobox.com>
 <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com>
In-Reply-To: <4C2DF427.7080508@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Pobox-Relay-ID: DE23EA74-8CF4-11DF-A241-DA91016DD5F0-47602734!b-pb-sasl-quonix.pobox.com
Return-Path: <skuribay@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@pobox.com
Precedence: bulk
X-list: linux-mips

Hi David,

Before submitting irq_ffs() cleanup patchset, it seems I/we need to sort
out PowerTV's IRQ code properly.  Please find my comments below.

On 07/02/2010 11:13 PM, Shinya Kuribayashi wrote:
> On 07/01/2010 07:01 AM, David VomLehn wrote:
>> Thanks!  You are correct in your analysis and make a good point that
>> clz should be used in interrupt handling. I think, though, that it's
>> better to go ahead and supply a full-blown cpu-features-override.h 
>> rather than focusing on this one case. This way fls() will be optimized
>> to use clz everywhere and any other optimizations that depend on constant
>> cpu_has_* values will also be used.
> 
> Your choice, either one will be fine :-)

Double-checking the generated code, current PowerTV IRQ code is slightly
different from what I expected:

1)
PowerTV doesn't use mips_cpu_irq_init(), so IRQ #0-7 are not allocated
for MIPS CPU IRQs, but used for its ASIC interrupts.  All irq_desc[0..
126] (NR_IRQS=127) are meant for ASIC interrupts, a bit surprising ;-)

Presumably it intentionally skips primary CP0.Status decoding.  Just
check CP0.Status, and if it's flagged, then jump into ASIC dispatcher
directly.

2) PowerTV's irq_ffs() behaves differently from Malta or MISPSim one.

Without CLZ optimization, current PowerTV's irq_ffs() returns:

  PowerTV
  -------
  status=0x 100 => 9
  status=0x 300 => 10
  status=0x 700 => 11
  status=0x f00 => 12
  status=0x1f00 => 13
  status=0x3f00 => 14
  status=0x7f00 => 15
  status=0xff00 => 16

while Malta and MIPSSim would return:

  Malta, MIPSSim
  -------
  status=0x 100 => 0
  status=0x 300 => 1
  status=0x 700 => 2
  status=0x f00 => 3
  status=0x1f00 => 4
  status=0x3f00 => 5
  status=0x7f00 => 6
  status=0xff00 => 7

3)
In addition to 2), the most questionable part is (irq == CAUSEF_IP3):

> asmlinkage void plat_irq_dispatch(void)
> {
>         unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
>         int irq;
> 
>         irq = irq_ffs(pending);
> 
>         if (irq == CAUSEF_IP3)
>                 asic_irqdispatch();
>         else if (irq >= 0)
>                 do_IRQ(irq);
>         else
>                 spurious_interrupt();
> }

CAUSEF_IP3 is 0x0800, while irq_ffs() returns (9..16).  This implies
that asic_irqdispatch() is not used here, and all interrupts are
forwarded to 'else-if (irq >= 0) do_IRQ(irq);' path.

Remember that all irq_desc[0..126] are meant for ASIC interrupts, and
irq_ffs() returns (9..16).  How do you handle rest of interrupts?  I'm
lost here.

Taking a closer look, PowerTV has the code registering VI- or EIC-
handlers.  Asic_irqdispatch() might be directly strapped via VI- or
EIC-mode, and plat_irq_dispatch() is not used completely, hmm.

---

For example, the patch like this still works for PowerTV?

I'd like to make sure whether PowerTV still require irq_ffs() or not,
as it prevents irq_ffs() consolidation patch from being submitted.
But no need to hurry, I can hold the patch for weeks, for months.

  Shinya

diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 529c44a..2a8fd99 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -33,7 +33,6 @@
 
 #include <asm/irq_cpu.h>
 #include <linux/io.h>
-#include <asm/irq_regs.h>
 #include <asm/mips-boards/generic.h>
 
 #include <asm/mach-powertv/asic_regs.h>
@@ -68,40 +67,15 @@ static void asic_irqdispatch(void)
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
 asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
 	int irq;
 
-	irq = irq_ffs(pending);
-
-	if (irq == CAUSEF_IP3)
-		asic_irqdispatch();
-	else if (irq >= 0)
+	irq = get_int();
+	if (irq >= 0)
 		do_IRQ(irq);
 	else
 		spurious_interrupt();
