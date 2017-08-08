Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 21:11:37 +0200 (CEST)
Received: from mail-yw0-x230.google.com ([IPv6:2607:f8b0:4002:c05::230]:35032
        "EHLO mail-yw0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994856AbdHHTL1Gb4Ra (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 21:11:27 +0200
Received: by mail-yw0-x230.google.com with SMTP id l82so27230529ywc.2
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2017 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=byS9n9XRgjrXQYcS/hpmeg3N1/uHk8e1ew5SHZNxgFo=;
        b=EcAk5ooQEcKz5dTBLOG1nKzz0f6002pv1dmLDu0rlQ8tpsUpN8oP1mdJZ8mHUeoBXz
         rM9gqWXQMmoQLScVgVBKzbf/a4eYFPYcHztGWLfUJYbN1Zsp67MrU6g/WPpUJUM9/QVE
         Gt0sfcD4a7yAsv2Ry9YhWDobye3hSaMxR0sj2dgXbYkzWp1dZPvqXKweMf4PmnOIVcPo
         Y32BHR2mZFxzl3OrphuIfPjDKOFj7M8uGXbVWbLXXLUu7ATMQdx+LAD3JnQTwuh8esHn
         Kh7Vj6vaC3eYIUuM0KsrjSAKvW7eWIKuDe110i3Ubc8UcrkuN2vNsRidIE4JVCTn3dfq
         aWKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=byS9n9XRgjrXQYcS/hpmeg3N1/uHk8e1ew5SHZNxgFo=;
        b=YvHJ+J004Bj+3zqG72Zt0/XJ5X+xPqLIJF0tQKgrgNFVobRS2pfYuXohtwCgDSUAB7
         9Fx8lYpfotmCXLH3A4xQSQQf+BAD3zuXdlK1v6eNpydKjyMPdSNy4ldEQRIrqFDRF6R0
         Th7hoXG0nOmAhukcLziGzqTa/aDgzrIwXLMB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=byS9n9XRgjrXQYcS/hpmeg3N1/uHk8e1ew5SHZNxgFo=;
        b=OFP3j2+/cR3s1zZ5r4l6jbTLTW+tX83orstsOgxp+JjJSydOfUr4R7yk3TyptKFOgj
         K+ZWh3DIdenDl87pKCVX0Bp5nKkTRqYkgzxE3R+7igjH/nOhRA+978ZUUlpbn0VS8JD9
         k0mT7qK0ecgZmUmmR2rRp57uUojG7pzkQseMsswxbQwLR4LrSzn/koKyoEKMpe2eP/eY
         HvdVQl5m4xpwhtfz4a/rGqK7LmkhCFoTioEfKb1ur9tBs0GN59eLc//pTif3X7Mc6ndj
         FS1C+LMFO1qsUC4uXns3YXBrNd2u0qs7YXPZ9tMnd/WM8fOujdEply4zGcVBpZtrLmJX
         jmog==
X-Gm-Message-State: AHYfb5iSgluLaq9K0ZGj1UBunPA1ZEyxiCJhNaXu90Lby9oakEYmUDTq
        4fEfCmCy133PpIhKh35m4R2dUctjATkP
X-Received: by 10.13.221.19 with SMTP id g19mr4629595ywe.407.1502219480929;
 Tue, 08 Aug 2017 12:11:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.80.6 with HTTP; Tue, 8 Aug 2017 12:11:18 -0700 (PDT)
In-Reply-To: <1502195022-18161-1-git-send-email-matt.redfearn@imgtec.com>
References: <1502195022-18161-1-git-send-email-matt.redfearn@imgtec.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Aug 2017 12:11:18 -0700
X-Google-Sender-Auth: hv3Ydg2bui4uvMfZ2HPUmxM_2ls
Message-ID: <CAGXu5j+nF5sAO=NMLq2Oh2aHJRxGVED93oCH0GK28yU0SXQ=MA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: usercopy: Implement stack frame object validation
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Aug 8, 2017 at 5:23 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> This implements arch_within_stack_frames() for MIPS that validates if an
> object is wholly contained by a kernel stack frame.
>
> With CONFIG_HARDENED_USERCOPY enabled, MIPS now passes the LKDTM tests
> USERCOPY_STACK_FRAME_TO, USERCOPY_STACK_FRAME_FROM and
> USERCOPY_STACK_BEYOND on a Creator Ci40.
>
> Since the MIPS kernel does not use frame pointers, we re-use the MIPS
> kernels stack frame unwinder which uses instruction inspection to deduce
> the stack frame size. As such it introduces a larger performance penalty
> than on arches which use the frame pointer.

Hmm, given x86's plans to drop the frame pointer, I wonder if the
inter-frame checking code should be gated by a CONFIG. This (3%) is a
rather high performance hit to take for a relatively small protection
(it's mainly about catching too-large-reads, since most
too-large-writes will be caught by the stack canary).

What do you think?

-Kees

>
> On qemu, before this patch, hackbench gives:
> Running with 10*40 (== 400) tasks.
> Time: 5.484
> Running with 10*40 (== 400) tasks.
> Time: 4.039
> Running with 10*40 (== 400) tasks.
> Time: 3.908
> Running with 10*40 (== 400) tasks.
> Time: 3.955
> Running with 10*40 (== 400) tasks.
> Time: 4.185
> Running with 10*40 (== 400) tasks.
> Time: 4.497
> Running with 10*40 (== 400) tasks.
> Time: 3.980
> Running with 10*40 (== 400) tasks.
> Time: 4.078
> Running with 10*40 (== 400) tasks.
> Time: 4.219
> Running with 10*40 (== 400) tasks.
> Time: 4.026
>
> Giving an average of 4.2371
>
> With this patch, hackbench gives:
> Running with 10*40 (== 400) tasks.
> Time: 5.671
> Running with 10*40 (== 400) tasks.
> Time: 4.282
> Running with 10*40 (== 400) tasks.
> Time: 4.101
> Running with 10*40 (== 400) tasks.
> Time: 4.040
> Running with 10*40 (== 400) tasks.
> Time: 4.683
> Running with 10*40 (== 400) tasks.
> Time: 4.387
> Running with 10*40 (== 400) tasks.
> Time: 4.289
> Running with 10*40 (== 400) tasks.
> Time: 4.027
> Running with 10*40 (== 400) tasks.
> Time: 4.048
> Running with 10*40 (== 400) tasks.
> Time: 4.079
>
> Giving an average of 4.3607
>
> This indicates an additional 3% overhead for inspecting the kernel stack
> when CONFIG_HARDENED_USERCOPY is enabled.
>
> This patch is based on Linux v4.13-rc4, and for correct operation on
> microMIPS depends on my series "MIPS: Further microMIPS stack unwinding
> fixes"
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> ---
>
>  arch/mips/Kconfig                   |  1 +
>  arch/mips/include/asm/thread_info.h | 74 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 8dd20358464f..6cbf2d525c8d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -35,6 +35,7 @@ config MIPS
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
> +       select HAVE_ARCH_WITHIN_STACK_FRAMES if KALLSYMS
>         select HAVE_CBPF_JIT if (!64BIT && !CPU_MICROMIPS)
>         select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
>         select HAVE_CC_STACKPROTECTOR
> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
> index b439e512792b..931652460393 100644
> --- a/arch/mips/include/asm/thread_info.h
> +++ b/arch/mips/include/asm/thread_info.h
> @@ -14,6 +14,80 @@
>
>  #include <asm/processor.h>
>
> +#ifdef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
> +
> +/*
> + * Walks up the stack frames to make sure that the specified object is
> + * entirely contained by a single stack frame.
> + *
> + * Returns:
> + *     GOOD_FRAME      if within a frame
> + *     BAD_STACK       if placed across a frame boundary (or outside stack)
> + *     NOT_STACK       unable to determine
> + */
> +static inline int arch_within_stack_frames(const void *const stack,
> +                                          const void *const stackend,
> +                                          const void *obj, unsigned long len)
> +{
> +       /* Avoid header recursion by just declaring this here */
> +       extern unsigned long unwind_stack_by_address(
> +                                               unsigned long stack_page,
> +                                               unsigned long *sp,
> +                                               unsigned long pc,
> +                                               unsigned long *ra);
> +       unsigned long sp, lastsp, ra, pc;
> +       int skip_frames;
> +
> +       /* Get this frame's details */
> +       sp = (unsigned long)__builtin_frame_address(0);
> +       pc = (unsigned long)current_text_addr();
> +
> +       /*
> +        * Skip initial frames to get back the function requesting the copy.
> +        * Unwind the frames of:
> +        *   arch_within_stack_frames (inlined into check_stack_object)
> +        *   __check_object_size
> +        * This leaves sp & pc in the frame associated with
> +        *   copy_{to,from}_user() (inlined into do_usercopy_stack)
> +        */
> +       for (skip_frames = 0; skip_frames < 2; skip_frames++) {
> +               pc = unwind_stack_by_address((unsigned long)stack, &sp, pc, &ra);
> +               if (!pc)
> +                       return BAD_STACK;
> +       }
> +
> +       if ((unsigned long)obj < sp) {
> +               /* obj is not in the frame of the requestor or it's callers */
> +               return BAD_STACK;
> +       }
> +
> +       /*
> +        * low ---------------------------------------> high
> +        * [local vars][saved regs][ra][local vars']
> +        * ^                           ^
> +        * lastsp                      sp
> +        * ^----------------------^
> +        *  allow copies only within here
> +        */
> +       do {
> +               lastsp = sp;
> +               pc = unwind_stack_by_address((unsigned long)stack, &sp, pc, &ra);
> +               if ((((unsigned long)obj) >= lastsp) &&
> +                   (((unsigned long)obj + len) <= (sp - sizeof(void *)))) {
> +                       /* obj is entirely within this stack frame */
> +                       return GOOD_FRAME;
> +               }
> +       } while (pc);
> +
> +       /*
> +        * We can't unwind any further. If we haven't found the object entirely
> +        * within one of our callers frames, it must be a bad object.
> +        */
> +       return BAD_STACK;
> +}
> +
> +#endif /* CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES */
> +
>  /*
>   * low level task data that entry.S needs immediate access to
>   * - this struct should fit entirely inside of one cache line
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
