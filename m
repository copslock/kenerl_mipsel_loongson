Received:  by oss.sgi.com id <S553958AbRAPURj>;
	Tue, 16 Jan 2001 12:17:39 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:24794 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553949AbRAPURd>;
	Tue, 16 Jan 2001 12:17:33 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA27170;
	Tue, 16 Jan 2001 21:17:45 +0100 (MET)
Date:   Tue, 16 Jan 2001 21:17:45 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ian Chilton <ian@ichilton.co.uk>
cc:     linux-mips@oss.sgi.com
Subject: Re: Current CVS (010116) Boots OK
In-Reply-To: <20010116192836.A26863@woody.ichilton.co.uk>
Message-ID: <Pine.GSO.3.96.1010116210848.5546Z-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 16 Jan 2001, Ian Chilton wrote:

> Just cross compiled the kernel with GCC 2.95.2 and Binutils 2.10.1 and
> booted my Indy R4600:
[...]
> Linux version 2.4.0 (ian@slinky) (gcc version 2.95.3 19991030
> (prerelease)) #1 1
> MC: SGI memory controller Revision 3
> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 00001000 @ 00001000 (reserved)
>  memory: 001c5000 @ 08002000 (reserved)
>  memory: 00579000 @ 081c7000 (usable)
>  memory: 000c0000 @ 08740000 (ROM data)
>  memory: 05800000 @ 08800000 (usable)
> On node 0 totalpages: 57344
> zone(0): 57344 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: console=ttyS0
> Calibrating system timer... 500000 [100.00 MHz CPU]
> NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9
> revision AD
> NG1: Screensize 1280x1024
> Console: colour SGI Newport 160x64
> zs0: console input
> Console: ttyS0 (Zilog8530)
> Calibrating delay loop... 99.73 BogoMIPS
> Memory: 91868k/95716k available (1517k kernel code, 3848k reserved, 84k
> data, 6)

 Great!  The code works.  Thanks for the report.  Hmm, that "6)" at the
end looks weird, though -- there should be something like "xxxk init, 0k
highmem)"... 

 Could you please change "#undef DEBUG" into "#define DEBUG" in
arch/mips/arc/memory.c and check if your system boots this way, either?
I would also appreciate an output from '/proc/iomem' (once you boot into
a shell).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
