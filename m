Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2012 01:08:48 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:54677 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2CJAIa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2012 01:08:30 +0100
Received: by ggnk1 with SMTP id k1so1525600ggn.36
        for <multiple recipients>; Fri, 09 Mar 2012 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kjGahSZ2ptaX/nh0kHU+K1pCoYD/akNAjKYCToUzPC8=;
        b=rcGha562hfioZCmDvp73sSBD2EmZ14ioM5h0fJVzFzAXwvIKoA8XHwl3E/AT+/PyF5
         Zni2pv97MEj6NtjeEo/j6A0UhwIw3gldG7Q/sGPSgyEnGJAJ6byQX29vTmbqPyZif3W4
         +sbvvS2hAS0uON6pvfDFinkblfK2vVsmPpJrcmnaDp1BlbcX6eo3mdNehmpteTuzHypd
         beqxcixs7/XBZpvO/vpCGrXXxlAw8fJvP+iRTGa8/FozNz02Iv5r3RJjwCMk42TkGbqj
         65X2G6urWJiJtqeMPFtJroZFQHtWEwmDrPuYbcWMSMjYoj2tzobJOu8Vk5uZ2nVB0RXg
         oRVQ==
Received: by 10.236.126.168 with SMTP id b28mr4836920yhi.88.1331338104357;
        Fri, 09 Mar 2012 16:08:24 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id l2sm12123679anq.12.2012.03.09.16.08.22
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 16:08:23 -0800 (PST)
Message-ID: <4F5A9B75.8090301@gmail.com>
Date:   Fri, 09 Mar 2012 16:08:21 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        David Daney <david.s.daney@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com> <20120302190744.571E03E1C63@localhost> <4F511FB0.5070901@cavium.com> <4F527285.1020500@gmail.com> <4F52F90C.5060306@gmail.com> <20120309055704.465823E0901@localhost> <4F5A4FDE.1030305@gmail.com> <4F5A710A.1000408@gmail.com>
In-Reply-To: <4F5A710A.1000408@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/09/2012 01:07 PM, Rob Herring wrote:
> On 03/09/2012 12:45 PM, David Daney wrote:
[...]
>>
>> Probably I have not explained well enough why legacy will not work.
>>
>> We have three different interrupt controllers (although only one is
>> currently in-tree).  hwirq to irq mapping for them is more or less as
>> follows:
>
> I'll just repeat what others have said: if it's not upstream it doesn't
> exist.
>
> We have no knowledge about out of tree h/w to understand what you need
>
>> irq                 hwirqCIU        hwirqCIU2      hwirqCIU3
>> ----------------------------------------------------------------------
>> OCTEON_IRQ_USB0     56               81             934562
>> OCTEON_IRQ_TWSI     45              224             100543
>> OCTEON_IRQ_UART0    34              228               4572
>> .
>> .
>> .
>
> How many actual hwirqs in each case and what is the range?
>
> So for CIU3, it seems you would need to use a radix tree. CIU2 is
> probably borderline depending on what is the max number. But because you
> don't yet have code in tree for either yet, you can use a linear domain
> for now. It shouldn't be hard to switch from linear to radix later.
>
>> Now what we notice here is that there is no possible 1:1 linearly
>> increasing mapping possible for the irq and *all* three hwirq sets.  We
>> want a single binary that contains support for all three interrupt
>> controllers, so the OCTEON_IRQ_* values have to be the same for all
>> three interrupt controllers.  Because of this, legacy mapping is
>> *impossible*.
>
> OCTEON_IRQ_* values need to go. You may not have to do that now, but
> certainly before doing support for CIU2 and CIU3 you do. Those platforms
> should be DT only.
>
>>
>> Since the possible ranges of the hwirq values is very large and quite
>> sparse, probably the radix mapping will be required.
>>
>
> Yes. You're not the only one with this issue.
>
>> Also to support non-OF drivers and architecture specific code for the
>> near future, I really think the existing IRQ values *must* be preserved.
>>
>
> For a legacy boot yes. But when you boot with DT, you should not need
> them.

It is not a matter of how the system is booted, rather what all the 
drivers are expecting...

> This is certainly possible as several ARM platforms do this. You
> need to start with minimal set of drivers enabled for DT and add them
> back in 1 by 1.
>

What I don't understand about this is what happens during the transition?

What if a shared interrupt were referred from one non-OF driver by its 
symbolic OCTEON_IRQ_? value, and from a second driver by its hwirq value 
extracted from the DT?  In that case you would be referring to the same 
interrupt line by two different irq values, clearly that should be 
prevented.

At a minimum, the change made for each converted driver would have to 
include: removing the OCTEON_IRQ_? values,  Maintain a list of hwirqs 
that are outside of the domain and report this by the.map() function, 
and then update this list.

David Daney

> Rob
>
>> Therefore, as I said above, we need a way for my SOC/board code to
>> specify the mapping.
>>
>> Perhaps we need to add an optional function to struct irq_domain_ops
>> that would allow the default mapping to be overridden on a per
>> irq_domain basis.
>>
>> Otherwise, I think I will have to keep poking into the internal
>> irq_domain data structures to get the mappings I want.
>>
>> What do you think?
>>
>> David Daney
>
>
