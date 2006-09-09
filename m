Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Sep 2006 18:17:25 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:35834 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038495AbWIIRRX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 9 Sep 2006 18:17:23 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C17083F61; Sat,  9 Sep 2006 10:17:20 -0700 (PDT)
Message-ID: <4502F7A9.3080301@ru.mvista.com>
Date:	Sat, 09 Sep 2006 21:19:37 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	rmk@arm.linux.org.uk, linux-serial@vger.kernel.org,
	linux-mips@linux-mips.org,
	=?ISO-8859-1?Q?Thomas_K=F6ller?= <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com> <44F5911D.8020807@ru.mvista.com>
In-Reply-To: <44F5911D.8020807@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>>>> @@ -289,6 +296,36 @@ static inline int map_8250_out_reg(struc
>>>>     return au_io_out_map[offset];
>>>> }
>>>>
>>>> +#elif defined (CONFIG_SERIAL_8250_RM9K)
>>>> +
>>>> +static const u8
>>>> +    regmap_in[8] = {
>>>> +        [UART_RX]    = 0x00,
>>>> +        [UART_IER]    = 0x0c,
>>>> +        [UART_IIR]    = 0x14,
>>>> +        [UART_LCR]    = 0x1c,
>>>> +        [UART_MCR]    = 0x20,
>>>> +        [UART_LSR]    = 0x24,
>>>> +        [UART_MSR]    = 0x28,
>>>> +        [UART_SCR]    = 0x2c
>>>> +    },
>>>> +    regmap_out[8] = {
>>>> +        [UART_TX]     = 0x04,
>>>> +        [UART_IER]    = 0x0c,
>>>> +        [UART_FCR]    = 0x18,
>>>> +        [UART_LCR]    = 0x1c,
>>>> +        [UART_MCR]    = 0x20,
>>>> +        [UART_LSR]    = 0x24,
>>>> +        [UART_MSR]    = 0x28,
>>>> +        [UART_SCR]    = 0x2c
>>>> +    };

>>>    I guess you're using regshift == 0?

>> Yes.

>    Well, regshift of 2 seems more fitting for the 32-bit registers. This 
> is not principal but using 0 regshift don't actually buy anything -- the 
> shift will be perfomed anyway.

    Not only that -- look at serial8250_request_std_resources(). Withouth the
proper regshift of 2 it won't be able to correctly calculate UART decoded
memory range size.  So, 0 simply doesn't fit.

>> implementations, and hence every code to support a nonstandard device 
>> must define an
>> iotype of its own, even though one of the existing iotypes would work 
>> just fine? In my

>    UPIO_MEM32 doesn't actually cover your case as it corresponds to the 
> UART with the
> fully 8250-compatible register set, just having 32-bit registers instead 
> of the usual
> 8-bit ones. RM9000 is clearly not fully compatible to 8250 in regard to 
> the register
> addresses since it has RX/TX regs, FCR and the divisor latch mapped to 
> the separate
> addresses, just like Alchemy UART. And I stressed that it's the main 
> issue with this
> UART's compatibility to 8250 in my first followup.

    Further on, even if the regshift is correct it (being used as 8 << 
regshift) still won't give you the correct resource size since as I just said, 
the UART is not 8250-compatible and has more than 8 32-bit registers. So we 
end up with the need to modify serial8250_request_std_resources() and 
serial8250_release_std_resources().

>> Thomas

WBR, Sergei
