Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A99mj06392
	for linux-mips-outgoing; Fri, 10 Aug 2001 02:09:48 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A99fV06388
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 02:09:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA03906;
	Fri, 10 Aug 2001 11:11:58 +0200 (MET DST)
Date: Fri, 10 Aug 2001 11:11:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Problem with PMAD-AA / DECStation 5000/200
In-Reply-To: <20010809182047.A25724@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1010810110057.2724F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 9 Aug 2001, Jan-Benedict Glaw wrote:

> I volunteer to provide all PROMs I can find @home. However, someone
> has to read them as I don't have an EPROM burner:-(

 I'm not sure how exactly the ROMs are wired (they're usually 8-bit); 
hopefully in a "natural" way.  You can read most of ROMs under Linux via
mmap()ping /dev/mem -- parts of ROMs may not be directly available to the
host CPU if they contain option's CPU firmware.  The MB ROM is remapped
(byte-merged) by the chipset so that it can be read in 32-bit quantities
as parts of it get executed directly (the I/O ASIC permits switching the
byte merging off).  Option ROMs are not remapped as they always get copied
to the system RAM before execution.  Their organization can be read from
their headers as specified by the TURBOchannel firmware specification.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
