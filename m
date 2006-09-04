Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Sep 2006 18:39:17 +0100 (BST)
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173]:2966 "HELO
	smtp104.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039235AbWIDRjP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Sep 2006 18:39:15 +0100
Received: (qmail 24362 invoked from network); 4 Sep 2006 17:39:05 -0000
Received: from unknown (HELO ?192.168.1.19?) (pantelis@embeddedalley.com@62.1.231.13 with plain)
  by smtp104.biz.mail.re2.yahoo.com with SMTP; 4 Sep 2006 17:39:04 -0000
In-Reply-To: <44FC625A.5050005@ru.mvista.com>
References: <4432BF48.8030403@ru.mvista.com> <44F2E9F7.6030309@ru.mvista.com> <F8D0F572-A68C-4343-A563-23D79BAB25AD@embeddedalley.com> <20060830080157.GA17632@flint.arm.linux.org.uk> <44FC625A.5050005@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <4098748B-6105-4644-A86A-B776A23D0272@embeddedalley.com>
Cc:	Russell King <rmk@arm.linux.org.uk>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 8BIT
From:	Pantelis Antoniou <pantelis@embeddedalley.com>
Subject: Re: [PATCH] AMD Alchemy: claim UART memory range
Date:	Mon, 4 Sep 2006 20:38:55 +0300
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <pantelis@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pantelis@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On 04 Σεπ 2006, at 8:28 ΜΜ, Sergei Shtylyov wrote:

> Hello.
>
> Russell King wrote:
>
>>>>  BTW, can anybody enlighten me why 8250_au1x00.c came into  
>>>> being  at all?
>>>> Its only function seems to register the UART platform devices,  
>>>> the  thing
>>>> that is usually done in the board setup code, i. e. I'd rather  
>>>> have  it in arch/mips/au1000/common/platform.c (however, 8250.c  
>>>> should  have been able to filter out ports with UPIO_AU in case   
>>>> CONFIG_SERIAL_8250_AU1X00 undefined)...
>
>>> Seemed like a good idea at the moment to follow the already  
>>> existing  convention.
>
>> Already existing convention is as per Sergei's mail actually - to  
>> have the
>> platform device registration in arch/*.  The others which you  
>> thought were
>> convention there (accent, boca, fourport, hub6, mca) are all for  
>> add-in
>> cards and aren't architecture specific.
>
>> Hence, they can't live in arch/*.
>
>> So yes, 8250_au1x00.c breaks the established convention because it  
>> isn't
>> an add-in card.
>
>    Thanks for clarification.
>
>    Now another question to Pantelis: IIUC, the Alchemy UART  
> platform devices have UPF_SKIP_TEST set because of the Alchemy docs  
> claiming that UARTs other than UART3 don't have MCR/MSR and only  
> UART3 does have the full set of the modem control/status lines?   
> Were they indeed failing the loopback test for you? Asking because  
> on DBAu1550 board all (enabled) UARTs do pass the loopback test if  
> I get rid of this flag (however, Au1550 datasheet says MCR/MSR  
> exists on all UARTs, just no modem pins exist on UART0, and only  
> RTS-/CTS- pair on UART1 -- and the bits having no correspoding pins  
> seem to be tied high internally).
>    If I'm correct, the driver seems inconsistent in how it handles  
> UART_BUG_NOMSR flag, only checking it when deciding whether to  
> enable the modem status interrupts or not while actually it should  
> have been checked in serial8250_set_mctrl() and check_modem_status 
> () as well...
>    It also looks like the driver doesn't use Alchemy UARTs to their  
> full potential currently: UART3 has not only full set of modem  
> lines, but also is capable of the auto flow control (UART1 on  
> Au1550 also is).  (Making use of these features howewer are  
> complicated by the auto flow control being only available in the  
> late steppings of Au1500 and UART3 modem pins being multiplexed  
> with GPIO...)
>
> WBR, Sergei
>
> PS: CCing linux-mips to keep people here informed. :-)

Hi Sergei,

Yes, 1550 has proper UARTs on all port, but not 1200 ;)

Somehow I thought that hacking 8250 to support two different Au's  
(1550 & 1200)
wouldn't go down well; so I chickened out & settled for a subset that  
would work on
both. Feel free to fight your way through to support all the  
functionality you
require.

Pantelis
