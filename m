Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5C1KoC16871
	for linux-mips-outgoing; Mon, 11 Jun 2001 18:20:50 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5C1KlV16865
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 18:20:48 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id DAA19671;
	Tue, 12 Jun 2001 03:22:15 +0200 (MET DST)
Date: Tue, 12 Jun 2001 03:22:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: Florian Lohoff <flo@rfc822.org>, Keith Owens <kaos@ocs.com.au>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
In-Reply-To: <20010611180109.B6610@foobazco.org>
Message-ID: <Pine.GSO.3.96.1010612031334.18298B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Jun 2001, Keith M Wesolowski wrote:

> Actually, it would probably be preferable to try first arch-os-objdump
> and maybe one or two other similar variants and then search the path.

 Sure, if you know how to guess the names (I don't).  The PATH approach
should work well if you choose one cross environment at a time.

> Supposing I have multiple cross environments on my machine...

 Does anyone have only a single one? ;-)  (Having a complete mipsel-linux,
a basic alpha-linux and a few obscure partial environments...) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
