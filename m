Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2011 04:55:57 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:59092 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903695Ab1KLDzu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2011 04:55:50 +0100
Received: by gyf1 with SMTP id 1so4231285gyf.36
        for <multiple recipients>; Fri, 11 Nov 2011 19:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ls0pueoFxTPKfEKf8YEcp1s+xaqzDYy4KIjKxsOFzPA=;
        b=nPsbMoAlLp3w1/xDNsp0/dJB7zpe93Xe0Zly5zsOraWoElS6q3Krvvf81qkM0gNAGg
         CSlBNFHfHeyIdi+1XmqdsoHj8IaFvQhJfz6FZOCs47qowoTekFykiTWmWBiQ+zO7FOZ+
         tU/edWWSNq7TV4lvHOTPZ7CGXxV317iegmbOs=
Received: by 10.236.145.72 with SMTP id o48mr1018998yhj.86.1321070143829;
        Fri, 11 Nov 2011 19:55:43 -0800 (PST)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id u19sm39706616ank.11.2011.11.11.19.55.42
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 19:55:43 -0800 (PST)
Message-ID: <4EBDEE3D.1000000@gmail.com>
Date:   Fri, 11 Nov 2011 21:55:41 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     ddaney.cavm@gmail.com
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] irq/of: Enchance irq_domain support.
References: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10805

On 11/11/2011 07:50 PM, ddaney.cavm@gmail.com wrote:
> From: David Daney <david.daney@cavium.com>
> 
> This is the first cut at hooking up my Octeon port to the irq_domain things.
> 
> The Octeon specific patches are part of a larger set, and will need to
> be applied with that set, the first patch is stand-alone.
> 
> The basic problem being solved taken from one of my other e-mails:
> 
>    Unfortunately, although a good idea, kernel/irq/irqdomain.c makes a
>    bunch of assumptions that don't hold for Octeon.  We may be able to
>    improve it so that it flexible enough to suit us.
> 
> 
>    Here are the problems I see:
> 
>    1) It is assumed that there is some sort of linear correspondence
>    between 'hwirq' and 'irq', and that the range of valid values is
>    contiguous.
> 
>    2) It is assumed that the concepts of nr_irq, irq_base and
>    hwirq_base have easy to determine values and you can do iteration
>    over their ranges by adding indexes to the bases.
> 

I still think this is the wrong approach.

Are the gpio interrupts the source of your problem here? That's how I
read it. You have 16 GPIO irqs directly connected into lines on your
primary interrupt controller which has 128 lines. So for a Linux irq
number, you want to translate to a GPIO hwirq number and/or a CIU hwirq
number. Trying to have 2 hwirq mappings for 1 Linux irq number just
won't work. It seems to me you should use a chained handler here because
you need to process the interrupt at both the primary ctrlr and gpio
ctrlr levels.

Rob

> 
> David Daney (2):
>   irq/of/ARM: Enhance irq iteration capability of irq_domain code.
>   MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.
> 
>  arch/arm/common/gic.c                |   32 +++--
>  arch/mips/Kconfig                    |    1 +
>  arch/mips/cavium-octeon/octeon-irq.c |  279 +++++++++++++++++++++++++++++++++-
>  include/linux/irqdomain.h            |   29 +++-
>  kernel/irq/irqdomain.c               |   97 +++++++++---
>  5 files changed, 390 insertions(+), 48 deletions(-)
> 
