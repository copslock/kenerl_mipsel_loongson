Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 20:20:10 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8680 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491930Ab0KWTUG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 20:20:06 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cec140b0000>; Tue, 23 Nov 2010 11:20:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 23 Nov 2010 11:20:56 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 23 Nov 2010 11:20:56 -0800
Message-ID: <4CEC13E1.4080202@caviumnetworks.com>
Date:   Tue, 23 Nov 2010 11:20:01 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Felix Fietkau <nbd@openwrt.org>
CC:     Gabor Juhos <juhosg@openwrt.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>
Subject: Re: [PATCH 03/18] MIPS: add generic support for multiple machines
 within a single kernel
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>        <1290524800-21419-4-git-send-email-juhosg@openwrt.org> <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com> <4CEC0D1C.7090605@openwrt.org> <4CEC10AE.10305@openwrt.org>
In-Reply-To: <4CEC10AE.10305@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2010 19:20:56.0592 (UTC) FILETIME=[8DA8F100:01CB8B43]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/23/2010 11:06 AM, Felix Fietkau wrote:
> On 2010-11-23 7:51 PM, Gabor Juhos wrote:
>> Hi Arnaud,
>>
>>> On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos<juhosg@openwrt.org>  wrote:
>>>> This patch adds a generic solution to support multiple machines based on
>>>> a given SoC within a single kernel image. It is implemented already for
>>>> several other architectures but MIPS has no generic support for that yet.
>>>>
>>> Is this the way `arch/mips' wants to go to support multiple machine
>>> within a same kernel image ?
>>
>> I don't know yet what will be the chosen way.
>>
>>> Flattened Device Tree is the other way to achieve that. I remind the latter
>>> being proposed by Felix Fietkau on #openwrt.
>>
>> FDT makes sense when the bootloader supports that. FDT makes sense when the
>> bootloader supports that, but i'm not aware of any AR71xx/AR724x/AR913x based
>> board which has such bootloader. Additionally, the device-tree support for MIPS
>> has been added only recently and none of the existing MIPS boards are using that
>> yet AFAIK. If that will be widely used we can consider to switch to that later.
> We don't need boot loader support, we can make a simple loader stub that
> passes the FDT data to the kernel. It would certainly be better than our
> current cmdline hack ;)
> I think using FDT would save us a lot of maintenance work, as we
> wouldn't have to change the kernel for every single new board that we
> add support for.
>

For what it's worth, the FDT support in the kernel is almost completely 
generic.  The appropriate hooks are already in the mips archetecture 
support, but most of the contents of arch/mips/kernel/prom.c will likely 
need to be moved to chip/board specific files.

Over the next few weeks I plan on sending out patches to the 
cavium-octeon support to convert it to use the FDT.  So I don't think it 
is out of the question that other chips would start to use it as well.

David Daney
