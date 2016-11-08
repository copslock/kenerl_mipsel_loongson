Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2016 10:23:36 +0100 (CET)
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36392 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbcKHJX3OrT-M convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2016 10:23:29 +0100
Received: by mail-yw0-f196.google.com with SMTP id r204so6419505ywb.3
        for <linux-mips@linux-mips.org>; Tue, 08 Nov 2016 01:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dzw9dDBp5Yesp/i9wfooTyqt5Iuq5LZdm97eqbWYTPs=;
        b=vs4LFdDfN06nB5cAK0C3jWh7gW/jKURnrKiAAYMiJcIbgAwKrDeOQ4KRMNO38VlPgY
         BdEOqzXDh4/silGfCHqa1ON3eUlsi6pTeD6V4TDY6FP+66HMVaahZ2ouWqePHRoHtY0v
         nVG/3hjy/Zx9Qi3zIGheAPiJaDxDQjRjpproNQpItY0mtURtnOffgaakgpZszMj+sliH
         jcgkr5tbLh4hynWoCAxgEytKkeCfVZgSMOmD+9n6nu5qLvR9JChohtSN52fuHGDN+xq0
         4LVNTtyYA7QeW+5CbTCt54LWe5gLk1a0IwNSxY+chK6ARKgCEMcvZqnqT10Oaj7NfqW0
         tW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dzw9dDBp5Yesp/i9wfooTyqt5Iuq5LZdm97eqbWYTPs=;
        b=X7KatoyVgOvQS+KUtXbeDP2Fjyz6R5kNZE/lcecRSMdwQc6QF/4qg/ANWed4LjtGyn
         ODbtWATQsojgd424aaWyfUSEQYsALiX4lyKibTgZup83IC/CGUFDkKexM96+Jp5dI96C
         hIMYc7NToCZPStJMPFogSsw5lz7Pg2EP1Fl4jg9pmCdJ226pMJ40eVvBsU7qbcZWfAOm
         e47MplJ6rJXnPEpJtMapmrRPGP3WFhlKhZrHZd37nuBvi8pWw3f9ZsqXMmrwZpMnp9YP
         6XJfUYFaSXitvOL6ZKRXNEOVDlX3QVl95xNlMk6BinlhjJcby7cO0bpG9TW7fXIBxVze
         E+rw==
X-Gm-Message-State: ABUngvf1xQw+glkvAScE94gSq5pER4CxxBNKmED9Uc/bM6EEETTdPee7J0Y8ALt1ScJcxO+52lZJRZvgQij0qA==
X-Received: by 10.129.146.70 with SMTP id j67mr9924428ywg.275.1478597003338;
 Tue, 08 Nov 2016 01:23:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.11.73 with HTTP; Tue, 8 Nov 2016 01:23:23 -0800 (PST)
In-Reply-To: <20161107113042.15821-1-paul.burton@imgtec.com>
References: <20161107113042.15821-1-paul.burton@imgtec.com>
From:   "Jayachandran C." <c.jayachandran@gmail.com>
Date:   Tue, 8 Nov 2016 14:53:23 +0530
Message-ID: <CA+7sy7DGvgYLCdCkVtE-xU=Nw=Q=3fc-bmR3v6Djoaj7hAUA+g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: netlogic: Exclude netlogic,xlp-pic code from XLR builds
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <c.jayachandran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.jayachandran@gmail.com
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

Hi Paul,

On Mon, Nov 7, 2016 at 5:00 PM, Paul Burton <paul.burton@imgtec.com> wrote:
>
> Code in arch/mips/netlogic/common/irq.c which handles the XLP PIC fails
> to build in XLR configurations due to cpu_is_xlp9xx not being defined,
> leading to the following build failure:
>
>     arch/mips/netlogic/common/irq.c: In function ‘xlp_of_pic_init’:
>     arch/mips/netlogic/common/irq.c:298:2: error: implicit declaration
>     of function ‘cpu_is_xlp9xx’ [-Werror=implicit-function-declaration]
>       if (cpu_is_xlp9xx()) {
>       ^
>
> Although the code was conditional upon CONFIG_OF which is indirectly
> selected by CONFIG_NLM_XLP_BOARD but not CONFIG_NLM_XLR_BOARD, the
> failing XLR with CONFIG_OF configuration can be configured manually or
> by randconfig.
>
> Fix the build failure by making the affected XLP PIC code conditional
> upon CONFIG_CPU_XLP which is used to guard the inclusion of
> asm/netlogic/xlp-hal/xlp.h that provides the required cpu_is_xlp9xx
> function.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jayachandran C <jchandra@broadcom.com>
> ---
>
>  arch/mips/netlogic/common/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
> index 3660dc6..b04eca1 100644
> --- a/arch/mips/netlogic/common/irq.c
> +++ b/arch/mips/netlogic/common/irq.c
> @@ -275,7 +275,7 @@ asmlinkage void plat_irq_dispatch(void)
>         do_IRQ(nlm_irq_to_xirq(node, i));
>  }
>
> -#ifdef CONFIG_OF
> +#if defined(CONFIG_CPU_XLP) && defined(CONFIG_OF)
>  static const struct irq_domain_ops xlp_pic_irq_domain_ops = {
>         .xlate = irq_domain_xlate_onetwocell,
>  };
> @@ -348,7 +348,7 @@ void __init arch_init_irq(void)
>  #if defined(CONFIG_CPU_XLR)
>         nlm_setup_fmn_irq();
>  #endif
> -#if defined(CONFIG_OF)
> +#if defined(CONFIG_CPU_XLP) && defined(CONFIG_OF)
>         of_irq_init(xlp_pic_irq_ids);
>  #endif
>  }

Thanks for fixing this up.  I think the use "defined(CONFIG_CPU_XLP)
&& defined(CONFIG_OF)" is redundant, since CONFIG_CPU_XLP implies
CONFIG_OF. Just "defined(CONFIG_CPU_XLP)" should be good enough.

JC.
