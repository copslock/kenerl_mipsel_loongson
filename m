Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5J9b8nC013678
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 02:37:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5J9b8XV013677
	for linux-mips-outgoing; Wed, 19 Jun 2002 02:37:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5J9b0nC013672
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 02:37:00 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id CAA19938
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 02:39:51 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA27110;
	Wed, 19 Jun 2002 02:39:46 -0700 (PDT)
Message-ID: <002901c21775$45209190$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Hartvig Ekner" <hartvige@mips.com>, "user alias" <linux-mips@oss.sgi.com>
References: <200206190717.g5J7Hnc27328@copfs01.mips.com>
Subject: Re: Linux and the Sony Playstation
Date: Wed, 19 Jun 2002 11:39:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Hartvig Ekner" <hartvige@mips.com>
To: "user alias" <linux-mips@oss.sgi.com>
> > From: "Kevin D. Kissell" <kevink@mips.com>
> > To: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
> > Subject: Linux and the Sony Playstation 2
> > Date: Tue, 18 Jun 2002 15:59:57 +0200
> > 
> > The Sony PS2 Linux kit has been shipping for nearly
> > a month now, and I'm frankly astonished at how little
> > I've seen on this mailing list about it.  For better or
> > for worse, this changes everything for MIPS/Linux.
> > The number of MIPS/Linux users worldwide has
> > just gone up by at least an order of magnitude,
> > and they are on a platform running a 2.2.1-derived
> > kernel and using gcc 2.95.2.
> > 
> > It's a perfectly usable platform out of the box, but
> > Carsten has thrown "crashme" at it, and it goes down
> > relatively quickly.  People trying to port kaffe and
> > other programs that do double-precision float are
> > blocked because there's no double precision on the
> > R5900, and the Sony kernel lacks the Algorithmics
> > emulator.
> 
> The few simple double-precision programs (ala hello world) I ran worked,
> and the compiler substitutes integer code (softfloat) for any double
> precision operation. What are the things known not to work?

You didn't disassemble the code.  The Sony gcc distribution
is hard-wired to generate soft-float code, even if you 
specify -mhard-float on the command line.

Since most embedded/multimedia FP is single precision,
one could imagine why Sony and Toshiba could have
decided to leave out floating doubles.  The real problem
is the accursed C stipulation that all FP arguments be
promoted to doubles.  Having every damned passed
argument converted by the kernel would be a bit of
a hit, but I would expect that, in any (single precision)
floating point computation intensive application, that
would be more than made up for by the time gained
in executing the loops native.  And, as always, we
have the correctness issue.  We need to get the PS2
to 2.4.x (and 2.5) fairly quickly, and we want to 
be able to have interoperability of MIPS32 binaries 
across PS2 and non-PS2 platforms, including those 
who habitually use their FPUs.  I've started hacking 
the current (2.4.18+) MIPS/Algorithmics emulator 
code into the Sony 2.2.1 kernel as a stopgap, but
it's a little tricky to test, given that the Sony tools
go out of their way to stop me generating any 
real FP instructions. 

            Regards,

            Kevin K.
