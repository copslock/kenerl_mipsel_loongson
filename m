Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA13094; Mon, 22 Apr 1996 19:15:40 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id TAA06483; Mon, 22 Apr 1996 19:15:34 -0700
Received: from soyuz.wellington.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id TAA06467; Mon, 22 Apr 1996 19:15:28 -0700
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	for <linux@cthulhu.engr.sgi.com> id OAA14551; Tue, 23 Apr 1996 14:15:25 +1200
Received: (alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/8.6.9) id OAA21562 for linux@cthulhu.engr.sgi.com; Tue, 23 Apr 1996 14:15:24 +1200
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9604231415.ZM21560@windy.wellington.sgi.com>
Date: Tue, 23 Apr 1996 14:15:23 +0000
In-Reply-To: ariel@yon.engr.sgi.com (Ariel Faigon)
        "MIPS port kickoff meeting" (Apr 19,  5:22pm)
References: <199604200022.RAA24414@yon.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: MIPS port kickoff meeting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Apr 19,  5:22pm, Ariel Faigon wrote:
> Subject: MIPS port kickoff meeting
> Hi LinuxMIPSies,
>
> This is becoming real. Please mark your calendars.
>
> We have Jamaica in B10U, which holds 12 people, from 4-5pm
> on Wednesday April 24th.
>
> I know it may conflict with someone's schedule but p l e a s e
> try your best to show up.
>
Umm...could be a problem.  It's a holiday here in New Zealand, otherwise :-)


>
> Agenda:
> 	1) Quick round table: introduce everyone
> 	2) Sort out some details:
> 		Are we going for a 64-bit kernel?
> 		What MIPS instruction set should we support
> 		[e.g. 3K is important for the embedded market]
> 		What dev tools should we use?
> 		elf/coff stabs/dwarf gcc/cc etc. etc.

My 2c worth:
   1. We should definitely do 32bit, probably 64bit as well.  There is a
      big base of R3k machines out there that are going to start getting
      left behind soon.
   2. We need to go for lowest common denominator (MIPS I) and then add
      conditionals (in the low level bits) later.  The c code can of course be
      compiled as the user wants it.
   3. We need to support machines that don't have a graphics head (servers).
      This requires serial drivers.
   4. We should really tie this project in with what is happening at
      http://lena.fnet.fr/.  Their goal has been to get Linux on ARCS systems
      running little endian, but there is a need for a MIPS port for MIPS (the
      company) R3k machines which needs to be big endian.
   5. Should we use the 'milo' bootloader?

	6.
> 	4) Suggest more ways to accelerate David Miller's ramp up
> 	5) List action items
> 	6) Get volunteers for help on the above
>
Probably not much I can do from here.  Maybe some Beta testing a bit further
down the track (test for bit inversion in the southern hemisphere :-) ).

I still have an interest in getting Linux on to the old MIPS boxes, so maybe
with a few quick hacks after David has worked his magic I can get this to
happen.  I suspect that this would also help CSD out as I know they still get
support calls from people who have these machines and are falling all over the
place with the development environment (svr3, bsd43, svr4).  Often they are
little more than people playing and having a Linux offering may be the best way
to get them out of our hair.  Also, RISC/os is getting a bit long in the tooth
now and there are still some nasty little bugs in it, often comms related which
more often than not is what the person wanted it for!

One thing that would be nice is for someone to minute the meeting to the list
so that those of us who can't attend can see what's happening.  I guess it is
also a good way of documenting the progress as things move along!

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
