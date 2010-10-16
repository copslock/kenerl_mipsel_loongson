Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 10:05:07 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38050 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab0JPIFE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Oct 2010 10:05:04 +0200
Received: by fxm15 with SMTP id 15so1146391fxm.36
        for <multiple recipients>; Sat, 16 Oct 2010 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=pujCEvB3o9D7t2KKDkVQm4FrbNIDC1JnPtMTu9EO0WE=;
        b=dJR6AVPJlOLiPRU8b2Sr1U1FtN0gFVYpek44fE24ZvnxvfnoR4pojyuloDBlnANWjO
         8zW2gXtCTvbB/oZjfEDYTjuMeEhP9Y+a6eaQowoH08a8gtVoJqwHs46COVOGbjPVn1zO
         zLf6fUfFnxV0KHrPR87VOLKgLzfSyPEJPyclo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=NKwS5j0HhuGIER4/12W5I+Wb68j3+q77KeVQS6mW0AfgtrHL0G7+EY75R7cfXe8R8r
         oIsA9ZlHMGRJoTh4e0kxKOeBu5GdDY5noqWOnfCbxMBr/ld9/JEQgbO0KAzSAOOfsB1L
         UK0xEM5JOqk6ijcC80yAw1YMyvaHWFaY2lxcs=
MIME-Version: 1.0
Received: by 10.103.123.10 with SMTP id a10mr900054mun.119.1287216299147; Sat,
 16 Oct 2010 01:04:59 -0700 (PDT)
Received: by 10.223.119.193 with HTTP; Sat, 16 Oct 2010 01:04:59 -0700 (PDT)
In-Reply-To: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
References: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
Date:   Sat, 16 Oct 2010 10:04:59 +0200
X-Google-Sender-Auth: fcJblr46XLRrsOOOT69YfWZsP5Y
Message-ID: <AANLkTikdRQSsLxPFtY+cav24wEkSVEQ9vCtrMEvvM3CV@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Implement __read_mostly
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 14, 2010 at 21:36, David Daney <ddaney@caviumnetworks.com> wrote:
> Just do what everyone else is doing by placing __read_mostly things in
> the .data.read_mostly section.
>
> mips_io_port_base can not be read-only (const) and writable
> (__read_mostly) at the same time.  One of them has to go, so I chose
> to eliminate the __read_mostly.  It will still get stuck in a portion
> of memory that is not adjacent to things that are written, and thus
> not be on a dirty cache line, for whatever that is worth.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/cache.h |    2 ++
>  arch/mips/kernel/setup.c      |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
> index 37f175c..650ac9b 100644
> --- a/arch/mips/include/asm/cache.h
> +++ b/arch/mips/include/asm/cache.h
> @@ -17,4 +17,6 @@
>  #define SMP_CACHE_SHIFT                L1_CACHE_SHIFT
>  #define SMP_CACHE_BYTES                L1_CACHE_BYTES
>
> +#define __read_mostly __attribute__((__section__(".data.read_mostly")))
> +
>  #endif /* _ASM_CACHE_H */
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4e68a51..6d0c3be 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -69,7 +69,7 @@ static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
>  * mips_io_port_base is the begin of the address space to which x86 style
>  * I/O ports are mapped.
>  */
> -const unsigned long mips_io_port_base __read_mostly = -1;
> +const unsigned long mips_io_port_base = -1;
>  EXPORT_SYMBOL(mips_io_port_base);

Ugh. So as soon as someone implements MMU protection for the read-only data
section, it'll break silently?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
