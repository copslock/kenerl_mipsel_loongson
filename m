Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 17:23:00 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:28369 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037691AbWH3QW6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2006 17:22:58 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F10983EE7; Wed, 30 Aug 2006 09:22:42 -0700 (PDT)
Message-ID: <44F5BB96.7010408@ru.mvista.com>
Date:	Wed, 30 Aug 2006 20:23:50 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Thomas Koeller <thomas.koeller@baslerweb.com>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	=?ISO-8859-1?Q?Thomas_?= =?ISO-8859-1?Q?K=F6ller?= 
	<thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com> <44F5911D.8020807@ru.mvista.com> <44F59E1A.6080505@ru.mvista.com>
In-Reply-To: <44F59E1A.6080505@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>>> +    [PORT_RM9000] = {
>>>>> +        .name        = "RM9000",
>>>>> +        .fifo_size    = 16,
>>>>> +        .tx_loadsz    = 16,
>>>>> +        .fcr        = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>>>>> +        .flags        = UART_CAP_FIFO,
>>>>> +    },
>>>>> };

>>>>> +
>>>>> +#define map_8250_in_reg(up, offset) \
>>>>> +    (((up)->port.type == PORT_RM9000) ? regmap_in[offset] : (offset))
>>>>> +#define map_8250_out_reg(up, offset) \
>>>>> +    (((up)->port.type == PORT_RM9000) ? regmap_out[offset] : 
>>>>> (offset))
>>>>> +
>>>>> +

>>>>    Why you're not using specific iotype for RM9000 UARTs?

>>> Because I did not realize that this was necessary. The device 
>>> registers are

>>    This is strange as you had an opposite example before your eyes.

>    Now, it doesn't seem so strange. I thing I'm gonna agree with your 
> point.

    That was also rash. :-)
    Introducing new UPIO_* values seem to be the necessary evil.
    Shows my knowledge of the serial core. :-<

>>> I would like to return to the port type vs. iotype  stuff once again. 
>>> From what you
>>> wrote I seem to understand that the iotype is not just a method of 
>>> accessing device
>>> registers, but also the primary means of discrimination between 
>>> different h/w

>>    No, it's intended as just a method of accessing device registers.

>    Only relevant to 8250 driver. The method is indeed quite 
> describabable by UPIO_MEM32.

    But since we need to know the addressing scheme before poking at the 
registers in the autoconfig code (and that code seem to be *always* executed 
for the 8250 platform devices) and it's actually different from the other 
8250-compatible UARTs, we have no other solution then to introduce UPIO_AU.
    I guess you're using early_serial_setup() to register UARTs with the 8250 
driver? I think that the platform device method is preferrable now.

>>> implementations, and hence every code to support a nonstandard device 
>>> must define an
>>> iotype of its own, even though one of the existing iotypes would work 
>>> just fine? In my

>>    UPIO_MEM32 doesn't actually cover your case as it corresponds to 
>> the UART with the
>> fully 8250-compatible register set, just having 32-bit registers 
>> instead of the usual
>> 8-bit ones. RM9000 is clearly not fully compatible to 8250 in regard 
>> to the register
>> addresses since it has RX/TX regs, FCR and the divisor latch mapped to 
>> the separate
>> addresses, just like Alchemy UART. And I stressed that it's the main 
>> issue with this
>> UART's compatibility to 8250 in my first followup.

>    What I didn't take into account is that iotype thing is not at all 
> specific to 8250 driver. In the light of this, the reasons for 
> appearance of UPIO_AU and UPIO_TSI indeed seem questionable.

    UPIO_TSI still seems somewhat of an abuse to me WRT to its UUE bit 
workaround. UPIO_AU however is a necessary evil (unless the driver code is 
changed to be able to pass the port type for platform devices and therefore 
not autoconfig them).

>>> Thomas

WBR, Sergei
