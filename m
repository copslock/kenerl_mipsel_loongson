Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 22:03:08 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19521 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492039Ab0KVVDB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Nov 2010 22:03:01 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ceadaaa0000>; Mon, 22 Nov 2010 13:03:38 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 22 Nov 2010 13:03:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 22 Nov 2010 13:03:50 -0800
Message-ID: <4CEADA80.8030605@caviumnetworks.com>
Date:   Mon, 22 Nov 2010 13:02:56 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ricardo Mendoza <ricmm@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages like
 "early" console!
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com><4CE57C92.6030705@mvista.com><AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com> <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com> <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com> <4CE6A103.8030009@mvista.com> <AEA634773855ED4CAD999FBB1A66D0760136A91F@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760136A91F@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2010 21:03:50.0884 (UTC) FILETIME=[C3696240:01CB8A88]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/22/2010 12:51 PM, Ardelean, Andrei wrote:
> Hi Sergei,
>
> "     Are your UART registers identity mapped to virtual address space?"
>
> My system has DDR memory 0x80000000..0x90000000 (kseg0) and UART is
> mapped starting with bbf01000 (kseg1). Can you give me some details
> about your question?
>
> I didn't do anything special for the port other than
> 	set_io_port_base(GD_PORT_BASE);
> in gd-init.c
>
>

I think you need to reset your process here.

First you should probably get a prom_putchar() function working.  Then 
enable CONFIG_EARLY_PRINTK.  That will enable you to debug many things.

If need be, you can write a trivial prom_puts() to go with your 
prom_putchar().

If you have two serial ports available, all the better.  Use one for 
printing debugging information and the other as the port you are trying 
to debug.

Asking people to stare at the thousands of lines of code that make up 
the serial I/O system and spot the error in your configuration will 
probably be less fruitful than tracing through it to find the problem.

David Daney
