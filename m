Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 22:51:59 +0000 (GMT)
Received: from smtp004.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.81]:20910
	"HELO smtp004.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224921AbVCTWvn>; Sun, 20 Mar 2005 22:51:43 +0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp004.bizmail.sc5.yahoo.com with SMTP; 20 Mar 2005 22:51:41 -0000
Message-ID: <423DFE7C.7040406@embeddedalley.com>
Date:	Sun, 20 Mar 2005 14:51:40 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@osdl.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org>
In-Reply-To: <20050320224028.GB6727@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, Mar 19, 2005 at 02:13:51PM -0800, Andrew Morton wrote:
> 
> 
>>>au1x00_uart
>>>-----------
>>>
>>>Maintainer: unknown (akpm - any ideas?)
>>
>>Ralf.
> 
> 
> Actually Pete Popov (ppopov@embeddedalley.com) who I put on the cc.

Thanks :)

>>>This is a complete clone of 8250.c, which includes all the 8250-specific
>>>structure names.
>>>
>>>Specifically, I'd like to see the following addressed:
>>>
>>>- Please clean this up to use au1x00-specific names.
>>>- this driver is lagging behind with fixes that the other drivers are
>>>  getting.  Is au1x00_uart actually maintained?
> 
> 
> Sort of; much of the Alchemy development effort is still going into 2.4.

It works and no one has complained about any bugs. But you're right, fixes going 
into other drivers have not made it into this one.

>>>- the usage of UPIO_HUB6
>>>  (this driver doesn't support hub6 cards)
>>>- __register_serial, register_serial, unregister_serial
>>>  (this driver doesn't support PCMCIA cards, all of which are based on
>>>   8250-compatible devices.)
>>>- early_serial_setup
>>>  (should we really have the function name duplicated across different
>>>   hardware drivers?)
> 
> 
> No argument here.  Pete says the AMD Alchemy UART is just different enough
> to be hard to handle in the 8250 and so the driver is just an ugly
> chainsawed version of the 8250.c
> 
> 
>>>The main reason is I wish to kill off uart_register_port and
>>>uart_unregister_port, but these drivers are using it.

I tried a couple of times to cleanly add support to the 8250 for the Au1x 
serial. The uart is just different enough to make that hard, though I admit I 
never spent too much time on it. Sounds like it's time to revisit it again.

Pete
