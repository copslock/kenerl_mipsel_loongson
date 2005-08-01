Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 20:06:11 +0100 (BST)
Received: from [IPv6:::ffff:67.115.118.5] ([IPv6:::ffff:67.115.118.5]:3855
	"EHLO us0exb05.us.sonicwall.com") by linux-mips.org with ESMTP
	id <S8225929AbVHATFw>; Mon, 1 Aug 2005 20:05:52 +0100
Received: from us0exb02.us.sonicwall.com ([10.50.128.202]) by us0exb05.us.sonicwall.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 1 Aug 2005 12:08:52 -0700
Received: from [10.0.15.99] ([10.0.15.99]) by us0exb02.us.sonicwall.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 1 Aug 2005 12:08:51 -0700
Message-ID: <42EE7343.9020209@total-knowledge.com>
Date:	Mon, 01 Aug 2005 12:08:51 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ppopov@embeddedalley.com
CC:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Au1000 PCMCIA I/O space?
References: <42EDBE3B.3010503@total-knowledge.com> <1122877889.5014.319.camel@localhost.localdomain>
In-Reply-To: <1122877889.5014.319.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2005 19:08:51.0755 (UTC) FILETIME=[743C97B0:01C596CC]
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Hmm, I see. I'm not really using PCMCIA driver - I just have
IDE interface hanging off of PCMCIA controller of Au1000, so
I had to do something similar to drivers/ide/mips/swarm.c.
Thus since I can pass addresses directly to ioremap, I'm OK
anyways.


Pete Popov wrote:

>On Sun, 2005-07-31 at 23:16 -0700, Ilya A. Volynets-Evenbakh wrote:
>  
>
>>Is there any particular reason why Au1000 PCMCIA IO space is not 
>>included in 36-bit address fixup?
>>Attached patch fixes it for me, but I'm wondering if there is valid 
>>reason not to do that.
>>    
>>
>
>Because it's ioremapped by the au1x pcmcia driver and the driver passes 
>the virt address to the pcmcia stack. If this isn't working for you, 
>something else is broken.  You only need the fixup when you can't call 
>ioremap with the entire 36 bit phys address. For example, the attribute and
>common memory space are ioremapped by the "pcmcia stack" in the kernel,
>not the low level socket driver over which we have control. Thus, to
>work around the fact that you can't easily change the entire pcmcia
>stack, you do the fixup thing. 
>
>Unless the pcmcia stack changed, the driver should work as is.
>
>Pete
>
>  
>

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
