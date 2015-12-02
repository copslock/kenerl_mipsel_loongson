Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 19:09:27 +0100 (CET)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32902 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007502AbbLBSJYvuguG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 19:09:24 +0100
Received: by igcmv3 with SMTP id mv3so123463998igc.0
        for <linux-mips@linux-mips.org>; Wed, 02 Dec 2015 10:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JSd7QybGmTI+/p3Jk5oiw7CXdIV+BxwwLxY4CciDneI=;
        b=m4ICv+vy/4a0ZRb9z0PGcSKMNwDKBj85Gte+qZcnFTo71N/j3QocvGeiHfdbcSXuNh
         ih5jf9f+8KvbjJsMQCXb9Al4Q637b4+oq6mVBzw1q0eXyHtBrX5ZDte44GLcoxs5w4ny
         GQ02rYJyp6nYJqwCBjVQvPYzVgjQc4fuJ/G/pbVsInLpIzT7B3r45kw/l1P6yoTkyhsH
         eBnL0vXq2/jVLz0unTQGi2vnwZ4x3CUk9EFb39/1VMlRqbtGuBwwKE4/KTFpDeaIKLH0
         kqreIarF+w9eqp931U5s3HtWLFPg6mSE8+b49O3ucVrp209h4PgYQ7omrVI09D54pRW7
         hwog==
X-Received: by 10.50.59.242 with SMTP id c18mr8539242igr.82.1449079759266;
 Wed, 02 Dec 2015 10:09:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.17 with HTTP; Wed, 2 Dec 2015 10:08:39 -0800 (PST)
In-Reply-To: <565CB780.3010206@simon.arlott.org.uk>
References: <565CB727.7030209@simon.arlott.org.uk> <565CB780.3010206@simon.arlott.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed, 2 Dec 2015 10:08:39 -0800
Message-ID: <CAGVrzcauQMk7wurw3CVG8Sh5NN1dEDLjjguuUeBxTMcozjJVCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: bcm63xx: Add BCM63xx gated clock support
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2015-11-30 12:54 GMT-08:00 Simon Arlott <simon@fire.lp0.eu>:
> The BCM63xx contains clocks gated with a register. Clocks are indexed
> by bits in the register and are active high. Clock gate bits are
> interleaved with other status bits and configurable clocks in the same
> register.
>
> Enabled by default for BMIPS_GENERIC.
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---

[snip]

> +
> +config CLK_BCM63XX
> +       bool "Broadcom BCM63xx clock support"
> +       depends on BMIPS_GENERIC
> +       depends on COMMON_CLK
> +       default y

default BMIPS_GENERIC?

> +       help
> +         Enable clock framework support for Broadcom 63xx SoCs
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index 3fc9506..4f5f8ce 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_COMMON_CLK_IPROC)  += clk-ns2.o
>  obj-$(CONFIG_ARCH_BCM_CYGNUS)  += clk-cygnus.o
>  obj-$(CONFIG_ARCH_BCM_NSP)     += clk-nsp.o
>  obj-$(CONFIG_ARCH_BCM_5301X)   += clk-nsp.o
> +obj-$(CONFIG_CLK_BCM63XX)      += clk-bcm63xx.o
> diff --git a/drivers/clk/bcm/clk-bcm63xx.c b/drivers/clk/bcm/clk-bcm63xx.c
> new file mode 100644
> index 0000000..0e8cc06
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm63xx.c

There is a pending clk-bcm63xx.c implementation, covering BCM63138 in
Stephen Boyd's clk/next tree, which you would want to base your
patches on, it is not a huge deal to resolve the conflict, and there
will be separate entry points and functions based on the compatible
string anyway...

> @@ -0,0 +1,187 @@
> +/*
> + * Copyright 2015 Simon Arlott
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Based on clk-gate.c:
> + * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
> + * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
> + */

I am not really anything very specific to 63xx chips in there, in
fact, this looks like a fairly generic clk-gate driver using regmap to
get its masks and offsets, would it make sense to create
clk-gate-regmap.c which exposes the bulk of what you are doing and you
could match using a specific compatible string?
--
Florian
