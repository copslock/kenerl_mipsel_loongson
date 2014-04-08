Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:52:24 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:58512 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820489AbaDHLv6vCJN1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Apr 2014 13:51:58 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 08F58283EC3
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 13:51:13 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f49.google.com (mail-qg0-f49.google.com [209.85.192.49])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7B737280041
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 13:51:11 +0200 (CEST)
Received: by mail-qg0-f49.google.com with SMTP id e89so755387qgf.22
        for <linux-mips@linux-mips.org>; Tue, 08 Apr 2014 04:51:54 -0700 (PDT)
X-Received: by 10.224.131.132 with SMTP id x4mr3524657qas.97.1396957914413;
 Tue, 08 Apr 2014 04:51:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.109.97 with HTTP; Tue, 8 Apr 2014 04:51:34 -0700 (PDT)
In-Reply-To: <1396957079-403359-2-git-send-email-manuel.lauss@gmail.com>
References: <1396957079-403359-1-git-send-email-manuel.lauss@gmail.com> <1396957079-403359-2-git-send-email-manuel.lauss@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 8 Apr 2014 13:51:34 +0200
Message-ID: <CAOiHx=kKhtr-Q=JEgSVdEhbuaWqcL9jB0QQFckFGn6KF11YOLg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] MIPS: optional floating point support
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39722
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

On Tue, Apr 8, 2014 at 1:37 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> (snip)
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index 4d86b72..954f52d 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -155,16 +155,24 @@ static inline int init_fpu(void)
>  {
>         int ret = 0;
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
> +               } else {
> +                       fpu_emulator_init_fpu();
> +               }
> +               preempt_enable();
>         } else {
> -               fpu_emulator_init_fpu();
> +               static int first = 1;

I really hate to nitpick again but ... empty line after variable
definition, please?

> +               if (likely(first)) {
> +                       first = 0;
> +                       pr_err("FPU support disabled, but FPU use detected!\n");
> +               }
> +               ret = SIGILL;
>         }
> -
> -       preempt_enable();
>         return ret;
>  }


Regards
Jonas
