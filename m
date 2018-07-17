Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 23:34:46 +0200 (CEST)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:33831
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993029AbeGQVen0ILH8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 23:34:43 +0200
Received: by mail-ua0-x244.google.com with SMTP id r10-v6so1643650uao.1
        for <linux-mips@linux-mips.org>; Tue, 17 Jul 2018 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SSgaQbajrGW516224Z0u0OepwxYlwlsqhHVnIr8soto=;
        b=pZcHJtAU0xHm+vg+JmHZABs0UejizdoMyDV7396hiaJFSbWEE9mudHbwxwHOZ7Lxvp
         XT9PAFhFINT03cRDwykLyXosHqPTXVMIeV0udlhHef8L7IUsqCSXOsiQPYMYMDgEbAHf
         w+FShurAz7wa9OcBcUHlqWqqt81AfXIyHaKOXWxAoGcyviOCrsXKiS25Ps3Gc3OeFHF3
         yrLx84kePrMkPQZ4lQuIuZfoVWFG7a97Jqo7xORqDTNQUkaKPQWpAOsA0fo0hjLBv0iX
         vfXdAxza+6c5v62v9C6yNflAgaeA8B9byZbw4yM2rYxeUHHvJrbI72LSNOKDIeJ37NqQ
         mUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SSgaQbajrGW516224Z0u0OepwxYlwlsqhHVnIr8soto=;
        b=mm03OXnoOpGwZ6CL9bl2HQWEb/CTitNl/WgWGudoZ/xOH4of5HbF7WbfgCSabe7TnJ
         qPOUt722g8fxfLdTAu9dzRNHBxpWqffpbR3sgGdCHGLjZ16KkhvwYpi0ZdtW6rvspQnL
         O6hMSdWRz6KYoc47UZYJkSPIkMsdb33e9v4mj3PlzlUkEvpr9st3QzO7QJaDxy7aOWHD
         uFpuHrfakfHJM8RsbwBwhjxa0ZX4AWS15RLQ9++P/QIKk6m2SmgF4ueiN4x+YE/tCuJT
         2NHfO7IW+t95dWZIca9cE+aMUfKNHrn/oEajgoZMxQ0yAge5VfXKqMX1ZEuUWgt4WOOL
         wBvw==
X-Gm-Message-State: AOUpUlE+xEK7kc7PjeE8Y06dQZExjB8oIIc7fmYBs3EoSUYV9yWSHkuZ
        ywVBmBL8rHKtpjdD7OwTK3nZ6h9PdjBZRT0ZsWU=
X-Google-Smtp-Source: AAOMgpf6rCJmS8l58CXw86X7rfgeUEKgAAEvl8dcVrtWFx+CVYmLtUd8N6KXGCG6nJOkqTVTNTz1nEeqiBpCXMUYGGw=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2192189uaf.199.1531863277679;
 Tue, 17 Jul 2018 14:34:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 14:34:37
 -0700 (PDT)
In-Reply-To: <20180717142314.32337-4-alexandre.belloni@bootlin.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com> <20180717142314.32337-4-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jul 2018 00:34:37 +0300
Message-ID: <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
Subject: Re: [PATCH 3/5] spi: dw-mmio: add MSCC Ocelot support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Because the SPI controller deasserts the chip select when the TX fifo is
> empty (which may happen in the middle of a transfer), the CS should be
> handled by linux. Unfortunately, some or all of the first four chip
> selects are not muxable as GPIOs, depending on the SoC.
>
> There is a way to bitbang those pins by using the SPI boot controller so
> use it to set the chip selects.
>
> At init time, it is also necessary to give control of the SPI interface to
> the Designware IP.

> +       ret = dw_spi_mscc_init(pdev, dwsmmio);
> +       if (ret)
> +               goto out;

> +       { .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},

Looks like you were thinking about something like

init_func = device_get_match_data(...);
if (init_func) {
 ret = init_func();
 if (ret)
   return ret;
}

?

-- 
With Best Regards,
Andy Shevchenko
