Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARIQ7Q27144
	for linux-mips-outgoing; Tue, 27 Nov 2001 10:26:07 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARIPto27141
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 10:25:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA11475;
	Tue, 27 Nov 2001 18:23:12 +0100 (MET)
Date: Tue, 27 Nov 2001 18:23:11 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
In-Reply-To: <20011127163602.C9282@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011127180947.440K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Florian Lohoff wrote:

> >  It's not the same, sorry -- for sections you would need to handle ones
> > marked ALLOC in flags.  Of these you need to load ones of type PROGBITS
> > and zero-fill ones of type NOBITS.  Others may be discarded.  For Linux
> > you may actually skip NOBITS as well, as the head code zero-fills common
> > sections itself, but handling them is saner IMO. 
> 
> This is mostly what i do - As the ext2 code loads in the whole file
> as a chunk i am loading it after the booloader - Then copy it to the
> end of the first 8Megs (Which is the minimum memory on a decstation)
> and then copy the chunks marked PROGBITS to their final location.

 That's ugly -- isn't there a possibility to read a file on a
block-by-block basis?

> > But it's not marked as allocatable, so it does not belong to the run-time
> > image.  See also the "System V Application Binary Interface, Edition 4.1",
> > chapter 4 for sections and 5 for segments. 
> 
> ;) I am no elf god by far - I was just in the need of a bootloader so
> i looked in the elf headers and collected the bits i thought were
> usefull.

 Neither am I, but come on -- the ELF format is next to trivial to handle
and the spec is just a few pages -- the relevant part of chapter 5 fits in
three pages. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
