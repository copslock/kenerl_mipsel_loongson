Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 18:44:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18709 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491005Ab0JYQoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 18:44:00 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc5b3ef0000>; Mon, 25 Oct 2010 09:44:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 25 Oct 2010 09:44:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 25 Oct 2010 09:44:20 -0700
Message-ID: <4CC5B3C9.60000@caviumnetworks.com>
Date:   Mon, 25 Oct 2010 09:43:53 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Is it any serial8250 platform driver available?
References: <AEA634773855ED4CAD999FBB1A66D0760126B496@CORPEXCH1.na.ads.idt.com> <4CC1E677.1090404@caviumnetworks.com> <AEA634773855ED4CAD999FBB1A66D0760126B6FC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760126B6FC@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2010 16:44:20.0574 (UTC) FILETIME=[DF379FE0:01CB7463]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/25/2010 08:37 AM, Ardelean, Andrei wrote:
> Hi David,
>
> I studied this driver and few other examples and I have one question
> regarding the driver configuration:
> Which field must be initialized in the plat_serial8250_port structure:
> 	unsigned long	iobase;		/* io base address */
> 	void __iomem	*membase;	/* ioremap cookie or NULL */
> 	resource_size_t	mapbase;	/* resource base */
> Some drivers init only one of them, other two fields.
>
> My UART is located at 0x1bf01000, can I put this value in all those
> fields?
>

As with many things in life, it depends.

In this case it depends on the flags you pass as well as any serial_in() 
and serial_out() functions you may have.  It is fortunate you have the 
source code available, you can use it to see how the different options 
affect things.

David Daney


> Thanks,
> Andrei
>
>
> -----Original Message-----
> From: David Daney [mailto:ddaney@caviumnetworks.com]
> Sent: Friday, October 22, 2010 3:31 PM
> To: Ardelean, Andrei
> Cc: linux-mips@linux-mips.org
> Subject: Re: Is it any serial8250 platform driver available?
>
> On 10/22/2010 12:23 PM, Ardelean, Andrei wrote:
>> Hi,
>>
>> I am porting MIPS Linux from MALTA to a new board. I ported early
>> console code from malta_console.c and I am looking now to use a
>> interrupt driven driver for TTY. My UART is compatible with 8250 (1
> UART
>> port only) but the UART registers are directly mapped in CPU memory
> map.
>> There is no PCI bus. My problem is that the driver implemented in
> 8250.c
>> is very complex and it seems to be hardcode for ISA bus, is it any
>> simple platform UART driver available to be directly mapped in the CPU
>> space? Can you give me some advice what would be a good approach for
> my
>> case?
>>
>
> Many chips have 8250 compatible ports and use 8250.c.
>
> See arch/mips/cavium-octeon/serial.c
>
> David Daeny
>
