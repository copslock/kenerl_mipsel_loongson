Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 03:26:18 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:53648 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2C2BZa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 03:25:30 +0200
Received: by pbcun4 with SMTP id un4so2867926pbc.36
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2012 18:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=nnFBfHMsBkf4idIZz9la3kItpXI/VOP+Wdt1BwFv86I=;
        b=DkZKIHxzq8XjcHrqH10R+so9aloMHb2psb8c3nJV5ywFaHB4X1I4T3HDlSU5JozDig
         9Lb3hteuuuePPlvVVI5T4D/U2Qo6M4ZEzX6gJx6z1c9h0G6HQzs3C5xVHuQuIAoyIuE2
         IcPngpn24TNPq03ROXkGHnotqkq9llOYpqPGXFsqF8g1wqrwzI+ODzItKW4uuoShLQRR
         DKbfQg1k+mHhrP5JLn817+FM3iV/y8fJ22JoPz8amHbyzp+w23ZzJtOsyGhaUvwXHS6C
         XQOGyMZOp12M/tXoBNSoFP1eXFETIFACy9k0CWWSDGZidZNTrhq+hDVFIssGu9y53lS0
         0NCg==
Received: by 10.68.194.198 with SMTP id hy6mr975379pbc.0.1332984323916;
        Wed, 28 Mar 2012 18:25:23 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id k3sm3829103pbd.17.2012.03.28.18.25.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 18:25:19 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id AD0A63E0DAA; Wed, 28 Mar 2012 15:31:55 -0700 (MST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
In-Reply-To: <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com>
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Wed, 28 Mar 2012 16:31:55 -0600
Message-Id: <20120328223155.AD0A63E0DAA@localhost>
X-Gm-Message-State: ALoCoQnPlu17pV/C99fBTuPz65mRSLrzNOHUJHYCQ0+sFHM3rhbj5t/vlu60YxRRVScPrIIXp0K3
X-archive-position: 32811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 26 Mar 2012 12:31:19 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Create two domains.  One for the GPIO lines, and the other for on-chip
> sources.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
[...]
> +struct octeon_irq_gpio_domain_data {
> +	unsigned int base_hwirq;
> +};

Hmmm...

> +static int octeon_irq_gpio_xlat(struct irq_domain *d,
> +				struct device_node *node,
> +				const u32 *intspec,
> +				unsigned int intsize,
> +				unsigned long *out_hwirq,
> +				unsigned int *out_type)
> +{
[...]
> +	*out_hwirq = gpiod->base_hwirq + pin;

...base_hwirq is only used here...

[...]
> +		gpiod = kzalloc(sizeof (*gpiod), GFP_KERNEL);
> +		if (gpiod) {
> +			/* gpio domain host_data is the base hwirq number. */
> +			gpiod->base_hwirq = 16;
> +			irq_domain_add_linear(gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);

... and it is unconditionally set to 16.  It looks to me like
base_hwirq and the associated kzalloc() is unnecessary.

g.
