Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARIa6w27330
	for linux-mips-outgoing; Tue, 27 Nov 2001 10:36:06 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARIZwo27326
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 10:35:59 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA11733;
	Tue, 27 Nov 2001 18:35:03 +0100 (MET)
Date: Tue, 27 Nov 2001 18:35:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: FPU interrupt handler 
In-Reply-To: <200111261407.PAA11348@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1011127182519.440L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 26 Nov 2001, Houten K.H.C. van (Karel) wrote:

> >  I may upload binaries of my kernels to my site if they are to be useful
> > -- they are fully monolithic (but with kmod support) due to historical
> > reasons.  Only IPv6 is modular due to its unstability -- it freezes the
> > system immediately on my /240 and splashes a bunch of suspicious messages
> > on my /260 (weird, but no time to debug).  They only support /240 and /260
> > due to CONFIG_CPU_HAS_WB unset.
> 
> Yes please. I hope to get a new disk this week, so I can build a
> stable development server...

 The kernels are now available at
'ftp://ftp.ds2.pg.gda.pl/pub/macro/linux/'. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
