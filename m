Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QIbsv02302
	for linux-mips-outgoing; Fri, 26 Oct 2001 11:37:54 -0700
Received: from web11906.mail.yahoo.com (web11906.mail.yahoo.com [216.136.172.190])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QIbp002299
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 11:37:51 -0700
Message-ID: <20011026183751.15156.qmail@web11906.mail.yahoo.com>
Received: from [209.243.184.191] by web11906.mail.yahoo.com via HTTP; Fri, 26 Oct 2001 11:37:51 PDT
Date: Fri, 26 Oct 2001 11:37:51 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Backspace on Virtual Console causes oops
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3BD99DAC.EB762713@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gleb,

> Guess 1: You've got PC UARTs and
> drivers/char/serial.c
> Guess 2: TAB TAB in bash causes the oops too.
> Guess 3: You didn't change famous beep function in
> the driver.

Correct on all 3 counts. Thanks for pointing the way.

Also thanks to Pete Popov and James Simmons. In
particular to James for telling me to look at vt.c,
functions kd_nosound and _kd_mksound. I changed the
ifdef to be aware of my board and now the problem is
solved.

To All,

I am grateful that my problem was solved quickly. But
before I posted to the list I did a search on
"Backspace oops linux", "Backspace crash linux" and a
few other combinations to see if this was possibly a
known problem. But turned nothing up.
Is there any other list / repository I should be
looking at to pick up on bugs like this ?

Any tips / info would be greatly appreciated.

Wayne

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
