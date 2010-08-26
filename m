Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 01:40:16 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:36449 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491800Ab0HZXkM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 01:40:12 +0200
Received: by pvg12 with SMTP id 12so1001661pvg.36
        for <linux-mips@linux-mips.org>; Thu, 26 Aug 2010 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tBj9qr0GnFIeQPWc1IkxhRKsm2umcUATHyE80aVJXpc=;
        b=HAr+BFK7UBS6lswOewQ0qIzDgqkbn3Rdj02EIlJ4Dp6brcpFKZj0ddnk6sw7LRKLd5
         O2Eh4v3SqS6Wu+brGgZemm4rMtcMVy2WQSD3D7OyLqhxKGu81EluoFS0XsjsharNPzFy
         ExMM23kK/Bmu282wHnHw0HSAz7bac2Cq187t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YDNhrlXo7mYMz6jOo3nJ5Vvlf8jZTqWiUCaNU91GxIj4WDjwnebpA5vXdZkt/aFSci
         IT2eEbf55lPhtQ4128nTUeBnczCxLwhbRNNUzl5jKBlFOLgDKgSfpscJat1jMew1c5Y2
         aRLmVrRLYTqLOcKbGTlar4pk7u+CYI/6fFFAc=
Received: by 10.142.43.7 with SMTP id q7mr601606wfq.22.1282866005991;
        Thu, 26 Aug 2010 16:40:05 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id x26sm2054054wfd.20.2010.08.26.16.40.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 16:40:04 -0700 (PDT)
Date:   Fri, 27 Aug 2010 08:42:46 +0900
From:   Adam Jiang <jiang.adam@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: irq: add statckoverflow detection
Message-ID: <20100826234246.GB12367@capricorn-x61>
References: <1282372293-30211-1-git-send-email-jiang.adam@gmail.com>
 <4C757CF4.6010304@caviumnetworks.com>
 <AANLkTi=FrWs_tL_Z6EL0LeiBMt2Vj9_axFVXprzJB0iS@mail.gmail.com>
 <4C769498.9020004@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C769498.9020004@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 26, 2010 at 09:21:44AM -0700, David Daney wrote:
> On 08/25/2010 06:12 PM, Adam Jiang wrote:
> >2010/8/26 David Daney<ddaney@caviumnetworks.com>:
> >>It looks like this patch only checks when processing an interrupt, which
> >>doesn't seem like it would give much coverage.
> >
> >Yes, it is. This is only for detection on the situation which may be
> >caused by nested interruption. No more coverage to any other cases.
> >Because to do that is much difficult and unpredicted.
> >
> 
> Well, since the default is to run interrupt handlers with interrupts
> disabled, it seems like it is of little use as you will almost never
> see nested interrupts.
> 
> A solution that shows overflow in all situations would be of more
> use. Something that could use GCC's -stack-check or related
> machinery might be interesting.
> 

Yes, you may be right. However, some toolchain has no -stack-check
option available. At least, it seems my mispel gcc missed this option.

Actually, the issue has been discussed about one month before in
mips-linux list. You can see the thread here

http://www.spinics.net/lists/mips/msg38198.html

I tried to port the same functionality from x86 to mips. This may be
another option for checking stackoverflow but not an essential solution.
But yes, you are right. Nested interruption never happen unless some
really stupid thing. Unfortunately, I have seen such things in a BSP
code. I think it is necessary to provide a small function to check it.
How do you say?

Best regards,
/Adam

> David Daney
> 
> 
> >I will revise the bad code style Sergei blamed.
> >
> >/Adam
> >
> >>
> >>Am I missing something?
> >>
> >>David Daney
> >>
> >>
> >>On 08/20/2010 11:31 PM, jiang.adam@gmail.com wrote:
> >>>
> >>>From: Adam Jiang<jiang.adam@gmail.com>
> >>>
> >>>Add stackoverflow detection to mips arch
> >>>
> >>>Signed-off-by: Adam Jiang<jiang.adam@gmail.com>
> >>>---
> >>>  arch/mips/Kconfig.debug |    7 +++++++
> >>>  arch/mips/kernel/irq.c  |   19 +++++++++++++++++++
> >>>  2 files changed, 26 insertions(+), 0 deletions(-)
> >>>
> >>>diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> >>>index 43dc279..f1a00a2 100644
> >>>--- a/arch/mips/Kconfig.debug
> >>>+++ b/arch/mips/Kconfig.debug
> >>>@@ -67,6 +67,13 @@ config CMDLINE_OVERRIDE
> >>>
> >>>          Normally, you will choose 'N' here.
> >>>
> >>>+config DEBUG_STACKOVERFLOW
> >>>+       bool "Check for stack overflows"
> >>>+       depends on DEBUG_KERNEL
> >>>+       help
> >>>+         This option will cause messages to be printed if free stack
> >>>space
> >>>+         drops below a certain limit.
> >>>+
> >>>  config DEBUG_STACK_USAGE
> >>>        bool "Enable stack utilization instrumentation"
> >>>        depends on DEBUG_KERNEL
> >>>diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> >>>index c6345f5..6334037 100644
> >>>--- a/arch/mips/kernel/irq.c
> >>>+++ b/arch/mips/kernel/irq.c
> >>>@@ -151,6 +151,22 @@ void __init init_IRQ(void)
> >>>  #endif
> >>>  }
> >>>
> >>>+static inline void check_stack_overflow(void)
> >>>+{
> >>>+#ifdef CONFIG_DEBUG_STACKOVERFLOW
> >>>+       long sp;
> >>>+
> >>>+       asm volatile("move %0, $sp" : "=r" (sp));
> >>>+       sp = sp&    (THREAD_SIZE-1);
> >>>+
> >>>+       /* check for stack overflow: is there less then 2KB free? */
> >>>+       if (unlikely(sp<    (sizeof(struct thread_info) + 2048))) {
> >>>+               printk("do_IRQ: stack overflow: %ld\n",
> >>>+                      sp - sizeof(struct thread_info));
> >>>+               dump_stack();
> >>>+       }
> >>>+#endif
> >>>+}
> >>>  /*
> >>>   * do_IRQ handles all normal device IRQ's (the special
> >>>   * SMP cross-CPU interrupts have their own specific
> >>>@@ -159,6 +175,9 @@ void __init init_IRQ(void)
> >>>  void __irq_entry do_IRQ(unsigned int irq)
> >>>  {
> >>>        irq_enter();
> >>>+
> >>>+       check_stack_overflow();
> >>>+
> >>>        __DO_IRQ_SMTC_HOOK(irq);
> >>>        generic_handle_irq(irq);
> >>>        irq_exit();
> >>
> >>
> 
