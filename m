Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2011 16:30:59 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:53994 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903650Ab1L3Paz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2011 16:30:55 +0100
Received: by ghrr15 with SMTP id r15so6324171ghr.36
        for <linux-mips@linux-mips.org>; Fri, 30 Dec 2011 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ri18Vu4l5NSWJJkZUTJnqKi4Df6FT87zd9WPUHSkI8o=;
        b=Y6/QPLzFe771loX90WxizKUCwOg/eftJ4MlXw+T/EF7Iee3eGHoQP7JlOWF5aK8nf/
         ElQibTcvzso2C5vS/JWgHXP7XP3FTJBtzsqRLnLGwLmsTxaBwiLHfqlFoAYg66ShDDs1
         Z3PsdkfDWh4s28BrqhUiNi+zw+3p+nVdP+rr0=
Received: by 10.236.195.73 with SMTP id o49mr3222503yhn.71.1325259048630;
        Fri, 30 Dec 2011 07:30:48 -0800 (PST)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id q33sm37923563anh.4.2011.12.30.07.30.46
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Dec 2011 07:30:47 -0800 (PST)
Message-ID: <4EFDD925.3050806@gmail.com>
Date:   Fri, 30 Dec 2011 09:30:45 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/4] irq/of: Cleanup and Enchance irq_domain support.
References: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21168

David,

On 12/14/2011 08:32 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Back in early Nov. I send the first version of this patch set.  Now
> things are heating up again in the world of irq_domain, so I wanted to
> try to get some closure on the issues I had.  The Octeon patch is
> included here to show how I am using irq_domain, but is part of a much
> larger effort to merge Octeon device tree support.
> 
> The basic problem I am attempting to solve is using irq domains when
> there is a 'non-linear' mapping of hwirq <--> irq within a domain.
> Octeon has a single set of irq numbers that is used across two
> different implementations of the interrupt controller as well as more
> than 10 different SOCs all which use different subsets of the irq
> number space.  The result is that the hwirq to irq mapping function
> contains many gaps and discontinuities, it is really quite random.
> 
> The existing irq domain infrastructure assumes a continuous linear
> mapping of hwirq to irq that can be encapsulated by the irq_base,
> hwirq_base and nr_irq elements of struct irq_domain.  This is not
> suitable for the Octeon implementation.
> 
> The gist of my change is to add an optional iterator function to
> irq_domain_ops which knows how to iterate over the irq numbers in a
> given domain.  For simple linear domains (those currently supported),
> we iterate using the current method based on irq_base, hwirq_base and
> nr_irq.
> 
> Summary of the patches:
> 
> 1) Get rid of some unused code to make subsequent changes simpler.
> 
> 2) Cleanup the data type used by various hwirq functions and users.
> 
> 3) Add the irq iterator, and fix up the ARM GIC code to use it instead
> of the current irq_domain_for_each_irq().
> 
> 4) Add the Octeon users of the interface.
> 
> In an earlier exchange, Rob Herring had said:
> 
>    ... Handling sparse irqs is a potentially common problem, so we
>    should address that in the core irqdomain code.
> 
> Which is what this patch set is doing.
> 
> There was a suggestion that perhaps having .to_irq() return a magic
> value if there was no mapping would also work.  However I prefer this
> approach as it separates the concepts of iteration and mapping of irq
> numbers.
> 
> Please comment.

Can we first have a patch that just allows irq domains to be enabled on
MIPS. It collides because of multiple versions of irq_create_of_mapping.

Rob
