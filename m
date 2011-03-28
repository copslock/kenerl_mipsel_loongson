Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 16:13:54 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:58119 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491765Ab1C1ONv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Mar 2011 16:13:51 +0200
Message-ID: <4D909800.50701@phrozen.org>
Date:   Mon, 28 Mar 2011 16:15:28 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH V2 06/10] MIPS: lantiq: add NOR flash support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>         <1298996006-15960-7-git-send-email-blogic@openwrt.org> <1299488320.2746.5.camel@localhost> <4D74CEC2.4040506@openwrt.org>
In-Reply-To: <4D74CEC2.4040506@openwrt.org>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips

On 07/03/11 13:25, John Crispin wrote:
> On 07/03/11 09:58, Artem Bityutskiy wrote:
>> On Tue, 2011-03-01 at 17:13 +0100, John Crispin wrote:
>>   
>>> NOR flash is attached to the same EBU (External Bus Unit) as PCI. As described
>>> in the PCI patch, the EBU is a little buggy, resulting in the upper and lower
>>> 16 bit of the data on a 32 bit read are swapped. (essentially we have a addr^=2)
>>>
>>> To work around this we do a addr^=2 during the probe. Once probed we adapt
>>> cfi->addr_unlock1 and cfi->addr_unlock2 to represent the endianess bug.
>>>
>>> Changes in V2
>>> * handle the endianess bug inside the map code and not in the generic cfi code
>>> * remove the addr swizzle patch
>>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>> Cc: Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
>>> Cc: linux-mips@linux-mips.org
>>> Cc: linux-mtd@lists.infradead.org
>>>     
>> There are a couple checkpatch.pl warnings, would you please address them
>> and resend?
>>
>>   
> Hi,
> 
> of course.
> 
> thanks,
> John
> 
> 

Hi,

i fixed one of the warnings. the remaining warning wants me to put at
least 4 lines into the help section in the Kconfig. However 3 lines were
enough to explain what the driver does.

John
