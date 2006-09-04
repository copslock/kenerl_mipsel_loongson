Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Sep 2006 19:20:26 +0100 (BST)
Received: from p549F5EA7.dip.t-dialin.net ([84.159.94.167]:49050 "EHLO
	p549F5EA7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039253AbWIDSUX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Sep 2006 19:20:23 +0100
Received: from h155.mvista.com ([63.81.120.155]:10090 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S1100038AbWIDSNt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Sep 2006 20:13:49 +0200
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A21813EBE; Mon,  4 Sep 2006 11:13:01 -0700 (PDT)
Message-ID: <44FC6D38.1000407@ru.mvista.com>
Date:	Mon, 04 Sep 2006 22:15:20 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Pantelis Antoniou <pantelis@embeddedalley.com>
Cc:	Russell King <rmk@arm.linux.org.uk>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] AMD Alchemy: claim UART memory range
References: <4432BF48.8030403@ru.mvista.com> <44F2E9F7.6030309@ru.mvista.com> <F8D0F572-A68C-4343-A563-23D79BAB25AD@embeddedalley.com> <20060830080157.GA17632@flint.arm.linux.org.uk> <44FC625A.5050005@ru.mvista.com> <4098748B-6105-4644-A86A-B776A23D0272@embeddedalley.com>
In-Reply-To: <4098748B-6105-4644-A86A-B776A23D0272@embeddedalley.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Pantelis Antoniou wrote:

>>>>>  BTW, can anybody enlighten me why 8250_au1x00.c came into  being  
>>>>> at all?
>>>>> Its only function seems to register the UART platform devices,  
>>>>> the  thing
>>>>> that is usually done in the board setup code, i. e. I'd rather  
>>>>> have  it in arch/mips/au1000/common/platform.c (however, 8250.c  
>>>>> should  have been able to filter out ports with UPIO_AU in case   
>>>>> CONFIG_SERIAL_8250_AU1X00 undefined)...

>>>> Seemed like a good idea at the moment to follow the already  
>>>> existing  convention.

>>> Already existing convention is as per Sergei's mail actually - to  
>>> have the
>>> platform device registration in arch/*.  The others which you  
>>> thought were
>>> convention there (accent, boca, fourport, hub6, mca) are all for  add-in
>>> cards and aren't architecture specific.

>>> Hence, they can't live in arch/*.

>>> So yes, 8250_au1x00.c breaks the established convention because it  
>>> isn't
>>> an add-in card.

>>    Thanks for clarification.

>>    Now another question to Pantelis: IIUC, the Alchemy UART  platform 
>> devices have UPF_SKIP_TEST set because of the Alchemy docs  claiming 
>> that UARTs other than UART3 don't have MCR/MSR and only  UART3 does 
>> have the full set of the modem control/status lines?   Were they 
>> indeed failing the loopback test for you? Asking because  on DBAu1550 
>> board all (enabled) UARTs do pass the loopback test if  I get rid of 
>> this flag (however, Au1550 datasheet says MCR/MSR  exists on all 
>> UARTs, just no modem pins exist on UART0, and only  RTS-/CTS- pair on 
>> UART1 -- and the bits having no correspoding pins  seem to be tied 
>> high internally).
>>    If I'm correct, the driver seems inconsistent in how it handles  
>> UART_BUG_NOMSR flag, only checking it when deciding whether to  enable 
>> the modem status interrupts or not while actually it should  have been 
>> checked in serial8250_set_mctrl() and check_modem_status () as well...
>>    It also looks like the driver doesn't use Alchemy UARTs to their  
>> full potential currently: UART3 has not only full set of modem  lines, 
>> but also is capable of the auto flow control (UART1 on  Au1550 also 
>> is).  (Making use of these features howewer are  complicated by the 
>> auto flow control being only available in the  late steppings of 
>> Au1500 and UART3 modem pins being multiplexed  with GPIO...)

>> PS: CCing linux-mips to keep people here informed. :-)

> Yes, 1550 has proper UARTs on all port, but not 1200 ;)

    No, it doesn't have "proper" UARTs on all ports (like all the other 
Alchemies), it's just said it has MCR/MSR on UART0/1 as well as on UART3. 
Actually, Au1200 also does, according to its datasheet.

> Somehow I thought that hacking 8250 to support two different Au's  (1550 
> & 1200)
> wouldn't go down well; so I chickened out & settled for a subset that  
> would work on
> both. Feel free to fight your way through to support all the  
> functionality you
> require.

    Well, now I certainly have no time for enabling any features, even for 
fixing buglets. So, if anybody of the linux-mips readers cares enough, it's 
their call... :-)
    At least UART_BUG_NOMSR handling should be extended if MCR/MSR are indeed 
missing on some SOCs.
    And since 0 in the bit 7 (U3) bit of sys_pinfunc determines if UART3 modem 
control/status are used for GPIO, this is also worth checking somewhere (if 
one wants to support the full set of the modem lines)...

> Pantelis

WBR, Sergei
