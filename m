Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA24213; Mon, 1 Jul 1996 15:13:49 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA19372 for linux-list; Mon, 1 Jul 1996 22:13:44 GMT
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA19365 for <linux@engr.sgi.com>; Mon, 1 Jul 1996 15:13:40 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	for <linux@engr> id KAA02362; Tue, 2 Jul 1996 10:13:24 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id KAA01446 for linux@engr; Tue, 2 Jul 1996 10:13:23 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9607021013.ZM1444@windy.wellington.sgi.com>
Date: Tue, 2 Jul 1996 10:13:22 +0000
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: (Fwd) Re: SGI/MIPS Linux port status
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Folks,

I ping'ed Ralf about shared GNU libc for big endian machines.  At the end of
his reply he asks for some info to help him.  I'm not sure if he is on the
list of blessed people or not, and I suspect there are some others who would
be far more able to answer his question than myself.

Can someone follow this up.....(Ariel, Larry, Bill ???)

Cheers, Alistair

--- Forwarded mail from Ralf Baechle <ralf@Julia.DE>

From: Ralf Baechle <ralf@Julia.DE>
Subject: Re: SGI/MIPS Linux port status
To: alambie@wellington.sgi.com (Alistair Lambie)
Date: Mon, 1 Jul 1996 23:54:00 +0200 (MET DST)

Hi,

> > The even better news is that I've started to rebuild my entire system
> > using ELF shared libraries.  I'll try to make first alpha release of
> > shared library binaries tomorrow for little endian binaries (the above
> > mentioned machines are all little endian); I'll try to generate big
> > endian libs as soon as possible.
> >
> I have been building up a core set of binaries for us to use on the SGI
boxes.
> These are of course big endian, and naturally HUGE because they are
statically
> linked!

I know how big your binaries are - after all I'm still using a mostly
static linked system also.  So I assume that your /bin/ls is also about
15 times the size of the i486-linux shared /bin/ls ...

           Can you let me know when you have big endian shared libs so I can
have
> something a little more sane to deal with.

I'm rebulding my entire toolchain for big endian.  This night I should find
the time to rebuild the libs, also.

> BTW, I assume that you are using GNU libc?

Yes, I'm using GNU libc snapshot 960619.  Linux libc is lacking tons of code
required for MIPS fp support.  The problem is simply that MIPS only has the
capabilities to add, subtract, multiply and divide in hardware, some FPUs
can do sqrt() while Intel/68881/68882 can do many complex computations in
hardware.  Also HJ's way to maintain the code and the code itself made it
a bit of a pain to use Linux libc ...

On which libc is your SGI stuff based?  Also I'm trying to make my work
as SGI-ish as possible.  I don't have access to a SGI or documentation but
have some questions about IRIX regarding the shared lib stuff, PIC code
and more.  Can you help me?

Happy hacking,

  Ralf


---End of forwarded mail from Ralf Baechle <ralf@Julia.DE>

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
