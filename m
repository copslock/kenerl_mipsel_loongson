Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2011 23:41:20 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:65440 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903598Ab1KNWlN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2011 23:41:13 +0100
Received: by ggno1 with SMTP id o1so7169587ggn.36
        for <multiple recipients>; Mon, 14 Nov 2011 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YWzXI72pNO+Vz17FnOptL0mFxAnHPPCq9LljgYSpZWI=;
        b=eLysEGHz/bdSmiGGrYkFEWbQn9ks7GZ1FH/wO+qDtdOiLuhsRK3s+50OHxqKkBDi62
         F6SB7w6FdZeXhrmRTkrLwnDtzPWHPYl1PVmTe67bAoag0QxyfKlk7D3FJBEnS013Jt/R
         aoUIhfT9bdQ7fVr52wuO1P3C6Z9pep8av3TdY=
Received: by 10.146.88.6 with SMTP id l6mr130670yab.35.1321310467635;
        Mon, 14 Nov 2011 14:41:07 -0800 (PST)
Received: from [172.17.28.11] ([173.226.190.126])
        by mx.google.com with ESMTPS id l27sm65583487ani.21.2011.11.14.14.41.05
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 14:41:06 -0800 (PST)
Message-ID: <4EC19900.5000806@gmail.com>
Date:   Mon, 14 Nov 2011 16:41:04 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     tglx@linutronix.de, linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] irq/of: Enchance irq_domain support.
References: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com> <4EBDEE3D.1000000@gmail.com> <4EC156D8.1080803@gmail.com>
In-Reply-To: <4EC156D8.1080803@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11960

On 11/14/2011 11:58 AM, David Daney wrote:
> On 11/11/2011 07:55 PM, Rob Herring wrote:
>> On 11/11/2011 07:50 PM, ddaney.cavm@gmail.com wrote:
>>> From: David Daney<david.daney@cavium.com>
>>>
>>> This is the first cut at hooking up my Octeon port to the irq_domain
>>> things.
>>>
>>> The Octeon specific patches are part of a larger set, and will need to
>>> be applied with that set, the first patch is stand-alone.
>>>
>>> The basic problem being solved taken from one of my other e-mails:
>>>
>>>     Unfortunately, although a good idea, kernel/irq/irqdomain.c makes a
>>>     bunch of assumptions that don't hold for Octeon.  We may be able to
>>>     improve it so that it flexible enough to suit us.
>>>
>>>
>>>     Here are the problems I see:
>>>
>>>     1) It is assumed that there is some sort of linear correspondence
>>>     between 'hwirq' and 'irq', and that the range of valid values is
>>>     contiguous.
>>>
>>>     2) It is assumed that the concepts of nr_irq, irq_base and
>>>     hwirq_base have easy to determine values and you can do iteration
>>>     over their ranges by adding indexes to the bases.
>>>
>>
>> I still think this is the wrong approach.
>>
>> Are the gpio interrupts the source of your problem here?
> 
> No.
> 
>> That's how I read it.
> 
> Take a look at Patch 2/2, since the GPIO irqs are contiguous over both
> irq and hwirq numbers, I use the existing infrastructure with no
> modifications.
> 

I did. You are adding GPIO support to the existing support. It would be
nice to separate that from add DT support.

>> You have 16 GPIO irqs directly connected into lines on your
>> primary interrupt controller which has 128 lines. So for a Linux irq
>> number, you want to translate to a GPIO hwirq number and/or a CIU hwirq
>> number. Trying to have 2 hwirq mappings for 1 Linux irq number just
>> won't work. It seems to me you should use a chained handler here because
>> you need to process the interrupt at both the primary ctrlr and gpio
>> ctrlr levels.
>>
> 
> All moot as it is based on the false predicate of GPIO irqs being the
> problem.
> 
Let me rephrase, if you completely ignore GPIO for a minute, what is the
issue. Just that irq_descs are sparsely allocated for the primary
controller. Then the GPIO interrupts are inserted into the middle of
that irq space. Handling sparse irqs is a potentially common problem, so
we should address that in the core irqdomain code.

> 
> The root of the problem are all of the irqs that are not GPIO.  I have:
> 
> o irq numbers currently in the range [9..196], with holes for any given
> SOC/Board implementation.  SOCs currently in development will have
> additional irq numbers with even more holes.
> 
> o Two different interrupt controllers.  One with 128 lines, the other
> with  512 or more lines, both sparsely populated.  The mapping of hwirq
> to irq is done at boot time based on the hardware the kernel image is
> running on.  Note that the second type of irq controller support is not
> in the kernel.org kernel, but it exists, and I intend on getting support
> for it merged ASAP.

To be clear, those are not holes in hwirq's, but many lines don't have
connections so you are not allocating Linux irqs for them. hwirq should
reflect interrupt numbers from the controller's perspective and be
directly usable to index to the correct register and bit mask. There's
no storage associated with a hwirq, so the only cost is iterating over
them which is not done frequently.

There is not a clean separation of the primary interrupt controller's
hwirq numbers and Linux irq numbers in your patch. Then you are
overlaying the GPIO interrupts into the Linux irq space.

> At a minimum the loop in irq_domain_add() where we iterate over a linear
> range of irq numbers is not flexible enough.  You may not like my
> iterator functions in irq_domain_ops, but we need to provide something
> better than the irq_domain_for_each_irq() macro.

I'm just trying to back-up some and understand the problem.

How about if .to_irq returns 0, the loop can just continue and skip over
that hwirq without error.

I don't think .each_hwirq is being used, so you can delete that.

Rob
