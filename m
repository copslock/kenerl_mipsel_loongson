Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 18:47:11 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:12889 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038886AbWHYRrJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2006 18:47:09 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CB40E3EEF; Fri, 25 Aug 2006 10:47:04 -0700 (PDT)
Message-ID: <44EF37DD.6090305@ru.mvista.com>
Date:	Fri, 25 Aug 2006 21:48:13 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	dpervushin@ru.mvista.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] NEC EMMA2RH support, revisited
References: <1148208787.6884.9.camel@diimka-laptop> <44EDF1C8.4020507@ru.mvista.com>
In-Reply-To: <44EDF1C8.4020507@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylyov wrote:

>> The patch below is to support NEC EMMA2RH Mark-eins board (R5500-based)
>> Thanks for helping and valuable comments:
>>      the whole linux-mips comminuty
>>     Ralf Baechle
>>     Martin Michlmayr
>>     Thiemo Seufer

>    It seems that the community have overlooked at least one issue with 
> this code:

    Not a big issue as it seems since UARTs are registered as the 8250 
platform devices elsewhere.

>> Index: linux/arch/mips/emma2rh/markeins/setup.c
>> ===================================================================
>> --- /dev/null
>> +++ linux/arch/mips/emma2rh/markeins/setup.c
> 
> [...]
> 
>> +static void inline __init markeins_sio_setup(void)
>> +{
>> +#ifdef CONFIG_KGDB_8250

>    I wonder what it's doing in the Linux/MIPS patch while it's only 
> relevant to the cross-arch KGDB patchset.

    Well, certainly this code does not belong here...

>> +    struct uart_port emma_port;
>> +
>> +    memset(&emma_port, 0, sizeof(emma_port));
>> +
>> +    emma_port.flags =
>> +        UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>> +    emma_port.iotype = UPIO_MEM;
>> +    emma_port.regshift = 4;    /* I/O addresses are every 8 bytes */
>> +    emma_port.uartclk = 18544000;    /* Clock rate of the chip */
>> +
>> +    emma_port.line = 0;
>> +    emma_port.mapbase = KSEG1ADDR(EMMA2RH_PFUR0_BASE + 3);
>> +    emma_port.membase = (u8*)emma_port.mapbase;
>> +    early_serial_setup(&emma_port);
>> +
>> +    emma_port.line = 1;
>> +    emma_port.mapbase = KSEG1ADDR(EMMA2RH_PFUR1_BASE + 3);
>> +    emma_port.membase = (u8*)emma_port.mapbase;
>> +    early_serial_setup(&emma_port);
>> +
>> +    emma_port.irq = EMMA2RH_IRQ_PFUR1;
>> +    kgdb8250_add_port(1, &emma_port);
>> +#endif

>    Why you #ifdef out early_serial_setup() calls is even more 
> interesting. How this kernel is supposed to work at all with such code?!

    Why there was need to register ports early with 8250 driver if KGDB driver 
was enabled -- they don't have that much to do with each other. This  code 
looks dubious even in the context of the KGDB-2 patchset.

WBR, Sergei
