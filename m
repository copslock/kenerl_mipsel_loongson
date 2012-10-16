Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2012 10:19:45 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33122 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823044Ab2JPITjCaOrP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2012 10:19:39 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so3951837lbb.36
        for <multiple recipients>; Tue, 16 Oct 2012 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=V0PaBpXsL497QKhh6fyZNnLV162t+Rj/q5CWcnNp4eU=;
        b=zs4J1KEmhV1D3Vf+tq9TR+2ME/uRos+IcvrcAx95D3snBaIh16yYFSXDbYhZFh6Npa
         HCF8TFRwuLA4YIJJMawSWe+/EmqzmnNqCH4Mc9So/q0AnF36MLRndVH5j0RuY9GBGa6C
         DWX0EItdpNi4MqGMtDrpe8nfARvpW2TBIDkOVhhHKuIVvczhq1vUgXeWLSgiUvO7OOXh
         nhnAYdeYUFy8YjT8zApns0xv1zwIWO01X7wNyyTeYlthDgEhvsB0bwh+voxWPu/BdBWi
         GaTuWLaWJbDSMFj3Zw0X5rdkedo+rr7XHKX7Wupkd8ywffeXAwdnkkDdxWitK2jW1Wg6
         gk8Q==
MIME-Version: 1.0
Received: by 10.152.108.66 with SMTP id hi2mr12055862lab.11.1350375573335;
 Tue, 16 Oct 2012 01:19:33 -0700 (PDT)
Received: by 10.152.112.168 with HTTP; Tue, 16 Oct 2012 01:19:33 -0700 (PDT)
In-Reply-To: <1350337127-11315-2-git-send-email-antonynpavlov@gmail.com>
References: <1350337127-11315-1-git-send-email-antonynpavlov@gmail.com>
        <1350337127-11315-2-git-send-email-antonynpavlov@gmail.com>
Date:   Tue, 16 Oct 2012 10:19:33 +0200
X-Google-Sender-Auth: LlvA0koaMDpOgD3tIgiY-6cNuS0
Message-ID: <CAMuHMdUf-UBNE+2DxvOo5Cc5+FbzQzvCMBJN2epBesmn0dnoAQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: JZ4740: add missing header file to serial.h
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34708
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

On Mon, Oct 15, 2012 at 11:38 PM, Antony Pavlov <antonynpavlov@gmail.com> wrote:
> The 'uart_port' struct is used in the declaration of
> the jz4740_serial_out() function.

It only needs a forward declaration, as it just references the pointer type.

> This commit adds the missing header file containing
> declaration of the 'uart_port' struct.
>
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> ---
>  arch/mips/jz4740/serial.h |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/jz4740/serial.h b/arch/mips/jz4740/serial.h
> index aa5a939..dfc155c 100644
> --- a/arch/mips/jz4740/serial.h
> +++ b/arch/mips/jz4740/serial.h
> @@ -16,6 +16,8 @@
>  #ifndef __MIPS_JZ4740_SERIAL_H__
>  #define __MIPS_JZ4740_SERIAL_H__
>
> +#include <linux/serial_core.h>
> +

I.e. you can just use instead:

    struct uart_port;

>  void jz4740_serial_out(struct uart_port *p, int offset, int value);
>
>  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
