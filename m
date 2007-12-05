Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 19:22:12 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:54029 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20032114AbXLETWE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2007 19:22:04 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CAC463ECC; Wed,  5 Dec 2007 11:22:01 -0800 (PST)
Message-ID: <4756FA6C.6040807@ru.mvista.com>
Date:	Wed, 05 Dec 2007 22:22:20 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@fh-hagenberg.at>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Alchemy: fix interrupt routing
References: <200712051908.18780.sshtylyov@ru.mvista.com> <4756D42E.9040609@fh-hagenberg.at> <20071205182353.GC10697@linux-mips.org> <4756F494.8090207@ru.mvista.com> <20071205191208.GA12547@linux-mips.org>
In-Reply-To: <20071205191208.GA12547@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>>   It works:

>>41 total events, 5.109 events/sec

> That's the expected behaviour, good.

> One of the remaining problems on some platforms with tickless kernels is
> that not all clocksource / clockevent driver combinations are playing
> nicely with each other.  You can switch the clocksource driver manually
> at runtime.  First let's see what clocksource we have:
> 
>   # cd /sys/devices/system/clocksource/clocksource0/
>   # cat available_clocksource 
>   MIPS pit jiffies 

    I only have MIPS and jiffies of course. :-)

>   # cat current_clocksource 
>   MIPS 

> MIPS is the CP0 count register.  pit is the i8259 and jiffies simply counts
> interrupts like in the old days so has problems with lost timer interrupts
> and generally not such a great idea for tickless.  You should be able to
> switch between all these drivers by something like:

>   # echo jiffies > current_clocksource
>   Time: jiffies clocksource has been installed.
>   #

> Try switching between all the available clocksources a few times to see if
> that's working right also.

    It died after I selected jiffies.

>    Ralf

WBR, Sergei
