Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:58:47 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:39289
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993086AbeABP6issUP1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:58:38 +0100
Received: by mail-it0-x243.google.com with SMTP id 68so39795714ite.4;
        Tue, 02 Jan 2018 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KJ2DEQ0l7fEEVtAzB4ZBex9cCDGdsZHWTwzi12XHwyY=;
        b=ezHdznuwzZczA4VordBRvlpM+eyyfL3tUeqzTeahq4UlWr9GiX70XAydCzsgdgU/P+
         fJNMEhVi9pzIOApRvaFDB8OTrUGHmSkSwPfENv1DkU5QV6ST/6v/qOmCQMGF4ohv8d0c
         YHoe9DyIYSd30/S/PPmXYYSPPHDLBWwBuRSI3WVKXekC+ZQgVYSBno8o+7UQ0UxXGJsX
         FTg9M4Sx/e6mXwOc31d4Y/EM4x1IrXShBjgGfS/FYPqHTI7CLxQt79J8NzXAOJIT7AQy
         S4uSWkLLcauBu+sPzMcsRom7Q5aTIhdEI9FpQ6m2hYcaSos6k7xxVKNsj3/E+cK+bjrS
         GTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KJ2DEQ0l7fEEVtAzB4ZBex9cCDGdsZHWTwzi12XHwyY=;
        b=KAJ2Ei9vG2dbY02FpSNTSrMM2d5Zwv3hKzZnet53nnbFIG6v+mo9sCAevt4XIiZN9u
         7gKSBRTXJ3ArBcq3qP0xphs4vOy+xXq3oujDKGZxeujUH+LuXKlIjhvnB9dXAaNHncrC
         iNUCowlYdF3yoVA/j1m0Z7+vgP/DTfRMYgrtDMxyd0ro3t37MrT5O0Na7M61w5Zw+8op
         S9c0bjB7EGaVuirsJwDO9GuTtCoeCWyTn4Et9pNbVQV+O3IgnhORfavwsqPUTGjT75qX
         rLFPq/Ytt8cLxS3+bXFQA8emWzaXC1RIqoCiCzKEFkDoNSaOZ3tI2HT3+1PfxJYfAQbZ
         DGuQ==
X-Gm-Message-State: AKGB3mLFBrET8Y3P6KC4RNz1GLgB73EOnou65lgJpHN8yCmpuCtykIKG
        aaVyBWlL6xokFkV9jEbV9n/BQ+YUNO7yjGuNrv8=
X-Google-Smtp-Source: ACJfBovc436YLg/jR5Ij8qVFV1982OdOl05eCAb6/klgq95SR6YYpC6FNdEGC778dCpkLOklk3FEE4GgAIZN8aB98To=
X-Received: by 10.36.217.208 with SMTP id p199mr43330359itg.106.1514908712379;
 Tue, 02 Jan 2018 07:58:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 07:58:31 -0800 (PST)
In-Reply-To: <20180102150848.11314-8-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180102150848.11314-8-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 21:28:31 +0530
Message-ID: <CANc+2y7owub-Nr++MYsoGTDTHxiqeqSFsMEL7b_oWLx-OtosRQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] MIPS: ingenic: Use common cmdline handling code
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 2 January 2018 at 20:38, Paul Cercueil <paul@crapouillou.net> wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>
> jz4740_init_cmdline appends all arguments from argv (in fw_arg1) to
> arcs_cmdline, up to argc (in fw_arg0). The common code in
> fw_init_cmdline will do the exact same thing when run on a system where
> fw_arg0 isn't a pointer to kseg0 (it'll also set _fw_envp but we don't
> use it). Remove the custom implementation & use the generic code.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>  arch/mips/jz4740/prom.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
>
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: No change
>
> diff --git a/arch/mips/jz4740/prom.c b/arch/mips/jz4740/prom.c
> index 47e857194ce6..a62dd8e6ecf9 100644
> --- a/arch/mips/jz4740/prom.c
> +++ b/arch/mips/jz4740/prom.c
> @@ -20,33 +20,13 @@
>  #include <linux/serial_reg.h>
>
>  #include <asm/bootinfo.h>
> +#include <asm/fw/fw.h>
>  #include <asm/mach-jz4740/base.h>
>
> -static __init void jz4740_init_cmdline(int argc, char *argv[])
> -{
> -       unsigned int count = COMMAND_LINE_SIZE - 1;
> -       int i;
> -       char *dst = &(arcs_cmdline[0]);
> -       char *src;
> -
> -       for (i = 1; i < argc && count; ++i) {
> -               src = argv[i];
> -               while (*src && count) {
> -                       *dst++ = *src++;
> -                       --count;
> -               }
> -               *dst++ = ' ';
> -       }
> -       if (i > 1)
> -               --dst;
> -
> -       *dst = 0;
> -}
> -
>  void __init prom_init(void)
>  {
> -       jz4740_init_cmdline((int)fw_arg0, (char **)fw_arg1);
>         mips_machtype = MACH_INGENIC_JZ4740;
> +       fw_init_cmdline();
>  }
>
>  void __init prom_free_prom_memory(void)
> --
> 2.11.0
>
>

Looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
