Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DE8Am14650
	for linux-mips-outgoing; Fri, 13 Jul 2001 07:08:10 -0700
Received: from delta.ds2.pg.gda.pl (root@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DE82V14646;
	Fri, 13 Jul 2001 07:08:04 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA08084;
	Fri, 13 Jul 2001 16:01:31 +0200 (MET DST)
Date: Fri, 13 Jul 2001 16:01:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
In-Reply-To: <20010713133517.C1378@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010713151359.3193D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 13 Jul 2001, Ralf Baechle wrote:

> >  Hmm, I would consider that a bug in such an assembler.  The mtc0 and
> > possibly the mfc0 opcode should be treated as reordering barriers as they
> > may involve side effects an assembler might not be aware of. 
> 
> Assembler is the art of using sideeffects so things are fairly explicit.
> Optimizations are controlled using
> 
>   .set noreorder / reorder
>   .set volatile / novolatile
>   .set nomove / nomove
>   .set nobopt / bopt

 Sure, but sometimes ".set reorder" allows you to achieve better
optimization across various ISAs without a need to resort to the
preprocessor.  Consider the following code: 

	lw	$1,($2)
	addu	$3,$1

You need an instruction between the two for a MIPS I CPU but MIPS II+ CPUs
interlock here if no instruction is placed.  Assuming no real instruction
can be reordered here, a nop must be inserted if the code gets compiled
for a MIPS I CPU but no instruction is preferred otherwise.  The assembler
does it automatically if the ".set reorder" directive is active, but you
need to decide yourself if it is not.

 Actually with mfc0 there is no problem -- you need a nop in the case like
the above one as coprocessor transfers never interlock; at least docs
state so.  But who believes docs without a grain of salt, so please
correct me if I am wrong (I don't have appropriate hardware to perform a
test). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
