Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 09:34:02 +0200 (CEST)
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35782 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeHGHd4LVIYo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 09:33:56 +0200
Received: by mail-ua0-f194.google.com with SMTP id q12-v6so15076732ual.2
        for <linux-mips@linux-mips.org>; Tue, 07 Aug 2018 00:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GE/fYjIuio1/pTL8bdFFc+pv3Uk68paDEfNifPHmXWs=;
        b=VA93ZT00S0EayRRbq7wivL54BDZctDJOB0jIPU2AiNOfXOJVe9l44Xt0aWU2AG5rcI
         M9z1r3tRLH/2sJeqjm1KApqVJYHVyta6NJIFrjQhUeDptOOX7rgj7jLTt8XUvZcGcU/O
         9M0HE9j0fGby0fpJEzlDjMfoqy+wYVSZtzoGcpbZjVRVU1dkg2dKbNTFCTk6ch3osAAg
         4OQapJNYtrMLzCeq7LbvHpETBBBIAbYS1VUB1z2cjlkfFGKvlgKLpzcF8Vz7HBO1CIsY
         pgrjHGk2fjK173+R1tXf5zjAAszfA0siblD3iAjdmVK2mmt0V3tMsx4hI8fUfPANut0Z
         KkLA==
X-Gm-Message-State: AOUpUlE6y0Ee4Ze32tTmQKqe1uCTWwmNhBXrBHgA72cPYQpCj/fGV2zM
        jKw0BRKS3FKRMoBe2nVPxrLGgr8L1eUDaf5os7k=
X-Google-Smtp-Source: AAOMgpdqehgpS+3jTcG7bm7ld/PVCL4WRpJ333yQgVnmJoBlkr38nSKWpnzWEGar3HZagmHTOncuQ4QjHujYxrctMO4=
X-Received: by 2002:a1f:8948:: with SMTP id l69-v6mr11835313vkd.132.1533627230008;
 Tue, 07 Aug 2018 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-9-songjun.wu@linux.intel.com>
In-Reply-To: <20180803030237.3366-9-songjun.wu@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Aug 2018 09:33:38 +0200
Message-ID: <CAMuHMdXkGchPN337dXbBVOFsb1o-Tkh8S_z=uCm3Z0sDjPVMKA@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
To:     songjun.wu@linux.intel.com
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65443
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

Hi Songjun,

On Fri, Aug 3, 2018 at 5:04 AM Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Get serial id from dts.
>
> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> macro is defined in lantiq_soc.h.
> lantiq_soc.h is in arch path for legacy product support.
>
> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
>
> If "#ifdef preprocessor" is changed to
> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> code using LTQ_EARLY_ASC is compiled.
> Compilation will fail for no LTQ_EARLY_ASC defined.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

Thanks for your patch!

> @@ -699,9 +700,19 @@ lqasc_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> -       /* check if this is the console port */
> -       if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
> -               line = 1;
> +       /* get serial id */
> +       line = of_alias_get_id(node, "serial");
> +       if (line < 0) {
> +#ifdef CONFIG_LANTIQ
> +               if (mmres->start == CPHYSADDR(LTQ_EARLY_ASC))
> +                       line = 0;
> +               else
> +                       line = 1;
> +#else
> +               dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
> +               return line;

Please note that not providing a fallback here makes life harder when using
DT overlays.
See the description of commit 7678f4c20fa7670f ("serial: sh-sci: Add support
for dynamic instances") for background info.

> +#endif
> +       }
>
>         if (lqasc_port[line]) {
>                 dev_err(&pdev->dev, "port %d already allocated\n", line);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
