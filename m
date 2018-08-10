Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 19:34:30 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994794AbeHJReUsMhA0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2018 19:34:20 +0200
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com [209.85.216.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB3922455
        for <linux-mips@linux-mips.org>; Fri, 10 Aug 2018 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533922453;
        bh=xexaJaKN8Jd8Uk1lDhJ82rRvfauPvMV6C+w8qphCsgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Piu7PBCF9nCkcKZDXoyzcLA/qRmCpaTj2qizSOlb7smWw7Gs9Qg5ImOeQgVLN7LfH
         2Mij84KgaZ/KsNKaNCMY6QvPHfCoMeta40pPbQDBiVz+1GQDrQ7D8sRnAci6zp0Z3/
         8x24BNtU5Gvx8e1Gr5W6jb4u8QkEnYSH621BmEkM=
Received: by mail-qt0-f175.google.com with SMTP id t5-v6so11112505qtn.3
        for <linux-mips@linux-mips.org>; Fri, 10 Aug 2018 10:34:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlET9jrFTvee4hZXKa4bnnjr2r7/O+RPHBrL/oXUvNdAAHRA4L8u
        aEu3EDy4cvTC74t9Ir8/SujklfDljUkZMaJyvQ==
X-Google-Smtp-Source: AA+uWPzNCJ6lzWLUpSweuSQkyccYwcmZ9Dhd4vz/IMhpTpssdm+3N7GOBvFV1lRDcAJiZ+fBhUZvYQfAuYs4oA/mEFI=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr7698782qta.60.1533922452110;
 Fri, 10 Aug 2018 10:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de>
In-Reply-To: <20180805232651.10605-1-afaerber@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Aug 2018 11:34:00 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
Message-ID: <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, jringle@gridpoint.com,
        Michael Allwright <allsey87@gmail.com>,
        Jakub Kicinski <kubakici@wp.pl>, liuxuenetmail@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65539
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

On Sun, Aug 5, 2018 at 5:27 PM Andreas Färber <afaerber@suse.de> wrote:
>
> This is to allow using serdev.
>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 243c96025053..ad7267274f65 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
>
>         for (i = 0; i < devtype->nr_uart; ++i) {
> +#ifdef CONFIG_OF
> +               struct device_node *np;
> +               struct platform_device *pdev;
> +               char name[6] = "uartx";
> +#endif
> +
>                 s->p[i].line            = i;
>                 /* Initialize port data */
> +#ifdef CONFIG_OF
> +               name[4] = '0' + i;
> +               np = of_get_child_by_name(dev->of_node, name);
> +               if (IS_ERR(np)) {
> +                       ret = PTR_ERR(np);
> +                       goto out_ports;
> +               }
> +               pdev = of_platform_device_create(np, NULL, dev);

Ideally, you would use of_platform_default_populate here. I think
you'd have to add a compatible to the child nodes, but that wouldn't
be a bad thing. I could envision that the child nodes ultimately
become their own driver utilizing the standard 8250 driver and a
compatible string would be needed in that case.

You'd then have to loop over each child of 'dev' instead of the DT nodes.

> +               if (IS_ERR(pdev)) {
> +                       ret = PTR_ERR(pdev);
> +                       goto out_ports;
> +               }
> +               platform_set_drvdata(pdev, dev_get_drvdata(dev));
> +               s->p[i].port.dev        = &pdev->dev;
> +#else
>                 s->p[i].port.dev        = dev;
> +#endif
>                 s->p[i].port.irq        = irq;
>                 s->p[i].port.type       = PORT_SC16IS7XX;
>                 s->p[i].port.fifosize   = SC16IS7XX_FIFO_SIZE;
