Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 14:09:29 +0000 (GMT)
Received: from law10-f109.law10.hotmail.com ([IPv6:::ffff:64.4.15.109]:28168
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224934AbTL2OJ0>; Mon, 29 Dec 2003 14:09:26 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 29 Dec 2003 06:09:17 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 29 Dec 2003 14:09:17 GMT
X-Originating-IP: [63.121.54.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: kevink@mips.com, linux-mips@linux-mips.org
Subject: gdbserver and Re: hardware questions
Date: Mon, 29 Dec 2003 14:09:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F1098NvzHr4sR00062b5c@hotmail.com>
X-OriginalArrivalTime: 29 Dec 2003 14:09:17.0954 (UTC) FILETIME=[59037620:01C3CE15]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Kevin

Good to hear from you.

Thank you to you and Geert for saving me the grief of buying the wrong 
hardware!

The whole point of buying some mipsel hardware is to better track down a 
SIGSEGV I'm having with kaffe on my mipsel pda.

People on this list have suggested I use gdbserver.  I've played around with 
it over the last month and have a feeling that it won't work.

I use busybox so its init applet can handle all the linux startup stuff I 
don't understand.  One side effect is it starts a shell on /dev/ttyS0.  No 
problem.

I can start gdbserver on the pda:  gdbserver /dev/ttyS0 ...

On my linux laptop, I can start gdb but, when I do:

target remote /dev/ttyS0

I never get connected to gdbserver on the pda.

I suspect its because there's alread a shell running on /dev/ttyS0.  Does 
this sound reasonable?

Other than debugging with gdb, any suggestions as to tracking down a SIGSEGV 
on a pda with a shell on /dev/ttyS0?

Mark




>From: "Kevin D. Kissell" <kevink@mips.com>
>To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,   
><linux-mips@linux-mips.org>
>Subject: Re: hardware questions
>Date: Mon, 29 Dec 2003 12:39:02 +0100
>
>As Geert pointed out, the big-endian SGI hardware configuration
>and the little-endian PDA configuration mean that you'll be cross-compiling
>for "mipsel" (MIPS endian-little) on the Indigo anyway.  SGI did
>use industry-standard monitors, keyboards, and disks units of the
>period (which was 10 years ago - they could be hard to find today),
>but used non-standard NIC and memory cards. You're probably better
>off using a Linux PC as your development host.
>
>----- Original Message -----
>From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
>To: <linux-mips@linux-mips.org>
>Sent: Sunday, December 21, 2003 17:20
>Subject: hardware questions
>
>
> >
> > Hi folks
> >
> > I'm the guy with the Helio pda running an r3912 chip.  In an effort to
> > create a better development environment, I'm thinking about puchasing a
> > Silicon Graphics Iris Indigo Workstation.
> >
> > But, I'm unfamiliar with MIPS hardware.
> >
> > First of all, will code developed on this machine run on the r3912 chip?
> > The r3912 is little endian mips, 16 bit I think but maybe 32 bit.
> >
> > Can off the shelf monitors, keyboards, hard drives, NICs and memory be
> > installed in this system?
> >
> > Mark
> >
> > _________________________________________________________________
> > Grab our best dial-up Internet access offer: 6 months @$9.95/month.
> > http://join.msn.com/?page=dept/dialup
> >
> >
> >

_________________________________________________________________
Working moms: Find helpful tips here on managing kids, home, work —  and 
yourself.   http://special.msn.com/msnbc/workingmom.armx
