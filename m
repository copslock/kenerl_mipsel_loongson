Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 18:27:49 +0200 (CEST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:2757 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133754AbWEVQ1l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 May 2006 18:27:41 +0200
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k4MGRUm9010562;
	Mon, 22 May 2006 16:27:30 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k4MGRUwQ017069;
	Mon, 22 May 2006 16:27:30 GMT
Message-ID: <4471E672.6000907@am.sony.com>
Date:	Mon, 22 May 2006 09:27:30 -0700
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	Herbert Valerio Riedel <hvr@gnu.org>,
	Clem Taylor <clem.taylor@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: CONFIG_PRINTK_TIME and initial value for jiffies?
References: <ecb4efd10605151341l33f491f1ueca8a0ce609c989d@mail.gmail.com>	 <4468EE9B.4000009@ru.mvista.com>  <4468F40F.80902@ru.mvista.com> <1147759399.11301.15.camel@localhost.localdomain> <4469C71F.9060004@ru.mvista.com>
In-Reply-To: <4469C71F.9060004@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
>    sched_clock() defined in arch/i386/kernel/timers/timer_tsc.c can
> hardly provide 0-based time if it's using TSC (at least I can't see
> where the TSC is cleared). Even if it's not using TSC, jiffies_64 is not
> 0-based as we saw, and neither it's set to -300 secs because of the
> double cast to ulong and then to u64 which should clear the high word.
> Probably something somewhere clears TSC but I can see the related code
> only in arch/i386/kernel/smpboot.c...

I've worked a lot with the printk_times feature, and it's not unusual
on many systems to see weird values before time_init().  On x86 with a
TSC-based sched_clock() you may see values based on whatever
the TSC happens to be after firmware initialization up until time_init().

Note that you can re-base the timings to an arbitrary printk line
using scripts/show_delta.  See
http://tree.celinuxforum.org/CelfPubWiki/PrintkTimesSample2

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
