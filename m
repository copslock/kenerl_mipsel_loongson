Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA56094 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Aug 1998 13:56:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA27111
	for linux-list;
	Thu, 27 Aug 1998 13:56:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA15181;
	Thu, 27 Aug 1998 13:56:12 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA06365; Thu, 27 Aug 1998 13:55:29 -0700
Date: Thu, 27 Aug 1998 13:55:29 -0700
Message-Id: <199808272055.NAA06365@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Honza Pazdziora <adelton@informatics.muni.cz>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        Arnaud Le Neel <Arnaud.Le.Neel@cyceron.fr>, linux@cthulhu.engr.sgi.com
Subject: Re: boot problem for Indy
In-Reply-To: <19980827224215.C19688@aisa.fi.muni.cz>
References: <35E59FBA.96A1900C@cyceron.fr>
	<Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca>
	<19980827224215.C19688@aisa.fi.muni.cz>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Honza Pazdziora writes:
 > 
 > > > Cannot reload bootp()server.cyceron.fr:vmlinux
 > > > Illegal f_magik number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC
 > > > Unable to load bootp()server.cyceron.fr:vmlinux: execute format error
 > > > PS: Here is the description of the Indy i want to boot Linux:
 > > > 	IP22 100MHz R4000 with FPU
 > > 
 > > Hm.  Sounds to me like a processor thing.  Could that be, Ralf?  I'm not
 > > sure I've seen anyone try on an R4000 before, and if so, wha the
 > > implications of are for its cache.
 > 
 > I remember I tried to boot something like 2.1.7* on our older indy
 > with R4000 and the message was very much like this. Shall I retry?

      The PROM on older Indy systems, especially those with R4000
processors, may only support MIPS ECOFF binaries.  Are you booting an
ELF or an ECOFF kernel binary?  If you have an ELF kernel binary, and
it cannot be converted to ECOFF, you may need a two-level loading scheme.
Note that you could try loading sash from the local disk, and then
have sash boot vmlinux via bootp(), since sash does know about 
ELF binaries.
