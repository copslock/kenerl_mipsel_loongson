Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 15:14:31 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:40192 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaKJOO2DrW8B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 15:14:28 +0100
Received: by mail-la0-f49.google.com with SMTP id ge10so7552709lab.8
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 06:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Pf00S+wvPnSj7rycPsJC4gZWuARkBY0jH9R/4FjGTFY=;
        b=ZOR6xxOwEcUa9eJ9uxVScK5IiWCv99xvkBMxWWCFMZUqVAnm1G1h8Cqx4Mj5K4w66R
         IIplZuFeQUyjfdlhV6p8XnoFBxfuBBsPbVg6Fm2Rc2NEZH7hBIa1FCKyaw37apEvstvg
         harJnxCVb0X3UEi2j//vF5Gt62lrooHbI3ItoDnZK3zVyKOaUf8gdsrRuB0dnAaI2TrP
         Vi95cB7yJtyScNAubzyl0IHNZ15IspeYRw7yqlpx8NZO5ySvuIsRpj+CSH87WIm5o1qq
         hx74O+YcL6nR7NxjSB1OBOTqMB/zCcbPYjrhrvy30IrW6AwdacWfAbsFtcRgC5gtShpR
         mZaw==
X-Received: by 10.152.5.100 with SMTP id r4mr29821768lar.26.1415628861715;
 Mon, 10 Nov 2014 06:14:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.112.11.233 with HTTP; Mon, 10 Nov 2014 06:14:01 -0800 (PST)
In-Reply-To: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Nov 2014 08:14:01 -0600
X-Google-Sender-Auth: hSlUfLhNmnx3aiYdqqCzCoO6Ayc
Message-ID: <CAL_Jsq+iVfFGYEF575spQ5MaYPzo1QSfLUZP1M=TpH0+HdGS6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: Fix crash if an earlycon driver is not found
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> __earlycon_of_table_sentinel.compatible is a char[128], not a pointer, so
> it will never be NULL.  Checking it against NULL causes the match loop to
> run past the end of the array, and eventually match a bogus entry, under
> the following conditions:
>
>  - Kernel command line specifies "earlycon" with no parameters
>  - DT has a stdout-path pointing to a UART node
>  - The UART driver doesn't use OF_EARLYCON_DECLARE (or maybe the console
>    driver is compiled out)
>
> Fix this by checking to see if match->compatible is a non-empty string.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Cc: <stable@vger.kernel.org> # 3.16+

Thanks. I'll queue this up.

BTW, you should not add stable CC when submitting for review, but
rather add a note for the maintainer to apply to stable. Only if a
commit is in mainline already and not flagged for stable, then you
send the patch with the stable tag to get the commit added to stable.
It's a bit confusing...

Rob

> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1ffca8..30e97bc 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -773,7 +773,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>         if (offset < 0)
>                 return -ENODEV;
>
> -       while (match->compatible) {
> +       while (match->compatible[0]) {
>                 unsigned long addr;
>                 if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>                         match++;
> --
> 2.1.1
>
