Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jun 2010 18:22:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15137 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0FUQWR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jun 2010 18:22:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c1f91cc0000>; Mon, 21 Jun 2010 09:22:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 Jun 2010 09:22:13 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 Jun 2010 09:22:13 -0700
Message-ID: <4C1F91B0.7010304@caviumnetworks.com>
Date:   Mon, 21 Jun 2010 09:22:08 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Jan Rovins <janr@adax.com>
CC:     "'Kevin D. Kissell'" <kevink@paralogos.com>,
        linux-mips@linux-mips.org
Subject: Re: Help with decoding a NMI Watchdog interrupt on an Octeon
References: <4C1A8D86.60005@adax.com> <4C1A9319.1020202@paralogos.com> <4C1A98EC.1030708@caviumnetworks.com> <4C1D16F0.2090102@adax.com> <438633685C664132B53157C81BE355DD@ZuniBear>
In-Reply-To: <438633685C664132B53157C81BE355DD@ZuniBear>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jun 2010 16:22:13.0550 (UTC) FILETIME=[E83354E0:01CB115D]
X-archive-position: 27238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14461

On 06/20/2010 10:55 PM, Jan Rovins wrote:
> Some additions&  corrections to the previous:
>
>> -----Original Message-----
>> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
>> mips.org] On Behalf Of Jan Rovins
>> Sent: Saturday, June 19, 2010 3:14 PM
>> To: David Daney
>> Cc: Kevin D. Kissell; linux-mips@linux-mips.org
>> Subject: Re: Help with decoding a NMI Watchdog interrupt on an Octeon
>>
>> David Daney wrote:
>>> On 06/17/2010 02:26 PM, Kevin D. Kissell wrote:
>>>> NMI is just an input pin, so you'd really need to know what it's
>>>> connected to in the system you're working on.
>>>
>>> In this case, the NMI is likely being asserted by the watchdog.  So if
>>> you are stuck in a loop with interrupts disabled, the register dump
>>> might help you figure out where things are stuck.  But as you say
>>> below, knowing the value of the ErrorEPC register is critical.
>> Thank you David&  Kevin for the detailed information.
>>
>> Yes, in my case it's the watchdog, when I turn the watchdog off, the
>> machine just hangs, with no NMI dump.
>>
>> Ok, I added the code to Print out the ErrorEPC, and got:
>> ErrorEpc        0xc0000000023c5004
>> This address is not in vmlinux, but is the address of a loaded module.
>>
>> So, I poked around in /sys/module/ until I found one that had that
>> address range:
>> cat /sys/module/linux_bcm_core/sections/.text :0xc000000001c4e000
>>
>> And then did an objdump on this module. Since the module dump did not
>> contain the actual addresses that it was running from, I doctored up the
>> offsets by using the .text address from /sys/module/ of where the module
>> actually loaded.
>> objdump.cavium -d --adjust-vma 0xc000000001c4e000  linux-bcm-core.ko
>>

When looking at kernel modules, it can be helpful to show the 
relocations as well, so add '-r' to your objdump command line...

>> Just want to check if all this sounds correct so far? is my objdump
>> valid with the .text offset?
>>
>> I got a hit on the ErrorEPC value in my dump:
>> c0000000023c5004:       08000000        j       c000000000000000
>> <sal_dma_alloc-0x1c4e000>
>

... Once you turn on display or relocations, you can see where the jump 
is really going.  The relocations are applied by the kernel when loading 
the module.


>
> This line of code was inside a function called _default_assert, which on
> assertion failure, did a printk() and went into an intentional infinite
> loop, which explains the NMI dump. The only thing that puzzles me now, is
> that the assert failure printk rarely displayed. Could that be because it
> was called while interrupts were turned off? I suppose that would stop it
> from showing up in /var/log/messages.
>
> The assembly still does not make sense to me (first time with MIPS assembly)
> but on examining the C code I think I understand what's going on here.
>

It seems like you may be onto the cause of the watchdog expiring, all 
that's left is to figure out how you get into this spot in the first place.

David Daney
