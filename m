Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9T8prR27021
	for linux-mips-outgoing; Mon, 29 Oct 2001 00:51:53 -0800
Received: from t111.niisi.ras.ru ([193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9T8pj027018
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 00:51:45 -0800
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id LAA29839;
	Mon, 29 Oct 2001 11:50:47 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id MAA07482; Mon, 29 Oct 2001 12:41:31 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id LAA09240; Mon, 29 Oct 2001 11:25:26 +0300 (MSK)
Message-ID: <3BDD12C8.A8D62ACB@niisi.msk.ru>
Date: Mon, 29 Oct 2001 11:26:48 +0300
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Backspace on Virtual Console causes oops
References: <20011026183751.15156.qmail@web11906.mail.yahoo.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:
> 
> Gleb,
> 
> > Guess 1: You've got PC UARTs and
> > drivers/char/serial.c
> > Guess 2: TAB TAB in bash causes the oops too.
> > Guess 3: You didn't change famous beep function in
> > the driver.
> 
> Correct on all 3 counts. Thanks for pointing the way.

In fact, guess 1 is irrelevant. :-)

> 
> I am grateful that my problem was solved quickly. But
> before I posted to the list I did a search on
> "Backspace oops linux", "Backspace crash linux" and a
> few other combinations to see if this was possibly a
> known problem. But turned nothing up.
> Is there any other list / repository I should be
> looking at to pick up on bugs like this ?
> 
> Any tips / info would be greatly appreciated.

This is a famous problem, just look at vt.c, you'll see a lot of ifdefs
around sound routines. Just every porting engineer who encounter this
problem solved it himself (and added own ifdef to vt.c). In my case, I
just got fault epc, found the address in objdump -D output and look at
the sources. For me it seems easier, than posting a message to a list.
<nothing personal, really>

Regards,
Gleb.
