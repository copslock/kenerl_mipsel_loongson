Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JCs1007158
	for linux-mips-outgoing; Thu, 19 Jul 2001 05:54:01 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JCroV07108;
	Thu, 19 Jul 2001 05:53:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA05400;
	Thu, 19 Jul 2001 14:56:14 +0200 (MET DST)
Date: Thu, 19 Jul 2001 14:56:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
In-Reply-To: <20010719021819.D1888@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010719144215.4857A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 19 Jul 2001, Ralf Baechle wrote:

> This behaviour of objdump sucks rocks anyway.  There are MIPS I CPUs which
> have ll but no branch likely and many other MIPS ISA perversions.  Objdump
> also will only hexdump anything that hasn't been marked as code with
> .type.  Seems objdump's behaviour was choosen to be the most annoying
> possible.

 Well, actually I disagree.  I like this very much, since looking at the
output it's immediately obvious if some code contains opcodes
unrecognizable by a selected CPU (due to a bad compiler option or an
inline asm error).  And you can always select a desired CPU type with the
"-m mips:<model>" option (e.g. "-m mips:3000").  If there are MIPS I CPUs
which have have ll but no branch likely, etc. then their descriptions
should be appropriately set in objdump.  Otherwise, it's a bug in
binutils. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
