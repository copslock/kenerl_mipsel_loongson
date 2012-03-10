Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2012 17:20:46 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:56746 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903703Ab2CJQU2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2012 17:20:28 +0100
Received: by ghbf11 with SMTP id f11so1847420ghb.36
        for <multiple recipients>; Sat, 10 Mar 2012 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Mf2dm1FlCI3fX4+V3CxuHtCGZDD0aJ70eEdzoUmcd10=;
        b=VysIuJMTuW3g2x56ygKyX2XrGOo8apqUedV/3PSqnaibkAxKMW9rAkYTGqV1b54vvV
         WL3oFbxRcj4p+oSFH5vOiwPAtzFs/CGQeSGJkzTBAs82ZzeKymzsLe8Jbuim9SIOlkHi
         ggRdFEnuMy3VNRO/EdPpSoHLhUo/AqH7rKIneQVMqE828OFAKMxtu4WpFqellC+UkEM3
         lDQcGnUCxLoimk0EPJkDG0DyZNiByQVyfQSHg8ezSO+FceHVi5M/9UhOH2af+Ld/IzgS
         EDKxqTni1Wu3MbIQbXQgxSRgjDJuA70wkZjSvhm5hRR100QJ8c5E33fk9kLQb9j3AYde
         qNDw==
Received: by 10.236.184.167 with SMTP id s27mr7640593yhm.8.1331396422372;
        Sat, 10 Mar 2012 08:20:22 -0800 (PST)
Received: from [192.168.1.103] (65-36-72-55.dyn.grandenetworks.net. [65.36.72.55])
        by mx.google.com with ESMTPS id h30sm23718915yhk.4.2012.03.10.08.20.20
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 08:20:21 -0800 (PST)
Message-ID: <4F5B7F39.50106@gmail.com>
Date:   Sat, 10 Mar 2012 10:20:09 -0600
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        David Daney <david.s.daney@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com> <20120302190744.571E03E1C63@localhost> <4F511FB0.5070901@cavium.com> <4F527285.1020500@gmail.com> <4F52F90C.5060306@gmail.com> <20120309055704.465823E0901@localhost> <4F5A4FDE.1030305@gmail.com> <4F5A710A.1000408@gmail.com> <4F5A9B75.8090301@gmail.com>
In-Reply-To: <4F5A9B75.8090301@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/09/2012 06:08 PM, David Daney wrote:
> On 03/09/2012 01:07 PM, Rob Herring wrote:
>> On 03/09/2012 12:45 PM, David Daney wrote:
> [...]
>>>
>>> Probably I have not explained well enough why legacy will not work.
>>>
>>> We have three different interrupt controllers (although only one is
>>> currently in-tree).  hwirq to irq mapping for them is more or less as
>>> follows:
>>
>> I'll just repeat what others have said: if it's not upstream it doesn't
>> exist.
>>
>> We have no knowledge about out of tree h/w to understand what you need
>>
>>> irq                 hwirqCIU        hwirqCIU2      hwirqCIU3
>>> ----------------------------------------------------------------------
>>> OCTEON_IRQ_USB0     56               81             934562
>>> OCTEON_IRQ_TWSI     45              224             100543
>>> OCTEON_IRQ_UART0    34              228               4572
>>> .
>>> .
>>> .
>>
>> How many actual hwirqs in each case and what is the range?
>>
>> So for CIU3, it seems you would need to use a radix tree. CIU2 is
>> probably borderline depending on what is the max number. But because you
>> don't yet have code in tree for either yet, you can use a linear domain
>> for now. It shouldn't be hard to switch from linear to radix later.
>>
>>> Now what we notice here is that there is no possible 1:1 linearly
>>> increasing mapping possible for the irq and *all* three hwirq sets.  We
>>> want a single binary that contains support for all three interrupt
>>> controllers, so the OCTEON_IRQ_* values have to be the same for all
>>> three interrupt controllers.  Because of this, legacy mapping is
>>> *impossible*.
>>
>> OCTEON_IRQ_* values need to go. You may not have to do that now, but
>> certainly before doing support for CIU2 and CIU3 you do. Those platforms
>> should be DT only.
>>
>>>
>>> Since the possible ranges of the hwirq values is very large and quite
>>> sparse, probably the radix mapping will be required.
>>>
>>
>> Yes. You're not the only one with this issue.
>>
>>> Also to support non-OF drivers and architecture specific code for the
>>> near future, I really think the existing IRQ values *must* be preserved.
>>>
>>
>> For a legacy boot yes. But when you boot with DT, you should not need
>> them.
> 
> It is not a matter of how the system is booted, rather what all the
> drivers are expecting...
> 
>> This is certainly possible as several ARM platforms do this. You
>> need to start with minimal set of drivers enabled for DT and add them
>> back in 1 by 1.
>>
> 
> What I don't understand about this is what happens during the transition?
> 
> What if a shared interrupt were referred from one non-OF driver by its
> symbolic OCTEON_IRQ_? value, and from a second driver by its hwirq value
> extracted from the DT?  In that case you would be referring to the same
> interrupt line by two different irq values, clearly that should be
> prevented.
> 
> At a minimum, the change made for each converted driver would have to
> include: removing the OCTEON_IRQ_? values,  Maintain a list of hwirqs
> that are outside of the domain and report this by the.map() function,
> and then update this list.

Drivers should only deal with Linux irq numbers and should only get them
as a resource passed into the driver probe. This is true with or without
DT. I only see 2 drivers directly using OCTEON_IRQ defines: ethernet and
watchdog. Fix them. The serial setup code needs to use resources as
well. The other place you will see irq defines is platform device
declarations (i2c is an example in your case). For DT boot, you would
not register the static devices and the devices should be created
dynamically.

Rob
