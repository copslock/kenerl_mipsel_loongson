Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 May 2006 14:36:56 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:37566 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133380AbWEPMgr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 May 2006 14:36:47 +0200
Received: (qmail 24342 invoked from network); 16 May 2006 16:43:20 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 16 May 2006 16:43:20 -0000
Message-ID: <4469C71F.9060004@ru.mvista.com>
Date:	Tue, 16 May 2006 16:35:43 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Herbert Valerio Riedel <hvr@gnu.org>
CC:	Clem Taylor <clem.taylor@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: CONFIG_PRINTK_TIME and initial value for jiffies?
References: <ecb4efd10605151341l33f491f1ueca8a0ce609c989d@mail.gmail.com>	 <4468EE9B.4000009@ru.mvista.com>  <4468F40F.80902@ru.mvista.com> <1147759399.11301.15.camel@localhost.localdomain>
In-Reply-To: <1147759399.11301.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Herbert Valerio Riedel wrote:

> On Tue, 2006-05-16 at 01:35 +0400, Sergei Shtylyov wrote:

>>>>I just switched to 2.6.16.16 from 2.6.14 on a Au1550. I enabled
>>>>CONFIG_PRINTK_TIME, and for some reason jiffies doesn't start out near
>>>>zero like it does on x86. The first printk() always seems to have a
>>>>time of 4284667.296000.
>>
>>>>jiffies_64 and wall_jiffies gets initialized to INITIAL_JIFFIES, but
>>>>I'm not sure where jiffies is initialized. INITIAL_JIFFIES is -300*HZ
>>>>(with some weird casting)

>>    Yes, the casting is weird. I somewat doubt that:

>>#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

>>u64 jiffies_64 = INITIAL_JIFFIES;

>>can do the trick of wrapping around 5 mins after boot on x86... :-/

> jfyi, starting with an offset of -300 seconds is done on purpose, to
> expose bugs in drivers which don't handle wrapping of the jiffies;

    Oh, thank you. I've read that in the source code. :-)

> and the trick to get printk to start at offset 0 is either define a
> arch-specific printk_clock() function (it's a weak symbol in
> kernel/printk.c) or like more drivers to it, to provide a sched_clock()
> (which is used by the default printk_clock() function) implementation
> which starts at offset 0...

    sched_clock() defined in arch/i386/kernel/timers/timer_tsc.c can hardly 
provide 0-based time if it's using TSC (at least I can't see where the TSC is 
cleared). Even if it's not using TSC, jiffies_64 is not 0-based as we saw, and 
neither it's set to -300 secs because of the double cast to ulong and then to 
u64 which should clear the high word. Probably something somewhere clears TSC 
but I can see the related code only in arch/i386/kernel/smpboot.c...

> regards,
> hvr

WBR, Sergei
