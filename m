Return-Path: <SRS0=dgrR=U6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070BCC06511
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 15:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10CB20659
	for <linux-mips@archiver.kernel.org>; Mon,  1 Jul 2019 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAaLDw++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGAPMp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:12:45 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43782 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfGAPMo (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 1 Jul 2019 11:12:44 -0400
Received: by mail-yb1-f196.google.com with SMTP id f18so78841ybr.10
        for <linux-mips@vger.kernel.org>; Mon, 01 Jul 2019 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxcZv0DapxbLUTnkApDLiXz5c52jc+Kiux2mB44Onac=;
        b=ZAaLDw++9tkpSw30AdjLs4v/c3tSi0J6czrErFWKtT3ymi6pNEfi9YIw1zm6x+a//H
         0BGE/H0/94luzVFX0Pk6jDxN5EwGNYYpfOJd/wsXlWYHKMZj040P9775bausjnOhNSho
         N9mofnZ5SsvpcYwUh9tUbGDFe3YwVlLUdGkvTz32eSZNLfNJiz0Vw8V4eekGZI29oGHU
         zBKKuK1+H/akuwjlVhqfE9HiyhzBI1FQffzITDsrU3DKwfrdGmI+mcknlBuadbjqHJvf
         XIrorgGWra3GKL0uQVMj4EMNhokU3iBGWjZbw2HIZuHCA3Of0wNnvISZYWE39/v1NKDH
         XmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxcZv0DapxbLUTnkApDLiXz5c52jc+Kiux2mB44Onac=;
        b=aVKtkNajYLIRBPLYXPZLyPd+Vi7tDerGAp0nG9tLktPWbJP1VK/Sf67ExIV1Fqsmkb
         OLRG8raQlX0BF/CqYnvpx0lvhSnPklUfX4p/iWXd5Xvz/lj4rQQXp/xjN1gWT336T+Mu
         Mx6Cc9rLf0YnIyVqJjxP0rweegZU+6bQl065056mD75cIhMxMtbhimZt6LJwmsZ2/TFr
         5ABjahj6f6/1RNHGi1SfZBFHvNxnY9kS3CS6rUqP9WfYoXM17IW7whBmVNYBGGfAqBJK
         Cs7mKg9bPzL4kvZe4Uv20mDbCx7GmVh/007GDUb/Uqho5TaVBhuMZPxKqFrIUWbivIkT
         ZvGQ==
X-Gm-Message-State: APjAAAXsY9YAYm6AmeI7GKnOumvlHcEKiFwRxPWd82zEMWQhOUlwmPin
        k/SNxKvB+fqIkn+7n4b+nGe0PAC4
X-Google-Smtp-Source: APXvYqwAbwB8jiauupCiFD12ane2r71KV93ZrUzNDyk8M+7mxFDsE8tixCXFeDfR/OGwbaFA87Gg5w==
X-Received: by 2002:a25:eb10:: with SMTP id d16mr16794612ybs.313.1561993962699;
        Mon, 01 Jul 2019 08:12:42 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l22sm2587325ywl.68.2019.07.01.08.12.40
        for <linux-mips@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 08:12:41 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id f18so78760ybr.10
        for <linux-mips@vger.kernel.org>; Mon, 01 Jul 2019 08:12:40 -0700 (PDT)
X-Received: by 2002:a25:99c4:: with SMTP id q4mr16401842ybo.390.1561993960574;
 Mon, 01 Jul 2019 08:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190701100327.6425-1-antoine.tenart@bootlin.com> <20190701100327.6425-9-antoine.tenart@bootlin.com>
In-Reply-To: <20190701100327.6425-9-antoine.tenart@bootlin.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 1 Jul 2019 11:12:06 -0400
X-Gmail-Original-Message-ID: <CA+FuTSecj3FYGd5xnybgNFH7ndceLu9Orsa9O4RFp0U5bpNy7w@mail.gmail.com>
Message-ID: <CA+FuTSecj3FYGd5xnybgNFH7ndceLu9Orsa9O4RFp0U5bpNy7w@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] net: mscc: PTP Hardware Clock (PHC) support
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     David Miller <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-mips@vger.kernel.org, thomas.petazzoni@bootlin.com,
        allan.nielsen@microchip.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Jul 1, 2019 at 6:05 AM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> This patch adds support for PTP Hardware Clock (PHC) to the Ocelot
> switch for both PTP 1-step and 2-step modes.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

>  void ocelot_deinit(struct ocelot *ocelot)
>  {
> +       struct ocelot_port *port;
> +       struct ocelot_skb *entry;
> +       struct list_head *pos;
> +       int i;
> +
>         destroy_workqueue(ocelot->stats_queue);
>         mutex_destroy(&ocelot->stats_lock);
>         ocelot_ace_deinit();
> +
> +       for (i = 0; i < ocelot->num_phys_ports; i++) {
> +               port = ocelot->ports[i];
> +
> +               list_for_each(pos, &port->skbs) {
> +                       entry = list_entry(pos, struct ocelot_skb, head);
> +
> +                       list_del(pos);

list_for_each_safe

> +                       kfree(entry);
> +               }
> +       }
>  }
>  EXPORT_SYMBOL(ocelot_deinit);
