Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 19:34:53 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:28848 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S8133966AbWGYSem (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Jul 2006 19:34:42 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id A44B8D418D;
	Tue, 25 Jul 2006 20:34:36 +0200 (CEST)
Received: from [192.168.1.4] (d54C48E70.access.telenet.be [84.196.142.112])
	by asia.telenet-ops.be (Postfix) with ESMTP id 20CAED4184;
	Tue, 25 Jul 2006 20:34:35 +0200 (CEST)
Message-ID: <44C66437.9030402@telenet.be>
Date:	Tue, 25 Jul 2006 20:34:31 +0200
From:	Jurgen <jurgen.parmentier@telenet.be>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
	Todd Poynor <tpoynor@mvista.com>,
	linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] PNX8550 NAND flash driver
References: <43A2F819.1040106@ru.mvista.com> <43C69EC2.2070601@mvista.com>	 <43F1D439.60205@ru.mvista.com> <1152525196.30929.11.camel@localhost>
In-Reply-To: <1152525196.30929.11.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jurgen.parmentier@telenet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jurgen.parmentier@telenet.be
Precedence: bulk
X-list: linux-mips

Thomas Gleixner schreef:
> On Tue, 2006-02-14 at 15:59 +0300, Vladimir A. Barinov wrote:
>   
>>>> +    }
>>>> +
>>>> +    if (((bytes & 3) || (bytes < 16)) || ((u32) to & 3) || ((u32) 
>>>> from & 3)) {
>>>> +        if (((bytes & 1) == 0) &&
>>>> +            (((u32) to & 1) == 0) && (((u32) from & 1) == 0)) {
>>>> +            int words = bytes / 2;
>>>> +
>>>> +            local_irq_disable();
>>>> +            for (i = 0; i < words; i++) {
>>>> +                to16[i] = from16[i];
>>>> +            }
>>>> +            local_irq_enable();
>>>>         
>>> Really necessary to disable all irqs around this transfer?  How long 
>>> can interrupts be off during that time?
>>>       
>> That is needed since the NAND device is binded to the external XIO bus 
>> that could be used by another devices.
>>     
>
> Err, you have to protect the whole access sequence then. What protects
> the chip against access between the command write and data read ?
>
> If this really is a bus conflict problem, then you need some more
> protection than this.
>
> Can you please describe in detail why you think this is necessary. 
>
> 	tglx
>
>
>
>
>
>
>
>   
Root cause of the problem lies within the early implementation of the 
low-level NAND commands. There was a severe risk that the PCI accesses 
were stalled because of a Read Status command for the NAND Flash. This 
Read Status was launched immediately after program/erase command. The 
hardware itself will wait for the Ready/Busy to be high and only then 
launch the Read Status command. This behavior caused timeout on the 
internal bus because PCI was unable to use the pins during this wait.

If this problem was coinciding with an ISR that tried to perform a PCI 
status register, then this PCI access could possibly timeout (because 
the PCI pins were already claimed for the XIO access that is depending 
on the RBY signal).

Since the problem only showed during the PCI device ISR, the 
quick'n'dirty hack was to disable interrupts during XIO accesses.

A better fix that should be available somewhere, is to improve the 
low-level NAND driver that will first check the status of the Ready/Busy 
line and only THEN launch the Read NAND Status command...

Jurgen
