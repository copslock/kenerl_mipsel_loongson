Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 11:27:22 +0100 (BST)
Received: from web16604.mail.tpe.yahoo.com ([IPv6:::ffff:202.1.236.94]:11159
	"HELO web16604.mail.tpe.yahoo.com") by linux-mips.org with SMTP
	id <S8225717AbUFOK1S>; Tue, 15 Jun 2004 11:27:18 +0100
Message-ID: <20040615102708.42219.qmail@web16604.mail.tpe.yahoo.com>
Received: from [61.66.243.2] by web16604.mail.tpe.yahoo.com via HTTP; Tue, 15 Jun 2004 18:27:08 CST
Date: Tue, 15 Jun 2004 18:27:08 +0800 (CST)
From: =?big5?q?jospehchan?= <jospehchan@yahoo.com.tw>
Subject: Re: "No such device" with PCI card
To: Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
Cc: linux-mips@linux-mips.org, jbglaw@lug-owl.de
In-Reply-To: <40CEBB36.1030707@kilimandjaro.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Return-Path: <jospehchan@yahoo.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jospehchan@yahoo.com.tw
Precedence: bulk
X-list: linux-mips

Hi Dominique,
Thanks for your suggestion and help.
I've tried my VIA VT6212L USB2.0 PCI card on other
Linux system(x86 based) (RedHat 7.2 + kernel 2.4.16). 
And it works fine under kernel 2.4.16 with an USB
patch from kernel 2.4.26.
So I migrated the system to MIPS, but I was stuck by
this problem.
Altough I'm not familiar with device driver, but I
will try Jan-Benedict's suggestion.

BRs, 
 Joseph

<dom@kilimandjaro.dyndns.org> 的訊息：> jospehchan
wrote:
> 
> >
> > After loading the 8139too or usb-uhci module, the
> same problem
> > still happened. So I doubt that something missed
> when configuring the kernel.
> 
> Sorry, but your diagnosis is not quite correct. I'm
> guessing you are
> new to Linux kernel programming, device drivers etc
> (BTW, Jan-Benedict
> suggested you *modify* your kernel source then
> recompile). Why not try
> and get your USB PCI card working on a Linux PC
> computer first? That
> would get most of your questions sorted out without
> compositing them
> with MIPS issues. Then come back on this list and
> knowing that "it
> works on i386" we could help you crossing the little
> gap remaining.
> (Right now it's not even clear whether your USB card
> is supported by
> Linux at all!)
> 
> Not to mean that this list is not ready to provide
> assistance to you
> :-) but the MIPS platform still has rough edges, and
> better suited for
> hardcore programmers to date. I know that because
> I've jumped through
> those hoops myself before: I bought a desktop PCI
> Alpha computer
> almost a decade ago and suffered no end of a pain on
> it :-). This was
> a fun and teaching experience, sure - but also a
> frustrating one at times.
> 
> > BTW, how to mount the sysfs to /sys? I can not
> find the sysfs file
> > system in kernel configuration.
> 
> 
> As root, type:
> 
> mkdir /sys # Ignore error if already
> # exists
> mount /sys /sys -t sysfs
> 
> Then read up on the "Linux 2.6 device driver model":
> Documentation/driver-model/* in the kernel source,
> and
> http://lwn.net/Articles/31185/
> 
> -- 
> << Tout n'y est pas parfait, mais on y honore
> certainement les
> jardiniers >>
> 
> Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
> 
>  

-----------------------------------------------------------------
Yahoo!奇摩Messenger6.0
信箱搭配即時通, 溝通樂趣無窮! 
http://tw.messenger.yahoo.com/
