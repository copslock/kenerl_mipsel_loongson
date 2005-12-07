Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 19:06:05 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:40256 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133544AbVLGTFs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Dec 2005 19:05:48 +0000
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id jB7J5Rt25833;
	Wed, 7 Dec 2005 23:05:28 +0400
Message-ID: <43973277.6070301@ru.mvista.com>
Date:	Wed, 07 Dec 2005 22:05:27 +0300
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Peter Popov <ppopov@embeddedalley.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips PNX8550
References: <20051206202625.77199.qmail@web405.biz.mail.mud.yahoo.com>
In-Reply-To: <20051206202625.77199.qmail@web405.biz.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hi Pete,

Peter Popov wrote:

>Hi Vladimir,
>
>Is this really for the JBS board or for a different
>board?
>  
>
Thank you for the response.

I used a quite different board (STB810), but it's based on the same board
dependent code as JBS (i.e arch/mips/philips/pnx8550/jbs). I haven't 
worked with
JBS board and I'm not sure if slot=10 is needed for that, but it's 
really necessary for STB810.

I also has another question - Could you please advice: shall I create a 
different
arch/mips/philips/pnx8550/stb810
and add MACH_PHILIPS_STB810 ID and defconfig
or I can use exiting JBS one?

TIA,
Vladimir

>Pete
>
>--- "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
>wrote:
>
>  
>
>>Hi Ralf, Pete,
>>
>>This patch enables NATSEMI eth driver to be used on
>>pci bus.
>>
>>Does it make sense to push this patch?
>>
>>Vladimir
>>    
>>
>>>---
>>>      
>>>
>linux-2.6.15.orig/arch/mips/philips/pnx8550/jbs/irqmap.c
>  
>
>>2005-12-02 16:37:59.000000000 +0300
>>+++
>>linux-2.6.15/arch/mips/philips/pnx8550/jbs/irqmap.c
>>2005-12-02 17:33:05.000000000 +0300
>>@@ -31,6 +31,7 @@
>> char irq_tab_jbs[][5] __initdata = {
>>  [8] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
>>0xff},
>>  [9] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
>>0xff},
>>+ [10] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
>>0xff},
>>  [17] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
>>0xff},
>> };
>> 
>>
>>    
>>
>
>
>  
>
