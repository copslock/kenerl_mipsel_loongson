Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QE3L016061
	for linux-mips-outgoing; Tue, 26 Feb 2002 06:03:21 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QE1q916029;
	Tue, 26 Feb 2002 06:02:03 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA15051;
	Tue, 26 Feb 2002 13:59:46 +0100 (MET)
Date: Tue, 26 Feb 2002 13:59:46 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Jay Carlson <nop@nop.com>, Ralf Baechle <ralf@oss.sgi.com>,
   mad-dev@lists.mars.org, Carlo Agostini <carlo.agostini@yacme.com>,
   linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
In-Reply-To: <20020226005138.A4594@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020226135810.13814A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 26 Feb 2002, Daniel Jacobowitz wrote:

> > Agreed.  So do we need a special flag/directive for gas to say "I'm 
> > using soft float"?
> 
> And bit in the ELF header.  We can talk about this in a couple weeks
> once binutils 2.12 is out :)

 And a way for an override for ones who know what they are doing. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
