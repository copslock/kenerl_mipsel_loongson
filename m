Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 14:12:52 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:37103 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20027212AbXFGNMt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 14:12:49 +0100
Received: by py-out-1112.google.com with SMTP id f31so855508pyh
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2007 06:11:48 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sKwl+jhGy7ojUxuOTuGk6J50Ottw2Jye7+ZdNgmEi8EceQrsIIEs69fpdtziAiB7pNue/6S0xDfCmidF9l+1NOHW872absNPzUGwaLQGC6MqrojoFqUhdZjcrGysrJ/Az9a6NQPS0sgnGgLW7rwA9koRScX1LTrakxh7dfNJYqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j/pq+OumHiYs/azaO3k27o0IujpndLCUQ0i78ifn+S6ag18lmSorDpy2w69aZpSCLO/LSxyH9UGfTxziGaeTrrtlKxdE+lyzmhK3If9G0CrOGLD/hZaZQpsF3tfi8flD4iuOp9aRAgUyxo9cOmi3lurtkZU012VC0EU6YsUL0aY=
Received: by 10.65.133.8 with SMTP id k8mr3024605qbn.1181221908290;
        Thu, 07 Jun 2007 06:11:48 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 7 Jun 2007 06:11:48 -0700 (PDT)
Message-ID: <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
Date:	Thu, 7 Jun 2007 15:11:48 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070607113032.GA26047@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070606185450.GA10511@linux-mips.org>
	 <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
	 <20070607113032.GA26047@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jun 07, 2007 at 09:59:53AM +0200, Franck Bui-Huu wrote:
>
>>> I'm working on getting dyntick and highres timer support working for MIPS.
>>> This unavoidably implies dumping most of the MIPS-private time
>>> infrastructure we've piled up over the past decade.  Which really is a
>>> major crapectomy.  A first cut of the patches which are tested to
>>> run
>> That's definitely true. I wrote my own version of clockevent support
>> yesterday based on your patchset "dyntick-quilt" and I end up rewrite
>> the whole time.c. The biggest part of the job would be to split this
>> into several patches to ease the review but I doubt it worth it since
>> we rewrite it almost from scratch.
>
> I'm actually getting closer and closer to the point where keep things in
> a nicely split patchset stops being workable.
>

Actually I'm wondering if we shouldn't create a new file
"arch/mips/kernel/time2.c" which will be a complete rewrite of the
old one (interrupt handler, function pointers, clocksource,
clockevent). This file would be the future replacement of the old
time.c. This new file would be used only if the board have been
updated accordingly. That may help to migrate...

>> Another issue I have is to implement clockevent set_mode() method. You
>> left it empty but I think we need at least to shut down the timer
>> interrupt when setting the clock event device. Strangely I haven't
>> found a "generic" way to stop them through cp0. Have I missed
>> something ?
>
> You can mask the count/compare interrupt in the status register like any
> other interrupt.  Keep in mind that on many CPUs this interrupt is
> shared with the performance counter interrupt so cannot always be
> disabled.

Well this interrupt could be shared with other devices too, couldn't it ?
If so only the board code can disable it.

> There is no other disable bit for this interrupt than the IE bit in the
> status register.  So it may just have to be ignored.
>

That would mean we can't have a tickless system in these cases, wouldn't
it ?

> Other issues to solve:
>
>   o The R4000/R4400 (others?) allow the use of hwint5 for either the
>     count/compare interrupt or as a normal hardware interrupt.  The switch
>     happens based on a bootstream setting.  There is no config register
>     bit for this, so we either have to hardcode the knowledge about the
>     affected machines or construct a probe.  Where the count/compare is
>     not usable we cannot use this as a clockevent device.
>   o Old revisions of the R4000 have a bug where if the count register is
>     read in exactly the moment where it matches the compare register the
>     timer interrupt is lost.  This means the system will be interrupt-less
>     for the next typicall like 86s (at the typical 100MHz clock for the
>     affected processors).  The workaround needs to be implemented.
>
> Both are currently the least of my concerns, there is much bigger fish to
> catch ...
>

I agree a first implementation without these concerns addressed would
be easier. But it's still good to keep them in mind.

>> BTW any idea when "time-ntp-make-cmos-update-generic.patch" is going
>> to be merged into mainline ? Note: I think there's a bug in
>> notify_cmos_timer(). The following test should be negated, shouldn't
>> it ?
>>
>> +	if (no_sync_cmos_clock)
>> +		mod_timer(&sync_cmos_timer, jiffies + 1);
>
> In theory the patch should be in -mm to be merged early just after .22.
>

Haven't found any trace of it.

-- 
               Franck
