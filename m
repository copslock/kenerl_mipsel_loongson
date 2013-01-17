Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 07:27:27 +0100 (CET)
Received: from mail-vb0-f42.google.com ([209.85.212.42]:38838 "EHLO
        mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823008Ab3AQG10JbU60 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 07:27:26 +0100
Received: by mail-vb0-f42.google.com with SMTP id fa15so2199260vbb.29
        for <multiple recipients>; Wed, 16 Jan 2013 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=N1qNzm1W67FE8FoAgiJ4unQxDRFrLnQRjSEWoMXwkso=;
        b=Zs6AIwouBwJtCOrIs9SNj+sF5WAPdpcIqEnddDAofJUlO75YMf9P1uQc45hpMkE4l5
         7Nnem/Hwja7Yi9f99qxo3tjWCB2XFf7rK+TdjrnwJUHhuVDxShkK17Zc9AXoWMLmKXQb
         6TQBT8JZnzVa6H6Zk4h56Fsjr/zv0fhkGYvxP/laEvpVC+zHNKwYAx5XKmG8QVJC3351
         74QHDnQx/5ToQ5lWiDUv1nxhnYie/NIDkM2ilwJS8E5iufv+mN60MA8Ayjv3+lCGL1we
         hRfPnaXDJcrf984V0abEyJyM+i3+9QMTpW5HSCIYCVU01z+UfK4cWoSAhlGe9mSrQJU4
         IBEg==
MIME-Version: 1.0
X-Received: by 10.52.30.108 with SMTP id r12mr3801905vdh.72.1358404039799;
 Wed, 16 Jan 2013 22:27:19 -0800 (PST)
Received: by 10.58.227.168 with HTTP; Wed, 16 Jan 2013 22:27:19 -0800 (PST)
In-Reply-To: <1358379808-16449-1-git-send-email-alcooperx@gmail.com>
References: <1358379808-16449-1-git-send-email-alcooperx@gmail.com>
Date:   Thu, 17 Jan 2013 07:27:19 +0100
X-Google-Sender-Auth: LkTbMTicR-wlVa3713-ojwaW_RA
Message-ID: <CAMuHMdUSRM6dauiRtSs20YVfHmNrROrc4RpZL+dKA_e2t82J6A@mail.gmail.com>
Subject: Re: [PATCH V2] mips: function tracer: Fix broken function tracing
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     rostedt@goodmis.org, ddaney.cavm@gmail.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jan 17, 2013 at 12:43 AM, Al Cooper <alcooperx@gmail.com> wrote:
> Part of the sequence is "addiu sp,sp,-8" in the delay slot after every
> call to the trace routine "_mcount" (some legacy thing where 2 arguments
> used to be pushed on the stack). The _mcount routine is expected to
> adjust the sp by +8 before returning.

So when not disabled, the original jalr and addiu will be there, so _mcount has
to adjust sp.

> The problem is that when tracing is disabled for a function, the
> "jalr _mcount" instruction is replaced with a nop, but the
> "addiu sp,sp,-8" is still executed and the stack pointer is left
> trashed. When frame pointers are enabled the problem is masked
> because any access to the stack is done through the frame
> pointer and the stack pointer is restored from the frame pointer when
> the function returns.
>
> This patch writes two nops starting at the address of the "jalr _mcount"
> instruction whenever tracing is disabled. This means that the
> "addiu sp,sp.-8" will be converted to a nop along with the "jalr".

When disabled, there will be two nops.

> This is SMP safe because the first time this happens is during
> ftrace_init() which is before any other processor has been started.
> Subsequent calls to enable/disable tracing when other CPUs ARE running
> will still be safe because the enable will only change the first nop
> to a "jalr" and the disable, while writing 2 nops, will only be changing

When re-enabled, there will be a jalr and a nop, which differs from the initial
case, so _mcount doesn't have to adjust sp?

> @@ -69,7 +68,7 @@ NESTED(ftrace_caller, PT_SIZE, ra)
>         .globl _mcount
>  _mcount:
>         b       ftrace_stub
> -        nop
> +       addiu sp,sp,8
>         lw      t1, function_trace_stop
>         bnez    t1, ftrace_stub
>         nop

But _mcount will always adjust the stack pointer?
What am I missing?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
