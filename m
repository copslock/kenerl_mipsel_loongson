Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7EHfQx15266
	for linux-mips-outgoing; Tue, 14 Aug 2001 10:41:26 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7EHfJj15260;
	Tue, 14 Aug 2001 10:41:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA05695;
	Tue, 14 Aug 2001 19:43:23 +0200 (MET DST)
Date: Tue, 14 Aug 2001 19:43:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Ralf Baechle <ralf@oss.sgi.com>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
In-Reply-To: <3B781BF5.9FF57CF8@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010814193527.5426C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001, Gleb O. Raiko wrote:

> >  Note that for PCI-based systems, there is usually no problem -- PCI IDs
> > can be used instead in most cases.
> 
> How? In fact, I've got two different boards with the same Ethernet chip.
> Moreover, mach type shall be known as early as possible, early than pci
> init for sure. Just imagine, I need a way to identify PCI controller by
> mach type, so I need to scan pci busses for specific ID. Boom. :-) Did I
> miss something in your proposal?

 The PCI ID of a host bridge is usually sufficient to differentiate most
systems for onboard devices that are not reported on PCI.  If it is not
for your one, you just fall outside of the scope of "most cases" and you
need a different way to identify a system.  Note I do not promote
mips_machtype removal.

> BTW, in my Baget case, I just need a number for mach type. I can ask to
> change my prom in worst case.

 How do you set up mips_machtype on your system in the first place?  At
kernel_entry the code does not know what machine it's running on anyway,
so it has to set mips_machtype based on a detection algorithm. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
