Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 18:31:32 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:2766 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021938AbXD1Rba (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 18:31:30 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HhqiZ-0005RX-M8; Sat, 28 Apr 2007 17:28:20 +0000
Message-ID: <46338432.5060105@garzik.org>
Date:	Sat, 28 Apr 2007 13:28:18 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] ne: MIPS: Use platform_driver for ne on RBTX49XX
References: <20070425.015549.108742168.anemo@mba.ocn.ne.jp>	<463363ED.3050307@garzik.org> <20070429.022428.71103613.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070429.022428.71103613.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sat, 28 Apr 2007 11:10:37 -0400, Jeff Garzik <jeff@garzik.org> wrote:
>>>  static unsigned int netcard_portlist[] __initdata = {
>>> -	0x300, 0x280, 0x320, 0x340, 0x360, 0x380, 0
>>> +#if defined(CONFIG_ISA) || defined(CONFIG_M32R)
>>> +	0x300, 0x280, 0x320, 0x340, 0x360, 0x380,
>>> +#endif
>>> +	0
>> This looks a bit strange, and perhaps more difficult to maintain long term.
>>
>> I would suggest creating a NEEDS_PORTLIST cpp macro at the top of ne.c, 
>> to be defined or undefined based on CONFIG_xxx symbols.  Then, down in 
>> the code itself, conditionally include or exclude all portlist related 
>> data tables and code.
>>
>> Sound sane?
> 
> Sure.  Do you mean something like this?

Correct.

	Jeff
