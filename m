Received:  by oss.sgi.com id <S553984AbRA2P6U>;
	Mon, 29 Jan 2001 07:58:20 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:49813 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553852AbRA2P6L>;
	Mon, 29 Jan 2001 07:58:11 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA25620;
	Mon, 29 Jan 2001 16:57:08 +0100 (MET)
Date:   Mon, 29 Jan 2001 16:57:08 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, Pete Popov <ppopov@mvista.com>,
        linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
In-Reply-To: <20010127105018.D867@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010129164905.20889E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 27 Jan 2001, Ralf Baechle wrote:

> >  Yep, native builds are more likely to get correct as that's what most
> > developers out there check (there are actually developers who never heard
> > of something like a cross-compilation, sigh...).  But not everyone can
> > afford a week to build glibc or X11... 
> 
> Sounds like DECstation results.  Building all the Redhat 7.0 packages which
> are on oss + some others which could build for MIPS but don't for some
> reason to the point where the build fails takes approx 40h on an Origin 200
> with 2 180MHz R10000 processors and 1.5gb RAM.

 It's mostly RAM-dependent.  A machine with about 4 MB of memory will suck
for compilation regardless of the CPU type.  If you have a decent native
system, why to bother with cross-compiling? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
