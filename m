Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Feb 2008 15:40:43 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:58247 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28594800AbYB2Pkl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Feb 2008 15:40:41 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 10CAC3EC9; Fri, 29 Feb 2008 07:40:37 -0800 (PST)
Message-ID: <47C827B8.5050209@ru.mvista.com>
Date:	Fri, 29 Feb 2008 18:41:44 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Daniel Laird <daniel.j.laird@nxp.com>, linux-mips@linux-mips.org
Subject: Re: PNX8550 Broken on Linux 2.6.24 - Interrupt issues?
References: <64660ef00802280457i3eef020chd70f85c011c5a770@mail.gmail.com> <20080228222638.GB25013@linux-mips.org>
In-Reply-To: <20080228222638.GB25013@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>I have been happily using Linux 2.6.22.1 for ages on PNX8550 (STB810).
>> I have recently decided to step up and move onto Linux 2.6.24 series.
>>However I am not getting very far. :-(

    Heh, Daniel, you're not alone -- the Alchemy code got much more breakage 
before 2.6.24... :-)

>>The board crashes as soon as local_irq_enable is called in main.c

>>I was wondering if anyone out there might also be running on an
>>STB810/JBS PNX8550 based system and have any ideas as to why I am
>>crashing.
>>I know that PNX8550 does not enable the R4K Clock source stuff as the
>>chip is a bit 'special' and requires the two timers to be used instead
>>of one.

> csrc-r4k.c and cevt-r4k.c assume a standard compliant R4000-style
> c0_count and c0_compare register.  The PNX chips violate the expected
> behaviour badly so can't use these functions.

> But that's not very much of a problem.  The timer code is module and
> it is easy to write something like csrc-pnx.c and cevt-pnx.c to drive
> a PNX style count/compare timer.

    The PNX counter 0 can still be used as the standards clocksource with some 
ad-hockery (setting comparator to all ones and hooking the interrupt to clear 
it) but Vitaly went another way using counter 1 for clocksource, and counter 0 
as clockevent...

> Will look over the code to see if I can spot what crashes the PNXes.

>   Ralf

WBR, Sergei
