Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DDucK00797
	for linux-mips-outgoing; Wed, 13 Jun 2001 06:56:38 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DDjZP32140;
	Wed, 13 Jun 2001 06:51:37 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA21003;
	Wed, 13 Jun 2001 15:44:29 +0200 (MET DST)
Date: Wed, 13 Jun 2001 15:44:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Keith Owens <kaos@melbourne.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   Raoul Borenius <borenius@shuttle.de>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
In-Reply-To: <20010613140550.B31221@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010613153740.9854H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001, Ralf Baechle wrote:

> That can be done automatically.  For 32-bit ELF files mips*-linux binutils
> dump some of the addresses as 32-bit addresses, some as sign-extended (!)
> 64-bit addresses.  So ksymops should just sign extend any 32-bit addresses
> to 64-bit and then work on full lenght addresses.
> 
> Is ksymoops able to handle 64-bit addresses when running on a 32-bit host?
> That is a common case for many people when decoding their MIPS oopses.

 The point is whether addresses should be extended at all if a 32-bit
target is selected.  IMHO -- not, that's a limitation of BFD when
configured for both a 32-bit and a 64-bit target and it should be fixed
sooner or later (at least it's on my to-do list for some time).  BFD is
free to handle addresses as it likes internally, be it 64-bit or 32-bit,
but they should be truncated on final output to a 32-bit target, as they
already are for certain cases. 

 I'm not sure we need to work it around in ksymoops until BFD is fixed --
`cut -c8- < System.map' works as a charm.  It might be worth documenting,
though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
