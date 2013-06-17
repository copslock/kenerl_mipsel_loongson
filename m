Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 00:29:49 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34251 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835855Ab3FQW3lrUO-7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 00:29:41 +0200
Received: by mail-ie0-f172.google.com with SMTP id 16so8441547iea.3
        for <linux-mips@linux-mips.org>; Mon, 17 Jun 2013 15:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :x-gm-message-state;
        bh=dhaMnnRC7LFTUXk9PeVPUQ1DjtkgwrjtE4LrzjKSjCo=;
        b=a7q1mMQ51zSP4KeFe+n8M12f5/us8Y27tN9sC+Xt3yv/1SYnVfRPMKUwl+YSG4jSfI
         2LDMSsr6m/DJt0IVSXdqJx9NFVuvSRqpe0QYgyHrf4NFoqMm7FeKezP8SHr5b/iayVSp
         u95jBfwhPZi1qHlk7gZUifoMJKRgsOkLEMboYygok7yzk2arLEmtq81loCezyHtLfR1S
         MTPcdIeeJ4QyrNcTp4Vl1XxePPV/wLBKIV9se70LrOV41T8sqW7xE4/UnvUMtEn5zW0A
         ZMGrVP2RISSW81LmVPeNkvodqFHmrLbah3wj5ZoYikaOS6fbQMqWiyXqrUoCCIY7gSwD
         M03A==
X-Received: by 10.50.171.196 with SMTP id aw4mr6036240igc.23.1371508175200;
 Mon, 17 Jun 2013 15:29:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.133.16 with HTTP; Mon, 17 Jun 2013 15:29:15 -0700 (PDT)
In-Reply-To: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
From:   Grant Likely <grant.likely@linaro.org>
Date:   Mon, 17 Jun 2013 23:29:15 +0100
X-Google-Sender-Auth: kC5DEtUaS2Z6Q5Zdvh0_VBYpayU
Message-ID: <CACxGe6smNZofiGdO=nBM88MiWyoDvCTiPGFG5enEUwP_zCn17A@mail.gmail.com>
Subject: Re: [PATCH 0/7] genirq: add irq_get_trigger_type() to get IRQ flags
To:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQkDXGk96rTDNyqFJogiAaPWzVNOzm+hTq3fMeoHvANT9gST4iR0iqU3YaYfarDzSFspPk/n
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Fri, Jun 14, 2013 at 5:40 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Drivers that want to get the trigger edge/level type flags for a
> given interrupt have to first call irq_get_irq_data(irq) to get
> the struct irq_data and then irqd_get_trigger_type(irq_data) to
> obtain the IRQ flags.
>
> This is not only error prone but also unnecessary exposes the
> struct irq_data to callers. This patch-set adds a new function
> irq_get_trigger_type() to obtain the edge/level flags for an IRQ
> and updates the places where irq_get_irq_data(irq) was called
> just to obtain the flags from the struct irq_data.
>
> The patch-set is composed of the following patches:
>
> [PATCH 1/7] genirq: add irq_get_trigger_type() to get IRQ flags
> [PATCH 2/7] gpio: mvebu: use irq_get_trigger_type() to get IRQ flags
> [PATCH 3/7] mfd: twl4030-irq: use irq_get_trigger_type() to get IRQ flags
> [PATCH 4/7] mfd: stmpe: use irq_get_trigger_type() to get IRQ flags
> [PATCH 5/7] arm: orion: use irq_get_trigger_type() to get IRQ flags
> [PATCH 6/7] MIPS: octeon: use irq_get_trigger_type() to get IRQ flags
> [PATCH 7/7] irqdomain: use irq_get_trigger_type() to get IRQ flags

For the whole series:
Acked-by: Grant Likely <grant.likely@linaro.org>

>
>  arch/arm/plat-orion/gpio.c           |    2 +-
>  arch/mips/cavium-octeon/octeon-irq.c |    2 +-
>  drivers/gpio/gpio-mvebu.c            |    2 +-
>  drivers/mfd/stmpe.c                  |    3 +--
>  drivers/mfd/twl4030-irq.c            |    5 +----
>  include/linux/irq.h                  |    6 ++++++
>  kernel/irq/irqdomain.c               |    2 +-
>  7 files changed, 12 insertions(+), 10 deletions(-)
>
> Best regards,
> Javier
