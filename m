Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2012 03:25:55 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34361 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2C2BZ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2012 03:25:29 +0200
Received: by pbcun4 with SMTP id un4so2867900pbc.36
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2012 18:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=SI361tT+/7BJ/s8nK2qWGxYLm8MV8L9PKzMSveSgAsw=;
        b=bBI/QSsK2KMweSgs9tOAiYEfLQsgmRE63+fBdPf2BGuCER4u87CfzMMFURt4wPF6/Y
         r6gglwuwVuufKWp+dzMBLmcyEHScvMmVobo0mQah77ExlzXSFrpM30X9QZ8t5KL43ZLx
         qs+wxVxm8Z297i1TozixNnLRLF5tk3kKC+UGzBI5f6e9eX+TvJ/vmNqj9CBL/NliQOwM
         IPfJnFTI8d5c9jm48XCU6NYtvVzA9LwAbw+Yc99aqDKHJY1euY+RGz2h/r/gUNE4Uj06
         YNXaLHiOqpr9Y/AkV7Jaqsk3HMqbCAI74bqQQM5EduaWZkKJERm/p/nkDegShO1PXdzW
         HngA==
Received: by 10.68.216.35 with SMTP id on3mr1173615pbc.150.1332984322931;
        Wed, 28 Mar 2012 18:25:22 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id ko12sm3813030pbb.52.2012.03.28.18.25.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 18:25:19 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 8AFA83E0CFE; Wed, 28 Mar 2012 15:22:46 -0700 (MST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 2/4] MIPS: Octeon: Setup irq_domains for interrupts.
To:     David Daney <david.daney@cavium.com>,
        Rob Herring <robherring2@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <4F7205F3.3000108@cavium.com>
References: <1332790281-9648-1-git-send-email-ddaney.cavm@gmail.com> <1332790281-9648-3-git-send-email-ddaney.cavm@gmail.com> <4F711E69.1080302@gmail.com> <4F7205F3.3000108@cavium.com>
Date:   Wed, 28 Mar 2012 16:22:46 -0600
Message-Id: <20120328222246.8AFA83E0CFE@localhost>
X-Gm-Message-State: ALoCoQn/dBchRJ7YDRYPxKJDo1AOIU6lsiPpYsjIN8M+atjZQdfsizYDBbL0UakBKBNInPW2XhFQ
X-archive-position: 32810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 27 Mar 2012 11:24:51 -0700, David Daney <david.daney@cavium.com> wrote:
> On 03/26/2012 06:56 PM, Rob Herring wrote:
> > On 03/26/2012 02:31 PM, David Daney wrote:
> >> From: David Daney<david.daney@cavium.com>
> [...]
> >> +static int octeon_irq_ciu_map(struct irq_domain *d,
> >> +			      unsigned int virq, irq_hw_number_t hw)
> >> +{
> >> +	unsigned int line = hw>>  6;
> >> +	unsigned int bit = hw&  63;
> >> +
> >> +	if (virq>= 256)
> >> +		return -EINVAL;
> >
> > Drop this. You should not care what the virq numbers are.
> 
> 
> I care that they don't overflow the width of octeon_irq_ciu_to_irq (a u8).
> 
> So really I want to say:
> 
>     if (virq >= (1 << sizeof (octeon_irq_ciu_to_irq[0][0]))) {
>         WARN(...);
>         return -EINVAL;
>     }
> 
> 
> I need a map external to any one irq_domain.  The irq handling code 
> handles sources that come from two separate irq_domains, as well as irqs 
> that are not part of any domain.

You can get past this limitation by using the struct irq_data .hwirq and
.domain members for the irq ==> hwirq translation, and for hwirq ==>
irq the code should already have the context to know which user it is.

For the irqs that are not covered by an irq_domain, the driver is free
to set the .hwirq value directly.  Ultimately however, it will
probably be best to add an irq domain for those users also.

...

Howver, I don't understand where the risk is in overflowing
octeon_irq_ciu_to_irq[][].  From what I can see, the virq value isn't
used at all to calculate the array dereference.  line and bit are
calculated from the hwirq value.  What am I missing?

g.
