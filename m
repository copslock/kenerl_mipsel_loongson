Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA13099; Mon, 22 Apr 1996 19:16:38 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id TAA06594; Mon, 22 Apr 1996 19:16:33 -0700
Received: from yon.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id TAA06589; Mon, 22 Apr 1996 19:16:32 -0700
Received: by yon.engr.sgi.com (950413.SGI.8.6.12/940406.SGI.AUTO)
	for linux id TAA28613; Mon, 22 Apr 1996 19:16:30 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199604230216.TAA28613@yon.engr.sgi.com>
Subject: Re: David Miller is on the list
To: linux@yon.engr.sgi.com
Date: Mon, 22 Apr 1996 19:16:30 -0700 (PDT)
In-Reply-To: <199604230140.VAA03615@huahaga.rutgers.edu> from "David S. Miller" at Apr 22, 96 09:40:01 pm
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>
>(note: I looked back over this mail after composing it and I want to
>       warn people who are not familiar with me yet that I am very
>       sarcastic and am full of ridicule even when discussing
>       important topics.  Please don't take it that I lack tact
>       or am not being serious, because that simply isn't the case.)
>
Feel free to express yourself, my english (colloquial and otherwsie)
is bad anyway, and I guess the others don't care :-)


>Here is what I need:
>
>	The following utilities I need for development.
>	1) CVS/RCS, latest on prep.ai.mit.edu is fine
>
RCS comes default with IRIX today. But I know it is not
the latest. OK, and I'll add cvs.


>	2) Emacs-19.31 (rms should release within 2 weeks)
>	3) All GNU smidgen-type utilies as the default binaries
>	   (this include fileutils/sh-utils/sharutils/diffutils/
>	    findutils/...)
>	   Actually, Let me just stop short and say, if there is a
>	   source tarball for it on prep.ai.mit.edu:/pub/gnu I would
>	   like the latest installed on the machine I develop on.
>
Many of these are in our freeware project. Ready to install with
the click of a mouse. (Yes, one of the cool things about SGI is
a joe-user software installer infinitely better than RPM/glint.)

(yon) 84 /var/tmp> which find
/usr/freeware/bin/find
(yon) 85  /var/tmp> which tar
/usr/freeware/bin/tar
(yon) 86 /var/tmp> which grep
/usr/freeware/bin/grep
(yon) 87 /var/tmp> which chmod
/usr/freeware/bin/chmod


I'll add the missing ones. That's easy.

BTW, we called it '/usr/freeware' rather than '/usr/gnu' because
many packages are from other sources and because some of our
customers asked us to stay away from their /usr/local.


>	4) xfishtank (don't laugh)
>
Bingo. Larry runs this too. You weird people. Is this a conspiracy? :-)


>	5) fvwm
>
>	6) teco (Must support full teco command set as described
>	   in original DEC manuals! TECO is _the_ renaissance editor!)
>
I'll try to build these too.


>	The following would be nice, but if it will give people
>	bladder problems to do these then don't go out of your
>	way:
>	1) MIPS 4[40]00 manual is some online format (not postscript,
>	   something I can cut and paste out of an emacs buffer etc.
>	   so maybe info or pure ascii text would be fine, I could
>	   care less about the formatting, I just want the words
>	   there)

For MIPS ABI stuff: try the following web site,

	http://www.mipsabi.org/
Especially:
	http://www.mipsabi.org/Tech/Technical.html

Tell us what's missing there.

As for the MIPS programmer's Assembly manual. There is an excellent one
internally on the Web... I'll try to get you a copy soon.




>	2) Docs on the ethernet/scsi interfaces and I/O bus
>	   architecture for the first machine I will be getting
>	   this to work on, again text/info format would be nice.
>	   Of course I will probably just stuff in the ready
>	   drivers you might be getting to me into Linux but I want
>	   to write my own from scratch in the near future after
>	   that.
>	3) I know as much as a bum on the street about SGI machines
>	   and the various lines, a nice "roadmap to sgi workstations
>	   and servers, plus the hardware gook thats inside" type
>	   thing would be very useful to me.
>
I'll leave these to some other folks on the list.



>	I will feel more comfortable if:
>	1) I became very familiar with who the heavy low level MIPS
>	   assembly level hackers are who I will be dealing with while
>	   I am there.  Please tell me who they are, introduce, make
>	   us say hello to each other, you get the idea.
>
I believe the most knowledgable low-level gurus on the list are
Bill Earl and Jim Barton, I'm sure there are more, I just don't
know everyone on the list personally ...



>	2) I know the policy on loud music in the office I'll be in
>	   ;-)
>
I'm trying to get you an office right by mine :-)


>I've thought it over and to me the best plan for things this summer to
>me is:
>	a) R4400 32-bit "proof of concept, yeah we can pull it off"
>	   port happens first, side effect is that I become intimate
>	   enough with the chip that I can do things more efficiently.
>	b) From here we look into the 64-bit stuff and whether that is
>	   is even desirable on 64-bit.  (this would be my first
>	   64-bit port outside of my initial UltraSparc hacks)
>	c) Also think about the work needed to turn that code into
>	   r3000 friendly code.  Should not be too much as I've done
>	   the "write it on recent architecture design then backport
>	   it to older design which had some limitations" already and
>	   this didn't end up being so bad.
>
Cool.

>Expect more as I think it up... this should keep you guys busy for
>now.
>
>(Any dead-head tape traders at SGI engineering?  Just wondering, may
> want to start talking to them now ;-)
>
You'll find lots of them here ;-)

-- 
Peace, Ariel
