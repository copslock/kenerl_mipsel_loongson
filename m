Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 10:08:28 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.224]:8329 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021601AbXFHJIZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Jun 2007 10:08:25 +0100
Received: by wx-out-0506.google.com with SMTP id s14so638911wxc
        for <linux-mips@linux-mips.org>; Fri, 08 Jun 2007 02:07:24 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W0PlsBGnT+xG7hBwxPzsSJxM/FOLaVc/o5ObTrJ28JAtFAXqF9dT0yY8haLt5yhTwo2BQ48Zb6zoiA3UGd6ugYVHbYCEdofviuZIWWNRN+CFPedc4CbqJBk/gYvRdJtQXHxZVQFwfEdjp8fofL8dNMkpxsCOS2WdB/3KXAfftOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uQz+ozmFdP/QX8lsm7zBWKy034kj/P+mte8HIl3cFA44k0Vhal8rfE/YsL7sOH62QGDKlhRjYYE0IIvM+XSxAPVGt3jei6fdPLxtZnCimh3uFmYPcuJWK73lnUk8yHUpZxX+jD28E+v3RAqI7g9oVX5C4ruLAK2kh+DZ864NU14=
Received: by 10.65.163.8 with SMTP id q8mr4756046qbo.1181293643776;
        Fri, 08 Jun 2007 02:07:23 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Fri, 8 Jun 2007 02:07:23 -0700 (PDT)
Message-ID: <cda58cb80706080207ia8a6633na921c5faa69344cd@mail.gmail.com>
Date:	Fri, 8 Jun 2007 11:07:23 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070607151447.GF26047@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070606185450.GA10511@linux-mips.org>
	 <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
	 <20070607113032.GA26047@linux-mips.org>
	 <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
	 <20070607151447.GF26047@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/7/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jun 07, 2007 at 03:11:48PM +0200, Franck Bui-Huu wrote:
>
> > Actually I'm wondering if we shouldn't create a new file
> > "arch/mips/kernel/time2.c" which will be a complete rewrite of the
> > old one (interrupt handler, function pointers, clocksource,
> > clockevent). This file would be the future replacement of the old
> > time.c. This new file would be used only if the board have been
> > updated accordingly. That may help to migrate...
>
> And we'll still be stuck with the compat crap for years - no thank you.
> One of the strength of Linux has always been that if necessary we've been
> able to turn the code base upside down as needed - even if sometimes it
> takes a snow plough to move old stuff out of the way ;-)
>

OK.

> > >You can mask the count/compare interrupt in the status register like any
> > >other interrupt.  Keep in mind that on many CPUs this interrupt is
> > >shared with the performance counter interrupt so cannot always be
> > >disabled.
> >
> > Well this interrupt could be shared with other devices too, couldn't it ?
> > If so only the board code can disable it.
>
> No, the boot mode bit controls a multiplexer so there is either count/compare
> or the external interrupt.
>

The board I'm working on shares count/compare interrupt with others
devices. Actually an external interrupt controller, which is a simple
MUX, allows several devices to share the same irq line. To know which
device generates an irq you need to probe this irq controller.

So it seems to me that if the hardware designers decide to not reserve
the highest irq line for the timer irq, you're in trouble...

> > >There is no other disable bit for this interrupt than the IE bit in the
> > >status register.  So it may just have to be ignored.
> > >
> >
> > That would mean we can't have a tickless system in these cases, wouldn't
> > it ?
>
> It would simply mean we will receive a useless every 2^32 cycles - nothing
> terrible.  The tickless kernel isn't really tickless.  It's more accurately
> called dyntick.  One thing that keeps us from completly getting rid of
> regular timer interrupts under all circumstances is the current scheduler.
> Only if a CPU is idle Linux can stop the regular timer interrupts for it.
> With all the software interrupts that happen to be running on a usual
> system we expect just a hand full of interrupts per second.  And the good
> news is that mingo's current scheduler work is going to remove the concept
> of time slices from the scheduler and once that is done we _finally_ will
> be able to go even on non-idle CPUs.
>

OK.

thanks,
-- 
               Franck
