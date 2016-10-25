Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 10:55:56 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33101 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990644AbcJYIzs5zaKm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 10:55:48 +0200
Received: by mail-oi0-f68.google.com with SMTP id i127so5947938oia.0;
        Tue, 25 Oct 2016 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JCXHsAr1GLyPv1UT7FF216NeTowRT5NXwrPE7Rl85F4=;
        b=SMTsejZdL26vTqu4Sy4dZLveShDMIfdfKR126L1gnrEO5EJjIIB4yq9GXcVJC1MRt+
         cJXx8vPQtnMzTFRhHkKn4T+GXFoIOVtjnLsbBpJTdI4XcVXZHG0swABoTV8Cqt+T6xWn
         MfjS9B1YLgRjPK8w4+wndQcddD7TXqxm8ATI+UXHrhfwS10BzCX26lKB8spwdr/3PNvd
         tc9PcZwKSM6N+RQaXGbGTmUwkAtuKHj4HbeQvsWQqGFMoDFvYwdGWy87gsbwAjRlRKQ0
         e0Wwa8yk7jyi/s/09eMveMnYn74c2tqILlSLXRKHuuDc4VGllrg0eeTcyBtyqwnMaFsP
         5fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JCXHsAr1GLyPv1UT7FF216NeTowRT5NXwrPE7Rl85F4=;
        b=cHFkwxWU6YB/GwwkWQz/5McKqvmyEkXkOGUPKxqtYcQ4UCx6komNhwyGex1zxfBfph
         WpMt+5xEskUhCV7grwA4fB85gDyF+NvBDhb9ccr+9U7q+1eJ9J7P0HT49LEs2JBsy895
         fRwBKuDEN8+Hm/lkTgmENmkVKkzLrh9noDm3FknpJKoUDY5TMtSrGWLGT8DI4V/LYN6s
         2JQvDTUkNXmyw93qPnBXbTq7F91zgXLj7/9hBX2wQoVdhJ/SdwovALQB2JJT9SFWb55y
         Na5JErCsRw9wBhWGsfwxWlraD/6mHNPCAbKWIx5pitwC+XaKEuI+lmJbGcnWO1EKIMiW
         5gFw==
X-Gm-Message-State: ABUngvdB4wOXg5BIWoPsyop/ZqU+Y45D8V85XWUOMGCkZBKcTlC32HVOimFQh7wJrIM2nE2LPjEtMHjku8nXrQ==
X-Received: by 10.107.62.11 with SMTP id l11mr15109906ioa.181.1477385742788;
 Tue, 25 Oct 2016 01:55:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.170.214 with HTTP; Tue, 25 Oct 2016 01:55:42 -0700 (PDT)
In-Reply-To: <61796ee0-b3b8-53a6-d29d-487c89145fc1@users.sourceforge.net>
References: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net> <61796ee0-b3b8-53a6-d29d-487c89145fc1@users.sourceforge.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2016 10:55:42 +0200
X-Google-Sender-Auth: X8n2bkDEFWoJneIRfHwfzRmhIPM
Message-ID: <CAMuHMdXn2gss2MRP7j1pAcmcXL_VivGQqMw1mAu-PUaRxGER0w@mail.gmail.com>
Subject: Re: [PATCH 4/4] MIPS/kernel/proc: Combine four seq_printf() calls
 into one call in show_cpuinfo()
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?B?UmFsZiBCw6RjaGxl?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55563
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

On Mon, Oct 24, 2016 at 2:30 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 24 Oct 2016 13:54:58 +0200
>
> Some data were printed into a sequence by four separate function calls.
> Print the same data by one function call instead.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/mips/kernel/proc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 07480a9..1047a03 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -142,12 +142,15 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>                 seq_printf(m, "micromips kernel\t: %s\n",
>                       (read_c0_config3() & MIPS_CONF3_ISA_OE) ?  "yes" : "no");
>         }
> -       seq_printf(m, "shadow register sets\t: %d\n",
> -                     cpu_data[n].srsets);
> -       seq_printf(m, "kscratch registers\t: %d\n",
> -                     hweight8(cpu_data[n].kscratch_mask));
> -       seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
> -       seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
> +       seq_printf(m,
> +                  "shadow register sets\t: %d\n"
> +                  "kscratch registers\t: %d\n"
> +                  "package\t\t\t: %d\n"
> +                  "core\t\t\t: %d\n",
> +                  cpu_data[n].srsets,
> +                  hweight8(cpu_data[n].kscratch_mask),
> +                  cpu_data[n].package,
> +                  cpu_data[n].core);

I think the code is much easier to read with separate seq_printf()s for
each line printed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
