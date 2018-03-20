Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 08:15:52 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:43661
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992896AbeCTHPo6E-ge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2018 08:15:44 +0100
Received: by mail-oi0-x242.google.com with SMTP id y27-v6so487923oix.10;
        Tue, 20 Mar 2018 00:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gvXIYGbepR3UMEDym87DsfXAoi+gL0ziNhV9MBtGSu4=;
        b=fsyjGKMY377SYSk6WLIyRKByLJaozVfnm9Zxe257Dbuq8JUkWMJFy1c+DzBr2t4/Df
         GTrIkyp32fBba2O1gzsx1vj15EspYGFuKrv0JamO35QKPvJHOqA7mMLuwD3M5ZIq1Ib5
         bPp2qlajJ5GUfq4qezG7va0zNobgUbAMW6bx48HqfVUIH3J/iQ/SI/m1xDaU0iRjghH4
         XTbCJq7YMajB7l+V7WWVrSYI0KC65NeAR/u8MjyPMQl5q9FATOG03lgRoY+qF0k7ZcoY
         DqLj3yWvaiHx9lAxOC1gLqtMk303V/HK8wjgj6xPzF41cq99K0q4CuWU74mlw3w3jnYA
         wlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gvXIYGbepR3UMEDym87DsfXAoi+gL0ziNhV9MBtGSu4=;
        b=MMaTyFi8OLpUKdOZ0hyy64YFEpYfoXSKGm62dYwP8zKGY4TgYhX1JCBojqERCmhUeb
         zd2DD1T+DPfYslWyy1rnnCmGd9gnDB+oo4n+uu3VpG17b7GrXlg4WoEqJ+7w3h15XrLB
         uEtwhy+aPZHKciPupOEo70wh6Q9RCAsCe4Ku4CmY66EkV7jcBcFnsmqjBQydIgqqoQ3j
         0byuoD/LKs0xMTXe1why53JfU4F+Em2D55B26rPcmFYDtugol3eJfTFBKgjRNc7FC1vg
         8LzrZbi/Mw0q0nB+SNxvH+mzfXKtw6hFEnO56h1bx3CCCKhhWbwZ6FXFTWZefaxAkkzc
         /2DA==
X-Gm-Message-State: AElRT7EMYtQeP7z0zBgA9SYbQBk5c9fALxsZo4TPFTBPGpDximZoh4gK
        niyXGC5g5K30FxmpQakB6DIE9fNfofc0i0JmE1Q=
X-Google-Smtp-Source: AG47ELtrhkxaxSGQvQO/dtxHVlUG58DmbeTfw4OxBVOw9XmDY+ZgYJgmQEIVUY9ySUfDu42frChQGUzrILnBV99Q3YM=
X-Received: by 10.84.78.10 with SMTP id a10mr264663oiy.173.1521530138326; Tue,
 20 Mar 2018 00:15:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.138.3.76 with HTTP; Tue, 20 Mar 2018 00:15:17 -0700 (PDT)
In-Reply-To: <20180317232901.14129-3-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net> <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-3-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 20 Mar 2018 08:15:17 +0100
X-Google-Sender-Auth: UFPmw-6P91LGHTGy6O_ZOTdyfJo
Message-ID: <CA+7wUsyAkW+Bgmp6MuWTce1jMG-ug1b-UqFVen_vVeKFiW5Fww@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: ingenic: Add DT bindings for TCU clocks
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63070
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

Hi Paul,

Two things:

On Sun, Mar 18, 2018 at 12:28 AM, Paul Cercueil <paul@crapouillou.net> wrote:
> This header provides clock numbers for the ingenic,tcu
> DT binding.

I have tested the whole series on my Creator CI20 with success, using:

+ tcu@10002000 {
+ compatible = "ingenic,jz4780-tcu";
+ reg = <0x10002000 0x140>;
+
+ interrupt-parent = <&intc>;
+ interrupts = <27 26 25>;
+ };


So:

Tested-by: Mathieu Malaterre <malat@debian.org>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/clock/ingenic,tcu.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 include/dt-bindings/clock/ingenic,tcu.h
>
>  v2: Use SPDX identifier for the license
>  v3: No change
>  v4: No change
>
> diff --git a/include/dt-bindings/clock/ingenic,tcu.h b/include/dt-bindings/clock/ingenic,tcu.h
> new file mode 100644
> index 000000000000..179815d7b3bb
> --- /dev/null
> +++ b/include/dt-bindings/clock/ingenic,tcu.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides clock numbers for the ingenic,tcu DT binding.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
> +#define __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
> +
> +#define JZ4740_CLK_TIMER0      0
> +#define JZ4740_CLK_TIMER1      1
> +#define JZ4740_CLK_TIMER2      2
> +#define JZ4740_CLK_TIMER3      3
> +#define JZ4740_CLK_TIMER4      4
> +#define JZ4740_CLK_TIMER5      5
> +#define JZ4740_CLK_TIMER6      6
> +#define JZ4740_CLK_TIMER7      7
> +#define JZ4740_CLK_WDT         8
> +#define JZ4740_CLK_LAST                JZ4740_CLK_WDT
> +
> +#define JZ4770_CLK_OST         9
> +#define JZ4770_CLK_LAST                JZ4770_CLK_OST
> +

When working on JZ4780 support, I always struggle to read those kind
of #define. Since this is a new patch would you mind changing
s/JZ4740/JZ47XX/ in your header ?

Thanks for your work on JZ !

> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_TCU_H__ */
> --
> 2.11.0
>
>
