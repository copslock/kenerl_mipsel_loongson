Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARGBtt20900
	for linux-mips-outgoing; Tue, 27 Nov 2001 08:11:55 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARGBdo20891
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 08:11:46 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA06511;
	Tue, 27 Nov 2001 16:08:48 +0100 (MET)
Date: Tue, 27 Nov 2001 16:08:47 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
In-Reply-To: <20011127135449.B7022@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011127153437.440G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Florian Lohoff wrote:

> >  Huh?  You should be dealing with segments and not sections (as you are
> > loading and not linking the image) and then only LOADable ones.  I believe
> 
> I waded through the sections list copieng all sections which are of
> type PROGBITS which is basically the same. Also i cleared all NOBITS

 It's not the same, sorry -- for sections you would need to handle ones
marked ALLOC in flags.  Of these you need to load ones of type PROGBITS
and zero-fill ones of type NOBITS.  Others may be discarded.  For Linux
you may actually skip NOBITS as well, as the head code zero-fills common
sections itself, but handling them is saner IMO. 

 Still using segments is the proper way and it's simpler as well. 
Additionally for platforms that use physical (or in any way different)
addressing upon boot, you may (and should) use segments' physical
addresses that are not available (assigned) to sections.

> sections. The problem was a progbits section with length > 0 and addr
> = 0 which is IMHO bogus.

 Not bogus -- the only section which matches your criteria I'm seeing is
".pdr": 

$ mipsel-linux-readelf -S vmlinux-mips-2.4.14-20011123
There are 21 section headers, starting at offset 0x2f8e54:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        80040000 001000 2699c0 00 AX   0   0 8192
[...]
  [17] .pdr              PROGBITS        00000000 2c4954 034440 00      0   0  4
[...]
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

But it's not marked as allocatable, so it does not belong to the run-time
image.  See also the "System V Application Binary Interface, Edition 4.1",
chapter 4 for sections and 5 for segments. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
