Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA25837 for <linux-archive@neteng.engr.sgi.com>; Wed, 13 Jan 1999 07:27:02 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA20715
	for linux-list;
	Wed, 13 Jan 1999 07:26:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id HAA08352
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 13 Jan 1999 07:26:06 -0800 (PST)
	mail_from (chad@roctane.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	for <@sgidal.dallas.sgi.com:linux@cthulhu.engr.sgi.com> id JAA18507; Wed, 13 Jan 1999 09:24:28 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA07617 for <linux@cthulhu.engr.sgi.com>; Wed, 13 Jan 1999 07:25:58 -0800 (PST)
Message-ID: <369CBB05.E6D0C856@roctane.dallas.sgi.com>
Date: Wed, 13 Jan 1999 09:25:57 -0600
From: Chad Carlin <chad@roctane.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: linux <linux@cthulhu.engr.sgi.com>
Subject: Re: (Fwd) Re: same boot vmlinux trouble
References: <9901130912.ZM21964@interceptor.dallas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thanks in advance for the new kernel. Is anyone else out there running on an
R4400?

BTW In an effort to be sure that my antiquated Indy wasn't having problems
due to old rev hardware, I have updated this system with the latest parts.
Argo now has 1) rev 5 24-bit gfx, 2)rev 16 IP24 motherboard. 3) rev 11 PROM.
I'll check the CPU rev level if this matters to anyone.

Chad


Chad Carlin wrote:

> --- Forwarded mail from Alex deVries <adevries@engsoc.carleton.ca>
>
> Date: Tue, 12 Jan 1999 19:57:49 -0500 (EST)
> From: Alex deVries <adevries@engsoc.carleton.ca>
> To: ralf@uni-koblenz.de
> cc: linux <linux@cthulhu.engr.sgi.com>
> Subject: Re: same boot vmlinux trouble
>
> On Tue, 12 Jan 1999 ralf@uni-koblenz.de wrote:
> >
> > Alex, could you brew a binary kernel from CVS?  Thanks.
>
> I will as soon as linus.linux.sgi.com is alive again.  Any news on this?
>
> Incidentally, I've been working for the last few days on rewriting
> libfdisk. This is used inside the RH installer to mdoify and read
> partition tables.  SGI tables are wildly different than anything else of
> course, and libfdisk is really only designed for pc/dos partition tables.
>
> So, I'm rewriting it as nlibfdisk, and has support now for reading pc, sgi
> and macintosh partition tables.  It's flexible enough to easily allow
> other partitioning formats.
>
> Having this solved will let us have a better installer on the SGI, and
> also on Macintosh (both m68k and ppc).
>
> When it's looking a little less stable, I'll ask people here to give it a
> shot on their partition tables (marked read only, of course).
>
> - Alex
>
> ---End of forwarded mail from Alex deVries <adevries@engsoc.carleton.ca>
>
> --
>            -----------------------------------------------------
>             Chad Carlin                          Special Systems
>             Silicon Graphics Inc.                   972.205.5911
>             Pager 888.754.1597          VMail 800.414.7994 X5344
>             chad@sgi.com            http://reality.sgi.com/chad
>            -----------------------------------------------------
>            "His favorite Porsche was never the last. It was
>                 always the next" Said of Dr. Ferdinand Porsche
>

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
             Bumper Sticker: "Happiness is a belt fed weapon."
