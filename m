Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f67JOgn05924
	for linux-mips-outgoing; Sat, 7 Jul 2001 12:24:42 -0700
Received: from pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f67JOfV05913
	for <linux-mips@oss.sgi.com>; Sat, 7 Jul 2001 12:24:41 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GG400EYZB948K@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Sat, 07 Jul 2001 12:24:40 -0700 (PDT)
Date: Sat, 07 Jul 2001 12:23:26 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: Documentation on MIPS kernel options...
To: sjhill@cotw.com
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3B4761AE.3040601@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <3B473ABF.F2444CEE@cotw.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Steven J. Hill wrote:

> Greetings.
> 
> I have been having some correspondance with Eric Raymond (ESR)
> concerning MIPS configuration options. I have already sent him
> a fairly good sized list of descriptions for some MIPS options
> that will be utilized in the CML2 build system for the 2.5.x
> and 2.6.x series kernels. He sent me another list of items and
> I decided to ask those of you on the list to provide the
> descriptions. Please send me the descriptions and at the end of
> next week I will compile the results and send them off to 
> Eric. Thanks.
> 
> -Steve
 
> CONFIG_ARC_CONSOLE
> CONFIG_AU1000_UART

The uart on the Alchemy Au1000 is almost a 16550 but not quite.  I've 
added support for that uart in the non-standard uart section in 
drivers/char/Config.in.  This option is needed if you want uart support 
for debug and/or serial console.


> CONFIG_EVB_PCI1
> CONFIG_FORWARD_KEYBOARD
> CONFIG_GDB_CONSOLE



> CONFIG_IT8172_REVC

An older version of the IT8172 system controller what has slightly 
different pci mem windows. However, I don't think we need to support 
this anymore so I plan on dumping this asap.


> CONFIG_IT8172_SCR0
> CONFIG_IT8172_SCR1

On the IT8172 system controller, Smart Card Reader 0 and 1.


> CONFIG_SYSCLK_100
> CONFIG_SYSCLK_75
> CONFIG_SYSCLK_83


Let me know if you need additional information.

Thanks,

Pete


 
 
