Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 14:18:28 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:62103 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8224934AbTL2OS1>;
	Mon, 29 Dec 2003 14:18:27 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id hBTECJvq010529;
	Mon, 29 Dec 2003 06:12:19 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA14918;
	Mon, 29 Dec 2003 06:18:18 -0800 (PST)
Message-ID: <002401c3ce16$b44b1e10$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,
	<linux-mips@linux-mips.org>
References: <Law10-F1098NvzHr4sR00062b5c@hotmail.com>
Subject: Re: gdbserver and Re: hardware questions
Date: Mon, 29 Dec 2003 15:18:58 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

If you want more of a "large format" mipsel platform
to experiment with, you might be able to find an old
"RISC PC" from Siemens or NEC with an R4000
configured little-endian to run NT.  Maybe Ralf has
one in his attic he'd care to sell you. ;o)

I've never used gdbserver myself.  I did manage to get
some use out of the old 2.2-style kernel gdb hooks.
I don't know that it's the root of your problem, but
you should definitely get getty/shells off of whatever
serial port you're trying to use for debug.  In theory,
there are protocols to multiplex serial ports between
gdb streams and other stuff, but I've never had any
luck with them.   You may also need to make sure that
you're starting gdb and gdbserver in the right order.
Certainly, that was the case when booting with kgdb.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: <kevink@mips.com>; <linux-mips@linux-mips.org>
Sent: Monday, December 29, 2003 15:09
Subject: gdbserver and Re: hardware questions


> 
> Kevin
> 
> Good to hear from you.
> 
> Thank you to you and Geert for saving me the grief of buying the wrong 
> hardware!
> 
> The whole point of buying some mipsel hardware is to better track down a 
> SIGSEGV I'm having with kaffe on my mipsel pda.
> 
> People on this list have suggested I use gdbserver.  I've played around with 
> it over the last month and have a feeling that it won't work.
> 
> I use busybox so its init applet can handle all the linux startup stuff I 
> don't understand.  One side effect is it starts a shell on /dev/ttyS0.  No 
> problem.
> 
> I can start gdbserver on the pda:  gdbserver /dev/ttyS0 ...
> 
> On my linux laptop, I can start gdb but, when I do:
> 
> target remote /dev/ttyS0
> 
> I never get connected to gdbserver on the pda.
> 
> I suspect its because there's alread a shell running on /dev/ttyS0.  Does 
> this sound reasonable?
> 
> Other than debugging with gdb, any suggestions as to tracking down a SIGSEGV 
> on a pda with a shell on /dev/ttyS0?
> 
> Mark
> 
> 
> 
> 
> >From: "Kevin D. Kissell" <kevink@mips.com>
> >To: "Mark and Janice Juszczec" <juszczec@hotmail.com>,   
> ><linux-mips@linux-mips.org>
> >Subject: Re: hardware questions
> >Date: Mon, 29 Dec 2003 12:39:02 +0100
> >
> >As Geert pointed out, the big-endian SGI hardware configuration
> >and the little-endian PDA configuration mean that you'll be cross-compiling
> >for "mipsel" (MIPS endian-little) on the Indigo anyway.  SGI did
> >use industry-standard monitors, keyboards, and disks units of the
> >period (which was 10 years ago - they could be hard to find today),
> >but used non-standard NIC and memory cards. You're probably better
> >off using a Linux PC as your development host.
> >
> >----- Original Message -----
> >From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
> >To: <linux-mips@linux-mips.org>
> >Sent: Sunday, December 21, 2003 17:20
> >Subject: hardware questions
> >
> >
> > >
> > > Hi folks
> > >
> > > I'm the guy with the Helio pda running an r3912 chip.  In an effort to
> > > create a better development environment, I'm thinking about puchasing a
> > > Silicon Graphics Iris Indigo Workstation.
> > >
> > > But, I'm unfamiliar with MIPS hardware.
> > >
> > > First of all, will code developed on this machine run on the r3912 chip?
> > > The r3912 is little endian mips, 16 bit I think but maybe 32 bit.
> > >
> > > Can off the shelf monitors, keyboards, hard drives, NICs and memory be
> > > installed in this system?
> > >
> > > Mark
> > >
> > > _________________________________________________________________
> > > Grab our best dial-up Internet access offer: 6 months @$9.95/month.
> > > http://join.msn.com/?page=dept/dialup
> > >
> > >
> > >
> 
> _________________________________________________________________
> Working moms: Find helpful tips here on managing kids, home, work -  and 
> yourself.   http://special.msn.com/msnbc/workingmom.armx
> 
> 
