Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA11640; Thu, 10 Apr 1997 01:04:23 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA27816 for linux-list; Thu, 10 Apr 1997 01:03:38 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA27792 for <linux@relay.engr.SGI.COM>; Thu, 10 Apr 1997 01:03:34 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id BAA08682 for <linux@relay.engr.SGI.COM>; Thu, 10 Apr 1997 01:03:30 -0700
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id JAA01710;
	Thu, 10 Apr 1997 09:02:25 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id JAA08771; Thu, 10 Apr 1997 09:01:33 +0200
Message-Id: <199704100701.JAA08771@kernel.panic.julia.de>
Subject: Re: all in the family
To: davem@jenolan.rutgers.edu (David S. Miller)
Date: Thu, 10 Apr 1997 09:01:33 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <199704100226.WAA01960@jenolan.caipgeneral> from "David S. Miller" at Apr 9, 97 10:26:18 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>    Looks like I may be getting a machine here to see if we can migrate
>    some of our non-Oracle machines to Linux/SPARC.
> 
>    Anyone know if the emulation is up to hosting the Linux/Indy
>    cross-compiler?
> 
> It should be straight forward, 32-bit to 32-bit crosses under gcc work
> flawlessly right out of the box for everything I've ever tried.  It's
> when you cross from 32-bit to 64-bit that you may hit a bug or two.

I've got the necessary patches to make the binutils and GCC work as
Linux/Alpha -> Linux/MIPS crosscompiler.  Mike, if you need them remind
me to send them if you need them.

>    In related news, we'll then have Linux running on 5 architectures
>    in the same room (Intel, Alpha, SPARC, ELKS, Indy).  Maybe I'll
>    steal the PowerMac too... =)
> 
> ELKS, that is cheating ;-)

:-)

  Ralf
