Received:  by oss.sgi.com id <S305158AbQCHWpd>;
	Wed, 8 Mar 2000 14:45:33 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:24644 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQCHWpL>;
	Wed, 8 Mar 2000 14:45:11 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA23631; Wed, 8 Mar 2000 14:39:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA90002; Wed, 8 Mar 2000 14:43:49 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA03467
	for linux-list;
	Wed, 8 Mar 2000 14:25:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA77528
	for <linux@engr.sgi.com>;
	Wed, 8 Mar 2000 14:25:20 -0800 (PST)
	mail_from (nop@nop.com)
Received: from chmls05.mediaone.net (ne.mediaone.net [24.128.1.70]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05886
	for <linux@engr.sgi.com>; Wed, 8 Mar 2000 14:25:15 -0800 (PST)
	mail_from (nop@nop.com)
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.252.183])
	by chmls05.mediaone.net (8.8.7/8.8.7) with SMTP id RAA17596;
	Wed, 8 Mar 2000 17:24:57 -0500 (EST)
Message-ID: <59c501bf894d$31be85c0$0a00000a@decoy>
From:   "Jay Carlson" <nop@nop.com>
To:     "Ralf Baechle" <ralf@uni-koblenz.de>,
        "Tim Wilkinson" <tim@transvirtual.com>
Cc:     <linux-mips@fnet.fr>, <linux-mips@vger.rutgers.edu>,
        <linux@cthulhu.engr.sgi.com>
References: <38C54F05.458A3EFE@transvirtual.com> <20000308140301.B1425@uni-koblenz.de> <38C6A5D4.F08DFCE4@transvirtual.com> <20000308174251.A6399@uni-koblenz.de> <38C6BE35.C58B0630@transvirtual.com> <20000308180850.D6399@uni-koblenz.de>
Subject: Re: Mips/Linux integration of latest GCC, Binutils & GLibc
Date:   Wed, 8 Mar 2000 17:25:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> > Okay this makes sense.  This then means there's a problem with GLIBC
since it
> > excludes certain files when building a static library but unfortuantely
> > needs them because it uses #ifdef PIC to include bits of code related to
> > shared library workings (essentially it considers PIC to mean SHARED
when
> > this may not infact be the case - not for MIPS anyway).
> >
> > So what you're saying is pretty much how I have my gcc, binutils and
glibc
> > set up - I introduced a -DSHARED to glibc (which I suspect isn't really
> > okay) when building shared libraries so static libraries didn't include
> > the bad code.  I may look for a better solution however.
>
> Indeed.  The problem is just that Ulrich drepper didn't accept such a
patch
> the last time I sent it to him.
>
> > I've also made a bunch of elf related changes to mips/linux so that the
> > assembler output from gcc is more like the elf output for the x86/linux
> > targets.  It's interesting to note that mips/linux doesn't even defined
> > linux for CPP (and doesn't do a bunch of other stuff either come to
that)
> > which confused things no end when compiling the linux kernel.

The mips-linux configuration in gcc 2.95.x out of the box is just awful.  It
was obviously never tested against a full rebuild of the system, or in fact
any significant rebuild.

> Go to oss.sgi.com and get /pub/linux/mips/src/egcs/egcs-1.0.3a-2.diff.gz
> and integrate that with a current egcs.  This is what most people are
> using and is known to work.  It generates assembler output that is known
> to be working with binutils and even halfway human-readable as far as this
> can be said from compiler output.  You'll also find binutils test patches
> for more current releases there.

As Ralf sez, because MIPS PIC and non-PIC code can't intercall, generation
of non-PIC code for use in static libraries is incorrect, unless EVERYTHING
you're linking is non-PIC.   Most people feel that giving up shared
libraries is too high a price for the potential gain in code density and
efficiency from non-PIC/non-ABI builds.  Me, I still have lingering doubts,
but I don't have working code yet, so...

I did a port/translation/reinterpretation of Ralf's configuration in
egcs-1.0.3a-2 for gcc 2.95.1.  My take on this, as expressed in
ftp://ftp.place.org/pub/nop/linuxce/gcc-2.95.1-interim-990916.patch.gz , is
that gcc should always build as PIC, unless some Makefile etc really does
want to ask for the non-PIC lossage.

The primary flag for controlling this in my config
is -mabicalls/-mno-abicalls.  -mabicalls is the default (as it was in Ralf's
config).  -D__PIC__ and -D__pic__ are asserted unless -mno-abicalls is set
(which also implies -fno-pic).   glibc is happy with this.  So is the
kernel.  And random makefiles, libtool, autoconf, etc, can happily build
with their bogus -fpic or -fPIC options from other platforms and not break
anything.

Originally I thought that it would not be necessary to ever pass -KPIC to
the assembler; at the top of each PIC/abicalls assembly file GCC produces,
it sticks in a ".abicalls" directive which has the same effect as the -KPIC
option.  That worked just great until I encountered .S files that didn't
have that directive and didn't know any better, so I had to put the -KPIC
back in :-(

Jay
