Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:15:49 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55829 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823967AbaDHLPYZAv60 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Apr 2014 13:15:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id F2674280041
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 13:14:35 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com [209.85.216.175])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 77A20281628
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 13:14:34 +0200 (CEST)
Received: by mail-qc0-f175.google.com with SMTP id e16so745269qcx.34
        for <linux-mips@linux-mips.org>; Tue, 08 Apr 2014 04:15:18 -0700 (PDT)
X-Received: by 10.229.214.74 with SMTP id gz10mr3487957qcb.19.1396955718442;
 Tue, 08 Apr 2014 04:15:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.109.97 with HTTP; Tue, 8 Apr 2014 04:14:58 -0700 (PDT)
In-Reply-To: <1396954444-392675-2-git-send-email-manuel.lauss@gmail.com>
References: <1396954444-392675-1-git-send-email-manuel.lauss@gmail.com> <1396954444-392675-2-git-send-email-manuel.lauss@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 8 Apr 2014 13:14:58 +0200
Message-ID: <CAOiHx=mQkpFn-Ys2hpDY1DGMLA9zTCoUC2ixRBqwg7i7n-t8vg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] MIPS: optional floating point support
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Tue, Apr 8, 2014 at 12:54 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> This small patch makes the floating point support and the FPU-emulator
> optional.  A Warning will be printed once when first use of floating
> point is detected.
>
> Disabling fpu support shrinks vmlinux by about 54kBytes (32bit,
> optimizing for size), and it is mainly useful for embedded devices
> which have no need for float math (e.g. routers).
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---

(snip)

> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index 4d86b72..c3d418d 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -154,17 +154,26 @@ static inline void lose_fpu(int save)
>  static inline int init_fpu(void)
>  {
>         int ret = 0;
> +       static int first = 1;

This one could go into the else branch of (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)).

>
> -       preempt_disable();
> -       if (cpu_has_fpu) {
> -               ret = __own_fpu();
> -               if (!ret)
> -                       _init_fpu();
> +       if (IS_ENABLED(CONFIG_MIPS_FPU_SUPPORT)) {
> +               preempt_disable();
> +               if (cpu_has_fpu) {
> +                       ret = __own_fpu();
> +                       if (!ret)
> +                               _init_fpu();
> +               } else
> +                       fpu_emulator_init_fpu();

Braces belong on all branches of a conditional, see Chapter 3 of CodingStyle.

> +               preempt_enable();
>         } else {
> -               fpu_emulator_init_fpu();
> +               if (likely(first)) {
> +                       first = 0;
> +                       pr_err("FPU support disabled, but FPU use "
> +                              "detected! Make sure you have a "
> +                              "softfloat userspace!\n");

Don't split strings, it makes it hard to grep for and they have a
special exception to exceed the normal 80 characters per line limit
(Checkpatch does not complain about it). See also Chapter 2 of
CodingStyle.

Apart from that it looks okay to me.


Regards

Jonas
