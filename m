Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2004 22:40:56 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:48893 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225207AbUHaVkw>;
	Tue, 31 Aug 2004 22:40:52 +0100
Received: from [10.0.10.221] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA30822;
	Tue, 31 Aug 2004 14:40:48 -0700
Message-ID: <4134F061.5080502@mvista.com>
Date: Tue, 31 Aug 2004 14:40:49 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ichinoh@mb.neweb.ne.jp
CC: linux-mips@linux-mips.org
Subject: Re: Reset of USB
References: <F7800BBC-FB5C-11D8-85DA-000A956B2316@mb.neweb.ne.jp>
In-Reply-To: <F7800BBC-FB5C-11D8-85DA-000A956B2316@mb.neweb.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

ichinoh@mb.neweb.ne.jp wrote:

> Hello ,
>
> I invoked the Linux kernel on ALCHEMY DBAU1100 by U-BOOT.
>
> The processing which resets USB-OHCI of the head of a kernel is not 
> completed. (refer to *)
>
> Au1100 does not indicate "reset is completed."
> Is this phenomenon experienced?
>
> In addition,
> this phenomenon is not encountered when starting a kernel by YAMON.

Yamon initializes the CPU and then Linux doesn't have to touch too many 
registers. I'm guessing u-boot doesn't setup the clocking correctly, or 
at all, and that might be your problem. The Yamon code for these boards 
is available and it's easy to read the initialization code.  Take a look 
at it and that should solve your problem.

Pete

>
>
> *:
> arch/mips/au1000/common/setup.c
>
> #ifdef CONFIG_USB_OHCI
>     // enable host controller and wait for reset done
>     au_writel(0x08, USB_HOST_CONFIG);
>     udelay(1000);
>     au_writel(0x0E, USB_HOST_CONFIG);
>     udelay(1000);
>     au_readl(USB_HOST_CONFIG); // throw away first read
>     while (!(au_readl(USB_HOST_CONFIG) & 0x10))
>         au_readl(USB_HOST_CONFIG);
> #endif
>
> Best regards,
> Nyauyama
>
>
