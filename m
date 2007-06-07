Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 14:41:33 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:37553 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20027221AbXFGNla (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2007 14:41:30 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4437D3EC9; Thu,  7 Jun 2007 06:41:28 -0700 (PDT)
Message-ID: <46680B75.5040809@ru.mvista.com>
Date:	Thu, 07 Jun 2007 17:43:17 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
References: <20070606185450.GA10511@linux-mips.org>	 <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>	 <20070607113032.GA26047@linux-mips.org> <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
In-Reply-To: <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Franck Bui-Huu wrote:

> Actually I'm wondering if we shouldn't create a new file
> "arch/mips/kernel/time2.c" which will be a complete rewrite of the
> old one (interrupt handler, function pointers, clocksource,
> clockevent). This file would be the future replacement of the old
> time.c. This new file would be used only if the board have been
> updated accordingly. That may help to migrate...

    We've been there and done that -- for George Anzinger's HRT. :-)

>>> Another issue I have is to implement clockevent set_mode() method. You
>>> left it empty but I think we need at least to shut down the timer
>>> interrupt when setting the clock event device. Strangely I haven't
>>> found a "generic" way to stop them through cp0. Have I missed
>>> something ?

>> You can mask the count/compare interrupt in the status register like any
>> other interrupt.  Keep in mind that on many CPUs this interrupt is
>> shared with the performance counter interrupt so cannot always be
>> disabled.

> Well this interrupt could be shared with other devices too, couldn't it ?
> If so only the board code can disable it.

>> There is no other disable bit for this interrupt than the IE bit in the
>> status register.  So it may just have to be ignored.

> That would mean we can't have a tickless system in these cases, wouldn't
> it ?

    No, it doesn't. Even on dyntick kernels, interrupts do happen several 
times a second. Dynticks have nothing to do with disabling timer interrupts...

WBR, Sergei
