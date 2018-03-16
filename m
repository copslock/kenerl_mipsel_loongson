Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2018 13:43:46 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:38803
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994583AbeCPMngEMnnz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2018 13:43:36 +0100
Received: by mail-oi0-x242.google.com with SMTP id 20so1390042oiq.5;
        Fri, 16 Mar 2018 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kO61DoRocZkimmLFJbLFA9D2PD1102bwTjfGqseBdAY=;
        b=r1+1uLcTsfw+/gyC1j1HBDWsR82tNY6JBotogP/N90cjx5kiW1D31Okvry59+OwNzO
         SnwZ8YkrQTwemcUIF+0wukYTDtpplCv5Jv1cKGvh+0733WDiyUuAUCpLQiMiTskQbX+Z
         zEDNdl6gfNAX4f9rUmfr3veahXqbfM3OeOGT7zacrgVH8Y6Bw9ilbwXXN64bPCGnNEcX
         b4He5tPEg64RSf8HGLNPec3pyWXRpfg53LqXy/OMjkXSwOsy+NGgw0kKqWvJbpv1aJ6t
         P+DJuqEOk1+X7oKK+Ht/hJ2dHujGN4G6yVxTvWvnvxfrkIY8DJdGGQUoxindwtAKugS8
         mITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kO61DoRocZkimmLFJbLFA9D2PD1102bwTjfGqseBdAY=;
        b=ewRMCj8U5PYm1QKHvzr3RESV1ekd/QleBsoouWrC5HDSIxbt0AUYAxRDopmxebCYgK
         pekB4ukQpAjgESnOh57gdfYgh2cp6yhX3HxyPw0XxIYxGYfj13R39FLDE9mlQ/jvwg3k
         8aQf2Qe4T/sOKu7q0HflDUZNbUJMukSrUE7bLG/FAo0p1k5xw+tpW4eHEPZtqeDAbdEs
         O0EWK//2uqL4sNlePjev9aFktqRXrzsuHfq0uNMIWFo1JVhgSyKewEJAxtfcVHjOht7A
         0v8wWD4q7pxIFwqqKmfpmbid2zXkSgNp7zpjgeqQ9ryBBlMQzBwaM9NMnQ9pcAKOAJwy
         bXyw==
X-Gm-Message-State: AElRT7HKuIoeyF2zrurXqBl7Hm9XKa9pAdboQCdPTmaXiE/Ts1i6RLTp
        /kSqMDvnEAWgwlRxZtyyXR+B+bBljs4b83/Vt20=
X-Google-Smtp-Source: AG47ELuiAx/lDGXWyAOufG0vdq8rMAOdMKRnCsP6o8ndY4jqiQpj0V64qvgAGp7AI3Ve4tfOi1sb74LGDfqcRcwonaA=
X-Received: by 10.202.198.84 with SMTP id w81mr948068oif.306.1521204209579;
 Fri, 16 Mar 2018 05:43:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.20.79 with HTTP; Fri, 16 Mar 2018 05:43:09 -0700 (PDT)
In-Reply-To: <20180316025939.5416-1-jaedon.shin@gmail.com>
References: <20180316025939.5416-1-jaedon.shin@gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 16 Mar 2018 13:43:09 +0100
X-Google-Sender-Auth: 291KykBZdRRrZu_wuWAsgg1iquc
Message-ID: <CA+7wUsyNO+JK7xGky98SwKiy-DZ=zx3YBHsBPdG3+aimaE=J2A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix missing arcs_cmdline
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Jaedon,

On Fri, Mar 16, 2018 at 3:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Due to commit 8ce355cf2e38 ("MIPS: Setup boot_command_line before
> plat_mem_setup"), the value of arcs_command by prom_init is removed.
> boot_command_line is initialized with __dt_setup_arch from
> plat_mem_setup, but arcs_command is copied to boot_command_line before
> plat_mem_setup by previous commit. This commit recover missing
> arcs_command by prom_init.

If I cherry-pick your commit into my local branch I can no longer boot
my MIPS Creator CI20. The sad part is that nothing shows up in the log
(screen + tty) to indicate what the issue might be.

> Fixes: 8ce355cf2e38 ("MIPS: Setup boot_command_line before plat_mem_setup")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  arch/mips/kernel/setup.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 5f8b0a9e30b3..e87f468f76dc 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -836,30 +836,12 @@ static void __init arch_mem_init(char **cmdline_p)
>
>  #if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
>         strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> -#else
> -       if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
> -           (USE_DTB_CMDLINE && !boot_command_line[0]))
> -               strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> -
> -       if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
> -               if (boot_command_line[0])
> -                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> -       }
> -
> -#if defined(CONFIG_CMDLINE_BOOL)
> +#elif defined(CONFIG_CMDLINE_BOOL)
>         if (builtin_cmdline[0]) {
>                 if (boot_command_line[0])
>                         strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
>                 strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
>         }
> -
> -       if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
> -               if (boot_command_line[0])
> -                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> -               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> -       }
> -#endif
>  #endif
>
>         /* call board setup routine */
> @@ -881,6 +863,22 @@ static void __init arch_mem_init(char **cmdline_p)
>         pr_info("Determined physical RAM map:\n");
>         print_memory_map();
>
> +       if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
> +           (USE_DTB_CMDLINE && !boot_command_line[0]))
> +               strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> +
> +       if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
> +               if (boot_command_line[0])
> +                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> +       }
> +
> +       if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
> +               if (boot_command_line[0])
> +                       strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> +       }
> +
>         strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
>
>         *cmdline_p = command_line;
> --
> 2.16.2
>
