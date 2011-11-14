Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2011 18:59:01 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:55072 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903599Ab1KNR66 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2011 18:58:58 +0100
Received: by ggno1 with SMTP id o1so6826731ggn.36
        for <multiple recipients>; Mon, 14 Nov 2011 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=u91SPht4wg6aFe/FaDfqAhpLv4lZyemMTUEx2+KZ+/0=;
        b=M2WTaPIdu0+Gk/AOS6bIGh2Res4x7AKhkViz0bClZ3rpw9atFvOLzZnwlbd4vtq/r5
         D2y1qNysEVpwMhmmoZB3w5Qy5aiqD5Phzu7OVZXPwuz4ow/Pwv4EEBnpH3euIX3X3slZ
         3eY0uY+RBfpXFbH3k59hY2iT1Gxa9jHTjyKaw=
Received: by 10.147.58.12 with SMTP id l12mr4489991yak.12.1321293531778;
        Mon, 14 Nov 2011 09:58:51 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id f32sm63266624ani.20.2011.11.14.09.58.49
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 09:58:50 -0800 (PST)
Message-ID: <4EC156D8.1080803@gmail.com>
Date:   Mon, 14 Nov 2011 09:58:48 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>, tglx@linutronix.de
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] irq/of: Enchance irq_domain support.
References: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com> <4EBDEE3D.1000000@gmail.com>
In-Reply-To: <4EBDEE3D.1000000@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11755

On 11/11/2011 07:55 PM, Rob Herring wrote:
> On 11/11/2011 07:50 PM, ddaney.cavm@gmail.com wrote:
>> From: David Daney<david.daney@cavium.com>
>>
>> This is the first cut at hooking up my Octeon port to the irq_domain things.
>>
>> The Octeon specific patches are part of a larger set, and will need to
>> be applied with that set, the first patch is stand-alone.
>>
>> The basic problem being solved taken from one of my other e-mails:
>>
>>     Unfortunately, although a good idea, kernel/irq/irqdomain.c makes a
>>     bunch of assumptions that don't hold for Octeon.  We may be able to
>>     improve it so that it flexible enough to suit us.
>>
>>
>>     Here are the problems I see:
>>
>>     1) It is assumed that there is some sort of linear correspondence
>>     between 'hwirq' and 'irq', and that the range of valid values is
>>     contiguous.
>>
>>     2) It is assumed that the concepts of nr_irq, irq_base and
>>     hwirq_base have easy to determine values and you can do iteration
>>     over their ranges by adding indexes to the bases.
>>
>
> I still think this is the wrong approach.
>
> Are the gpio interrupts the source of your problem here?

No.

> That's how I read it.

Take a look at Patch 2/2, since the GPIO irqs are contiguous over both 
irq and hwirq numbers, I use the existing infrastructure with no 
modifications.

> You have 16 GPIO irqs directly connected into lines on your
> primary interrupt controller which has 128 lines. So for a Linux irq
> number, you want to translate to a GPIO hwirq number and/or a CIU hwirq
> number. Trying to have 2 hwirq mappings for 1 Linux irq number just
> won't work. It seems to me you should use a chained handler here because
> you need to process the interrupt at both the primary ctrlr and gpio
> ctrlr levels.
>

All moot as it is based on the false predicate of GPIO irqs being the 
problem.


The root of the problem are all of the irqs that are not GPIO.  I have:

o irq numbers currently in the range [9..196], with holes for any given 
SOC/Board implementation.  SOCs currently in development will have 
additional irq numbers with even more holes.

o Two different interrupt controllers.  One with 128 lines, the other 
with  512 or more lines, both sparsely populated.  The mapping of hwirq 
to irq is done at boot time based on the hardware the kernel image is 
running on.  Note that the second type of irq controller support is not 
in the kernel.org kernel, but it exists, and I intend on getting support 
for it merged ASAP.

At a minimum the loop in irq_domain_add() where we iterate over a linear 
range of irq numbers is not flexible enough.  You may not like my 
iterator functions in irq_domain_ops, but we need to provide something 
better than the irq_domain_for_each_irq() macro.

David Daney


> Rob
>
>>
>> David Daney (2):
>>    irq/of/ARM: Enhance irq iteration capability of irq_domain code.
>>    MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.
>>
>>   arch/arm/common/gic.c                |   32 +++--
>>   arch/mips/Kconfig                    |    1 +
>>   arch/mips/cavium-octeon/octeon-irq.c |  279 +++++++++++++++++++++++++++++++++-
>>   include/linux/irqdomain.h            |   29 +++-
>>   kernel/irq/irqdomain.c               |   97 +++++++++---
>>   5 files changed, 390 insertions(+), 48 deletions(-)
>>
>
>
