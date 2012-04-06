Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 03:52:21 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:34061 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904093Ab2DGBv4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 03:51:56 +0200
Received: by ggnk1 with SMTP id k1so1609492ggn.36
        for <linux-mips@linux-mips.org>; Fri, 06 Apr 2012 18:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=eBmYzAEgkWArDmsbrjpt7yGeINhvMHin1nL4kz2utCc=;
        b=RyNW1B4BLqRL2uO6EZ5PtELfFbySEOaOIeEDdyUSgvXv4AFNR9TEFhvzG129cTcP/U
         ZJobbWGpTNCnFp2P/i102e30ss5Apj7AgXZHIJWzzg9V/ApglYMBYeC7r9yy2iWu8bZa
         08ckWrbQDck+y/I1ruDPysLs8w4MR1KBjR6QPj7+W7lS/s/5vWTJwOSaAPFDjxvZ/8FF
         aU93QdSZbqjgaAwBw8NEud7pfagOL8+xLLvqlnIj6wMueUrFjXDhoC5yvBe5mOESwEZm
         G0Z3zS/l4mrZxk2VqvMmtiG2FoOXMrGX/qVunQ2IGuT7H25rFMvBM4hYm6R1e0iRVzgJ
         dDaw==
Received: by 10.100.249.1 with SMTP id w1mr6463anh.38.1333763510565;
        Fri, 06 Apr 2012 18:51:50 -0700 (PDT)
Received: from localhost (mf90f36d0.tmodns.net. [208.54.15.249])
        by mx.google.com with ESMTPS id r5sm14847455ani.19.2012.04.06.18.51.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 18:51:48 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id DCCD53E15E9; Fri,  6 Apr 2012 16:56:07 -0700 (PDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] irq/irq_domain: Quit ignoring error returns from irq_alloc_desc_from().
To:     David Daney <ddaney.cavm@gmail.com>,
        Rob Herring <robherring2@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <4F7F1BDD.4070205@gmail.com>
References: <1333669933-25267-1-git-send-email-ddaney.cavm@gmail.com> <4F7E64E4.3080509@gmail.com> <4F7F1BDD.4070205@gmail.com>
Date:   Fri, 06 Apr 2012 16:56:07 -0700
Message-Id: <20120406235607.DCCD53E15E9@localhost>
X-Gm-Message-State: ALoCoQlAGuNTpC5Uh3AKCiqXJHRNdyMNLfFwMEJqRSKPN2XjhFufiql0r9skeG03L/+0dI0Bs2qB
X-archive-position: 32876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 06 Apr 2012 09:37:49 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> On 04/05/2012 08:37 PM, Rob Herring wrote:
> > On 04/05/2012 06:52 PM, David Daney wrote:
> >> From: David Daney<david.daney@cavium.com>
> >> @@ -380,14 +381,14 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
> >>   	hint = hwirq % irq_virq_count;
> >>   	if (hint == 0)
> >>   		hint++;
> >> -	virq = irq_alloc_desc_from(hint, 0);
> >
> > You are not looking at mainline. hint was removed in later versions, and
> > the referenced commit ids don't exist.
> 
> Please look at Linus' tree before making incorrect statements about 
> whether or not code exists on the 'mainline'

Rob is indeed mistaken here, but please let's keep things civil.  I
did write the patches to remove the hint, but I avoided merging them
because I think they are risky.  I wanted to get the core irq_domain
changes in first.  The removal of hint will be applied during the next
merge window.

I will take your bug fix and get it pushed up to Linus soon.

g.
